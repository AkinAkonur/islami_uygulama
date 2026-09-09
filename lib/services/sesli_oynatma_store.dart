// ===========================================================================
// SESLİ OYNATMA DEPOSU - "Sıfır Sürtünme" (Zero Friction) durum kalıcılığı
// ---------------------------------------------------------------------------
// Sesli Kıssalar & Podcast modülünün deneyimi için gerekli olan tüm "son
// durum" verileri burada saklanır ve ValueNotifier ile arayüze bildirilir:
//   • Son dinlenen kıssa (id + adı)      → "Kaldığın Yerden Devam Et" kartı
//   • Son podcast/radyo kanalı + pozisyon → aynı kart; saniyesine kadar sürer
//   • Oynatma hızı ve uyku zamanlayıcı seçimi
// Tüm veriler cihazda (SharedPreferences) tutulur; sunucuya kayıt gönderilmez.
// ===========================================================================

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SesliOynatmaStore {
  SesliOynatmaStore._();

  static const _kSonKissaId = 'sesli_son_kissa_id';
  static const _kSonKissaAd = 'sesli_son_kissa_ad';
  static const _kSonKanalUrl = 'sesli_son_kanal_url';
  static const _kSonKanalAd = 'sesli_son_kanal_ad';
  static const _kPozisyonMs = 'sesli_podcast_pozisyon_ms';
  static const _kHiz = 'sesli_oynatma_hizi';
  static const _kUykuDk = 'sesli_uyku_zamanlayici_dk';

  static final ValueNotifier<String?> sonKissaId = ValueNotifier<String?>(null);
  static final ValueNotifier<String?> sonKissaAd = ValueNotifier<String?>(null);
  static final ValueNotifier<String?> sonKanalUrl = ValueNotifier<String?>(null);
  static final ValueNotifier<String?> sonKanalAd = ValueNotifier<String?>(null);

  /// Son podcast/radyo dinleme pozisyonu (milisaniye). Canlı yayın için 0'dır.
  static final ValueNotifier<int> podcastPozisyonMs = ValueNotifier<int>(0);

  /// Oynatma hızı çarpanı (0.75 / 1.0 / 1.25 / 1.5 / 2.0).
  static final ValueNotifier<double> hiz = ValueNotifier<double>(1.0);

  /// Seçilen uyku zamanlayıcısı (dakika). null = kapalı.
  static final ValueNotifier<int?> uykuDk = ValueNotifier<int?>(null);

  /// Uyku geri sayımı (aktif sayacın kalan dakikası); null = sayaç yok.
  static final ValueNotifier<int?> uykuKalanDk = ValueNotifier<int?>(null);

  static Timer? _uykuSayaci;
  static bool _yuklendi = false;

  /// Kalıcı verileri belleğe yükler (sayfa açılışında çağrılır).
  static Future<void> yukle() async {
    if (_yuklendi) return;
    _yuklendi = true;
    try {
      final p = await SharedPreferences.getInstance();
      sonKissaId.value = p.getString(_kSonKissaId);
      sonKissaAd.value = p.getString(_kSonKissaAd);
      sonKanalUrl.value = p.getString(_kSonKanalUrl);
      sonKanalAd.value = p.getString(_kSonKanalAd);
      podcastPozisyonMs.value = p.getInt(_kPozisyonMs) ?? 0;
      hiz.value = p.getDouble(_kHiz) ?? 1.0;
      uykuDk.value = p.getInt(_kUykuDk);
    } catch (_) {
      // Test/önbelleksiz ortamda sessiz geç.
    }
  }

  /// Son dinlenen kıssayı kaydeder.
  static Future<void> kissaKaydet(String id, String ad) async {
    sonKissaId.value = id;
    sonKissaAd.value = ad;
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(_kSonKissaId, id);
      await p.setString(_kSonKissaAd, ad);
    } catch (_) {}
  }

  /// Son dinlenen podcast/radyo kanalını kaydeder.
  static Future<void> kanalKaydet(String url, String ad) async {
    sonKanalUrl.value = url;
    sonKanalAd.value = ad;
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(_kSonKanalUrl, url);
      await p.setString(_kSonKanalAd, ad);
    } catch (_) {}
  }

  /// Podcast pozisyonunu günceller. [kaydet] yalnızca en az 1 saniyede bir
  /// diske yazar (pozisyon olayları çok sık gelir).
  static DateTime _sonPozisyonKaydi = DateTime.fromMillisecondsSinceEpoch(0);

  static Future<void> pozisyonGuncelle(int ms, {bool kaydet = false}) async {
    podcastPozisyonMs.value = ms;
    if (!kaydet) return;
    if (DateTime.now().difference(_sonPozisyonKaydi) <
        const Duration(seconds: 1)) {
      return;
    }
    _sonPozisyonKaydi = DateTime.now();
    try {
      final p = await SharedPreferences.getInstance();
      await p.setInt(_kPozisyonMs, ms);
    } catch (_) {}
  }

  /// Oynatma hızını kalıcı olarak kaydeder.
  static Future<void> hizAyarla(double deger) async {
    hiz.value = deger;
    try {
      final p = await SharedPreferences.getInstance();
      await p.setDouble(_kHiz, deger);
    } catch (_) {}
  }

  /// Uyku zamanlayıcı seçimini kaydeder ve geri sayımı başlatır.
  /// [durdugunda] geri sayım bitince (oynatmayı durdurmak için) çağrılır.
  static void uykuZamanlayici(int? dakika, {VoidCallback? durdugunda}) {
    uykuDk.value = dakika;
    _uykuSayaci?.cancel();
    uykuKalanDk.value = dakika;
    if (dakika == null) {
      try {
        _kaydetUyku(null);
      } catch (_) {}
      return;
    }
    try {
      _kaydetUyku(dakika);
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

  /// Uyku sayacını (geçici) iptal eder; kalıcı seçimi korur.
  static void uykuSayaciniDurdur() {
    _uykuSayaci?.cancel();
    _uykuSayaci = null;
    uykuKalanDk.value = null;
  }

  static Future<void> _kaydetUyku(int? dakika) async {
    try {
      final p = await SharedPreferences.getInstance();
      if (dakika == null) {
        await p.remove(_kUykuDk);
      } else {
        await p.setInt(_kUykuDk, dakika);
      }
    } catch (_) {}
  }
}
