// ===========================================================================
// HAC & UMRE DEPOSU - İlerleme Takibi
// İbadet modundaki tamamlanan adımlar ve sayaç durumları cihazda
// (SharedPreferences) saklanır; sunucuya veri gönderilmez.
// ===========================================================================

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HacUmreStore {
  HacUmreStore._();

  static const _anahtarAdimlar = 'hac_umre_tamamlanan_adimlar';
  static const _anahtarSayac = 'hac_umre_sayac_durumlari';

  /// Akış id -> tamamlanan adım id seti.
  static Future<Set<String>> tamamlananAdimlar(String akisId) async {
    final p = await SharedPreferences.getInstance();
    final veri = p.getString(_anahtarAdimlar);
    if (veri == null) return {};
    try {
      final map = jsonDecode(veri) as Map<String, dynamic>;
      final liste = map[akisId];
      if (liste == null) return {};
      return (liste as List).map((e) => e.toString()).toSet();
    } catch (_) {
      return {};
    }
  }

  static Future<void> adimTikla(String akisId, String adimId) async {
    final p = await SharedPreferences.getInstance();
    final veri = p.getString(_anahtarAdimlar);
    var map = <String, dynamic>{};
    if (veri != null) {
      try {
        map = jsonDecode(veri) as Map<String, dynamic>;
      } catch (_) {
        map = {};
      }
    }
    final mevcut = (map[akisId] as List?)?.map((e) => e.toString()).toSet() ??
        <String>{};
    if (!mevcut.add(adimId)) mevcut.remove(adimId);
    map[akisId] = mevcut.toList();
    await p.setString(_anahtarAdimlar, jsonEncode(map));
  }

  static Future<void> akisSifirla(String akisId) async {
    final p = await SharedPreferences.getInstance();
    final veri = p.getString(_anahtarAdimlar);
    var map = <String, dynamic>{};
    if (veri != null) {
      try {
        map = jsonDecode(veri) as Map<String, dynamic>;
      } catch (_) {
        map = {};
      }
    }
    map.remove(akisId);
    await p.setString(_anahtarAdimlar, jsonEncode(map));
  }

  /// Sayaç durumlarını kaydeder: {sayaçAnahtar: değer}.
  static Future<Map<String, int>> sayacDurumlari() async {
    final p = await SharedPreferences.getInstance();
    final veri = p.getString(_anahtarSayac);
    if (veri == null) return {};
    try {
      final map = jsonDecode(veri) as Map<String, dynamic>;
      return map.map((k, v) => MapEntry(k, (v as num).toInt()));
    } catch (_) {
      return {};
    }
  }

  static Future<void> sayacKaydet(String anahtar, int deger) async {
    final p = await SharedPreferences.getInstance();
    final map = await sayacDurumlari();
    map[anahtar] = deger;
    await p.setString(_anahtarSayac, jsonEncode(map));
  }
}
