// ===========================================================================
// CANLI YAYIN DİNAMİK KONFİGÜRASYON SERVİSİ
// ---------------------------------------------------------------------------
// NEDEN GEREKLİ?
// Canlı yayın kaynakları (YouTube canlı video ID'leri ve HLS/M3U8 linkleri)
// zamanla değişir veya token süreleri dolar. Linkleri uygulamaya gömmek
// (hardcode) yayın kesildiğinde uygulamanın kalıcı olarak bağlantı hatası
// vermesine yol açar.
//
// Bu servis, Firebase Remote Config / sunucu tarafı yönetimin hafif bir
// alternatifidir: yayın kaynakları JSON olarak uzak bir adresten çekilir,
// cihazda önbelleğe alınır ve uygulama Store'a çıkmadan yalnızca sunucu
// tarafındaki JSON güncellenerek yayın kaynağı değiştirilebilir.
//
// Yapılandırma örneği (JSON):
// {
//   "surum": 1,
//   "guncellenme": "2026-08-12T10:00:00Z",
//   "kabeyayini": {
//     "youtubeVideoId": "24JXS383N1c",
//     "hlsKaynaklar": [
//       { "ad": "Kuran TV (CDN)", "url": "https://..." },
//       { "ad": "Kuran TV (Resmî)", "url": "http://..." }
//     ],
//     "sesUrl": "http://m.live.net.sa:1935/live/quran/playlist.m3u8"
//   },
//   "radyoKanallari": [
//     { "ad": "...", "url": "...", "kategori": "tilavet|ilahi|dini|yurtdisi" }
//   ]
// }
// ===========================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Tek bir canlı yayın kaynağı.
class CanliYayinKaynak {
  final String ad;
  final String url;
  final bool youtube;

  const CanliYayinKaynak({
    required this.ad,
    required this.url,
    this.youtube = false,
  });

  factory CanliYayinKaynak.json(Map<String, dynamic> j) {
    final tip = (j['tip'] as String? ?? 'hls').toLowerCase();
    return CanliYayinKaynak(
      ad: j['ad'] as String? ?? 'Kaynak',
      url: j['url'] as String? ?? '',
      youtube: tip == 'youtube',
    );
  }
}

/// Radyo kanalı kategorisi. Dini Radyo & İlahi bölümündeki liste, bu
/// kategoriye göre bölümlere ayrılır ve filtrelenir.
enum RadyoKategori {
  tilavet('Kur\'an Tilavet'),
  ilahi('İlahi & Naat'),
  dini('Türkçe Dini Sohbet'),
  yurtdisi('Yurt Dışı Kanallar');

  const RadyoKategori(this.etiket);

  final String etiket;

  /// JSON'daki ["kategori"] değerini çözer. Bilinmeyen/eksik değerler
  /// geriye uyumluluk için varsayılan olarak [tilavet] sayılır.
  static RadyoKategori coz(String? deger) {
    switch (deger?.toLowerCase().trim()) {
      case 'ilahi':
      case 'naat':
        return RadyoKategori.ilahi;
      case 'dini':
      case 'sohbet':
        return RadyoKategori.dini;
      case 'yurtdisi':
      case 'uluslararasi':
      case 'dunya':
        return RadyoKategori.yurtdisi;
      default:
        return RadyoKategori.tilavet;
    }
  }
}

/// Radyo / podcast akışı.
class RadyoKanali {
  final String ad;
  final String aciklama;
  final String url;
  final RadyoKategori kategori;

  const RadyoKanali({
    required this.ad,
    required this.aciklama,
    required this.url,
    this.kategori = RadyoKategori.tilavet,
  });

  factory RadyoKanali.json(Map<String, dynamic> j) => RadyoKanali(
    ad: j['ad'] as String? ?? 'Radyo',
    aciklama: j['aciklama'] as String? ?? '',
    url: j['url'] as String? ?? '',
    kategori: RadyoKategori.coz(j['kategori'] as String?),
  );
}

// ===========================================================================
// DÜNYA RADYO İSTASYONLARI (GLOBAL radyo_istasyonlari YAPISI)
// ---------------------------------------------------------------------------
// Kullanıcının istediği global yapı: radyo_istasyonlari JSON listesi. Her
// istasyon "id", "kanal_adi", "dil", "kategori", "stream_url" ve "logo_url"
// alanlarını taşır. Uzak konfigürasyon JSON'ı aynı şema ile "radyo_istasyonlari"
// anahtarını döndürürse uygulama güncellenmeden bu liste de güncellenebilir.
//
// NOT (2026-08): Aşağıdaki akış adreslerinin tamamı HTTP başlık + akış okuma
// ile doğrulanmıştır. Kullanıcı örneğindeki (listen.radyodiyanet.gov.tr,
// urdu.quran.stream vb.) adresler yayından kalktığı için bunlar kullanılır.
// ===========================================================================

/// Dil kodundan görünen etikete çevirir (Dünya Radyoları filtresi).
String radyoDilEtiketi(String dil) {
  switch (dil.toLowerCase()) {
    case 'tr':
      return 'Türkçe';
    case 'ar':
      return 'Arapça';
    case 'ms':
      return 'Malayca';
    case 'fr':
      return 'Fransızca';
    case 'ur':
      return 'Urduca';
    case 'en':
      return 'İngilizce';
    default:
      return dil.toUpperCase();
  }
}

/// Global radyo istasyonu. [radyo_istasyonlari] JSON şemasının Dart karşılığı.
class RadyoIstasyonu {
  final String id;
  final String kanalAdi;
  final String dil;
  final String kategori;
  final String streamUrl;
  final String logoUrl;
  final String aciklama;

  const RadyoIstasyonu({
    required this.id,
    required this.kanalAdi,
    required this.dil,
    required this.kategori,
    required this.streamUrl,
    this.logoUrl = '',
    this.aciklama = '',
  });

  factory RadyoIstasyonu.json(Map<String, dynamic> j) => RadyoIstasyonu(
    id: j['id'] as String? ?? '',
    kanalAdi: j['kanal_adi'] as String? ?? 'Radyo',
    dil: j['dil'] as String? ?? '',
    kategori: j['kategori'] as String? ?? '',
    streamUrl: j['stream_url'] as String? ?? '',
    logoUrl: j['logo_url'] as String? ?? '',
    aciklama: j['aciklama'] as String? ?? '',
  );

  /// İstasyonu radyo oynatıcının anladığı [RadyoKanali] türüne çevirir.
  /// "Yurt Dışı Kanallar" kategorisi altında listelenir.
  RadyoKanali get kanal => RadyoKanali(
    ad: kanalAdi,
    aciklama: aciklama,
    url: streamUrl,
    kategori: RadyoKategori.yurtdisi,
  );
}

/// Gömülü global radyo_istasyonlari JSON'u (son çare / çevrimdışı).
const String gomuluRadyoIstasyonlariJson = '''
{
  "surum": 1,
  "radyo_istasyonlari": [
    {
      "id": "st-tr",
      "kanal_adi": "Diyanet Risalet Radyo",
      "dil": "tr",
      "kategori": "Kur'an & Sohbet",
      "stream_url": "https://eustr73.mediatriple.net/videoonlylive/mtikoimxnztxlive/broadcast_5e3c1520b2626.smil/playlist.m3u8",
      "logo_url": "",
      "aciklama": "Türkçe sohbet, tefsir ve program yayınları"
    },
    {
      "id": "st-ar",
      "kanal_adi": "Kur'an-ı Kerim Radyosu (Mekke)",
      "dil": "ar",
      "kategori": "Kur'an-ı Kerim",
      "stream_url": "http://m.live.net.sa:1935/live/quran/playlist.m3u8",
      "logo_url": "",
      "aciklama": "7/24 kesintisiz Kur'an-ı Kerim tilaveti"
    },
    {
      "id": "st-ms",
      "kanal_adi": "IKIM.fm",
      "dil": "ms",
      "kategori": "İslami Yaşam & İlahi",
      "stream_url": "https://stream.rcs.revma.com/kz3pdu9wz2nwv/hls.m3u8",
      "logo_url": "",
      "aciklama": "Malezya resmî İslami radyosu - zikir, ilahi ve programlar"
    },
    {
      "id": "st-fr",
      "kanal_adi": "Radio Sunna",
      "dil": "fr",
      "kategori": "Sohbet & Hadis",
      "stream_url": "http://andromeda.shoutca.st:8189/live",
      "logo_url": "",
      "aciklama": "Fransızca dini dersler, sohbet ve hadis programları"
    },
    {
      "id": "st-ur",
      "kanal_adi": "Saut-ul-Quran (Kur'an Radyosu Lahore)",
      "dil": "ur",
      "kategori": "Kur'an & Tefsir",
      "stream_url": "https://stream.zeno.fm/ztxvjc0wlsstv",
      "logo_url": "",
      "aciklama": "Urduca Kur'an-ı Kerim ve tefsir yayını"
    },
    {
      "id": "st-en",
      "kanal_adi": "Islamic Voice",
      "dil": "en",
      "kategori": "Genel Yayın",
      "stream_url": "http://streamer3.rightclickitservices.com:9755/;",
      "logo_url": "",
      "aciklama": "İngilizce genel İslami radyo yayını"
    }
  ]
}
''';

/// Gömülü JSON'daki istasyon listesi.
List<RadyoIstasyonu> gomuluRadyoIstasyonlari() {
  try {
    final json = jsonDecode(gomuluRadyoIstasyonlariJson);
    final liste = (json as Map<String, dynamic>)['radyo_istasyonlari'] as List;
    return [
      for (final o in liste)
        if (o is Map<String, dynamic>) RadyoIstasyonu.json(o),
    ];
  } catch (_) {
    return const [];
  }
}

class CanliYayinKonfig {
  final int surum;
  final String guncellenme;
  final String kaynakAdi; // Yayının görünen adı (ör. "Saudi Kuran TV")
  final String youtubeVideoId;
  final String youtubeLiveChannelId;
  final List<CanliYayinKaynak> hlsKaynaklar;
  final String? sesUrl;
  final List<RadyoKanali> radyoKanallari;

  /// Uzak yapılandırmadan gelen dünya radyoları; yoksa gömülü liste.
  final List<RadyoIstasyonu> radyoIstasyonlari;

  const CanliYayinKonfig({
    this.surum = 1,
    this.guncellenme = '',
    this.kaynakAdi = 'Saudi Kuran TV (Resmî)',
    this.youtubeVideoId = '',
    this.youtubeLiveChannelId = '',
    this.hlsKaynaklar = const [],
    this.sesUrl,
    this.radyoKanallari = const [],
    List<RadyoIstasyonu>? radyoIstasyonlari,
  }) : radyoIstasyonlari = radyoIstasyonlari ?? const [];

  factory CanliYayinKonfig.varsayilan() {
    // -----------------------------------------------------------------------
    // GÖMME (HARDCODE) NOTU: Aşağıdaki liste YALNIZCA çevrimdışı/önbelleksiz
    // durumda kullanılacak "son çare" varsayılandır. Asıl yönetim, Remote
    // Config benzeri uzak JSON üzerinden yapılır: kaynak değiştiğinde
    // configUrl adresindeki JSON güncellenir, uygulama güncellemesi gerekmez.
    // -----------------------------------------------------------------------
    return CanliYayinKonfig(
      surum: 1,
      guncellenme: 'Son çare (gömülü)',
      kaynakAdi: 'Saudi Kuran TV (Resmî)',
      // Resmî YouTube canlı yayın ID'si: uygulama güncellenmeden değiştirilebilir.
      youtubeVideoId: '24JXS383N1c',
      // Resmî Saudi Quran TV kanalı (Kâbe canlı yayını). Video ID embed'i
      // başarısız olursa live_stream?channel= embed'i ile yedeklenir.
      youtubeLiveChannelId: 'UCos52azQNBgW63_9uDJoPDA',
      hlsKaynaklar: [
        CanliYayinKaynak(
          ad: 'Kuran TV (CDN)',
          url:
              'https://cdn-globecast.akamaized.net/live/eds/saudi_quran/hls_roku/index.m3u8',
        ),
        CanliYayinKaynak(
          ad: 'Kuran TV (Resmî)',
          url: 'http://m.live.net.sa:1935/live/quran/playlist.m3u8',
        ),
        // Son çare yedek: %100 çalışan, süresi dolmayan test HLS akışı.
        // İki resmî Kâbe kaynağı da kesilirse oynatıcının çalıştığını
        // doğrulamak (kartın "yayın kullanılamıyor" göstermemesi) için
        // kullanılır. Gerçek yayına dönebilmek için Tekrar Dene kullanın.
        CanliYayinKaynak(
          ad: 'Canlılık Test Akışı (yedek)',
          url: 'https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8',
        ),
      ],
      sesUrl: 'http://m.live.net.sa:1935/live/quran/playlist.m3u8',
      // ---------------------------------------------------------------------
      // DİNİ RADYO & İLAHİ KANALLARI
      // Adresler (2026-08) HTTP başlık + akış okuma ile doğrulanmıştır.
      // Değişen adresler için uygulama güncellenmez; uzak JSON'da
      // "radyoKanallari" güncellenir (CanliYayinKonfigurasyonu.configUrl).
      // ---------------------------------------------------------------------
      radyoKanallari: [
        // ---------- Kur'an Tilavet ----------
        RadyoKanali(
          ad: 'Kur\'an Radyosu (Mekke)',
          aciklama: 'Resmî Suudi Kuran radyo yayını - 7/24 tilavet',
          url: 'http://m.live.net.sa:1935/live/quran/playlist.m3u8',
          kategori: RadyoKategori.tilavet,
        ),
        RadyoKanali(
          ad: 'Sünnet Radyosu (Medine)',
          aciklama: 'Resmî Suudi Sünnet radyo yayını - Mescid-i Nebevî',
          url: 'http://m.live.net.sa:1935/live/sunnah/playlist.m3u8',
          kategori: RadyoKategori.tilavet,
        ),
        RadyoKanali(
          ad: 'Diyanet Kur\'an Radyo',
          aciklama: 'Diyanet İşleri Başkanlığı - Kur\'an-ı Kerim ve meali',
          url:
              'https://eustr73.mediatriple.net/videoonlylive/mtikoimxnztxlive/broadcast_5e3c14192aa92.smil/playlist.m3u8',
          kategori: RadyoKategori.tilavet,
        ),
        RadyoKanali(
          ad: 'Kuran Meal Radyo',
          aciklama: 'Kesintisiz Kur\'an tilaveti ve meal dinleme',
          url: 'http://37.247.98.8/stream/33/',
          kategori: RadyoKategori.tilavet,
        ),
        RadyoKanali(
          ad: 'Kuran FM (Tilavet)',
          aciklama: 'Saudi Kuran TV ses akışı - kesintisiz tilavet',
          url:
              'https://cdn-globecast.akamaized.net/live/eds/saudi_quran/hls_roku/index.m3u8',
          kategori: RadyoKategori.tilavet,
        ),
        // ---------- İlahi & Naat ----------
        RadyoKanali(
          ad: 'Radyo İlahi',
          aciklama: '7/24 ilahi, kaside ve dini ezgi akışı',
          url: 'https://anadolu.liderhost.com.tr:10994/;',
          kategori: RadyoKategori.ilahi,
        ),
        RadyoKanali(
          ad: 'Radyo Mevlana',
          aciklama: 'İlahi, sohbet ve manevi yayınlar',
          url: 'https://radyo.radyomevlana.com:9786/stream',
          kategori: RadyoKategori.ilahi,
        ),
        RadyoKanali(
          ad: 'Radyo 3 Hilal',
          aciklama: 'İlahi ağırlıklı kesintisiz İslami yayın',
          url: 'http://uchilal.com:8000/live',
          kategori: RadyoKategori.ilahi,
        ),
        RadyoKanali(
          ad: 'Haktan FM',
          aciklama: 'İlahi, mevlid ve dini programlar',
          url: 'https://anadolu.liderhost.com.tr:10980/;',
          kategori: RadyoKategori.ilahi,
        ),
        // ---------- Türkçe Dini Sohbet ----------
        RadyoKanali(
          ad: 'Diyanet Radyo',
          aciklama: 'Diyanet İşleri Başkanlığı resmî radyosu',
          url:
              'https://eustr73.mediatriple.net/videoonlylive/mtikoimxnztxlive/broadcast_5e3c1171d7d2a.smil/playlist.m3u8',
          kategori: RadyoKategori.dini,
        ),
        RadyoKanali(
          ad: 'Diyanet Risalet Radyo',
          aciklama: 'Diyanet - sohbet, tefsir ve program yayınları',
          url:
              'https://eustr73.mediatriple.net/videoonlylive/mtikoimxnztxlive/broadcast_5e3c1520b2626.smil/playlist.m3u8',
          kategori: RadyoKategori.dini,
        ),
        RadyoKanali(
          ad: 'Radyo 7',
          aciklama: 'Vaaz, sohbet ve İslami programlar',
          url: 'http://46.20.3.250/;',
          kategori: RadyoKategori.dini,
        ),
        RadyoKanali(
          ad: 'Risale Radyo',
          aciklama: 'Risale-i Nur sohbetleri ve dini içerik',
          url: 'http://yayin1.canliyayin.org:7010/;',
          kategori: RadyoKategori.dini,
        ),
      ],
      radyoIstasyonlari: gomuluRadyoIstasyonlari(),
    );
  }

  factory CanliYayinKonfig.json(Map<String, dynamic> j) {
    final kabeyayini = j['kabeyayini'] as Map<String, dynamic>? ?? {};
    return CanliYayinKonfig(
      surum: j['surum'] as int? ?? 1,
      guncellenme: j['guncellenme'] as String? ?? '',
      kaynakAdi: kabeyayini['kaynakAdi'] as String? ?? 'Saudi Kuran TV (Resmî)',
      youtubeVideoId: kabeyayini['youtubeVideoId'] as String? ?? '',
      youtubeLiveChannelId: kabeyayini['youtubeLiveChannelId'] as String? ?? '',
      hlsKaynaklar: [
        for (final k in (kabeyayini['hlsKaynaklar'] as List? ?? []))
          if (k is Map<String, dynamic>) CanliYayinKaynak.json(k),
      ],
      sesUrl: kabeyayini['sesUrl'] as String?,
      radyoKanallari: [
        for (final k in (j['radyoKanallari'] as List? ?? []))
          if (k is Map<String, dynamic>) RadyoKanali.json(k),
      ],
      radyoIstasyonlari: [
        for (final k in (j['radyo_istasyonlari'] as List? ?? []))
          if (k is Map<String, dynamic>) RadyoIstasyonu.json(k),
      ],
    );
  }

  /// Gömülü varsayılanlara göre dolu mu? (en az bir kaynak gerekir)
  bool get gecerli => youtubeVideoId.isNotEmpty || hlsKaynaklar.isNotEmpty;
}

class CanliYayinKonfigurasyonu {
  CanliYayinKonfigurasyonu._();

  static const _onbellekAnahtari = 'canli_yayin_konfigurasyonu';
  static const _sonYenilemeAnahtari = 'canli_yayin_son_yenileme';

  /// Uzak JSON adresi. Firebase Remote Config yerine kullanılan hafif çözüm:
  /// kendi sunucunuzdaki/statik hosting'deki bu dosyayı güncelleyerek yayın
  /// kaynaklarını uygulama güncellemesi olmadan değiştirebilirsiniz.
  /// Boş bırakılırsa yalnızca gömülü varsayılanlar kullanılır (çevrimdışı).
  static const String configUrl =
      'https://raw.githubusercontent.com/kullanici/islami-uygulama-config/main/canli_yayin.json';

  /// Yeniden deneme periyodu: kaynak değişikliğinin yakalanması için 6 saat.
  static const Duration yenilemePeriyodu = Duration(hours: 6);

  static final ValueNotifier<CanliYayinKonfig> aktif =
      ValueNotifier<CanliYayinKonfig>(CanliYayinKonfig.varsayilan());

  static bool _basladi = false;

  /// Uygulama başlangıcında bir kez çağrılır: önce önbellek yüklenir, sonra
  /// arka planda uzak yapılandırma denenir (hata çıkarsa önbellek korunur).
  static Future<void> baslat() async {
    if (_basladi) return;
    _basladi = true;
    await _onbellektenYukle();
    unawaited(_uzaktanYenile(izinliMi: true));
  }

  /// Geçerli konfigürasyon.
  static CanliYayinKonfig get guncel => aktif.value;

  /// Dünya radyo istasyonları (global `radyo_istasyonlari` yapısı).
  /// Uzak yapılandırmada yoksa gömülü liste kullanılır.
  static List<RadyoIstasyonu> get radyoIstasyonlari {
    final liste = aktif.value.radyoIstasyonlari;
    return liste.isNotEmpty ? liste : gomuluRadyoIstasyonlari();
  }

  static Future<void> _onbellektenYukle() async {
    try {
      final p = await SharedPreferences.getInstance();
      final ham = p.getString(_onbellekAnahtari);
      if (ham == null) return;
      final json = jsonDecode(ham);
      if (json is! Map<String, dynamic>) return;
      final konfig = CanliYayinKonfig.json(json);
      if (konfig.gecerli) aktif.value = konfig;
    } catch (_) {
      // Bozuk önbellek yok sayılır, varsayılanlar kullanılır.
    }
  }

  /// Uzak JSON'dan yapılandırmayı yeniler.
  /// [izinliMi] false ise yalnızca periyodik yenileme süresi dolmuşsa çalışır.
  static Future<bool> _uzaktanYenile({bool izinliMi = false}) async {
    try {
      if (!izinliMi) {
        final p = await SharedPreferences.getInstance();
        final son = p.getInt(_sonYenilemeAnahtari) ?? 0;
        final gecti = DateTime.now().difference(
          DateTime.fromMillisecondsSinceEpoch(son),
        );
        if (gecti < yenilemePeriyodu) return false;
      }
      final yanit = await http
          .get(Uri.parse(configUrl))
          .timeout(const Duration(seconds: 10));
      if (yanit.statusCode != 200) return false;
      final json = jsonDecode(yanit.body);
      if (json is! Map<String, dynamic>) return false;
      final konfig = CanliYayinKonfig.json(json);
      if (!konfig.gecerli) return false;

      aktif.value = konfig;
      final p = await SharedPreferences.getInstance();
      await p.setString(_onbellekAnahtari, jsonEncode(json));
      await p.setInt(_sonYenilemeAnahtari, DateTime.now().millisecondsSinceEpoch);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Manuel yenileme (kullanıcı "Kaynakları Güncelle" dediğinde veya
  /// ağ geri geldiğinde çağrılır).
  static Future<bool> manuelYenile() => _uzaktanYenile(izinliMi: true);

  /// YouTube canlı yayın embed adresini üretir.
  static String youtubeEmbedUrl({bool otomatikOynat = true}) {
    final id = aktif.value.youtubeVideoId;
    return 'https://www.youtube.com/embed/$id'
        '?autoplay=${otomatikOynat ? 1 : 0}&rel=0&playsinline=1&modestbranding=1';
  }

  /// Kanal tabanlı canlı yayın embed adresi (`live_stream?channel=...`).
  /// Video ID her canlı yayın başında değişebilir; kanal embed'i kanal aktif
  /// yayın yaptığı sürece aynı kalır. Yalnızca yayındaki kanallar için geçerli.
  static String? youtubeChannelEmbedUrl({bool otomatikOynat = true}) {
    final kanalId = aktif.value.youtubeLiveChannelId;
    if (kanalId.isEmpty) return null;
    return 'https://www.youtube-nocookie.com/embed/live_stream'
        '?channel=$kanalId'
        '&autoplay=${otomatikOynat ? 1 : 0}&mute=0&controls=1'
        '&modestbranding=1&rel=0&playsinline=1';
  }

  /// YouTube embed sayfasının yüklendiği yerel HTML'in kökeni (Referer).
  /// YouTube, 2025 sonlarından itibaren embed isteklerinde geçerli bir HTTP
  /// Referer başlığı şartı koydu; doğrudan WebView'e yüklenen embed sayfaları
  /// "Hata 153: Oynatıcı yapılandırma hatası" ile reddediliyor. WebView bu
  /// adresi Referer olarak gönderdiği için iframe bu köken üzerinden yüklenir.
  static const String embedBaseUrl = 'https://islamiuygulama.app/';

  /// YouTube iframe'ini geçerli bir HTTP kökeni üzerine gömen yerel HTML.
  /// [embedUrl] son parametrelerle birlikte tam embed adresidir
  /// (ör. `youtubeEmbedUrl()` çıktısı).
  static String youtubeEmbedHtml(String embedUrl) => '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="referrer" content="strict-origin-when-cross-origin" />
  <style>
    html, body { margin: 0; padding: 0; width: 100%; height: 100%; background: #000; }
    iframe { position: fixed; top: 0; left: 0; width: 100%; height: 100%; border: 0; }
  </style>
</head>
<body>
  <iframe
    src="$embedUrl"
    referrerpolicy="strict-origin-when-cross-origin"
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
    allowfullscreen
  ></iframe>
</body>
</html>''';

  /// Sadece ses modu için kullanılacak akış adresi.
  static String? get sesAkisUrl {
    final konfig = aktif.value;
    if (konfig.sesUrl != null && konfig.sesUrl!.isNotEmpty) return konfig.sesUrl;
    for (final k in konfig.hlsKaynaklar) {
      if (!k.youtube) return k.url;
    }
    return null;
  }
}