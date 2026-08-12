import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'cuz_verileri.dart';

// ===========================================================================
// DUALAR VERİ SERVİSİ
// Tüm dua içerikleri (Arapça, Okunuş, Meal, etiketler, tekrar adedi,
// ayet/ses bağlantısı) uygulamayla birlikte gelen assets/dualar.json
// dosyasında tutulur. Bu sayede Dualar bölümü tamamen çevrimdışı ve
// ışık hızında çalışır.
// ===========================================================================

class DuaKaydi {
  final String id;
  final String baslik;
  final String arapca;
  final String okunus;
  final String meal;
  final String kaynak;
  final String? ayet; // "2:201" gibi Kur'an referansı -> ses varsa
  final int? tekrar; // tavsiye edilen tekrar adedi (zikirmatik hedefi)
  final List<String> etiketler;

  const DuaKaydi({
    required this.id,
    required this.baslik,
    required this.arapca,
    required this.okunus,
    required this.meal,
    required this.kaynak,
    this.ayet,
    this.tekrar,
    this.etiketler = const [],
  });

  factory DuaKaydi.fromJson(Map<String, dynamic> j) => DuaKaydi(
        id: j['id'] as String,
        baslik: (j['baslik'] as String?) ?? '',
        arapca: (j['arapca'] as String?) ?? '',
        okunus: (j['okunus'] as String?) ?? '',
        meal: (j['meal'] as String?) ?? '',
        kaynak: (j['kaynak'] as String?) ?? '',
        ayet: j['ayet'] as String?,
        tekrar: (j['tekrar'] as int?) ?? 0,
        etiketler: ((j['etiketler'] as List<dynamic>?) ?? const [])
            .map((e) => e.toString().toLowerCase())
            .toList(),
      );

  /// Kur'an âyetine dayanan dualar için sesli dinleme URL'si.
  String? get sesUrl {
    final a = ayet;
    if (a == null || !a.contains(':')) return null;
    final parcalar = a.split(':');
    final sure = int.tryParse(parcalar[0]);
    final ayetNo = int.tryParse(parcalar[1]);
    if (sure == null || ayetNo == null) return null;
    return CuzVerileri.ayetSesUrl(sure, ayetNo);
  }

  bool esles(String sorgu) {
    final s = sorgu.toLowerCase();
    if (baslik.toLowerCase().contains(s)) return true;
    if (meal.toLowerCase().contains(s)) return true;
    if (kaynak.toLowerCase().contains(s)) return true;
    for (final e in etiketler) {
      if (e.contains(s)) return true;
    }
    return false;
  }
}

class DuaGrubu {
  final String ad;
  final List<DuaKaydi> dualar;

  const DuaGrubu({required this.ad, required this.dualar});
}

class DuaKategori {
  final String id;
  final String ad;
  final String emoji;
  final String renkHex;
  final List<DuaGrubu> gruplar;

  const DuaKategori({
    required this.id,
    required this.ad,
    required this.emoji,
    required this.renkHex,
    required this.gruplar,
  });

  int get duaSayisi =>
      gruplar.fold(0, (toplam, g) => toplam + g.dualar.length);
}

class DualarVerileri {
  DualarVerileri._();

  static final DualarVerileri instance = DualarVerileri._();

  List<DuaKategori>? _kategoriler;

  Future<List<DuaKategori>> kategorileriYukle() async {
    final mevcut = _kategoriler;
    if (mevcut != null) return mevcut;

    final veri = await rootBundle.load('assets/dualar.json');
    final json = jsonDecode(utf8.decode(veri.buffer.asUint8List()))
        as Map<String, dynamic>;
    final kategoriler = ((json['kategoriler'] as List<dynamic>?) ?? [])
        .map((e) {
          final m = e as Map<String, dynamic>;
          return DuaKategori(
            id: m['id'] as String,
            ad: (m['ad'] as String?) ?? '',
            emoji: (m['emoji'] as String?) ?? '🤲',
            renkHex: (m['renk'] as String?) ?? '#F2C14E',
            gruplar: ((m['gruplar'] as List<dynamic>?) ?? []).map((g) {
              final gm = g as Map<String, dynamic>;
              return DuaGrubu(
                ad: (gm['ad'] as String?) ?? '',
                dualar: ((gm['dualar'] as List<dynamic>?) ?? [])
                    .map((d) => DuaKaydi.fromJson(d as Map<String, dynamic>))
                    .toList(),
              );
            }).toList(),
          );
        })
        .toList();
    _kategoriler = kategoriler;
    return kategoriler;
  }

  /// Tüm dualar (arama ve favoriler için).
  Future<List<DuaKaydi>> tumDualar() async {
    final kategoriler = await kategorileriYukle();
    return [
      for (final k in kategoriler)
        for (final g in k.gruplar) ...g.dualar,
    ];
  }

  Future<DuaKaydi?> idIleBul(String id) async {
    final dualar = await tumDualar();
    for (final d in dualar) {
      if (d.id == id) return d;
    }
    return null;
  }

  Future<List<DuaKaydi>> ara(String sorgu) async {
    final s = sorgu.trim();
    if (s.isEmpty) return const [];
    final dualar = await tumDualar();
    return dualar.where((d) => d.esles(s)).toList();
  }
}
