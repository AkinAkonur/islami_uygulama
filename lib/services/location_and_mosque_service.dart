import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import 'vakit_servisi.dart';

/// Yakındaki tek bir cami kaydı.
class Mosque {
  final String name;
  final double lat;
  final double lng;
  final double? distanceInMeters;

  Mosque({
    required this.name,
    required this.lat,
    required this.lng,
    this.distanceInMeters,
  });
}

/// GPS, önbellek/IP yedeği, Overpass cami araması ve harita yönlendirmesi.
class LocationAndMosqueService {
  LocationAndMosqueService._();

  /// İzinleri kontrol ederek güncel konumu alır. Canlı GPS zaman aşımına
  /// uğrarsa son bilinen cihaz konumunu kullanır.
  static Future<Position?> getCurrentLocation(BuildContext context) async {
    final l = AppLocalizations.of(context);
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (context.mounted) {
          _showMessage(
            context,
            l.t('ko.locationServiceOff'),
            actionText: l.t('c.manage'),
            onPressed: Geolocator.openLocationSettings,
          );
        }
        return null;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          _showMessage(context, l.t('ko.permissionDenied'));
        }
        return null;
      }
      if (permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          _showMessage(
            context,
            l.t('ko.permissionPermanent'),
            actionText: l.t('c.manage'),
            onPressed: Geolocator.openAppSettings,
          );
        }
        return null;
      }

      try {
        return await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
            timeLimit: Duration(seconds: 20),
          ),
        );
      } catch (e) {
        debugPrint('Cami GPS canlı konum alınamadı: $e');
        // Bina içinde canlı GPS fix'i gecikebilir; cihazın son geçerli konumu
        // cami araması için yeterlidir.
        try {
          final son = await Geolocator.getLastKnownPosition();
          if (son != null) return son;
        } catch (sonHata) {
          debugPrint('Cami GPS son konum alınamadı: $sonHata');
        }
        if (context.mounted) {
          _showMessage(context, l.t('ko.locationFailed'));
        }
        return null;
      }
    } catch (e) {
      debugPrint('Cami GPS izin/servis hatası: $e');
      if (context.mounted) {
        _showMessage(context, l.t('ko.locationFailed'));
      }
      return null;
    }
  }

  /// Verilen koordinat çevresindeki camileri OpenStreetMap/Overpass üzerinden
  /// arar. Farklı etiketleme biçimlerini kapsar; sunucu bozuksa yedek sunucuya
  /// geçer.
  static Future<List<Mosque>> fetchNearbyMosques(
    double lat,
    double lng, {
    double radiusInMeters = 10000,
  }) async {
    final query = '''
[out:json][timeout:25];
(
  nwr["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusInMeters,$lat,$lng);
  nwr["building"="mosque"](around:$radiusInMeters,$lat,$lng);
);
out center tags;
''';

    const overpassSunuculari = [
      'overpass-api.de',
      'overpass.kumi.systems',
      'overpass.osm.ch',
    ];

    for (final host in overpassSunuculari) {
      try {
        final uri = Uri.https(host, '/api/interpreter');
        final response = await http
            .post(
              uri,
              headers: const {
                'User-Agent': 'islami_uygulama/1.0 (nearby-mosques)',
                'Accept': 'application/json',
              },
              body: {'data': query},
            )
            .timeout(const Duration(seconds: 28));
        if (response.statusCode != 200) {
          debugPrint('Cami Overpass $host HTTP ${response.statusCode}');
          continue;
        }

        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        if (decoded is! Map<String, dynamic>) continue;
        final elements = decoded['elements'];
        if (elements is! List) continue;

        final camiler = <Mosque>[];
        final gorulen = <String>{};
        for (final raw in elements) {
          if (raw is! Map<String, dynamic>) continue;
          final tags = raw['tags'];
          final tagMap = tags is Map<String, dynamic>
              ? tags
              : const <String, dynamic>{};
          final center = raw['center'];
          final centerMap = center is Map<String, dynamic>
              ? center
              : const <String, dynamic>{};
          final latRaw = raw['lat'] ?? centerMap['lat'];
          final lngRaw = raw['lon'] ?? centerMap['lon'];
          if (latRaw is! num || lngRaw is! num) continue;
          final mLat = latRaw.toDouble();
          final mLng = lngRaw.toDouble();
          if (mLat == 0 || mLng == 0) continue;

          final osmId = '${raw['type']}:${raw['id']}';
          if (!gorulen.add(osmId)) continue;
          final adRaw = tagMap['name'] ??
              tagMap['name:tr'] ??
              tagMap['official_name'] ??
              tagMap['alt_name'];
          final ad = adRaw is String && adRaw.trim().isNotEmpty
              ? adRaw.trim()
              : 'Cami';
          final mesafe = Geolocator.distanceBetween(lat, lng, mLat, mLng);
          camiler.add(
            Mosque(
              name: ad,
              lat: mLat,
              lng: mLng,
              distanceInMeters: mesafe,
            ),
          );
        }
        camiler.sort(
          (a, b) => (a.distanceInMeters ?? double.infinity)
              .compareTo(b.distanceInMeters ?? double.infinity),
        );
        return camiler;
      } catch (e) {
        debugPrint('Cami arama hatası ($host): $e');
      }
    }
    return const <Mosque>[];
  }

  /// Önce canlı GPS'i, sonra uygulamada kayıtlı koordinatı, son olarak
  /// VakitServisi'nin GPS/IP yedeğini kullanarak camileri getirir.
  static Future<List<Mosque>> getKonumVeCamiler(BuildContext context) async {
    final position = await getCurrentLocation(context);
    if (position != null) {
      await VakitServisi.konumKaydet(
        lat: position.latitude,
        lng: position.longitude,
      );
      return fetchNearbyMosques(position.latitude, position.longitude);
    }

    var koordinat = await VakitServisi.koordinatOku();
    if (koordinat == null) {
      await VakitServisi.konumuOtomatikAl();
      koordinat = await VakitServisi.koordinatOku();
    }
    if (koordinat == null) return const <Mosque>[];
    return fetchNearbyMosques(koordinat.$1, koordinat.$2);
  }

  /// Seçilen camiye Google/Apple Maps ile yol tarifi açar.
  static Future<bool> yolTarifiAc(
    Mosque cami, {
    String? baslangicLat,
    String? baslangicLng,
    String mod = 'walking',
  }) async {
    final params = <String, String>{};
    final Uri uri;
    if (Platform.isIOS) {
      params['daddr'] = '${cami.lat},${cami.lng}';
      if (baslangicLat != null && baslangicLng != null) {
        params['saddr'] = '$baslangicLat,$baslangicLng';
      }
      params['dirflg'] = mod == 'driving' ? 'd' : 'w';
      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      params['api'] = '1';
      params['destination'] = '${cami.lat},${cami.lng}';
      params['travelmode'] = mod;
      if (baslangicLat != null && baslangicLng != null) {
        params['origin'] = '$baslangicLat,$baslangicLng';
      }
      uri = Uri.https('www.google.com', '/maps/dir/', params);
    }
    return _disaridaAc(uri);
  }

  /// Camiyi harita uygulamasında işaretler.
  static Future<bool> haritadaGoster(Mosque cami) async {
    final Uri uri;
    if (Platform.isIOS) {
      uri = Uri.https(
        'maps.apple.com',
        '/',
        {'q': '${cami.lat},${cami.lng}'},
      );
    } else {
      uri = Uri.https(
        'www.google.com',
        '/maps/search/',
        {'api': '1', 'query': '${cami.lat},${cami.lng}'},
      );
    }
    return _disaridaAc(uri);
  }

  static Future<bool> _disaridaAc(Uri uri) async {
    try {
      // Bazı Android sürümlerinde canLaunchUrl paket görünürlüğü nedeniyle
      // false dönebilir; doğrudan launch denemesi daha güvenilirdir.
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Harita açılamadı ($uri): $e');
      return false;
    }
  }

  static void _showMessage(
    BuildContext context,
    String message, {
    String? actionText,
    VoidCallback? onPressed,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: actionText != null && onPressed != null
            ? SnackBarAction(label: actionText, onPressed: onPressed)
            : null,
      ),
    );
  }
}
