import 'dart:convert';
import 'package:http/http.dart' as http;
import 'kuran_verileri.dart';

String _base = 'https://api.alquran.cloud/v1';
String _audioCdn = 'https://cdn.islamic.network/quran/audio';

class SureBilgisi {
  final int numara;
  final String arapcaAdi;
  final String turkceAdi;
  final String anlami;
  final int ayetSayisi;
  final String inisYeri; // Mekkî / Medenî
  final String ozet;

  SureBilgisi({
    required this.numara,
    required this.arapcaAdi,
    required this.turkceAdi,
    required this.anlami,
    required this.ayetSayisi,
    required this.inisYeri,
    required this.ozet,
  });
}

class AyetMetni {
  final int sureNo;
  final int ayetNo; // sure içindeki numara
  final int globalNo;
  final String arapca;
  final String meal;
  final String okunus;
  final int cuz;
  final int sayfa;
  final bool secdeAyeti;

  AyetMetni({
    required this.sureNo,
    required this.ayetNo,
    required this.globalNo,
    required this.arapca,
    required this.meal,
    required this.okunus,
    required this.cuz,
    required this.sayfa,
    required this.secdeAyeti,
  });
}

class KuranApi {
  static final KuranApi instance = KuranApi._();
  KuranApi._();

  final http.Client _client = http.Client();

  // ---------- SURE LİSTESİ ----------
  Future<List<SureBilgisi>> sureleriGetir() async {
    final uri = Uri.parse('$_base/surah');
    final res = await _client.get(uri).timeout(Duration(seconds: 20));
    if (res.statusCode != 200) {
      throw Exception('Sure listesi alınamadı (${res.statusCode})');
    }
    final json = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;

    return data.map((e) {
      final m = e as Map<String, dynamic>;
      final numara = m['number'] as int;
      return SureBilgisi(
        numara: numara,
        arapcaAdi: (m['name'] as String?) ?? '',
        turkceAdi: sureAdiTurkce(numara),
        anlami: sureAnlami(numara),
        ayetSayisi: (m['numberOfAyahs'] as int?) ?? 0,
        inisYeri: m['revelationType'] == 'Meccan' ? 'Mekkî' : 'Medenî',
        ozet: sureOzetiMetni(numara),
      );
    }).toList();
  }

  // ---------- SURE / CÜZ AYETLERİ (Arapça + meâl + okunuş) ----------
  Future<List<AyetMetni>> ayetleriGetir({int? sureNo, int? cuzNo}) async {
    if (sureNo != null) {
      return _sureAyetleriGetir(sureNo);
    }
    if (cuzNo != null) {
      return _cuzAyetleriGetir(cuzNo);
    }
    throw ArgumentError('sureNo veya cuzNo verilmelidir');
  }

  Future<List<AyetMetni>> _sureAyetleriGetir(int sureNo) async {
    final editions = [
      'quran-uthmani',
      ...mealler.map((m) => m.id),
      'tr.transliteration',
    ].join(',');
    final uri = Uri.parse('$_base/surah/$sureNo/editions/$editions');
    final res = await _client.get(uri).timeout(Duration(seconds: 30));
    if (res.statusCode != 200) {
      throw Exception('Ayetler alınamadı (${res.statusCode})');
    }
    final json = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;

    // [0] = uthmani, [1..n] = meâller, [son] = transliterasyon
    final arapcaList =
        (data[0] as Map<String, dynamic>)['ayahs'] as List<dynamic>;
    final mealListesi = <List<dynamic>>[];
    for (var i = 1; i < data.length - 1; i++) {
      mealListesi.add(
        (data[i] as Map<String, dynamic>)['ayahs'] as List<dynamic>,
      );
    }
    final okunusList =
        (data[data.length - 1] as Map<String, dynamic>)['ayahs']
            as List<dynamic>;

    return List.generate(arapcaList.length, (i) {
      final a = arapcaList[i] as Map<String, dynamic>;
      final ayetNo = a['numberInSurah'] as int;
      final globalNo = a['number'] as int;
      // Meâl seçimi (varsayılan Diyanet = index 0)
      final mealMap = mealListesi[0][i] as Map<String, dynamic>;
      final okunusMap = okunusList[i] as Map<String, dynamic>;

      return AyetMetni(
        sureNo: sureNo,
        ayetNo: ayetNo,
        globalNo: globalNo,
        arapca: (a['text'] as String?) ?? '',
        meal: (mealMap['text'] as String?) ?? '',
        okunus: (okunusMap['text'] as String?) ?? '',
        cuz: (a['juz'] as int?) ?? 0,
        sayfa: (a['page'] as int?) ?? 0,
        secdeAyeti: (a['sajda'] as bool?) ?? false,
      );
    });
  }

  Future<List<AyetMetni>> _cuzAyetleriGetir(int cuzNo) async {
    // Cüz endpoint'i tekil edisyon yolunu destekler:
    // /juz/{n}/{edition} şeklinde 3 ayrı istek yapıp global numaraya göre birleştir.
    final editions = ['quran-uthmani', 'tr.diyanet', 'tr.transliteration'];
    final sonuclar = <int, Map<String, dynamic>>{};

    for (final ed in editions) {
      final uri = Uri.parse('$_base/juz/$cuzNo/$ed');
      final res = await _client.get(uri).timeout(Duration(seconds: 30));
      if (res.statusCode != 200) {
        throw Exception('Cüz ayetleri alınamadı (${res.statusCode})');
      }
      final json =
          jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
      final data = json['data'] as Map<String, dynamic>;
      final ayahs = data['ayahs'] as List<dynamic>;
      for (final a in ayahs) {
        final m = a as Map<String, dynamic>;
        final globalNo = m['number'] as int;
        final kayit = sonuclar.putIfAbsent(globalNo, () => {});
        kayit[ed] = m;
      }
    }

    final numaralar = sonuclar.keys.toList()..sort();
    return numaralar.map((globalNo) {
      final a = sonuclar[globalNo]!['quran-uthmani']! as Map<String, dynamic>;
      final mealMap =
          sonuclar[globalNo]!['tr.diyanet']! as Map<String, dynamic>;
      final okunusMap =
          sonuclar[globalNo]!['tr.transliteration']! as Map<String, dynamic>;
      return AyetMetni(
        sureNo: (a['surah']['number'] as int?) ?? 0,
        ayetNo: (a['numberInSurah'] as int?) ?? 0,
        globalNo: globalNo,
        arapca: (a['text'] as String?) ?? '',
        meal: (mealMap['text'] as String?) ?? '',
        okunus: (okunusMap['text'] as String?) ?? '',
        cuz: (a['juz'] as int?) ?? cuzNo,
        sayfa: (a['page'] as int?) ?? 0,
        secdeAyeti: a['sajda'] is bool ? (a['sajda'] as bool) : false,
      );
    }).toList();
  }

  // ---------- TEK AYET (meâl değiştirilebilir) ----------
  Future<List<AyetMetni>> tekAyetGetir(int sureNo, int ayetNo) {
    return _ayetlerByNumara([
      {'sure': sureNo, 'ayet': ayetNo},
    ]);
  }

  Future<List<AyetMetni>> _ayetlerByNumara(
    List<Map<String, int>> numaralar,
  ) async {
    final editions = [
      'quran-uthmani',
      'tr.diyanet',
      'tr.transliteration',
    ].join(',');
    final ref = numaralar.map((n) => '${n['sure']}:${n['ayet']}').join(',');
    final uri = Uri.parse('$_base/ayah/$ref/editions/$editions');
    final res = await _client.get(uri).timeout(Duration(seconds: 30));
    if (res.statusCode != 200) {
      throw Exception('Ayet alınamadı (${res.statusCode})');
    }
    final json = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    final data = json['data'] as List<dynamic>;

    // Tek ayet ref'inde data, her edisyon için tek bir ayet nesnesi içerir:
    // [0] = uthmani (arapça), [1] = tr.diyanet (meâl), [2] = tr.transliteration (okunuş)
    final a = data[0] as Map<String, dynamic>;
    final mealMap = data[1] as Map<String, dynamic>;
    final okunusMap = data[2] as Map<String, dynamic>;
    return [
      AyetMetni(
        sureNo: (a['surah']['number'] as int?) ?? 0,
        ayetNo: (a['numberInSurah'] as int?) ?? 0,
        globalNo: (a['number'] as int?) ?? 0,
        arapca: (a['text'] as String?) ?? '',
        meal: (mealMap['text'] as String?) ?? '',
        okunus: (okunusMap['text'] as String?) ?? '',
        cuz: (a['juz'] as int?) ?? 0,
        sayfa: (a['page'] as int?) ?? 0,
        secdeAyeti: a['sajda'] is bool ? (a['sajda'] as bool) : false,
      ),
    ];
  }

  // ---------- AYET ARAMA (Türkçe kelime) ----------
  Future<List<Map<String, Object>>> ayetAra(String kelime) async {
    final uri = Uri.parse(
      '$_base/search/${Uri.encodeComponent(kelime)}/all/tr.diyanet',
    );
    final res = await _client.get(uri).timeout(Duration(seconds: 30));
    if (res.statusCode != 200) {
      throw Exception('Arama yapılamadı (${res.statusCode})');
    }
    final json = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final matches = (data['matches'] as List<dynamic>?) ?? [];

    return matches.take(30).map((e) {
      final m = e as Map<String, dynamic>;
      final sure = m['surah'] as Map<String, dynamic>;
      return {
        'text': (m['text'] as String?) ?? '',
        'sureNo': (sure['number'] as int?) ?? 0,
        'sureAdi': (sure['name'] as String?) ?? '',
        'ayetNo': (m['numberInSurah'] as int?) ?? 0,
      };
    }).toList();
  }

  // ---------- SES ----------
  // CDN'deki bazı kârî kayıtları yalnızca 192 kbps sürümünde bulunur.
  // Tek bir sabit kalite kullanmak bu kârîlerde 403 hatasına ve oynatmanın
  // hiç başlamamasına neden olur.
  static const Map<String, int> _kariSesKalitesi = {
    'ar.abdurrahmaansudais': 192,
    'ar.abdulbasitmurattal': 192,
  };

  static int _sesKalitesi(String kariId) => _kariSesKalitesi[kariId] ?? 128;

  static String sureSesUrl(String kariId, int sureNo) {
    return '$_audioCdn-surah/${_sesKalitesi(kariId)}/$kariId/$sureNo.mp3';
  }

  static String ayetSesUrl(String kariId, int globalAyetNo) {
    return '$_audioCdn/${_sesKalitesi(kariId)}/$kariId/$globalAyetNo.mp3';
  }

  void dispose() {
    _client.close();
  }
}
