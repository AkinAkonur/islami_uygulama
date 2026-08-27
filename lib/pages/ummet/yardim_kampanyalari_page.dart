import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';
import 'yardim_kampanya_detay_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).t('jk.title'),
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
    final l = AppLocalizations.of(context);
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
                  l.t('jk.bannerTitle'),
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
            l.t('jk.bannerIntro'),
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _kampanyaKarti(YardimKampanyasi k) {
    final l = AppLocalizations.of(context);
    final pay = _paylar[k.id] ?? 0;
    final toplam = k.katilan + pay;

    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _detayaGit(k),
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
                  Icon(Icons.chevron_right, color: Colors.white24),
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
                    l.t('jk.joinedCount').replaceFirst('{count}', binlikSayi(toplam)),
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  Spacer(),
                  Icon(Icons.info_outline, color: Colors.white38, size: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _detayaGit(YardimKampanyasi k) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => YardimKampanyaDetayPage(kampanya: k)),
    );
    if (!mounted) return;
    await _yukle();
  }
}
