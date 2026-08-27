import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';
import '../../widgets/kart_sekilleri.dart';

class ZikirKampanyalariPage extends StatefulWidget {
  const ZikirKampanyalariPage({super.key});

  @override
  State<ZikirKampanyalariPage> createState() => _ZikirKampanyalariPageState();
}

class _ZikirKampanyalariPageState extends State<ZikirKampanyalariPage> {
  final Map<String, int> _paylar = {};
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final paylar = <String, int>{};
    for (final z in zikirKampanyalariSeed) {
      paylar[z.id] = await UmmetStore.zikirPayi(z.id);
    }
    if (!mounted) return;
    setState(() {
      _paylar.addAll(paylar);
      _yukleniyor = false;
    });
  }

  Future<void> _katil(ZikirKampanyasi kampanya, int adet) async {
    final l = AppLocalizations.of(context);
    await UmmetStore.zikirKatil(kampanya.id, adet);
    if (!mounted) return;
    setState(() {
      _paylar[kampanya.id] = (_paylar[kampanya.id] ?? 0) + adet;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l.t('zk.joined')
              .replaceFirst('{count}', '$adet')
              .replaceFirst('{unit}', kampanya.birim),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('zk.title'),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: _yukleniyor
          ? Center(
              child: CircularProgressIndicator(color: Renkler.vurgu),
            )
          : ListView(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          UcdIkon(ikon: Icons.auto_awesome_rounded,
                              renk: Renkler.vurgu, boyut: 20),
                          const SizedBox(width: 8),
                          Text(
                            l.t('zk.jointTitle'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l.t('zk.intro'),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                for (final kampanya in zikirKampanyalariSeed) ...[
                  _kampanyaKarti(kampanya, l),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _kampanyaKarti(ZikirKampanyasi kampanya, AppLocalizations l) {
    final pay = _paylar[kampanya.id] ?? 0;
    final mevcut = kampanya.taban + pay;
    final oran = (mevcut / kampanya.hedef).clamp(0.0, 1.0);

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
                Expanded(
                  child: Text(
                    kampanya.ad,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Renkler.bannerUst,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${binlikSayi(mevcut)} / ${binlikSayi(kampanya.hedef)}',
                    style: TextStyle(
                      color: Renkler.acikVurgu,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                kampanya.arapca,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: oran,
                minHeight: 8,
                backgroundColor: Renkler.yuzey,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Renkler.vurgu),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (pay > 0) ...[
                  UcdIkon(ikon: Icons.check_circle_rounded,
                      renk: Renkler.vurgu, boyut: 16),
                  const SizedBox(width: 6),
                  Text(
                    l.t('zk.myShare').replaceFirst('{count}', binlikSayi(pay)),
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ] else
                  const Spacer(),
                for (final adet in [1, 33, 100]) ...[
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Renkler.vurgu,
                      side: BorderSide(color: Renkler.cerceve2),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: const Size(0, 36),
                    ),
                    onPressed: () => _katil(kampanya, adet),
                    child: Text('+$adet'),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
