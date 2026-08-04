import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

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
    await UmmetStore.zikirKatil(kampanya.id, adet);
    if (!mounted) return;
    setState(() {
      _paylar[kampanya.id] = (_paylar[kampanya.id] ?? 0) + adet;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$adet ${kampanya.birim} eklendi. Milyonlara ortak oldun! 📿',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Milyonluk Zikir Kampanyaları',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: _yukleniyor
          ? Center(
              child: CircularProgressIndicator(color: Renkler.vurgu),
            )
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                Container(
                  padding: EdgeInsets.all(14),
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
                          Icon(Icons.auto_awesome,
                              color: Renkler.vurgu, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Milyonluk Ortak Zikir',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tüm ümmetin katıldığı ortak salavat, tevhid ve istiğfar sayaçları. Her zikrin, binlerce kardeşin zikriyle birleşir. Birlikten bereket doğar.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                for (final kampanya in zikirKampanyalariSeed) ...[
                  _kampanyaKarti(kampanya),
                  SizedBox(height: 12),
                ],
                SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _kampanyaKarti(ZikirKampanyasi kampanya) {
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
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    kampanya.ad,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                kampanya.arapca,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 12),
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
            SizedBox(height: 12),
            Row(
              children: [
                if (pay > 0) ...[
                  Icon(Icons.check_circle,
                      color: Renkler.vurgu, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'Benim katkım: ${binlikSayi(pay)}',
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                ] else
                  Spacer(),
                for (final adet in [1, 33, 100]) ...[
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Renkler.vurgu,
                      side: BorderSide(color: Renkler.cerceve2),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: Size(0, 36),
                    ),
                    onPressed: () => _katil(kampanya, adet),
                    child: Text('+$adet'),
                  ),
                  SizedBox(width: 8),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
