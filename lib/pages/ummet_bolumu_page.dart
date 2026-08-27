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
import 'ummet/yardim_kampanyalari_page.dart';
import 'ummet/zekat_hesaplayici_page.dart';
import 'ummet/etkinlikler_page.dart';
import 'ummet/manevi_halkalar_page.dart';
import 'ummet/islami_akis_page.dart';
import 'ummet/dunya_ummeti_page.dart';
import 'ummet/ozel_sureler_page.dart';
import '../widgets/kart_sekilleri.dart';

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
            tooltip: "Canlı Yayınlar & Etkinlikler",
            icon: UcdIkon(ikon: Icons.videocam_rounded, renk: Renkler.vurgu),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EtkinliklerPage()),
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
                      UcdIkon(ikon: Icons.groups_rounded, renk: Renkler.vurgu, boyut: 40),
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
                              "Dua • Dayanışma • Yardım • Ortak İbadet",
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
                    Icons.favorite_outline_rounded,
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
                    Icons.menu_book_rounded,
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

            // ---------- 1. KÜRESEL DUA AĞI ----------
            _baslik(
              "🤲 Küresel Dua Ağı",
              "Dua duvarı, zincirler, hatim ve Yâsîn halkaları",
            ),
            _modulKart(
              context,
              Icons.campaign_rounded,
              "Canlı Dua Duvarı",
              "Dünyanın dört bir yanından dua istekleri • Amin ile destekle",
              Colors.pinkAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaDuvariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.link_rounded,
              "Dua Zincirleri",
              '"Gazze için 100.000 Fetih" • 1, 5 veya 10 üstlen',
              Colors.amber,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaZincirleriPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.chat_bubble_outline_rounded,
              "Dua Odaları",
              "Şifa • Borç/Rızık • Sınav • Aile Huzuru • Hidayet",
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaOdalariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_stories_rounded,
              "Seçme Sureler & Dualar",
              "Yâsîn, Mülk, Fâtiha, Cevşen ve daha fazlası • sesli dinleme",
              Colors.amber,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OzelSurelerPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.groups_2_rounded,
              "Hatim & Yâsîn Halkaları",
              "30 cüz, 30 kardeş • ortak hatim ve Yâsîn-i Şerif organizasyonları",
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HatimHalkalariPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 2. YARDIMLAŞMA & İYİLİK ----------
            _baslik(
              "💚 Yardımlaşma & İyilik",
              "Zekât, sadaka ve küresel yardım köprüleri",
            ),
            _modulKart(
              context,
              Icons.volunteer_activism_rounded,
              "Küresel Yardım Kampanyaları",
              "Su kuyusu, gıda, yetim sponsorluğu, kurban ve afet bağışları",
              Colors.deepOrange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => YardimKampanyalariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.calculate_rounded,
              "Zekât & Sadaka Hesaplayıcı",
              "Nisap kontrolü, %2,5 zekât hesabı ve bağış köprüsü",
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ZekatHesaplayiciPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.task_alt_rounded,
              "Günlük İyilik Görevleri",
              '"Bugün bir yetimi sevindir" • ümmet tamamlanma oranı',
              Colors.lightGreen,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => GunlukIyilikGorevleriPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 4. CANLI YAYINLAR & ETKİNLİKLER ----------
            _baslik(
              "📡 Canlı Yayın & Etkinlikler",
              "Mekke, Medine ve dini gün takvimi",
            ),
            _modulKart(
              context,
              Icons.videocam_rounded,
              "Canlı Yayın & Etkinlikler",
              "Mescid-i Haram ve Mescid-i Nebevî 7/24 • kandil programları",
              Colors.redAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EtkinliklerPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.public_rounded,
              "Canlı Ümmet Haritası",
              "Şu an namaz kılan, zikir çeken milyonlarca kardeşin",
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UmmetHaritasiPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 5. İSLAMİ AKIŞ & MANEVİ HALKALAR ----------
            _baslik(
              "💬 İslami Akış & Manevi Halkalar",
              "Günün mesajı ve birlikte gelişim grupları",
            ),
            _modulKart(
              context,
              Icons.wb_sunny_rounded,
              "Günün Mesajı",
              "Her gün yeni bir ayet, hadis ve hikmetli söz",
              Colors.purpleAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IslamiAkisPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.groups_rounded,
              "Manevi Gelişim Halkaları",
              '"Günde 1 Sayfa", "40 Hadis", "Sabah-Akşam zikirleri"',
              Colors.cyan,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ManeviHalkalarPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_awesome_rounded,
              "Milyonluk Zikir Kampanyaları",
              "Ortak salavat, kelime-i tevhid ve istiğfar sayaçları",
              Colors.pink,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ZikirKampanyalariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_stories_rounded,
              "İlham Veren Hikayeler",
              "İyilik örnekleri ve yeni Müslümanların hikayeleri",
              Colors.lightBlue,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IyilikHikayeleriPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 6. ÜMMET BİLİNCİ & TARİH/COĞRAFYA ----------
            _baslik(
              "🌍 Ümmet Bilinci & Coğrafya",
              "Nüfus dağılımı, gelenekler ve mazlum coğrafyalar",
            ),
            _modulKart(
              context,
              Icons.map_rounded,
              "Dünya Ümmeti",
              "Müslüman nüfus dağılımı ve kardeş toplulukların gelenekleri",
              Colors.indigoAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DunyaUmmetiPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.flag_rounded,
              "Mazlum Coğrafyalar & Bülten",
              "Filistin, Doğu Türkistan, Yemen, Arakan... manevi destek kartları",
              Colors.deepOrange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MazlumCografyalarPage()),
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
                UcdIkon(ikon: ikon, renk: renk, boyut: 16),
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
          child: UcdIkon(ikon: ikon, renk: renk, boyut: 24),
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
        trailing: UcdIkon(ikon: Icons.chevron_right_rounded, renk: Colors.white38),
        onTap: onTap,
      ),
    );
  }
}

