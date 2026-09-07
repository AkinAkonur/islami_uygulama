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
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.lerp(renk, Colors.white, 0.50)!, renk, dip],
        stops: const [0.0, 0.38, 1.0],
      ).createShader(bounds),
      child: Icon(
        ikon,
        size: boyut,
        color: Colors.white,
        shadows: golge
            ? [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.30),
                  offset: const Offset(0, 1.1),
                  blurRadius: 2,
                ),
              ]
            : null,
      ),
    );
  }
}
