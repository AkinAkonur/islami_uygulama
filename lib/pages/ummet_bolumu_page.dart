import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
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
import 'ummet/mubarek_sureler_page.dart';
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
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('sb.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: l.t('sb.liveTooltip'),
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
                              l.t('sb.bannerTitle'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              l.t('sb.bannerSub'),
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
                    l.t('sb.hadithMeal'),
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
                    l.t('sb.duaToday'),
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
                    l.t('sb.hatimDone'),
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
              l.t('sb.s1Title'),
              l.t('sb.s1Sub'),
            ),
            _modulKart(
              context,
              Icons.campaign_rounded,
              l.t('sb.mDuaWall'),
              l.t('sb.mDuaWallSub'),
              Colors.pinkAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaDuvariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.link_rounded,
              l.t('sb.mZincir'),
              l.t('sb.mZincirSub'),
              Colors.amber,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaZincirleriPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.chat_bubble_outline_rounded,
              l.t('sb.mOdalar'),
              l.t('sb.mOdalarSub'),
              Colors.teal,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DuaOdalariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_stories_rounded,
              l.t('sb.mSureler'),
              l.t('sb.mSurelerSub'),
              Colors.amber,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => OzelSurelerPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.record_voice_over_rounded,
              l.t('sb.mMubarek'),
              l.t('sb.mMubarekSub'),
              Colors.deepPurpleAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MubarekSurelerPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.groups_2_rounded,
              l.t('sb.mHatim'),
              l.t('sb.mHatimSub'),
              Colors.orange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HatimHalkalariPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 2. YARDIMLAŞMA & İYİLİK ----------
            _baslik(
              l.t('sb.s2Title'),
              l.t('sb.s2Sub'),
            ),
            _modulKart(
              context,
              Icons.volunteer_activism_rounded,
              l.t('sb.mKampanya'),
              l.t('sb.mKampanyaSub'),
              Colors.deepOrange,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => YardimKampanyalariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.calculate_rounded,
              l.t('sb.mZekat'),
              l.t('sb.mZekatSub'),
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ZekatHesaplayiciPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.task_alt_rounded,
              l.t('sb.mIyilik'),
              l.t('sb.mIyilikSub'),
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
              l.t('sb.s4Title'),
              l.t('sb.s4Sub'),
            ),
            _modulKart(
              context,
              Icons.videocam_rounded,
              l.t('sb.mCanli'),
              l.t('sb.mCanliSub'),
              Colors.redAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EtkinliklerPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.public_rounded,
              l.t('sb.mHarita'),
              l.t('sb.mHaritaSub'),
              Colors.green,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => UmmetHaritasiPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 5. İSLAMİ AKIŞ & MANEVİ HALKALAR ----------
            _baslik(
              l.t('sb.s5Title'),
              l.t('sb.s5Sub'),
            ),
            _modulKart(
              context,
              Icons.wb_sunny_rounded,
              l.t('sb.mMesaj'),
              l.t('sb.mMesajSub'),
              Colors.purpleAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IslamiAkisPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.groups_rounded,
              l.t('sb.mHalka'),
              l.t('sb.mHalkaSub'),
              Colors.cyan,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ManeviHalkalarPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_awesome_rounded,
              l.t('sb.mZikir'),
              l.t('sb.mZikirSub'),
              Colors.pink,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ZikirKampanyalariPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.auto_stories_rounded,
              l.t('sb.mHikaye'),
              l.t('sb.mHikayeSub'),
              Colors.lightBlue,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => IyilikHikayeleriPage()),
              ),
            ),
            SizedBox(height: 20),

            // ---------- 6. ÜMMET BİLİNCİ & TARİH/COĞRAFYA ----------
            _baslik(
              l.t('sb.s6Title'),
              l.t('sb.s6Sub'),
            ),
            _modulKart(
              context,
              Icons.map_rounded,
              l.t('sb.mDunya'),
              l.t('sb.mDunyaSub'),
              Colors.indigoAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DunyaUmmetiPage()),
              ),
            ),
            _modulKart(
              context,
              Icons.flag_rounded,
              l.t('sb.mMazlum'),
              l.t('sb.mMazlumSub'),
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

