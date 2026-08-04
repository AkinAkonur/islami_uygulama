import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../services/manevi_store.dart';
import '../services/renkler.dart';

class HedefCarkiPage extends StatefulWidget {
  const HedefCarkiPage({super.key});

  @override
  State<HedefCarkiPage> createState() => _HedefCarkiPageState();
}

class _HedefCarkiPageState extends State<HedefCarkiPage> {
  Map<String, int> _hedefler = {'kuran': 0, 'zikir': 0, 'namaz': 0};

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final h = await ManeviStore.hedeflerOku();
    if (mounted) setState(() => _hedefler = h);
  }

  Future<void> _arttir(String tur) async {
    final h = await ManeviStore.hedefEkle(tur, 1);
    if (mounted) setState(() => _hedefler = h);
  }

  Future<void> _azalt(String tur) async {
    final h = await ManeviStore.hedefEkle(tur, -1);
    if (mounted) setState(() => _hedefler = h);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Renkler.bannerUst, Renkler.bannerAlt],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _baslikSatiri(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _ozetKarti(),
                    const SizedBox(height: 16),
                    _halkaKarti(
                      tur: 'kuran',
                      baslik: 'Kur\'an',
                      hedef: '5 sayfa',
                      ikon: Icons.menu_book_outlined,
                    ),
                    const SizedBox(height: 16),
                    _halkaKarti(
                      tur: 'zikir',
                      baslik: 'Zikir',
                      hedef: '100 zikir',
                      ikon: Icons.radio_button_checked,
                    ),
                    const SizedBox(height: 16),
                    _halkaKarti(
                      tur: 'namaz',
                      baslik: 'Namaz',
                      hedef: '5 vakit',
                      ikon: Icons.mosque_outlined,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baslikSatiri(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const SizedBox(width: 8),
          const Text(
            'Manevi Hedef Çarkı',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.donut_large_outlined, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _ozetKarti() {
    final tamam = ManeviStore.hedefLimitleri.entries
        .where((e) => _hedefler[e.key]! >= e.value)
        .length;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.vurgu, Renkler.vurgu.withValues(alpha: 0.55)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tamam >= 3
                  ? 'Bugünün tüm hedeflerini tamamladın, maşallah!'
                  : 'Bugün $tamam/3 hedefe ulaştın. Devam et!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _halkaKarti({
    required String tur,
    required String baslik,
    required String hedef,
    required IconData ikon,
  }) {
    final limit = ManeviStore.hedefLimitleri[tur]!;
    final deger = _hedefler[tur]!;
    final oran = limit == 0 ? 0.0 : (deger / limit).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 72,
            height: 72,
            child: _HalkaCizimi(oran: oran),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(ikon, color: Renkler.vurgu, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      baslik,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$deger / $limit · hedef: $hedef',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      onPressed: deger <= 0 ? null : () => _azalt(tur),
                      icon: const Icon(Icons.remove_circle_outline, size: 20),
                      color: Renkler.vurgu,
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: deger >= limit ? null : () => _arttir(tur),
                      icon: const Icon(Icons.add_circle_outline, size: 20),
                      color: Renkler.vurgu,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${(oran * 100).round()}%',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

class _HalkaCizimi extends StatelessWidget {
  final double oran;

  const _HalkaCizimi({required this.oran});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HalkaPainter(oran: oran),
      child: Center(
        child: Text(
          '${(oran * 100).round()}%',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _HalkaPainter extends CustomPainter {
  final double oran;

  _HalkaPainter({required this.oran});

  @override
  void paint(Canvas canvas, Size size) {
    final merkez = size.center(Offset.zero);
    final yaricap = math.min(size.width, size.height) / 2 - 5;
    final arka = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..color = Renkler.cerceve;
    final on = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..color = Renkler.vurgu;
    canvas.drawCircle(merkez, yaricap, arka);
    if (oran > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: merkez, radius: yaricap),
        -math.pi / 2,
        2 * math.pi * oran,
        false,
        on,
      );
    }
  }

  @override
  bool shouldRepaint(_HalkaPainter oldDelegate) => oldDelegate.oran != oran;
}
