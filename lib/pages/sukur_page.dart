import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class SukurPage extends StatefulWidget {
  const SukurPage({super.key});

  @override
  State<SukurPage> createState() => _SukurPageState();
}

class _SukurPageState extends State<SukurPage> {
  int _hamdCount = 0;
  final List<Map<String, dynamic>> _sukurList = [
    {"text": "Sağlığım ve nefes alabildiğim için", "isDone": true},
    {"text": "İman ve İslam nimeti için", "isDone": true},
    {"text": "Ailem ve sevdiklerim için", "isDone": false},
  ];
  final TextEditingController _inputController = TextEditingController();

  void _addSukur() {
    if (_inputController.text.trim().isNotEmpty) {
      setState(() {
        _sukurList.insert(0, {"text": _inputController.text.trim(), "isDone": false});
        _inputController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('su.title')),
        backgroundColor: Renkler.yuzey,
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
                  colors: [Renkler.yuzey, Renkler.zemin],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  UcdIkon(ikon: Icons.favorite_rounded, renk: Renkler.vurgu, boyut: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.t('su.bannerTitle'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          l.t('su.bannerIntro'),
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Şükür Ayeti
            _buildCardTitle(l.t('su.verseTitle')),
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
                    "لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    l.t('su.verseText'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    l.t('su.verseSource'),
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

            // Zikir Sayacı Kartı
            _buildCardTitle(l.t('su.dhikrTitle')),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Renkler.vurgu, width: 1),
              ),
              child: Column(
                children: [
                  Text(
                    "«الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ»",
                    style: TextStyle(
                      color: Renkler.acikVurgu,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => setState(() => _hamdCount++),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Renkler.vurgu.withValues(alpha: 0.2),
                      child: Text(
                        "$_hamdCount",
                        style: TextStyle(
                          color: Renkler.vurgu,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    l.t('su.tapHint'),
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Şükür Günlüğü Ekleme Alanı
            _buildCardTitle(l.t('su.journalTitle')),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    decoration: InputDecoration(
                      hintText: l.t('su.journalHint'),
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
                  onPressed: _addSukur,
                  icon: UcdIkon(
                    ikon: Icons.add_circle,
                    renk: Renkler.vurgu,
                    boyut: 40,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Şükür Listesi
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _sukurList.length,
              itemBuilder: (context, index) {
                final item = _sukurList[index];
                return Card(
                  color: Renkler.kart,
                  margin: EdgeInsets.only(bottom: 8),
                  child: CheckboxListTile(
                    activeColor: Renkler.vurgu,
                    checkColor: Colors.black,
                    value: item["isDone"],
                    onChanged: (val) {
                      setState(() {
                        item["isDone"] = val ?? false;
                      });
                    },
                    title: Text(
                      item["text"],
                      style: TextStyle(
                        color: item["isDone"] ? Colors.white54 : Colors.white,
                        decoration: item["isDone"]
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    secondary: UcdIkon(ikon: Icons.favorite_border_rounded, renk: Renkler.vurgu),
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
