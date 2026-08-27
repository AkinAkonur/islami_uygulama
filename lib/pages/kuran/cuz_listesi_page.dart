import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/kuran_verileri.dart';
import '../../widgets/kart_sekilleri.dart';
import 'sure_detay_page.dart';

class CuzListesiPage extends StatelessWidget {
  const CuzListesiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('cl.cuzListTitle'),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 30,
        itemBuilder: (context, index) {
          final cuz = index + 1;
          final baslangic = cuzBaslangic[cuz] ?? '';
          final amme = cuz == 30;
          return Card(
            color: amme ? Renkler.seciliYuzey : Renkler.kart,
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(
                color: amme
                    ? Renkler.vurgu
                    : Renkler.cerceve,
              ),
            ),
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SureDetayPage(cuzNo: cuz),
                ),
              ),
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Renkler.yuzey,
                  shape: BoxShape.circle,
                  border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$cuz',
                  style: TextStyle(
                    color: Renkler.vurgu,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              title: Text(
                l.t('cz.cuz').replaceFirst('{cuz}', '$cuz'),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              ),
              subtitle: Text(
                baslangic + (amme ? l.t('cz.amme') : ''),
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
              trailing: UcdIkon(ikon: Icons.play_circle_outline_rounded, renk: Renkler.vurgu),
            ),
          );
        },
      ),
    );
  }
}
