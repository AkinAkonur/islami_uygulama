import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class BagisPage extends StatefulWidget {
  const BagisPage({super.key});

  @override
  State<BagisPage> createState() => _BagisPageState();
}

class _BagisPageState extends State<BagisPage> {
  List<Map<String, dynamic>> _projeleriGetir(AppLocalizations l) {
    return [
      {"title": l.t('bg.water'), "target": 50000, "collected": 38000, "desc": l.t('bg.waterDesc')},
      {"title": l.t('bg.orphan'), "target": 12000, "collected": 9500, "desc": l.t('bg.orphanDesc')},
      {"title": l.t('bg.quran'), "target": 5000, "collected": 4200, "desc": l.t('bg.quranDesc')},
      {"title": l.t('bg.food'), "target": 25000, "collected": 21000, "desc": l.t('bg.foodDesc')},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final projeler = _projeleriGetir(l);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('bg.title')),
        backgroundColor: const Color(0xFF2C241E),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: projeler.length,
        itemBuilder: (context, index) {
          final p = projeler[index];
          double progress = (p["collected"] as int) / (p["target"] as int);
          return Card(
            color: Renkler.kart,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p["title"],
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const UcdIkon(ikon: Icons.volunteer_activism_rounded, renk: Colors.amber, boyut: 24),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    p["desc"],
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.black26,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${l.t('bg.collected')}: ${p["collected"]} TL",
                        style: const TextStyle(color: Colors.white60, fontSize: 11),
                      ),
                      Text(
                        "${l.t('bg.target')}: ${p["target"]} TL",
                        style: const TextStyle(color: Colors.amberAccent, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l.t('bg.redirectSnackbar'))),
                        );
                      },
                      child: Text(l.t('bg.donateButton'), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
