// lib/pages/soru_cevap/soru_cevap_store.dart
// Soru-Cevap modülü deposu: quiz istatistikleri, günlük soru durumu ve
// rozet kazanımları. Tüm veriler cihazda (SharedPreferences) saklanır.

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'soru_cevap_model.dart';
import 'soru_cevap_verileri.dart';

class SoruCevapStore {
  SoruCevapStore._();

  static const _anahtarDogru = 'soru_cevap_toplam_dogru';
  static const _anahtarYanit = 'soru_cevap_toplam_yanit';
  static const _anahtarGunluk = 'soru_cevap_gunluk_';
  static const _anahtarBilinen = 'soru_cevap_ezber'; // Doğru bilinen soru id seti

  /// Toplam doğru cevap sayısı (rozetler buradan hesaplanır).
  static final ValueNotifier<int> toplamDogru = ValueNotifier<int>(0);

  /// Toplam cevaplanan soru sayısı.
  static final ValueNotifier<int> toplamYanit = ValueNotifier<int>(0);

  /// Doğru bilinen soru kimlikleri (aynı soruyu tekrar çözünce puan artmaz).
  static final ValueNotifier<Set<String>> bilinenSorular =
      ValueNotifier<Set<String>>({});

  /// Günün sorusu bu güne özel cevaplandı mı?
  static final ValueNotifier<bool> gunlukCevaplandi =
      ValueNotifier<bool>(false);

  /// Belleğe kayıtlı verileri yükler.
  static Future<void> yukle() async {
    final p = await SharedPreferences.getInstance();
    toplamDogru.value = p.getInt(_anahtarDogru) ?? 0;
    toplamYanit.value = p.getInt(_anahtarYanit) ?? 0;
    bilinenSorular.value = (p.getStringList(_anahtarBilinen) ?? const []).toSet();
    gunlukCevaplandi.value = p.getBool(_anahtarGunluk + _bugunKodu()) ?? false;
  }

  static String _bugunKodu() {
    final n = DateTime.now();
    return '${n.year}-${n.month}-${n.day}';
  }

  /// Bir soru cevaplandığında skoru günceller. [dogru] ise ve soru daha önce
  /// doğru bilinmemişse toplam doğru sayısını artırır.
  static Future<void> cevapKaydet(SoruCevapSorusu soru, bool dogru) async {
    toplamYanit.value++;
    if (dogru && !bilinenSorular.value.contains(soru.id)) {
      toplamDogru.value++;
      bilinenSorular.value = {...bilinenSorular.value, soru.id};
    }
    final p = await SharedPreferences.getInstance();
    await p.setInt(_anahtarDogru, toplamDogru.value);
    await p.setInt(_anahtarYanit, toplamYanit.value);
    await p.setStringList(_anahtarBilinen, bilinenSorular.value.toList());
  }

  /// Günün sorusu cevaplandı olarak işaretlenir (günde bir kez puan).
  static Future<void> gunlukIsaretle() async {
    gunlukCevaplandi.value = true;
    final p = await SharedPreferences.getInstance();
    await p.setBool(_anahtarGunluk + _bugunKodu(), true);
  }

  /// Bugüne özel durum sıfırlanır (gece yarısı geçince otomatik anlamsızlaşır).
  static void gunlukSifirla() {
    gunlukCevaplandi.value = false;
  }

  static List<Rozet> get kazanilanRozetler =>
      [for (final r in SoruCevapVerileri.rozetler) if (rozetKazanildi(r)) r];

  static List<Rozet> get kazanilamayanRozetler => [
        for (final r in SoruCevapVerileri.rozetler)
          if (!rozetKazanildi(r)) r,
      ];

  static bool rozetKazanildi(Rozet rozet) => toplamDogru.value >= rozet.esik;

  /// Bir sonraki rozete kaç doğru kaldığını döner.
  static int sonrakiRozetIcinKalan() {
    for (final r in SoruCevapVerileri.rozetler) {
      if (!rozetKazanildi(r)) return r.esik - toplamDogru.value;
    }
    return 0;
  }
}
