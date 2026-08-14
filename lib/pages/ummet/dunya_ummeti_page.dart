import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class DunyaUmmetiPage extends StatelessWidget {
  const DunyaUmmetiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Dünya Ümmeti',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _bilgiBanneri(),
          SizedBox(height: 16),
          Text(
            'Müslüman Nüfus Dağılımı',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          for (final u in dunyaMuslumanNufusu) ...[
            _nufusKarti(u),
            SizedBox(height: 8),
          ],
          SizedBox(height: 20),
          Text(
            'Kardeş Topluluklardan Gelenekler',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          for (final t in kardesTopluluklar) ...[
            _toplulukKarti(t),
            SizedBox(height: 10),
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
              Icon(Icons.public, color: Renkler.vurgu, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Tek bir beden, tek bir ümmet',
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
            'Farklı dillerde, farklı coğrafyalarda aynı kıbleye dönen milyarlarca kardeş. Nüfus dağılımı ve kültürel geleneklerle ümmet bilincini güçlendir.',
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _nufusKarti(Map<String, String> u) {
    if (u['bayrak'] == '🌍') {
      return Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Renkler.seciliYuzey,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Renkler.vurgu.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            Text('🌍', style: TextStyle(fontSize: 22)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                u['ulke']!,
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          Text(u['bayrak']!, style: TextStyle(fontSize: 20)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              u['ulke']!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            u['nufus']!,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(width: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Renkler.bannerUst,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              u['oran']!,
              style: TextStyle(
                color: Renkler.acikVurgu,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toplulukKarti(Map<String, String> t) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t['bayrak']!, style: TextStyle(fontSize: 26)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t['ad']!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    t['detay']!,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}