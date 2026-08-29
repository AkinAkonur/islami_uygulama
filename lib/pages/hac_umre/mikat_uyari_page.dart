import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../../widgets/kart_sekilleri.dart';
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
      final l = AppLocalizations.of(context);
      if (!await Geolocator.isLocationServiceEnabled()) {
        await Geolocator.openLocationSettings();
        throw Exception(l.t('mu.locService'));
      }
      LocationPermission izin = await Geolocator.checkPermission();
      if (izin == LocationPermission.denied) {
        izin = await Geolocator.requestPermission();
      }
      if (izin == LocationPermission.denied) {
        throw Exception(l.t('mu.permissionDenied'));
      }
      if (izin == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        throw Exception(l.t('mu.permissionForever'));
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
    final l = AppLocalizations.of(context);
    final enYakin = _enYakin();
    final uyariSeviyesi = enYakin == null
        ? 0
        : (enYakin.$2 <= mikatYakinlik2
              ? 2
              : (enYakin.$2 <= mikatYakinlik1 ? 1 : 0));

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('mu.title')),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UcdIkon(
                  ikon: Icons.gps_fixed_rounded,
                  renk: Color(0xFFD4AF37),
                  boyut: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l.t('mu.desc'),
                    style: const TextStyle(
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
            _UyariKarti(seviye: uyariSeviyesi, mikat: enYakin.$1, l: l)
          else if (enYakin != null)
            _NormalKart(
              mesafe: _mesafeMetin(enYakin.$2),
              mikat: enYakin.$1,
              l: l,
            )
          else
            _BeklemeKarti(l: l),
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
                        icon: const UcdIkon(
                          ikon: Icons.stop_circle_rounded,
                          renk: Colors.redAccent,
                        ),
                        label: Text(l.t('mu.stopTracking')),
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
                            : const UcdIkon(
                                ikon: Icons.play_arrow_rounded,
                                renk: Colors.white,
                              ),
                        label: Text(l.t('mu.startTracking')),
                      ),
              ),
              const SizedBox(width: 12),
              IconButton(
                tooltip: l.t('mu.refresh'),
                onPressed: _yukleniyor ? null : _konumAl,
                style: IconButton.styleFrom(
                  backgroundColor: Renkler.kart,
                  disabledForegroundColor: Colors.white24,
                ),
                icon: const UcdIkon(
                  ikon: Icons.my_location_rounded,
                  renk: Colors.white70,
                ),
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
                  const UcdIkon(
                    ikon: Icons.error_outline_rounded,
                    renk: Colors.redAccent,
                  ),
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
              Text(
                l.t('mu.boundaries'),
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (_izliyor)
                Text(
                  l
                      .t('mu.updatedEvery')
                      .replaceFirst('{s}', '$_guncellemeSaniye'),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const UcdIkon(
                      ikon: Icons.flight_takeoff_rounded,
                      renk: Colors.amberAccent,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l.t('mu.planeTitle'),
                      style: const TextStyle(
                        color: Colors.amberAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  mikatUcakUyari,
                  style: const TextStyle(
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
  final AppLocalizations l;

  const _UyariKarti({
    required this.seviye,
    required this.mikat,
    required this.l,
  });

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
              UcdIkon(
                ikon: ciddi
                    ? Icons.notification_important_rounded
                    : Icons.warning_amber_rounded,
                renk: renk,
                boyut: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  ciddi ? l.t('mu.veryClose') : l.t('mu.approaching'),
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
            '${l.t('mu.nearest').replaceFirst('{n}', mikat.ad)}\n${mikat.aciklama}\n\n${ciddi ? l.t('mu.seriousHint') : l.t('mu.prepareHint')}',
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
  final AppLocalizations l;

  const _NormalKart({
    required this.mesafe,
    required this.mikat,
    required this.l,
  });

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
          const UcdIkon(
            ikon: Icons.check_circle_outline_rounded,
            renk: Colors.greenAccent,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l
                  .t('mu.normalText')
                  .replaceFirst('{n}', mikat.ad)
                  .replaceFirst('{d}', mesafe),
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
  final AppLocalizations l;

  const _BeklemeKarti({required this.l});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          const UcdIkon(ikon: Icons.gps_off_rounded, renk: Colors.white38),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l.t('mu.waiting'),
              style: const TextStyle(
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
          const UcdIkon(ikon: Icons.location_on_rounded, renk: Colors.white38),
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
