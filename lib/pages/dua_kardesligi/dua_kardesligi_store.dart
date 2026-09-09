// ===========================================================================
// DUA KARDEŞLİĞİ DEPOSU - VERİ KATMANI
// Dua istekleri, "Amin" sayacı, şikâyet ve rozetler tek katmanda yönetilir.
// Not: Bu sürüm tamamen çevrimdışıdır (uygulamanın gizlilik ilkesi gereği);
// ileride bir API'ye bağlanırsa yalnızca bu dosya değişir, arayüz etkilenmez.
//   • "Amin" sayacı sunucuda Redis + toplu (batch) yazım gerektirir; burada
//     cihaz bazında güvenli sayım yapılır (cihaz başına tek Amin).
//   • Şikâyet kuralı: 3 farklı kullanıcı şikâyet ederse kart akıştan kaldırılır.
// ===========================================================================

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dua isteği kartı.
@immutable
class DuaIstegi {
  final String id;
  final String kategori;
  final String metin;
  final String isim; // boş ise anonim → "Bir Müslüman Kardeşiniz"
  final String ulkeEmoji; // opsiyonel ülke bayrağı
  final String ulkeAdi;
  final DateTime olusturma;
  final int sureSaat; // 24 / 72 / 168
  final int aminSayisi;
  final int sikayetSayisi;
  final bool benAminVerdim;
  final bool benSikayetEttim;
  final bool kaldirildi; // 3 şikâyette otomatik kaldırma
  final bool benim;

  const DuaIstegi({
    required this.id,
    required this.kategori,
    required this.metin,
    this.isim = '',
    this.ulkeEmoji = '',
    this.ulkeAdi = '',
    required this.olusturma,
    required this.sureSaat,
    this.aminSayisi = 0,
    this.sikayetSayisi = 0,
    this.benAminVerdim = false,
    this.benSikayetEttim = false,
    this.kaldirildi = false,
    this.benim = false,
  });

  bool get anonim => isim.isEmpty;
  String get gorunenIsim => anonim ? 'Bir Müslüman Kardeşiniz' : isim;

  bool get suresiDoldu => DateTime.now().isAfter(
        olusturma.add(Duration(hours: sureSaat)),
      );

  DuaIstegi kopyala({
    int? aminSayisi,
    int? sikayetSayisi,
    bool? benAminVerdim,
    bool? benSikayetEttim,
    bool? kaldirildi,
  }) {
    return DuaIstegi(
      id: id,
      kategori: kategori,
      metin: metin,
      isim: isim,
      ulkeEmoji: ulkeEmoji,
      ulkeAdi: ulkeAdi,
      olusturma: olusturma,
      sureSaat: sureSaat,
      aminSayisi: aminSayisi ?? this.aminSayisi,
      sikayetSayisi: sikayetSayisi ?? this.sikayetSayisi,
      benAminVerdim: benAminVerdim ?? this.benAminVerdim,
      benSikayetEttim: benSikayetEttim ?? this.benSikayetEttim,
      kaldirildi: kaldirildi ?? this.kaldirildi,
      benim: benim,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kategori': kategori,
        'metin': metin,
        'isim': isim,
        'ulkeEmoji': ulkeEmoji,
        'ulkeAdi': ulkeAdi,
        'olusturma': olusturma.toIso8601String(),
        'sureSaat': sureSaat,
        'aminSayisi': aminSayisi,
        'sikayetSayisi': sikayetSayisi,
        'benAminVerdim': benAminVerdim,
        'benSikayetEttim': benSikayetEttim,
        'kaldirildi': kaldirildi,
        'benim': benim,
      };

  factory DuaIstegi.fromJson(Map<String, dynamic> j) => DuaIstegi(
        id: j['id'] as String,
        kategori: j['kategori'] as String,
        metin: j['metin'] as String,
        isim: (j['isim'] as String?) ?? '',
        ulkeEmoji: (j['ulkeEmoji'] as String?) ?? '',
        ulkeAdi: (j['ulkeAdi'] as String?) ?? '',
        olusturma: DateTime.parse(j['olusturma'] as String),
        sureSaat: (j['sureSaat'] as num?)?.toInt() ?? 24,
        aminSayisi: (j['aminSayisi'] as num?)?.toInt() ?? 0,
        sikayetSayisi: (j['sikayetSayisi'] as num?)?.toInt() ?? 0,
        benAminVerdim: (j['benAminVerdim'] as bool?) ?? false,
        benSikayetEttim: (j['benSikayetEttim'] as bool?) ?? false,
        kaldirildi: (j['kaldirildi'] as bool?) ?? false,
        benim: (j['benim'] as bool?) ?? false,
      );
}

/// Rozet tanımı.
class Rozet {
  final String id;
  final String ad;
  final String aciklama;
  final String ikon; // emoji
  final int esik;
  final bool aminTuru; // true = amin sayısı, false = istek sayısı

  const Rozet({
    required this.id,
    required this.ad,
    required this.aciklama,
    required this.ikon,
    required this.esik,
    required this.aminTuru,
  });
}

/// Dua kategorileri.
const List<String> duaKategorileri = [
  'Şifa',
  'Sınav / Eğitim',
  'Borç / Sıkıntı',
  'Ailevi Durum',
  'Ahiret / Maneviyat',
];

/// Kategori başına hazır şablonlar (moderasyon yükünü azaltan Madlibs).
const Map<String, List<String>> duaSablonlari = {
  'Şifa': [
    '[_____] için acil şifa diliyorum. Dualarınızı bekliyorum.',
    'Ameliyatı olacak [_____] için dualarınızı rica ediyorum.',
    'Uzun süredir hasta olan [_____] için Rab\'den şifa istiyorum.',
  ],
  'Sınav / Eğitim': [
    '[_____] günkü sınavım için dualarınızı bekliyorum.',
    'Tezimi teslim edeceğim [_____] için hayırlısıyla başarı dilerim.',
    'Eğitim hayatımda [_____] sonucu için hayırlısını dilerim.',
  ],
  'Borç / Sıkıntı': [
    'Borçlarımdan kurtulmak için [_____] gün içinde dualarınızı rica ediyorum.',
    'Maddi sıkıntı içindeki [_____] için genişlik ve rızık dilerim.',
    'İş bulmak için çabalıyorum; [_____] için dualarınızı bekliyorum.',
  ],
  'Ailevi Durum': [
    'Ailemizin [_____] için hayırlısıyla sonuçlanmasını dilerim.',
    'Evlilik hazırlığında olan [_____] için hayırlısını istiyorum.',
    'Aramızdaki [_____] için birleştiriciliğini ve huzur dilerim.',
  ],
  'Ahiret / Maneviyat': [
    'İmanla ölen [_____] için mağfiret dilerim.',
    'Kalplerimizin [_____] hususunda hidayet bulması için dua edin.',
    'Nafile ibadetlerimde [_____] için sebat dilerim.',
  ],
};

/// Karakter sınırı (Twitter benzeri).
const int duaKarakterSiniri = 280;

/// Yayında kalma süresi seçenekleri (saat, etiket).
const List<(int, String)> duaSureSecenekleri = [
  (24, '24 Saat'),
  (72, '3 Gün'),
  (168, '1 Hafta'),
];

/// Rozetler.
const List<Rozet> rozetler = [
  Rozet(
    id: 'ilk_amin',
    ad: 'İlk Dua Et',
    aciklama: 'İlk "Amin"ini verdiğinde kazanırsın.',
    ikon: '🌱',
    esik: 1,
    aminTuru: true,
  ),
  Rozet(
    id: 'dert_ortagi',
    ad: 'Dert Ortağı',
    aciklama: '50 kardeşin duasına ortak oldun.',
    ikon: '🤝',
    esik: 50,
    aminTuru: true,
  ),
  Rozet(
    id: 'digerkam',
    ad: 'Diğerkâm',
    aciklama: '100 kardeşin için Amin dedin.',
    ikon: '💚',
    esik: 100,
    aminTuru: true,
  ),
  Rozet(
    id: 'merhamet',
    ad: 'Merhamet Çağlayanı',
    aciklama: '500 kardeşin duasına eşlik ettin.',
    ikon: '🌊',
    esik: 500,
    aminTuru: true,
  ),
  Rozet(
    id: 'gonul_sultani',
    ad: 'Gönül Sultanı',
    aciklama: '1000 kardeşin için Amin dedin.',
    ikon: '👑',
    esik: 1000,
    aminTuru: true,
  ),
  Rozet(
    id: 'dua_elcisi',
    ad: 'Dua Elçisi',
    aciklama: 'İlk dua isteğini paylaştın.',
    ikon: '📮',
    esik: 1,
    aminTuru: false,
  ),
  Rozet(
    id: 'cemaat_lideri',
    ad: 'Cemaat Lideri',
    aciklama: '10 dua isteği paylaştın.',
    ikon: '🕌',
    esik: 10,
    aminTuru: false,
  ),
];

/// Moderasyon: kelime filtresi + kalıp (IBAN/telefon) tespiti.
class Moderasyon {
  Moderasyon._();

  static final RegExp _iban = RegExp(
    r'\b(TR|SA|AE|KW|QA|BH|OM)\d{2}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\b',
    caseSensitive: false,
  );
  static final RegExp _telefon = RegExp(
    r'(\+?\d[\d\s\-]{9,}\d)',
  );

  /// Uygunsuz (küfür) sözcükler — genişletilebilir kara liste.
  static const List<String> _kufurListesi = [
    'amk', 'amq', 'aq', 'orospu', 'piç', 'göt', 'siktir', 'sikmek', 'sikeyim',
    'ananı', 'yavşak', 'pezevenk', 'kahpe', 'oç', 'mk', 'mq', 'kaşar',
    'ibne', 'şerefsiz', 'fuck', 'shit', 'bitch', 'damn',
  ];

  /// Siyasi içerik için sözcükler — genişletilebilir.
  static const List<String> _siyasiListesi = [
    'akp', 'chp', 'mhp', 'hdp', 'iyi parti', 'dem part', 'erdogan', 'kilicdaroglu',
    'bahceli', 'demirtas', 'netanyahu', 'trump', 'putin', 'terorist',
    'darbe', 'devrim', 'isyan', 'savas cagi', 'diktator', 'lider',
  ];

  /// Para/istismar kalıpları.
  static const List<String> _paraListesi = [
    'iban', 'para gonder', 'para gönder', 'havale', 'kredi kartı', 'banka',
    'hesap no', 'ödül kazandınız', 'kazandınız', 'çekiliş', 'puan topla',
    'ücretli', 'fidye öde', 'kripto', 'btc', 'bitcoin',
  ];

  static String _buyuk(String m) =>
      m.toLowerCase().replaceAll(RegExp(r'[^a-zçğıöşü0-9\s]'), '');

  /// Metni denetler; uygunsa `null`, değilse neden metni döner.
  static String? sorunBul(String metin) {
    final kucuk = metin.toLowerCase();

    if (metin.trim().isEmpty) return 'Lütfen bir dua metni yazın.';
    if (metin.trim().length < 10) return 'Dua metni çok kısa.';

    if (_iban.hasMatch(kucuk)) return 'IBAN / hesap bilgisi paylaşılamaz.';
    if (_telefon.hasMatch(metin)) return 'Telefon numarası paylaşılamaz.';

    final temiz = _buyuk(metin);
    for (final k in _kufurListesi) {
      if (temiz.contains(k)) return 'Metin kaba sözcük içeriyor.';
    }
    for (final s in _siyasiListesi) {
      if (temiz.contains(s)) return 'Siyasi içerik paylaşılamaz.';
    }
    for (final p in _paraListesi) {
      if (temiz.contains(p)) return 'Para/toplama içerikli talepler kabul edilmez.';
    }
    return null;
  }
}

/// Dua Kardeşliği deposu.
class DuaKardesligiStore {
  DuaKardesligiStore._();

  static const _anahtarIstekler = 'dua_kardesligi_istekler';
  static const _anahtarCihaz = 'dua_kardesligi_cihaz_id';

  /// İçerik değiştiğinde artan sürüm sayacı (UI dinler).
  static final ValueNotifier<int> surum = ValueNotifier<int>(0);

  static String? _cihazId;
  static List<DuaIstegi> _istekler = [];

  static String get cihazId {
    final r = _cihazId;
    if (r != null) return r;
    throw StateError('DuaKardesligiStore.yukle() önce çağrılmalı');
  }

  /// Kayıtlı istekleri yükler; ilk açılışta örnek (global) akışı oluşturur.
  static Future<void> yukle() async {
    final p = await SharedPreferences.getInstance();

    var cid = p.getString(_anahtarCihaz);
    if (cid == null) {
      cid = '${DateTime.now().millisecondsSinceEpoch}_'
          '${Random().nextInt(0xFFFFFF)}';
      await p.setString(_anahtarCihaz, cid);
    }
    _cihazId = cid;

    final raw = p.getString(_anahtarIstekler);
    if (raw == null) {
      _istekler = _ornekAkis();
      await _kaydet();
    } else {
      try {
        final liste = jsonDecode(raw) as List;
        _istekler = [
          for (final j in liste)
            DuaIstegi.fromJson((j as Map).cast<String, dynamic>()),
        ];
      } catch (_) {
        _istekler = _ornekAkis();
      }
    }
  }

  /// Yalnızca kaldırılmamış ve süresi dolmamış istekler.
  static List<DuaIstegi> aktifAkis() {
    eskiyenleriTemizle();
    final liste = _istekler
        .where((i) => !i.kaldirildi && !i.suresiDoldu)
        .toList()
      ..sort((a, b) => b.olusturma.compareTo(a.olusturma));
    return liste;
  }

  /// Tüm istekler (kaldırılanlar dahil) — istatistikler için.
  static List<DuaIstegi> tumIstekler() =>
      List.unmodifiable(_istekler);

  static Future<void> _kaydet() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(
      _anahtarIstekler,
      jsonEncode([for (final i in _istekler) i.toJson()]),
    );
  }

  /// Süresi dolmuş istekleri temizler (otomatik silme).
  static void eskiyenleriTemizle() {
    final once = _istekler.length;
    _istekler.removeWhere((i) => i.suresiDoldu && !i.benim);
    if (_istekler.length != once) {
      surum.value++;
      _kaydet();
    }
  }

  /// "Amin" sayar. Cihaz başına tek Amin; aynı isteğe ikinci kez basılırsa
  /// geri alır (toggle).
  static Future<void> aminVer(String id) async {
    final idx = _istekler.indexWhere((i) => i.id == id);
    if (idx < 0) return;
    final mevcut = _istekler[idx];
    final zatenVerdim = mevcut.benAminVerdim;
    final yeni = mevcut.kopyala(
      benAminVerdim: !zatenVerdim,
      aminSayisi: mevcut.aminSayisi + (zatenVerdim ? -1 : 1),
    );
    _istekler[idx] = yeni;
    surum.value++;
    await _kaydet();
  }

  /// Şikâyet eder; cihaz başına tek şikâyet. 3 farklı kullanıcı şikâyet
  /// ederse kart otomatik kaldırılır.
  static Future<bool> sikayetEt(String id) async {
    final idx = _istekler.indexWhere((i) => i.id == id);
    if (idx < 0) return false;
    final mevcut = _istekler[idx];
    if (mevcut.benSikayetEttim) return mevcut.kaldirildi;

    final yeniSikayet = mevcut.sikayetSayisi + 1;
    final kaldir = yeniSikayet >= 3;
    _istekler[idx] = mevcut.kopyala(
      benSikayetEttim: true,
      sikayetSayisi: yeniSikayet,
      kaldirildi: kaldir,
    );
    surum.value++;
    await _kaydet();
    return kaldir;
  }

  /// Yeni dua isteği oluşturur.
  static Future<DuaIstegi> istekEkle({
    required String kategori,
    required String metin,
    required bool anonim,
    required int sureSaat,
  }) async {
    final p = await SharedPreferences.getInstance();
    final isim = anonim ? '' : (p.getString('profil_isim') ?? '');
    final istek = DuaIstegi(
      id: 'k_${DateTime.now().millisecondsSinceEpoch}',
      kategori: kategori,
      metin: metin.trim(),
      isim: isim,
      olusturma: DateTime.now(),
      sureSaat: sureSaat,
      benim: true,
    );
    _istekler.insert(0, istek);
    surum.value++;
    await _kaydet();
    return istek;
  }

  /// Verilen toplam "Amin" sayısı (verilen dualar).
  static int toplamAmin() {
    var toplam = 0;
    for (final i in _istekler) {
      if (i.benAminVerdim) toplam++;
    }
    return toplam;
  }

  static int toplamIstek() =>
      _istekler.where((i) => i.benim).length;

  static int aktifIstekSayisi() => aktifAkis().length;

  /// Kazanılan rozetler.
  static List<Rozet> kazanilanRozetler() {
    final amin = toplamAmin();
    final istek = toplamIstek();
    return [
      for (final r in rozetler)
        if ((r.aminTuru ? amin : istek) >= r.esik) r,
    ];
  }

  // ----------------------- ÖRNEK GLOBAL AKIŞ -----------------------

  static List<DuaIstegi> _ornekAkis() {
    final now = DateTime.now();
    DuaIstegi o(
      String id,
      String kategori,
      String metin,
      String isim,
      String bayrak,
      String ulke,
      int saatOnce,
      int sure,
      int amin,
    ) =>
        DuaIstegi(
          id: id,
          kategori: kategori,
          metin: metin,
          isim: isim,
          ulkeEmoji: bayrak,
          ulkeAdi: ulke,
          olusturma: now.subtract(Duration(hours: saatOnce)),
          sureSaat: sure,
          aminSayisi: amin,
        );

    return [
      o('ornek_1', 'Şifa',
          'Anneciğimin kemoterapisi pazartesi başlıyor. Dualarınızı bekliyorum.',
          'Ahmet', '🇹🇷', 'Türkiye', 2, 72, 214),
      o('ornek_2', 'Sınav / Eğitim',
          'Tıp fakültesi son sınıf sınavı için güç ve kolaylık diliyorum.',
          'Fatimah', '🇲🇾', 'Malezya', 4, 24, 158),
      o('ornek_3', 'Ahiret / Maneviyat',
          'Nur Cemaati mensubu babamız bu gece vefat etti. İmanı ve kabri için dua edin.',
          'Amina', '🇮🇩', 'Endonezya', 1, 168, 612),
      o('ornek_4', 'Borç / Sıkıntı',
          'İşimi kaybettim, kira ödeyemiyorum. Rızık ve ferahlık için dua eder misiniz?',
          '', '🇪🇬', 'Mısır', 6, 72, 389),
      o('ornek_5', 'Ailevi Durum',
          'Kardeşimle aramız açıldı. Kalplerimizi birleştirmesi için dua edin.',
          'Yusuf', '🇲🇦', 'Fas', 9, 24, 96),
      o('ornek_6', 'Şifa',
          'Görme engelli kızım için sabır ve şifa dilerim.',
          'Zainab', '🇳🇬', 'Nijerya', 12, 168, 173),
      o('ornek_7', 'Borç / Sıkıntı',
          'Açtığım dükkan kapanmak üzere. Helal rızık ve bereket için dua edin.',
          '', '🇵🇰', 'Pakistan', 20, 72, 247),
      o('ornek_8', 'Sınav / Eğitim',
          'ALES sonucum açıklandı; doktora için hayırlısıyla kabul dilerim.',
          'Elif', '🇩🇪', 'Almanya', 26, 24, 84),
      o('ornek_9', 'Ahiret / Maneviyat',
          'Nafile oruç ve teheccüde devam etmek istiyorum; sebat için dua edin.',
          'Bilal', '🇬🇧', 'İngiltere', 40, 24, 61),
    ];
  }
}
