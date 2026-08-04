import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../services/ummet_verileri.dart';
import 'ummet/dua_duvari_page.dart';
import 'ummet/dua_zincirleri_page.dart';
import 'ummet/dua_odalari_page.dart';
import 'ummet/ummet_haritasi_page.dart';
import 'ummet/mazlum_cografyalar_page.dart';
import 'ummet/iyilik_hikayeleri_page.dart';
import 'ummet/hatim_halkalari_page.dart';
import 'ummet/zikir_kampanyalari_page.dart';
import 'ummet/gunluk_iyilik_gorevleri_page.dart';

class UmmetBolumuPage extends StatefulWidget {
  const UmmetBolumuPage({super.key});

  @override
  State<UmmetBolumuPage> createState() => _UmmetBolumuPageState();
}

class _UmmetBolumuPageState extends State<UmmetBolumuPage> {
  int _bugunDua = 48200;
  int _hatimTamamlanan = hatimTabaniTamamlanan;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final dua = await UmmetStore.bugunYapilanDua();
    final hatim = await UmmetStore.hatimTamamlanan();
    if (!mounted) return;
    setState(() {
      _bugunDua = dua;
      _hatimTamamlanan = hatim;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          "Ümmet",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: "Canlı Ümmet Haritası",
            icon: Icon(Icons.public, color: Renkler.vurgu),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UmmetHaritasiPage()),
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
                border: Border.all(
                  color: Renkler.vurgu.withValues(alpha: 0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.groups, color: Renkler.vurgu, size: 40),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ümmet",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Dua • Dayanışma • Ortak İbadet",
                              style: TextStyle(
                                color: Renkler.acikVurgu,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "الْمُؤْمِنُ لِلْمُؤْمِنِ كَالْبُنْيَانِ يَشُدُّ بَعْضُهُ بَعْضًا",
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '"Mümin, mümin için (tuğlaları birbirini tutan) bir bina gibidir; birbirlerine destek olurlar."',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Buhârî, Salât 88 • Müslim, Birr 65",
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // ---------- CANLI ÖZET ŞERİDİ ----------
            Row(
              children: [
                Expanded(
                  child: _miniSayac(
                    Icons.favorite_outline,
                    'Bugün dua',
                    binlikSayi(_bugunDua),
                    Colors.pinkAccent,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DuaDuvariPage()),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _miniSayac(
                    Icons.menu_book_outlined,
                    'Tamamlanan hatim',
                    binlikSayi(_hatimTamamlanan),
                    Colors.orangeAccent,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HatimHalkalariPage()),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // ---------- 1. DUA KARDEŞLİĞİ ----------
            _baslik("🤲 Dua Kardeşliği", "Dua duvarı, zincirler ve odalar"),
            _modulKart(
              context,
              Icons.campaign_outlined,
              "Canlı Dua Duvarı",
              "Rumuzla veya anonim dua isteği paylaş • tek tıkla dua et",
              Colors.pinkAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaDuvariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.link,
              "Dua Zincirleri",
              '"Gazze için 100.000 Fetih Suresi" • 1, 5 veya 10 üstlen',
              Colors.amber,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaZincirleriPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.chat_bubble_outline,
              "Dua Odaları",
              "Şifa • Borç/Rızık • Sınav • Aile Huzuru • Hidayet",
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaOdalariPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 2. KÜRESEL ÜMMET & DAYANIŞMA ----------
            _baslik("🌍 Küresel Ümmet & Dayanışma", "Canlı harita ve bülten"),
            _modulKart(
              context,
              Icons.public,
              "Canlı Ümmet Haritası",
              "Şu an namaz kılan, zikir çeken milyonlarca kardeşin",
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UmmetHaritasiPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.volunteer_activism,
              "Mazlum Coğrafyalar & Bülten",
              "Filistin, Doğu Türkistan, Yemen, Arakan... manevi destek kartları",
              Colors.deepOrange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MazlumCografyalarPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_stories,
              "İlham Veren Hikayeler",
              "İyilik örnekleri ve yeni Müslümanların hikayeleri",
              Colors.cyan,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IyilikHikayeleriPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 3. ORTAK İBADET & HEDEFLER ----------
            _baslik("📿 Ortak İbadet & Hedefler", "Birlikte ibadet etmenin bereketi"),
            _modulKart(
              context,
              Icons.groups_2_outlined,
              "Hatim Halkaları",
              "30 cüz • 30 kardeş • 24 saatte tamamlanan hatimler",
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HatimHalkalariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_awesome,
              "Milyonluk Zikir Kampanyaları",
              "Ortak salavat, kelime-i tevhid ve istiğfar sayaçları",
              Colors.purpleAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ZikirKampanyalariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.task_alt,
              "Günlük İyilik Görevleri",
              '"Bugün bir yetimi sevindir" • ümmet tamamlanma oranı',
              Colors.lightGreen,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => GunlukIyilikGorevleriPage()),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _miniSayac(IconData ikon, String etiket, String deger, Color renk,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(ikon, color: renk, size: 16),
                SizedBox(width: 6),
                Text(
                  etiket,
                  style: TextStyle(color: Colors.white54, fontSize: 10),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              deger,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
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
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
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

