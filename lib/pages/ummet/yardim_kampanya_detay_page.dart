import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class YardimKampanyaDetayPage extends StatefulWidget {
  const YardimKampanyaDetayPage({super.key, required this.kampanya});

  final YardimKampanyasi kampanya;

  @override
  State<YardimKampanyaDetayPage> createState() =>
      _YardimKampanyaDetayPageState();
}

class _YardimKampanyaDetayPageState extends State<YardimKampanyaDetayPage> {
  int _pay = 0;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final pay = await UmmetStore.kampanyaPayi(widget.kampanya.id);
    if (!mounted) return;
    setState(() => _pay = pay);
  }

  Future<void> _destekle() async {
    await UmmetStore.kampanyaDestekle(widget.kampanya.id);
    if (!mounted) return;
    setState(() => _pay++);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)
              .t('jk.niyetSave')
              .replaceFirst('{name}', widget.kampanya.ad),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final k = widget.kampanya;
    final toplam = k.katilan + _pay;

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          '${k.ikon} ${k.ad}',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Renkler.bannerUst, Renkler.bannerAlt],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Renkler.yuzey.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(k.ikon, style: const TextStyle(fontSize: 26)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            k.ad,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            k.kurum,
                            style:
                                TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.groups,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      l.t('jk.joinedCount').replaceFirst('{count}', binlikSayi(toplam)),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l.t('jk.about'),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            k.aciklama,
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
          ),
          if (k.detay != null) ...[
            const SizedBox(height: 14),
            Text(
              k.detay!,
              style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
            ),
          ],
          if (k.delil != null) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Renkler.cerceve),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"${k.delil}"',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                  if (k.kaynak != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      k.kaynak!,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Renkler.vurgu,
              foregroundColor: Renkler.zemin,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _destekle,
            icon: const Icon(Icons.favorite),
            label: Text(
              l.t('jk.intention'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l.t('jk.donationNote'),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white38, fontSize: 11, height: 1.4),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}