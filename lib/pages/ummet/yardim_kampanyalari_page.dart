import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class YardimKampanyalariPage extends StatefulWidget {
  const YardimKampanyalariPage({super.key});

  @override
  State<YardimKampanyalariPage> createState() => _YardimKampanyalariPageState();
}

class _YardimKampanyalariPageState extends State<YardimKampanyalariPage> {
  final Map<String, int> _paylar = {};
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final paylar = <String, int>{};
    for (final k in yardimKampanyalari) {
      paylar[k.id] = await UmmetStore.kampanyaPayi(k.id);
    }
    if (!mounted) return;
    setState(() {
      _paylar.addAll(paylar);
      _yukleniyor = false;
    });
  }

  Future<void> _destekle(YardimKampanyasi kampanya) async {
    await UmmetStore.kampanyaDestekle(kampanya.id);
    if (!mounted) return;
    setState(() {
      _paylar[kampanya.id] = (_paylar[kampanya.id] ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Destek niyetin kaydedildi. ${kampanya.ad} için Allah razı olsun. 💚',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Küresel Yardım Kampanyaları',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: _yukleniyor
          ? Center(child: CircularProgressIndicator(color: Renkler.vurgu))
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                _bilgiBanneri(),
                SizedBox(height: 16),
                for (final k in yardimKampanyalari) ...[
                  _kampanyaKarti(k),
                  SizedBox(height: 12),
                ],
                SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _bilgiBanneri() {
    return Container(
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
              Icon(Icons.volunteer_activism, color: Renkler.vurgu, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Zekât, sadaka ve hayrını ulaştır',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Güvenilir kurumların su kuyusu, gıda, yetim sponsorluğu, kurban ve afet kampanyalarına köprü. Niyetinizi kaydedin, bağışınızı kendi seçtiğiniz kuruma ulaştırın.',
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _kampanyaKarti(YardimKampanyasi k) {
    final pay = _paylar[k.id] ?? 0;
    final toplam = k.katilan + pay;

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
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Renkler.yuzey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(k.ikon, style: TextStyle(fontSize: 22)),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        k.ad,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        k.kurum,
                        style: TextStyle(color: Colors.white54, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              k.aciklama,
              style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
            ),
            if (k.delil != null) ...[
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Renkler.yuzey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '"${k.delil}"',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                    height: 1.4,
                  ),
                ),
              ),
            ],
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.groups, color: Renkler.vurgu, size: 16),
                SizedBox(width: 6),
                Text(
                  '${binlikSayi(toplam)} kardeş bu hayra ortak oldu',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                Spacer(),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Renkler.vurgu,
                    foregroundColor: Renkler.zemin,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    textStyle: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _destekle(k),
                  icon: Icon(Icons.favorite, size: 16),
                  label: Text('Niyet Ettim'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
