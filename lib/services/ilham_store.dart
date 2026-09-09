// ===========================================================================
// İLHAM STORE - KALICI YEREL HAFIZA
// Favori ilhamlar ve günün ilhamı hatırlatıcı saati shared_preferences ile
// cihazda saklanır; değişiklikler UI'a ValueNotifier üzerinden yansır.
// ===========================================================================

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Günün ilhamı için kurulan hatırlatıcı (saat/dakika).
class IlhamHatirlatma {
  final int saat;
  final int dakika;

  const IlhamHatirlatma({required this.saat, required this.dakika});

  String get saatYaz {
    final s = saat.toString().padLeft(2, '0');
    final d = dakika.toString().padLeft(2, '0');
    return '$s:$d';
  }

  Map<String, int> toJson() => {'saat': saat, 'dakika': dakika};

  factory IlhamHatirlatma.fromJson(Map<String, dynamic> j) =>
      IlhamHatirlatma(
        saat: ((j['saat'] as num?) ?? 0).toInt().clamp(0, 23),
        dakika: ((j['dakika'] as num?) ?? 0).toInt().clamp(0, 59),
      );
}

class IlhamStore {
  IlhamStore._();

  static const _favorilerKey = 'ilham_favoriler';
  static const _hatirlatmaKey = 'ilham_hatirlatma';

  /// Favori ilham id'leri.
  static final ValueNotifier<Set<String>> favoriler =
      ValueNotifier<Set<String>>({});

  /// Günün ilhamı hatırlatıcısı (null = kurulmamış).
  static final ValueNotifier<IlhamHatirlatma?> hatirlatma =
      ValueNotifier<IlhamHatirlatma?>(null);

  static bool _yuklendi = false;

  static Future<void> yukle() async {
    if (_yuklendi) return;
    _yuklendi = true;
    final p = await SharedPreferences.getInstance();

    final favListe = p.getStringList(_favorilerKey) ?? const [];
    favoriler.value = favListe.toSet();

    final hatirJson = p.getString(_hatirlatmaKey);
    if (hatirJson != null) {
      try {
        hatirlatma.value =
            IlhamHatirlatma.fromJson(
              jsonDecode(hatirJson) as Map<String, dynamic>,
            );
      } catch (_) {}
    }
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

  // ---------------- HATIRLATICI ----------------

  static Future<void> hatirlatmaKaydet(IlhamHatirlatma kayit) async {
    hatirlatma.value = kayit;
    final p = await SharedPreferences.getInstance();
    await p.setString(_hatirlatmaKey, jsonEncode(kayit.toJson()));
  }

  static Future<void> hatirlatmaKaldir() async {
    hatirlatma.value = null;
    final p = await SharedPreferences.getInstance();
    await p.remove(_hatirlatmaKey);
  }
}