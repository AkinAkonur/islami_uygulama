import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

import '../services/renkler.dart';
import '../services/vakit_servisi.dart';
import '../l10n/app_localizations.dart';

class KiblePusulaPage extends StatefulWidget {
  const KiblePusulaPage({super.key});

  @override
  State<KiblePusulaPage> createState() => _KiblePusulaPageState();
}

class _KiblePusulaPageState extends State<KiblePusulaPage> {
  StreamSubscription<CompassEvent>? _pusulaDinleyicisi;
  double? _cihazYonu;
  double? _kibleAcisi;
  double? _uzaklikKm;
  bool _konumYukleniyor = true;
  bool _pusulaKullanilamiyor = false;
  Timer? _sensorBeklemeZamani;

  @override
  void initState() {
    super.initState();
    _pusulayiBaslat();
    _konumuYukle();
  }

  void _pusulayiBaslat() {
    final events = FlutterCompass.events;
    if (events == null) {
      _pusulaKullanilamiyor = true;
      return;
    }
    _sensorBeklemeZamani = Timer(const Duration(seconds: 4), () {
      if (mounted && _cihazYonu == null) {
        setState(() => _pusulaKullanilamiyor = true);
      }
    });
    try {
      _pusulaDinleyicisi = events.listen(
        (event) {
          final heading = event.heading;
          if (heading == null || heading < 0 || !mounted) return;
          _sensorBeklemeZamani?.cancel();
          setState(() {
            _cihazYonu = heading % 360;
            _pusulaKullanilamiyor = false;
          });
        },
        onError: (_) {
          if (mounted) setState(() => _pusulaKullanilamiyor = true);
        },
      );
    } catch (_) {
      _pusulaKullanilamiyor = true;
    }
  }

  Future<void> _konumuYukle({bool yenile = false}) async {
    setState(() => _konumYukleniyor = true);
    var koordinat = await VakitServisi.koordinatOku();
    if (yenile || koordinat == null) {
      await VakitServisi.konumuOtomatikAl();
      koordinat = await VakitServisi.koordinatOku();
    }
    if (!mounted) return;
    setState(() {
      _konumYukleniyor = false;
      if (koordinat != null) {
        _kibleAcisi = VakitServisi.kibleAcisi(koordinat.$1, koordinat.$2);
        _uzaklikKm = VakitServisi.kabeUzakligiKm(koordinat.$1, koordinat.$2);
      }
    });
  }

  @override
  void dispose() {
    _sensorBeklemeZamani?.cancel();
    _pusulaDinleyicisi?.cancel();
    super.dispose();
  }

  double _fark(double hedef, double mevcut) =>
      ((hedef - mevcut + 540) % 360) - 180;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final heading = _cihazYonu;
    final kible = _kibleAcisi;
    final fark = heading != null && kible != null
        ? _fark(kible, heading)
        : null;
    final hizali = fark != null && fark.abs() <= 5;

    return Scaffold(
      backgroundColor: const Color(0xFF0C1610),
      appBar: AppBar(
        title: Text(l.t('kbl.title')),
        backgroundColor: const Color(0xFF112016),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF112016), Color(0xFF08100B)],
          ),
        ),
        child: SafeArea(
          child: _konumYukleniyor
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  children: [
                    _durumKarti(fark, hizali, l),
                    const SizedBox(height: 26),
                    Center(child: _Pusula3D(kibleFarki: fark, hizali: hizali)),
                    const SizedBox(height: 26),
                    _kabeKarti(hizali, l),
                    const SizedBox(height: 18),
                    _bilgiCipleri(l),
                    const SizedBox(height: 18),
                    _yonlendirme(fark, hizali, l),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () => _konumuYukle(yenile: true),
                      icon: const Icon(Icons.my_location_outlined),
                      label: Text(l.t('kbl.refreshLocation')),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Renkler.vurgu,
                        side: BorderSide(
                          color: Renkler.vurgu.withValues(alpha: .6),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l.t('kbl.tip'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .58),
                        fontSize: 12,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _durumKarti(double? fark, bool hizali, AppLocalizations l) {
    final konumHazir = _kibleAcisi != null;
    final sensorHazir = _cihazYonu != null;
    final anaRenk = hizali
        ? const Color(0xFF54D780)
        : Renkler.vurgu.withValues(alpha: .9);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1B3322).withValues(alpha: .95),
            const Color(0xFF13241A),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: anaRenk.withValues(alpha: .45)),
        boxShadow: [
          BoxShadow(
            color: anaRenk.withValues(alpha: hizali ? .30 : .10),
            blurRadius: 22,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [anaRenk.withValues(alpha: .35), Colors.transparent],
              ),
              border: Border.all(color: anaRenk.withValues(alpha: .6)),
            ),
            child: Icon(
              hizali ? Icons.check_circle : Icons.explore,
              color: anaRenk,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hizali ? l.t('kbl.aligned') : l.t('kbl.alignKaaba'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  !konumHazir
                      ? l.t('kbl.statusNoPos')
                      : _pusulaKullanilamiyor
                      ? l.t('kbl.statusNoSensor')
                      : !sensorHazir
                      ? l.t('kbl.statusWaiting')
                      : l.t('kbl.statusReady')
                          .replaceFirst(
                              '{a}', _kibleAcisi!.toStringAsFixed(1))
                          .replaceFirst('{d}', _uzaklikKm!.toStringAsFixed(0)),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .68),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kabeKarti(bool hizali, AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF1B3322).withValues(alpha: .85),
            const Color(0xFF122018),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFDDBB55).withValues(alpha: .35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFDDBB55).withValues(alpha: .15),
                  border: Border.all(
                    color: const Color(0xFFDDBB55).withValues(alpha: .5),
                  ),
                ),
                child: const Icon(
                  Icons.mosque_outlined,
                  color: Color(0xFFE4C25B),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kâbe-i Muazzama',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Mescid-i Haram · Mekke',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (hizali)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF54D780).withValues(alpha: .18),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF54D780).withValues(alpha: .5),
                    ),
                  ),
                  child: Text(
                    l.t('kbl.alignedBadge'),
                    style: const TextStyle(
                      color: Color(0xFF70E495),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          // Kâbe görseli — çemberin dışında, sabit durur
          SizedBox(
            height: 168,
            width: double.infinity,
            child: CustomPaint(
              size: const Size(168, 168),
              painter: _Kaaba3DPainter(highlight: hizali),
            ),
          ),
        ],
      ),
    );
  }

Widget _bilgiCipleri(AppLocalizations l) {
  final hazir = _kibleAcisi != null;
  return Row(
    children: [
      Expanded(
        child: _cipler(
          ikon: Icons.explore_outlined,
          deger: hazir ? '${_kibleAcisi!.toStringAsFixed(1)}°' : '—',
          etiket: l.t('kbl.qiblaAngle'),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _cipler(
          ikon: Icons.location_city_outlined,
          deger: _uzaklikKm != null
              ? '${_uzaklikKm!.toStringAsFixed(0)} km'
              : '—',
          etiket: l.t('kbl.kaabaDistance'),
        ),
      ),
    ],
  );
}

  Widget _cipler({
    required IconData ikon,
    required String deger,
    required String etiket,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      child: Column(
        children: [
          Icon(ikon, color: Renkler.vurgu, size: 20),
          const SizedBox(height: 8),
          Text(
            deger,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            etiket,
            style: TextStyle(
              color: Colors.white.withValues(alpha: .55),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

Widget _yonlendirme(double? fark, bool hizali, AppLocalizations l) {
  String metin;
  if (_kibleAcisi == null) {
    metin = l.t('kbl.guideNoPos');
  } else if (_pusulaKullanilamiyor) {
    metin = l.t('kbl.guideNoSensor');
  } else if (_cihazYonu == null) {
    metin = l.t('kbl.guideHoldFlat');
  } else if (hizali) {
    metin = l.t('kbl.guideReady');
  } else {
    final derece = fark!.abs().round();
    metin = fark > 0
        ? l.t('kbl.guideTurnRight').replaceFirst('{d}', '$derece')
        : l.t('kbl.guideTurnLeft').replaceFirst('{d}', '$derece');
  }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: .07),
            Colors.white.withValues(alpha: .02),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      child: Row(
        children: [
          Icon(Icons.navigation, color: Renkler.vurgu),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              metin,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Modern, 3D görünümlü kıble pusulası. Kadran sabit durur; ibre (iğne)
/// kıble farkı kadar dönerek yönlendirme yapar ve hizalanınca yeşil parlar.
class _Pusula3D extends StatefulWidget {
  final double? kibleFarki;
  final bool hizali;

  const _Pusula3D({required this.kibleFarki, required this.hizali});

  @override
  State<_Pusula3D> createState() => _Pusula3DState();
}

class _Pusula3DState extends State<_Pusula3D> {
  @override
  Widget build(BuildContext context) {
    final angle = (widget.kibleFarki ?? 0) * math.pi / 180;
    final hazir = widget.kibleFarki != null;
    return SizedBox(
      width: 330,
      height: 330,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Hizalanınca beliren yeşil halo
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: widget.hizali ? 322 : 250,
            height: widget.hizali ? 322 : 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF54D780).withValues(
                    alpha: widget.hizali ? .45 : 0,
                  ),
                  blurRadius: 70,
                  spreadRadius: 6,
                ),
              ],
            ),
          ),
          // Dış bezel (3D derinlik)
          Container(
            width: 312,
            height: 312,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                center: Alignment(-0.25, -0.35),
                colors: [Color(0xFF3A5C47), Color(0xFF152419)],
              ),
              border: Border.all(
                color: const Color(0xFF82A88F),
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .65),
                  blurRadius: 32,
                  offset: const Offset(10, 16),
                ),
                BoxShadow(
                  color: const Color(0xFF4E7A5C).withValues(alpha: .35),
                  blurRadius: 20,
                  offset: const Offset(-8, -8),
                ),
              ],
            ),
          ),
          // Kadran halkası
          Container(
            width: 282,
            height: 282,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0E1C13),
              border: Border.all(
                color: Colors.black.withValues(alpha: .55),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .6),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: .04),
                  blurRadius: 2,
                  offset: const Offset(-1, -1),
                ),
              ],
            ),
          ),
          const _Kadran(),
          if (hazir)
            AnimatedRotation(
              duration: const Duration(milliseconds: 200),
              turns: angle / (2 * math.pi),
              child: _Ibre(hizali: widget.hizali),
            ),
          // Merkez topuz (ibre yuvası)
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.white.withValues(alpha: .9),
                  const Color(0xFF9E8B5A),
                ],
              ),
              border: Border.all(
                color: Colors.black.withValues(alpha: .4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .5),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Kadran extends StatelessWidget {
  const _Kadran();

  @override
  Widget build(BuildContext context) {
    const yonler = [(0.0, 'K'), (90.0, 'D'), (180.0, 'G'), (270.0, 'B')];
    return SizedBox(
      width: 282,
      height: 282,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(282, 282),
            painter: _DereceHalkasiPainter(),
          ),
          for (var i = 0; i < 24; i++)
            Transform.rotate(
              angle: i * math.pi / 12,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: i % 2 == 0 ? 3 : 1.5,
                    height: 13,
                    decoration: BoxDecoration(
                      color: i % 2 == 0
                          ? Colors.white70
                          : Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          for (final yon in yonler)
            Transform.rotate(
              angle: yon.$1 * math.pi / 180,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 34),
                  child: Container(
                    width: 34,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: yon.$2 == 'K'
                          ? const Color(0xFFEF7878).withValues(alpha: .18)
                          : Colors.white.withValues(alpha: .05),
                      border: Border.all(
                        color: (yon.$2 == 'K'
                                ? const Color(0xFFEF7878)
                                : Colors.white38)
                            .withValues(alpha: .35),
                      ),
                    ),
                    child: Text(
                      yon.$2,
                      style: TextStyle(
                        color: yon.$2 == 'K'
                            ? const Color(0xFFEF7878)
                            : Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DereceHalkasiPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final merkez = size.center(Offset.zero);
    final r = size.shortestSide / 2 - 6;
    final incCizgi = Paint()
      ..color = Colors.white.withValues(alpha: .18)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    final kalinCizgi = Paint()
      ..color = Colors.white.withValues(alpha: .38)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 360; i += 6) {
      final a = i * math.pi / 180;
      final ic = r - (i % 30 == 0 ? 9 : 5);
      final dis = r - 1;
      canvas.drawLine(
        Offset(merkez.dx + math.cos(a) * ic, merkez.dy + math.sin(a) * ic),
        Offset(merkez.dx + math.cos(a) * dis, merkez.dy + math.sin(a) * dis),
        i % 30 == 0 ? kalinCizgi : incCizgi,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DereceHalkasiPainter oldDelegate) => false;
}

/// Parlak, 3D görünümlü altın ibre.
class _Ibre extends StatelessWidget {
  final bool hizali;
  const _Ibre({required this.hizali});

  @override
  Widget build(BuildContext context) {
    final renk = hizali ? const Color(0xFF54D780) : const Color(0xFFE2C56B);
    return SizedBox(
      width: 210,
      height: 210,
      child: CustomPaint(
        size: const Size(210, 210),
        painter: _IbrePainter(renk: renk),
      ),
    );
  }
}

class _IbrePainter extends CustomPainter {
  final Color renk;
  const _IbrePainter({required this.renk});

  @override
  void paint(Canvas canvas, Size size) {
    final merkez = size.center(Offset.zero);

    // İbre gövdesi (ok şekli) yukarı bakar
    final golge = Paint()
      ..color = Colors.black.withValues(alpha: .5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);
    final okYolu = Path()
      ..moveTo(merkez.dx, merkez.dy - 78)
      ..lineTo(merkez.dx + 19, merkez.dy - 34)
      ..lineTo(merkez.dx + 13, merkez.dy + 42)
      ..lineTo(merkez.dx, merkez.dy + 58)
      ..lineTo(merkez.dx - 13, merkez.dy + 42)
      ..lineTo(merkez.dx - 19, merkez.dy - 34)
      ..close();

    // Parıltı efekti
    final glow = Paint()
      ..color = renk.withValues(alpha: .45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawPath(okYolu, glow);

    // Alt gölge (kaydırılmış kopya)
    final golgeYolu = Path()..addPath(okYolu, const Offset(0, 6));
    canvas.drawPath(golgeYolu, golge);

    // Ana gövde
    final govde = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          renk.withValues(alpha: .95),
          renk.withValues(alpha: .45),
        ],
      ).createShader(Rect.fromCenter(center: merkez, width: 210, height: 210));
    canvas.drawPath(okYolu, govde);

    // Orta çizgi parlaması
    final orta = Paint()
      ..color = Colors.white.withValues(alpha: .85)
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(merkez.dx, merkez.dy - 66),
      Offset(merkez.dx, merkez.dy + 36),
      orta,
    );

    // Merkez topuz
    canvas.drawCircle(
      merkez,
      9,
      Paint()
        ..shader = RadialGradient(
          colors: [Colors.white, renk],
        ).createShader(Rect.fromCircle(center: merkez, radius: 9)),
    );
    canvas.drawCircle(
      merkez,
      9,
      Paint()
        ..color = Colors.black.withValues(alpha: .4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant _IbrePainter oldDelegate) =>
      oldDelegate.renk != renk;
}

class _Kaaba3DPainter extends CustomPainter {
  final bool highlight;
  const _Kaaba3DPainter({required this.highlight});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 7;

    // ---- Zemin gölgesi ----
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy + 36), width: 70, height: 16),
      Paint()..color = Colors.black.withValues(alpha: .45),
    );

    // ---- Yükselen parıltı ----
    final glow = Paint()
      ..color = (highlight ? const Color(0xFF70E495) : const Color(0xFFDDBB55))
          .withValues(alpha: highlight ? .45 : .30)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);
    canvas.drawCircle(Offset(cx, cy - 4), 48, glow);

    // ---- Mermer kaide (platform) ----
    final kaide = RRect.fromRectAndRadius(
      Rect.fromLTWH(cx - 40, cy + 22, 80, 13),
      const Radius.circular(3),
    );
    canvas.drawRRect(
      kaide,
      Paint()
        ..shader = LinearGradient(
          colors: const [Color(0xFFE8E4D6), Color(0xFFB9B3A0)],
        ).createShader(kaide.outerRect),
    );
    canvas.drawRRect(
      kaide,
      Paint()
        ..color = const Color(0xFFDDBB55)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    // ---- İzometrik küp geometrisi ----
    // Ön yüzey: düz dikdörtgen (temiz, eğik değil)
    const dx = 15.0, dy = -11.0;
    final fL = Offset(cx - 25, cy - 22); // ön üst sol
    final fR = Offset(cx + 25, cy - 22); // ön üst sağ
    final fRB = Offset(cx + 25, cy + 28); // ön alt sağ
    final fLB = Offset(cx - 25, cy + 28); // ön alt sol
    final tL = fL + const Offset(dx, dy); // tepe sol
    final tR = fR + const Offset(dx, dy); // tepe sağ
    final sRB = fRB + const Offset(dx, dy); // sağ yüz arka alt

    final top = Path()
      ..moveTo(fL.dx, fL.dy)
      ..lineTo(fR.dx, fR.dy)
      ..lineTo(tR.dx, tR.dy)
      ..lineTo(tL.dx, tL.dy)
      ..close();
    final right = Path()
      ..moveTo(fR.dx, fR.dy)
      ..lineTo(tR.dx, tR.dy)
      ..lineTo(sRB.dx, sRB.dy)
      ..lineTo(fRB.dx, fRB.dy)
      ..close();
    final front = Path()
      ..moveTo(fL.dx, fL.dy)
      ..lineTo(fR.dx, fR.dy)
      ..lineTo(fRB.dx, fRB.dy)
      ..lineTo(fLB.dx, fLB.dy)
      ..close();

    // ---- Üst yüzey (en açık, ışığı alır) ----
    canvas.drawPath(
      top,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [Color(0xFF9C9C9C), Color(0xFF555555)],
        ).createShader(Rect.fromLTRB(tL.dx, tL.dy, fR.dx, fR.dy)),
    );

    // ---- Sağ yan yüzey (orta ton) ----
    canvas.drawPath(
      right,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [Color(0xFF343434), Color(0xFF141414)],
        ).createShader(Rect.fromLTRB(fR.dx, fR.dy, sRB.dx, fRB.dy)),
    );

    // ---- Ön yüzey (en koyu, siyah kumaş) ----
    canvas.drawPath(
      front,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [Color(0xFF1D1D1D), Color(0xFF050505)],
        ).createShader(Rect.fromLTRB(fL.dx, fL.dy, fR.dx, fRB.dy)),
    );

    // ---- Ön yüzey kumaş dokusu (ince dikey çizgiler) ----
    final doku = Paint()
      ..color = Colors.white.withValues(alpha: .045)
      ..strokeWidth = 0.8;
    for (var i = 1; i < 6; i++) {
      final x = fL.dx + i * (fR.dx - fL.dx) / 6;
      canvas.drawLine(
        Offset(x, fL.dy + 1),
        Offset(x, fRB.dy - 1),
        doku,
      );
    }

    // ---- Köşe gölgeleri (yumuşak 3D) ----
    final kenar = Paint()
      ..color = Colors.black.withValues(alpha: .6)
      ..strokeWidth = 1.4;
    canvas.drawLine(fL, fLB, kenar);
    canvas.drawLine(fR, fRB, kenar);
    canvas.drawLine(fL, tL, kenar);
    canvas.drawLine(fR, tR, kenar);

    // ---- Kapı (sivri kemerli, altın çerçeveli) ----
    final kapiW = 14.0;
    final kapiX = cx + 1;
    final kapiTop = cy - 2;
    final kapiBottom = cy + 22;
    final kapi = Path()
      ..moveTo(kapiX - kapiW / 2, kapiTop + 6)
      ..lineTo(kapiX - kapiW / 2, kapiBottom)
      ..lineTo(kapiX + kapiW / 2, kapiBottom)
      ..lineTo(kapiX + kapiW / 2, kapiTop + 6)
      ..close();
    canvas.drawPath(
      kapi,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF5C4A1E), Color(0xFF2A2008)],
        ).createShader(Rect.fromLTRB(
          kapiX - kapiW / 2,
          kapiTop,
          kapiX + kapiW / 2,
          kapiBottom,
        )),
    );
    // Kapı altın çerçevesi
    final kapiCerceve = Paint()
      ..color = const Color(0xFFE4C25B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    canvas.drawPath(kapi, kapiCerceve);
    // Kapı kemeri üstü
    canvas.drawArc(
      Rect.fromCircle(center: Offset(kapiX, kapiTop + 6), radius: kapiW / 2),
      math.pi,
      math.pi,
      false,
      kapiCerceve,
    );

    // ---- Altın kuşak (hizam): ön yüzde ----
    final hizamUst = cy - 14.0;
    final hizamAlt = cy - 7.0;
    final hizamOn = Rect.fromLTRB(fL.dx + 1, hizamUst, fR.dx - 1, hizamAlt);
    canvas.drawRect(
      hizamOn,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [Color(0xFFF0D488), Color(0xFFB98F2E)],
        ).createShader(hizamOn),
    );
    // Kuşak üzerinde hat/yazı motifi
    final hat = Paint()
      ..color = const Color(0xFF7A5C16)
      ..strokeWidth = 1.2;
    for (var i = 0; i < 9; i++) {
      final x = fL.dx + 3 + i * (fR.dx - fL.dx - 6) / 8;
      canvas.drawLine(
        Offset(x, hizamUst + 1.2),
        Offset(x, hizamAlt - 1.2),
        hat,
      );
    }
    // Kuşak altın alt-üst ince çizgileri
    final inceAltin = Paint()
      ..color = const Color(0xFFE4C25B).withValues(alpha: .7)
      ..strokeWidth = 0.9;
    canvas.drawLine(Offset(fL.dx + 1, hizamUst), Offset(fR.dx - 1, hizamUst), inceAltin);
    canvas.drawLine(Offset(fL.dx + 1, hizamAlt), Offset(fR.dx - 1, hizamAlt), inceAltin);

    // ---- Kuşak sağ yüzeye devam eder ----
    final hizamYan = Path()
      ..moveTo(fR.dx - 0.5, hizamUst + 3)
      ..lineTo(tR.dx - 0.5, hizamUst + 3 + dy)
      ..lineTo(sRB.dx - 0.5, hizamAlt + 3 + dy)
      ..lineTo(fRB.dx - 0.5, hizamAlt + 3)
      ..close();
    canvas.drawPath(
      hizamYan,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: const [Color(0xFFB98F2E), Color(0xFF7A5C16)],
        ).createShader(Rect.fromLTRB(fR.dx, hizamUst, sRB.dx, hizamAlt)),
    );

    // ---- Hacerü'l-Esved (siyah taş) ----
    final tas = Offset(fL.dx + 6.5, fRB.dy - 5.5);
    canvas.drawCircle(
      tas,
      4.2,
      Paint()
        ..shader = RadialGradient(
          colors: const [Color(0xFF8A8A8A), Color(0xFF1A1A1A)],
        ).createShader(Rect.fromCircle(center: tas, radius: 4.2)),
    );
    canvas.drawCircle(
      tas,
      4.2,
      Paint()
        ..color = const Color(0xFFC9A23A).withValues(alpha: .9)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // ---- Üst yüzey ışık süzmesi ----
    final parlaklik = Path()
      ..moveTo(tL.dx + 2, tL.dy + 3)
      ..lineTo(tL.dx + 18, tL.dy + 3)
      ..lineTo(tL.dx + 14, tL.dy + 1)
      ..lineTo(tL.dx + 1, tL.dy + 1)
      ..close();
    canvas.drawPath(
      parlaklik,
      Paint()..color = Colors.white.withValues(alpha: .20),
    );

    // ---- Ön yüzeye hafif yansıma (üstte) ----
    final yansima = Path()
      ..moveTo(fL.dx + 6, fL.dy + 6)
      ..lineTo(fR.dx - 8, fL.dy + 6)
      ..lineTo(fR.dx - 20, fL.dy + 16)
      ..lineTo(fL.dx + 14, fL.dy + 16)
      ..close();
    canvas.drawPath(
      yansima,
      Paint()..color = Colors.white.withValues(alpha: .035),
    );
  }

  @override
  bool shouldRepaint(covariant _Kaaba3DPainter oldDelegate) =>
      oldDelegate.highlight != highlight;
}
