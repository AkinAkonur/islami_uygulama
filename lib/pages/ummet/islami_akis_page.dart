import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';
import '../../widgets/kart_sekilleri.dart';

class IslamiAkisPage extends StatelessWidget {
  const IslamiAkisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('ia.title'),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _bugunKarti(l),
          const SizedBox(height: 20),
          Text(
            l.t('ia.discover'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          for (final m in gununMesajlari) ...[
            _mesajKarti(m),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bugunKarti(AppLocalizations l) {
    final i = UmmetStore.gununMesajIndexi();
    final mesaj = gununMesajlari[i % gununMesajlari.length];
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: Icons.wb_sunny_rounded, renk: Renkler.vurgu, boyut: 20),
              const SizedBox(width: 8),
              Text(
                l.t('ia.todayMessage'),
                style: TextStyle(
                  color: Renkler.acikVurgu,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '"${mesaj['metin']}"',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Renkler.vurgu.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${mesaj['tip']}',
                  style: TextStyle(
                    color: Renkler.acikVurgu,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${mesaj['kaynak']}',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mesajKarti(Map<String, String> m) {
    final renk = m['tip'] == 'Ayet'
        ? Renkler.vurgu
        : m['tip'] == 'Hadis'
            ? Renkler.vurgu
            : Renkler.acikVurgu;
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UcdIkon(ikon: Icons.format_quote_rounded, renk: renk, boyut: 20),
                const SizedBox(width: 8),
                Text(
                  '${m['tip']}',
                  style: TextStyle(
                    color: renk,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '"${m['metin']}"',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '— ${m['kaynak']}',
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
