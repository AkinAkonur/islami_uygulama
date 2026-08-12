// ===========================================================================
// HADİS KÜTÜPHANESİ SERVİSİ
// Kaynak: compressed_hadith_sqlite (https://github.com/IsmailHosenIsmailJames/
// compressed_hadith_sqlite) - MIT lisanslı, çevrimdışı çalışmaya hazır
// sıkıştırılmış SQLite hadis veritabanları (FTS5 tam metin arama destekli).
//
// - Kitap listesi, kullanıcının uygulamada seçtiği dile göre {lang}/info.json
//   dosyasından çekilir (9 dil: ara, ben, eng, fra, ind, rus, tam, tur, urd).
// - Kitaplar ilk açılışta indirilir, zip'ten çıkarılır ve cihazda saklanır.
//   İndirme iki farklı sunucudan (GitHub raw + jsDelivr CDN) denenir.
// - Sonraki açılışlarda tamamen çevrimdışı çalışır.
// ===========================================================================

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class HadisKitabi {
  final String kod; // örn: tur-bukhari
  final String ad; // Sahih al Bukhari
  final String adYerli; // Sahih-i Buhari (dildeki ad)
  final int hadisSayisi;
  final int bolumSayisi;
  final int zipBoyut; // byte
  final String zipYolu; // tur/tur-bukhari.sqlite.zip

  const HadisKitabi({
    required this.kod,
    required this.ad,
    required this.adYerli,
    required this.hadisSayisi,
    required this.bolumSayisi,
    required this.zipBoyut,
    required this.zipYolu,
  });

  String get boyutMetni {
    final mb = zipBoyut / (1024 * 1024);
    return mb >= 1
        ? '${mb.toStringAsFixed(1)} MB'
        : '${(zipBoyut / 1024).round()} KB';
  }

  Map<String, Object> toJson() => {
        'kod': kod,
        'ad': ad,
        'adYerli': adYerli,
        'hadisSayisi': hadisSayisi,
        'bolumSayisi': bolumSayisi,
        'zipBoyut': zipBoyut,
        'zipYolu': zipYolu,
      };

  factory HadisKitabi.fromJson(Map<String, dynamic> j) => HadisKitabi(
        kod: j['kod'] as String,
        ad: (j['ad'] as String?) ?? '',
        adYerli: (j['adYerli'] as String?) ?? '',
        hadisSayisi: (j['hadisSayisi'] as int?) ?? 0,
        bolumSayisi: (j['bolumSayisi'] as int?) ?? 0,
        zipBoyut: (j['zipBoyut'] as int?) ?? 0,
        zipYolu: (j['zipYolu'] as String?) ?? '',
      );
}

class HadisBolumu {
  final int id;
  final String ad;
  final String adYerli;
  final int baslangic;
  final int bitis;
  final int hadisSayisi;

  const HadisBolumu({
    required this.id,
    required this.ad,
    required this.adYerli,
    required this.baslangic,
    required this.bitis,
    required this.hadisSayisi,
  });
}

class HadisKaydi {
  final int hadisNo;
  final String metin;
  final String bolum;
  final String? alim;
  final String? derece;

  const HadisKaydi({
    required this.hadisNo,
    required this.metin,
    required this.bolum,
    this.alim,
    this.derece,
  });
}

class HadisKutuphanesiService {
  HadisKutuphanesiService._();

  static final HadisKutuphanesiService instance =
      HadisKutuphanesiService._();

  static const _sahip = 'IsmailHosenIsmailJames';
  static const _depo = 'compressed_hadith_sqlite';
  static const _dal = 'master';

  // İndirme sırası: GitHub raw + jsDelivr CDN (yük yedekliliği için).
  static const _sunucular = [
    'https://raw.githubusercontent.com/$_sahip/$_depo/$_dal',
    'https://cdn.jsdelivr.net/gh/$_sahip/$_depo@$_dal',
  ];

  /// Uygulama dili kodu -> veritabanı dil kodu.
  static const Map<String, String> _dilEslestirme = {
    'tr': 'tur',
    'en': 'eng',
    'ar': 'ara',
    'id': 'ind',
    'ms': 'ind',
    'ur': 'urd',
    'bn': 'ben',
    'fr': 'fra',
    'ru': 'rus',
    'ta': 'tam',
  };

  static String depoDilKodu(String uygulamaDili) =>
      _dilEslestirme[uygulamaDili.toLowerCase()] ?? 'eng';

  /// Ağ yoksa kullanılacak çevrimdışı yedek liste (Türkçe).
  static const List<HadisKitabi> _turYedek = [
    HadisKitabi(
      kod: 'tur-bukhari',
      ad: 'Sahih al Bukhari',
      adYerli: 'Sahih-i Buhari',
      hadisSayisi: 7278,
      bolumSayisi: 97,
      zipBoyut: 6495115,
      zipYolu: 'tur/tur-bukhari.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'tur-muslim',
      ad: 'Sahih Muslim',
      adYerli: 'Sahih-i Müslim',
      hadisSayisi: 7219,
      bolumSayisi: 56,
      zipBoyut: 3941024,
      zipYolu: 'tur/tur-muslim.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'tur-abudawud',
      ad: 'Sunan Abu Dawud',
      adYerli: 'Sünen-i Ebu Davud',
      hadisSayisi: 5274,
      bolumSayisi: 43,
      zipBoyut: 2394670,
      zipYolu: 'tur/tur-abudawud.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'tur-nasai',
      ad: 'Sunan an Nasai',
      adYerli: 'Sünen-i Nesai',
      hadisSayisi: 5683,
      bolumSayisi: 51,
      zipBoyut: 431115,
      zipYolu: 'tur/tur-nasai.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'tur-tirmidhi',
      ad: 'Jami At Tirmidhi',
      adYerli: 'Sünen-i Tirmizi',
      hadisSayisi: 3998,
      bolumSayisi: 49,
      zipBoyut: 1978321,
      zipYolu: 'tur/tur-tirmidhi.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'tur-ibnmajah',
      ad: 'Sunan Ibn Majah',
      adYerli: 'Sünen-i İbn Mace',
      hadisSayisi: 4077,
      bolumSayisi: 37,
      zipBoyut: 2528493,
      zipYolu: 'tur/tur-ibnmajah.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'tur-malik',
      ad: 'Muwatta Malik',
      adYerli: 'Muvatta Malik',
      hadisSayisi: 1840,
      bolumSayisi: 61,
      zipBoyut: 556677,
      zipYolu: 'tur/tur-malik.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'tur-nawawi',
      ad: 'Forty Hadith of an-Nawawi',
      adYerli: 'İmam Nevevi\'nin Kırk Hadisi',
      hadisSayisi: 42,
      bolumSayisi: 1,
      zipBoyut: 22769,
      zipYolu: 'tur/tur-nawawi.sqlite.zip',
    ),
  ];

  static const List<HadisKitabi> _engYedek = [
    HadisKitabi(
      kod: 'eng-bukhari',
      ad: 'Sahih al Bukhari',
      adYerli: 'Sahih al-Bukhari',
      hadisSayisi: 7278,
      bolumSayisi: 97,
      zipBoyut: 3489629,
      zipYolu: 'eng/eng-bukhari.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'eng-muslim',
      ad: 'Sahih Muslim',
      adYerli: 'Sahih Muslim',
      hadisSayisi: 7219,
      bolumSayisi: 56,
      zipBoyut: 2388600,
      zipYolu: 'eng/eng-muslim.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'eng-abudawud',
      ad: 'Sunan Abu Dawud',
      adYerli: 'Sunan Abu Dawud',
      hadisSayisi: 5274,
      bolumSayisi: 43,
      zipBoyut: 1886151,
      zipYolu: 'eng/eng-abudawud.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'eng-nasai',
      ad: 'Sunan an Nasai',
      adYerli: 'Sunan an-Nasai',
      hadisSayisi: 5683,
      bolumSayisi: 51,
      zipBoyut: 1606373,
      zipYolu: 'eng/eng-nasai.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'eng-tirmidhi',
      ad: 'Jami At Tirmidhi',
      adYerli: 'Jami at-Tirmidhi',
      hadisSayisi: 3998,
      bolumSayisi: 49,
      zipBoyut: 1341091,
      zipYolu: 'eng/eng-tirmidhi.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'eng-ibnmajah',
      ad: 'Sunan Ibn Majah',
      adYerli: 'Sunan Ibn Majah',
      hadisSayisi: 4077,
      bolumSayisi: 37,
      zipBoyut: 1603637,
      zipYolu: 'eng/eng-ibnmajah.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'eng-malik',
      ad: 'Muwatta Malik',
      adYerli: 'Muwatta Malik',
      hadisSayisi: 1840,
      bolumSayisi: 61,
      zipBoyut: 370262,
      zipYolu: 'eng/eng-malik.sqlite.zip',
    ),
    HadisKitabi(
      kod: 'eng-nawawi',
      ad: 'Forty Hadith of an-Nawawi',
      adYerli: 'Forty Hadith of an-Nawawi',
      hadisSayisi: 42,
      bolumSayisi: 1,
      zipBoyut: 15536,
      zipYolu: 'eng/eng-nawawi.sqlite.zip',
    ),
  ];

  final http.Client _client = http.Client();
  final Map<String, Database> _dbler = {};
  final Map<String, List<HadisKitabi>> _kitapOnbellek = {};
  bool _ffiHazir = false;
  bool _yerlesikKuruldu = false;

  // ---------------- KİTAP LİSTESİ (dil destekli) ----------------

  /// Kullanıcının seçtiği uygulama dili için kitap listesini döner.
  /// Önce ağdan {dil}/info.json çekilir (bellek + kalıcı önbellek), ağ
  /// yoksa cihazdaki önbellek, o da yoksa dilin yedek listesi kullanılır.
  Future<List<HadisKitabi>> kitaplariGetir(
    String uygulamaDili, {
    void Function()? agYok,
  }) async {
    final dil = depoDilKodu(uygulamaDili);
    final bellek = _kitapOnbellek[dil];
    if (bellek != null) return bellek;

    final prefs = await SharedPreferences.getInstance();
    final onbellekAnahtar = 'hadis_kitaplar_$dil';

    try {
      final kitaplar = await _infoJsonCek(dil);
      _kitapOnbellek[dil] = kitaplar;
      await prefs.setString(
        onbellekAnahtar,
        jsonEncode(kitaplar.map((k) => k.toJson()).toList()),
      );
      return kitaplar;
    } catch (_) {
      agYok?.call();
    }

    final kayitli = prefs.getString(onbellekAnahtar);
    if (kayitli != null && kayitli.isNotEmpty) {
      try {
        final kitaplar = (jsonDecode(kayitli) as List<dynamic>)
            .map((e) => HadisKitabi.fromJson(e as Map<String, dynamic>))
            .toList();
        _kitapOnbellek[dil] = kitaplar;
        return kitaplar;
      } catch (_) {
        // bozuk önbellek
      }
    }
    return switch (dil) {
      'tur' => _turYedek,
      'eng' => _engYedek,
      _ => const [],
    };
  }

  /// {dil}/info.json dosyasını birden çok sunucudan dener.
  Future<List<HadisKitabi>> _infoJsonCek(String dil) async {
    Object? sonHata;
    for (final sunucu in _sunucular) {
      try {
        final res = await _client
            .get(Uri.parse('$sunucu/$dil/info.json'))
            .timeout(const Duration(seconds: 30));
        if (res.statusCode != 200) {
          throw Exception('HTTP ${res.statusCode}');
        }
        final json =
            jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
        final kitaplar = (json['books'] as List<dynamic>).map((e) {
          final m = e as Map<String, dynamic>;
          final kod = m['book'] as String;
          return HadisKitabi(
            kod: kod,
            ad: (m['name'] as String?) ?? kod,
            adYerli: (m['name_native'] as String?) ?? (m['name'] as String?) ?? kod,
            hadisSayisi: (m['hadith_count'] as int?) ?? 0,
            bolumSayisi: (m['section_count'] as int?) ?? 0,
            zipBoyut: (m['zip_size'] as int?) ?? 0,
            zipYolu: (m['zip_path'] as String?) ?? '$dil/$kod.sqlite.zip',
          );
        }).toList();
        if (kitaplar.isEmpty) throw Exception('Boş kitap listesi');
        return kitaplar;
      } catch (e) {
        sonHata = e;
      }
    }
    throw Exception('Kitap listesi alınamadı: $sonHata');
  }

  // ---------------- VERİTABANI YÖNETİMİ ----------------

  Future<String> _dizin() async {
    final destek = await getApplicationSupportDirectory();
    final hadis = Directory(p.join(destek.path, 'hadis'));
    await hadis.create(recursive: true);
    await _yerlesikKitaplariKur(hadis.path);
    return hadis.path;
  }

  /// Uygulamayla birlikte gelen küçük kitabı (İmam Nevevi'nin Kırk Hadisi)
  /// ilk açılışta cihaz dizinine kopyalar. Böylece internet olmasa bile
  /// kütüphane çalışır durumda başlar.
  Future<void> _yerlesikKitaplariKur(String dizin) async {
    if (_yerlesikKuruldu) return;
    _yerlesikKuruldu = true;
    const zipKaynak = 'assets/hadis/tur-nawawi.sqlite.zip';
    const hedefSqlite = 'tur-nawawi.sqlite';
    if (File(p.join(dizin, hedefSqlite)).existsSync()) return;
    try {
      final veri = await rootBundle.load(zipKaynak);
      final arsiv = ZipDecoder().decodeBytes(veri.buffer.asUint8List());
      for (final uye in arsiv.files) {
        if (!uye.isFile) continue;
        final hedef = p.join(dizin, p.basename(uye.name));
        await File(hedef).writeAsBytes(uye.content!, flush: true);
      }
    } catch (_) {
      // Varlık bulunamazsa sessizce geç; kitaplar istenince indirilir.
    }
  }

  void _ffiBaslat() {
    if (_ffiHazir) return;
    if (kIsWeb) return;
    if (!(Platform.isWindows || Platform.isLinux || Platform.isMacOS)) return;
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    _ffiHazir = true;
  }

  /// Kitap veritabanı cihazda hazır mı?
  Future<bool> kitapHazir(String kod) async {
    final dizin = await _dizin();
    return File(p.join(dizin, '$kod.sqlite')).existsSync();
  }

  Future<Uint8List> _indir(
    String url, {
    void Function(int indirilen, int toplam)? ilerleme,
  }) async {
    final istek = http.Request('GET', Uri.parse(url));
    final yanit = await _client.send(istek).timeout(const Duration(seconds: 20));
    if (yanit.statusCode != 200) {
      throw Exception('HTTP ${yanit.statusCode}');
    }
    final toplam = yanit.contentLength ?? 0;
    final koms = BytesBuilder(copy: false);
    var alinan = 0;
    // 30 saniye boyunca hiç veri gelmezse bağlantıyı iptal et.
    await for (final parca
        in yanit.stream.timeout(const Duration(seconds: 30))) {
      koms.add(parca);
      alinan += parca.length;
      if (toplam > 0) ilerleme?.call(alinan, toplam);
    }
    return koms.takeBytes();
  }

  /// Zip'i indirir (birden çok sunucu dener), açar, .sqlite dosyasını
  /// dizine çıkarır ve yolunu döner. [ilerleme] byte cinsinden çağrılır.
  Future<String> _indirVeAc(
    HadisKitabi kitap, {
    void Function(int indirilen, int toplam)? ilerleme,
  }) async {
    final dizin = await _dizin();
    final sqliteYolu = p.join(dizin, '${kitap.kod}.sqlite');
    if (File(sqliteYolu).existsSync()) return sqliteYolu;

    Uint8List? veri;
    final hatalar = <String>[];
    for (final sunucu in _sunucular) {
      try {
        veri = await _indir('$sunucu/${kitap.zipYolu}', ilerleme: ilerleme);
        break;
      } catch (e) {
        hatalar.add('$sunucu => $e');
      }
    }
    if (veri == null) {
      throw Exception('İndirme başarısız oldu: ${hatalar.join(' | ')}');
    }

    final zipYolu = p.join(dizin, '${kitap.kod}.sqlite.zip');
    final zip = File(zipYolu);
    await zip.writeAsBytes(veri, flush: true);
    try {
      final arsiv = ZipDecoder().decodeBytes(await zip.readAsBytes());
      String? cikanSqlite;
      for (final uye in arsiv.files) {
        if (!uye.isFile) continue;
        final hedef = p.join(dizin, p.basename(uye.name));
        await File(hedef).writeAsBytes(uye.content!, flush: true);
        if (p.extension(uye.name).toLowerCase() == '.sqlite') {
          cikanSqlite = hedef;
        }
      }
      if (cikanSqlite == null) {
        throw Exception('Zip içinde veritabanı bulunamadı.');
      }
      return cikanSqlite;
    } finally {
      if (File(zipYolu).existsSync()) await File(zipYolu).delete();
    }
  }

  Future<Database> _veritabani(
    String kod, {
    void Function(int indirilen, int toplam)? ilerleme,
  }) async {
    _ffiBaslat();
    final mevcut = _dbler[kod];
    if (mevcut != null && mevcut.isOpen) return mevcut;

    // Önce dile göre kitap listesinden kitabı bul (kod + zipYolu için).
    var kitap = _kitapBulCached(kod);
    if (kitap == null) {
      throw Exception('"$kod" bulunamadı. Kitap listesi yüklenemedi.');
    }
    final yol = await _indirVeAc(kitap, ilerleme: ilerleme);
    final db = await openDatabase(yol, readOnly: true);
    _dbler[kod] = db;
    return db;
  }

  HadisKitabi? _kitapBulCached(String kod) {
    for (final liste in _kitapOnbellek.values) {
      for (final k in liste) {
        if (k.kod == kod) return k;
      }
    }
    for (final k in [..._turYedek, ..._engYedek]) {
      if (k.kod == kod) return k;
    }
    return null;
  }

  // ---------------- SORGULAR ----------------

  Future<List<HadisBolumu>> bolumler(
    String kod, {
    void Function(int indirilen, int toplam)? ilerleme,
  }) async {
    final db = await _veritabani(kod, ilerleme: ilerleme);
    final satirlar = await db.query(
      'sections',
      orderBy: 'id',
      columns: [
        'id',
        'section_name',
        'section_name_native',
        'start_hadith_number',
        'end_hadith_number',
        'hadith_count',
      ],
    );
    return satirlar.map(_bolumCevir).toList();
  }

  HadisBolumu _bolumCevir(Map<String, Object?> s) => HadisBolumu(
        id: s['id'] as int,
        ad: (s['section_name'] as String?) ?? '',
        adYerli: (s['section_name_native'] as String?) ?? '',
        baslangic: (s['start_hadith_number'] as int?) ?? 0,
        bitis: (s['end_hadith_number'] as int?) ?? 0,
        hadisSayisi: (s['hadith_count'] as int?) ?? 0,
      );

  Future<List<HadisKaydi>> bolumHadisleri(
    String kod,
    int bolumId, {
    int limit = 40,
    int offset = 0,
  }) async {
    final db = await _veritabani(kod);
    final satirlar = await db.rawQuery(
      '''
      SELECT h.hadith_number, h.text, s.section_name AS bolum,
        (SELECT g.scholar_name FROM grades g WHERE g.hadith_id = h.id LIMIT 1) AS alim,
        (SELECT g.grade FROM grades g WHERE g.hadith_id = h.id LIMIT 1) AS derece
      FROM hadiths h
      LEFT JOIN sections s ON h.section_id = s.id
      WHERE h.section_id = ?
      ORDER BY h.hadith_number
      LIMIT ? OFFSET ?
      ''',
      [bolumId, limit, offset],
    );
    return satirlar.map(_hadisCevir).toList();
  }

  Future<int> bolumHadisSayisi(String kod, int bolumId) async {
    final db = await _veritabani(kod);
    final sonuc = await db.rawQuery(
      'SELECT COUNT(*) AS n FROM hadiths WHERE section_id = ?',
      [bolumId],
    );
    return Sqflite.firstIntValue(sonuc) ?? 0;
  }

  /// FTS5 tam metin arama. Birden fazla kelime AND olarak aranır.
  Future<List<HadisKaydi>> ara(
    String kod,
    String sorgu, {
    int limit = 50,
  }) async {
    final temiz = _ftsSorgusu(sorgu);
    if (temiz.isEmpty) return const [];
    final db = await _veritabani(kod);
    final satirlar = await db.rawQuery(
      '''
      SELECT h.hadith_number, h.text, s.section_name AS bolum,
        (SELECT g.scholar_name FROM grades g WHERE g.hadith_id = h.id LIMIT 1) AS alim,
        (SELECT g.grade FROM grades g WHERE g.hadith_id = h.id LIMIT 1) AS derece
      FROM hadiths_fts f
      JOIN hadiths h ON f.rowid = h.id
      LEFT JOIN sections s ON h.section_id = s.id
      WHERE hadiths_fts MATCH ?
      ORDER BY rank
      LIMIT ?
      ''',
      [temiz, limit],
    );
    return satirlar.map(_hadisCevir).toList();
  }

  String _ftsSorgusu(String sorgu) {
    final kelimeler = sorgu
        .trim()
        .replaceAll('"', ' ')
        .split(RegExp(r'\s+'))
        .where((k) => k.isNotEmpty)
        .map((k) => '$k*')
        .toList();
    return kelimeler.join(' ');
  }

  HadisKaydi _hadisCevir(Map<String, Object?> s) => HadisKaydi(
        hadisNo: (s['hadith_number'] as int?) ?? 0,
        metin: (s['text'] as String?) ?? '',
        bolum: (s['bolum'] as String?) ?? '',
        alim: (s['alim'] as String?)?.isNotEmpty == true
            ? s['alim'] as String
            : null,
        derece: (s['derece'] as String?)?.isNotEmpty == true
            ? s['derece'] as String
            : null,
      );

  /// Kitabı cihazdan tamamen kaldırır (daha sonra yeniden indirilebilir).
  Future<void> sil(String kod) async {
    final acik = _dbler.remove(kod);
    if (acik != null && acik.isOpen) await acik.close();
    final dizin = await _dizin();
    for (final uzanti in ['.sqlite', '.sqlite.zip']) {
      final dosya = File(p.join(dizin, '$kod$uzanti'));
      if (dosya.existsSync()) await dosya.delete();
    }
  }

  void dispose() {
    _client.close();
    for (final db in _dbler.values) {
      if (db.isOpen) db.close();
    }
    _dbler.clear();
  }
}
