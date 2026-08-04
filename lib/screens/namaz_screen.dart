import 'package:flutter/material.dart';
import '../services/renkler.dart';
import 'guide_screen.dart';
import 'wudu_screen.dart';
import 'qada_screen.dart';
import 'special_screen.dart';

class NamazScreen extends StatelessWidget {
  const NamazScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F1410),
      appBar: AppBar(
        title: Text("Namaz & İbadet Merkezi", style: TextStyle(fontWeight: FontWeight.bold, color: Renkler.vurgu)),
        backgroundColor: Color(0xFF141F18),
        elevation: 0,
        iconTheme: IconThemeData(color: Renkler.vurgu),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Countdown Card (Sonraki Namaz Geri Sayım)
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1B3B2B), Color(0xFF0D2117)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Renkler.vurgu.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "YAKLAŞAN VAKİT",
                          style: TextStyle(color: Renkler.vurgu, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("20:17", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Akşam Namazı", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text("01:24:10 kaldı", style: TextStyle(color: Renkler.vurgu, fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0.70,
                      backgroundColor: Colors.black38,
                      valueColor: AlwaysStoppedAnimation<Color>(Renkler.vurgu),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // 5 Vakit Listesi
            Text("Bugünkü Vakitler", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            _vakitTile("İmsak", "04:12", false),
            _vakitTile("Güneş", "05:48", false),
            _vakitTile("Öğle", "13:05", false),
            _vakitTile("İkindi", "16:45", false),
            _vakitTile("Akşam", "20:17", true),
            _vakitTile("Yatsı", "21:50", false),
            SizedBox(height: 24),

            // Hızlı Erişim Grid
            Text("Hızlı Erişim & Rehberler", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _gridCard(context, Icons.menu_book, "Adım Adım Kılınış", "Rehber & Stepper", GuideScreen(), Colors.green),
                _gridCard(context, Icons.water_drop, "Abdest & Gusül", "Temizlik Esasları", WuduScreen(), Colors.teal),
                _gridCard(context, Icons.calendar_today, "Kaza Takipçisi", "Takvim & Liste", QadaScreen(), Colors.orange),
                _gridCard(context, Icons.healing, "Özel Durumlar", "Seferî & Hasta", SpecialScreen(), Colors.blueAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _vakitTile(String name, String time, bool isCurrent) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrent ? Color(0xFF1E3326) : Color(0xFF161E18),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isCurrent ? Renkler.vurgu : Color(0xFF223028)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(isCurrent ? Icons.access_time_filled : Icons.access_time, color: isCurrent ? Renkler.vurgu : Colors.white54, size: 20),
              SizedBox(width: 12),
              Text(name, style: TextStyle(color: isCurrent ? Colors.white : Colors.white70, fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
          Text(time, style: TextStyle(color: isCurrent ? Renkler.vurgu : Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _gridCard(BuildContext context, IconData icon, String title, String subtitle, Widget targetPage, Color color) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF161E18),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(height: 10),
            Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            SizedBox(height: 2),
            Text(subtitle, style: TextStyle(color: Colors.white54, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
