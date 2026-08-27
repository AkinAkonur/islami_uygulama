import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../../widgets/kart_sekilleri.dart';
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
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('hu.title')),
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
            _bolumBasligi(l.t('hu.ibadetSection')),
            _modulKarti(
              context,
              icon: Icons.checklist_rtl_rounded,
              renk: Colors.tealAccent,
              baslik: l.t('hu.ibadetTitle'),
              altBaslik: l.t('hu.ibadetSub'),
              sayfa: const IbadetModuPage(),
            ),
            _modulKarti(
              context,
              icon: Icons.rotate_90_degrees_cw_rounded,
              renk: Colors.amberAccent,
              baslik: l.t('hu.tavafTitle'),
              altBaslik: l.t('hu.tavafSub'),
              sayfa: SayacSayfasi(tur: SayacTuru.tavaf),
            ),
            _modulKarti(
              context,
              icon: Icons.swap_horiz_rounded,
              renk: Colors.lightGreenAccent,
              baslik: l.t('hu.sayTitle'),
              altBaslik: l.t('hu.saySub'),
              sayfa: SayacSayfasi(tur: SayacTuru.say),
            ),
            _modulKarti(
              context,
              icon: Icons.account_tree_rounded,
              renk: Colors.orangeAccent,
              baslik: l.t('hu.demTitle'),
              altBaslik: l.t('hu.demSub'),
              sayfa: const FikihKararAgaciPage(),
            ),
            const SizedBox(height: 20),
            _bolumBasligi(l.t('hu.ziyaretSection')),
            _modulKarti(
              context,
              icon: Icons.explore_rounded,
              renk: Colors.blueAccent,
              baslik: l.t('hu.ziyaretTitle'),
              altBaslik: l.t('hu.ziyaretSub'),
              sayfa: const ZiyaretRehberiPage(),
            ),
            const SizedBox(height: 20),
            _bolumBasligi(l.t('hu.sahaSection')),
            _modulKarti(
              context,
              icon: Icons.gps_fixed_rounded,
              renk: Colors.purpleAccent,
              baslik: l.t('hu.mikatTitle'),
              altBaslik: l.t('hu.mikatSub'),
              sayfa: const MikatUyariPage(),
            ),
            _modulKarti(
              context,
              icon: Icons.record_voice_over_rounded,
              renk: Colors.pinkAccent,
              baslik: l.t('hu.acilTitle'),
              altBaslik: l.t('hu.acilSub'),
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
          child: UcdIkon(ikon: icon, renk: renk, boyut: 24),
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
        trailing: const UcdIkon(ikon: Icons.chevron_right_rounded, renk: Colors.white38),
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
    final l = AppLocalizations.of(context);
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
      child: Row(
        children: [
          const UcdIkon(ikon: Icons.mosque_rounded, renk: Colors.white, boyut: 36),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('hu.bannerTitle'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.t('hu.bannerIntro'),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
