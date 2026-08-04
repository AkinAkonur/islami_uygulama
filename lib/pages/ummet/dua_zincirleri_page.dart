import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class DuaZincirleriPage extends StatefulWidget {
  const DuaZincirleriPage({super.key});

  @override
  State<DuaZincirleriPage> createState() => _DuaZincirleriPageState();
}

class _DuaZincirleriPageState extends State<DuaZincirleriPage> {
  final Map<String, int> _paylar = {};
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final paylar = <String, int>{};
    for (final z in duaZincirleriSeed) {
      paylar[z.id] = await UmmetStore.zincirPayi(z.id);
    }
    if (!mounted) return;
    setState(() {
      _paylar.addAll(paylar);
      _yukleniyor = false;
    });
  }

  Future<void> _katil(DuaZinciri zincir, int adet) async {
    await UmmetStore.zincirKatil(zincir.id, adet);
    if (!mounted) return;
    setState(() {
      _paylar[zincir.id] = (_paylar[zincir.id] ?? 0) + adet;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$adet adet üstlendin: ${zincir.ad} 🤲',
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
          'Dua Zincirleri',
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
                          Icon(Icons.link, color: Renkler.vurgu, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Zincire Katıl, Sevaba Ortak Ol',
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
                        'Küresel bir hedef için herkes üzerine düşeni yapar: 1, 5 ya da 10 adet. Tamamlanan zincirler ümmet olarak büyük bir sevap hanesine dönüşür.',
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
                for (final zincir in duaZincirleriSeed) ...[
                  _zincirKarti(zincir),
                  SizedBox(height: 12),
                ],
                SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _zincirKarti(DuaZinciri zincir) {
    final pay = _paylar[zincir.id] ?? 0;
    final mevcut = zincir.taban + pay;
    final oran = (mevcut / zincir.hedef).clamp(0.0, 1.0);

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
                    zincir.ad,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Renkler.bannerUst,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${binlikSayi(mevcut)} / ${binlikSayi(zincir.hedef)}',
                    style: TextStyle(
                      color: Renkler.acikVurgu,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              zincir.detay,
              style: TextStyle(color: Colors.white54, fontSize: 12),
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '"${zincir.duaMetni}"',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
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
                    'Senin payın: ${binlikSayi(pay)}',
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                ] else
                  Spacer(),
                for (final adet in [1, 5, 10]) ...[
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Renkler.vurgu,
                      side: BorderSide(color: Renkler.cerceve2),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: Size(0, 36),
                    ),
                    onPressed: () => _katil(zincir, adet),
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
