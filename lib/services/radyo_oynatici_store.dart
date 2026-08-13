// ===========================================================================
// RADYO OYNATICI DEPOSU - Uygulama genelinde tek canlı radyo oynatıcı
// ---------------------------------------------------------------------------
// Dini Radyo & İlahi bölümünün deneyimi için kullanıcı kontrollü, kalıcı bir
// oynatıcı sağlar:
//   • Tek global AudioPlayer (just_audio): kullanıcı radyo dinlerken başka
//     sayfalara geçse bile yayın kesintisiz devam eder.
//   • Kullanıcı kontrolleri: çal/durdur, duraklat, durdur, ses seviyesi,
//     favori kanallar, uyku zamanlayıcısı, önceki/sonraki kanal.
//   • Tüm durum ValueNotifier ile arayüze bildirilir; kalıcı veriler
//     (favoriler, ses seviyesi, uyku tercihi) SharedPreferences'ta saklanır.
// ===========================================================================

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'canli_yayin_konfigurasyonu.dart';

/// Yayın sunucuları (özellikle Zeno FM) tarayıcı olmayan varsayılan
/// User-Agent'lı istekleri reddedebilir; bu yüzden istemciler gerçek bir
/// istemci kimliği gönderilir.
const String _radyoUserAgent =
    'Mozilla/5.0 (Linux; Android 14) islami_uygulama/1.0';

/// Global radyo oynatıcı deposu. Tek just_audio [AudioPlayer] örneğini yönetir.
class RadyoOynaticiStore {
  RadyoOynaticiStore._();

  static const _kFavoriler = 'radyo_favori_kanallar';
  static const _kSes = 'radyo_ses_seviyesi';
  static const _kUykuDk = 'radyo_uyku_zamanlayici_dk';

  /// Oynatıcının tek örneği. Uygulama ömrü boyunca yaşar.
  static final AudioPlayer player = AudioPlayer(userAgent: _radyoUserAgent);

  /// Şu an çalan kanal; null = çalmıyor.
  static final ValueNotifier<RadyoKanali?> calanKanal =
      ValueNotifier<RadyoKanali?>(null);

  /// Oynatıcı oynatıyor mu (duraklatılmış değil).
  static final ValueNotifier<bool> calyor = ValueNotifier<bool>(false);

  /// Akış bağlanırken/yüklenirken true.
  static final ValueNotifier<bool> yukleniyor = ValueNotifier<bool>(false);

  /// Son oynatma hatası (varsa).
  static final ValueNotifier<String?> hata = ValueNotifier<String?>(null);

  /// Ses seviyesi (0-100).
  static final ValueNotifier<int> ses = ValueNotifier<int>(100);

  /// Favori kanal URL'leri.
  static final ValueNotifier<Set<String>> favoriler =
      ValueNotifier<Set<String>>({});

  /// Uyku zamanlayıcısı seçimi (dakika); null = kapalı.
  static final ValueNotifier<int?> uykuDk = ValueNotifier<int?>(null);

  /// Aktif uyku sayacının kalan dakikası; null = sayaç yok.
  static final ValueNotifier<int?> uykuKalanDk = ValueNotifier<int?>(null);

  static Timer? _uykuSayaci;
  static bool _basladi = false;

  /// Ayrı kanal listesi yoksa önceki/sonraki gezinme için kullanılacak liste.
  static List<RadyoKanali> kanalListesi = [];

  /// Oynatıcıyı başlatır (uygulama açılışında bir kez çağrılır).
  static Future<void> baslat({List<RadyoKanali>? kanallar}) async {
    if (_basladi) return;
    _basladi = true;
    if (kanallar != null) kanalListesi = kanallar;

    // Kalıcı tercihleri yükle.
    try {
      final p = await SharedPreferences.getInstance();
      ses.value = (p.getInt(_kSes) ?? 100).clamp(0, 100);
      favoriler.value = (p.getStringList(_kFavoriler) ?? []).toSet();
      uykuDk.value = p.getInt(_kUykuDk);
    } catch (_) {}

    // Durum dinleyicileri. just_audio'da tüm durum/hatalar akışlar üzerinden
    // gelir; dinleyiciler setSource'tan önce bağlanmalıdır (bu yüzden
    // başlatma burada yapılır).
    player.playingStream.listen((p) => calyor.value = p);
    player.processingStateStream.listen((durum) {
      if (durum == ProcessingState.idle ||
          durum == ProcessingState.completed) {
        yukleniyor.value = false;
      }
    }, onError: (Object e, StackTrace st) {});
    // Akış hataları (ölü bağlantı, sunucu reddi vb.) buradan yakalanır.
    player.playbackEventStream.listen(
      (_) {},
      onError: (Object e, StackTrace st) {
        if (calanKanal.value != null) {
          yukleniyor.value = false;
          calyor.value = false;
          hata.value =
              'Bu radyo akışına ulaşılamadı. Bağlantınızı kontrol edip tekrar deneyin.';
        }
      },
    );
  }

  /// Radyo kanalını oynatır. Aynı kanal çalıyorsa duraklatır.
  static Future<void> oynat(
    RadyoKanali kanal, {
    List<RadyoKanali>? kanallar,
  }) async {
    if (kanallar != null) kanalListesi = kanallar;
    if (calanKanal.value?.url == kanal.url) {
      if (calyor.value) {
        await player.pause();
      } else {
        await player.play();
      }
      calyor.value = player.playing;
      return;
    }
    hata.value = null;
    yukleniyor.value = true;
    try {
      await player.stop();
      await player.setVolume(ses.value / 100);
      // Canlı akış: parça sonu bilgisi gerekmediği için preload kapatılır.
      await player.setUrl(kanal.url, preload: false);
      calanKanal.value = kanal;
      await player.play();
      calyor.value = true;
      yukleniyor.value = false;
    } catch (_) {
      yukleniyor.value = false;
      calyor.value = false;
      hata.value =
          'Bu radyo akışına ulaşılamadı. Bağlantınızı kontrol edip tekrar deneyin.';
    }
  }

  /// Çalmayı tamamen durdurur (kanal seçimini temizler).
  static Future<void> durdur() async {
    await player.stop();
    calanKanal.value = null;
    calyor.value = false;
    yukleniyor.value = false;
    hata.value = null;
  }

  /// Sıradaki kanala geçer. Listenin sonundaysa başa döner.
  static Future<void> sonraki() async {
    if (kanalListesi.isEmpty || calanKanal.value == null) return;
    final i = kanalListesi.indexWhere(
      (k) => k.url == calanKanal.value!.url,
    );
    final siraki = kanalListesi[(i + 1) % kanalListesi.length];
    await oynat(siraki);
  }

  /// Önceki kanala geçer. Baştaysa sona döner.
  static Future<void> onceki() async {
    if (kanalListesi.isEmpty || calanKanal.value == null) return;
    final i = kanalListesi.indexWhere(
      (k) => k.url == calanKanal.value!.url,
    );
    final onceki = kanalListesi[(i - 1 + kanalListesi.length) %
        kanalListesi.length];
    await oynat(onceki);
  }

  /// Ses seviyesini (0-100) ayarlar ve kalıcı kaydeder.
  static Future<void> sesAyarla(int deger) async {
    final v = deger.clamp(0, 100);
    ses.value = v;
    try {
      await player.setVolume(v / 100);
      final p = await SharedPreferences.getInstance();
      await p.setInt(_kSes, v);
    } catch (_) {}
  }

  /// Kanal favori mi?
  static bool favoriMi(String url) => favoriler.value.contains(url);

  /// Favori ekler/kaldırır (kalıcı).
  static Future<void> favoriDegistir(String url) async {
    final yeni = Set<String>.from(favoriler.value);
    if (!yeni.add(url)) yeni.remove(url);
    favoriler.value = yeni;
    try {
      final p = await SharedPreferences.getInstance();
      await p.setStringList(_kFavoriler, yeni.toList());
    } catch (_) {}
  }

  /// Uyku zamanlayıcısı ayarlar. [durdugunda] bitiminde çağrılır.
  static void uykuZamanlayici(int? dakika, {VoidCallback? durdugunda}) {
    uykuDk.value = dakika;
    _uykuSayaci?.cancel();
    uykuKalanDk.value = dakika;
    if (dakika == null) {
      try {
        final p = SharedPreferences.getInstance();
        p.then((p) => p.remove(_kUykuDk));
      } catch (_) {}
      return;
    }
    try {
      final p = SharedPreferences.getInstance();
      p.then((p) => p.setInt(_kUykuDk, dakika));
    } catch (_) {}
    _uykuSayaci = Timer.periodic(const Duration(minutes: 1), (timer) {
      final kalan = (uykuKalanDk.value ?? 0) - 1;
      uykuKalanDk.value = kalan <= 0 ? 0 : kalan;
      if (kalan <= 0) {
        timer.cancel();
        _uykuSayaci = null;
        durdugunda?.call();
      }
    });
  }

  /// Uyku sayacını iptal eder (kalıcı seçim korunur).
  static void uykuSayaciniDurdur() {
    _uykuSayaci?.cancel();
    _uykuSayaci = null;
    uykuKalanDk.value = null;
  }

  /// Tüm dinleyicileri temizler (yalnızca test/uygulama kapanışında).
  static void dispose() {
    _uykuSayaci?.cancel();
    _uykuSayaci = null;
    player.dispose();
  }
}