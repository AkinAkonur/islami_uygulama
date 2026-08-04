import 'package:flutter/material.dart';
import '../services/renkler.dart';

class WidgetRehberiPage extends StatelessWidget {
  const WidgetRehberiPage({super.key});

  static const List<Map<String, String>> _adimlar = [
    {
      'no': '1',
      'baslik': 'Ana ekranı basılı tut',
      'aciklama': 'Telefonunda ana ekranın boş bir alanına basılı tut.',
    },
    {
      'no': '2',
      'baslik': 'Widget\'lar\'a dokun',
      'aciklama': 'Açılan menüden "Widget\'lar" seçeneğini seç.',
    },
    {
      'no': '3',
      'baslik': 'Huzur & Manevi Yolculuk\'u bul',
      'aciklama': 'Uygulama listesinden "Huzur & Manevi Yolculuk" widget\'ını bul.',
    },
    {
      'no': '4',
      'baslik': 'Ana ekrana ekle',
      'aciklama': 'Widget\'ı sürükleyip ana ekrana bırak. Boyutunu istediğin gibi ayarla.',
    },
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
                    _onizlemeKarti(),
                    const SizedBox(height: 16),
                    _adimKarti(),
                    const SizedBox(height: 16),
                    _durumKarti(),
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
            'Widget Rehberi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.widgets_outlined, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _onizlemeKarti() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.vurgu, Renkler.vurgu.withValues(alpha: 0.55)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.schedule_outlined, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'Widget Önizleme',
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
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('🕌', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    const Text(
                      'Sıradaki Vakit',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Öğle 13:05',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '00:42:15',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    const Spacer(),
                    const Text('🌙', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 6),
                    const Text(
                      'İmsak 04:12',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Vakit kartı, kalan süre ve bugünün vakitleri tek bakışta.',
            style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _adimKarti() {
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
              Icon(Icons.touch_app_outlined, color: Renkler.vurgu, size: 20),
              SizedBox(width: 8),
              Text(
                'Kurulum Adımları',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._adimlar.map(
            (a) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Renkler.vurgu,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      a['no']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a['baslik']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          a['aciklama']!,
                          style: TextStyle(
                              color: Colors.white54, fontSize: 12),
                        ),
                      ],
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

  Widget _durumKarti() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.construction_outlined, color: Renkler.vurgu, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Widget desteği şu anda önizleme aşamasında. Yakında uygulama güncellemesiyle birlikte ana ekranına ekleyebileceksin.',
              style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
