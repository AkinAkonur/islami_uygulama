// ===========================================================================
// ALTIN TACTILE - 3D zümrüt/altın dokunsal arayüz bileşenleri
// ---------------------------------------------------------------------------
// Kullanıcının "3D Zümrüt & Altın" tasarımından birebir çevrilen bileşenler:
//  • AltinButon   : altın metalik bezel + zümrüt iç çukur + derin kabartma
//                    + dokununca basma efekti + isteğe bağlı altın ışıma
//  • ZumrutCamKutu: zümrüt koyu gradyan zemin + ince altın kenar + cam
//                    yansıması (diyagonal parlama)
//  • AltinBar     : altın parlayan başparmak, yeşil→altın gradyan izli kaydırıcı
// ===========================================================================

import 'package:flutter/material.dart';

class AltinTasarim {
  AltinTasarim._();

  static const altin = Color(0xFFF0C030);
  static const acikAltin = Color(0xFFF9E3A8);
  static const koyuAltin = Color(0xFF9A6B00);
  static const altinParlakRenk = Color(0xFFFFE9A8);

  static const zumrutDerin = Color(0xFF0B150E);
  static const zumrutOrt = Color(0xFF14281B);
  static const zumrutAcik = Color(0xFF1D3A26);
  static const camUstGolge = Color(0xFF123024);
  static const camAltGolge = Color(0xFF060B08);
}

/// Altın metallik bezeli, zümrüt iç çukurlu dairesel dokunsal buton.
class AltinButon extends StatefulWidget {
  const AltinButon({
    super.key,
    required this.ikon,
    this.boyut = 44,
    this.ikonBoyut,
    this.onPressed,
    this.isik = true,
    this.ikonRenk,
  });

  final IconData ikon;
  final double boyut;
  final double? ikonBoyut;

  /// Altın bezelin dışına taşan ışıma. Aktif/çalan durumlar için true,
  /// ikincil butonlar için daha sönük bir değer yeterlidir.
  final bool isik;

  final Color? ikonRenk;

  final VoidCallback? onPressed;

  @override
  State<AltinButon> createState() => _AltinButonState();
}

class _AltinButonState extends State<AltinButon> {
  bool _basili = false;

  @override
  Widget build(BuildContext context) {
    final boyut = widget.boyut;
    final cizgiKalini = (boyut * 0.085).clamp(2.0, 5.0);
    return GestureDetector(
      onTapDown: widget.onPressed == null ? null : (_) => setState(() => _basili = true),
      onTapCancel: widget.onPressed == null ? null : () => setState(() => _basili = false),
      onTapUp: widget.onPressed == null ? null : (_) => setState(() => _basili = false),
      onTap: widget.onPressed,
      child: Transform.translate(
        offset: _basili ? const Offset(0, 1.5) : Offset.zero,
        child: Container(
          width: boyut,
          height: boyut,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _basili
                  ? [
                      AltinTasarim.koyuAltin,
                      AltinTasarim.altin,
                      AltinTasarim.koyuAltin,
                    ]
                  : [
                      AltinTasarim.acikAltin,
                      AltinTasarim.altin,
                      AltinTasarim.koyuAltin,
                      AltinTasarim.altin,
                    ],
              stops: _basili ? const [0, 0.5, 1] : const [0, 0.35, 0.62, 1],
            ),
            boxShadow: [
              // Altın ışıma (bezelden dışa taşar)
              BoxShadow(
                color: AltinTasarim.altin.withValues(
                  alpha: _basili ? 0.35 : (widget.isik ? 0.55 : 0.28),
                ),
                blurRadius: boyut * 0.35,
                spreadRadius: 1,
              ),
              // Derinlik: aşağıda koyu gölge
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.75),
                offset: Offset(0, boyut * 0.09),
                blurRadius: boyut * 0.12,
              ),
              // Üst ışık konturu
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.35),
                offset: const Offset(0, -1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.all(cizgiKalini),
            padding: EdgeInsets.all(boyut * 0.06),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: const Alignment(-0.35, -0.45),
                colors: _basili
                    ? [AltinTasarim.zumrutAcik, AltinTasarim.zumrutDerin]
                    : [AltinTasarim.zumrutOrt, AltinTasarim.zumrutDerin],
              ),
              boxShadow: [
                // Oyuk: aşağıda karanlık çukur
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.9),
                  offset: Offset(0, boyut * 0.06),
                  blurRadius: boyut * 0.1,
                ),
                // Bezelin üstten aydınlatması iç kapa izni verir
                BoxShadow(
                  color: AltinTasarim.altin.withValues(alpha: 0.4),
                  offset: const Offset(0, -1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Icon(
                widget.ikon,
                color: widget.ikonRenk ?? AltinTasarim.altinParlakRenk,
                size: widget.ikonBoyut ?? boyut * 0.48,
                shadows: [
                  Shadow(
                    color: AltinTasarim.koyuAltin.withValues(alpha: 0.9),
                    offset: const Offset(0, 1.2),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Zümrüt koyu gradyan zeminli, ince altın kenarlı, cam yansımalı panel.
class ZumrutCamKutu extends StatelessWidget {
  const ZumrutCamKutu({
    super.key,
    required this.child,
    this.margin,
    this.padding,
    this.koseYaricapi = 18,
    this.kenarKalini = 1.2,
    this.isik = true,
    this.zeminler,
  });

  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double koseYaricapi;
  final double kenarKalini;

  /// Dış altın ışıması açık/kapalı.
  final bool isik;

  /// Özel zemin gradyanı; null ise varsayılan zümrüt cam.
  final Gradient? zeminler;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(koseYaricapi),
        gradient: zeminler ??
            const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AltinTasarim.camUstGolge, AltinTasarim.camAltGolge],
            ),
        border: Border.all(
          color: AltinTasarim.altin.withValues(alpha: isik ? 0.6 : 0.35),
          width: kenarKalini,
        ),
        boxShadow: [
          BoxShadow(
            color: AltinTasarim.altin.withValues(alpha: isik ? 0.16 : 0.08),
            blurRadius: 16,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(koseYaricapi - kenarKalini),
        child: Stack(
          children: [
            // Cam yansıması: çapraz parlama
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.12),
                        Colors.white.withValues(alpha: 0.0),
                        Colors.black.withValues(alpha: 0.18),
                      ],
                      stops: const [0, 0.4, 1],
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: padding ?? EdgeInsets.zero, child: child),
          ],
        ),
      ),
    );
  }
}

/// Altın dokunsal kaydırıcı teması: altın parlayan başparmak + yeşil→altın iz.
class AltinBar extends StatelessWidget {
  const AltinBar({
    super.key,
    required this.deger,
    this.onDegisti,
    this.minimum = 0,
    this.maximum = 1,
    this.aktif = true,
  });

  final double deger;
  final double minimum;
  final double maximum;
  final ValueChanged<double>? onDegisti;

  /// Sürükleme etkin mi (yalnızca gösterim).
  final bool aktif;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 3,
        activeTrackColor: AltinTasarim.altin,
        inactiveTrackColor: AltinTasarim.zumrutAcik.withValues(alpha: 0.6),
        thumbColor: AltinTasarim.altinParlakRenk,
        thumbShape: const RoundSliderThumbShape(
          enabledThumbRadius: 7,
          elevation: 6,
          pressedElevation: 10,
        ),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
        overlayColor: AltinTasarim.altin.withValues(alpha: 0.22),
        trackShape: _GradyanTrackShape(),
        // Altın ışıma: başparmak üzerinde sıcak gölge
        valueIndicatorColor: AltinTasarim.koyuAltin,
      ),
      child: Slider(
        value: deger.clamp(minimum, maximum),
        min: minimum,
        max: maximum,
        onChanged: aktif ? onDegisti : null,
      ),
    );
  }
}

/// Dolu kısmı zümrüt→altın gradyanla çizen kaydırıcı izi.
class _GradyanTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final rect = getPreferredRect(
      parentBox: parentBox,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final trackHeight = sliderTheme.trackHeight ?? 4;
    final y = thumbCenter.dy;
    final yari = (trackHeight + additionalActiveTrackHeight) / 2;

    // Boş kısım: koyu zümrüt
    final bosRRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(rect.left, y - yari, rect.right, y + yari),
      Radius.circular(yari),
    );
    context.canvas.drawRRect(
      bosRRect,
      Paint()
        ..color = AltinTasarim.zumrutAcik.withValues(alpha: 0.6)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1),
    );

    // Dolu kısım: yeşil → altın gradyan
    final doluRect = Rect.fromLTRB(
      rect.left,
      y - yari,
      thumbCenter.dx,
      y + yari,
    );
    if (doluRect.width <= 0) return;
    final doluRRect = RRect.fromRectAndRadius(
      doluRect,
      Radius.circular(yari),
    );
    final boya = Paint()
      ..shader = const LinearGradient(
        colors: [AltinTasarim.zumrutAcik, AltinTasarim.altin],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(doluRect);
    context.canvas.drawRRect(doluRRect, boya);

    // Altın ışıma konturu
    context.canvas.drawRRect(
      doluRRect.inflate(0.5),
      Paint()
        ..color = AltinTasarim.altin.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.2),
    );
  }
}