import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

/// Cami Model Sınıfı
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

/// Konum ve Yakındaki Camileri Yöneten Tam Servis
class LocationAndMosqueService {
  /// 1. Kullanıcının Konumunu Güvenli Şekilde Alır (İzinler ve GPS Açıklığı Kontrol Edilir)
  static Future<Position?> getCurrentLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // GPS / Konum Servisi Açık mı?
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        _showMessage(context, 'Lütfen cihazınızın Konum (GPS) servisini açın.');
      }
      return null;
    }

    // İzin Kontrolü
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          _showMessage(context, 'Konum izni reddedildi.');
        }
        return null;
      }
    }

    // Kalıcı Olarak Engellendi mi?
    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        _showMessage(
          context,
          'Konum izni kalıcı olarak engellenmiş. Lütfen ayarlardan izin verin.',
          actionText: 'Ayarlar',
          onPressed: () => Geolocator.openAppSettings(),
        );
      }
      return null;
    }

    // Konumu Getir
    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 12),
        ),
      );
    } catch (e) {
      if (context.mounted) {
        _showMessage(context, 'Konum bilgisi alınamadı: $e');
      }
      return null;
    }
  }

  /// 2. Alınan Enlem ve Boylama Göre OpenStreetMap (Overpass API) Üzerinden Yakındaki Camileri Çeker
  static Future<List<Mosque>> fetchNearbyMosques(
    double lat,
    double lng, {
    double radiusInMeters = 5000,
  }) async {
    final String overpassUrl = 'https://overpass-api.de/api/interpreter';

    // 5 km yarıçapındaki Müslüman ibadethanelerini sorgular
    final String query = '''
      [out:json];
      (
        node["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusInMeters,$lat,$lng);
        way["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusInMeters,$lat,$lng);
        relation["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusInMeters,$lat,$lng);
      );
      out center;
    ''';

    try {
      final response = await http.post(
        Uri.parse(overpassUrl),
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        final List elements = data['elements'] ?? [];

        List<Mosque> mosques = [];

        for (var element in elements) {
          String name = element['tags']?['name'] ?? 'Cami (İsimsiz)';
          double mLat = element['lat'] ?? element['center']?['lat'] ?? 0.0;
          double mLng = element['lon'] ?? element['center']?['lon'] ?? 0.0;

          if (mLat != 0.0 && mLng != 0.0) {
            double distance = Geolocator.distanceBetween(lat, lng, mLat, mLng);
            mosques.add(
              Mosque(
                name: name,
                lat: mLat,
                lng: mLng,
                distanceInMeters: distance,
              ),
            );
          }
        }

        // En yakın camiden en uzağa doğru sırala
        mosques.sort(
          (a, b) =>
              (a.distanceInMeters ?? 0).compareTo(b.distanceInMeters ?? 0),
        );
        return mosques;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Cami arama hatası: $e');
      return [];
    }
  }

  /// 3. Hem Konumu Alan Hem De Camileri Tek Hamlede Getiren Ana Fonksiyon
  static Future<List<Mosque>> getKonumVeCamiler(BuildContext context) async {
    Position? position = await getCurrentLocation(context);
    if (position == null) return [];

    return await fetchNearbyMosques(position.latitude, position.longitude);
  }

  // Bildirim Kutusu Yardımcısı
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