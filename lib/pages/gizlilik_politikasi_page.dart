import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';

/// Detaylı Gizlilik Politikası sayfası. Ayarlar menüsünden açılır.
class GizlilikPolitikasiSayfasi extends StatelessWidget {
  const GizlilikPolitikasiSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final bolumler = [
      (ikon: Icons.storage_outlined, anahtar: '1'),
      (ikon: Icons.location_on_outlined, anahtar: '2'),
      (ikon: Icons.notifications_active_outlined, anahtar: '3'),
      (ikon: Icons.share_outlined, anahtar: '4'),
      (ikon: Icons.delete_outline, anahtar: '5'),
      (ikon: Icons.child_care_outlined, anahtar: '6'),
      (ikon: Icons.update_outlined, anahtar: '7'),
    ];

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.kart,
        title: Text(
          l.t('d.privacy'),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Renkler.cerceve, width: 1),
            ),
            child: Text(
              l.t('pp.intro'),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.6,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          const SizedBox(height: 16),
          for (final b in bolumler) _bolumKarti(context, b.ikon, b.anahtar),
          const SizedBox(height: 12),
          Center(
            child: Text(
              l.t('pp.last'),
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _bolumKarti(BuildContext context, IconData ikon, String no) {
    final l = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.yuzey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve2, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Renkler.seciliYuzey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(ikon, color: Renkler.vurgu, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l.t('pp.s${no}t'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l.t('pp.s${no}b'),
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
