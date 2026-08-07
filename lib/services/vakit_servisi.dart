import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'ayarlar_store.dart';

class VakitBilgisi {
  final String ad;
  final int saat;
  final int dakika;

  const VakitBilgisi(this.ad, this.saat, this.dakika);

  int get dakikaToplam => saat * 60 + dakika;

  String get saatYaz =>
      '${saat.toString().padLeft(2, '0')}:${dakika.toString().padLeft(2, '0')}';

  Map<String, dynamic> toJson() => {'ad': ad, 'saat': saat, 'dakika': dakika};

  static VakitBilgisi fromJson(Map<String, dynamic> j) =>
      VakitBilgisi(j['ad'] as String, j['saat'] as int, j['dakika'] as int);
}

/// Namaz vakitlerini Aladhan API'den alır, günlük önbelleğe alır ve
/// kullanıcının konumuna göre günceller.
class VakitServisi {
  VakitServisi._();

  static const List<String> vakitAdlari = [
    'İmsak',
    'Güneş',
    'Öğle',
    'İkindi',
    'Akşam',
    'Yatsı',
  ];

  /// İnternet yokken ya da konum seçilmeden önce kullanılan varsayılan vakitler.
  static const List<VakitBilgisi> varsayilan = [
    VakitBilgisi('İmsak', 4, 12),
    VakitBilgisi('Güneş', 5, 48),
    VakitBilgisi('Öğle', 13, 5),
    VakitBilgisi('İkindi', 16, 45),
    VakitBilgisi('Akşam', 20, 17),
    VakitBilgisi('Yatsı', 21, 50),
  ];

  static const _keyVakitler = 'vakitler_gunluk';
  static const _keyVakitGun = 'vakitler_gun';
  static const _keySehir = 'vakit_sehir';
  static const _keyUlke = 'vakit_ulke';
  static const _keyLat = 'vakit_lat';
  static const _keyLng = 'vakit_lng';
  static const _keyKonumDenendi = 'vakit_konum_denendi';

  /// Konum veya hesaplama yöntemi değişince tetiklenir; açık ekranlar
  /// (ana sayfa vakit kartları vb.) dinleyerek vakitleri yeniden yükler.
  static final ValueNotifier<int> vakitGuncellendi = ValueNotifier<int>(0);

  static Future<SharedPreferences> get _p => SharedPreferences.getInstance();

  /// İlk açılışta bir kez GPS konumu dener ve vakitleri tazeler.
  /// "Otomatik Konum (GPS)" ayarı kapalıysa GPS hiç istenmez.
  static Future<void> ilkkonum() async {
    final p = await _p;
    if (!(p.getBool('ayar_konum_otomatik') ?? true)) return;
    final sehir = p.getString(_keySehir);
    final koordinat = p.getDouble(_keyLat);
    if (p.getBool(_keyKonumDenendi) ?? false) return;
    await p.setBool(_keyKonumDenendi, true);
    if (sehir == null && koordinat == null) {
      await konumuOtomatikAl();
      await _cacheTemizle();
    }
  }

  static String _tarihKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static String _tarihApi(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

  // ---------------- KONUM ----------------

  static Future<String?> sehirOku() async =>
      (await _p).getString(_keySehir);

  static Future<String?> ulkeOku() async =>
      (await _p).getString(_keyUlke);

  static Future<(double, double)?> koordinatOku() async {
    final p = await _p;
    final lat = p.getDouble(_keyLat);
    final lng = p.getDouble(_keyLng);
    if (lat == null || lng == null) return null;
    return (lat, lng);
  }

  static Future<void> konumKaydet({
    String? sehir,
    String? ulke,
    double? lat,
    double? lng,
  }) async {
    final p = await _p;
    if (sehir != null) await p.setString(_keySehir, sehir);
    if (ulke != null) await p.setString(_keyUlke, ulke);
    if (lat != null) await p.setDouble(_keyLat, lat);
    if (lng != null) await p.setDouble(_keyLng, lng);
    await _cacheTemizle();
    vakitGuncellendi.value++;
  }

  /// GPS ile konumu alır, kaydeder ve şehir/ülke adını bulur.
  /// Başarılı olursa true döner.
  static Future<bool> konumuOtomatikAl() async {
    try {
      final servis = GeolocatorPlatform.instance;
      if (!await servis.isLocationServiceEnabled()) return false;

      LocationPermission izin = await servis.checkPermission();
      if (izin == LocationPermission.denied) {
        izin = await servis.requestPermission();
      }
      if (izin == LocationPermission.denied ||
          izin == LocationPermission.deniedForever) {
        return false;
      }

      final konum = await servis.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 12),
        ),
      );

      await konumKaydet(lat: konum.latitude, lng: konum.longitude);

      // Şehir/ülke adını bul (Nominatim, anahtarsız ücretsiz reverse coğrafi
      // kodlama). Başarısız olursa koordinatlarla devam edilir.
      try {
        final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse'
          '?lat=${konum.latitude}&lon=${konum.longitude}'
          '&format=json&zoom=8',
        );
        final cevap = await http.get(url, headers: const {
          'User-Agent': 'islami_uygulama/1.0',
        }).timeout(const Duration(seconds: 10));
        if (cevap.statusCode == 200) {
          final g = jsonDecode(cevap.body)['address'] as Map<String, dynamic>;
          final sehir = (g['city'] ?? g['town'] ?? g['village'] ?? g['state'])
              as String?;
          final ulke = g['country'] as String?;
          if (sehir != null) await konumKaydet(sehir: sehir);
          if (ulke != null) await konumKaydet(ulke: ulke);
        }
      } catch (_) {
        // Şehir adı bulunamazsa koordinatlarla devam edilir.
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  // ---------------- VAKİTLER ----------------

  static Future<List<VakitBilgisi>> gunlukVakitler() async {
    final p = await _p;
    final bugun = _tarihKey(DateTime.now());
    if (p.getString(_keyVakitGun) == bugun) {
      final raw = p.getString(_keyVakitler);
      if (raw != null && raw.isNotEmpty) {
        try {
          final list = jsonDecode(raw) as List<dynamic>;
          return list
              .map((e) => VakitBilgisi.fromJson(e as Map<String, dynamic>))
              .toList();
        } catch (_) {
          // bozuk önbellek → yeniden çek
        }
      }
    }
    return _cikar();
  }

  static Future<void> _cacheTemizle() async {
    final p = await _p;
    await p.remove(_keyVakitler);
    await p.remove(_keyVakitGun);
  }

  /// Kesin güncel veri isteyen çağrıcılar (yöntem/konum değişikliği) için:
  /// önbelleği atlar, API'den yeniden çeker ve ekranları bilgilendirir.
  static Future<List<VakitBilgisi>> vakitleriYenile() async {
    final liste = await _cikar();
    vakitGuncellendi.value++;
    return liste;
  }

  static Future<List<VakitBilgisi>> _cikar() async {
    List<VakitBilgisi> vakitler;
    try {
      vakitler = await _apiGetir();
    } catch (_) {
      vakitler = varsayilan;
    }
    final p = await _p;
    await p.setString(
      _keyVakitler,
      jsonEncode(vakitler.map((v) => v.toJson()).toList()),
    );
    await p.setString(_keyVakitGun, _tarihKey(DateTime.now()));
    return vakitler;
  }

  static Future<List<VakitBilgisi>> _apiGetir() async {
    final bugun = _tarihApi(DateTime.now());

    final method = await aktifMetotKodu();

final koordinat = await koordinatOku();
      final Uri url;
      if (koordinat != null) {
        url = Uri.parse(
          'https://api.aladhan.com/v1/timings'
          '?latitude=${koordinat.$1}&longitude=${koordinat.$2}'
          '&date=$bugun&method=$method',
        );
      } else {
      final sehir = await sehirOku() ?? 'İstanbul';
      final ulkeKod = (await ulkeOku()) ?? 'Türkiye';
      url = Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity'
        '?city=${Uri.encodeComponent(sehir)}'
        '&country=${Uri.encodeComponent(ulkeKod)}'
        '&date=$bugun&method=$method',
      );
    }

    final cevap = await http.get(url, headers: const {
      'User-Agent': 'islami_uygulama/1.0',
    }).timeout(const Duration(seconds: 12));

    if (cevap.statusCode != 200) {
      throw Exception('Vakit API hatası: ${cevap.statusCode}');
    }

    const apiMap = {
      'Fajr': 'İmsak',
      'Sunrise': 'Güneş',
      'Dhuhr': 'Öğle',
      'Asr': 'İkindi',
      'Maghrib': 'Akşam',
      'Isha': 'Yatsı',
    };

    final timings =
        jsonDecode(cevap.body)['data']['timings'] as Map<String, dynamic>;
    final cikti = <VakitBilgisi>[];
    apiMap.forEach((apiAd, trAd) {
      final deger = timings[apiAd] as String?;
      if (deger != null && deger.contains(':')) {
        final parca = deger.split(':');
        cikti.add(
          VakitBilgisi(trAd, int.parse(parca[0]), int.parse(parca[1])),
        );
      }
    });
    if (cikti.length != 6) throw Exception('Eksik vakit verisi');
    return cikti;
  }

  /// Kullanıcının seçimini; seçim yoksa bulunduğu ülkeye göre uygulanan
  /// gerçek hesaplama yöntemini döndürür.
  static Future<String> aktifMetotKodu() async {
    final secili = await AyarlarStore.metotOku();
    if (secili != null && secili.isNotEmpty) return secili;

    final ulke = (await ulkeOku())?.toLowerCase() ?? '';
    // Konum henüz belirlenmediyse varsayılan şehir İstanbul'dur.
    final turkiye = ulke.isEmpty || ulke.contains('turk') || ulke.contains('türk');
    return turkiye ? AyarlarStore.diyanetKod : AyarlarStore.mwlKod;
  }

  // ---------------- SIRADAKİ VAKİT ----------------

  /// Sıradaki vakti döner: (ad, saat, kalanYazı). Vakit yoksa null.
  static (String, String, String)? siradakiVakit(DateTime now) {
    return siradakiVakitListede(now, varsayilan);
  }

  static (String, String, String)? siradakiVakitListede(
    DateTime now,
    List<VakitBilgisi> vakitler,
  ) {
    final simdiDk = now.hour * 60 + now.minute;
    VakitBilgisi? secilen;
    for (final v in vakitler) {
      if (v.dakikaToplam > simdiDk) {
        secilen = v;
        break;
      }
    }
    if (secilen == null) return null;
    final kalanDk = secilen.dakikaToplam - simdiDk;
    if (kalanDk <= 0) return null;
    final h = kalanDk ~/ 60;
    final m = kalanDk % 60;
    final kalanYaz = h > 0 ? '$h saat $m dk' : '$m dk';
    return (secilen.ad, secilen.saatYaz, kalanYaz);
  }

  /// Akşam vaktini (iftar) döner; bulunamazsa null.
  static VakitBilgisi? aksamVakti(List<VakitBilgisi> vakitler) {
    for (final v in vakitler) {
      if (v.ad == 'Akşam') return v;
    }
    return null;
  }

  // ---------------- KIBLE ----------------

  static const double _kabeLat = 21.4225;
  static const double _kabeLng = 39.8262;

  /// Koordinatlara göre Kıble açısını (derece) hesaplar.
  static double kibleAcisi(double lat, double lng) {
    double rad(double d) => d * math.pi / 180;
    final dLng = rad(_kabeLng - lng);
    final phi1 = rad(lat);
    final phi2 = rad(_kabeLat);
    final y = math.sin(dLng);
    final x = math.cos(phi1) * math.tan(phi2) - math.sin(phi1) * math.cos(dLng);
    final derece = (math.atan2(y, x) * 180 / math.pi + 360) % 360;
    return derece;
  }

  static String yonEtiketi(double derece) {
    if (derece >= 337.5 || derece < 22.5) return 'K';
    if (derece < 67.5) return 'KD';
    if (derece < 112.5) return 'D';
    if (derece < 157.5) return 'GD';
    if (derece < 202.5) return 'G';
    if (derece < 247.5) return 'GB';
    if (derece < 292.5) return 'B';
    return 'KB';
  }

  /// Kâbe'ye haversine formülüyle uzaklık (km).
  static double kabeUzakligiKm(double lat, double lng) {
    const R = 6371.0;
    double rad(double d) => d * math.pi / 180;
    final dLat = rad(_kabeLat - lat);
    final dLng = rad(_kabeLng - lng);
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(rad(lat)) *
            math.cos(rad(_kabeLat)) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return R * c;
  }
}
