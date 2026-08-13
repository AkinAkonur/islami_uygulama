// ===========================================================================
// İLHAM VE HİKMET VERİ SERVİSİ (bulut tabanlı + çevrimdışı)
// ---------------------------------------------------------------------------
// İlham köşesi beş kategoriden beslenir:
//   ayet   -> Günün Âyeti ve Tefekkür Notu
//   hadis  -> Günün Hadis-i Şerifi ve Günlük Hayat Rehberliği
//   alim   -> İslam Alimlerinden Hikmetli Sözler
//   bilgi  -> "Bunu biliyor muydunuz?" (İlham Köşesi)
//   dua    -> Günün Duası / Niyeti
//
// MİMARİ (uygulamayı şişirmez):
// 1) GÖMÜLÜ HAVUZ: Küçük, yalnızca metin içeren bir havuz (~55 kayıt) her
//    gün tarihe göre farklı içerik gösterir (döngüsel rotasyon).
// 2) BULUT (lazy-load): Günün içeriği/arşiv paketleri uzak JSON'dan alınır,
//    cihazda önbelleğe yazılır (smart caching) — internet yoksa son içerik.
// 3) ARŞİV: Yalnızca "Geçmiş Günler" açıldığında hesaplanır/yenilenir.
// ===========================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// İlham içeriğinin kategorisi (günlük akışın beş modülü).
enum IlhamKategori {
  ayet('Günün Âyeti & Tefekkür', IconsTip.ayet),
  hadis('Günün Hadis-i Şerifi', IconsTip.hadis),
  alim('Alimlerden Hikmetli Sözler', IconsTip.alim),
  bilgi('Bunu Biliyor Muydunuz?', IconsTip.bilgi),
  dua('Günün Duası / Niyeti', IconsTip.dua);

  const IlhamKategori(this.ad, this.ikon);

  final String ad;
  final String ikon;

  /// JSON'daki kategori etiketi/anahtarından çözer; bilinmeyen → [ayet].
  static IlhamKategori coz(Object? deger) {
    final s = deger?.toString().trim().toLowerCase() ?? '';
    if (s.contains('hadis')) return hadis;
    if (s.contains('alim') || s.contains('hikmetli') || s.contains('söz')) {
      return alim;
    }
    if (s.contains('biliyor') || s.contains('bilgi') || s.contains('medeniyet')) {
      return bilgi;
    }
    if (s.contains('dua') || s.contains('niyet')) return dua;
    if (s.contains('ayet') || s.contains('tefekkür') || s.contains('hikmet')) {
      return ayet;
    }
    return ayet;
  }
}

/// Kategori ikon adları (veri dosyasında ikon adı taşınmasın diye kod tarafı).
class IconsTip {
  static const ayet = 'menu_book';
  static const hadis = 'auto_stories';
  static const alim = 'emoji_objects';
  static const bilgi = 'lightbulb';
  static const dua = 'volunteer_activism';
}

/// Tek bir ilham/hikmet içeriği (kayıt).
class IlhamIcerik {
  final String id;
  final IlhamKategori kategori;
  final String baslik;
  final String metin; // ana içerik (hikmet, tefekkür, bilgi, dua metni...)
  final String kaynak; // ayet referansı / hadis kaynağı / alim adı
  final String arkaPlan; // paylaşım kartı arka plan anahtarı (ör. emerald)
  final List<String> etiketler;
  final String? ek; // ayet meali vb. öne çıkan alıntı (opsiyonel)

  const IlhamIcerik({
    required this.id,
    required this.kategori,
    required this.baslik,
    required this.metin,
    required this.kaynak,
    this.arkaPlan = 'gece',
    this.etiketler = const [],
    this.ek,
  });

  factory IlhamIcerik.json(Map<String, dynamic> j) => IlhamIcerik(
        id: (j['id'] as String?) ?? '',
        kategori: IlhamKategori.coz(j['kategori']),
        baslik: (j['baslik'] as String?) ?? '',
        metin: (j['metin'] as String?) ?? '',
        kaynak: (j['kaynak_ayet_veya_soz'] as String?) ?? '',
        arkaPlan: (j['paylasim_gorsel_arkaplan'] as String?) ?? 'gece',
        etiketler: ((j['etiketler'] as List<dynamic>?) ?? const [])
            .map((e) => e.toString().trim().toLowerCase())
            .where((e) => e.isNotEmpty)
            .toList(),
        ek: j['ek'] as String?,
      );
}

class IlhamVerileri {
  IlhamVerileri._();

  static final IlhamVerileri instance = IlhamVerileri._();

  /// Uzak ilham JSON adresi (bulut tabanlı günlük akış / arşiv paketleri).
  /// Kendi sunucunuzdaki dosyayı güncelleyerek içeriği uygulama güncellemesi
  /// olmadan yönetebilirsiniz. Boş/ulaşılamaz → gömülü havuz kullanılır.
  static const String uzakJsonUrl =
      'https://raw.githubusercontent.com/kullanici/islami-uygulama-config/main/ilham_hikmet.json';

  /// Yeniden deneme periyodu: 12 saat (günde en fazla 2 tazeleme).
  static const Duration yenilemePeriyodu = Duration(hours: 12);

  static const _onbellekAnahtari = 'ilham_uzak_onbellek';
  static const _sonYenilemeAnahtari = 'ilham_uzak_son_yenileme';

  List<IlhamIcerik> _havuz = [];
  bool _yuklendi = false;

  /// Kaynak paketler (JSON): [gömuluIlhamJson]'dan çözülür.
  List<IlhamIcerik> _pakettenCoz(Map<String, dynamic> json) {
    // Şema: ilham_hikmet_modulu.gunluk_icerikler [ kayıt... ]
    final kok =
        json['ilham_hikmet_modulu'] as Map<String, dynamic>? ?? json;
    final liste = kok['gunluk_icerikler'] as List<dynamic>? ??
        (kok['gunun_icerigi'] != null
            ? [kok['gunun_icerigi']]
            : const []);
    return [
      for (final o in liste)
        if (o is Map<String, dynamic>) IlhamIcerik.json(o),
    ];
  }

  /// Havuzu yükler: önce gömülü asset (her zaman), sonra önbellek varsa onun
  /// kayıtları havuzu zenginleştirir. Böylece çevrimdışı da güncel kalır.
  Future<void> _yukle() async {
    if (_yuklendi) return;
    _yuklendi = true;
    try {
      final veri = await rootBundle.load('assets/ilham_hikmet.json');
      final json = jsonDecode(utf8.decode(veri.buffer.asUint8List()))
          as Map<String, dynamic>;
      final liste = _pakettenCoz(json);
      if (liste.isNotEmpty) _havuz = liste;
    } catch (_) {}

    try {
      final p = await SharedPreferences.getInstance();
      final ham = p.getString(_onbellekAnahtari);
      if (ham == null) return;
      final liste = _pakettenCoz(jsonDecode(ham) as Map<String, dynamic>);
      if (liste.isNotEmpty) _havuz = liste;
    } catch (_) {}
  }

  /// Tarih sayısına göre döngüsel seçim (gün -> kayıt indeksi).
  static int _donustur(int gunSayisi, int kayitSayisi) {
    if (kayitSayisi <= 0) return 0;
    return ((gunSayisi % kayitSayisi) + kayitSayisi) % kayitSayisi;
  }

  /// [tarih] (varsayılan: bugün) için günün akışındaki 5 içerik.
  Future<List<IlhamIcerik>> gununAkisi([DateTime? tarih]) async {
    await _yukle();
    final tarih2 = tarih ?? DateTime.now();
    final yilBasi = DateTime(tarih2.year, 1, 1);
    final gun = tarih2.difference(yilBasi).inDays + 1; // 1..366
    final akis = <IlhamIcerik>[];
    for (final k in IlhamKategori.values) {
      final liste = _havuz.where((i) => i.kategori == k).toList();
      if (liste.isEmpty) continue;
      akis.add(liste[_donustur(gun, liste.length)]);
    }
    return akis;
  }

  /// "Geçmiş Günler" arşivi: [geriye] güne kadar dün, önceki gün... her gün
  /// için 5 içerik. Yalnızca kullanıcı Arşiv sekmesine dokunduğunda çağrılır
  /// (lazy loading) ve gerekirse bulut paketi tazelenir.
  Future<List<Map<String, Object>>> arsivGunleri({int geriye = 7}) async {
    await _yukle();
    final bugun = DateTime.now();
    final sonuc = <Map<String, Object>>[];
    for (var d = 1; d <= geriye; d++) {
      final gun = bugun.subtract(Duration(days: d));
      final icerikler = await gununAkisi(gun);
      sonuc.add({
        'tarih': gun,
        'icerikler': icerikler,
      });
    }
    return sonuc;
  }

  /// Uzak JSON'u deneyip havuzu günceller: başarı/güncelleme → true.
  /// Hata ya da güncelleme zamanı gelmemişse false; önbellek/gömülü korunur.
  static Future<bool> uzaktanYenile({bool zorla = false}) async {
    final servis = instance;
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
      final liste = servis._pakettenCoz(ham);
      if (liste.isEmpty) return false;

      servis._havuz = liste;
      servis._yuklendi = true;
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

  /// Kaynağı adresiyle bulur (favoriler için).
  Future<IlhamIcerik?> idIleBul(String id) async {
    await _yukle();
    for (final i in _havuz) {
      if (i.id == id) return i;
    }
    return null;
  }
}