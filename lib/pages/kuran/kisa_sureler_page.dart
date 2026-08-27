import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/kuran_verileri.dart';
import '../../widgets/kart_sekilleri.dart';
import 'sure_detay_page.dart';

class KisaSurelerPage extends StatelessWidget {
  final int tab;
  const KisaSurelerPage({super.key, this.tab = 0});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      initialIndex: tab,
      child: Scaffold(
        backgroundColor: Renkler.zemin,
        appBar: AppBar(
          title: Text(
            l.t('ks.title'),
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Renkler.yuzey,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Renkler.vurgu,
            labelColor: Renkler.vurgu,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: l.t('ks.tabShort')),
              Tab(text: l.t('ks.tabSpecial')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _kisaSurelerListesi(context, l),
            _ozelGunListesi(context, l),
          ],
        ),
      ),
    );
  }

  Widget _kisaSurelerListesi(BuildContext context, AppLocalizations l) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Renkler.seciliYuzey,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.t('ks.readTitle'),
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                l.t('ks.readDesc'),
                style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (final k in kisaSureler) _sureKarti(context, k, l),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _ozelGunListesi(BuildContext context, AppLocalizations l) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Renkler.seciliYuzey,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.t('ks.specialTitle'),
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                l.t('ks.specialDesc'),
                style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (final k in ozelGunSureleri) _sureKarti(context, k, l),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _sureKarti(BuildContext context, Map<String, Object> k, AppLocalizations l) {
    final no = k['no'] as int;
    final ad = k['ad'] as String;
    final not = k['not'] as String;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: Renkler.yuzey,
              shape: BoxShape.circle,
              border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
            ),
            alignment: Alignment.center,
            child: Text(
              '$no',
              style: TextStyle(color: Renkler.vurgu, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${sureAdiTurkce(no)} ($ad)',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 3),
                Text(
                  not,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l.t('ks.openSurah'),
            icon: UcdIkon(ikon: Icons.play_circle_outline_rounded, renk: Renkler.vurgu, boyut: 26),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SureDetayPage(sureNo: no)),
            ),
          ),
        ],
      ),
    );
  }
}
