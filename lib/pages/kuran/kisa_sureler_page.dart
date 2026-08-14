import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/kuran_verileri.dart';
import 'sure_detay_page.dart';

class KisaSurelerPage extends StatelessWidget {
  final int tab;
  const KisaSurelerPage({super.key, this.tab = 0});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: tab,
      child: Scaffold(
        backgroundColor: Renkler.zemin,
        appBar: AppBar(
          title: Text(
            "Namazda Okunan Sureler",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Renkler.yuzey,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Renkler.vurgu,
            labelColor: Renkler.vurgu,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: "Amme Cüzü / Kısa"),
              Tab(text: "Özel Gün Sureleri"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _kisaSurelerListesi(context),
            _ozelGunListesi(context),
          ],
        ),
      ),
    );
  }

  Widget _kisaSurelerListesi(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Renkler.seciliYuzey,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Namazda Okunanlar",
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                "Fâtiha ve zamm-ı sureler. Namazda Fâtiha'dan sonra okunan kısa surelerin ezberine ve anlamına buradan ulaşın.",
                style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        for (final k in kisaSureler) _sureKarti(context, k),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _ozelGunListesi(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Renkler.seciliYuzey,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Özel Zamanların Sureleri",
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                "Cuma, kandil geceleri, Arefe, bayram ve gece okunması tavsiye edilen sureler. Kehf cumada, Mülk her gece, İhlâs arefede öne çıkar.",
                style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        for (final k in ozelGunSureleri) _sureKarti(context, k),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _sureKarti(BuildContext context, Map<String, Object> k) {
    final no = k['no'] as int;
    final ad = k['ad'] as String;
    final not = k['not'] as String;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${sureAdiTurkce(no)} ($ad)',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 3),
                Text(
                  not,
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: "Sureyi Aç",
            icon: Icon(Icons.play_circle_outline, color: Renkler.vurgu, size: 26),
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
