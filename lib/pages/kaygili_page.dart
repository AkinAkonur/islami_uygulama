import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class KaygiliPage extends StatefulWidget {
  const KaygiliPage({super.key});

  @override
  State<KaygiliPage> createState() => _KaygiliPageState();
}

class _KaygiliPageState extends State<KaygiliPage> {
  int _hasbunallahCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("😟 Kaygı & Tevekkül Odası"),
        backgroundColor: Color(0xFF2B1E1E),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2B1E1E), Renkler.zemin],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.redAccent.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  UcdIkon(ikon: Icons.shield_outlined, renk: Colors.redAccent, boyut: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tevekkül & Sükûnet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Endişelerini ve geleceğe dair kaygılarını Yaratıcısına teslim et.",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Tevekkül Ayeti
            _buildCardTitle("Tevekkül Ayeti (Talak Suresi)"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.redAccent.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Text(
                    "وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '"Kim Allah’a tevekkül ederse, O, kendisine yeter."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Talak Suresi, 3. Ayet",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Acil Tevekkül Zikri
            _buildCardTitle("Tevekkül Zikri (Hasbunallah)"),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color(0xFF2B1E1E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "«حَسْبُنَا اللّٰهُ وَنِعْمَ الْوَكٖيلُ»",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '"Allah bize yeter, O ne güzel vekildir."',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: () => setState(() => _hasbunallahCount++),
                    icon: UcdIkon(ikon: Icons.touch_app, renk: Colors.white),
                    label: Text(
                      "Zikir Çek: $_hasbunallahCount",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Sakinleşme Adımları
            _buildCardTitle("Kaygıyı Azaltmak İçin 3 Manevi Adım"),
            _buildStepTile(
              "1",
              "Tazelen ve Abdest Al",
              "Serin su ile abdest almak öfkeyi, kaygıyı ve sinirleri yatıştırır.",
            ),
            _buildStepTile(
              "2",
              "2 Rakat Tevekkül Namazı Kıl",
              "Tüm ağırlıklarını ve endişelerini seccadede Allah'a bırak.",
            ),
            _buildStepTile(
              "3",
              "Euzu-Besmele ve İstiğfar Çek",
              "«Estağfirullah el-azim» diyerek kalbi ve zihni vesveseden arındır.",
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

  Widget _buildStepTile(String step, String title, String subtitle) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.redAccent.withValues(alpha: 0.2),
          child: Text(
            step,
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
      ),
    );
  }
}
