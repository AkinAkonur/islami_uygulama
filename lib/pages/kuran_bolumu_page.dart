import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/kuran_verileri.dart';
import '../widgets/kart_sekilleri.dart';
import 'kuran/sure_listesi_page.dart';
import 'kuran/ayet_arama_page.dart';
import 'kuran/hatim_takibi_page.dart';
import 'kuran/kisa_sureler_page.dart';
import 'kuran/tematik_ayetler_page.dart';
import 'kuran/kuran_adabi_page.dart';
import 'kuran/cuz_listesi_page.dart';

class KuranBolumuPage extends StatefulWidget {
  const KuranBolumuPage({super.key});

  @override
  State<KuranBolumuPage> createState() => _KuranBolumuPageState();
}

class _KuranBolumuPageState extends State<KuranBolumuPage> {
  String _kariId = 'ar.abdurrahmaansudais';

  @override
  void initState() {
    super.initState();
    _kariyiYukle();
  }

  Future<void> _kariyiYukle() async {
    final prefs = await SharedPreferences.getInstance();
    final kayitliId = prefs.getString('kuran_kari_id');
    if (kayitliId != null) {
      final kari = kariler.where((k) => k.id == kayitliId).firstOrNull;
      if (kari != null && mounted) {
        setState(() => _kariId = kari.id);
      }
    }
  }

  Future<void> _kariSec(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('kuran_kari_id', id);
    setState(() => _kariId = id);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final gununAyeti = _bugununAyeti();

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('qn.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: l.t('qn.etiquette'),
            icon: UcdIkon(ikon: Icons.auto_stories_rounded, renk: Renkler.vurgu),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => KuranAdabiPage()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------- BANNER ----------
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Renkler.bannerUst, Renkler.bannerAlt],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UcdIkon(ikon: Icons.menu_book_rounded, renk: Renkler.vurgu, boyut: 40),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.t('qn.title'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              l.t('qn.subtitle'),
                              style: TextStyle(color: Renkler.acikVurgu, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "قُرْآنٌ كَرِيمٌ",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(height: 6),
                  Text(
                    l.t('qn.verseText'),
                    style: TextStyle(color: Colors.white70, fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 6),
                  Text(
                    l.t('qn.verseRef'),
                    style: TextStyle(color: Renkler.vurgu, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // ---------- GÜNÜN AYETİ ----------
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Renkler.cerceve),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      UcdIkon(ikon: Icons.wb_sunny_outlined, renk: Renkler.vurgu, boyut: 18),
                      SizedBox(width: 8),
                      Text(
                        l.t('qn.dailyVerse'),
                        style: TextStyle(color: Renkler.vurgu, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AyetAramaPage()),
                        ),
                        child: UcdIkon(ikon: Icons.search_rounded, renk: Colors.white38, boyut: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    gununAyeti["arabic"]!,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontSize: 24, height: 1.6),
                  ),
                  SizedBox(height: 14),
                  Text(
                    '"${gununAyeti["translation"]!}"',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic, height: 1.5),
                  ),
                  SizedBox(height: 10),
                  Text(
                    gununAyeti["reference"]!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Renkler.vurgu, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // ---------- A. OKUMA ----------
            _baslik(l.t('qn.readTab'), l.t('qn.readDesc')),
            _modulKart(
              context,
              Icons.format_list_numbered,
              l.t('qn.sureList'),
              l.t('qn.sureListDesc'),
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SureListesiPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.filter_alt_outlined,
              l.t('qn.cuzList'),
              l.t('qn.cuzListDesc'),
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CuzListesiPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.search,
              l.t('qn.verseSearch'),
              l.t('qn.verseSearchDesc'),
              Colors.lightGreen,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AyetAramaPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- B. DİNLEME ----------
            _baslik(l.t('qn.listenTab'), l.t('qn.listenDesc')),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Renkler.cerceve2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.t('qn.selectReciter'),
                    style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: _kariId,
                    dropdownColor: Renkler.seciliYuzey,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Renkler.yuzey,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: kariler
                        .map((k) => DropdownMenuItem(value: k.id, child: Text(k.ad)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        _kariSec(val);
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      UcdIkon(ikon: Icons.headphones_rounded, renk: Renkler.vurgu, boyut: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l.t('qn.noRecitation'),
                          style: TextStyle(color: Colors.white54, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // ---------- C. EZBER & TAKİP ----------
            _baslik(l.t('qn.memorizeTab'), l.t('qn.memorizeDesc')),
            _modulKart(
              context,
              Icons.flag_outlined,
              l.t('qn.hatimTrack'),
              l.t('qn.hatimTrackDesc'),
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HatimTakibiPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- D. KELİME & ANLAM ----------
            _baslik(l.t('qn.exploreTab'), l.t('qn.exploreDesc')),
            _modulKart(
              context,
              Icons.folder_special_outlined,
              l.t('qn.thematic'),
              l.t('qn.thematicDesc'),
              Colors.pinkAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TematikAyetlerPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- E. ÖZEL BÖLÜMLER ----------
            _baslik(l.t('qn.specialTab')),
            _modulKart(
              context,
              Icons.self_improvement,
              l.t('qn.shortSures'),
              l.t('qn.shortSuresDesc'),
              Colors.purpleAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => KisaSurelerPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.star_outline,
              l.t('qn.specialDays'),
              l.t('qn.specialDaysDesc'),
              Colors.amber,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => KisaSurelerPage(tab: 1)),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_stories_outlined,
              l.t('qn.mannersTitle'),
              l.t('qn.mannersDesc'),
              Colors.cyan,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => KuranAdabiPage()),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Map<String, String> _bugununAyeti() {
    final now = DateTime.now();
    final gun = now.difference(DateTime(now.year, 1, 1)).inDays;
    return gununAyetleri[gun % gununAyetleri.length];
  }

  Widget _baslik(String baslik, [String? alt]) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            baslik,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (alt != null)
            Text(alt, style: TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _modulKart(
    BuildContext context,
    IconData ikon,
    String baslik,
    String alt,
    Color renk,
    VoidCallback onTap,
  ) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: renk.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: UcdIkon(ikon: ikon, renk: renk, boyut: 24),
        ),
        title: Text(
          baslik,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          alt,
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
        trailing: UcdIkon(ikon: Icons.chevron_right, renk: Colors.white38),
        onTap: onTap,
      ),
    );
  }
}
