import 'package:flutter/material.dart';

import '../../services/renkler.dart';
import 'acil_durum_sozlugu_page.dart';
import 'fikih_karar_agaci_page.dart';
import 'ibadet_modu_page.dart';
import 'mikat_uyari_page.dart';
import 'sayac_sayfasi.dart';
import 'ziyaret_rehberi_page.dart';
import 'hac_umre_verileri.dart';

// ===========================================================================
// HAC & UMRE REHBERİ - ANA MENÜ
// Kutsal topraklarda A'dan Z'ye başucu rehberi. Tüm modüller buradan açılır.
// ===========================================================================

class HacUmreRehberPage extends StatelessWidget {
  const HacUmreRehberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Hac & Umre Rehberi'),
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderBanner(),
            const SizedBox(height: 20),
            _bolumBasligi('🕋 İbadet Rehberi'),
            _modulKarti(
              context,
              icon: Icons.checklist_rtl,
              renk: Colors.tealAccent,
              baslik: 'İbadet Modu (Adım Adım)',
              altBaslik:
                  'Umre, Hac-ı İfrâd, Kırân ve Temettu için kontrol listesi',
              sayfa: const IbadetModuPage(),
            ),
            _modulKarti(
              context,
              icon: Icons.rotate_90_degrees_cw,
              renk: Colors.amberAccent,
              baslik: 'Tavaf Sayacı',
              altBaslik: 'Ekrana dokunarak 7 şavt takibi + şavt duaları',
              sayfa: SayacSayfasi(tur: SayacTuru.tavaf),
            ),
            _modulKarti(
              context,
              icon: Icons.swap_horiz,
              renk: Colors.lightGreenAccent,
              baslik: 'Sa\'y Sayacı',
              altBaslik: 'Safa-Merve arası 7 gidiş-geliş sayacı',
              sayfa: SayacSayfasi(tur: SayacTuru.say),
            ),
            _modulKarti(
              context,
              icon: Icons.account_tree_outlined,
              renk: Colors.orangeAccent,
              baslik: 'Dem & Fidye Karar Ağacı',
              altBaslik: 'İhram ihlalinde mezhebe göre ceza rehberi',
              sayfa: const FikihKararAgaciPage(),
            ),
            const SizedBox(height: 20),
            _bolumBasligi('🗺️ Ziyaret Rehberi'),
            _modulKarti(
              context,
              icon: Icons.explore_outlined,
              renk: Colors.blueAccent,
              baslik: 'Mekke & Medine Ziyaret Rehberi',
              altBaslik: 'Hira, Sevr, Ravza, Uhud ve daha fazlası',
              sayfa: const ZiyaretRehberiPage(),
            ),
            const SizedBox(height: 20),
            _bolumBasligi('📡 Saha Araçları'),
            _modulKarti(
              context,
              icon: Icons.gps_fixed,
              renk: Colors.purpleAccent,
              baslik: 'Mikat Uyarı Motoru',
              altBaslik: 'GPS ile mikat sınırına yaklaşma bildirimi',
              sayfa: const MikatUyariPage(),
            ),
            _modulKarti(
              context,
              icon: Icons.record_voice_over_outlined,
              renk: Colors.pinkAccent,
              baslik: 'Acil Durum Sözlüğü',
              altBaslik: '30 temel Arapça cümle, sesli okuma ile',
              sayfa: const AcilDurumSozluguPage(),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _bolumBasligi(String baslik) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        baslik,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _modulKarti(
    BuildContext context, {
    required IconData icon,
    required Color renk,
    required String baslik,
    required String altBaslik,
    required Widget sayfa,
  }) {
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: renk.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: renk, size: 24),
        ),
        title: Text(
          baslik,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          altBaslik,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => sayfa),
          );
        },
      ),
    );
  }
}

class _HeaderBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.mosque_outlined, color: Colors.white, size: 36),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kutsal Topraklarda Başucu Rehberi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'İbadet akışı, sayaçlar, ziyaret mekânları ve saha araçları '
                  'tek yerden. Hepsi çevrimdışı çalışır.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
