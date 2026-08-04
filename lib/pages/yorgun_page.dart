import 'package:flutter/material.dart';
import '../services/renkler.dart';

class YorgunPage extends StatefulWidget {
  const YorgunPage({super.key});

  @override
  State<YorgunPage> createState() => _YorgunPageState();
}

class _YorgunPageState extends State<YorgunPage> {
  bool _isBreathingActive = false;
  String _breathStep = "Başlamak için Egzersizi Başlat'a dokunun";

  void _startBreathing() {
    setState(() {
      _isBreathingActive = true;
      _breathStep = "Nefes Al (4 Saniye)";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("😴 Yorgunluk & Ferahlık Odası"),
        backgroundColor: Color(0xFF1E242B),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Üst Banner
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E242B), Renkler.zemin],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(Icons.bedtime_outlined, color: Colors.blueAccent, size: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dinlenme & Rahatlama",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Bedenin ve ruhun dinlenmeye ihtiyaç duyduğunda Rabb'ine sığın.",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Nefes Egzersizi Kartı
            _buildCardTitle("4-7-8 Nefes & Sakinleşme Egzersizi"),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF1E242B),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent),
              ),
              child: Column(
                children: [
                  Icon(Icons.air, color: Colors.blueAccent, size: 44),
                  SizedBox(height: 12),
                  Text(
                    _breathStep,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "4 sn Nefes Al • 7 sn Tut • 8 sn Yavaşça Ver",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _startBreathing,
                    icon: Icon(Icons.play_arrow),
                    label: Text(_isBreathingActive ? "Devam Ediyor..." : "Egzersizi Başlat"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Rahatlatıcı Ayet (İnşirah)
            _buildCardTitle("Ferahlık Veren Ayet (İnşirah)"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Text(
                    "فَإِنَّ مَعَ الْعُسْرِ يُسْرًا • إِنَّ مَعَ الْعُسْرِ يُسْرًا",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '"Şüphesiz her zorlukla beraber bir kolaylık vardır. Gerçekten, her zorlukla beraber bir kolaylık vardır."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "İnşirah Suresi, 5-6. Ayetler",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Uyku Öncesi Dualar Köşesi
            _buildCardTitle("Uyku & Dinlenme Duaları"),
            _buildDuaTile(
              "Ayet-el Kürsi",
              "Yatmadan önce okunacak en büyük koruma kalkanı.",
            ),
            _buildDuaTile(
              "Felak & Nas Sureleri",
              "Avuç içine üflenerek tüm bedene meshedilen şifa sureleri.",
            ),
            _buildDuaTile(
              "Yatış Duası",
              "«Bismike Allahümme emûtü ve ahyâ» (Allah'ım senin adınla ölür ve dirilirim.)",
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDuaTile(String title, String subtitle) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(Icons.bedtime, color: Colors.blueAccent),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.white38),
      ),
    );
  }
}
