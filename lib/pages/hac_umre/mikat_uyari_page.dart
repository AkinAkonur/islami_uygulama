import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../services/renkler.dart';
import 'hac_umre_verileri.dart';
import 'mikat_verileri.dart';

// ===========================================================================
// MİKAT UYARI MOTORU - GPS TABANLI
// Kullanıcı mikat sınırına yaklaşırken (50 km / 10 km) uyarı verir.
// İzleme açıkken konum belirli aralıklarla yenilenir.
// ===========================================================================

class MikatUyariPage extends StatefulWidget {
  const MikatUyariPage({super.key});

  @override
  State<MikatUyariPage> createState() => _MikatUyariPageState();
}

class _MikatUyariPageState extends State<MikatUyariPage> {
  Position? _konum;
  bool _yukleniyor = false;
  bool _izliyor = false;
  String? _hata;
  Timer? _timer;
  final int _guncellemeSaniye = 15;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _konumAl() async {
    setState(() {
      _yukleniyor = true;
      _hata = null;
    });
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        await Geolocator.openLocationSettings();
        throw Exception('Konum servisi kapalı.');
      }
      LocationPermission izin = await Geolocator.checkPermission();
      if (izin == LocationPermission.denied) {
        izin = await Geolocator.requestPermission();
      }
      if (izin == LocationPermission.denied) {
        throw Exception('Konum izni verilmedi.');
      }
      if (izin == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        throw Exception('Konum izni kalıcı olarak reddedilmiş.');
      }
      Position? konum;
      try {
        konum = await Geolocator.getLastKnownPosition();
      } catch (_) {}
      konum ??= await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 12),
        ),
      );
      if (mounted) setState(() => _konum = konum);
    } catch (e) {
      if (mounted) setState(() => _hata = e.toString());
    } finally {
      if (mounted) setState(() => _yukleniyor = false);
    }
  }

  void _izlemeyiBaslat() {
    if (_izliyor) return;
    setState(() => _izliyor = true);
    _konumAl();
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(seconds: _guncellemeSaniye),
      (_) => _konumAl(),
    );
  }

  void _izlemeyiDurdur() {
    _timer?.cancel();
    setState(() => _izliyor = false);
  }

  double? _mesafe(MikatNoktasi m) {
    final k = _konum;
    if (k == null) return null;
    return Geolocator.distanceBetween(
          k.latitude,
          k.longitude,
          m.enlem,
          m.boylam,
        ) /
        1000;
  }

  /// En yakın mikat ve mesafesi.
  (MikatNoktasi, double)? _enYakin() {
    if (_konum == null) return null;
    MikatNoktasi? enYakin;
    double? enKucuk;
    for (final m in mikatNoktalari) {
      final d = _mesafe(m)!;
      if (enKucuk == null || d < enKucuk) {
        enKucuk = d;
        enYakin = m;
      }
    }
    if (enYakin == null || enKucuk == null) return null;
    return (enYakin, enKucuk);
  }

  String _mesafeMetin(double km) {
    if (km < 1) return '${(km * 1000).round()} m';
    if (km < 100) return '${km.toStringAsFixed(1)} km';
    return '${km.round()} km';
  }

  @override
  Widget build(BuildContext context) {
    final enYakin = _enYakin();
    final uyariSeviyesi = enYakin == null
        ? 0
        : (enYakin.$2 <= mikatYakinlik2
              ? 2
              : (enYakin.$2 <= mikatYakinlik1 ? 1 : 0));

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Mikat Uyarı Motoru'),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Açıklama
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.gps_fixed, color: Colors.purpleAccent, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Uçak veya kara yoluyla Mekke\'ye yaklaşırken mikat sınırına '
                    '50 km ve 10 km kala burada uyarı alırsınız. İhram için '
                    'önceden hazırlanmayı unutmayın.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Uyarı seviyesi
          if (enYakin != null && uyariSeviyesi > 0)
            _UyariKarti(seviye: uyariSeviyesi, mikat: enYakin.$1)
          else if (enYakin != null)
            _NormalKart(mesafe: _mesafeMetin(enYakin.$2), mikat: enYakin.$1)
          else
            _BeklemeKarti(),
          const SizedBox(height: 16),
          // Kontroller
          Row(
            children: [
              Expanded(
                child: _izliyor
                    ? OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _izlemeyiDurdur,
                        icon: const Icon(Icons.stop_circle_outlined),
                        label: const Text('İzlemeyi Durdur'),
                      )
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Renkler.vurgu.withValues(alpha: 0.2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _yukleniyor ? null : _izlemeyiBaslat,
                        icon: _yukleniyor
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.play_arrow),
                        label: const Text('İzlemeyi Başlat'),
                      ),
              ),
              const SizedBox(width: 12),
              IconButton(
                tooltip: 'Konumu yenile',
                onPressed: _yukleniyor ? null : _konumAl,
                style: IconButton.styleFrom(
                  backgroundColor: Renkler.kart,
                  disabledForegroundColor: Colors.white24,
                ),
                icon: const Icon(Icons.my_location, color: Colors.white70),
              ),
            ],
          ),
          if (_hata != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.redAccent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _hata!,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          // Mikat listesi
          Row(
            children: [
              const Text(
                'MİKAT SINIRLARI',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (_izliyor)
                Text(
                  'Her $_guncellemeSaniye sn güncellenir',
                  style: const TextStyle(color: Colors.white24, fontSize: 11),
                ),
            ],
          ),
          const SizedBox(height: 8),
          for (final m in mikatNoktalari)
            _MikatSatir(
              mikat: m,
              mesafe: _mesafe(m),
              mesafeMetin: _mesafeMetin,
              vurgula: enYakin?.$1.ad == m.ad,
            ),
          const SizedBox(height: 16),
          // Uçak uyarısı
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.amberAccent.withValues(alpha: 0.3),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.flight_takeoff, color: Colors.amberAccent),
                    SizedBox(width: 8),
                    Text(
                      'Uçakla Geliyorsanız',
                      style: TextStyle(
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  mikatUcakUyari,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// YARDIMCI KARTLAR
// ===========================================================================

class _UyariKarti extends StatelessWidget {
  final int seviye;
  final MikatNoktasi mikat;

  const _UyariKarti({required this.seviye, required this.mikat});

  @override
  Widget build(BuildContext context) {
    final ciddi = seviye == 2;
    final renk = ciddi ? Colors.redAccent : Colors.orangeAccent;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: renk.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: renk, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                ciddi ? Icons.notification_important : Icons.warning_amber,
                color: renk,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  ciddi
                      ? 'Mikat sınırına çok yakınsınız!'
                      : 'Mikat sınırına yaklaşıyorsunuz',
                  style: TextStyle(
                    color: renk,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'En yakın mikat: ${mikat.ad}\n'
            '${mikat.aciklama}\n\n'
            '${ciddi ? "Lütfen ihrama girmiş ve niyet etmiş olduğunuzdan emin olun!" : "İhram hazırlığınızı yapın: gusül, ihram elbisesi, iki rekât namaz ve telbiye ile niyet."}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _NormalKart extends StatelessWidget {
  final String mesafe;
  final MikatNoktasi mikat;

  const _NormalKart({required this.mesafe, required this.mikat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.greenAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'En yakın mikat: ${mikat.ad}\n'
              'Mesafe: $mesafe · Henüz uyarı sınırında değilsiniz.',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BeklemeKarti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: const Row(
        children: [
          Icon(Icons.gps_off, color: Colors.white38),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Konumunuz henüz alınmadı. İzlemeyi başlatın veya konum butonuna '
              'dokunun.',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MikatSatir extends StatelessWidget {
  final MikatNoktasi mikat;
  final double? mesafe;
  final String Function(double) mesafeMetin;
  final bool vurgula;

  const _MikatSatir({
    required this.mikat,
    required this.mesafe,
    required this.mesafeMetin,
    required this.vurgula,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: vurgula ? Renkler.seciliYuzey : Renkler.kart,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: vurgula
              ? Renkler.vurgu.withValues(alpha: 0.5)
              : Renkler.cerceve,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.white38),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mikat.ad,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  mikat.yon,
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            mesafe == null ? '—' : mesafeMetin(mesafe!),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
