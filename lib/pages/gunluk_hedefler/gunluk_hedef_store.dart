import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gunluk_hedef_verileri.dart';

class GunlukHedefSonuc {
  final List<HedefRozet> yeniRozetler;
  final bool gunTamamlandi;
  final int kazanilanXp;

  const GunlukHedefSonuc({
    this.yeniRozetler = const [],
    this.gunTamamlandi = false,
    this.kazanilanXp = 0,
  });
}

class GunlukHedefStore {
  GunlukHedefStore._();

  static const _keyIlerleme = 'gunluk_hedef_ilerleme_';
  static const _keySeri = 'gunluk_hedef_seri';
  static const _keySeriSon = 'gunluk_hedef_seri_son';
  static const _keyUzun = 'gunluk_hedef_uzun_seri';
  static const _keyXp = 'gunluk_hedef_xp';
  static const _keyDondurucu = 'gunluk_hedef_dondurucu';
  static const _keyKorunma = 'gunluk_hedef_korunma_gunu';
  static const _keyRozetler = 'gunluk_hedef_rozetler';

  static final ValueNotifier<int> surum = ValueNotifier<int>(0);

  static final ValueNotifier<GunlukHedefSonuc?> kutlama =
      ValueNotifier<GunlukHedefSonuc?>(null);

  static void _sonucYayinla(GunlukHedefSonuc sonuc) {
    if (sonuc.gunTamamlandi || sonuc.yeniRozetler.isNotEmpty) {
      kutlama.value = sonuc;
    }
  }

  static Map<GunlukHedefTipi, int> _bugun = {};
  static Set<String> _rozetIdler = {};
  static int _seri = 0;
  static int _uzunSeri = 0;
  static int _xp = 0;
  static int _dondurucu = 0;
  static bool _bugunKorundu = false;

  static String _tarih(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String get _bugunKey => _tarih(DateTime.now());

  static Map<GunlukHedefTipi, int> get bugunIlerleme =>
      Map.unmodifiable(_bugun);
  static int get seri => _seri;
  static int get uzunSeri => _uzunSeri;
  static int get toplamXp => _xp;
  static int get dondurucu => _dondurucu;
  static bool get bugunKorundu => _bugunKorundu;

  static bool tamam(GunlukHedefTipi tip) =>
      (_bugun[tip] ?? 0) >= gorevIcin(tip).hedefSayi;

  static int get bugunTamamlanan =>
      gunlukGorevler.where((g) => tamam(g.tip)).length;

  static int get bugunKazanilanXp => gunlukGorevler
      .where((g) => tamam(g.tip))
      .fold(0, (toplam, g) => toplam + g.xp);

  static int get gunlukMaxXp =>
      gunlukGorevler.fold(0, (toplam, g) => toplam + g.xp);

  static bool get gunTamam =>
      gunlukGorevler.every((g) => tamam(g.tip));

  static List<HedefRozet> get kazanilanRozetler =>
      [for (final r in kilometreTaslari) if (_rozetIdler.contains(r.id)) r];

  static Future<void> yukle() async {
    final p = await SharedPreferences.getInstance();
    final bugun = _bugunKey;

    _bugun = _okunanVeri(p, bugun);
    _seri = p.getInt(_keySeri) ?? 0;
    _uzunSeri = p.getInt(_keyUzun) ?? 0;
    _xp = p.getInt(_keyXp) ?? 0;
    _dondurucu = p.getInt(_keyDondurucu) ?? 0;
    _rozetIdler = (p.getStringList(_keyRozetler) ?? const []).toSet();
    _bugunKorundu = p.getString(_keyKorunma) == bugun;

    final son = p.getString(_keySeriSon) ?? '';
    if (son.isNotEmpty && son != bugun) {
      final sonTarih = DateTime.tryParse(son);
      if (sonTarih != null) {
        final kacirilan = DateTime.now().difference(sonTarih).inDays - 1;
        if (kacirilan > 0 && !_bugunKorundu) {
          if (kacirilan <= _dondurucu) {
            _dondurucu -= kacirilan;
            _bugunKorundu = true;
            await p.setInt(_keyDondurucu, _dondurucu);
            await p.setString(_keyKorunma, bugun);
            await p.setString(
              _keySeriSon,
              _tarih(DateTime.now().subtract(const Duration(days: 1))),
            );
          } else {
            _seri = 0;
            await p.setInt(_keySeri, 0);
            await p.setString(_keySeriSon, '');
          }
        }
      }
    }
    surum.value++;
  }

  static Future<GunlukHedefSonuc> kissaTamamla() =>
      _gorevTamamla(GunlukHedefTipi.kissa);

  static Future<GunlukHedefSonuc> soruDogru() =>
      _gorevTamamla(GunlukHedefTipi.soru);

  static Future<GunlukHedefSonuc> kardeslikAminEkle() =>
      _sayacEkle(GunlukHedefTipi.kardeslik, 1);

  static Future<GunlukHedefSonuc> zikirEkle(int adet) =>
      _sayacEkle(GunlukHedefTipi.zikir, adet);

  static Future<GunlukHedefSonuc> _gorevTamamla(GunlukHedefTipi tip) async {
    final onceTamam = gunTamam;
    var kaz = 0;
    if (!tamam(tip)) {
      _bugun[tip] = gorevIcin(tip).hedefSayi;
      kaz = gorevIcin(tip).xp;
      _xp += kaz;
    }
    final rozetler = await _seriKontrol();
    await _kaydet();
    surum.value++;
    final sonuc = GunlukHedefSonuc(
      yeniRozetler: rozetler,
      gunTamamlandi: !onceTamam && gunTamam,
      kazanilanXp: kaz,
    );
    _sonucYayinla(sonuc);
    return sonuc;
  }

  static Future<GunlukHedefSonuc> _sayacEkle(
    GunlukHedefTipi tip,
    int adet,
  ) async {
    final onceTamam = gunTamam;
    final gorev = gorevIcin(tip);
    final once = _bugun[tip] ?? 0;
    var kaz = 0;
    if (once < gorev.hedefSayi) {
      _bugun[tip] = (once + adet).clamp(0, gorev.hedefSayi);
      if (tamam(tip)) {
        kaz = gorev.xp;
        _xp += kaz;
      }
    }
    final rozetler = await _seriKontrol();
    await _kaydet();
    surum.value++;
    final sonuc = GunlukHedefSonuc(
      yeniRozetler: rozetler,
      gunTamamlandi: !onceTamam && gunTamam,
      kazanilanXp: kaz,
    );
    _sonucYayinla(sonuc);
    return sonuc;
  }

  static Future<void> _kaydet() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(
      '$_keyIlerleme$_bugunKey',
      jsonEncode(_bugun),
    );
    await Future.wait([
      p.setInt(_keySeri, _seri),
      p.setInt(_keyUzun, _uzunSeri),
      p.setInt(_keyXp, _xp),
      p.setInt(_keyDondurucu, _dondurucu),
    ]);
  }

  static Future<List<HedefRozet>> _seriKontrol() async {
    if (!gunTamam) return const [];
    final p = await SharedPreferences.getInstance();
    final bugun = _bugunKey;
    final son = p.getString(_keySeriSon) ?? '';
    if (son == bugun) return const [];
    final dun = _tarih(DateTime.now().subtract(const Duration(days: 1)));
    _seri = son == dun ? _seri + 1 : 1;
    if (_seri > _uzunSeri) _uzunSeri = _seri;
    await p.setString(_keySeriSon, bugun);
    return _rozetKontrol();
  }

  static Future<List<HedefRozet>> _rozetKontrol() async {
    final p = await SharedPreferences.getInstance();
    final yeni = <HedefRozet>[];
    for (final r in kilometreTaslari) {
      if (_seri >= r.esik && !_rozetIdler.contains(r.id)) {
        _rozetIdler.add(r.id);
        yeni.add(r);
      }
    }
    if (yeni.isNotEmpty) {
      await p.setStringList(_keyRozetler, _rozetIdler.toList());
    }
    return yeni;
  }

  static Future<bool> dondurucuAl() async {
    if (_xp < dondurucuFiyati) return false;
    _xp -= dondurucuFiyati;
    _dondurucu++;
    await _kaydet();
    surum.value++;
    return true;
  }

  static Future<List<bool>> sonYediGun() async {
    final p = await SharedPreferences.getInstance();
    final sonuc = <bool>[];
    for (var i = 6; i >= 0; i--) {
      final gun = _tarih(DateTime.now().subtract(Duration(days: i)));
      final veri = _okunanVeri(p, gun);
      sonuc.add(gunlukGorevler.every((g) => (veri[g.tip] ?? 0) >= g.hedefSayi));
    }
    return sonuc;
  }

  static Map<GunlukHedefTipi, int> _okunanVeri(
    SharedPreferences p,
    String tarih,
  ) {
    final raw = p.getString('$_keyIlerleme$tarih');
    if (raw == null) return {};
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final sonuc = <GunlukHedefTipi, int>{};
      for (final e in map.entries) {
        final tip = GunlukHedefTipi.values
            .where((t) => t.name == e.key)
            .firstOrNull;
        if (tip != null) sonuc[tip] = (e.value as num).toInt();
      }
      return sonuc;
    } catch (_) {
      return {};
    }
  }
}

