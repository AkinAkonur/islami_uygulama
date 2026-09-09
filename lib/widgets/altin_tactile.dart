// ===========================================================================
// ALTIN TACTILE - 3D zümrüt/altın dokunsal arayüz bileşenleri
// ---------------------------------------------------------------------------
// Kullanıcının "3D Zümrüt & Altın" tasarımından birebir çevrilen bileşenler:
//  • AltinButon   : altın metalik bezel + zümrüt iç çukur + derin kabartma
//                    + dokununca basma efekti + isteğe bağlı altın ışıma
//  • ZumrutCamKutu: zümrüt koyu gradyan zemin + ince altın kenar + cam
//                    yansıması (diyagonal parlama)

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
            ),
            child: Center(
              child: Icon(
                widget.ikon,
                color: widget.ikonRenk ?? AltinTasarim.altinParlakRenk,
                size: widget.ikonBoyut ?? boyut * 0.48,
                shadows: const [
                  Shadow(
                    color: Color(0xAA000000),
                    offset: Offset(0, 2),
                    blurRadius: 3,
                  ),
                  Shadow(
                    color: Color(0x66FFF4CF),
                    offset: Offset(-0.7, -0.7),
                    blurRadius: 1,
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

/// Dolu kısmı zümrüt→altın gradyanla çizen kaydırıcı izi.
/// Uygulama geneli `SliderTheme`da da kullanılır (tüm kaydırıcılar tactile olur).
class GradyanSliderTrackShape extends RoundedRectSliderTrackShape {
  const GradyanSliderTrackShape();
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
      Paint()..color = AltinTasarim.zumrutAcik.withValues(alpha: 0.6),
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
  }
}

/// Tüm uygulamadaki özel(dokusal) butonları 3D zümrüt/altın görünüme çeviren
/// genel sarmalayıcı. Altın metalik bezel + zümrüt iç çukur + derin kabartma;
/// dokununca basar, seçili(çalan/aktif) durumda daha parlak altın çerçeve ve
/// koyu zümrüt yüz, etkin değilse soluklaşır. `child` serbesttir: metin,
/// ikon+metin, sadece ikon (yüksek köşe yarıçapıyla yuvarlak da olur).
class UcdButon extends StatefulWidget {
  const UcdButon({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.basili = false,
    this.etkin = true,
    this.koseYaricapi = 16,
    this.kenarKalini = 1.4,
    this.dolgu = const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
    this.genislik,
    this.yukseklik,
    this.isik = true,
    this.zeminler,
  });

  final Widget child;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  /// Aktif/seçili durum (çalan ayet, açık mod, seçili vakit...).
  final bool basili;

  /// Etkin değilse basmalar yanıt vermez ve görünüm solur.
  final bool etkin;

  final double koseYaricapi;
  final double kenarKalini;
  final EdgeInsetsGeometry dolgu;
  final double? genislik;
  final double? yukseklik;

  /// Dış altın ışıması.
  final bool isik;

  /// İç yüzey gradyanı; null ise varsayılan zümrüt çukur.
  final Gradient? zeminler;

  @override
  State<UcdButon> createState() => _UcdButonState();
}

class _UcdButonState extends State<UcdButon> {
  bool _hendir = false;

  bool get _aktif => widget.etkin && widget.onTap != null;

  @override
  Widget build(BuildContext context) {
    final pressed = _hendir || widget.basili;
    final radius = BorderRadius.circular(widget.koseYaricapi);
    final cizgi = widget.kenarKalini;

    final gorunum = Container(
      width: widget.genislik,
      height: widget.yukseklik,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: !_aktif
              ? const [
                  Color(0xFF5A5540),
                  Color(0xFF3A3A34),
                  Color(0xFF34302A),
                  Color(0xFF3A3A34),
                ]
              : pressed
                  ? const [Color(0xFF9A6B00), AltinTasarim.altin, Color(0xFF9A6B00)]
                  : const [
                      AltinTasarim.acikAltin,
                      AltinTasarim.altin,
                      AltinTasarim.koyuAltin,
                      AltinTasarim.altin,
                    ],
          stops: pressed && _aktif
              ? const [0, 0.5, 1]
              : const [0, 0.35, 0.62, 1],
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(cizgi),
        padding: widget.dolgu,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.koseYaricapi - cizgi),
          gradient: widget.zeminler ??
              (pressed
                  ? const RadialGradient(
                      center: Alignment(-0.3, -0.4),
                      colors: [AltinTasarim.zumrutAcik, AltinTasarim.zumrutDerin],
                    )
                  : const RadialGradient(
                      center: Alignment(-0.35, -0.45),
                      colors: [AltinTasarim.zumrutOrt, AltinTasarim.zumrutDerin],
                    )),
        ),
        child: Center(
          child: Opacity(
            opacity: _aktif ? 1 : 0.5,
            child: widget.child,
          ),
        ),
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: !_aktif ? null : (_) => setState(() => _hendir = true),
      onTapCancel: !_aktif ? null : () => setState(() => _hendir = false),
      onTapUp: !_aktif ? null : (_) => setState(() => _hendir = false),
      onTap: widget.onTap,
      onLongPress: !_aktif ? null : widget.onLongPress,
      child: Semantics(
        button: true,
        enabled: _aktif,
        selected: widget.basili,
        child: Transform.translate(
          offset: pressed ? const Offset(0, 2) : Offset.zero,
          child: gorunum,
        ),
      ),
    );
  }
}
