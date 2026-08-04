import 'package:flutter/material.dart';
import '../services/renkler.dart';
import 'kible_pusula_page.dart';

class KonumPage extends StatelessWidget {
  const KonumPage({super.key});

  static const List<Map<String, String>> _vakitler = [
    {'ad': 'İmsak', 'saat': '04:12'},
    {'ad': 'Güneş', 'saat': '05:48'},
    {'ad': 'Öğle', 'saat': '13:05'},
    {'ad': 'İkindi', 'saat': '16:45'},
    {'ad': 'Akşam', 'saat': '20:17'},
    {'ad': 'Yatsı', 'saat': '21:50'},
  ];

  static const List<Map<String, String>> _camiler = [
    {'ad': 'Süleymaniye Camii', 'mesafe': '2,4 km', 'vakit': 'İmsak 04:12'},
    {'ad': 'Sultanahmet Camii', 'mesafe': '3,1 km', 'vakit': 'İmsak 04:12'},
    {'ad': 'Eyüp Sultan Camii', 'mesafe': '4,8 km', 'vakit': 'İmsak 04:12'},
    {'ad': 'Fatih Camii', 'mesafe': '3,6 km', 'vakit': 'İmsak 04:12'},
    {'ad': 'Beyazıt Camii', 'mesafe': '2,9 km', 'vakit': 'İmsak 04:12'},
    {'ad': 'Mimar Sinan Camii', 'mesafe': '5,2 km', 'vakit': 'İmsak 04:12'},
  ];

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
                    _kibleKarti(context),
                    const SizedBox(height: 16),
                    _vakitKarti(),
                    const SizedBox(height: 16),
                    _camiKarti(),
                    const SizedBox(height: 16),
                    _uyariKarti(),
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
            'Cami & Konum',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.location_on_outlined, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _kibleKarti(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KiblePusulaPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Renkler.vurgu, Renkler.vurgu.withValues(alpha: 0.55)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(Icons.explore_outlined, color: Colors.white, size: 34),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kıble yönün: 154° Güneydoğu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Pusulayı aç ve Kâbe\'ye yönel',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  Widget _vakitKarti() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule_outlined, color: Renkler.vurgu, size: 20),
              SizedBox(width: 8),
              Text(
                'Bugünün Namaz Vakitleri',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._vakitler.map(
            (v) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Text(
                    v['ad']!,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    v['saat']!,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _camiKarti() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mosque_outlined, color: Renkler.vurgu, size: 20),
              SizedBox(width: 8),
              Text(
                'Yakınındaki Camiler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ..._camiler.map(
            (c) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.mosque_outlined,
                        color: Renkler.vurgu, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c['ad']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          c['vakit']!,
                          style: TextStyle(
                              color: Colors.white54, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      c['mesafe']!,
                      style: TextStyle(
                        color: Renkler.vurgu,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uyariKarti() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Renkler.vurgu, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Vakitler ve cami listesi İstanbul için örnek verilerdir. Konum izni ile kendi bölgene göre güncellenir.',
              style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
