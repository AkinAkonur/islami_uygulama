import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Hatim takibi: 30 cüzün hangilerinin okunduğunu cihazda saklar.
class CuzHatimStore {
  static const String _anahtar = 'cuz_okundu';

  static Future<List<bool>> oku() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString(_anahtar);
    if (raw == null) return List.filled(30, false);
    try {
      final liste = (jsonDecode(raw) as List<dynamic>)
          .map((e) => e == true)
          .toList();
      while (liste.length < 30) {
        liste.add(false);
      }
      return liste;
    } catch (_) {
      return List.filled(30, false);
    }
  }

  static Future<void> isaretle(int cuzNo, bool okundu) async {
    final p = await SharedPreferences.getInstance();
    final liste = await oku();
    liste[cuzNo - 1] = okundu;
    await p.setString(_anahtar, jsonEncode(liste));
  }

  static Future<void> hepsiniSifirla() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_anahtar, jsonEncode(List.filled(30, false)));
  }
}
