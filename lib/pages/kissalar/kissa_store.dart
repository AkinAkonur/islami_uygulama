import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ===========================================================================
// KISSALAR DEPOSU - Favoriler, yer imleri, renkli kişisel notlar
// Tüm veriler cihazda (SharedPreferences) saklanır; sunucuya hiçbir kişisel
// kayıt gönderilmez (uygulamanın uçtan uca gizlilik ilkesi).
// ===========================================================================

class KissaNotu {
  final String metin;
  final int renkIndex; // 0..4 renk paleti

  const KissaNotu({required this.metin, required this.renkIndex});

  Map<String, dynamic> toJson() => {'metin': metin, 'renk': renkIndex};

  factory KissaNotu.fromJson(Map<String, dynamic> json) => KissaNotu(
        metin: (json['metin'] as String?) ?? '',
        renkIndex: (json['renk'] as num?)?.toInt() ?? 0,
      );
}

class KissaStore {
  KissaStore._();

  static const _anahtarFavoriler = 'kissalar_favoriler';
  static const _anahtarNotlar = 'kissalar_notlar';

  static final ValueNotifier<Set<String>> favoriler =
      ValueNotifier<Set<String>>({});

  static final ValueNotifier<Map<String, List<KissaNotu>>> notlar =
      ValueNotifier<Map<String, List<KissaNotu>>>({});

  /// Renkli not paleti: hex kodlar (UI'da kissaHex ile renge çevrilir).
  static const List<String> notRenkHexleri = [
    '#F2C14E',
    '#4FC3C9',
    '#5FA8E8',
    '#F09A6E',
    '#EC4899',
  ];

  static const List<String> notRenkAdlari = [
    'Sarı',
    'Turkuaz',
    'Mavi',
    'Turuncu',
    'Pembe',
  ];

  /// Kayıtlı verileri belleğe yükler (uygulama başlangıcında çağrılır).
  static Future<void> yukle() async {
    final p = await SharedPreferences.getInstance();

    final fav = p.getStringList(_anahtarFavoriler) ?? const [];
    favoriler.value = fav.toSet();

    final notJson = p.getString(_anahtarNotlar);
    final notMap = <String, List<KissaNotu>>{};
    if (notJson != null) {
      try {
        final veri = jsonDecode(notJson) as Map<String, dynamic>;
        veri.forEach((id, liste) {
          notMap[id] = [
            for (final j in (liste as List))
              KissaNotu.fromJson((j as Map).cast<String, dynamic>()),
          ];
        });
      } catch (_) {
        // Bozuk kayıt yok sayılır.
      }
    }
    notlar.value = notMap;
  }

  static bool favoriMi(String id) => favoriler.value.contains(id);

  static Future<void> favoriDegistir(String id) async {
    final set = Set<String>.from(favoriler.value);
    if (!set.add(id)) set.remove(id);
    favoriler.value = set;
    final p = await SharedPreferences.getInstance();
    await p.setStringList(_anahtarFavoriler, set.toList());
  }

  static List<KissaNotu> kissaNotlari(String id) =>
      notlar.value[id] ?? const [];

  static Future<void> notEkle(String id, String metin, int renkIndex) async {
    final map = Map<String, List<KissaNotu>>.from(notlar.value);
    final liste = [...kissaNotlari(id), KissaNotu(metin: metin, renkIndex: renkIndex)];
    map[id] = liste;
    notlar.value = map;
    await _kaydet();
  }

  static Future<void> notSil(String id, int index) async {
    final map = Map<String, List<KissaNotu>>.from(notlar.value);
    final liste = [...kissaNotlari(id)]..removeAt(index);
    if (liste.isEmpty) {
      map.remove(id);
    } else {
      map[id] = liste;
    }
    notlar.value = map;
    await _kaydet();
  }

  static Future<void> _kaydet() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(
      _anahtarNotlar,
      jsonEncode({
        for (final e in notlar.value.entries)
          e.key: [for (final n in e.value) n.toJson()],
      }),
    );
  }
}