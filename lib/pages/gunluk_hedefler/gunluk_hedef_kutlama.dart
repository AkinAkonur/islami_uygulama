import 'dart:math';

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import 'gunluk_hedef_store.dart';

class KutlamaEkrani extends StatefulWidget {
  const KutlamaEkrani({super.key, required this.sonuc, required this.seri});

  final GunlukHedefSonuc sonuc;
  final int seri;

  @override
  State<KutlamaEkrani> createState() => _KutlamaEkraniState();
}

class _KutlamaEkraniState extends State<KutlamaEkrani>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 3400),
  );
  late final List<_Parcacik> _parcalar = List.generate(
    70,
    (_) => _Parcacik(Random(), MediaQuery.of(context).size.width),
  );

  @override
  void initState() {
    super.initState();
    _ac.addStatusListener((durum) {
      if (durum == AnimationStatus.completed && mounted) {
        Navigator.pop(context);
      }
    });
    _ac.forward();
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final baslik = widget.sonuc.gunTamamlandi
        ? l.t('gk.titleDone')
        : l.t('gk.titleBadge');
    final altMetin = widget.sonuc.gunTamamlandi
        ? l.t('gk.streak').replaceFirst('{count}', '${widget.seri}')
        : '${widget.sonuc.yeniRozetler.first.ikon} '
            '${widget.sonuc.yeniRozetler.first.ad}: '
            '${widget.sonuc.yeniRozetler.first.aciklama}';
    final ekXp = widget.sonuc.kazanilanXp;

    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedBuilder(
              animation: _ac,
              builder: (context, _) => CustomPaint(
                painter: _KonfetiPainter(
                  parcalar: _parcalar,
                  t: _ac.value,
                ),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _ac,
                  curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack),
                ),
                child: Container(
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Renkler.kart,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Renkler.vurgu.withValues(alpha: 0.6),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Renkler.vurgu.withValues(alpha: 0.35),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!widget.sonuc.gunTamamlandi)
                        Text(
                          widget.sonuc.yeniRozetler.first.ikon,
                          style: const TextStyle(fontSize: 56),
                        ),
                      const SizedBox(height: 12),
                      Text(
                        baslik,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        altMetin,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      if (ekXp > 0) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Renkler.vurgu.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '+$ekXp XP',
                            style: TextStyle(
                              color: Renkler.vurgu,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Parcacik {
  final double x;
  final double hiz;
  final double boyut;
  final Color renk;
  final double sallanma;
  final double faz;
  final double burulma;

  _Parcacik(Random r, double genislik)
      : x = r.nextDouble() * genislik,
        hiz = 0.6 + r.nextDouble() * 0.7,
        boyut = 6 + r.nextDouble() * 7,
        renk = _renkler[r.nextInt(_renkler.length)],
        sallanma = 2 + r.nextDouble() * 5,
        faz = r.nextDouble() * 6,
        burulma = (r.nextDouble() - 0.5) * 12;
}

const List<Color> _renkler = [
  Color(0xFFF2C14E),
  Color(0xFF4FC3C9),
  Color(0xFFF09A6E),
  Color(0xFF9BB8E8),
  Color(0xFF10B981),
  Color(0xFFEC4899),
];

class _KonfetiPainter extends CustomPainter {
  _KonfetiPainter({required this.parcalar, required this.t});

  final List<_Parcacik> parcalar;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in parcalar) {
      final y = (size.height + 40) * t * p.hiz;
      final x = p.x + sin(t * 6 + p.faz) * p.sallanma * 10;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(t * p.burulma);
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: p.boyut,
          height: p.boyut * 0.55,
        ),
        Paint()..color = p.renk,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_KonfetiPainter oldDelegate) => oldDelegate.t != t;
}
