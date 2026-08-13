// ===========================================================================
// DİNİ GÜNLER SERVİSİ — Ramazan ve kandil tarihleri (Diyanet takvimi)
// ---------------------------------------------------------------------------
// 1) GÖMÜLÜ TABLO: Diyanet İşleri Başkanlığı resmî dini günler takvimi
//    (2025-2030) kod içinde sabittir; uygulama her zaman doğru tarihle açılır.
// 2) BULUT (lazy): Ana ekran açılırken config/dini_gunler.json uzak dosyası
//    24 saatte bir tazelenir; yeni yılların resmî tarihleri uygulama
//    güncellemesi olmadan devreye girer. Bağlantı yoksa gömülü tablo kalır.
// 3) YEDEK HESAP: Tabloda olmayan yıllar için standart hicri "tabular"
//    takvim algoritması kullanılır; 1-2 gün içinde doğru tarih üretir (resmî
//    takvim yayınlanana kadar). Böylece sayaç asla yanlış sabit bir tarihte
//    "takılı kalmaz": hicri yıl miladi takvime göre her yıl ~11 gün geriye
//    kayar ve bu servis de her yıl kendiliğinden kayar.
// Kaynak: Diyanet İşleri Başkanlığı dini günler takvimi (diyanet.gov.tr).
// ===========================================================================

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DiniGunlerServisi {
  DiniGunlerServisi._();

  /// Uzak dini günler yapılandırması (radyoda güncellenebilir içerik):
  /// Bu dosyayı depoda güncelleyerek takvimi uygulama güncellemesi olmadan
  /// yönetebilirsiniz. Ulaşılamazsa gömülü Diyanet tablosu kullanılır.
  static const String uzakJsonUrl =
      'https://raw.githubusercontent.com/AkinAkonur/islami_uygulama/main/config/dini_gunler.json';

  /// Yeniden deneme periyodu: 24 saat (günde en fazla 1 tazeleme).
  static const Duration yenilemePeriyodu = Duration(hours: 24);

  static const _onbellekAnahtari = 'dini_gunler_uzak_onbellek';
  static const _sonYenilemeAnahtari = 'dini_gunler_uzak_son_yenileme';

  // -----------------------------------------------------------------------
  // DİYANET RESMÎ TAKVİMİ (gömülü): 2025-2030 Ramazan dönemleri
  // (2030'da iki Ramazan: 5 Oca-3 Şub ve 26 Ara 2030-24 Oca 2031)
  // -----------------------------------------------------------------------
  static const List<Map<String, Object>> _gomuluRamazan = [
    {'yil': 2025, 'baslangic': '2025-03-02', 'bitis': '2025-03-30'},
    {'yil': 2026, 'baslangic': '2026-02-19', 'bitis': '2026-03-19'},
    {'yil': 2027, 'baslangic': '2027-02-08', 'bitis': '2027-03-08'},
    {'yil': 2028, 'baslangic': '2028-01-28', 'bitis': '2028-02-25'},
    {'yil': 2029, 'baslangic': '2029-01-16', 'bitis': '2029-02-13'},
    {'yil': 2030, 'baslangic': '2030-01-05', 'bitis': '2030-02-03'},
    {'yil': 2030, 'baslangic': '2030-12-26', 'bitis': '2031-01-24'},
  ];

  /// Kandiller, arefe ve bayramlar (Diyanet resmî tarihleri).
  static const List<Map<String, String>> _gomuluOzelGunler = [
    {'tarih': '2025-12-25', 'ad': 'Regaib Kandili', 'ikon': '🌙'},
    {'tarih': '2026-01-15', 'ad': 'Miraç Kandili', 'ikon': '🪜'},
    {'tarih': '2026-02-02', 'ad': 'Berat Kandili', 'ikon': '✨'},
    {'tarih': '2026-03-16', 'ad': 'Kadir Gecesi', 'ikon': '🌙'},
    {'tarih': '2026-03-19', 'ad': 'Ramazan Bayramı Arefesi', 'ikon': '🤲'},
    {'tarih': '2026-03-20', 'ad': 'Ramazan Bayramı', 'ikon': '🎉'},
    {'tarih': '2026-05-26', 'ad': 'Kurban Bayramı Arefesi', 'ikon': '🕋'},
    {'tarih': '2026-05-27', 'ad': 'Kurban Bayramı', 'ikon': '🐑'},
    {'tarih': '2026-08-24', 'ad': 'Mevlid Kandili', 'ikon': '🕌'},
    {'tarih': '2026-12-10', 'ad': 'Regaib Kandili', 'ikon': '🌙'},
    {'tarih': '2027-01-04', 'ad': 'Miraç Kandili', 'ikon': '🪜'},
    {'tarih': '2027-01-22', 'ad': 'Berat Kandili', 'ikon': '✨'},
    {'tarih': '2027-03-05', 'ad': 'Kadir Gecesi', 'ikon': '🌙'},
    {'tarih': '2027-03-08', 'ad': 'Ramazan Bayramı Arefesi', 'ikon': '🤲'},
    {'tarih': '2027-03-09', 'ad': 'Ramazan Bayramı', 'ikon': '🎉'},
    {'tarih': '2027-05-15', 'ad': 'Kurban Bayramı Arefesi', 'ikon': '🕋'},
    {'tarih': '2027-05-16', 'ad': 'Kurban Bayramı', 'ikon': '🐑'},
    {'tarih': '2027-08-13', 'ad': 'Mevlid Kandili', 'ikon': '🕌'},
    {'tarih': '2027-12-02', 'ad': 'Regaib Kandili', 'ikon': '🌙'},
    {'tarih': '2027-12-24', 'ad': 'Miraç Kandili', 'ikon': '🪜'},
    {'tarih': '2028-02-22', 'ad': 'Kadir Gecesi', 'ikon': '🌙'},
    {'tarih': '2028-02-25', 'ad': 'Ramazan Bayramı Arefesi', 'ikon': '🤲'},
    {'tarih': '2028-02-26', 'ad': 'Ramazan Bayramı', 'ikon': '🎉'},
  ];

  // Etkin veri (gömülü başlar; uzak JSON gelince yerini alır).
  static List<Map<String, Object>> _gecerliRamazan = List.of(_gomuluRamazan);
  static List<Map<String, String>> _gecerliOzel = List.of(_gomuluOzelGunler);

  /// Uygulama başlarken çağrılır: uzak takvimi (varsa) arka planda tazeler.
  /// Dönüşü beklenmez; başarısız olursa gömülü Diyanet tablosu geçerli kalır.
  static void baslat() {
    unawaited(uzaktanYenile());
  }

  /// Uzak JSON'u deneyip tabloyu günceller: başarı → true.
  /// Hata ya da periyot dolmamışsa false; gömülü/önbellek korunur.
  static Future<bool> uzaktanYenile({bool zorla = false}) async {
    try {
      final p = await SharedPreferences.getInstance();
      if (!zorla) {
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
      _uygula(ham);
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

  /// Kaynak paketi ayrıştırıp etkin tabloyu değiştirir (güvenli ayrıştırma:
  /// bozuk kayıtlar atlanır, tamamen boş paket reddedilir).
  static void _uygula(Map<String, dynamic> ham) {
    final kok = ham['dini_gunler_modulu'] as Map<String, dynamic>? ?? ham;

    final rList = kok['ramazan_periyotlari'] as List<dynamic>? ?? const [];
    final yeniRamazan = <Map<String, Object>>[];
    for (final o in rList) {
      if (o is! Map<String, dynamic>) continue;
      final bas = _tarihCoz(o['baslangic']);
      final bit = _tarihCoz(o['bitis']);
      if (bas == null || bit == null || !bas.isBefore(bit)) continue;
      yeniRamazan.add({
        'yil': bas.year,
        'baslangic': o['baslangic'].toString(),
        'bitis': o['bitis'].toString(),
      });
    }
    if (yeniRamazan.isNotEmpty) _gecerliRamazan = yeniRamazan;

    final oList = kok['ozel_gunler'] as List<dynamic>? ?? const [];
    final yeniOzel = <Map<String, String>>[];
    for (final o in oList) {
      if (o is! Map<String, dynamic>) continue;
      final tarih = o['tarih']?.toString();
      final ad = o['ad']?.toString().trim() ?? '';
      if (tarih == null || _tarihCoz(tarih) == null || ad.isEmpty) continue;
      yeniOzel.add({
        'tarih': tarih,
        'ad': ad,
        'ikon': (o['ikon'] ?? '🌙').toString(),
      });
    }
    if (yeniOzel.isNotEmpty) _gecerliOzel = yeniOzel;
  }

  static DateTime? _tarihCoz(Object? s) {
    if (s == null) return null;
    final t = DateTime.tryParse(s.toString());
    return t;
  }

  // -----------------------------------------------------------------------
  // RAMAZAN ARALIKLARI (tablo + hicri yedek)
  // -----------------------------------------------------------------------

  /// [yil] içinde başlayan tüm Ramazan dönemleri.
  /// 2030 gibi çift Ramazan yıllarında birden fazla dönem dönebilir.
  static List<({DateTime bas, DateTime bit})> ramazanAraliklari(int yil) {
    final sonuc = <({DateTime bas, DateTime bit})>[];
    var tablodaVar = false;
    for (final kayit in _gecerliRamazan) {
      final bas = _tarihCoz(kayit['baslangic']);
      final bit = _tarihCoz(kayit['bitis']);
      if (bas == null || bit == null) continue;
      if (bas.year == yil) {
        sonuc.add((bas: bas, bit: bit));
        tablodaVar = true;
      }
    }
    if (tablodaVar) return sonuc;

    // Tablo dışı yıl → tabular hicri takvim yedeği (1-2 gün yaklaşık).
    final hicri = _hicriYilTahmin(yil);
    for (final h in {hicri - 1, hicri}) {
      final bas = _hicriRamazanBaslangic(h);
      if (bas.year == yil) {
        sonuc.add((bas: bas, bit: bas.add(const Duration(days: 28))));
      }
    }
    return sonuc;
  }

  /// [yil] için Ramazan başlangıcı (1 Ramazan). Çift Ramazan yıllarında
  /// ilk dönemi döndürür.
  static DateTime ramazanBaslangic(int yil) {
    final aralik = ramazanAraliklari(yil);
    return aralik.isEmpty
        ? _hicriRamazanBaslangic(_hicriYilTahmin(yil))
        : aralik.first.bas;
  }

  /// [yil] için 30 Ramazan (orucun son günü). Çift Ramazan yıllarında ilk
  /// dönemin bitişini döndürür.
  static DateTime ramazanBitis(int yil) {
    final aralik = ramazanAraliklari(yil);
    return aralik.isEmpty
        ? ramazanBaslangic(yil).add(const Duration(days: 28))
        : aralik.first.bit;
  }

  /// [now] Ramazan ayı içinde mi? (2030 çift Ramazan dahil; bitiş günü de
  /// Ramazan sayılır — arefe orucu).
  static bool ramazanIci(DateTime now) {
    for (var y = now.year - 1; y <= now.year + 1; y++) {
      for (final a in ramazanAraliklari(y)) {
        if (!now.isBefore(a.bas) &&
            now.isBefore(a.bit.add(const Duration(days: 1)))) {
          return true;
        }
      }
    }
    return false;
  }

  /// [now]'dan sonraki ilk Ramazan başlangıcı (geri sayım hedefi).
  static DateTime sonrakiRamazanBaslangic(DateTime now) {
    DateTime? enYakin;
    for (var y = now.year - 1; y <= now.year + 3; y++) {
      for (final a in ramazanAraliklari(y)) {
        if (a.bas.isAfter(now) &&
            (enYakin == null || a.bas.isBefore(enYakin))) {
          enYakin = a.bas;
        }
      }
    }
    return enYakin ?? ramazanBaslangic(now.year + 1);
  }

  // -----------------------------------------------------------------------
  // HİCRİ TABULAR TAKVİM YEDEĞİ (standart "takvimsel" metin: ±1-2 gün)
  // -----------------------------------------------------------------------

  /// Miladi yıla denk gelen hicri yıl tahmini.
  static int _hicriYilTahmin(int miladiYil) =>
      ((miladiYil - 622) * 33) ~/ 32;

  /// Hicri [yil]'in 1 Ramazan gününün miladi karşılığı (tabular takvim).
  /// Formül: JDN = gun + ceil(29.5001*(ay-1)) + (yil-1)*354 +
  ///          floor((3+11*yil)/30) + 1948439   (ay=9, gun=1)
  static DateTime _hicriRamazanBaslangic(int hicriYil) {
    final jdn = 1948439 +
        (hicriYil - 1) * 354 +
        ((3 + 11 * hicriYil) ~/ 30) +
        238;
    return _julianGunden(jdn);
  }

  /// JDN -> Miladi (Fliegel–Van Flandern algoritması).
  static DateTime _julianGunden(int jdn) {
    var l = jdn + 68569;
    final n = (4 * l) ~/ 146097;
    l = l - (146097 * n + 3) ~/ 4;
    final i = (4000 * (l + 1)) ~/ 1461001;
    l = l - (1461 * i) ~/ 4 + 31;
    final j = (80 * l) ~/ 2447;
    final gun = l - (2447 * j) ~/ 80;
    l = j ~/ 11;
    final ay = j + 2 - 12 * l;
    final yil = 100 * (n - 49) + i + l;
    return DateTime(yil, ay, gun);
  }

  // -----------------------------------------------------------------------
  // ÖZEL GÜNLER (kandil, arefe, bayram)
  // -----------------------------------------------------------------------

  /// Etkin özel günler listesi (tarihe göre sıralı). Görünüm ve bildirim
  /// aynı 'tarih' (YYYY-AA-GG) anahtarını kullanır.
  static List<Map<String, String>> get ozelGunler {
    final liste = List<Map<String, String>>.of(_gecerliOzel);
    liste.sort(
      (a, b) => (a['tarih'] ?? '').compareTo(b['tarih'] ?? ''),
    );
    return liste;
  }
}