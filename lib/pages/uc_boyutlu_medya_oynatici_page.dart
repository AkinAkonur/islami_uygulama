import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/canli_yayin_konfigurasyonu.dart';
import '../services/radyo_oynatici_store.dart';
import '../widgets/altin_tactile.dart';

/// Gönderilen zümrüt-altın örneğe yakın, tam ekran 3D medya oynatıcısı.
/// Bütün kontrol ikonları kabartmalı [AltinButon] bileşenleridir ve gerçek
/// global radyo oynatıcısını yönetir.
class UcBoyutluMedyaOynaticiPage extends StatefulWidget {
  const UcBoyutluMedyaOynaticiPage({super.key});

  @override
  State<UcBoyutluMedyaOynaticiPage> createState() =>
      _UcBoyutluMedyaOynaticiPageState();
}

class _UcBoyutluMedyaOynaticiPageState
    extends State<UcBoyutluMedyaOynaticiPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _isiltı;
  Timer? _saat;
  DateTime _simdi = DateTime.now();

  @override
  void initState() {
    super.initState();
    _isiltı = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
    _saat = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _simdi = DateTime.now());
    });
  }

  @override
  void dispose() {
    _saat?.cancel();
    _isiltı.dispose();
    super.dispose();
  }

  String _iki(int sayi) => sayi.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF010805),
      body: AnimatedBuilder(
        animation: _isiltı,
        builder: (context, _) => Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: _ZumrutSahneBoyaci(_isiltı.value)),
            SafeArea(
              child: Column(
                children: [
                  _ustCubuk(context),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 520),
                          child: ValueListenableBuilder<RadyoKanali?>(
                            valueListenable: RadyoOynaticiStore.calanKanal,
                            builder: (context, kanal, _) {
                              if (kanal == null) return _bosDurum(context, l);
                              return _oynatici(context, l, kanal);
                            },
                          ),
                        ),
                      ),
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

  Widget _ustCubuk(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          AltinButon(
            boyut: 42,
            ikonBoyut: 20,
            isik: false,
            ikon: Icons.arrow_back_rounded,
            onPressed: () => Navigator.maybePop(context),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              gradient: const LinearGradient(
                colors: [Color(0xFF183323), Color(0xFF07130D)],
              ),
              border: Border.all(color: const Color(0x99EAB308)),
              boxShadow: const [
                BoxShadow(color: Color(0x55EAB308), blurRadius: 14),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.graphic_eq_rounded,
                    color: Color(0xFFFFE9A8), size: 16),
                SizedBox(width: 7),
                Text(
                  '3D HI-RES',
                  style: TextStyle(
                    color: Color(0xFFFFE9A8),
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 42,
            child: Text(
              '${_iki(_simdi.hour)}:${_iki(_simdi.minute)}',
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bosDurum(BuildContext context, AppLocalizations l) {
    return ZumrutCamKutu(
      koseYaricapi: 30,
      kenarKalini: 1.8,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _UcBoyutluKapak(donuyor: false),
          const SizedBox(height: 24),
          Text(
            l.t('df.radioNotFound'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _oynatici(
    BuildContext context,
    AppLocalizations l,
    RadyoKanali kanal,
  ) {
    return ValueListenableBuilder<bool>(
      valueListenable: RadyoOynaticiStore.calyor,
      builder: (context, caliyor, _) =>
          ValueListenableBuilder<bool>(
        valueListenable: RadyoOynaticiStore.yukleniyor,
        builder: (context, yukleniyor, _) =>
            ValueListenableBuilder<int>(
          valueListenable: RadyoOynaticiStore.ses,
          builder: (context, ses, _) => ValueListenableBuilder<Set<String>>(
            valueListenable: RadyoOynaticiStore.favoriler,
            builder: (context, favoriler, _) {
              final favori = favoriler.contains(kanal.url);
              return ZumrutCamKutu(
                koseYaricapi: 30,
                kenarKalini: 1.7,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const _UcBoyutluLogo(),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.t('df.radioTitle').toUpperCase(),
                                style: const TextStyle(
                                  color: Color(0xFFFFD84B),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 12,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                '320 Kbps • 3D Sound',
                                style: TextStyle(
                                  color: Color(0xFF7DAE91),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _UcBoyutluEkolayzir(aktif: caliyor),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _UcBoyutluKapak(donuyor: caliyor),
                        const SizedBox(width: 17),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _durum(caliyor, yukleniyor, l),
                              const SizedBox(height: 9),
                              Text(
                                kanal.ad,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  shadows: [
                                    Shadow(
                                      color: Color(0xAA000000),
                                      offset: Offset(0, 3),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                kanal.aciklama,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFFD3B95D),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _canliCizgi(caliyor),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          l.t(caliyor ? 'rp.live' : 'rp.paused'),
                          style: const TextStyle(
                            color: Color(0xFF6DC391),
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${ses.toString()}%',
                          style: const TextStyle(
                            color: Color(0xFF9A8140),
                            fontWeight: FontWeight.w800,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 21),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AltinButon(
                          boyut: 48,
                          ikon: Icons.stop_rounded,
                          ikonBoyut: 22,
                          isik: false,
                          onPressed: RadyoOynaticiStore.durdur,
                        ),
                        AltinButon(
                          boyut: 54,
                          ikon: Icons.skip_previous_rounded,
                          ikonBoyut: 28,
                          isik: false,
                          onPressed: RadyoOynaticiStore.onceki,
                        ),
                        AltinButon(
                          boyut: 74,
                          ikon: caliyor
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          ikonBoyut: 38,
                          isik: true,
                          onPressed: yukleniyor
                              ? null
                              : () => RadyoOynaticiStore.oynat(kanal),
                        ),
                        AltinButon(
                          boyut: 54,
                          ikon: Icons.skip_next_rounded,
                          ikonBoyut: 28,
                          isik: false,
                          onPressed: RadyoOynaticiStore.sonraki,
                        ),
                        AltinButon(
                          boyut: 48,
                          ikon: favori
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          ikonBoyut: 22,
                          isik: favori,
                          onPressed: () =>
                              RadyoOynaticiStore.favoriDegistir(kanal.url),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 1,
                      color: const Color(0x55EAB308),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(
                          Icons.volume_down_rounded,
                          color: Color(0xFFFFD84B),
                          size: 20,
                          shadows: [
                            Shadow(
                              color: Color(0xAA000000),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Slider(
                            value: ses.toDouble(),
                            max: 100,
                            activeColor: const Color(0xFFEAB308),
                            inactiveColor: const Color(0xFF173525),
                            onChanged: (v) =>
                                RadyoOynaticiStore.sesAyarla(v.round()),
                          ),
                        ),
                        const Icon(
                          Icons.volume_up_rounded,
                          color: Color(0xFFFFD84B),
                          size: 20,
                          shadows: [
                            Shadow(
                              color: Color(0xAA000000),
                              offset: Offset(0, 2),
                              blurRadius: 3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _durum(bool caliyor, bool yukleniyor, AppLocalizations l) {
    final metin = yukleniyor
        ? l.t('rp.connecting')
        : l.t(caliyor ? 'rp.live' : 'rp.paused');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: caliyor ? const Color(0xFFEAB308) : Colors.white38,
            boxShadow: caliyor
                ? const [BoxShadow(color: Color(0xAAEAB308), blurRadius: 8)]
                : null,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            metin.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFFFFD84B),
              fontWeight: FontWeight.w900,
              fontSize: 10,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _canliCizgi(bool caliyor) {
    final hareket = caliyor ? _isiltı.value : 0.35;
    return Container(
      height: 9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF06140D),
        border: Border.all(color: const Color(0xAA765B08)),
        boxShadow: const [
          BoxShadow(color: Color(0x66000000), offset: Offset(0, 3), blurRadius: 5),
        ],
      ),
      padding: const EdgeInsets.all(2),
      child: FractionallySizedBox(
        widthFactor: 0.36 + hareket * 0.56,
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF10A86E), Color(0xFFFFD84B)],
            ),
            boxShadow: const [
              BoxShadow(color: Color(0x8810A86E), blurRadius: 6),
            ],
          ),
        ),
      ),
    );
  }
}

class _UcBoyutluLogo extends StatelessWidget {
  const _UcBoyutluLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF0B0), Color(0xFFEAB308), Color(0xFF755000)],
        ),
        boxShadow: const [
          BoxShadow(color: Color(0x88EAB308), blurRadius: 10),
          BoxShadow(color: Color(0xAA000000), offset: Offset(0, 4), blurRadius: 6),
        ],
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment(-0.4, -0.5),
            colors: [Color(0xFF2D8F63), Color(0xFF05130C)],
          ),
        ),
        child: const Icon(
          Icons.mosque_rounded,
          color: Color(0xFFFFE9A8),
          size: 21,
          shadows: [
            Shadow(color: Color(0xCC000000), offset: Offset(0, 2), blurRadius: 3),
          ],
        ),
      ),
    );
  }
}

class _UcBoyutluKapak extends StatelessWidget {
  const _UcBoyutluKapak({required this.donuyor});

  final bool donuyor;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0018)
        ..rotateY(donuyor ? -0.10 : 0.06)
        ..rotateX(-0.05),
      child: Container(
        width: 116,
        height: 116,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFE9A8), Color(0xFFEAB308), Color(0xFF694700)],
          ),
          boxShadow: const [
            BoxShadow(color: Color(0xAA000000), offset: Offset(10, 13), blurRadius: 18),
            BoxShadow(color: Color(0x55EAB308), offset: Offset(-4, -5), blurRadius: 12),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(17),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/gorseller/medya_kapak_bildirim.jpg',
                fit: BoxFit.cover,
              ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0x44FFFFFF), Color(0x00000000), Color(0x55000000)],
                  ),
                ),
              ),
              Positioned(
                right: 7,
                bottom: 7,
                child: Container(
                  width: 27,
                  height: 27,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFE9A8), Color(0xFFEAB308), Color(0xFF795600)],
                    ),
                    boxShadow: [
                      BoxShadow(color: Color(0xAA000000), offset: Offset(0, 3), blurRadius: 4),
                    ],
                  ),
                  child: const Icon(Icons.graphic_eq_rounded,
                      color: Color(0xFF082016), size: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UcBoyutluEkolayzir extends StatelessWidget {
  const _UcBoyutluEkolayzir({required this.aktif});

  final bool aktif;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: const Color(0xFF06140D),
        border: Border.all(color: const Color(0xAA765B08)),
        boxShadow: const [
          BoxShadow(color: Color(0x99000000), offset: Offset(0, 3), blurRadius: 5),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (i) {
          final h = aktif ? <double>[12, 19, 15, 9][i] : 5.0;
          return AnimatedContainer(
            duration: Duration(milliseconds: 260 + i * 80),
            width: 4,
            height: h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Color(0xFF0BA56B), Color(0xFFFFD84B)],
              ),
              boxShadow: const [
                BoxShadow(color: Color(0x6610A86E), blurRadius: 4),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ZumrutSahneBoyaci extends CustomPainter {
  const _ZumrutSahneBoyaci(this.ilerleme);

  final double ilerleme;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const RadialGradient(
          center: Alignment(0, -0.35),
          radius: 1.3,
          colors: [Color(0xFF073825), Color(0xFF01110B), Color(0xFF000503)],
          stops: [0, 0.52, 1],
        ).createShader(rect),
    );

    final isik = Paint()..color = const Color(0xFF15A66F).withValues(alpha: 0.18);
    for (var i = 0; i < 46; i++) {
      final x = ((i * 83) % math.max(1, size.width.toInt())).toDouble();
      final temelY = ((i * 137) % math.max(1, size.height.toInt())).toDouble();
      final y = (temelY + ilerleme * (12 + i % 5)) % size.height;
      final r = 0.8 + (i % 4) * 0.65;
      canvas.drawCircle(Offset(x, y), r, isik);
    }

    // Alt bölümde perspektif ışık çizgileri.
    final ufuk = size.height * 0.72;
    final cizgi = Paint()
      ..color = const Color(0xFF1B9064).withValues(alpha: 0.10)
      ..strokeWidth = 1;
    for (var i = -6; i <= 6; i++) {
      canvas.drawLine(
        Offset(size.width / 2 + i * 10, ufuk),
        Offset(size.width / 2 + i * size.width / 7, size.height),
        cizgi,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ZumrutSahneBoyaci oldDelegate) =>
      oldDelegate.ilerleme != ilerleme;
}
