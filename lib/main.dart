import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workmanager/workmanager.dart';
import 'l10n/app_localizations.dart';
import 'l10n/dil_hizmetleri.dart';
import 'services/renkler.dart';
import 'services/ayarlar_store.dart';
import 'services/bildirim_merkezi.dart';
import 'services/vakit_servisi.dart';
import 'services/gercek_bildirimler.dart';
import 'pages/huzurlu_page.dart';
import 'pages/sukur_page.dart';
import 'pages/yorgun_page.dart';
import 'pages/umutlu_page.dart';
import 'pages/kaygili_page.dart';
import 'pages/daha_fazla_page.dart';
import 'pages/dualar_page.dart';
import 'pages/bagis_page.dart';
import 'pages/tesbih_page.dart';
import 'pages/cuzler_page.dart';
import 'pages/ilham_page.dart';
import 'pages/kible_pusula_page.dart';
import 'pages/ai_tefsir_page.dart';
import 'pages/kuran_bolumu_page.dart';
import 'pages/ummet_bolumu_page.dart';
import 'pages/namazlar_bolumu_page.dart';
import 'pages/ramazan_modu_page.dart';
import 'pages/devam_et_page.dart';
import 'pages/gunluk_gorev_page.dart';
import 'pages/konum_page.dart';
import 'pages/hedef_carki_page.dart';
import 'pages/widget_rehberi_page.dart';
import 'pages/bildirimler_sayfasi.dart';
import 'pages/profil_sayfasi.dart';
import 'services/manevi_store.dart';
import 'services/canli_yayin_konfigurasyonu.dart';
import 'services/dini_gunler_servisi.dart';
import 'services/radyo_oynatici_store.dart';
import 'widgets/radyo_mini_oynatici.dart';
import 'widgets/kart_sekilleri.dart';
import 'widgets/ucd_kart.dart';
import 'screens/namaz_screen.dart';
import 'screens/gorsel_kilinis_screen.dart';
import 'pages/kuran/sure_listesi_page.dart';
import 'pages/soru_cevap/gunun_sorusu_karti.dart';
import 'pages/dua_kardesligi/dua_kardesligi_store.dart';
import 'screens/settings_page.dart';

// Workmanager arka plan görevi: uygulama kapalıyken bile namaz vakitleri
// bildirimlerinin güncel kalması için günde bir kez zamanlamayı tazeler.
@pragma('vm:entry-point')
void bildirimleriTazele() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await GercekBildirimler.kurulum();
      await GercekBildirimler.planla();
    } catch (_) {
      // Arka plan hataları sessizce yutulur; bir sonraki tazeleme tekrar dener.
    }
    return true;
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AyarlarStore.baslat();
  // İlk açılışta kayıtlı tercih yoksa cihaz dili otomatik algılanır.
  await DilHizmetleri.baslat();
  await DuaKardesligiStore.yukle();
  // Canlı yayın kaynakları uzak konfigürasyondan dinamik olarak alınır
  // (Firebase Remote Config alternatifi; kaynak değişirse Store güncellemesi gerekmez).
  await CanliYayinKonfigurasyonu.baslat();
  // Radyo oynatıcıyı uygulama genelinde başlat: başka sayfalara geçilse bile
  // Dini Radyo & İlahi akışı kesintisiz devam eder, alt çubukta mini oynatıcı görünür.
  await RadyoOynaticiStore.baslat();
  // Dini günler (Ramazan, kandiller) Diyanet resmî takvimine dayanır ve
  // uzak yapılandırmayla otomatik tazelenir; ulaşılamazsa gömülü tablo kullanılır.
  DiniGunlerServisi.baslat();
  // Namaz bildirimleri: arka plan görevini kaydet (yalnızca Android).
  // Uygulama kapalıyken de günde bir kez bildirimler yeniden planlanır.
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await Workmanager().initialize(bildirimleriTazele);
    await Workmanager().registerPeriodicTask(
      'namaz-bildirim-tazeleme',
      'bildirimleriTazele',
      frequency: const Duration(hours: 24),
      initialDelay: const Duration(minutes: 10),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: DilHizmetleri.aktifDil,
      builder: (context, dil, _) => ValueListenableBuilder<String?>(
        valueListenable: AyarlarStore.vurguKod,
        builder: (context, _, _) => ValueListenableBuilder<bool>(
          valueListenable: AyarlarStore.karanlikMod,
          builder: (context, karanlik, _) => MaterialApp(
            title: 'Huzur & Manevi Yolculuk',
            debugShowCheckedModeBanner: false,
            locale: dil,
            supportedLocales: DilHizmetleri.desteklenenler,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: const Color(0xFFF3F6F2),
              fontFamily: 'Roboto',
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Renkler.zemin,
              fontFamily: 'Roboto',
            ),
            themeMode: karanlik ? ThemeMode.dark : ThemeMode.light,
            home: AnaSayfa(),
          ),
        ),
      ),
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
    final l = AppLocalizations.of(context);
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                        l.t('h.priv'),
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
                          style: TextStyle(color: Colors.white, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Hicri ${ProfilStore.hicriYil()} · ${DateTime.now().year}",
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  _SessizChip(),
                  SizedBox(width: 10),
                  _BildirimZili(),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AyarlarSayfasi(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Renkler.cerceve,
                      child: UcdIkon(
                        ikon: Icons.settings_outlined,
                        renk: Colors.white70,
                        boyut: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Duygu Modları
              Text(
                l.t('h.how'),
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
                      l.t('m.huzurlu'),
                      true,
                      HuzurluPage(),
                    ),
                    _buildMoodChip(
                      context,
                      "🙏",
                      l.t('m.sukurlu'),
                      false,
                      SukurPage(),
                    ),
                    _buildMoodChip(
                      context,
                      "😴",
                      l.t('m.yorgun'),
                      false,
                      YorgunPage(),
                    ),
                    _buildMoodChip(
                      context,
                      "🤲",
                      l.t('m.umutlu'),
                      false,
                      UmutluPage(),
                    ),
                    _buildMoodChip(
                      context,
                      "😟",
                      l.t('m.kaygili'),
                      false,
                      KaygiliPage(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              _VakitKartlari(),
              SizedBox(height: 16),

              UcdKart(
                radius: 18,
                sekil: KartSekli.kose,
                child: RamazanBanner(),
              ),
              SizedBox(height: 24),

              // Günlük Maneviyat Modülleri
              Text(
                l.t('h.daily'),
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
                childAspectRatio: 2.7,
                children: [
                  _ozelModulKarti(
                    context,
                    Icons.play_circle_fill_outlined,
                    l.t('mod.devam'),
                    _DevamOzetMetni(),
                    Colors.lightGreenAccent,
                    DevamEtPage(),
                    kartSekli: KartSekli.yuvar,
                    plakaSekli: PlakaSekli.daire,
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.local_fire_department_outlined,
                    l.t('mod.gorev'),
                    _GorevOzetMetni(),
                    Colors.deepOrangeAccent,
                    GunlukGorevPage(),
                    kartSekli: KartSekli.kose,
                    plakaSekli: PlakaSekli.baklava,
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.mosque_outlined,
                    l.t('mod.cami'),
                    Text(
                      l.t('mod.camiAlt'),
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.cyanAccent,
                    KonumPage(),
                    kartSekli: KartSekli.klasik,
                    plakaSekli: PlakaSekli.mihrap,
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.donut_large_outlined,
                    l.t('mod.carki'),
                    Text(
                      l.t('mod.carkiAlt'),
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.amberAccent,
                    HedefCarkiPage(),
                    kartSekli: KartSekli.yuvar,
                    plakaSekli: PlakaSekli.daire,
                  ),
                  _HizliTesbihKarti(),
                  _ozelModulKarti(
                    context,
                    Icons.headphones_outlined,
                    l.t('mod.dinle'),
                    Text(
                      l.t('mod.dinleAlt'),
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.blueAccent,
                    SureListesiPage(),
                    kartSekli: KartSekli.kose,
                    plakaSekli: PlakaSekli.altigen,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Keşfet
              Text(
                l.t('h.discover'),
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
                childAspectRatio: 2.7,
                children: [
                  _ozelModulKarti(
                    context,
                    Icons.widgets_outlined,
                    l.t('mod.widget'),
                    Text(
                      l.t('mod.widgetAlt'),
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.purpleAccent,
                    WidgetRehberiPage(),
                    kartSekli: KartSekli.klasik,
                    plakaSekli: PlakaSekli.yuvarlakKare,
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.explore_outlined,
                    l.t('mod.pusula'),
                    Text(
                      l.t('mod.pusulaAlt'),
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.tealAccent,
                    KiblePusulaPage(),
                    kartSekli: KartSekli.kose,
                    plakaSekli: PlakaSekli.baklava,
                  ),
                  _ozelModulKarti(
                    context,
                    Icons.self_improvement_outlined,
                    l.t('mod.gorsel'),
                    Text(
                      l.t('mod.gorselAlt'),
                      style: TextStyle(color: Colors.white54, fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Colors.greenAccent,
                    GorselKilinisScreen(),
                    kartSekli: KartSekli.yuvar,
                    plakaSekli: PlakaSekli.altigen,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Daha Fazla Butonu
              UcdKart(
                radius: 20,
                maxTilt: 0.09,
                sekil: KartSekli.kose,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DahaFazlaPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Renkler.kart,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l.t('h.more'),
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white54,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // İkonlu Menü (Dualar, Bağış, Cüz'ler, İlham)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIconMenu(
                    context,
                    Icons.pan_tool_alt_outlined,
                    l.t('h.duas'),
                    Colors.orangeAccent,
                    DualarPage(),
                    plakaSekli: PlakaSekli.daire,
                    kartSekli: KartSekli.yuvar,
                  ),
                  _buildIconMenu(
                    context,
                    Icons.dark_mode_outlined,
                    l.t('h.donate'),
                    Colors.amber,
                    BagisPage(),
                    plakaSekli: PlakaSekli.altigen,
                    kartSekli: KartSekli.klasik,
                  ),
                  _buildIconMenu(
                    context,
                    Icons.filter_frames,
                    l.t('h.cuzler'),
                    Colors.tealAccent,
                    CuzlerPage(),
                    plakaSekli: PlakaSekli.yuvarlakKare,
                    kartSekli: KartSekli.yuvar,
                  ),
                  _buildIconMenu(
                    context,
                    Icons.menu_book_outlined,
                    l.t('h.ilham'),
                    Colors.orange,
                    IlhamPage(),
                    plakaSekli: PlakaSekli.baklava,
                    kartSekli: KartSekli.klasik,
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Kıble Bölümü
              _buildSectionTitle(l.t('h.qiblaTitle')),
              SizedBox(height: 12),
              UcdKart(
                radius: 16,
                sekil: KartSekli.yuvar,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KiblePusulaPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Renkler.yuzey,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Renkler.cerceve2, width: 1),
                    ),
                    child: Row(
                      children: [
                        SekilPlaka(
                          sekil: PlakaSekli.mihrap,
                          ikon: Icons.explore_outlined,
                          ikonRenk: Renkler.vurgu,
                          boyut: 34,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.t('h.qiblaDir'),
                                style: TextStyle(
                                  color: Renkler.vurgu,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l.t('h.kaaba'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              const _KibleOzeti(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.white38,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Günün Sorusu (her gün değişir)
              UcdKart(
                radius: 16,
                sekil: KartSekli.yuvar,
                child: GununSorusuKarti(),
              ),
              SizedBox(height: 16),

              // Günün Ayeti (Her gün otomatik değişir)
              Builder(
                builder: (context) {
                  final now = DateTime.now();
                  final dayOfYear = now
                      .difference(DateTime(now.year, 1, 1))
                      .inDays;
                  final verses = [
                    {
                      "arabic": "إِنَّ مَعَ الْعُسْرِ يُسْرًا",
                      "translation":
                          "Şüphesiz her zorlukla beraber bir kolaylık vardır.",
                      "reference": "İnşirah Suresi, 6. Ayet",
                    },
                    {
                      "arabic": "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
                      "translation":
                          "Bilesiniz ki, kalpler ancak Allah’ı anmakla huzur bulur.",
                      "reference": "Ra'd Suresi, 28. Ayet",
                    },
                    {
                      "arabic": "فَاذْكُرُونِي أَذْكُرْكُمْ",
                      "translation": "Öyleyse beni anın ki ben de sizi anayım.",
                      "reference": "Bakara Suresi, 152. Ayet",
                    },
                    {
                      "arabic": "لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ",
                      "translation":
                          "Andolsun, eğer şükrederseniz elbette size nimetimi artırırım.",
                      "reference": "İbrahim Suresi, 7. Ayet",
                    },
                    {
                      "arabic":
                          "وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ",
                      "translation":
                          "Kim Allah’a tevekkül ederse, O, kendisine yeter.",
                      "reference": "Talak Suresi, 3. Ayet",
                    },
                    {
                      "arabic": "لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ",
                      "translation": "Allah’ın rahmetinden ümidinizi kesmeyin.",
                      "reference": "Zümer Suresi, 53. Ayet",
                    },
                    {
                      "arabic":
                          "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا",
                      "translation":
                          "Allah, hiç kimseye gücünün üstünde bir yük yüklemez.",
                      "reference": "Bakara Suresi, 286. Ayet",
                    },
                  ];
                  final ayetIndex = dayOfYear % verses.length;
                  final todayVerse = verses[ayetIndex];

                  return UcdKart(
                    radius: 16,
                    sekil: KartSekli.kose,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Renkler.kart,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Renkler.cerceve, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              UcdIkon(
                                ikon: Icons.menu_book_outlined,
                                renk: Renkler.vurgu,
                                boyut: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                l.t('h.ayet'),
                                style: TextStyle(
                                  color: Renkler.vurgu,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              UcdIkon(
                                ikon: Icons.share_outlined,
                                renk: Colors.white54,
                                boyut: 18,
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Text(
                            todayVerse["arabic"]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 14),
                          Text(
                            '"${l.t('ay.${ayetIndex + 1}')}"',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontStyle: FontStyle.italic,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            l.t('ref.${ayetIndex + 1}'),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Renkler.vurgu,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Radyo çalarken tüm sayfalarda kesintisiz görünen mini oynatıcı.
          const RadyoMiniOynatici(),
          BottomNavigationBar(
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
                label: l.t('h.navHome'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: l.t('h.navNamaz'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome),
                label: l.t('h.navAi'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book_outlined),
                label: l.t('h.navKuran'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined),
                label: l.t('h.navUmmet'),
              ),
            ],
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
    final moodKart = GestureDetector(
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
    return UcdKart(
      radius: 20,
      maxTilt: 0.09,
      sekil: KartSekli.yuvar,
      child: moodKart,
    );
  }

  Widget _buildIconMenu(
    BuildContext context,
    IconData icon,
    String label,
    Color iconColor,
    Widget targetPage, {
    KartSekli kartSekli = KartSekli.klasik,
    PlakaSekli plakaSekli = PlakaSekli.yuvarlakKare,
  }) {
    final ikonMenu = GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Column(
        children: [
          UcdKart(
            radius: 20,
            maxTilt: 0.09,
            sekil: kartSekli,
            child: SekilPlaka(
              sekil: plakaSekli,
              ikon: icon,
              ikonRenk: iconColor,
              boyut: 60,
            ),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
    return UcdKart(radius: 20, maxTilt: 0.09, child: ikonMenu);
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
class _KibleOzeti extends StatefulWidget {
  const _KibleOzeti();

  @override
  State<_KibleOzeti> createState() => _KibleOzetiState();
}

class _KibleOzetiState extends State<_KibleOzeti> {
  String _metin = '—';

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final k = await VakitServisi.koordinatOku();
    if (!mounted) return;
    setState(() {
      if (k == null) {
        _metin = AppLocalizations.of(context).t('h.locate');
      } else {
        final aci = VakitServisi.kibleAcisi(k.$1, k.$2);
        _metin = '${aci.round()}° ${VakitServisi.yonEtiketi(aci)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _metin,
      style: TextStyle(
        color: Renkler.vurgu,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _VakitBilgisi {
  final String ad;
  final String saat;
  final IconData ikon;
  final int dakika;

  const _VakitBilgisi(this.ad, this.saat, this.ikon, this.dakika);
}

IconData _vakitIkonu(String ad) {
  switch (ad) {
    case 'Güneş':
    case 'Öğle':
      return Icons.wb_sunny;
    case 'İkindi':
      return Icons.brightness_5;
    case 'Akşam':
      return Icons.wb_twilight;
    case 'Yatsı':
      return Icons.nights_stay;
    default:
      return Icons.wb_twilight;
  }
}

_VakitBilgisi _servisVaktiniCevir(VakitBilgisi v) =>
    _VakitBilgisi(v.ad, v.saatYaz, _vakitIkonu(v.ad), v.dakikaToplam);

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
            child: UcdIkon(
              ikon: Icons.notifications_none,
              renk: Colors.white70,
              boyut: 20,
            ),
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
  Widget hedefSayfa, {
  KartSekli kartSekli = KartSekli.klasik,
  PlakaSekli plakaSekli = PlakaSekli.yuvarlakKare,
}) {
  return UcdKart(
    radius: 16,
    maxTilt: 0.09,
    sekil: kartSekli,
    child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => hedefSayfa));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: Row(
          children: [
            SekilPlaka(
              sekil: plakaSekli,
              ikon: ikon,
              ikonRenk: renk,
              boyut: 34,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    baslik,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  DefaultTextStyle(
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    child: altIcerik,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: Colors.white38, size: 16),
          ],
        ),
      ),
    ),
  );
}

class _DevamOzetMetni extends StatefulWidget {
  @override
  State<_DevamOzetMetni> createState() => _DevamOzetMetniState();
}

class _DevamOzetMetniState extends State<_DevamOzetMetni> {
  @override
  void initState() {
    super.initState();
    ManeviStore.sonKuranKonumu();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<KuranKonumu>(
      valueListenable: ManeviStore.kuranKonumu,
      builder: (context, konum, _) {
        return Text(
          '${AppLocalizations.of(context).t('h.last')} ${konum.gosterim}',
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
          '🔥 ${AppLocalizations.of(context).t('h.streak').replaceAll('{n}', '${snp.data ?? 0}')}',
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
    final l = AppLocalizations.of(context);
    return UcdKart(
      radius: 16,
      maxTilt: 0.09,
      sekil: KartSekli.kose,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => TesbihPage()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Renkler.kart,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Renkler.cerceve),
          ),
          child: Row(
            children: [
              SekilPlaka(
                sekil: PlakaSekli.daire,
                ikon: Icons.radio_button_checked,
                ikonRenk: Colors.pinkAccent,
                boyut: 34,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.t('mod.hizli'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_sayi ?? 0}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              InkWell(
                onTap: _arttir,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Renkler.seciliYuzey,
                    borderRadius: BorderRadius.circular(10),
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
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, color: Colors.white38, size: 16),
            ],
          ),
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
  List<_VakitBilgisi> _vakitler = const [];
  String _metotEtiketi = 'Diyanet (Türkiye)';

  List<_VakitBilgisi> get _liste =>
      _vakitler.isNotEmpty ? _vakitler : _gunVakitleri;

  @override
  void initState() {
    super.initState();
    _bastaBaslat();
    _sureci = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
    VakitServisi.vakitGuncellendi.addListener(_vakitleriYukle);
  }

  Future<void> _bastaBaslat() async {
    await VakitServisi.ilkkonum();
    await GercekBildirimler.kurulum();
    await GercekBildirimler.planla();
    await _vakitleriYukle();
  }

  Future<void> _vakitleriYukle() async {
    final guncel = await VakitServisi.gunlukVakitler();
    final metotKod = await VakitServisi.aktifMetotKodu();
    if (!mounted) return;
    setState(() {
      _vakitler = guncel.map(_servisVaktiniCevir).toList();
      _metotEtiketi = AyarlarStore.metotEtiketi(metotKod);
    });
  }

  @override
  void dispose() {
    _sureci?.cancel();
    VakitServisi.vakitGuncellendi.removeListener(_vakitleriYukle);
    super.dispose();
  }

  String _sureYaz(int sn) {
    String iki(int n) => n.toString().padLeft(2, '0');
    final s = sn % 60;
    final dk = (sn ~/ 60) % 60;
    final sa = sn ~/ 3600;
    return '${iki(sa)}:${iki(dk)}:${iki(s)}';
  }

  (
    int kalan,
    double ilerleme,
    _VakitBilgisi siradaki,
    _VakitBilgisi ondanSonraki,
  )
  _vakitHesapla(DateTime simdi) {
    final dakika = simdi.hour * 60 + simdi.minute;
    final saniye = dakika * 60 + simdi.second;

    int sonrakiIndex = _liste.indexWhere((v) => v.dakika > dakika);
    if (sonrakiIndex == -1) sonrakiIndex = 0;

    final siradaki = _liste[sonrakiIndex];
    final ondanSonraki = _liste[(sonrakiIndex + 1) % _liste.length];
    final oncekiIndex = (sonrakiIndex - 1 + _liste.length) % _liste.length;
    final onceki = _liste[oncekiIndex];

    final bool geceGecisi = sonrakiIndex == 0;
    final int baslangicSn = onceki.dakika * 60;
    final int bitisSn = geceGecisi
        ? (_liste.first.dakika + 1440) * 60
        : siradaki.dakika * 60;
    final double ilerleme = ((saniye - baslangicSn) / (bitisSn - baslangicSn))
        .clamp(0.0, 1.0);
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
    final (kalan, ilerleme, siradaki, ondanSonraki) = _vakitHesapla(
      DateTime.now(),
    );
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 65, child: _yaklasanKart(siradaki, kalan, ilerleme)),
          SizedBox(width: 12),
          Expanded(flex: 35, child: _siradakiKart(ondanSonraki)),
        ],
      ),
    );
  }

  Widget _yaklasanKart(_VakitBilgisi v, int kalan, double ilerleme) {
    final l = AppLocalizations.of(context);
    return UcdKart(
      radius: 24,
      maxTilt: 0.08,
      sekil: KartSekli.yuvar,
      child: GestureDetector(
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
              // Sol üstten yayılan yumuşak ışık (derinlik hissi).
              Positioned(
                top: -50,
                left: -30,
                width: 190,
                height: 190,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.12),
                        Colors.white.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ),
              // Sağ üstte kırpılmış dekoratif kubbe silüeti.
              Positioned(
                top: -34,
                right: -14,
                width: 130,
                height: 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(60),
                    ),
                  ),
                ),
              ),
              // Büyük su-ikoni (hafif görünür).
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
                          l.t('v.yaklasan'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.12),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.calculate_outlined,
                                  color: Colors.white70,
                                  size: 12,
                                ),
                                SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    _metotEtiketi,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _sureYaz(kalan),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1.2,
                                          fontFeatures: [
                                            const FontFeature.tabularFigures(),
                                          ],
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.35,
                                              ),
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                            Shadow(
                                              color: Colors.white.withValues(
                                                alpha: 0.30,
                                              ),
                                              blurRadius: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    l.t('v.kaldi'),
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${l.vakitAdi(v.ad)} · ${v.saat}',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        _VakitHalkasi(
                          ilerleme: ilerleme,
                          ikon: v.ikon,
                          boyut: 64,
                          renk: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _siradakiKart(_VakitBilgisi v) {
    final l = AppLocalizations.of(context);
    return UcdKart(
      radius: 24,
      maxTilt: 0.08,
      sekil: KartSekli.kose,
      child: GestureDetector(
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
          child: Stack(
            children: [
              // Sağ altta hafif görünen ay (hilal) su-ikoni.
              Positioned(
                right: -8,
                bottom: -12,
                child: Icon(
                  Icons.nights_stay_outlined,
                  size: 72,
                  color: Renkler.vurgu.withValues(alpha: 0.07),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          l.t('v.siradaki'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(height: 1, color: Colors.white12),
                      ),
                    ],
                  ),
                  Center(
                    child: _VakitHalkasi(
                      ilerleme: 0,
                      ikon: v.ikon,
                      boyut: 56,
                      renk: Renkler.vurgu,
                    ),
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
                      const SizedBox(height: 2),
                      Text(
                        v.saat,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// VAKİT HALKASI (Dairesel Geri Sayım / İlerleme)
// ===========================================================================
/// Yanıp biten halka: vakit kartlarında ilerlemeyi (veya sabit dekoratif
/// halkayı) çizgiyle gösteren, ortasında vakit ikonu bulunan rozet.
class _VakitHalkasi extends StatelessWidget {
  const _VakitHalkasi({
    required this.ilerleme,
    required this.ikon,
    required this.renk,
    this.boyut = 64,
  });

  /// Halkanın doluluk oranı (0..1); 0 verilirse sabit (dekoratif) halka.
  final double ilerleme;

  final IconData ikon;

  /// Yay ve çizgi rengi.
  final Color renk;

  final double boyut;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boyut,
      height: boyut,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: _HalkaCizici(ilerleme: ilerleme, renk: renk),
          ),
          Center(
            child: Container(
              width: boyut * 0.62,
              height: boyut * 0.62,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.22),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
              ),
              child: UcdIkon(ikon: ikon, renk: renk, boyut: boyut * 0.30),
            ),
          ),
        ],
      ),
    );
  }
}

class _HalkaCizici extends CustomPainter {
  const _HalkaCizici({required this.ilerleme, required this.renk});

  final double ilerleme;
  final Color renk;

  @override
  void paint(Canvas canvas, Size size) {
    final merkez = size.center(Offset.zero);
    final yaricap = size.width / 2 - 3;
    final dikdortgen = Rect.fromCircle(center: merkez, radius: yaricap);

    final iz = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..color = Colors.white.withValues(alpha: 0.14);
    canvas.drawCircle(merkez, yaricap, iz);

    if (ilerleme <= 0.0) return;

    final baslangic = -math.pi / 2;
    final tarama = 2 * math.pi * ilerleme.clamp(0.0, 1.0);

    final parlaklik = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..color = renk.withValues(alpha: 0.16);
    canvas.drawArc(dikdortgen, baslangic, tarama, false, parlaklik);

    final yay = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..color = renk;
    canvas.drawArc(dikdortgen, baslangic, tarama, false, yay);
  }

  @override
  bool shouldRepaint(covariant _HalkaCizici old) =>
      old.ilerleme != ilerleme || old.renk != renk;
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
        title: Text("$moodType Modu", style: TextStyle(color: Renkler.vurgu)),
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
