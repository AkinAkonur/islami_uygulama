import 'dart:math' as math;

import 'package:flutter/material.dart';

class AcilisEkrani extends StatefulWidget {
  const AcilisEkrani({super.key, required this.sonraki});

  final Widget sonraki;

  @override
  State<AcilisEkrani> createState() => _AcilisEkraniState();
}

class _AcilisEkraniState extends State<AcilisEkrani>
    with TickerProviderStateMixin {
  late final AnimationController _sure;
  late final AnimationController _donus;

  @override
  void initState() {
    super.initState();
    _sure = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _donus = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
    _sure.forward().then((_) => _gec());
  }

  void _gec() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => widget.sonraki,
        transitionsBuilder: (_, animasyon, _, cocuk) =>
            FadeTransition(opacity: animasyon, child: cocuk),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _sure.dispose();
    _donus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD4AF37),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF7DE8C),
              Color(0xFFEAC159),
              Color(0xFFD4AF37),
              Color(0xFFB8860B),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -120,
              left: -120,
              child: Container(
                width: 420,
                height: 420,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x33FFFFFF),
                ),
              ),
            ),
            Positioned(
              bottom: -160,
              right: -140,
              child: Container(
                width: 460,
                height: 460,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x22FFFFFF),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _sure,
                      curve: const Interval(0, 0.25, curve: Curves.easeIn),
                    ),
                    child: _DonanLogo(animasyon: _donus),
                  ),
                  const SizedBox(height: 46),
                  FadeTransition(
                    opacity: CurvedAnimation(
                      parent: _sure,
                      curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'İslami Uygulama',
                          style: TextStyle(
                            color: Color(0xFF0B150E),
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Huzur & Manevi Yolculuk',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.92),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 3.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DonanLogo extends StatelessWidget {
  const _DonanLogo({required this.animasyon});

  final Animation<double> animasyon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0x55FFFFFF),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66FFFFFF),
            blurRadius: 70,
            spreadRadius: 4,
          ),
        ],
      ),
      child: AnimatedBuilder(
        animation: animasyon,
        builder: (context, child) {
          final aci = animasyon.value * 2 * math.pi;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0012)
              ..rotateY(aci),
            child: child,
          );
        },
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFFFFFFF),
            border: Border.all(color: const Color(0xFF0B150E), width: 3),
            image: const DecorationImage(
              image: AssetImage('assets/branding/app_icon_source.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}