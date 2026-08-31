import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'kart_sekilleri.dart';

/// Ana sayfadaki kartlara belirgin bir 3D görünüm katan sarmalayıcı:
///
/// - Dokunuş/imleç yönüne göre X/Y ekseninde perspektifli eğilme (tilt),
/// - Basılıyken "içeri itilme" hissi (hafif ölçeklenme),
/// - Eğilmeyle birlikte kayan parlak süpürme (specular) ve alt kenar gölgesi.
///
/// Durduğunda kartlar sabittir (dalgalanma/nefes animasyonu çalışmaz).
///
/// İçerik şablonu asla değişmez: `child` aynen korunur, yalnızca derinlik
/// katmanları eklenir. Dokunma olayları `Listener` ile gözlemlenir (tüketilmez),
/// kartların kendi tıklama/gezinme davranışları aynen çalışmaya devam eder.
class UcdKart extends StatefulWidget {
  const UcdKart({
    super.key,
    required this.child,
    this.maxTilt = 0.10,
    this.radius = 20,
    this.idleSalinim = true,
    this.sekil = KartSekli.klasik,
  });

  /// Sarmalanan (bozulmadan korunan) orijinal kart.
  final Widget child;

  /// Radyan cinsinden en fazla eğilme açısı.
  final double maxTilt;

  /// Kartın köşe yuvarlaması; ışığın/gölgenin kırpıldığı köşe yarıçapı.
  final double radius;

  /// Kartın dış hat biçimi (klasik / squircle / oktagon / kemer-alt).
  final KartSekli sekil;

  /// Dokunulmadığında çok hafif, sürekli salınım animasyonu açık mı?
  /// Talep gereği kapalidir: kartlar sabittir.
  final bool idleSalinim;

  @override
  State<UcdKart> createState() => _UcdKartState();
}

class _UcdKartState extends State<UcdKart> with TickerProviderStateMixin {
  late final Ticker _ticker;
  // Idle animasyonu test ortamında kapatılır (pumpAndSettle zaman aşımına
  // uğramasın); tüm kartlar yine de dokunmayla 3D eğilme yaşar.
  late final bool _idle;
  Duration _t = Duration.zero;
  double _hx = 0, _hy = 0; // imlecin hedef eğilme değerleri
  double _x = 0, _y = 0; // yumuşatılmış gerçek eğilme değerleri
  bool _aktif = false; // dokunma altında mı
  bool _basili = false; // basılı tutma (küçük ölçek geri bildirimi)

  @override
  void initState() {
    super.initState();
    _idle = false; // Dalgalanma (nefes alma + isik bandi) kapali: sabit kartlar.
    _ticker = createTicker(_tik)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tik(Duration _) {
    _t += const Duration(milliseconds: 16);
    final nx = _x + (_hx - _x) * 0.14;
    final ny = _y + (_hy - _y) * 0.14;
    final durgun =
        !_aktif && (nx - _x).abs() < 0.0004 && (ny - _y).abs() < 0.0004;
    if (durgun) {
      if (!_idle && _x == 0 && _y == 0) {
        _ticker.stop();
        return;
      }
      _x = 0;
      _y = 0;
      if (mounted) setState(() {});
      return;
    }
    _x = nx;
    _y = ny;
    if (mounted) setState(() {});
  }

  /// Kartın çalışma anındaki gerçek boyutunu alır (LayoutBuilder'a gerek yok;
  /// yatay kaydırmalı satırlar gibi sınırsız alanlarda da çalışır).
  Size? _olcum() {
    final rb = context.findRenderObject();
    if (rb is RenderBox && rb.hasSize) return rb.size;
    return null;
  }

  void _git(Offset? konum) {
    final boyut = _olcum();
    if (boyut == null || !boyut.width.isFinite || !boyut.height.isFinite) {
      _aktif = false;
      _basili = false;
      _hx = 0;
      _hy = 0;
      return;
    }
    if (konum == null) {
      _aktif = false;
      _basili = false;
      _hx = 0;
      _hy = 0;
    } else if (boyut.width > 0 && boyut.height > 0) {
      _aktif = true;
      _basili = true;
      _hx = ((konum.dx / boyut.width) - 0.5) * 2;
      _hy = ((konum.dy / boyut.height) - 0.5) * 2;
    }
    if (!_ticker.isActive) _ticker.start();
  }

  /// Kartın üstüne binen derinlik katmanları (ışık bandı + kenar vurgusu +
  /// alt gölgesi). Eğilmeyle birlikte kayarak 3D yüzey hissi verir.
  Widget _katmanlar(Widget kart, Size boyut, double egrX, double egrY) {
    final yuzey = widget.radius;
    final agorgi = egrY / widget.maxTilt; // -1..1 dikey eğim
    final yatar = egrX / widget.maxTilt; // -1..1 yatay eğim
    return ClipPath(
      clipper: KartSiluet(widget.sekil, yuzey),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          kart,
          // Alt kenar gölgesi: eğilmeyle karşı yöne kayar.
          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, -1),
                    end: Alignment(0, 1),
                    colors: [
                      Colors.black.withValues(alpha: 0.06 + 0.10 * yatar),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.20 + 0.08 * yatar),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),
          ),
          // Üst kenar ince ışık çizgisi (hafif kabarık yüzey hissi).
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 1,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.0),
                      Colors.white.withValues(alpha: 0.18 - 0.08 * agorgi),
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boyut = _olcum() ?? Size.zero;
    final sn = (_t.inMilliseconds / 1000.0) * 2 * math.pi;
    // Boştayken kartlar "nefes alır": hafif eğilme + ölçek titreşimi.
    final salY = _idle ? 0.012 * math.sin(sn) : 0.0;
    final salX = _idle ? 0.009 * math.sin(sn * 0.77 + 1.3) : 0.0;
    final nefes = _idle ? 1.0 + 0.006 * math.sin(sn * 0.55 + 0.5) : 1.0;
    final egrX = (_x * widget.maxTilt) + salX;
    final egrY = (-_y * widget.maxTilt) + salY;
    final olcek = (_basili ? 0.945 : 1.0) * nefes;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0016)
        ..rotateY(egrX)
        ..rotateX(egrY)
        ..scaleByDouble(olcek, olcek, olcek, 1.0),
      child: Listener(
        onPointerDown: (e) => _git(e.localPosition),
        onPointerMove: (e) => _git(e.localPosition),
        onPointerUp: (_) => _git(null),
        onPointerCancel: (_) => _git(null),
        child: _katmanlar(widget.child, boyut, egrX, egrY),
      ),
    );
  }
}
