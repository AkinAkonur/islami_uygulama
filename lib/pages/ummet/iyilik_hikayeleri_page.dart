import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';
import '../../widgets/kart_sekilleri.dart';

class IyilikHikayeleriPage extends StatelessWidget {
  const IyilikHikayeleriPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('ih.title'),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Renkler.bannerUst, Renkler.bannerAlt],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                UcdIkon(ikon: Icons.auto_stories_rounded, renk: Renkler.vurgu, boyut: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l.t('ih.intro'),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final hikaye in iyilikHikayeleri) ...[
            _hikayeKarti(hikaye, l),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _hikayeKarti(Map<String, String> hikaye, AppLocalizations l) {
    final yeniMusluman = hikaye['tema'] == 'Yeni Müslüman';
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: yeniMusluman
              ? Renkler.vurgu.withValues(alpha: 0.4)
              : Renkler.cerceve,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: yeniMusluman
                        ? Renkler.bannerUst
                        : Renkler.cerceve2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    hikaye['tema']!,
                    style: TextStyle(
                      color: yeniMusluman
                          ? Renkler.acikVurgu
                          : Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              hikaye['baslik']!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hikaye['hikaye']!,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const UcdIkon(ikon: Icons.favorite_rounded, renk: Color(0xFFEF5350), boyut: 14),
                const SizedBox(width: 6),
                Text(
                  l.t('ih.sharedGood'),
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
                const Spacer(),
                UcdIkon(
                  ikon: Icons.auto_awesome_rounded,
                  renk: Renkler.vurgu.withValues(alpha: 0.5),
                  boyut: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
