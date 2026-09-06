import 'package:flutter/material.dart';

/// 3D dokunsal (skeuomorphic) kart: alt/geniş derinlik gölgesi + üst ışık
/// bevel'i + basınca içe çökme (daha koyu yüzey + iç gölge hissi).
class TactileKart extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool altinCerceve; // altın kenar mı (yoksa zümrüt)
  final EdgeInsetsGeometry? dolgu;
  final BorderRadius? kose;
  final double? genislik;
  const TactileKart({super.key, required this.child, this.onTap, this.altinCerceve = false, this.dolgu, this.kose, this.genislik});
  @override
  State<TactileKart> createState() => _TactileKartState();
}
class _TactileKartState extends State<TactileKart> {
  bool _basili = false;
  @override
  Widget build(BuildContext context) {
    const yuzey = Color(0xFF06281E);         // surfaceCard
    const yuzeyAcik = Color(0xFF0C382B);     // surfaceCardLight
    const altin = Color(0xFFFFC107);         // goldAccent
    const zumrut = Color(0xFF10B981);        // emeraldPrimary
    final kose = widget.kose ?? BorderRadius.circular(20);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => setState(() => _basili = true),
      onTapUp: (_) => setState(() => _basili = false),
      onTapCancel: () => setState(() => _basili = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.genislik,
        padding: widget.dolgu ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: kose,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _basili
                ? [const Color(0xFF031E15), yuzey]
                : [yuzeyAcik, const Color(0xFF041F16)],
          ),
          border: Border.all(
            color: widget.altinCerceve
                ? altin.withValues(alpha: 0.4)
                : zumrut.withValues(alpha: 0.2),
            width: 1.2,
          ),
          boxShadow: _basili
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: const Offset(1, 2),
                    blurRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.6),
                    offset: const Offset(0, 8),
                    blurRadius: 14,
                    spreadRadius: -2,
                  ),
                  BoxShadow(
                    color: (widget.altinCerceve ? altin : zumrut)
                        .withValues(alpha: 0.12),
                    offset: const Offset(0, -1),
                    blurRadius: 4,
                  ),
                ],
        ),
        child: widget.child,
      ),
    );
  }
}