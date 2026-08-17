import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// Ana sayfadaki kartlara 3D derinlik katan sarmalayıcı.
///
/// Dokunuş/imleç yönüne göre X/Y ekseninde perspektifli eğilir (tilt),
/// basılıyken hafif ölçeklenir ve yüzeyinde eğilmeyle birlikte kayan bir
/// ışık-gölge katmanı taşır. Dokunulmadığında (isteğe bağlı) dingin bir
/// "yüzme" salınımı sayfaya sürekli 3D havası verir.
///
/// İçerik şablonu asla değişmez: `child` aynen korunur, yalnızca dış
/// derinlik katmanı eklenir. Dokunma olayları `Listener` ile gözlemlenir
/// (tüketilmez), bu yüzden kartların kendi tıklama/gezinme davranışları
/// aynen çalışmaya devam eder.
class UcdKart extends StatefulWidget {
  const UcdKart({
    super.key,
    required this.child,
    this.maxTilt = 0.055,
    this.radius = 24,
    this.idleSalinim = true,
  });

  /// Sarmalanan (bozulmadan korunan) orijinal kart.
  final Widget child;

  /// Radyan cinsinden en fazla eğilme açısı.
  final double maxTilt;

  /// Kartın köşe yuvarlaması; ışık-gölge katmanı bu yarıçapla kırpılır.
  final double radius;

  /// Dokunulmadığında çok hafif, sürekli salınım animasyonu açık mı?
  final bool idleSalinim;

  @override
  State<UcdKart> createState() => _UcdKartState();
}

class _UcdKartState extends State<UcdKart> with TickerProviderStateMixin {
  late final Ticker _ticker;
  Duration _t = Duration.zero;
  double _hx = 0, _hy = 0; // imlecin hedef eğilme değerleri
  double _x = 0, _y = 0; // yumuşatılmış gerçek eğilme değerleri
  bool _aktif = false; // dokunma altında mı
  bool _basili = false; // basılı tutma (küçük ölçek geri bildirimi)

  bool get _baskilastirmali => widget.idleSalinim;

  @override
  void initState() {
    super.initState();
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
      if (!_baskilastirmali && _x == 0 && _y == 0) {
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

  void _git(Offset? konum, Size boyut) {
    if (!boyut.width.isFinite || !boyut.height.isFinite) {
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
    } else {
      _aktif = true;
      _basili = true;
      _hx = ((konum.dx / boyut.width) - 0.5) * 2;
      _hy = ((konum.dy / boyut.height) - 0.5) * 2;
    }
    if (!_ticker.isActive) _ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, kosullar) {
        final boyut = Size(kosullar.maxWidth, kosullar.maxHeight);
        if (!boyut.width.isFinite || !boyut.height.isFinite) {
          // Sınırsız alan (ör. yatay kaydırmalı sıra): kartı olduğu gibi koy.
          return widget.child;
        }
        final sn = (_t.inMilliseconds / 1000.0) * 2 * math.pi;
        final salY = widget.idleSalinim ? 0.006 * math.sin(sn) : 0.0;
        final salX = widget.idleSalinim
            ? 0.004 * math.sin(sn * 0.77 + 1.3)
            : 0.0;
        final egrX = (_x * widget.maxTilt) + salX;
        final egrY = (-_y * widget.maxTilt) + salY;
        final olcek = _basili ? 0.975 : 1.0;
        final yuzey = widget.radius;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0016)
            ..rotateY(egrX)
            ..rotateX(egrY)
            ..scaleByDouble(olcek, olcek, olcek, 1.0),
          child: Listener(
            onPointerDown: (e) => _git(e.localPosition, boyut),
            onPointerMove: (e) => _git(e.localPosition, boyut),
            onPointerUp: (_) => _git(null, boyut),
            onPointerCancel: (_) => _git(null, boyut),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(yuzey),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  widget.child,
                  Positioned.fill(
                    child: IgnorePointer(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(
                              (egrX / widget.maxTilt).clamp(-1, 1) * -0.30,
                              -0.55,
                            ),
                            end: Alignment(
                              (egrX / widget.maxTilt).clamp(-1, 1) * 0.30,
                              0.8,
                            ),
                            colors: [
                              Colors.white.withValues(alpha: 0.09),
                              Colors.white.withValues(alpha: 0.02),
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.14),
                              Colors.black.withValues(alpha: 0.10),
                            ],
                            stops: const [0.0, 0.18, 0.5, 0.85, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
