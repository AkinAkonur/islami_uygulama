import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ===========================================================================
// DUA STORE - KALICI YEREL HAFIZA
// Favoriler, "Kendi Dualarım", zikirmatik sayacları ve yazı boyutu
// shared_preferences ile cihazda saklanır; değişiklikler UI'a
// ValueNotifier üzerinden anında yansır.
// ===========================================================================

class OzDua {
  final String id;
  final String baslik;
  final String metin;

  const OzDua({required this.id, required this.baslik, required this.metin});

  Map<String, String> toJson() => {'id': id, 'baslik': baslik, 'metin': metin};

  factory OzDua.fromJson(Map<String, dynamic> j) => OzDua(
        id: (j['id'] as String?) ?? '',
        baslik: (j['baslik'] as String?) ?? '',
        metin: (j['metin'] as String?) ?? '',
      );
}

class DuaStore {
  DuaStore._();

  static const _favorilerKey = 'dua_favoriler';
  static const _ozDualarKey = 'dua_oz_dualari';
  static const _sayaclarKey = 'dua_sayaclar';
  static const _fontKey = 'dua_font_boyutu';

  static final ValueNotifier<Set<String>> favoriler =
      ValueNotifier<Set<String>>({});
  static final ValueNotifier<List<OzDua>> ozDualar =
      ValueNotifier<List<OzDua>>([]);
  static final ValueNotifier<Map<String, int>> sayaclar =
      ValueNotifier<Map<String, int>>({});
  static final ValueNotifier<double> fontBoyutu = ValueNotifier<double>(19);

  static bool _yuklendi = false;

  static Future<void> yukle() async {
    if (_yuklendi) return;
    _yuklendi = true;
    final p = await SharedPreferences.getInstance();

    final favListe = p.getStringList(_favorilerKey) ?? const [];
    favoriler.value = favListe.toSet();

    final ozJson = p.getString(_ozDualarKey);
    if (ozJson != null) {
      try {
        ozDualar.value = (jsonDecode(ozJson) as List<dynamic>)
            .map((e) => OzDua.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }

    final sayacJson = p.getString(_sayaclarKey);
    if (sayacJson != null) {
      try {
        final map = (jsonDecode(sayacJson) as Map<String, dynamic>)
            .map((k, v) => MapEntry(k, (v as num?)?.toInt() ?? 0));
        sayaclar.value = map;
      } catch (_) {}
    }

    fontBoyutu.value = p.getDouble(_fontKey) ?? 19;
  }

  // ---------------- FAVORİLER ----------------

  static bool favoriMi(String id) => favoriler.value.contains(id);

  static Future<void> favoriDegistir(String id) async {
    final yeni = Set<String>.from(favoriler.value);
    if (!yeni.add(id)) yeni.remove(id);
    favoriler.value = yeni;
    final p = await SharedPreferences.getInstance();
    await p.setStringList(_favorilerKey, yeni.toList());
  }

  // ---------------- KENDİ DUALARIM ----------------

  static Future<void> ozDuaEkle(String baslik, String metin) async {
    final yeni = List<OzDua>.from(ozDualar.value)
      ..insert(
        0,
        OzDua(id: 'oz-${DateTime.now().millisecondsSinceEpoch}',
            baslik: baslik, metin: metin),
      );
    await _ozDualariKaydet(yeni);
  }

  static Future<void> ozDuaSil(String id) async {
    final yeni =
        ozDualar.value.where((d) => d.id != id).toList();
    await _ozDualariKaydet(yeni);
  }

  static Future<void> _ozDualariKaydet(List<OzDua> liste) async {
    ozDualar.value = liste;
    final p = await SharedPreferences.getInstance();
    await p.setString(
      _ozDualarKey,
      jsonEncode(liste.map((d) => d.toJson()).toList()),
    );
  }

  // ---------------- ZİKİRMATİK SAYACI ----------------

  static int sayacOku(String id) => sayaclar.value[id] ?? 0;

  static Future<int> sayacArttir(String id) async {
    final mevcut = sayaclar.value[id] ?? 0;
    final yeni = mevcut + 1;
    final map = Map<String, int>.from(sayaclar.value)..[id] = yeni;
    sayaclar.value = map;
    final p = await SharedPreferences.getInstance();
    await p.setString(
      _sayaclarKey,
      jsonEncode(map.map((k, v) => MapEntry(k, v.toString()))),
    );
    return yeni;
  }

  static Future<void> sayacSifirla(String id) async {
    if (!sayaclar.value.containsKey(id)) return;
    final map = Map<String, int>.from(sayaclar.value)..remove(id);
    sayaclar.value = map;
    final p = await SharedPreferences.getInstance();
    await p.setString(
      _sayaclarKey,
      jsonEncode(map.map((k, v) => MapEntry(k, v.toString()))),
    );
  }

  // ---------------- YAZI BOYUTU ----------------

  static Future<void> fontBoyutuYaz(double deger) async {
    fontBoyutu.value = deger;
    final p = await SharedPreferences.getInstance();
    await p.setDouble(_fontKey, deger);
  }
}
