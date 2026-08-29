import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class UmutluPage extends StatefulWidget {
  const UmutluPage({super.key});

  @override
  State<UmutluPage> createState() => _UmutluPageState();
}

class _UmutluPageState extends State<UmutluPage> {
  final List<Map<String, dynamic>> _goals = [
    {"text": "Hayırlı bir kapının açılması için samimi dua et", "isDone": false},
    {"text": "Bugün bir muhtaca iyilikte bulun", "isDone": false},
    {"text": "Geleceğim için tevekkül edip endişeyi bırak", "isDone": true},
    {"text": "Kaza ve belalara karşı sadaka ver", "isDone": false},
  ];

  final TextEditingController _customGoalController = TextEditingController();

  void _addGoal() {
    if (_customGoalController.text.trim().isNotEmpty) {
      setState(() {
        _goals.insert(0, {"text": _customGoalController.text.trim(), "isDone": false});
        _customGoalController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('um.title')),
        backgroundColor: Renkler.yuzey,
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
                  colors: [Renkler.yuzey, Renkler.zemin],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  UcdIkon(ikon: Icons.wb_sunny_rounded, renk: Renkler.vurgu, boyut: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.t('um.bannerTitle'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          l.t('um.bannerIntro'),
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Umut Ayetleri
            _buildCardTitle(l.t('um.verseTitle')),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Text(
                    "قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَىٰ أَنفُسِهِمْ لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '"De ki: Ey kendi aleyhlerine haddi aşan kullarım! Allah’ın rahmetinden ümidinizi kesmeyin. Şüphesiz Allah bütün günahları bağışlar."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    l.t('um.verseSource'),
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

            // Niyet & Dua Listesi Ekleme
            _buildCardTitle(l.t('um.addTitle')),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _customGoalController,
                    decoration: InputDecoration(
                      hintText: l.t('um.addHint'),
                      filled: true,
                      fillColor: Renkler.kart,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: _addGoal,
                  icon: UcdIkon(
                    ikon: Icons.add_circle,
                    renk: Renkler.vurgu,
                    boyut: 40,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Niyetler Listesi
            _buildCardTitle(l.t('um.goalsTitle')),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _goals.length,
              itemBuilder: (context, index) {
                final goal = _goals[index];
                return Card(
                  color: Renkler.kart,
                  margin: EdgeInsets.only(bottom: 8),
                  child: CheckboxListTile(
                    activeColor: Renkler.vurgu,
                    checkColor: Colors.white,
                    value: goal["isDone"],
                    onChanged: (val) {
                      setState(() {
                        goal["isDone"] = val ?? false;
                      });
                    },
                    title: Text(
                      goal["text"],
                      style: TextStyle(
                        color: goal["isDone"] ? Colors.white54 : Colors.white,
                        decoration: goal["isDone"]
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    secondary: UcdIkon(ikon: Icons.star_border_rounded, renk: Renkler.vurgu),
                  ),
                );
              },
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
}
