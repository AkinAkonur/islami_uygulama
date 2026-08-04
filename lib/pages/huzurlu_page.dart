import 'package:flutter/material.dart';
import '../services/renkler.dart';

class HuzurluPage extends StatefulWidget {
  const HuzurluPage({super.key});

  @override
  State<HuzurluPage> createState() => _HuzurluPageState();
}

class _HuzurluPageState extends State<HuzurluPage> {
  int _zikirCount = 0;
  final TextEditingController _journalController = TextEditingController();
  final List<String> _journalEntries = [];

  void _addJournalEntry() {
    if (_journalController.text.trim().isNotEmpty) {
      setState(() {
        _journalEntries.insert(0, _journalController.text.trim());
        _journalController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("😊 Huzur Odası & Tefekkür"),
        backgroundColor: Renkler.seciliYuzey,
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
                  colors: [Renkler.seciliYuzey, Renkler.zemin],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Renkler.vurgu.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.spa, color: Renkler.vurgu, size: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sakinlik & İçsel Huzur",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Zihnini dünyevi telaştan arındır, kalbini zikirle dinlendir.",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Huzur Ayeti
            _buildCardTitle("Huzur Veren Ayet"),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Renkler.cerceve2),
              ),
              child: Column(
                children: [
                  Text(
                    "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '"Bilesiniz ki, kalpler ancak Allah’ı anmakla huzur bulur."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Ra'd Suresi, 28. Ayet",
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Yâ Selâm Zikir Sayacı
            _buildCardTitle("Huzur Zikri (Yâ Selâm)"),
            GestureDetector(
              onTap: () => setState(() => _zikirCount++),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Renkler.seciliYuzey,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Renkler.vurgu),
                ),
                child: Column(
                  children: [
                    Text(
                      "$_zikirCount",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Renkler.vurgu,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Dokunarak Zikir Çek",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "«يَا سَلَامُ» (Ey Selamet ve Emniyet Veren)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Sakinleştirici Hadis & Tavsiyeler
            _buildCardTitle("Manevi Reçete"),
            _buildTipCard(
              Icons.wb_sunny_outlined,
              "Güne Teşekkürle Başla",
              "Sabah ve akşam ezanlarından sonra İhlas, Felak ve Nas surelerini 3'er defa okumak kalbe emniyet verir.",
            ),
            _buildTipCard(
              Icons.water_drop_outlined,
              "Abdestin Ferahlığı",
              "Huzursuzluk hissettiğinde taze bir abdest almak, öfkeyi ve iç sıkıntısını su gibi akıtıp götürür.",
            ),
            _buildTipCard(
              Icons.menu_book,
              "Tefekkür Anı",
              "Göklerin ve yerin yaratılışındaki incelikleri düşünmek imanı ve huzuru artırır.",
            ),
            SizedBox(height: 20),

            // Tefekkür Günlüğü
            _buildCardTitle("Bugünün Tefekkürü ve Notları"),
            TextField(
              controller: _journalController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText:
                    "Bugün seni en çok huzurlu kılan şey neydi? Buraya yazabilirsin...",
                filled: true,
                fillColor: Renkler.kart,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                ),
                onPressed: _addJournalEntry,
                icon: Icon(Icons.save),
                label: Text("Notu Kaydet"),
              ),
            ),
            if (_journalEntries.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                "Kaydedilen Tefekkürleriniz:",
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ..._journalEntries.map(
                (entry) => Card(
                  color: Renkler.kart,
                  margin: EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(Icons.bookmark, color: Renkler.vurgu),
                    title: Text(
                      entry,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
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

  Widget _buildTipCard(IconData icon, String title, String subtitle) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.cerceve2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Renkler.vurgu, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
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
