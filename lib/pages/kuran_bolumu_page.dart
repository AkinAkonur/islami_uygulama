import 'package:flutter/material.dart';
import '../services/renkler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/kuran_verileri.dart';
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
    final gununAyeti = _bugununAyeti();

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          "Kur'an-ı Kerim",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: "Kur'an Adabı",
            icon: Icon(Icons.auto_stories_outlined, color: Renkler.vurgu),
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
                      Icon(Icons.menu_book, color: Renkler.vurgu, size: 40),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kur'an-ı Kerim",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Okuma • Dinleme • Ezber • Takip",
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
                    '"Hakkında hiçbir şüphe olmayan bu kitap, muttakiler için yol göstericidir."',
                    style: TextStyle(color: Colors.white70, fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Bakara Suresi, 2. Ayet",
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
                      Icon(Icons.wb_sunny_outlined, color: Renkler.vurgu, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Günün Ayeti",
                        style: TextStyle(color: Renkler.vurgu, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AyetAramaPage()),
                        ),
                        child: Icon(Icons.search, color: Colors.white38, size: 20),
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
            _baslik("📖 Okuma", "Sureler, cüzler ve meâl"),
            _modulKart(
              context,
              Icons.format_list_numbered,
              "Sure Listesi (114)",
              "Numara, isim, âyet sayısı ve iniş yeri • arama",
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SureListesiPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.filter_alt_outlined,
              "Cüz Listesi (30)",
              "Bölüm bölüm Kur'an okuma",
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CuzListesiPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.search,
              "Ayet Arama",
              "Türkçe kelimeyle veya sure:âyet numarasıyla",
              Colors.lightGreen,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AyetAramaPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- B. DİNLEME ----------
            _baslik("🎧 Dinleme", "Seçtiğiniz kârîden tilâvet"),
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
                    "Kârî Seçimi",
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
                      Icon(Icons.headphones, color: Renkler.vurgu, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Tilâveti dinlemek için bir sure açın: Sure Listesi'nden seçin veya aşağıdan hızlı erişin.",
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
            _baslik("📈 Ezber & Takip", "Hatim ve hedefler"),
            _modulKart(
              context,
              Icons.flag_outlined,
              "Hatim Takibi",
              "Okunan sayfalar, ilerleme çubuğu ve bitince kutlama",
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HatimTakibiPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- D. KELİME & ANLAM ----------
            _baslik("🔍 Kelime & Anlam", "Öğrenme ve keşif"),
            _modulKart(
              context,
              Icons.folder_special_outlined,
              "Tematik Âyetler",
              "Sabır, tövbe, rızık, anne-baba, huzur... hazır paketler",
              Colors.pinkAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TematikAyetlerPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- E. ÖZEL BÖLÜMLER ----------
            _baslik("✨ Özel Bölümler"),
            _modulKart(
              context,
              Icons.self_improvement,
              "Amme Cüzü & Kısa Sureler",
              "Namazda okunan sûreler • ezber desteği",
              Colors.purpleAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => KisaSurelerPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.star_outline,
              "Özel Gün Sureleri",
              "Kehf (cuma), Mülk (her gece), Vâkıa, Yâsîn",
              Colors.amber,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => KisaSurelerPage(tab: 1)),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_stories_outlined,
              "Kur'an'a Dokunma Adabı",
              "Abdest, tilâvet secdesi ve okuma edepleri",
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
          child: Icon(ikon, color: renk, size: 24),
        ),
        title: Text(
          baslik,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          alt,
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
        trailing: Icon(Icons.chevron_right, color: Colors.white38),
        onTap: onTap,
      ),
    );
  }
}
