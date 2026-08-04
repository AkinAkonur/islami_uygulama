import 'package:flutter/material.dart';
import '../services/renkler.dart';

class TesbihPage extends StatefulWidget {
  const TesbihPage({super.key});

  @override
  State<TesbihPage> createState() => _TesbihPageState();
}

class _TesbihPageState extends State<TesbihPage> {
  int _count = 0;
  int _totalCount = 0;
  String _selectedZikir = "Sübhanallah (33)";

  final List<String> _zikirListesi = [
    "Sübhanallah (33)",
    "Elhamdülillah (33)",
    "Allahu Ekber (33)",
    "Estağfirullah el-Azim",
    "La ilahe illallah",
    "Salavat-ı Şerife",
  ];

  void _increment() {
    setState(() {
      _count++;
      _totalCount++;
      if (_count > 33) {
        _count = 1;
      }
    });
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("Dijital Akıllı Tesbih (Zikirmatik)"),
        backgroundColor: Color(0xFF2B1E26),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Zikir Seçimi
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.pinkAccent.withValues(alpha: 0.3)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedZikir,
                  dropdownColor: Renkler.kart,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.pinkAccent),
                  items: _zikirListesi.map((String zikir) {
                    return DropdownMenuItem<String>(
                      value: zikir,
                      child: Text(zikir),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedZikir = newValue;
                        _count = 0;
                      });
                    }
                  },
                ),
              ),
            ),
            Spacer(),

            // Büyük Zikir Sayacı Dairesi
            GestureDetector(
              onTap: _increment,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF880E4F), Color(0xFFC2185B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pinkAccent.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$_count",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Dokun ve Çek",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),

            // Toplam Sayaç ve Sıfırlama
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Toplam Zikir: $_totalCount",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2C2C2C),
                    foregroundColor: Colors.pinkAccent,
                  ),
                  onPressed: _reset,
                  icon: Icon(Icons.refresh),
                  label: Text("Sıfırla"),
                ),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
