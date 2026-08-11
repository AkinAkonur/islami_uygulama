import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

import '../services/renkler.dart';
import '../services/vakit_servisi.dart';

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
  }

  Future<void> _konumuYukle({bool yenile = false}) async {
    setState(() => _konumYukleniyor = true);
    var koordinat = await VakitServisi.koordinatOku();
    // İlk açılışta kayıtlı konum yoksa kullanıcıyı ek bir ekrana göndermeden
    // doğrudan GPS izni iste ve kıble açısını hesapla.
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
    final heading = _cihazYonu;
    final kible = _kibleAcisi;
    final fark = heading != null && kible != null
        ? _fark(kible, heading)
        : null;
    final hizali = fark != null && fark.abs() <= 5;

    return Scaffold(
      backgroundColor: const Color(0xFF0C1610),
      appBar: AppBar(
        title: const Text('Kıble Pusulası'),
        backgroundColor: const Color(0xFF112016),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: _konumYukleniyor
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                children: [
                  _durumKart(fark, hizali),
                  const SizedBox(height: 24),
                  Center(
                    child: _Pusula3D(kibleFarki: fark, hizali: hizali),
                  ),
                  const SizedBox(height: 24),
                  _yonlendirme(fark, hizali),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => _konumuYukle(yenile: true),
                    icon: const Icon(Icons.my_location_outlined),
                    label: const Text('Konumu Yenile'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Renkler.vurgu,
                      side: BorderSide(
                        color: Renkler.vurgu.withValues(alpha: .6),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Daha doğru sonuç için telefonu düz ve yatay tutun; metal yüzeylerden ve mıknatıslı kılıflardan uzaklaşın.',
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
    );
  }

  Widget _durumKart(double? fark, bool hizali) {
    final konumHazir = _kibleAcisi != null;
    final sensorHazir = _cihazYonu != null;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF17281C),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: hizali
              ? const Color(0xFF54D780)
              : Renkler.vurgu.withValues(alpha: .4),
        ),
      ),
      child: Row(
        children: [
          Icon(
            hizali ? Icons.check_circle : Icons.explore,
            color: hizali ? const Color(0xFF54D780) : Renkler.vurgu,
            size: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hizali ? 'Kıbleye yöneldiniz' : 'Kâbe yönünü hizalayın',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  !konumHazir
                      ? 'Kıble açısını hesaplamak için konumunuzu yenileyin.'
                      : _pusulaKullanilamiyor
                      ? 'Bu cihazda kullanılabilir pusula sensörü bulunamadı.'
                      : !sensorHazir
                      ? 'Pusula sensörü bekleniyor. Telefonu hafifçe hareket ettirin.'
                      : 'Kıble: ${_kibleAcisi!.toStringAsFixed(1)}° • Kâbe: ${_uzaklikKm!.toStringAsFixed(0)} km',
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

  Widget _yonlendirme(double? fark, bool hizali) {
    String metin;
    if (_kibleAcisi == null) {
      metin = 'Önce “Konumu Yenile” düğmesine dokunun.';
    } else if (_pusulaKullanilamiyor) {
      metin =
          'Bu cihazda pusula sensörü olmadığı için canlı kıble yönü gösterilemiyor.';
    } else if (_cihazYonu == null) {
      metin = 'Pusula verisi alınırken telefonu düz tutun.';
    } else if (hizali) {
      metin = 'Hazır. Telefonun üst kısmı Kâbe yönünü gösteriyor.';
    } else {
      final derece = fark!.abs().round();
      metin = fark > 0
          ? 'Telefonu sağa doğru $derece° çevirin.'
          : 'Telefonu sola doğru $derece° çevirin.';
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF1B3322), const Color(0xFF14231A)],
        ),
        borderRadius: BorderRadius.circular(18),
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

class _Pusula3D extends StatelessWidget {
  final double? kibleFarki;
  final bool hizali;

  const _Pusula3D({required this.kibleFarki, required this.hizali});

  @override
  Widget build(BuildContext context) {
    final angle = (kibleFarki ?? 0) * math.pi / 180;
    final hazir = kibleFarki != null;
    return SizedBox(
      width: 310,
      height: 310,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 296,
            height: 296,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [Color(0xFF274330), Color(0xFF101C14)],
              ),
              border: Border.all(color: const Color(0xFF5C8066), width: 3),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 22,
                  offset: Offset(0, 10),
                ),
              ],
            ),
          ),
          const _Kadran(),
          if (hazir)
            Transform.rotate(
              angle: angle,
              child: const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(
                    Icons.navigation,
                    color: Color(0xFFE2C56B),
                    size: 52,
                  ),
                ),
              ),
            ),
          CustomPaint(
            size: const Size(116, 116),
            painter: _Kaaba3DPainter(highlight: hizali),
          ),
          Positioned(
            bottom: 26,
            child: Text(
              hazir ? '${kibleFarki!.abs().round()}°' : '—',
              style: TextStyle(
                color: hizali ? const Color(0xFF70E495) : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
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
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var i = 0; i < 24; i++)
            Transform.rotate(
              angle: i * math.pi / 12,
              child: const Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 13,
                  child: VerticalDivider(color: Colors.white38, thickness: 1),
                ),
              ),
            ),
          for (final yon in yonler)
            Transform.rotate(
              angle: yon.$1 * math.pi / 180,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 17),
                  child: Text(
                    yon.$2,
                    style: TextStyle(
                      color: yon.$2 == 'K'
                          ? const Color(0xFFEF7878)
                          : Colors.white70,
                      fontWeight: FontWeight.bold,
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

class _Kaaba3DPainter extends CustomPainter {
  final bool highlight;
  const _Kaaba3DPainter({required this.highlight});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    final gold = const Color(0xFFDDBB55);
    final glow = Paint()
      ..color = (highlight ? const Color(0xFF70E495) : gold).withValues(
        alpha: .35,
      )
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2 + 8), 48, glow);

    final top = Path()
      ..moveTo(22, 35)
      ..lineTo(75, 17)
      ..lineTo(103, 34)
      ..lineTo(50, 53)
      ..close();
    p.color = const Color(0xFF4A4A4A);
    canvas.drawPath(top, p);
    final front = Path()
      ..moveTo(22, 35)
      ..lineTo(50, 53)
      ..lineTo(50, 102)
      ..lineTo(22, 83)
      ..close();
    p.color = const Color(0xFF0C0C0C);
    canvas.drawPath(front, p);
    final side = Path()
      ..moveTo(50, 53)
      ..lineTo(103, 34)
      ..lineTo(103, 82)
      ..lineTo(50, 102)
      ..close();
    p.color = const Color(0xFF1B1B1B);
    canvas.drawPath(side, p);
    p.color = gold;
    canvas.drawRect(const Rect.fromLTWH(25, 56, 75, 8), p);
    p.color = const Color(0xFF8B6C1C);
    canvas.drawRect(const Rect.fromLTWH(61, 72, 16, 26), p);
    p.style = PaintingStyle.stroke;
    p.strokeWidth = 1.5;
    p.color = gold;
    canvas.drawPath(top, p);
    canvas.drawPath(front, p);
    canvas.drawPath(side, p);
  }

  @override
  bool shouldRepaint(covariant _Kaaba3DPainter oldDelegate) =>
      oldDelegate.highlight != highlight;
}
