import 'package:flutter/material.dart';
import '../services/renkler.dart';

class DualarPage extends StatelessWidget {
  const DualarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dualar = [
      {
        "title": "Rabbena Duaları",
        "arabic": "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
        "meaning": "Ey Rabbimiz! Bize dünyada da iyilik ver, ahirette de iyilik ver ve bizi ateş azabından koru."
      },
      {
        "title": "İnşirah Ferahlık Duası",
        "arabic": "اللَّهُمَّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي",
        "meaning": "Allah'ım! Göğsümü genişlet, işimi bana kolaylaştır."
      },
      {
        "title": "Nazar ve Korunma Duası",
        "arabic": "أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّةِ مِنْ كُلِّ شَيْطَانٍ وَهَامَّةٍ",
        "meaning": "Her türlü şeytandan, zararlı mahlukattan ve kem gözden Allah'ın eksiksiz kelimelerine sığınırım."
      },
      {
        "title": "Borçtan ve Sıkıntıdan Kurtulma Duası",
        "arabic": "اللَّهُمَّ إِنِّى أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ",
        "meaning": "Allah'ım! Kederden ve hüzünden sana sığınırım."
      },
    ];

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("Manevi Dualar Hazinesi"),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: dualar.length,
        itemBuilder: (context, index) {
          final dua = dualar[index];
          return Card(
            color: Renkler.kart,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dua["title"]!,
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    dua["arabic"]!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '"${dua["meaning"]!}"',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
