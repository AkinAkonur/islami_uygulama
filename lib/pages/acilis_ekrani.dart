// ===========================================================================
// AÇILIŞ EKRANI (Animasyonlu · 3D his)
// ---------------------------------------------------------------------------
// Uygulama açılırken gösterilen kısa (yaklaşık 2,6 sn) tanıtım ekranı:
//  • Arka plan: kâbe yeşili degradesi + nabız gibi atan altın hale
//  • 3D his: perspektif matrisiyle hafifçe dönen Kâbe (altın kuşak & kapı)
//  • Dönen altın halka + yükselen altın yıldız parçacıkları
//  • Otomatik geçiş; ekrana dokunan kullanıcı için derhal geçiş.
// ===========================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../services/renkler.dart';

class AcilisEkrani extends StatefulWidget {
  const AcilisEkrani({super.key, required this.sonraki});

  /// Açılış bitince gösterilecek ana ekran.
  final Widget sonraki;

  @override
  State<AcilisEkrani> createState() => _AcilisEkraniState();
}

class _AcilisEkraniState extends State<AcilisEkrani>
    with TickerProviderStateMixin {
  late final AnimationController _kontrol = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  );
  bool _gectiMi = false;

  @override
  void initState() {
    super.initState();
    _kontrol.forward().whenComplete(_gec);
  }

  @override
  void dispose() {
    _kontrol.dispose();
    super.dispose();
  }

  void _gec() {
    if (_gectiMi || !mounted) return;
    _gectiMi = true;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (_, _, _) => widget.sonraki,
        transitionsBuilder: (_, animasyon, _, cocuk) {
          final t = Curves.easeOutCubic.transform(animasyon.value);
          return Opacity(
            opacity: t,
            child: Transform.scale(scale: 0.96 + 0.04 * t, child: cocuk),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boyut = MediaQuery.of(context).size;
    final buyukluk = math.min(boyut.width, boyut.height);

    return Scaffold(
      backgroundColor: Renkler.zemin,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _gec,
        child: AnimatedBuilder(
          animation: _kontrol,
          builder: (context, _) {
            final v = _kontrol.value;
            final yumusak = Curves.easeInOut.transform(v);

            // Kâbe'nin 3D salınımı (periyodik, hafif).
            final salincak =
                math.sin(v * math.pi * 4) * 0.38 + math.sin(v * math.pi * 2) * 0.12;
            final yuzus = math.sin(v * math.pi * 4 + 0.7) * 4.5;

            return Stack(
              fit: StackFit.expand,
              children: [
                // Arka plan: degradeler, altın hale, halka ve yıldızlar.
                CustomPaint(
                  painter: _ArkaPlanResmi(ilerleme: v, boyut: boyut),
                ),

                // İçerik (başlık + alt yazı): yumuşak belirme + yukarı kayma.
                Positioned(
                  left: 24,
                  right: 24,
                  top: boyut.height * 0.10 + (1 - yumusak) * 18,
                  child: Opacity(
                    opacity: yumusak,
                    child: Column(
                      children: [
                        Icon(Icons.mosque_rounded,
                            size: 34, color: Renkler.vurgu),
                        const SizedBox(height: 10),
                        _altinYazi(
                          'İslami Uygulama',
                          fontBoyut: 30,
                          kalin: true,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Huzur & Manevi Yolculuk',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 13,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Kâbe — 3D perspektif + salınım + yüzer hareket.
                Positioned.fill(
                  child: Align(
                    alignment: const Alignment(0, -0.10),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.0018)
                        ..rotateY(salincak)
                        ..rotateX(0.18)
                        ..translateByDouble(0.0, yuzus, 0.0, 1.0),
                      child: CustomPaint(
                        size: Size(buyukluk * 0.52, buyukluk * 0.52),
                        painter: _KabeResmi(),
                      ),
                    ),
                  ),
                ),

                // Alt bant: ipucu + ince altın ilerleme çubuğu.
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: boyut.height * 0.07,
                  child: Opacity(
                    opacity: yumusak,
                    child: Column(
                      children: [
                        Text(
                          'Devam etmek için dokunun',
                          style: TextStyle(
                            color: Colors.white38
                                .withValues(alpha: 0.5 + 0.5 * _nabiz(v)),
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: SizedBox(
                            width: 140,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: LinearProgressIndicator(
                                value: v,
                                minHeight: 3,
                                backgroundColor: Renkler.kart,
                                valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFFD4AF37),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  double _nabiz(double v) {
    return (math.sin(v * math.pi * 10) + 1) / 2;
  }

  Widget _altinYazi(String metin, {double fontBoyut = 24, bool kalin = false}) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFEED07A), Color(0xFFD4AF37), Color(0xFF9C7716)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(
        metin,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontBoyut,
          fontWeight: kalin ? FontWeight.w800 : FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// ARKA PLAN RESMİ (deg, hale, halka, yıldızlar)
// ---------------------------------------------------------------------------
class _ArkaPlanResmi extends CustomPainter {
  _ArkaPlanResmi({required this.ilerleme, required this.boyut});

  final double ilerleme;
  final Size boyut;

  static const _altin = Color(0xFFD4AF37);
  static const _acikAltin = Color(0xFFEED07A);
  static const _yesilKoyu = Color(0xFF0B150E);
  static const _yesilYuz = Color(0xFF1B3022);
  static const _yesilAci = Color(0xFF29432F);

  @override
  void paint(Canvas canvas, Size size) {
    final merkez = Offset(size.width / 2, size.height * 0.40);

    // Koyu yeşil dikey degrade.
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const LinearGradient(
          colors: [_yesilKoyu, _yesilYuz, _yesilAci, _yesilKoyu],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Offset.zero & size),
    );

    // Nabız gibi atan altın hale (Kâbe arkası).
    final haleYaricap = size.width * (0.30 + 0.045 * math.sin(ilerleme * math.pi * 4));
    canvas.drawCircle(
      merkez,
      haleYaricap,
      Paint()
        ..shader = RadialGradient(
          colors: [
            _altin.withValues(alpha: 0.28),
            _altin.withValues(alpha: 0.08),
            Colors.transparent,
          ],
          stops: const [0.0, 0.6, 1.0],
        ).createShader(
          Rect.fromCircle(center: merkez, radius: haleYaricap + 40),
        ),
    );

    // Dönen altın halka (iki parçalı; uçta parlak nokta).
    final halkaYaricap = size.width * 0.34;
    final aci = ilerleme * math.pi * 2;
    final katli = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round;

    for (final (kayma, opaklik, kalin) in [
      (0.0, 0.55, 1.6),
      (math.pi, 0.30, 3.2),
    ]) {
      katli
        ..color = _acikAltin.withValues(alpha: opaklik)
        ..strokeWidth = kalin;
      canvas.drawArc(
        Rect.fromCircle(center: merkez, radius: halkaYaricap),
        aci + kayma,
        math.pi * 1.15,
        false,
        katli,
      );
    }

    // Halka üzerinde süzülen parlak nokta.
    final nokta = Offset(
      merkez.dx + math.cos(aci) * halkaYaricap,
      merkez.dy + math.sin(aci) * halkaYaricap,
    );
    canvas.drawCircle(nokta, 4, Paint()..color = _altin);
    canvas.drawCircle(
      nokta,
      12,
      Paint()..color = _altin.withValues(alpha: 0.25),
    );

    // Yükselen altın yıldız parçacıkları.
    for (var i = 0; i < 26; i++) {
      final x = _f(i, size.width);
      final hiz = 0.04 + _f(i + 100, 0.09);
      final faz = _f(i + 200, 1.0);
      final y = size.height * (1 - (((ilerleme * hiz) + faz) % 1.0));
      final ic = _f(i + 300, 0.6) + 0.4;
      final buyukluk = 1.0 + _f(i + 400, 2.6);
      final alfa = _f(i + 500, 0.5);
      final renk = i.isEven ? _acikAltin : _yesilAci;
      canvas.drawCircle(
        Offset(x, y),
        buyukluk,
        Paint()..color = renk.withValues(alpha: ic * alfa),
      );
    }
  }

  /// Belirli parçacık özellikleri için kararlı sözde-rastgele değer.
  double _f(int i, double aralik) {
    final deger = ((i * 9301 + 49297) % 233280) / 233280;
    return deger * aralik;
  }

  @override
  bool shouldRepaint(_ArkaPlanResmi oldDelegate) =>
      oldDelegate.ilerleme != ilerleme;
}

// ---------------------------------------------------------------------------
// KÂBE RESMİ (ön cephe; 3D perspektif dönüştürücüyle sahneye yerleşir)
// ---------------------------------------------------------------------------
class _KabeResmi extends CustomPainter {
  static const _altin = Color(0xFFD4AF37);
  static const _acikAltin = Color(0xFFEED07A);
  static const _golgeAltin = Color(0xFF8A6A1F);
  static const _govde = Color(0xFF121713);

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height * 0.40);
    final g = size.width * 0.72; // ön yüz genişliği
    final y = size.height * 0.80; // yükseklik
    final left = c.dx - g / 2;
    final ust = c.dy - y;
    final govde = Rect.fromLTWH(left, ust, g, y);

    // Zemin yansıması / gölge.
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(c.dx, c.dy + y * 0.16),
        width: g * 1.5,
        height: y * 0.14,
      ),
      Paint()..color = Colors.black.withValues(alpha: 0.45),
    );

    // Gövde (dikey ışık geçişi).
    canvas.drawRect(
      govde,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF1A211A), _govde, Color(0xFF070B08)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(govde),
    );

    // Altın band (kisve kuşağı).
    final bandY = ust + y * 0.20;
    final bandH = y * 0.055;
    canvas.drawRect(
      Rect.fromLTWH(left, bandY, g, bandH),
      Paint()
        ..shader = const LinearGradient(
          colors: [_acikAltin, _altin, _golgeAltin],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(Rect.fromLTWH(left, bandY, g, bandH)),
    );
    canvas.drawRect(
      Rect.fromLTWH(left, bandY + bandH, g, 2.2),
      Paint()..color = _altin.withValues(alpha: 0.7),
    );

    // Kuşak altı altın hatlar (iplikler).
    final hatlar = Paint()
      ..color = _altin.withValues(alpha: 0.28)
      ..strokeWidth = 1.1;
    for (var i = 1; i <= 6; i++) {
      final x = left + (g * i) / 7;
      canvas.drawLine(
        Offset(x, bandY + bandH + 3),
        Offset(x, govde.bottom - 6),
        hatlar,
      );
    }

    // Kapı (altın, yumuşak parıltılı).
    final kapiW = g * 0.18;
    final kapiH = y * 0.26;
    final kapi = Rect.fromCenter(
      center: Offset(c.dx, govde.bottom - kapiH / 2),
      width: kapiW,
      height: kapiH,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(kapi, const Radius.circular(4)),
      Paint()
        ..shader = LinearGradient(
          colors: [_acikAltin, _altin, _golgeAltin],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(kapi),
    );
    canvas.drawRect(
      kapi.deflate(2),
      Paint()..color = const Color(0xFF9C7716).withValues(alpha: 0.35),
    );

    // Hacerülesved köşesi.
    final tasMerkez = Offset(left + g * 0.13, govde.bottom - g * 0.11);
    canvas.drawCircle(tasMerkez, g * 0.075, Paint()..color = const Color(0xFF0A0D0A));
    canvas.drawCircle(
      tasMerkez,
      g * 0.075,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6
        ..shader = const LinearGradient(
          colors: [_acikAltin, _altin, _goldShadow],
        ).createShader(Rect.fromCircle(center: tasMerkez, radius: g * 0.08)),
    );

    // Üstte ince altın çizgi + köşe vurgusu.
    canvas.drawRect(
      Rect.fromLTWH(left, ust, g, 2.2),
      Paint()..color = _altin.withValues(alpha: 0.85),
    );
    canvas.drawCircle(
      Offset(c.dx, ust),
      g * 0.16,
      Paint()..color = _acikAltin.withValues(alpha: 0.16),
    );
  }

  @override
  bool shouldRepaint(_KabeResmi oldDelegate) => false;
}

const _goldShadow = Color(0xFF8A6A1F); // const liste için üst düzey sabit