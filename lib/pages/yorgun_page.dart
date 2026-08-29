import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class YorgunPage extends StatefulWidget {
  const YorgunPage({super.key});

  @override
  State<YorgunPage> createState() => _YorgunPageState();
}

class _YorgunPageState extends State<YorgunPage> {
  bool _isBreathingActive = false;

  void _startBreathing() {
    setState(() {
      _isBreathingActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('yg.title')),
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
                  UcdIkon(ikon: Icons.bedtime_rounded, renk: Renkler.vurgu, boyut: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.t('yg.bannerTitle'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          l.t('yg.bannerIntro'),
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
            _buildCardTitle(l.t('yg.exerciseTitle')),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Renkler.vurgu),
              ),
              child: Column(
                children: [
                  UcdIkon(ikon: Icons.air_rounded, renk: Renkler.vurgu, boyut: 44),
                  SizedBox(height: 12),
                  Text(
                    _isBreathingActive ? l.t('yg.breathing') : l.t('yg.breathStart'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    l.t('yg.breathGuide'),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Renkler.vurgu,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _startBreathing,
                    icon: UcdIkon(ikon: Icons.play_arrow_rounded, renk: Colors.white),
                    label: Text(_isBreathingActive ? l.t('yg.runningBtn') : l.t('yg.startBtn')),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Rahatlatıcı Ayet (İnşirah)
            _buildCardTitle(l.t('yg.verseTitle')),
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
                    l.t('yg.verseSource'),
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

            // Uyku Öncesi Dualar Köşesi
            _buildCardTitle(l.t('yg.duaTitle')),
            _buildDuaTile(
              l.t('yg.dua1Title'),
              l.t('yg.dua1Sub'),
            ),
            _buildDuaTile(
              l.t('yg.dua2Title'),
              l.t('yg.dua2Sub'),
            ),
            _buildDuaTile(
              l.t('yg.dua3Title'),
              l.t('yg.dua3Sub'),
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
        leading: UcdIkon(ikon: Icons.bedtime, renk: Renkler.vurgu),
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
        trailing: UcdIkon(ikon: Icons.chevron_right, renk: Colors.white38),
      ),
    );
  }
}
