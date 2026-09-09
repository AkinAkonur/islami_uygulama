import 'package:flutter/material.dart';
import 'kart_sekilleri.dart';
import 'tactile_kart.dart';

/// Equal-width quick access tile: one centered 3D icon and a two-line label.
class HizliErisimKarti extends StatelessWidget {
  const HizliErisimKarti({super.key, required this.ikon, required this.label, required this.onTap});
  final IconData ikon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textHeight = MediaQuery.textScalerOf(context).scale(10) * 2.8;
    return Semantics(button: true, child: Tooltip(message: label, child: TactileKart(
      genislik: double.infinity,
      onTap: onTap,
      kose: BorderRadius.circular(14),
      dolgu: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: SizedBox(width: double.infinity, child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(width: 36, height: 36, alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle,
              color: const Color(0xFFFFC107).withValues(alpha: 0.12)),
            child: UcdIkon(ikon: ikon, renk: const Color(0xFFFFD54F), boyut: 26)),
          const SizedBox(height: 6),
          SizedBox(height: textHeight, width: double.infinity,
            child: Center(child: Text(label, textAlign: TextAlign.center,
              maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 10,
                height: 1.3, fontWeight: FontWeight.w600)))),
        ],
      )),
    )));
  }
}
