// lib/pages/soru_cevap/gunun_sorusu_karti.dart
// Ana ekranda görünen "Günün Sorusu" kartı: soruyu gösterir, dokununca
// Soru-Cevap modülünün Günün Sorusu sekmesini açar.

import 'package:flutter/material.dart';

import '../../services/renkler.dart';
import 'soru_cevap_page.dart';
import 'soru_cevap_verileri.dart';

class GununSorusuKarti extends StatelessWidget {
  const GununSorusuKarti({super.key});

  @override
  Widget build(BuildContext context) {
    final soru = SoruCevapVerileri.gununSorusu();
    final kategori = SoruCevapVerileri.kategoriler
        .firstWhere(
          (k) => k.id == soru.kategori,
          orElse: () => SoruCevapVerileri.kategoriler.first,
        )
        .emoji;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const SoruCevapPage(baslangicSekme: 2),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Renkler.bannerUst, Renkler.bannerAlt],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Renkler.cerceve),
          boxShadow: [
            BoxShadow(
              color: Renkler.vurgu.withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text('📅', style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '$kategori Günün Sorusu',
                        style: TextStyle(
                          color: Renkler.vurgu,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.white38,
                        size: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    soru.soru,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Cevabı ve ilgili ayeti görmek için dokunun',
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
