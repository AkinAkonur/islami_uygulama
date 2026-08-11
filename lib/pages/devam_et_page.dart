import 'package:flutter/material.dart';
import '../services/manevi_store.dart';
import '../services/renkler.dart';
import '../pages/tesbih_page.dart';
import 'kuran/hatim_takibi_page.dart';
import 'kuran/sure_detay_page.dart';

class DevamEtPage extends StatefulWidget {
  const DevamEtPage({super.key});

  @override
  State<DevamEtPage> createState() => _DevamEtPageState();
}

class _DevamEtPageState extends State<DevamEtPage> {
  String _sonAyet = '';
  KuranKonumu _kuranKonumu = const KuranKonumu(
    sureNo: 2,
    ayetNo: 255,
    sureAdi: 'Bakara',
  );
  int _tesbih = 0;
  Map<String, int> _hatim = {'sayfa': 1, 'sayi': 0, 'bugun': 0, 'seri': 0};

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final kuranKonumu = await ManeviStore.sonKuranKonumu();
    final tesbih = await ManeviStore.tesbihSayisi();
    final hatim = await ManeviStore.hatimDurumu();
    if (mounted) {
      setState(() {
        _sonAyet = kuranKonumu.gosterim;
        _kuranKonumu = kuranKonumu;
        _tesbih = tesbih;
        _hatim = hatim;
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
                    _ayetKarti(),
                    const SizedBox(height: 16),
                    _tesbihKarti(),
                    const SizedBox(height: 16),
                    _hatimKarti(),
                    const SizedBox(height: 16),
                    _ipucuKarti(),
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
            'Devam Et',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.play_circle_outline, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _kartTasi(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _ayetKarti() {
    return _kartTasi(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.menu_book_outlined, color: Renkler.vurgu, size: 20),
              SizedBox(width: 8),
              Text(
                'Kur\'an\'da kaldığın yer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'Son okuduğun ayet: $_sonAyet',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SureDetayPage(
                      sureNo: _kuranKonumu.sureNo,
                      baslangicAyetNo: _kuranKonumu.ayetNo,
                    ),
                  ),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Renkler.vurgu),
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text('Ayet okumaya devam et'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tesbihKarti() {
    return _kartTasi(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.radio_button_checked, color: Renkler.vurgu, size: 20),
              SizedBox(width: 8),
              Text(
                'Tesbih sayacın',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                '$_tesbih',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TesbihPage()),
                  );
                },
                style: FilledButton.styleFrom(backgroundColor: Renkler.vurgu),
                icon: const Icon(Icons.radio_button_checked, size: 16),
                label: const Text('Tesbih\'e Git'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hatimKarti() {
    final toplam = _hatim['sayfa']!;
    return _kartTasi(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_stories_outlined, color: Renkler.vurgu, size: 20),
              SizedBox(width: 8),
              Text(
                'Yarım kalan hatim',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _hatimKutusu('Sayfa', '$toplam'),
              const SizedBox(width: 12),
              _hatimKutusu('Bugün okunan', '${_hatim['bugun']}'),
              const SizedBox(width: 12),
              _hatimKutusu('Seri', '${_hatim['seri']} 🔥'),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const HatimTakibiPage()),
                );
              },
              style: TextButton.styleFrom(foregroundColor: Renkler.vurgu),
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text('Hatim takibine git'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hatimKutusu(String etiket, String deger) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Renkler.seciliYuzey,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              deger,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(etiket, style: TextStyle(color: Colors.white54, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _ipucuKarti() {
    return _kartTasi(
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: Renkler.vurgu, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Her gün bir sayfa okusan, hatimini yaklaşık 3 ayda tamamlarsın. Küçük adımlar en kalıcı olanlardır.',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
