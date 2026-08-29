import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

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
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('hz.title')),
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
                  UcdIkon(ikon: Icons.spa_rounded, renk: Renkler.vurgu, boyut: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.t('hz.bannerTitle'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          l.t('hz.bannerIntro'),
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
            _buildCardTitle(l.t('hz.verseTitle')),
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
                    l.t('hz.verseText'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    l.t('hz.verseSource'),
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
            _buildCardTitle(l.t('hz.dhikrTitle')),
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
                      l.t('hz.tapHint'),
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    SizedBox(height: 8),
                    Text(
                      l.t('hz.dhikrText'),
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
            _buildCardTitle(l.t('hz.tipsTitle')),
            _buildTipCard(
              Icons.wb_sunny_rounded,
              l.t('hz.tip1Title'),
              l.t('hz.tip1Sub'),
            ),
            _buildTipCard(
              Icons.water_drop_outlined,
              l.t('hz.tip2Title'),
              l.t('hz.tip2Sub'),
            ),
            _buildTipCard(
              Icons.menu_book,
              l.t('hz.tip3Title'),
              l.t('hz.tip3Sub'),
            ),
            SizedBox(height: 20),

            // Tefekkür Günlüğü
            _buildCardTitle(l.t('hz.journalTitle')),
            TextField(
              controller: _journalController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: l.t('hz.journalHint'),
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
                  backgroundColor: Renkler.vurgu,
                  foregroundColor: Colors.black,
                ),
                onPressed: _addJournalEntry,
                icon: UcdIkon(ikon: Icons.save_rounded, renk: Colors.white70),
                label: Text(l.t('hz.saveNote')),
              ),
            ),
            if (_journalEntries.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                l.t('hz.savedNotes'),
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
                    leading: UcdIkon(ikon: Icons.bookmark_rounded, renk: Renkler.vurgu),
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
              child: UcdIkon(ikon: icon, renk: Renkler.vurgu, boyut: 24),
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
