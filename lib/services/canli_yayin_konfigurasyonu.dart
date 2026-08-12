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
//     { "ad": "...", "url": "..." }
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

/// Radyo / podcast akışı.
class RadyoKanali {
  final String ad;
  final String aciklama;
  final String url;

  const RadyoKanali({
    required this.ad,
    required this.aciklama,
    required this.url,
  });

  factory RadyoKanali.json(Map<String, dynamic> j) => RadyoKanali(
    ad: j['ad'] as String? ?? 'Radyo',
    aciklama: j['aciklama'] as String? ?? '',
    url: j['url'] as String? ?? '',
  );
}

class CanliYayinKonfig {
  final int surum;
  final String guncellenme;
  final String kaynakAdi; // Yayının görünen adı (ör. "Saudi Kuran TV")
  final String youtubeVideoId;
  final List<CanliYayinKaynak> hlsKaynaklar;
  final String? sesUrl;
  final List<RadyoKanali> radyoKanallari;

  const CanliYayinKonfig({
    this.surum = 1,
    this.guncellenme = '',
    this.kaynakAdi = 'Saudi Kuran TV (Resmî)',
    this.youtubeVideoId = '',
    this.hlsKaynaklar = const [],
    this.sesUrl,
    this.radyoKanallari = const [],
  });

  factory CanliYayinKonfig.varsayilan() {
    // -----------------------------------------------------------------------
    // GÖMME (HARDCODE) NOTU: Aşağıdaki liste YALNIZCA çevrimdışı/önbelleksiz
    // durumda kullanılacak "son çare" varsayılandır. Asıl yönetim, Remote
    // Config benzeri uzak JSON üzerinden yapılır: kaynak değiştiğinde
    // configUrl adresindeki JSON güncellenir, uygulama güncellemesi gerekmez.
    // -----------------------------------------------------------------------
    return const CanliYayinKonfig(
      surum: 1,
      guncellenme: 'Son çare (gömülü)',
      kaynakAdi: 'Saudi Kuran TV (Resmî)',
      // Resmî YouTube canlı yayın ID'si: uygulama güncellenmeden değiştirilebilir.
      youtubeVideoId: '24JXS383N1c',
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
      ],
      sesUrl: 'http://m.live.net.sa:1935/live/quran/playlist.m3u8',
      radyoKanallari: [
        RadyoKanali(
          ad: 'Kur\'an Radyosu (Mekke)',
          aciklama: 'Resmî Suudi Kuran radyo yayını - 7/24 tilavet',
          url: 'http://m.live.net.sa:1935/live/quran/playlist.m3u8',
        ),
        RadyoKanali(
          ad: 'Sünnet Radyosu (Medine)',
          aciklama: 'Resmî Suudi Sünnet radyo yayını - Mescid-i Nebevî',
          url: 'http://m.live.net.sa:1935/live/sunnah/playlist.m3u8',
        ),
        RadyoKanali(
          ad: 'Kuran FM (Tilavet)',
          aciklama: 'Kesintisiz Kur\'an sesli dinleme için yedek akış',
          url:
              'https://cdn-globecast.akamaized.net/live/eds/saudi_quran/hls_roku/index.m3u8',
        ),
      ],
    );
  }

  factory CanliYayinKonfig.json(Map<String, dynamic> j) {
    final kabeyayini = j['kabeyayini'] as Map<String, dynamic>? ?? {};
    return CanliYayinKonfig(
      surum: j['surum'] as int? ?? 1,
      guncellenme: j['guncellenme'] as String? ?? '',
      kaynakAdi: kabeyayini['kaynakAdi'] as String? ?? 'Saudi Kuran TV (Resmî)',
      youtubeVideoId: kabeyayini['youtubeVideoId'] as String? ?? '',
      hlsKaynaklar: [
        for (final k in (kabeyayini['hlsKaynaklar'] as List? ?? []))
          if (k is Map<String, dynamic>) CanliYayinKaynak.json(k),
      ],
      sesUrl: kabeyayini['sesUrl'] as String?,
      radyoKanallari: [
        for (final k in (j['radyoKanallari'] as List? ?? []))
          if (k is Map<String, dynamic>) RadyoKanali.json(k),
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