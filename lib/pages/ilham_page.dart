import 'package:flutter/material.dart';
import '../services/renkler.dart';

class IlhamPage extends StatelessWidget {
  const IlhamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ilhamSozleri = [
      {
        "quote": "Kader gayretkeşiktir. Sen gayret et, Mevlam en güzelini takdir eyler.",
        "author": "Hz. Mevlana"
      },
      {
        "quote": "Kalp denilen bu latif emanet, ancak Allah'ın zikriyle ve marifetiyle sükûnet bulur.",
        "author": "İmam Gazali"
      },
      {
        "quote": "Üzülme! Çünkü Allah senin gözyaşlarını dahi zayi etmez, her damlasını rahmetine yazar.",
        "author": "Mesnevi'den Hikmetler"
      },
      {
        "quote": "Sabır, sıkıntı anında ilk çarpmada gösterilen metanettir.",
        "author": "Hadis-i Şerif"
      },
    ];

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("İlham & Hikmet Köşesi"),
        backgroundColor: Color(0xFF2D1E1E),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: ilhamSozleri.length,
        itemBuilder: (context, index) {
          final item = ilhamSozleri[index];
          return Card(
            color: Renkler.kart,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.format_quote, color: Colors.orange, size: 32),
                  SizedBox(height: 12),
                  Text(
                    '"${item["quote"]!}"',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "— ${item["author"]!}",
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
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
