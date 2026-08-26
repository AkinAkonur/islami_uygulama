import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class BagisPage extends StatefulWidget {
  const BagisPage({super.key});

  @override
  State<BagisPage> createState() => _BagisPageState();
}

class _BagisPageState extends State<BagisPage> {
  final List<Map<String, dynamic>> _projeler = [
    {"title": "Su Kuyusu Projeleri", "target": 50000, "collected": 38000, "desc": "Kurak bölgelerde temiz su kuyusu açılışı."},
    {"title": "Yetim Sponsorluğu", "target": 12000, "collected": 9500, "desc": "Bir yetimin aylık eğitim ve gıda ihtiyacı."},
    {"title": "Kur'an-ı Kerim Dağıtımı", "target": 5000, "collected": 4200, "desc": "İhtiyaç sahiplerine Kur'an ve meal hediyesi."},
    {"title": "İyilik Sofrası (Gıda Paketi)", "target": 25000, "collected": 21000, "desc": "Muhtaç aileler için sıcak yemek ve gıda kolisi."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("Sadaka & İyilik Projeleri"),
        backgroundColor: Color(0xFF2C241E),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _projeler.length,
        itemBuilder: (context, index) {
          final p = _projeler[index];
          double progress = (p["collected"] as int) / (p["target"] as int);
          return Card(
            color: Renkler.kart,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p["title"],
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      UcdIkon(ikon: Icons.volunteer_activism_rounded, renk: Colors.amber, boyut: 24),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text(
                    p["desc"],
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.black26,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Toplanan: ${p["collected"]} TL",
                        style: TextStyle(color: Colors.white60, fontSize: 11),
                      ),
                      Text(
                        "Hedef: ${p["target"]} TL",
                        style: TextStyle(color: Colors.amberAccent, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Bağış sayfasına yönlendiriliyorsunuz... Allah kabul etsin.")),
                        );
                      },
                      child: Text("Bağış Yap / Sadaka Ver", style: TextStyle(fontWeight: FontWeight.bold)),
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
