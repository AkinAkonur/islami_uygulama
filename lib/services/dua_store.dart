import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ===========================================================================
// DUA STORE - KALICI YEREL HAFIZA
// Favoriler, "Kendi Dualarım", zikirmatik sayacları, yazı boyutu ve dua
// hatırlatıcıları shared_preferences ile cihazda saklanır; değişiklikler
// UI'a ValueNotifier üzerinden anında yansır.
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

/// Bir dua için kurulan hatırlatıcı: saat/dakika + tekrar edilecek günler.
/// [gunler] boşsa "her gün" anlamına gelir (1 = Pazartesi ... 7 = Pazar).
class DuaHatirlatma {
  final String duaId;
  final int saat;
  final int dakika;
  final List<int> gunler;

  const DuaHatirlatma({
    required this.duaId,
    required this.saat,
    required this.dakika,
    this.gunler = const [],
  });

  /// Tekrarlı mı? (önümüzdeki hafta da geçerli)
  bool get tekrarli => gunler.isNotEmpty;

  String get saatYaz {
    final s = saat.toString().padLeft(2, '0');
    final d = dakika.toString().padLeft(2, '0');
    return '$s:$d';
  }

  /// Günlerin kısa etiketi: boş = "Her gün".
  String get gunlerYaz {
    if (gunler.isEmpty) return 'Her gün';
    const adlar = ['', 'Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
    final sirali = List<int>.from(gunler)..sort();
    return '${sirali.map((g) => g >= 1 && g <= 7 ? adlar[g] : '').join(', ')} · saat $saatYaz';
  }

  Map<String, dynamic> toJson() => {
    'duaId': duaId,
    'saat': saat,
    'dakika': dakika,
    'gunler': gunler,
  };

  factory DuaHatirlatma.fromJson(Map<String, dynamic> j) => DuaHatirlatma(
    duaId: (j['duaId'] as String?) ?? '',
    saat: ((j['saat'] as num?) ?? 0).toInt().clamp(0, 23),
    dakika: ((j['dakika'] as num?) ?? 0).toInt().clamp(0, 59),
    gunler: ((j['gunler'] as List<dynamic>?) ?? const [])
        .map((e) => ((e as num?) ?? 0).toInt().clamp(1, 7))
        .toSet()
        .toList(),
  );
}

class DuaStore {
  DuaStore._();

  static const _favorilerKey = 'dua_favoriler';
  static const _ozDualarKey = 'dua_oz_dualari';
  static const _sayaclarKey = 'dua_sayaclar';
  static const _fontKey = 'dua_font_boyutu';
  static const _hatirlatmalarKey = 'dua_hatirlatmalar';

  static final ValueNotifier<Set<String>> favoriler =
      ValueNotifier<Set<String>>({});
  static final ValueNotifier<List<OzDua>> ozDualar = ValueNotifier<List<OzDua>>(
    [],
  );
  static final ValueNotifier<Map<String, int>> sayaclar =
      ValueNotifier<Map<String, int>>({});
  static final ValueNotifier<double> fontBoyutu = ValueNotifier<double>(19);

  /// duaId -> hatırlatıcı
  static final ValueNotifier<Map<String, DuaHatirlatma>> hatirlatmalar =
      ValueNotifier<Map<String, DuaHatirlatma>>({});

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
        final map = (jsonDecode(sayacJson) as Map<String, dynamic>).map(
          (k, v) => MapEntry(k, (v as num?)?.toInt() ?? 0),
        );
        sayaclar.value = map;
      } catch (_) {}
    }

    fontBoyutu.value = p.getDouble(_fontKey) ?? 19;

    final hatirJson = p.getString(_hatirlatmalarKey);
    if (hatirJson != null) {
      try {
        final map = (jsonDecode(hatirJson) as Map<String, dynamic>).map(
          (k, v) => MapEntry(
            k,
            DuaHatirlatma.fromJson((v as Map).cast<String, dynamic>()),
          ),
        );
        hatirlatmalar.value = map;
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

  // ---------------- KENDİ DUALARIM ----------------

  static Future<void> ozDuaEkle(String baslik, String metin) async {
    final yeni = List<OzDua>.from(ozDualar.value)
      ..insert(
        0,
        OzDua(
          id: 'oz-${DateTime.now().millisecondsSinceEpoch}',
          baslik: baslik,
          metin: metin,
        ),
      );
    await _ozDualariKaydet(yeni);
  }

  static Future<void> ozDuaSil(String id) async {
    final yeni = ozDualar.value.where((d) => d.id != id).toList();
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

  // ---------------- DUA HATIRLATICILARI ----------------

  static DuaHatirlatma? hatirlatmaOku(String duaId) =>
      hatirlatmalar.value[duaId];

  static Future<void> hatirlatmaKaydet(DuaHatirlatma kayit) async {
    final yeni = Map<String, DuaHatirlatma>.from(hatirlatmalar.value)
      ..[kayit.duaId] = kayit;
    hatirlatmalar.value = yeni;
    final p = await SharedPreferences.getInstance();
    await p.setString(
      _hatirlatmalarKey,
      jsonEncode(yeni.map((k, v) => MapEntry(k, v.toJson()))),
    );
  }

  static Future<void> hatirlatmaSil(String duaId) async {
    if (!hatirlatmalar.value.containsKey(duaId)) return;
    final yeni = Map<String, DuaHatirlatma>.from(hatirlatmalar.value)
      ..remove(duaId);
    hatirlatmalar.value = yeni;
    final p = await SharedPreferences.getInstance();
    await p.setString(
      _hatirlatmalarKey,
      jsonEncode(yeni.map((k, v) => MapEntry(k, v.toJson()))),
    );
  }
}
