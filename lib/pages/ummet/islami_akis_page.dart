import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class IslamiAkisPage extends StatelessWidget {
  const IslamiAkisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'İslami Akış • Günün Mesajı',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _bugunKarti(),
          SizedBox(height: 20),
          Text(
            'Keşfet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(height: 6),
          for (final m in gununMesajlari) ...[
            _mesajKarti(m),
            SizedBox(height: 10),
          ],
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bugunKarti() {
    final i = UmmetStore.gununMesajIndexi();
    final mesaj = gununMesajlari[i % gununMesajlari.length];
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.wb_sunny, color: Renkler.vurgu, size: 20),
              SizedBox(width: 8),
              Text(
                "GÜNÜN MESAJI",
                style: TextStyle(
                  color: Renkler.acikVurgu,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            '"${mesaj['metin']}"',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Renkler.vurgu.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${mesaj['tip']}',
                  style: TextStyle(
                    color: Renkler.acikVurgu,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${mesaj['kaynak']}',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mesajKarti(Map<String, String> m) {
    final renk = m['tip'] == 'Ayet'
        ? Color(0xFF4FC3C9)
        : m['tip'] == 'Hadis'
            ? Color(0xFFF2C14E)
            : Color(0xFFEC4899);
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
                Icon(Icons.format_quote, color: renk, size: 20),
                SizedBox(width: 8),
                Text(
                  '${m['tip']}',
                  style: TextStyle(
                    color: renk,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              '"${m['metin']}"',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '— ${m['kaynak']}',
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}