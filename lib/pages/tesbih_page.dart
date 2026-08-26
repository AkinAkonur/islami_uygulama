import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/kart_sekilleri.dart';
import '../services/manevi_store.dart';
import '../services/renkler.dart';

class TesbihPage extends StatefulWidget {
  const TesbihPage({super.key});

  @override
  State<TesbihPage> createState() => _TesbihPageState();
}

class _TesbihPageState extends State<TesbihPage>
    with SingleTickerProviderStateMixin {
  int _count = 0;
  int _totalCount = 0;
  String _selectedZikir = ManeviStore.varsayilanZikirler.first;
  List<String> _ozelZikirler = [];
  late final AnimationController _animasyon;
  bool _patlama = false;

  static final RegExp _hedefDeseni = RegExp(r'\((\d+)\)');

  @override
  void initState() {
    super.initState();
    _animasyon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.92,
      upperBound: 1.0,
      value: 1.0,
    );
    ManeviStore.ozelZikirler().then((liste) {
      if (mounted) setState(() => _ozelZikirler = liste);
    });
  }

  @override
  void dispose() {
    _animasyon.dispose();
    super.dispose();
  }

  List<String> get _zikirListesi =>
      [...ManeviStore.varsayilanZikirler, ..._ozelZikirler];

  int get _hedefSayi {
    final eslesme = _hedefDeseni.firstMatch(_selectedZikir);
    return eslesme != null ? int.tryParse(eslesme.group(1)!) ?? 33 : 33;
  }

  void _increment() {
    final hedef = _hedefSayi;
    _animasyon.forward(from: 0.92);
    setState(() {
      _count++;
      _totalCount++;
      if (_count >= hedef) {
        _count = 0;
        _patlama = true;
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) setState(() => _patlama = false);
        });
      }
    });
  }

  void _reset() {
    setState(() => _count = 0);
  }

  Future<void> _zikirEkleDialog() async {
    final controller = TextEditingController();
    final eklenen = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Renkler.kart,
        title: const Text(
          'Yeni Zikir Ekle',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          cursorColor: Renkler.vurgu,
          maxLength: 60,
          onSubmitted: (deger) => Navigator.pop(ctx, deger.trim()),
          decoration: InputDecoration(
            counterText: '',
            hintText: 'Zikir metni… (örn. Ya Rahman (33))',
            hintStyle: const TextStyle(color: Colors.white38),
            labelText: 'Zikir adı',
            labelStyle: const TextStyle(color: Colors.white54),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Renkler.vurgu),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Vazgeç'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
    if (eklenen == null || eklenen.isEmpty) return;
    final liste = await ManeviStore.zikirEkle(eklenen);
    if (mounted) {
      setState(() {
        _ozelZikirler = liste;
        _selectedZikir = eklenen;
        _count = 0;
      });
    }
  }

  Future<void> _zikirSil(String zikir) async {
    final liste = await ManeviStore.zikirSil(zikir);
    if (!mounted) return;
    setState(() {
      _ozelZikirler = liste;
      if (_selectedZikir == zikir) {
        _selectedZikir = _zikirListesi.isNotEmpty
            ? _zikirListesi.first
            : 'Sübhanallah (33)';
        _count = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hedef = _hedefSayi;
    final oran = hedef == 0 ? 0.0 : (_count / hedef).clamp(0.0, 1.0);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("Dijital Akıllı Tesbih (Zikirmatik)"),
        backgroundColor: Color(0xFF2B1E26),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2B1E26), Color(0xFF1B1016)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _zikirSecimKarti(),
                const Spacer(),
                _kasa(hedef: hedef, oran: oran),
                const SizedBox(height: 28),
                _altBilgi(hedef, oran),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _zikirSecimKarti() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.pinkAccent.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedZikir,
                isExpanded: true,
                dropdownColor: Renkler.kart,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                icon: const UcdIkon(ikon: Icons.arrow_drop_down_rounded, renk: Colors.pinkAccent),
                items: _zikirListesi.map((String zikir) {
                  return DropdownMenuItem<String>(
                    value: zikir,
                    child: Text(zikir, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedZikir = newValue;
                      _count = 0;
                    });
                  }
                },
              ),
            ),
          ),
          IconButton(
            onPressed: _reset,
            tooltip: 'Sayacı sıfırla',
            icon: const UcdIkon(ikon: Icons.refresh_rounded, renk: Colors.white54),
          ),
          IconButton(
            onPressed: _zikirEkleDialog,
            tooltip: 'Zikir ekle',
            icon: UcdIkon(ikon: Icons.add_circle_outline_rounded, renk: Colors.pinkAccent),
          ),
          if (_ozelZikirler.contains(_selectedZikir))
            IconButton(
              onPressed: () => _zikirSil(_selectedZikir),
              tooltip: 'Zikri kaldır',
              icon: const UcdIkon(ikon: Icons.delete_outline_rounded, renk: Colors.white54),
            ),
        ],
      ),
    );
  }

  /// 3D görünümlü ana tespih kasası: derin gölge, parlak yüzey, boncuk
  /// halkası ve dokunma animasyonu.
  Widget _kasa({required int hedef, required double oran}) {
    return AnimatedBuilder(
      animation: _animasyon,
      builder: (context, _) {
        return ScaleTransition(
          scale: _animasyon,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Dış halo
              Container(
                width: 292,
                height: 292,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.pinkAccent.withValues(alpha: _patlama ? 0.55 : 0.28),
                      Colors.pinkAccent.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              // Boncuk halkası
              CustomPaint(
                size: const Size(272, 272),
                painter: _BoncukHalkasiPainter(oran: oran),
              ),
              // 3D tespih topuzu
              GestureDetector(
                onTap: _increment,
                child: Container(
                  width: 218,
                  height: 218,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFD81B60), Color(0xFF6A1B9A)],
                    ),
                    boxShadow: [
                      // Dışa doğru derin gölge (3D kalkıklık)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.55),
                        blurRadius: 34,
                        offset: const Offset(12, 18),
                      ),
                      BoxShadow(
                        color: Colors.pinkAccent.withValues(alpha: 0.45),
                        blurRadius: 26,
                        offset: const Offset(-6, -6),
                      ),
                    ],
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.22),
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Üst parlama (glass highlight)
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 96,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              center: const Alignment(0, -1.1),
                              colors: [
                                Colors.white.withValues(alpha: 0.35),
                                Colors.white.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // İç çember
                      Container(
                        width: 178,
                        height: 178,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.14),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "$_count",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 68,
                              fontWeight: FontWeight.w800,
                              height: 1.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Dokun ve Çek",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _altBilgi(int hedef, double oran) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFF3A2430).withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _istatistik(
            ikon: Icons.track_changes_rounded,
            deger: '$hedef',
            etiket: 'Hedef',
          ),
          _istatistik(
            ikon: Icons.bolt_rounded,
            deger: '$_totalCount',
            etiket: 'Toplam Zikir',
          ),
          _istatistik(
            ikon: Icons.percent_rounded,
            deger: '${(oran * 100).round()}%',
            etiket: 'İlerleme',
          ),
        ],
      ),
    );
  }

  Widget _istatistik({
    required IconData ikon,
    required String deger,
    required String etiket,
  }) {
    return Column(
      children: [
        UcdIkon(ikon: ikon, renk: Colors.pinkAccent, boyut: 20),
        const SizedBox(height: 6),
        Text(
          deger,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          etiket,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

/// Tespihin çevresine dizili boncukları çizer. İlerleme oranına göre boncuklar
/// parlar; dolan her boncuk yükseltilmiş (3D) görünür.
class _BoncukHalkasiPainter extends CustomPainter {
  final double oran;

  _BoncukHalkasiPainter({required this.oran});

  @override
  void paint(Canvas canvas, Size size) {
    final merkez = size.center(Offset.zero);
    final yaricap = size.shortestSide / 2 - 14;
    const boncukSayisi = 33;
    final bosBoncuk = Paint()
      ..color = Colors.white.withValues(alpha: 0.10)
      ..style = PaintingStyle.fill;
    final doluBoncuk = Paint()
      ..color = const Color(0xFFFF80AB)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    final doluParil = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;

    for (var i = 0; i < boncukSayisi; i++) {
      final aci = (i / boncukSayisi) * 2 * math.pi - math.pi / 2;
      final x = merkez.dx + math.cos(aci) * yaricap;
      final y = merkez.dy + math.sin(aci) * yaricap;
      final dolu = i / boncukSayisi <= oran;
      if (dolu) {
        canvas.drawCircle(Offset(x, y), 5.5, doluBoncuk);
        canvas.drawCircle(Offset(x - 1.2, y - 1.2), 1.8, doluParil);
      } else {
        canvas.drawCircle(Offset(x, y), 5.0, bosBoncuk);
      }
    }
  }

  @override
  bool shouldRepaint(_BoncukHalkasiPainter oldDelegate) =>
      oldDelegate.oran != oran;
}
