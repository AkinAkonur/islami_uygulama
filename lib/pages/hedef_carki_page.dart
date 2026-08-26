import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/kart_sekilleri.dart';
import '../services/manevi_store.dart';
import '../services/renkler.dart';

class HedefCarkiPage extends StatefulWidget {
  const HedefCarkiPage({super.key});

  @override
  State<HedefCarkiPage> createState() => _HedefCarkiPageState();
}

class _HedefCarkiPageState extends State<HedefCarkiPage> {
  Map<String, int> _hedefler = {
    'kuran': 0,
    'zikir': 0,
    'namaz': 0,
    'dua': 0,
    'tesbih': 0,
    'sadaka': 0,
  };
  List<(String, String, int)> _ozelHedefler = [];
  final TextEditingController _baslikController = TextEditingController();
  final TextEditingController _limitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  @override
  void dispose() {
    _baslikController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  Future<void> _yukle() async {
    final h = await ManeviStore.hedeflerOku();
    final ozel = await ManeviStore.ozelHedefler();
    if (mounted) {
      setState(() {
        _hedefler = h;
        _ozelHedefler = ozel;
      });
    }
  }

  Future<void> _arttir(String tur) async {
    final h = await ManeviStore.hedefEkle(tur, 1);
    if (mounted) setState(() => _hedefler = h);
  }

  Future<void> _azalt(String tur) async {
    final h = await ManeviStore.hedefEkle(tur, -1);
    if (mounted) setState(() => _hedefler = h);
  }

  Future<void> _hedefEkle() async {
    final baslik = _baslikController.text.trim();
    final limit = int.tryParse(_limitController.text.trim());
    if (baslik.isEmpty || limit == null || limit < 1) return;
    final yeni = await ManeviStore.ozelHedefEkle(baslik, limit);
    final h = await ManeviStore.hedeflerOku();
    if (mounted) {
      setState(() {
        _ozelHedefler = yeni;
        _hedefler = h;
      });
      _baslikController.clear();
      _limitController.clear();
    }
  }

  Future<void> _hedefSil(String id) async {
    final yeni = await ManeviStore.ozelHedefSil(id);
    final h = await ManeviStore.hedeflerOku();
    if (mounted) {
      setState(() {
        _ozelHedefler = yeni;
        _hedefler = h;
      });
    }
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
                      ikon: Icons.menu_book_rounded,
                    ),
                    const SizedBox(height: 16),
                    _halkaKarti(
                      tur: 'zikir',
                      baslik: 'Zikir',
                      hedef: '100 zikir',
                      ikon: Icons.radio_button_checked_rounded,
                    ),
                    const SizedBox(height: 16),
                    _halkaKarti(
                      tur: 'namaz',
                      baslik: 'Namaz',
                      hedef: '5 vakit',
                      ikon: Icons.mosque_rounded,
                    ),
                    const SizedBox(height: 16),
                    _halkaKarti(
                      tur: 'dua',
                      baslik: 'Dua',
                      hedef: '10 dua',
                      ikon: Icons.favorite_outline_rounded,
                    ),
                    const SizedBox(height: 16),
                    _halkaKarti(
                      tur: 'tesbih',
                      baslik: 'Tesbih',
                      hedef: '33 tesbih',
                      ikon: Icons.filter_vintage_rounded,
                    ),
                    const SizedBox(height: 16),
                    _halkaKarti(
                      tur: 'sadaka',
                      baslik: 'Sadaka',
                      hedef: '3 sadaka',
                      ikon: Icons.volunteer_activism_rounded,
                    ),
                    if (_ozelHedefler.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Divider(color: Colors.white12, height: 1),
                      const SizedBox(height: 16),
                      Text(
                        'Senin Eklediklerin',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final h in _ozelHedefler) ...[
                        _ozelHedefKarti(h),
                        const SizedBox(height: 12),
                      ],
                    ],
                    const SizedBox(height: 16),
                    const Divider(color: Colors.white12, height: 1),
                    const SizedBox(height: 16),
                    _eklemeKarti(),
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
            icon: const UcdIkon(ikon: Icons.arrow_back_ios_new, renk: Colors.white),
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
          const UcdIkon(ikon: Icons.donut_large_rounded, renk: Colors.white54),
        ],
      ),
    );
  }

  Widget _ozetKarti() {
    final toplamHedef = ManeviStore.hedefLimitleri.length + _ozelHedefler.length;
    final tamam = ManeviStore.hedefLimitleri.entries
        .where((e) => (_hedefler[e.key] ?? 0) >= e.value)
        .length;
    final tamamOzel = _ozelHedefler.where((h) {
      final limit = h.$3;
      return (_hedefler[h.$1] ?? 0) >= limit;
    }).length;
    final tumTamam = tamam + tamamOzel;
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
          const UcdIkon(ikon: Icons.emoji_events_rounded, renk: Colors.white, boyut: 30),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tumTamam >= toplamHedef
                  ? 'Bugünün tüm hedeflerini tamamladın, maşallah!'
                  : 'Bugün $tumTamam/$toplamHedef hedefe ulaştın. Devam et!',
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

  Widget _ozelHedefKarti((String, String, int) h) {
    final tur = h.$1;
    final baslik = h.$2;
    final limit = h.$3;
    final deger = _hedefler[tur] ?? 0;
    final oran = limit == 0 ? 0.0 : (deger / limit).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
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
                    UcdIkon(ikon: Icons.star_outline_rounded, renk: Renkler.vurgu, boyut: 16),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        baslik,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$deger / $limit · hedef: $limit adet',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      onPressed: deger <= 0 ? null : () => _azalt(tur),
                      icon: UcdIkon(ikon: Icons.remove_circle_outline_rounded, renk: Renkler.vurgu, boyut: 20)),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: deger >= limit ? null : () => _arttir(tur),
                      icon: UcdIkon(ikon: Icons.add_circle_outline_rounded, renk: Renkler.vurgu, boyut: 20)),
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
          IconButton(
            onPressed: () => _hedefSil(tur),
            tooltip: 'Hedefi kaldır',
            icon: const UcdIkon(ikon: Icons.delete_outline_rounded, renk: Colors.white38),
          ),
        ],
      ),
    );
  }

  Widget _eklemeKarti() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Yeni Hedef Ekle',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _baslikController,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            cursorColor: Renkler.vurgu,
            maxLength: 40,
            onSubmitted: (_) => _hedefEkle(),
            decoration: InputDecoration(
              counterText: '',
              isDense: true,
              labelText: 'Hedef adı',
              labelStyle: const TextStyle(color: Colors.white54),
              hintText: 'örn. İlmihal, Hatim, Oruç',
              hintStyle: const TextStyle(color: Colors.white38),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white24),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Renkler.vurgu),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _limitController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  cursorColor: Renkler.vurgu,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onSubmitted: (_) => _hedefEkle(),
                  decoration: InputDecoration(
                    counterText: '',
                    isDense: true,
                    labelText: 'Hedef miktarı',
                    labelStyle: const TextStyle(color: Colors.white54),
                    hintText: 'örn. 10',
                    hintStyle: const TextStyle(color: Colors.white38),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Renkler.vurgu),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: _hedefEkle,
                style: FilledButton.styleFrom(
                  backgroundColor: Renkler.vurgu,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                icon: const UcdIkon(ikon: Icons.add_rounded, renk: Colors.white, boyut: 18),
                label: const Text('Ekle'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Eklediğin hedefler çarkına eklenir; çöp kutusuyla kaldırabilirsin.',
            style: TextStyle(color: Colors.white38, fontSize: 11),
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
    final deger = _hedefler[tur] ?? 0;
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
                    UcdIkon(ikon: ikon, renk: Renkler.vurgu, boyut: 16),
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
                      icon: UcdIkon(ikon: Icons.remove_circle_outline_rounded, renk: Renkler.vurgu, boyut: 20)),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: deger >= limit ? null : () => _arttir(tur),
                      icon: UcdIkon(ikon: Icons.add_circle_outline_rounded, renk: Renkler.vurgu, boyut: 20)),
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
