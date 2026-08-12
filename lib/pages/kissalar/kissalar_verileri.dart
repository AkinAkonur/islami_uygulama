import 'package:flutter/material.dart';

// ===========================================================================
// KISSALAR & PEYGAMBERLER MODÜLÜ - VERİ MODELLERİ
// Tüm içerik çevrimdışı çalışır; ses ve görsel kaynaklar için CDN/API
// altyapısına hazır alanlar taşır (sesUrl vb.). Kaynak esasları: Diyanet
// İşleri Başkanlığı, İbn Kesîr "Peygamberler ve Melikler Tarihi",
// M. Âsım Köksal "İslam Tarihi", Kadı Iyaz "Şifa-i Şerif",
// İmam Nevevî "Riyâzü's-Sâlihîn".
// ===========================================================================

/// Ayet referansı: Arapça metin + meali + kaynağı (sure/ayet).
class AyetKaydi {
  final String arapca;
  final String meal;
  final String kaynak;

  const AyetKaydi({
    required this.arapca,
    required this.meal,
    required this.kaynak,
  });
}

/// Hadis-i şerif referansı.
class HadisKaydi {
  final String metin;
  final String kaynak;

  const HadisKaydi({required this.metin, required this.kaynak});
}

/// Kronoloji maddesi (Tarih sekmesi).
class KronolojiMadde {
  final String tarih;
  final String olay;

  const KronolojiMadde({required this.tarih, required this.olay});
}

/// Coğrafya noktası (Tarih & Coğrafya sekmesi, harita köprüsü ile).
class CografyaNokta {
  final String yer;
  final String aciklama;
  final double? enlem;
  final double? boylam;

  const CografyaNokta({
    required this.yer,
    required this.aciklama,
    this.enlem,
    this.boylam,
  });
}

/// Quiz sorusu ("Ne Kadar Öğrendin?").
class QuizSoru {
  final String soru;
  final List<String> secenekler;
  final int dogruIndex;

  const QuizSoru({
    required this.soru,
    required this.secenekler,
    required this.dogruIndex,
  });
}

/// Peygamberler için kimlik kartı alanı ("Yaşadığı dönem" vb.).
class KimlikKarti {
  final String alanAdi;
  final String deger;

  const KimlikKarti({required this.alanAdi, required this.deger});
}

/// Kıssa / siyer / peygamber kaydı.
class KissaKaydi {
  final String id;
  final String baslik;
  final String ozet;
  final String emoji;
  final String kategoriId; // siyer | peygamberler | ibret
  final List<String> temalar; // Sabır, Adalet, Cesaret, Sadakat...
  final String donem; // Dönem/zaman etiketi (filtreleme + rozet)
  final List<String> metin; // Metin & Anlatım paragrafları
  final List<AyetKaydi> ayetler; // Ayet & Hadis sekmesi
  final List<HadisKaydi> hadisler;
  final List<KronolojiMadde> kronoloji; // Tarih & Coğrafya sekmesi
  final List<CografyaNokta> cografya;
  final List<String> hikmetler; // Hikmet & Dersler
  final List<String> akademikNotlar; // Akademik / Detay Notlar
  final List<QuizSoru> quiz; // "Ne Kadar Öğrendin?"
  final String? sesUrl; // CDN/streaming ses adresi
  final List<KimlikKarti> kimlikKarti; // Peygamberler için

  const KissaKaydi({
    required this.id,
    required this.baslik,
    required this.ozet,
    required this.emoji,
    required this.kategoriId,
    this.temalar = const [],
    this.donem = '',
    this.metin = const [],
    this.ayetler = const [],
    this.hadisler = const [],
    this.kronoloji = const [],
    this.cografya = const [],
    this.hikmetler = const [],
    this.akademikNotlar = const [],
    this.quiz = const [],
    this.sesUrl,
    this.kimlikKarti = const [],
  });

  /// Arama için metnin tamamını birleştirir.
  String get aramaMetni => [
        baslik,
        ozet,
        donem,
        ...metin,
        ...hikmetler,
        ...akademikNotlar,
        ...ayetler.map((a) => '${a.arapca} ${a.meal} ${a.kaynak}'),
        ...hadisler.map((h) => '${h.metin} ${h.kaynak}'),
        ...cografya.map((c) => '${c.yer} ${c.aciklama}'),
      ].join(' ').toLowerCase();
}

/// Grup (akordeon başlığı): Siyer'de evreler, İbret'te alt başlıklar.
class KissaGrubu {
  final String ad;
  final String aciklama;
  final List<KissaKaydi> kisalar;

  const KissaGrubu({
    required this.ad,
    required this.aciklama,
    required this.kisalar,
  });
}

/// Ana kategori sütunu: Siyer-i Nebi / Peygamberler Tarihi / İbretlik Hikayeler.
class KissaKategori {
  final String id;
  final String ad;
  final String altBaslik;
  final String emoji;
  final String renkHex;
  final String renkAkcentHex;
  final List<KissaGrubu> gruplar;

  const KissaKategori({
    required this.id,
    required this.ad,
    required this.altBaslik,
    required this.emoji,
    required this.renkHex,
    required this.renkAkcentHex,
    required this.gruplar,
  });

  List<KissaKaydi> get tumKisalar => [for (final g in gruplar) ...g.kisalar];
}

/// Tüm modülün kayıt defteri: kategoriler + arama + günün kıssası.
/// Veri dosyaları (_siyer, _peygamberler, _ibret) verilerini kaydettirir.
class KissalarVerileri {
  KissalarVerileri._();

  static final List<KissaKategori> _kategoriler = [];

  static void kayitKategori(KissaKategori kategori) {
    if (_kategoriler.any((k) => k.id == kategori.id)) return;
    _kategoriler.add(kategori);
  }

  static List<KissaKategori> get kategoriler => List.unmodifiable(_kategoriler);

  static List<KissaKaydi> get tumKisalar => [
        for (final k in _kategoriler) ...k.tumKisalar,
      ];

  static KissaKaydi? bul(String id) {
    for (final k in tumKisalar) {
      if (k.id == id) return k;
    }
    return null;
  }

  /// Günün Kıssası: gün numarasına göre döner (her gün değişir).
  static KissaKaydi gununKissasi() {
    final liste = tumKisalar;
    if (liste.isEmpty) {
      // Kayıt defteri boş kalırsa (test vb.) güvenli bir boş kayıt döner.
      return _bositKayit;
    }
    final gun = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    return liste[gun % liste.length];
  }

  static KissaKaydi get _bositKayit => KissaKaydi(
        id: 'bos',
        baslik: 'İçerik hazırlanıyor',
        ozet: 'Modül içerikleri yükleniyor.',
        emoji: '📖',
        kategoriId: 'ibret',
      );

  /// Tematik filtreleme.
  static List<KissaKaydi> temayaGore(String tema) =>
      tumKisalar.where((k) => k.temalar.contains(tema)).toList();

  static const List<String> tumTemalar = [
    'Sabır',
    'Adalet',
    'Cesaret',
    'Sadakat',
    'Merhamet',
    'Cömertlik',
    'İlim',
    'Tevekkül',
    'Ahlak',
    'İffet',
  ];

  /// Dönem (zaman) filtresi için benzersiz değerler.
  static List<String> get tumDonemler {
    final set = <String>{};
    for (final k in tumKisalar) {
      if (k.donem.isNotEmpty) set.add(k.donem);
    }
    return set.toList()..sort();
  }

  /// Metin içi arama: başlık, metin, ayet, hadis ve hikmetlerde sözcük arar.
  static List<KissaKaydi> ara(String sorgu) {
    final q = sorgu.trim().toLowerCase();
    final kelimeler = q
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 1)
        .toList();
    if (kelimeler.isEmpty) return const [];
    return tumKisalar.where((k) {
      final metin = k.aramaMetni;
      return kelimeler.every((w) => metin.contains(w));
    }).toList();
  }
}

/// Veri dosyalarının ortak renk yardımcısı (hex kod → renk).
Color kissaHex(String hex) {
  var h = hex.replaceFirst('#', '');
  if (h.length == 6) h = 'FF$h';
  return Color(int.tryParse(h, radix: 16) ?? 0xFFF2C14E);
}