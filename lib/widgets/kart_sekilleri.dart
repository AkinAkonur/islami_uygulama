import 'package:flutter/material.dart';

/// Tek ikon glisine 3D görünüm kazandıran sarmalayıcı: yukarıdan aşağı
/// parlayan degrade dolgu (üst aydınlık → alt koyu) ile yüzey derinliği verir.
class UcdIkon extends StatelessWidget {
  const UcdIkon({
    super.key,
    required this.ikon,
    required this.renk,
    this.boyut = 24,
    this.derinlik,
    this.golge = true,
  });

  final IconData ikon;
  final Color renk;
  final double boyut;
  final Color? derinlik;
  final bool golge;

  @override
  Widget build(BuildContext context) {
    final dip = derinlik ?? Color.lerp(renk, Colors.black, 0.35)!;
    final parlak = Color.lerp(renk, Colors.white, 0.58)!;
    return RepaintBoundary(
      child: SizedBox.square(
        dimension: boyut,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (golge)
              Positioned.fill(
                child: IgnorePointer(
                  child: ExcludeSemantics(
                    child: CustomPaint(
                      painter: _IkonKabartiPainter(
                        ikon, boyut, dip, parlak, Directionality.of(context)),
                    ),
                  ),
                ),
              ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [parlak, renk, dip],
                stops: const [0.0, 0.46, 1.0],
              ).createShader(bounds),
              child: Icon(
                ikon,
                size: boyut,
                color: Colors.white,
                semanticLabel: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dekoratif kabartılar ayrı kontrol/ikon değildir; tek ön yüz tıklanır.
class _IkonKabartiPainter extends CustomPainter {
  const _IkonKabartiPainter(this.ikon, this.boyut, this.dip,
      this.parlak, this.yon);
  final IconData ikon;
  final double boyut;
  final Color dip;
  final Color parlak;
  final TextDirection yon;

  @override
  void paint(Canvas canvas, Size size) {
    final yansit = ikon.matchTextDirection && yon == TextDirection.rtl;
    if (yansit) {
      canvas.save();
      canvas.translate(size.width, 0);
      canvas.scale(-1, 1);
    }
    void ciz(Color renk, Offset kayma) {
      final metin = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(ikon.codePoint),
          style: TextStyle(fontSize: boyut, height: 1,
            fontFamily: ikon.fontFamily, package: ikon.fontPackage, color: renk),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      metin.paint(canvas, Offset((size.width - metin.width) / 2,
          (size.height - metin.height) / 2) + kayma);
      metin.dispose();
    }
    ciz(dip.withValues(alpha: 0.92), const Offset(0, 2.1));
    ciz(parlak.withValues(alpha: 0.50), const Offset(-0.75, -0.75));
    if (yansit) canvas.restore();
  }

  @override
  bool shouldRepaint(_IkonKabartiPainter old) =>
      old.ikon != ikon || old.boyut != boyut || old.dip != dip ||
      old.parlak != parlak || old.yon != yon;
}
