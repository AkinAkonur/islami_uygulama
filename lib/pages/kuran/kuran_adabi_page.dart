import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/kuran_verileri.dart';

class KuranAdabiPage extends StatelessWidget {
  const KuranAdabiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          "Kur'an'a Dokunma Adabı",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            padding: EdgeInsets.all(18),
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
                    Icon(Icons.auto_stories, color: Renkler.vurgu, size: 32),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Kur'an-ı Kerim'e saygı, imanın bir gereğidir.",
                        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Mushaf'a abdestsiz dokunmak caiz değildir. Tilâvet secdesi gerektiren âyetler okunduğunda secde yapılır. (Vâkıa 56/79)",
                  style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          for (final madde in kuranAdabi)
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Renkler.cerceve),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle_outline, color: Renkler.vurgu, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          madde["baslik"]!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          madde["detay"]!,
                          style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tilâvet Secdesi",
                  style: TextStyle(color: Renkler.vurgu, fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 6),
                Text(
                  "Kur'an'da 15 secde âyeti vardır. Bunlardan birini okuyan veya işiten kişi, tekbir getirerek secde eder; secdede 'Sübhâne rabbiye'l-a'lâ' diyerek kalkar. Namaz içinde okunduğunda da secde gerekir.",
                  style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
