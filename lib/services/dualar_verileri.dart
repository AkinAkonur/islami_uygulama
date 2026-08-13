import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'cuz_verileri.dart';

// ===========================================================================
// DUALAR VERİ SERVİSİ (bulut tabanlı + çevrimdışı)
// ---------------------------------------------------------------------------
// 1) TEMEL: Uygulamayla birlikte gelen assets/dualar.json (çevrimdışı, anlık).
// 2) BULUT (lazy-load): Uzak JSON adresinden (dualar_url) yeni dualar/fazilet/
//    çok dilli mealler çekilir, cihazda önbelleğe alınır. Uygulama güncellemesi
//    olmadan içerik genişletilebilir; sunucu erişilemezse gömülü yedek kullanılır.
// 3) Her duada: Arapça (harekeli), okunuş (transliterasyon), çok dilli meal,
//    kaynak (sure/hadis), fazilet (hikmet-önem), etiketler, tekrar adedi,
//    isteğe bağlı ses_url ve ayet tabanlı otomatik ses bağlantısı.
// ===========================================================================

class DuaKaydi {
  final String id;
  final String baslik;
  final String arapca;
  final String okunus;
  final String meal; // varsayılan (Türkçe) meal
  final String kaynak; // sure/hadis kaynağı (Buhari, Müslim, Tirmizi...)
  final String fazilet; // okumanın manevi önemi / sünnet olduğu zaman (1-2 cümle)
  final Map<String, String> mealler; // dil kodu -> meal (çok dilli içerik)
  final String? ayet; // "2:201" gibi Kur'an referansı -> otomatik ses
  final String? sesKaynak; // isteğe bağlı doğrudan ses URL'si (ses_url)
  final int? tekrar; // tavsiye edilen tekrar adedi (zikirmatik hedefi)
  final List<String> etiketler;

  const DuaKaydi({
    required this.id,
    required this.baslik,
    required this.arapca,
    required this.okunus,
    required this.meal,
    required this.kaynak,
    this.fazilet = '',
    this.mealler = const {},
    this.ayet,
    this.sesKaynak,
    this.tekrar,
    this.etiketler = const [],
  });

  factory DuaKaydi.fromJson(Map<String, dynamic> j) => DuaKaydi(
        id: j['id'] as String,
        baslik: (j['baslik'] as String?) ?? '',
        arapca: (j['arapca'] as String?) ?? '',
        okunus: (j['okunus'] as String?) ?? '',
        meal: (j['meal'] as String?) ?? '',
        kaynak: (j['kaynak'] as String?) ?? '',
        fazilet: (j['fazilet'] as String?) ?? '',
        mealler: _mealleriCoz(j['mealler']),
        ayet: j['ayet'] as String?,
        sesKaynak: j['ses_url'] as String?,
        tekrar: (j['tekrar'] as int?) ?? 0,
        etiketler: ((j['etiketler'] as List<dynamic>?) ?? const [])
            .map((e) => e.toString().toLowerCase())
            .toList(),
      );

  static Map<String, String> _mealleriCoz(Object? ham) {
    if (ham is! Map) return const {};
    return ham.map(
      (k, v) => MapEntry(k.toString().toLowerCase(), v.toString()),
    );
  }

  /// Mevcut dil kodu için meal; dil çevirisi yoksa varsayılan (Türkçe) meal.
  String mealDil(String dilKodu) {
    if (dilKodu.isEmpty) return meal;
    return mealler[dilKodu.toLowerCase()] ?? meal;
  }

  /// Sesli dinleme URL'si: önce [sesKaynak] (açıkça verilmiş ses_url),
  /// yoksa Kur'an âyetine dayanan dualar için otomatik üretilen adres.
  String? get sesUrl {
    final acik = sesKaynak;
    if (acik != null && acik.isNotEmpty) return acik;
    final a = ayet;
    if (a == null || !a.contains(':')) return null;
    final parcalar = a.split(':');
    final sure = int.tryParse(parcalar[0]);
    final ayetNo = int.tryParse(parcalar[1]);
    if (sure == null || ayetNo == null) return null;
    return CuzVerileri.ayetSesUrl(sure, ayetNo);
  }

  bool esles(String sorgu) {
    final s = sorgu.toLowerCase();
    if (baslik.toLowerCase().contains(s)) return true;
    if (meal.toLowerCase().contains(s)) return true;
    if (kaynak.toLowerCase().contains(s)) return true;
    if (fazilet.toLowerCase().contains(s)) return true;
    for (final e in etiketler) {
      if (e.contains(s)) return true;
    }
    return false;
  }
}

class DuaGrubu {
  final String ad;
  final List<DuaKaydi> dualar;

  const DuaGrubu({required this.ad, required this.dualar});
}

class DuaKategori {
  final String id;
  final String ad;
  final String emoji;
  final String renkHex;
  final List<DuaGrubu> gruplar;

  const DuaKategori({
    required this.id,
    required this.ad,
    required this.emoji,
    required this.renkHex,
    required this.gruplar,
  });

  int get duaSayisi =>
      gruplar.fold(0, (toplam, g) => toplam + g.dualar.length);
}

/// Uzak JSON'dan gelen kategorileri çözer (gömülü asset ile aynı şema).
List<DuaKategori> duaKategorileriCoz(Map<String, dynamic> json) {
  return ((json['kategoriler'] as List<dynamic>?) ?? [])
      .map((e) {
        final m = e as Map<String, dynamic>;
        return DuaKategori(
          id: m['id'] as String,
          ad: (m['ad'] as String?) ?? '',
          emoji: (m['emoji'] as String?) ?? '🤲',
          renkHex: (m['renk'] as String?) ?? '#F2C14E',
          gruplar: ((m['gruplar'] as List<dynamic>?) ?? []).map((g) {
            final gm = g as Map<String, dynamic>;
            return DuaGrubu(
              ad: (gm['ad'] as String?) ?? '',
              dualar: ((gm['dualar'] as List<dynamic>?) ?? [])
                  .map((d) => DuaKaydi.fromJson(d as Map<String, dynamic>))
                  .toList(),
            );
          }).toList(),
        );
      })
      .toList();
}

class DualarVerileri {
  DualarVerileri._();

  static final DualarVerileri instance = DualarVerileri._();

  /// Uzak dua JSON adresi (lazy-load / bulut tabanlı içerik).
  ///
  /// Kendi sunucunuzdaki/statik hosting'deki bu dosyayı güncelleyerek yeni
  /// dualar, faziletler ve çok dilli mealler ekleyebilirsiniz — uygulamayı
  /// Store'da güncellemeye gerek kalmaz. Boş bırakılırsa gömülü asset kullanılır.
  static const String uzakJsonUrl =
      'https://raw.githubusercontent.com/kullanici/islami-uygulama-config/main/dualar.json';

  /// Yeniden deneme periyodu: içerik güncellemelerini yakalamak için 12 saat.
  static const Duration yenilemePeriyodu = Duration(hours: 12);

  static const _onbellekAnahtari = 'dualar_uzak_onbellek';
  static const _sonYenilemeAnahtari = 'dualar_uzak_son_yenileme';

  List<DuaKategori>? _kategoriler;

  Future<List<DuaKategori>> kategorileriYukle() async {
    final mevcut = _kategoriler;
    if (mevcut != null) return mevcut;

    final veri = await rootBundle.load('assets/dualar.json');
    final json = jsonDecode(utf8.decode(veri.buffer.asUint8List()))
        as Map<String, dynamic>;
    final kategoriler = duaKategorileriCoz(json);
    _kategoriler = kategoriler;
    return kategoriler;
  }

  /// Uzak JSON'u deneyip içeriği yeniler:
  /// başarı → değişiklik yoksa false, güncellendiyse true.
  /// Hata/sunucu yoksa false döner ve gömülü/önbellek içerik korunur.
  static Future<bool> uzaktanYenile({bool zorla = false}) async {
    try {
      if (!zorla) {
        final p = await SharedPreferences.getInstance();
        final son = p.getInt(_sonYenilemeAnahtari) ?? 0;
        final gecti = DateTime.now().difference(
          DateTime.fromMillisecondsSinceEpoch(son),
        );
        if (gecti < yenilemePeriyodu) return false;
      }
      final yanit = await http
          .get(Uri.parse(uzakJsonUrl))
          .timeout(const Duration(seconds: 10));
      if (yanit.statusCode != 200) return false;
      final ham = jsonDecode(yanit.body);
      if (ham is! Map<String, dynamic>) return false;
      final kategoriler = duaKategorileriCoz(ham);
      if (kategoriler.isEmpty) return false;
      if (kategoriler.isEmpty || kategoriler.every((k) => k.duaSayisi == 0)) {
        return false;
      }

      instance._kategoriler = kategoriler;
      final p = await SharedPreferences.getInstance();
      await p.setString(_onbellekAnahtari, jsonEncode(ham));
      await p.setInt(
        _sonYenilemeAnahtari,
        DateTime.now().millisecondsSinceEpoch,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Tüm dualar (arama ve favoriler için).
  Future<List<DuaKaydi>> tumDualar() async {
    final kategoriler = await kategorileriYukle();
    return [
      for (final k in kategoriler)
        for (final g in k.gruplar) ...g.dualar,
    ];
  }

  Future<DuaKaydi?> idIleBul(String id) async {
    final dualar = await tumDualar();
    for (final d in dualar) {
      if (d.id == id) return d;
    }
    return null;
  }

  Future<List<DuaKaydi>> ara(String sorgu) async {
    final s = sorgu.trim();
    if (s.isEmpty) return const [];
    final dualar = await tumDualar();
    return dualar.where((d) => d.esles(s)).toList();
  }

  /// Uygulama açılışında/bölüm açılışında bir kez çağrılır: önce gömülü veya
  /// önbellekteki içerik kullanılır, sonra arka planda uzak sunucu denenir.
  static Future<void> bolumAcildaYenile() async {
    unawaited(uzaktanYenile());
  }
}