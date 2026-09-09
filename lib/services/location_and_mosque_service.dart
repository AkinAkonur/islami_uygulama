import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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

    // Ana sunucu erişilemezse sıradaki yedek sunucu denenir.
    const overpassSunuculari = [
      'https://overpass-api.de/api/interpreter',
      'https://maps.mail.ru/osm/tools/overpass/api/interpreter',
      'https://overpass.osm.ch/api/interpreter',
      'https://overpass.kumi.systems/api/interpreter',
    ];

    for (final overpassUrl in overpassSunuculari) {
      try {
        final response = await http
            .post(
              Uri.parse(overpassUrl),
              body: {'data': query},
            )
            .timeout(const Duration(seconds: 20));

        if (response.statusCode == 200) {
          final data = json.decode(utf8.decode(response.bodyBytes));
          final List elements = data['elements'] ?? [];

          List<Mosque> mosques = [];

          for (var element in elements) {
            String name = element['tags']?['name'] ?? 'Cami (İsimsiz)';
            double mLat = element['lat'] ?? element['center']?['lat'] ?? 0.0;
            double mLng = element['lon'] ?? element['center']?['lon'] ?? 0.0;

            if (mLat != 0.0 && mLng != 0.0) {
              double distance = Geolocator.distanceBetween(
                lat,
                lng,
                mLat,
                mLng,
              );
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
        }
      } catch (e) {
        debugPrint('Cami arama hatası ($overpassUrl): $e');
      }
    }
    return [];
  }

  /// 3. Hem Konumu Alan Hem De Camileri Tek Hamlede Getiren Ana Fonksiyon
  static Future<List<Mosque>> getKonumVeCamiler(BuildContext context) async {
    Position? position = await getCurrentLocation(context);
    if (position == null) return [];

    return await fetchNearbyMosques(position.latitude, position.longitude);
  }

  /// 4. Seçilen Camiye Yol Tarifi Al (Google Maps / Apple Maps / Waze)
  static Future<bool> yolTarifiAc(
    Mosque cami, {
    String? baslangicLat,
    String? baslangicLng,
    String mod = 'walking',
  }) async {
    final dest = '$cami.lat,$cami.lng';
    final baslangic = baslangicLat != null && baslangicLng != null
        ? '$baslangicLat,$baslangicLng'
        : null;
    final yon = baslangic != null ? '&origin=$baslangic' : '';

    final Uri? uri;
    if (Platform.isIOS) {
      uri = Uri.parse(
        'https://maps.apple.com/?daddr=$dest$yon&dirflg=${mod == 'driving' ? 'd' : 'w'}',
      );
    } else if (Platform.isAndroid) {
      uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1$yon&destination=$dest&travelmode=$mod',
      );
    } else {
      uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1$yon&destination=$dest&travelmode=$mod',
      );
    }

    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  /// 5. Camiyi Haritada Konumlarıyla Göster
  static Future<bool> haritadaGoster(Mosque cami) async {
    final uri = Uri.parse(
      Platform.isIOS
          ? 'https://maps.apple.com/?q=${cami.lat},${cami.lng}'
          : 'https://www.google.com/maps/search/?api=1&query=${cami.lat},${cami.lng}',
    );
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
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