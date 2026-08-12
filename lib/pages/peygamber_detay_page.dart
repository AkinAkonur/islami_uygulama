// lib/pages/peygamber_detay_page.dart

import 'package:flutter/material.dart';
import '../models/kissalar_model.dart';
import '../services/renkler.dart';
import '../widgets/interaktif_metin_renderer.dart';

class PeygamberDetayPage extends StatelessWidget {
  final PeygamberModel peygamber;
  final IcerikModu mod;

  const PeygamberDetayPage({
    super.key,
    required this.peygamber,
    required this.mod,
  });

  @override
  Widget build(BuildContext context) {
    final metin = mod == IcerikModu.kesif
        ? peygamber.kesifIcerigi['tr'] ?? ''
        : peygamber.derinIcerigi['tr'] ?? '';

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.yuzey,
        title: Text(peygamber.isim.getGosterimIsmi('tr')),
        actions: [
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.headset),
            onPressed: () {
              // Audiobook Ses Oynatıcı Entegrasyonu
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Harita ve Günümüz Konumu Bilgisi
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
              ),
              child: Row(
                children: [
                  Icon(Icons.map_outlined, color: Renkler.vurgu),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tarihi Bölge & Günümüz Haritası',
                          style: TextStyle(color: Colors.white54, fontSize: 11),
                        ),
                        Text(
                          '${peygamber.cografiHarita.first.konumAdi} (${peygamber.cografiHarita.first.bugunkuKarsiligi})',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // İnteraktif Bağlantılı Metin Motoru
            InteraktifMetinRenderer(
              hamMetin: metin,
              OnLinkTiklandi: (tur, id) {
                // Sahabe, Ayet veya Tefsir sayfasına yönlendirme
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Yönlendiriliyor: $tur -> ID: $id')),
                );
              },
              OnTerimTiklandi: (terim, aciklama) {
                // Terim Sözlüğü Tooltip BottomSheet
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Renkler.yuzey,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          terim,
                          style: TextStyle(
                            color: Renkler.vurgu,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          aciklama,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // Akademik Derinlik: Farklı Görüşler / Rivayetler Accordion
            if (peygamber.farkliGorusler.isNotEmpty) ...[
              const Text(
                'Farklı Görüşler ve Rivayetler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ...peygamber.farkliGorusler.map(
                (gorus) => ExpansionTile(
                  title: Text(
                    gorus['baslik']!,
                    style: const TextStyle(
                      color: Colors.amberAccent,
                      fontSize: 14,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        gorus['icerik']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),

            // Sahih Kaynakça Gösterimi
            const Text(
              'Kaynaklar:',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            ...peygamber.kaynaklar.map(
              (k) => Text(
                '• ${k.eserAdi} - ${k.yazar} (${k.ciltSayfa})',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
