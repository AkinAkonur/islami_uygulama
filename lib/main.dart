import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'services/renkler.dart';
import 'services/bildirim_merkezi.dart';
import 'pages/huzurlu_page.dart';
import 'pages/sukur_page.dart';
import 'pages/yorgun_page.dart';
import 'pages/umutlu_page.dart';
import 'pages/kaygili_page.dart';
import 'pages/daha_fazla_page.dart';
import 'pages/dualar_page.dart';
import 'pages/bagis_page.dart';
import 'pages/tesbih_page.dart';
import 'pages/ilham_page.dart';
import 'pages/kible_pusula_page.dart';
import 'pages/ai_tefsir_page.dart';
import 'pages/namazlar_bolumu_page.dart';
import 'pages/kuran_bolumu_page.dart';
import 'pages/ummet_bolumu_page.dart';
import 'pages/ramazan_modu_page.dart';
import 'pages/devam_et_page.dart';
import 'pages/gunluk_gorev_page.dart';
import 'pages/konum_page.dart';
import 'pages/hedef_carki_page.dart';
import 'pages/widget_rehberi_page.dart';
import 'pages/bildirimler_sayfasi.dart';
import 'pages/profil_sayfasi.dart';
import 'services/manevi_store.dart';
import 'screens/namaz_screen.dart';
import 'screens/gorsel_kilinis_screen.dart';
import 'pages/kuran/sure_listesi_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Huzur & Manevi Yolculuk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Renkler.zemin,
        fontFamily: 'Roboto',
      ),
      home: AnaSayfa(),
    );
  }
}

// ===========================================================================
// ANA SAYFA
// ===========================================================================
class AnaSayfa extends StatelessWidget {
  const AnaSayfa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Uçtan Uca Gizlilik Etiketi
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Renkler.seciliYuzey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: Renkler.vurgu,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "UÇTAN UCA GİZLİLİK",
                        style: TextStyle(
                          color: Renkler.vurgu,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Profil ve Tarih Satırı
              Row(
                children: [
                  _ProfilAvatar(),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "18 Safer / 15 Ağustos",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Hicri ${ProfilStore.hicriYil()} · ${DateTime.now().year}",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  _SessizChip(),
                  SizedBox(width: 10),
                  _BildirimZili(),
                  SizedBox(width: 8),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Renkler.cerceve,
                    child: Icon(
                      Icons.settings_outlined,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Duygu Modları
              Text(
                "Bugün nasıl hissediyorsun?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildMoodChip(
                      context,
                      "😊",
                      "Huzurlu",
                      true,
                      HuzurluPage(),
                    ),
                    _buildMoodChip(
                      context,
                      "🙏",
                      "Şükür Dolu",
                      false,
                      SukurPage(),
                    ),
                    _buildMoodChip(
                      context,
                      "😴",
                      "Yorgun",
                      false,
                      YorgunPage(),
                    ),
                    _buildMoodChip(
                      context,
                      "🤲",
                      "Umutlu",
                      false,
                      UmutluPage(),
                    ),
                    _buildMoodChip(
                      context,
                      "😟",
                      "Kaygılı",
                      false,
                      KaygiliPage(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              _VakitKartlari(),
              SizedBox(height: 16),

              RamazanBanner(),
              SizedBox(height: 24),

              // Günlük Maneviyat Modülleri
              Text(
                "Günlük Maneviyat",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.45,
                children: [
                  _ozelModulKarti(
                    context,
                    Icons.play_circle_fill_outlined,
                    "Devam Et",
                    _DevamOzetMetni(),
                    Colors.lightGreenAccent,
                    DevamEtPage(),
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.local_fire_department_outlined,
                    "Günlük Görevler",
                    _GorevOzetMetni(),
                    Colors.deepOrangeAccent,
                    GunlukGorevPage(),
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.mosque_outlined,
                    "Cami & Konum",
                    Text(
                      "Kıble, camiler ve vakitler",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.cyanAccent,
                    KonumPage(),
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.donut_large_outlined,
                    "Hedef Çarkı",
                    Text(
                      "Kuran · Zikir · Namaz",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.amberAccent,
                    HedefCarkiPage(),
                  ),
                  _HizliTesbihKarti(),
                  _ozelModulKarti(
                    context,
                    Icons.headphones_outlined,
                    "Kuran Dinle",
                    Text(
                      "Kuran okuyucuları",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.blueAccent,
                    SureListesiPage(),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Keşfet
              Text(
                "Keşfet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.45,
                children: [
                  _ozelModulKarti(
                    context,
                    Icons.widgets_outlined,
                    "Widget Rehberi",
                    Text(
                      "Vakit widget'ı kurulumu",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.purpleAccent,
                    WidgetRehberiPage(),
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.explore_outlined,
                    "Kıble Pusulası",
                    Text(
                      "Kabe'ye yönü bul",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.tealAccent,
                    KiblePusulaPage(),
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.self_improvement_outlined,
                    "Görsel Kılınış",
                    Text(
                      "Namaz & abdest rehberi",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.greenAccent,
                    GorselKilinisScreen(),
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.radio_button_checked,
                    "Tesbih",
                    Text(
                      "Zikir sayacı",
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.pinkAccent,
                    TesbihPage(),
                  ),
                ],
              ),
              SizedBox(height: 24),

               // Daha Fazla Butonu
               GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => DahaFazlaPage()),
                   );
                 },
                 child: Container(
                   padding: EdgeInsets.symmetric(
                     horizontal: 16,
                     vertical: 8,
                   ),
                   decoration: BoxDecoration(
                     color: Renkler.kart,
                     borderRadius: BorderRadius.circular(20),
                   ),
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text(
                         "Daha Fazla",
                         style: TextStyle(color: Colors.white70, fontSize: 12),
                       ),
                       SizedBox(width: 4),
                       Icon(Icons.chevron_right, color: Colors.white54, size: 16),
                     ],
                   ),
                 ),
               ),
              SizedBox(height: 16),

               // İkonlu Menü (Dualar, Bağış, Tesbih, İlham)
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   _buildIconMenu(
                     context,
                     Icons.pan_tool_alt_outlined,
                     "Dualar",
                     Colors.orangeAccent,
                     DualarPage(),
                   ),
                   _buildIconMenu(
                     context,
                     Icons.dark_mode_outlined,
                     "Bağış",
                     Colors.amber,
                     BagisPage(),
                   ),
                   _buildIconMenu(
                     context,
                     Icons.radio_button_checked,
                     "Tesbih",
                     Colors.pinkAccent,
                     TesbihPage(),
                   ),
                   _buildIconMenu(
                     context,
                     Icons.menu_book_outlined,
                     "İlham",
                     Colors.orange,
                     IlhamPage(),
                   ),
                 ],
               ),
              SizedBox(height: 24),

               // Kıble Bölümü
               _buildSectionTitle("Kıble"),
               SizedBox(height: 12),
               GestureDetector(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => KiblePusulaPage()),
                   );
                 },
                 child: Container(
                   padding: EdgeInsets.all(20),
                   decoration: BoxDecoration(
                     color: Renkler.yuzey,
                     borderRadius: BorderRadius.circular(24),
                     border: Border.all(color: Renkler.cerceve2, width: 1),
                   ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           Text(
                             "Kıble Yönü",
                             style: TextStyle(
                               color: Renkler.vurgu,
                               fontSize: 12,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           SizedBox(height: 4),
                           Text(
                             "Kâbe'ye Doğru",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           SizedBox(height: 12),
                           Container(
                             padding: EdgeInsets.symmetric(
                               horizontal: 12,
                               vertical: 6,
                             ),
                             decoration: BoxDecoration(
                               color: Renkler.cerceve2,
                               borderRadius: BorderRadius.circular(16),
                             ),
                             child: Row(
                               children: [
                                 Icon(
                                   Icons.explore_outlined,
                                   color: Renkler.vurgu,
                                   size: 16,
                                 ),
                                 SizedBox(width: 6),
                                 Text(
                                   "154° GD",
                                   style: TextStyle(
                                     color: Renkler.vurgu,
                                     fontSize: 12,
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                               ],
                              ),
                            ),
                          ],
                        ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Renkler.cerceve,
                            shape: BoxShape.circle,
                          ),
                         child: Center(
                           child: Icon(
                             Icons.account_balance,
                             color: Colors.white24,
                             size: 40,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(height: 24),

               // Günün Ayeti (Her gün otomatik değişir)
               Builder(
                 builder: (context) {
                   final now = DateTime.now();
                   final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
                   final verses = [
                     {
                       "arabic": "إِنَّ مَعَ الْعُسْرِ يُسْرًا",
                       "translation": "Şüphesiz her zorlukla beraber bir kolaylık vardır.",
                       "reference": "İnşirah Suresi, 6. Ayet"
                     },
                     {
                       "arabic": "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
                       "translation": "Bilesiniz ki, kalpler ancak Allah’ı anmakla huzur bulur.",
                       "reference": "Ra'd Suresi, 28. Ayet"
                     },
                     {
                       "arabic": "فَاذْكُرُونِي أَذْكُرْكُمْ",
                       "translation": "Öyleyse beni anın ki ben de sizi anayım.",
                       "reference": "Bakara Suresi, 152. Ayet"
                     },
                     {
                       "arabic": "لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ",
                       "translation": "Andolsun, eğer şükrederseniz elbette size nimetimi artırırım.",
                       "reference": "İbrahim Suresi, 7. Ayet"
                     },
                     {
                       "arabic": "وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ",
                       "translation": "Kim Allah’a tevekkül ederse, O, kendisine yeter.",
                       "reference": "Talak Suresi, 3. Ayet"
                     },
                     {
                       "arabic": "لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ",
                       "translation": "Allah’ın rahmetinden ümidinizi kesmeyin.",
                       "reference": "Zümer Suresi, 53. Ayet"
                     },
                     {
                       "arabic": "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا",
                       "translation": "Allah, hiç kimseye gücünün üstünde bir yük yüklemez.",
                       "reference": "Bakara Suresi, 286. Ayet"
                     },
                   ];
                   final todayVerse = verses[dayOfYear % verses.length];

                   return Container(
                     padding: EdgeInsets.all(20),
                     decoration: BoxDecoration(
                       color: Renkler.kart,
                       borderRadius: BorderRadius.circular(24),
                       border: Border.all(color: Renkler.cerceve, width: 1),
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.stretch,
                       children: [
                         Row(
                           children: [
                             Icon(
                               Icons.menu_book_outlined,
                               color: Renkler.vurgu,
                               size: 20,
                             ),
                             SizedBox(width: 8),
                             Text(
                               "Günün Ayeti",
                               style: TextStyle(
                                 color: Renkler.vurgu,
                                 fontSize: 14,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             Spacer(),
                             Icon(
                               Icons.share_outlined,
                               color: Colors.white54,
                               size: 20,
                             ),
                           ],
                         ),
                         SizedBox(height: 24),
                         Text(
                           todayVerse["arabic"]!,
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             color: Colors.white,
                             fontSize: 26,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         SizedBox(height: 24),
                         Text(
                           '"${todayVerse["translation"]!}"',
                           style: TextStyle(
                             color: Colors.white70,
                             fontSize: 14,
                             fontStyle: FontStyle.italic,
                             height: 1.5,
                           ),
                         ),
                         SizedBox(height: 16),
                         Text(
                           todayVerse["reference"]!,
                           textAlign: TextAlign.right,
                           style: TextStyle(
                             color: Renkler.vurgu,
                             fontSize: 12,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                       ],
                     ),
                   );
                 },
               ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Renkler.navBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Renkler.vurgu,
        unselectedItemColor: Colors.white54,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NamazlarBolumuPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AiTefsirPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KuranBolumuPage()),
            );
          } else if (index == 4) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UmmetBolumuPage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Ana Sayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Namazlar",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: "AI"),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: "Kur'an",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups_outlined),
            label: "Ümmet",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_outline),
            label: "Videolar",
          ),
        ],
      ),
    );
  }

  Widget _buildMoodChip(
    BuildContext context,
    String emoji,
    String text,
    bool isSelected,
    Widget targetPage,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Renkler.seciliYuzey : Renkler.kart,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Renkler.vurgu : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(emoji, style: TextStyle(fontSize: 16)),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Renkler.vurgu : Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconMenu(
    BuildContext context,
    IconData icon,
    String label,
    Color iconColor,
    Widget targetPage,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// ===========================================================================
// VAKİT KARTLARI (Canlı Yaklaşan Vakit + Sıradaki Vakit)
// ===========================================================================
class _VakitBilgisi {
  final String ad;
  final String saat;
  final IconData ikon;
  final int dakika;

  const _VakitBilgisi(this.ad, this.saat, this.ikon, this.dakika);
}

const List<_VakitBilgisi> _gunVakitleri = [
  _VakitBilgisi("İmsak", "04:12", Icons.wb_twilight, 4 * 60 + 12),
  _VakitBilgisi("Güneş", "05:48", Icons.wb_sunny, 5 * 60 + 48),
  _VakitBilgisi("Öğle", "13:05", Icons.wb_sunny, 13 * 60 + 5),
  _VakitBilgisi("İkindi", "16:45", Icons.brightness_5, 16 * 60 + 45),
  _VakitBilgisi("Akşam", "20:17", Icons.wb_twilight, 20 * 60 + 17),
  _VakitBilgisi("Yatsı", "21:50", Icons.nights_stay, 21 * 60 + 50),
];

// ===========================================================================
// PROFİL, BİLDİRİM ZİLİ VE SESSİZ VAKİT ÇİPİ
// ===========================================================================
class _ProfilAvatar extends StatefulWidget {
  @override
  State<_ProfilAvatar> createState() => _ProfilAvatarState();
}

class _ProfilAvatarState extends State<_ProfilAvatar> {
  Uint8List? _resim;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final resim = await ProfilStore.resimOku();
    if (mounted) setState(() => _resim = resim);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ProfilSayfasi()),
        ).then((_) => _yukle());
      },
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Renkler.cerceve,
        backgroundImage: _resim != null ? MemoryImage(_resim!) : null,
        child: _resim == null
            ? const Icon(Icons.person_outline, color: Colors.white70)
            : null,
      ),
    );
  }
}

class _BildirimZili extends StatefulWidget {
  @override
  State<_BildirimZili> createState() => _BildirimZiliState();
}

class _BildirimZiliState extends State<_BildirimZili> {
  int _sayi = 0;

  @override
  void initState() {
    super.initState();
    BildirimMerkezi.rozet.addListener(_rozetDegisti);
    _yukle();
  }

  @override
  void dispose() {
    BildirimMerkezi.rozet.removeListener(_rozetDegisti);
    super.dispose();
  }

  void _rozetDegisti() {
    if (mounted) setState(() => _sayi = BildirimMerkezi.rozet.value);
  }

  Future<void> _yukle() async {
    await BildirimMerkezi.guncelle();
    await BildirimMerkezi.rozetGuncelle();
    if (mounted) setState(() => _sayi = BildirimMerkezi.rozet.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BildirimlerSayfasi()),
        ).then((_) => _yukle());
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Renkler.cerceve,
            child: const Icon(Icons.notifications_none, color: Colors.white70, size: 20),
          ),
          if (_sayi > 0)
            Positioned(
              right: -6,
              top: -6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Renkler.zemin, width: 1.5),
                ),
                child: Text(
                  '$_sayi',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SessizChip extends StatefulWidget {
  @override
  State<_SessizChip> createState() => _SessizChipState();
}

class _SessizChipState extends State<_SessizChip> {
  bool _sessiz = false;

  @override
  void initState() {
    super.initState();
    BildirimMerkezi.sessizDurumu().then((s) {
      if (mounted) setState(() => _sessiz = s);
    });
  }

  Future<void> _degistir() async {
    final yeni = await BildirimMerkezi.sessizDegistir();
    if (mounted) setState(() => _sessiz = yeni);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _degistir,
      child: Tooltip(
        message: 'Sessiz vakit 21:00 - 06:00 · tek dokunuşla sessize al',
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          decoration: BoxDecoration(
            color: _sessiz
                ? Renkler.vurgu.withValues(alpha: 0.35)
                : Renkler.seciliYuzey,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _sessiz
                  ? Renkler.vurgu.withValues(alpha: 0.7)
                  : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _sessiz ? Icons.notifications_off : Icons.volume_off,
                color: _sessiz ? Renkler.vurgu : Colors.white54,
                size: 12,
              ),
              const SizedBox(width: 4),
              Text(
                _sessiz ? 'Sessiz' : '21-06',
                style: TextStyle(
                  color: _sessiz ? Renkler.vurgu : Colors.white54,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// GÜNLÜK MANEVİYAT MODÜL KARTLARI
// ===========================================================================
Widget _ozelModulKarti(
  BuildContext context,
  IconData ikon,
  String baslik,
  Widget altIcerik,
  Color renk,
  Widget hedefSayfa,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => hedefSayfa));
    },
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, color: renk, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  baslik,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          altIcerik,
        ],
      ),
    ),
  );
}

class _DevamOzetMetni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: ManeviStore.sonOkunanAyet(),
      builder: (context, snp) {
        final metin =
            (snp.hasData && snp.data!.isNotEmpty) ? snp.data! : 'Bakara 255';
        return Text(
          'Son: $metin',
          style: TextStyle(color: Colors.white54, fontSize: 11),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}

class _GorevOzetMetni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: ManeviStore.seriOku(),
      builder: (context, snp) {
        return Text(
          '🔥 ${snp.data ?? 0} gün seri',
          style: TextStyle(color: Colors.white54, fontSize: 11),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }
}

class _HizliTesbihKarti extends StatefulWidget {
  @override
  State<_HizliTesbihKarti> createState() => _HizliTesbihKartiState();
}

class _HizliTesbihKartiState extends State<_HizliTesbihKarti> {
  int? _sayi;

  @override
  void initState() {
    super.initState();
    ManeviStore.tesbihSayisi().then((s) {
      if (mounted) setState(() => _sayi = s);
    });
  }

  Future<void> _arttir() async {
    final s = await ManeviStore.tesbihEkle(1);
    if (mounted) setState(() => _sayi = s);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TesbihPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.radio_button_checked,
                    color: Colors.pinkAccent, size: 22),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Hızlı Tesbih',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  '${_sayi ?? 0}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: _arttir,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '+1',
                      style: TextStyle(
                        color: Renkler.vurgu,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _VakitKartlari extends StatefulWidget {
  const _VakitKartlari();

  @override
  State<_VakitKartlari> createState() => _VakitKartlariState();
}

class _VakitKartlariState extends State<_VakitKartlari> {
  Timer? _sureci;

  @override
  void initState() {
    super.initState();
    _sureci = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _sureci?.cancel();
    super.dispose();
  }

  String _sureYaz(int sn) {
    String iki(int n) => n.toString().padLeft(2, '0');
    final s = sn % 60;
    final dk = (sn ~/ 60) % 60;
    final sa = sn ~/ 3600;
    return '${iki(sa)}:${iki(dk)}:${iki(s)}';
  }

  (int kalan, double ilerleme, _VakitBilgisi siradaki, _VakitBilgisi ondanSonraki)
      _vakitHesapla(DateTime simdi) {
    final dakika = simdi.hour * 60 + simdi.minute;
    final saniye = dakika * 60 + simdi.second;

    int sonrakiIndex = _gunVakitleri.indexWhere((v) => v.dakika > dakika);
    if (sonrakiIndex == -1) sonrakiIndex = 0;

    final siradaki = _gunVakitleri[sonrakiIndex];
    final ondanSonraki =
        _gunVakitleri[(sonrakiIndex + 1) % _gunVakitleri.length];
    final oncekiIndex =
        (sonrakiIndex - 1 + _gunVakitleri.length) % _gunVakitleri.length;
    final onceki = _gunVakitleri[oncekiIndex];

    final bool geceGecisi = sonrakiIndex == 0;
    final int baslangicSn = onceki.dakika * 60;
    final int bitisSn = geceGecisi
        ? (_gunVakitleri.first.dakika + 1440) * 60
        : siradaki.dakika * 60;
    final double ilerleme =
        ((saniye - baslangicSn) / (bitisSn - baslangicSn)).clamp(0.0, 1.0);
    final int kalan = bitisSn - saniye;

    return (kalan, ilerleme, siradaki, ondanSonraki);
  }

  void _vakitlereGit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NamazScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final (kalan, ilerleme, siradaki, ondanSonraki) =
        _vakitHesapla(DateTime.now());
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 65,
            child: _yaklasanKart(siradaki, kalan, ilerleme),
          ),
          SizedBox(width: 12),
          Expanded(
            flex: 35,
            child: _siradakiKart(ondanSonraki),
          ),
        ],
      ),
    );
  }

  Widget _yaklasanKart(_VakitBilgisi v, int kalan, double ilerleme) {
    return GestureDetector(
      onTap: _vakitlereGit,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Renkler.bannerUst, Renkler.bannerAlt],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Renkler.vurgu.withValues(alpha: 0.22),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -16,
              top: -14,
              child: Icon(
                v.ikon,
                size: 104,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.8),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "YAKLAŞAN VAKİT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(
                    v.saat,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "${v.ad} Namazı",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _sureYaz(kalan),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 27,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                              fontFeatures: [
                                const FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Text(
                        "kaldı",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: ilerleme,
                      backgroundColor: Colors.black.withValues(alpha: 0.25),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _siradakiKart(_VakitBilgisi v) {
    return GestureDetector(
      onTap: _vakitlereGit,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Renkler.kart, Renkler.yuzey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Renkler.cerceve2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "SIRADAKİ",
              style: TextStyle(
                color: Colors.white38,
                fontSize: 9,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Renkler.vurgu.withValues(alpha: 0.14),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Renkler.vurgu.withValues(alpha: 0.35),
                ),
              ),
              child: Icon(v.ikon, color: Renkler.vurgu, size: 22),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  v.ad,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  v.saat,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// DUYGU YOLCULUĞU SAYFASI (Mod Detayı)
// ===========================================================================
class DuyguYolculukSayfasi extends StatelessWidget {
  final String moodType;
  const DuyguYolculukSayfasi({super.key, required this.moodType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "$moodType Modu",
          style: TextStyle(color: Renkler.vurgu),
        ),
      ),
      body: Center(
        child: Text(
          "$moodType modu içeriği burada yer alıyor.",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
