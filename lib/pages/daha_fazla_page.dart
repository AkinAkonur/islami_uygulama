import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';
import '../services/canli_yayin_konfigurasyonu.dart';
import '../services/radyo_oynatici_store.dart';
import '../widgets/radyo_media_player.dart';
import '../widgets/radyo_mini_oynatici.dart';
import 'hadis_kutuphanesi_page.dart';
import 'kissalar_ve_peygamberler_page.dart';
import 'soru_cevap/soru_cevap_page.dart';
import 'yakindaki_camiler_page.dart';
import 'hac_umre/hac_umre_page.dart';
import 'dua_kardesligi/dua_kardesligi_page.dart';
import 'gunluk_hedefler/gunluk_hedefler_page.dart';
import 'paylasim_kartlari/paylasim_kartlari_studio_page.dart';
import 'kabe_canli_page.dart';
import 'sesli_kissalar_ve_podcastler_page.dart';
import 'mekke_medine_sanal_tur_page.dart';
import 'gizlilik_merkezi_page.dart';

class DahaFazlaPage extends StatelessWidget {
  const DahaFazlaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("Tüm Modüller & Özellikler"),
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Renkler.seciliYuzey,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  UcdIkon(ikon: Icons.explore_rounded, renk: Renkler.vurgu, boyut: 32),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Keşif ve Maneviyat Merkezi",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "İhtiyacınız olan tüm dini araçlar, rehberler ve içerikler burada.",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // 1. GÜNLÜK KULLANIM
            _buildSectionHeader("📅 Günlük Kullanım"),
            SizedBox(height: 12),
            _buildModuleCard(
              context,
              Icons.star_outline_rounded,
              "Esma-ül Hüsna",
              "Allah'ın 99 ismi ve derin anlamları",
              EsmaulHusnaPage(),
              Colors.amberAccent,
            ),
            _buildModuleCard(
              context,
              Icons.mosque_rounded,
              "Cami Bul",
              "Konumunuza yakın cami ve mescitleri listeleyin",
              const YakindakiCamilerPage(),
              Colors.tealAccent,
            ),
            _buildModuleCard(
              context,
              Icons.calendar_month_rounded,
              "Hicri Takvim",
              "Kandiller, dini bayramlar ve Ramazan sayacı",
              HicriTakvimPage(),
              Colors.orangeAccent,
            ),
            _buildModuleCard(
              context,
              Icons.calculate_rounded,
              "Zekat & Fitre Hesaplayıcı",
              "Mal varlığına göre zekat ve fitre hesaplama aracı",
              ZekatHesaplamaPage(),
              Colors.lightGreenAccent,
            ),
            SizedBox(height: 24),

            // 2. DERİNLEŞTİRİCİ İÇERİK
            _buildSectionHeader("📖 Derinleştirici İçerik"),
            SizedBox(height: 12),
            _buildModuleCard(
              context,
              Icons.menu_book_rounded,
              "Hatim Takibi",
              "Kur'an okuma ilerlemesi, cüz ve sayfa takibi",
              HatimTakibiPage(),
              Colors.blueAccent,
            ),
            _buildModuleCard(
              context,
              Icons.format_quote_rounded,
              "Hadis Kütüphanesi",
              "Kütüb-i Sitte'den seçkin hadisler ve günlük rehber",
              HadisKutuphanesiPage(),
              Colors.cyanAccent,
            ),
            _buildModuleCard(
              context,
              Icons.history_edu_rounded,
              "Kıssalar & Peygamberler",
              "Sîre-i Nebi, peygamberler tarihi ve ibretlik hikayeler",
              KissalarPage(),
              Colors.purpleAccent,
            ),
            _buildModuleCard(
              context,
              Icons.quiz_rounded,
              "Soru-Cevap (Fetva)",
              "Günlük hayata dair ilmihal ve SSS başlıkları",
              SoruCevapPage(),
              Colors.pinkAccent,
            ),
            _buildModuleCard(
              context,
              Icons.luggage_rounded,
              "Hac & Umre Rehberi",
              "Adım adım kutsal topraklar yolculuğu ve duaları",
              const HacUmreRehberPage(),
              Colors.amber,
            ),
            SizedBox(height: 24),

            // 3. TOPLULUK & MOTİVASYON
            _buildSectionHeader("🤲 Topluluk & Motivasyon"),
            SizedBox(height: 12),
            _buildModuleCard(
              context,
              Icons.groups_rounded,
              "Dua Kardeşliği",
              "Anonim olarak kardeşlerin için dua iste ve dua et",
              const DuaKardesligiPage(),
              Colors.orange,
            ),
            _buildModuleCard(
              context,
              Icons.local_fire_department_rounded,
              "Günlük Hedefler / Streak",
              "İbadet alışkanlığı ve seri (streak) takibi",
              GunlukHedeflerPage(),
              Colors.deepOrangeAccent,
            ),
            _buildModuleCard(
              context,
              Icons.share_rounded,
              "Paylaşım Kartları",
              "WhatsApp ve Instagram için ayet/hadis görsel kartları",
              PaylasimKartlariStudioPage(),
              Colors.lightBlueAccent,
            ),
            SizedBox(height: 24),

            // 4. İNTERAKTİF MEDYA MERKEZİ
            Text(
              "🎧 İnteraktif Medya Merkezi",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            _kabeCanliHeroKarti(context),
            SizedBox(height: 12),
            _buildModuleCard(
              context,
              Icons.record_voice_over_rounded,
              "Sesli Kıssalar ve Podcastler",
              "Kıssaları dinle, podcast ve radyo akışları",
              const SesliKissalarVePodcastlerPage(),
              Colors.purpleAccent,
            ),
            _buildModuleCard(
              context,
              Icons.threesixty_rounded,
              "Mekke & Medine 360° Sanal Tur",
              "Canlı yayınlar, 360° turlar ve mekân haritaları",
              const MekkeMedineSanalTurPage(),
              Colors.amberAccent,
            ),
            _buildModuleCard(
              context,
              Icons.radio_rounded,
              "Dini Radyo & İlahi",
              "Kesintisiz Kuran tilaveti, sohbet ve ilahi akışı",
              DiniRadyoPage(),
              Colors.indigoAccent,
            ),
            _buildModuleCard(
              context,
              Icons.security_rounded,
              "Gizlilik & Veri Güvenliği",
              "\"Verilerim cihazımda saklanır\" gizlilik taahhüdü",
              const GizlilikMerkeziPage(),
              Colors.green,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Kâbe-i Muazzama Canlı Yayını "hero" kartı:
  /// canlı rozeti + açıklama + 🎧 Ses Modu / 📺 Tam Ekran İzle kısayolları.
  Widget _kabeCanliHeroKarti(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const KabeCanliPage()),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Renkler.bannerUst, Renkler.bannerAlt],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Renkler.vurgu.withValues(alpha: 0.15),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Canlı rozeti
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  UcdIkon(ikon: Icons.circle, renk: Colors.white, boyut: 8),
                  SizedBox(width: 6),
                  Text(
                    'KABE-İ MUAZZAMA CANLI YAYINI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '🕋 Kâbe-i Muazzama Canlı Yayını',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Şu an Mescid-i Haram\'dan Canlı · 24/7',
              style: TextStyle(color: Colors.white70, fontSize: 12.5),
            ),
            const SizedBox(height: 4),
            Text(
              'Resmî Harem yayını (canlı HLS) · hücresel veri uyarısı · Mini Oynatıcı (PiP)',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _heroButon(
                    ikon: Icons.headphones_rounded,
                    etiket: '🎧 Ses Modu\n(Arkaplanda Çal)',
                    dolu: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const KabeCanliPage(
                          baslangicModu: YayinModu.ses,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _heroButon(
                    ikon: Icons.fullscreen_rounded,
                    etiket: '📺 Tam Ekran İzle',
                    dolu: false,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const KabeCanliPage(),
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

  Widget _heroButon({
    required IconData ikon,
    required String etiket,
    required bool dolu,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: dolu
              ? Renkler.vurgu.withValues(alpha: 0.85)
              : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: dolu
                ? Colors.transparent
                : Colors.white.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UcdIkon(ikon: ikon, renk: dolu ? Colors.black : Colors.white, boyut: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                etiket,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: dolu ? Colors.black : Colors.white,
                  fontSize: 11.5,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModuleCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget targetPage,
    Color color,
  ) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: UcdIkon(ikon: icon, renk: color, boyut: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: UcdIkon(ikon: Icons.chevron_right, renk: Colors.white38),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
      ),
    );
  }
}

// ===========================================================================
// SUB-PAGES FOR EACH MODULE (Interactive & Functional placeholders)
// ===========================================================================

class EsmaulHusnaPage extends StatelessWidget {
  const EsmaulHusnaPage({super.key});

  static const _veriler = '''
Allah|اللّٰه|Eşi ve benzeri olmayan tek ilâh|Bütün güzel isimlerin sahibi; ibadete yalnız O layıktır.
Er-Rahmân|الرَّحْمٰن|Merhameti bütün varlıkları kuşatan|Dünyada tüm mahlûkata rahmetiyle muamele eder.
Er-Rahîm|الرَّحِيم|Çok merhamet eden|Müminlere özel rahmet ve mağfiret ihsan eder.
El-Melik|الْمَلِك|Mutlak hükümran|Mülkün tamamı O'nundur; dilediği gibi tasarruf eder.
El-Kuddûs|الْقُدُّوس|Her eksiklikten uzak|Zâtı, sıfatları ve fiilleri her türlü noksanlıktan münezzehtir.
Es-Selâm|السَّلَام|Esenlik veren|Kullarına huzur, güven ve selâmet bahşeder.
El-Mü'min|الْمُؤْمِن|Güven veren|Kullarını emniyete ulaştırır ve peygamberlerini tasdik eder.
El-Müheymin|الْمُهَيْمِن|Gözetip koruyan|Her şeyi kuşatır, korur ve denetler.
El-Azîz|الْعَزِيز|Mutlak galip ve güçlü|İzzet sahibidir; hiçbir güç O'na üstün gelemez.
El-Cebbâr|الْجَبَّار|Dilediğini yaptıran|Kırıkları onarır, kudretiyle her şeye hükmeder.
El-Mütekebbir|الْمُتَكَبِّر|Büyüklükte eşsiz|Gerçek büyüklük yalnız O'na aittir.
El-Hâlik|الْخَالِق|Yaratan|Her şeyi yoktan var eden ve ölçüyle yaratan.
El-Bâri|الْبَارِئ|Kusursuz yaratan|Varlıkları birbirinden farklı özelliklerle yaratan.
El-Musavvir|الْمُصَوِّر|Şekil veren|Her varlığa dilediği suret ve özellikleri veren.
El-Gaffâr|الْغَفَّار|Çok bağışlayan|Tevbe edenlerin günahlarını tekrar tekrar örten.
El-Kahhâr|الْقَهَّار|Her şeye galip|Bütün yaratılmışlar kudreti karşısında boyun eğer.
El-Vehhâb|الْوَهَّاب|Karşılıksız veren|Lütuf ve nimetlerini karşılık beklemeden bağışlar.
Er-Rezzâk|الرَّزَّاق|Rızık veren|Bütün canlıların maddî ve manevî rızkını veren.
El-Fettâh|الْفَتَّاح|Kapıları açan|Hayır kapılarını açar, hak ile bâtılı ayırır.
El-Alîm|الْعَلِيم|Her şeyi bilen|Geçmişi, geleceği, gizliyi ve açığı eksiksiz bilir.
El-Kâbıd|الْقَابِض|Daraltan|Hikmetiyle rızkı ve imkânı dilediğine daraltır.
El-Bâsıt|الْبَاسِط|Genişleten|Hikmetiyle rızkı ve imkânı dilediğine genişletir.
El-Hâfıd|الْخَافِض|Alçaltan|Dilediğini adaletiyle aşağı derecelere indirir.
Er-Râfi|الرَّافِع|Yükselten|Dilediğini ilim, iman ve derece bakımından yükseltir.
El-Muizz|الْمُعِز|İzzet veren|Dilediği kulunu şereflendirir ve güçlü kılar.
El-Müzill|الْمُذِل|Zillete düşüren|Dilediğini adaletiyle zillete düşürür.
Es-Semî|السَّمِيع|Her şeyi işiten|Gizli-açık bütün sesleri ve duaları işitir.
El-Basîr|الْبَصِير|Her şeyi gören|Karanlıkta dahi bütün varlıkları ve halleri görür.
El-Hakem|الْحَكَم|Hüküm veren|Son hüküm sahibi; hükmünde hikmet ve adalet vardır.
El-Adl|الْعَدْل|Mutlak adalet sahibi|Hiç kimseye zerre kadar haksızlık etmez.
El-Latîf|اللَّطِيف|Lütfu ince olan|En ince ayrıntıları bilir, kullarına zarif lütuflarda bulunur.
El-Habîr|الْخَبِير|Her şeyden haberdar|Varlıkların iç yüzünü ve sonuçlarını bilir.
El-Halîm|الْحَلِيم|Ceza vermekte acele etmeyen|Günaha rağmen kullarına mühlet tanır.
El-Azîm|الْعَظِيم|Pek yüce|Zâtı ve sıfatları aklın kavrayışını aşan büyüklüktedir.
El-Gafûr|الْغَفُور|Bağışlaması bol|Samimi tevbe ile günahları bağışlar.
Eş-Şekûr|الشَّكُور|Az amele çok veren|Küçük iyiliği bile büyük karşılıkla mükâfatlandırır.
El-Aliyy|الْعَلِي|Çok yüce|Her makamın üstünde, her eksiklikten uzaktır.
El-Kebîr|الْكَبِير|Çok büyük|Büyüklüğü ve kudreti sınırsızdır.
El-Hafîz|الْحَفِيظ|Koruyan|Her şeyi korur; yapılanları da eksiksiz muhafaza eder.
El-Mukît|الْمُقِيت|Rızık ve güç veren|Her canlıya ihtiyacı kadar rızık ve kuvvet ulaştırır.
El-Hasîb|الْحَسِيب|Hesap gören|Kullarına yeter; amellerin hesabını eksiksiz görür.
El-Celîl|الْجَلِيل|Ululuk sahibi|Azamet, celâl ve yücelik sahibidir.
El-Kerîm|الْكَرِيم|Çok cömert|İhsanı bol, affı geniş ve ikramı sınırsızdır.
Er-Rakîb|الرَّقِيب|Gözetleyen|Her an kullarını ve bütün varlığı gözetir.
El-Mücîb|الْمُجِيب|Dualara karşılık veren|Kendisine yönelenlerin duasına dilediği şekilde icabet eder.
El-Vâsi|الْوَاسِع|Rahmeti ve ilmi geniş|İlmi, kudreti ve rahmeti her şeyi kuşatır.
El-Hakîm|الْحَكِيم|Hikmet sahibi|Her işi yerli yerinde ve anlamlıdır.
El-Vedûd|الْوَدُود|Çok seven ve sevilen|Salih kullarını sever, sevgiye layık olandır.
El-Mecîd|الْمَجِيد|Şanı yüce|Şeref, ikram ve övgüsü çok yücedir.
El-Bâis|الْبَاعِث|Dirilten|Ölüleri kıyamette yeniden diriltecek olandır.
Eş-Şehîd|الشَّهِيد|Her şeye şahit|Her yerde hazır ve her olaya şahittir.
El-Hakk|الْحَق|Varlığı ve hükmü gerçek|Zâtı kesin gerçektir; vaadi ve hükmü haktır.
El-Vekîl|الْوَكِيل|Güvenilip dayanılan|Kendisine tevekkül edenlere yeter ve işleri en güzel yönetir.
El-Kaviyy|الْقَوِي|Çok güçlü|Kudreti sonsuz, gücü eksiksizdir.
El-Metîn|الْمَتِين|Çok sağlam|Kudreti sarsılmaz, hükmü dayanıklıdır.
El-Veliyy|الْوَلِي|Dost ve yardımcı|Müminlerin dostu, koruyucusu ve yardımcısıdır.
El-Hamîd|الْحَمِيد|Her övgüye layık|Her hâlde hamde ve övgüye layıktır.
El-Muhsî|الْمُحْصِي|Her şeyi sayan|Yaratılmışların ve amellerin sayısını eksiksiz bilir.
El-Mübdi|الْمُبْدِئ|İlk defa yaratan|Varlıkları örneksiz olarak ilk kez yaratır.
El-Muîd|الْمُعِيد|Yeniden yaratan|Öldükten sonra tekrar diriltip var edecek olandır.
El-Muhyî|الْمُحْيِي|Hayat veren|Canlılara hayat veren ve yaşatandır.
El-Mümît|الْمُمِيت|Ölümü veren|Her canlının ecelini takdir eden ve ölümü yaratandır.
El-Hayy|الْحَي|Diri|Hayatı ezelî ve ebedîdir; asla ölmez.
El-Kayyûm|الْقَيُّوم|Her şeyi ayakta tutan|Varlığı kendindendir, bütün varlıkları yönetir.
El-Vâcid|الْوَاجِد|Dilediğini bulan|Hiçbir şeye muhtaç olmayan, her şeye sahip olandır.
El-Mâcid|الْمَاجِد|Şerefi yüce|Cömertliği, şanı ve keremi sonsuzdur.
El-Vâhid|الْوَاحِد|Tek|Zâtında, sıfatlarında ve fiillerinde tektir.
Es-Samed|الصَّمَد|Her şeyin muhtaç olduğu|Kendisi hiçbir şeye muhtaç değildir.
El-Kâdir|الْقَادِر|Her şeye gücü yeten|Dilediğini yapmaya kudreti yeter.
El-Muktedir|الْمُقْتَدِر|Kudreti üstün|Kudretini dilediği şekilde eksiksiz ortaya koyan.
El-Mukaddim|الْمُقَدِّم|Öne alan|Hikmetiyle dilediğini öne geçirir.
El-Muahhir|الْمُؤَخِّر|Geri bırakan|Hikmetiyle dilediğini geri bırakır veya erteler.
El-Evvel|الْأَوَّل|İlk|Varlığının başlangıcı yoktur.
El-Âhir|الْآخِر|Son|Varlığının sonu yoktur.
Ez-Zâhir|الظَّاهِر|Varlığı aşikâr|Delilleriyle varlığı açıkça bilinen.
El-Bâtın|الْبَاطِن|Mahiyeti gizli|Zâtının hakikati idrak edilemeyecek kadar yücedir.
El-Vâlî|الْوَالِي|Yönetici|Kâinatı idare eden ve yöneten.
El-Müteâlî|الْمُتَعَالِي|Çok yüce|Her türlü eksiklikten ve benzerlikten uzaktır.
El-Berr|الْبَر|İyiliği bol|Kullarına iyilik ve ihsanı çok olandır.
Et-Tevvâb|التَّوَّاب|Tevbeleri kabul eden|Kul tekrar dönse de tevbesini kabul eder.
El-Müntekim|الْمُنْتَقِم|Adaletle cezalandıran|Zulümde ısrar edenleri adaletiyle cezalandırır.
El-Afüv|الْعَفُو|Affı çok|Günahları silip izlerini dahi kaldıran.
Er-Raûf|الرَّؤُوف|Çok şefkatli|Kullarına karşı pek merhametli ve şefkatlidir.
Mâlikü'l-Mülk|مَالِكُ الْمُلْك|Mülkün sahibi|Mülkü dilediğine verir, dilediğinden alır.
Zü'l-Celâli ve'l-İkrâm|ذُو الْجَلَالِ وَالْإِكْرَام|Celâl ve ikram sahibi|Azamet ve ikramın gerçek sahibidir.
El-Muksit|الْمُقْسِط|Adaletle hükmeden|Her hakkı sahibine veren mutlak adalet sahibidir.
El-Câmi|الْجَامِع|Toplayan|Dilediklerini bir araya getiren, kıyamette kulları toplayan.
El-Ganiyy|الْغَنِي|Hiçbir şeye muhtaç olmayan|Her şey O'na muhtaç, O ise hiçbir şeye muhtaç değildir.
El-Muğnî|الْمُغْنِي|Zengin eden|Dilediğine yeterlilik ve zenginlik veren.
El-Mâni|الْمَانِع|Engelleyen|Hikmetiyle dilediği şeyin gerçekleşmesine engel olan.
Ed-Dârr|الضَّار|Zarar vereni yaratan|Zarar da fayda da O'nun ilmi ve izniyle gerçekleşir.
En-Nâfi|النَّافِع|Fayda veren|Her türlü yararı ve hayrı veren.
En-Nûr|النُّور|Aydınlatan|Göklerin ve yerin nuru; kalpleri hidayetle aydınlatan.
El-Hâdî|الْهَادِي|Hidayet veren|Kullarını doğru yola ulaştıran.
El-Bedî|الْبَدِيع|Eşsiz yaratan|Örneği olmadan benzersiz yaratan.
El-Bâkî|الْبَاقِي|Ebedî kalan|Her şey yok olurken varlığı devam eden.
El-Vâris|الْوَارِث|Her şeyin son sahibi|Varlıklar yok olduğunda mülk yine O'na kalır.
Er-Reşîd|الرَّشِيد|Doğruya ulaştıran|Her işinde doğru olan ve doğru yolu gösteren.
Es-Sabûr|الصَّبُور|Çok sabırlı|Günahkârlara ceza vermekte acele etmeyendir.''';

  @override
  Widget build(BuildContext context) {
    final list = _veriler.trim().split('\n').map((s) => s.split('|')).toList();
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text("Esma-ül Hüsna (99 İsim)"),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return Card(
            color: Renkler.kart,
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.amber.withValues(alpha: 0.2),
                child: Text(
                  "${index + 1}",
                  style: TextStyle(color: Colors.amber),
                ),
              ),
              title: Text(
                '${item[0]}  •  ${item[1]}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  '${item[2]}\n${item[3]}',
                  style: const TextStyle(color: Colors.white70, height: 1.35),
                ),
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

class HicriTakvimPage extends StatelessWidget {
  const HicriTakvimPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Hicri Takvim & Önemli Günler", [
      _item(
        "Bugün: 18 Safer 1448",
        "Mübarek üç aylara ve kandillere kalan süreler.",
      ),
      _item("Berat Kandili", "Yaklaşan mübarek gece"),
      _item("Ramazan Başlangıcı", "11 Ayın Sultanı'na kalan süre sayaçları"),
    ]);
  }
}

class ZekatHesaplamaPage extends StatefulWidget {
  const ZekatHesaplamaPage({super.key});
  @override
  State<ZekatHesaplamaPage> createState() => _ZekatHesaplamaPageState();
}

class _ZekatHesaplamaPageState extends State<ZekatHesaplamaPage> {
  final _nakit = TextEditingController();
  final _banka = TextEditingController();
  final _altinGram = TextEditingController();
  final _altinFiyat = TextEditingController();
  final _gumusGram = TextEditingController();
  final _gumusFiyat = TextEditingController();
  final _alacak = TextEditingController();
  final _ticaret = TextEditingController();
  final _yatirim = TextEditingController();
  final _diger = TextEditingController();
  final _borc = TextEditingController();
  final _fitreKisi = TextEditingController(text: '1');
  final _fitreTutar = TextEditingController();
  bool _nisabAltin = true;
  double? _netVarlik;
  double _nisab = 0;
  double _zekat = 0;
  double _fitre = 0;

  double _sayi(TextEditingController c) {
    final ham = c.text.trim();
    final duzenli = ham.contains(',')
        ? ham.replaceAll('.', '').replaceAll(',', '.')
        : ham;
    return double.tryParse(duzenli) ?? 0;
  }

  void _hesapla() {
    setState(() {
      final altinDegeri = _sayi(_altinGram) * _sayi(_altinFiyat);
      final gumusDegeri = _sayi(_gumusGram) * _sayi(_gumusFiyat);
      final varliklar =
          _sayi(_nakit) +
          _sayi(_banka) +
          altinDegeri +
          gumusDegeri +
          _sayi(_alacak) +
          _sayi(_ticaret) +
          _sayi(_yatirim) +
          _sayi(_diger);
      _netVarlik = varliklar - _sayi(_borc);
      _nisab = _nisabAltin ? 85 * _sayi(_altinFiyat) : 595 * _sayi(_gumusFiyat);
      _zekat = _netVarlik! >= _nisab && _nisab > 0 ? _netVarlik! * .025 : 0;
      _fitre = _sayi(_fitreKisi) * _sayi(_fitreTutar);
    });
  }

  @override
  void dispose() {
    for (final c in [
      _nakit,
      _banka,
      _altinGram,
      _altinFiyat,
      _gumusGram,
      _gumusFiyat,
      _alacak,
      _ticaret,
      _yatirim,
      _diger,
      _borc,
      _fitreKisi,
      _fitreTutar,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("Zekat Hesaplayıcı"),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Bu araç yaklaşık bir hesap sunar. Zekât için nisap miktarı, malın üzerinden bir kamerî yıl geçmesi ve borçlar gibi şartları kendi durumunuza göre değerlendiriniz.',
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
          const SizedBox(height: 18),
          _baslik('1. Nisap tercihi'),
          SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: true, label: Text('Altın nisabı (85 g)')),
              ButtonSegment(value: false, label: Text('Gümüş nisabı (595 g)')),
            ],
            selected: {_nisabAltin},
            onSelectionChanged: (v) => setState(() => _nisabAltin = v.first),
          ),
          const SizedBox(height: 14),
          _baslik('2. Varlıklarınız'),
          _alan('Nakit (TL)', _nakit, 'Cüzdan ve eldeki para'),
          _alan('Banka hesapları (TL)', _banka, 'Vadesiz/vadeli hesaplar'),
          _alan('Altın miktarı (gram)', _altinGram, 'Ziynet ve yatırım altını'),
          _alan('1 gram altın fiyatı (TL)', _altinFiyat, 'Güncel fiyatı girin'),
          _alan('Gümüş miktarı (gram)', _gumusGram, 'Sahip olduğunuz gümüş'),
          _alan('1 gram gümüş fiyatı (TL)', _gumusFiyat, 'Güncel fiyatı girin'),
          _alan(
            'Tahsil edilebilir alacaklar (TL)',
            _alacak,
            'Geri ödeneceği kesin alacaklar',
          ),
          _alan(
            'Ticaret malları (TL)',
            _ticaret,
            'Satış fiyatı üzerinden stok değeri',
          ),
          _alan(
            'Yatırım / hisse / fon (TL)',
            _yatirim,
            'Zekâta tabi kısmın güncel değeri',
          ),
          _alan(
            'Diğer zekâta tabi varlıklar (TL)',
            _diger,
            'Örn. döviz veya değerli maden',
          ),
          const SizedBox(height: 8),
          _baslik('3. Düşülecek borçlar'),
          _alan(
            'Vadesi gelmiş / kısa vadeli borçlar (TL)',
            _borc,
            'Ödenecek borçlar; uzun vadeli borcun yalnız yakın taksiti',
          ),
          const SizedBox(height: 8),
          _baslik('4. Fitre (isteğe bağlı)'),
          _alan(
            'Kişi sayısı',
            _fitreKisi,
            'Kendiniz ve sorumlu olduğunuz kişiler',
          ),
          _alan(
            'Kişi başı fitre tutarı (TL)',
            _fitreTutar,
            'Bulunduğunuz yıl için açıklanan tutarı girin',
          ),
          const SizedBox(height: 18),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Renkler.vurgu,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            onPressed: _hesapla,
            icon: const UcdIkon(ikon: Icons.calculate_rounded, renk: Colors.white70),
            label: const Text('Hesapla'),
          ),
          if (_netVarlik != null) ...[
            const SizedBox(height: 18),
            _sonucKarti(),
          ],
        ],
      ),
    );
  }

  Widget _baslik(String metin) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 4),
    child: Text(
      metin,
      style: TextStyle(
        color: Renkler.vurgu,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
    ),
  );

  Widget _alan(
    String baslik,
    TextEditingController controller,
    String yardim,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: baslik,
        helperText: yardim,
        labelStyle: const TextStyle(color: Colors.white70),
        helperStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Renkler.kart,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );

  Widget _sonucKarti() {
    final zekatVar = _zekat > 0;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: .5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hesap özeti',
            style: TextStyle(
              color: Renkler.vurgu,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 10),
          _satir(
            'Net zekâta tabi varlık',
            '${_netVarlik!.toStringAsFixed(2)} TL',
          ),
          _satir('Seçilen nisap eşiği', '${_nisab.toStringAsFixed(2)} TL'),
          const Divider(color: Colors.white24),
          Text(
            zekatVar
                ? 'Tahmini zekât (%2,5): ${_zekat.toStringAsFixed(2)} TL'
                : 'Nisap eşiğine ulaşılmadığı için bu hesapta zekât çıkmadı.',
            style: TextStyle(
              color: zekatVar ? Colors.amberAccent : Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (_fitre > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Toplam fitre: ${_fitre.toStringAsFixed(2)} TL',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
        ],
      ),
    );
  }

  Widget _satir(String ad, String deger) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Expanded(
          child: Text(ad, style: const TextStyle(color: Colors.white70)),
        ),
        Text(
          deger,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class HatimTakibiPage extends StatefulWidget {
  const HatimTakibiPage({super.key});

  @override
  State<HatimTakibiPage> createState() => _HatimTakibiPageState();
}

class _HatimTakibiPageState extends State<HatimTakibiPage> {
  static const _silinenAnahtar = 'hatim_takibi_silinenler';
  final List<(String, String)> _icerikler = [
    ("1. Cüz - Bakara Suresi", "%100 Tamamlandı"),
    ("2. Cüz - Bakara Suresi", "%45 İlerleme"),
    ("3. Cüz - Al-i İmran", "Henüz Başlanmadı"),
  ];
  final Set<String> _silinenler = {};

  @override
  void initState() {
    super.initState();
    _silinenleriYukle();
  }

  Future<void> _silinenleriYukle() async {
    final p = await SharedPreferences.getInstance();
    final kayitli = p.getStringList(_silinenAnahtar) ?? const [];
    if (!mounted) return;
    setState(() => _silinenler.addAll(kayitli));
  }

  Future<void> _sil(String baslik) async {
    setState(() => _silinenler.add(baslik));
    final p = await SharedPreferences.getInstance();
    await p.setStringList(_silinenAnahtar, _silinenler.toList());
  }

  @override
  Widget build(BuildContext context) {
    final gorunen = _icerikler
        .where((i) => !_silinenler.contains(i.$1))
        .toList();
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text(
          'Hatim Takibi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
      ),
      body: gorunen.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Liste boş. Tüm cüz ve sureler silindi.',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [for (final (baslik, durum) in gorunen) _satir(baslik, durum)],
            ),
    );
  }

  Widget _satir(String baslik, String durum) {
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 4),
        leading: CircleAvatar(
          backgroundColor: Renkler.vurgu.withValues(alpha: 0.15),
          child: UcdIkon(ikon: Icons.menu_book_rounded, renk: Renkler.vurgu, boyut: 20),
        ),
        title: Text(
          baslik,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          durum,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: IconButton(
          tooltip: 'Sil',
          onPressed: () => _sil(baslik),
          icon: const UcdIkon(ikon: Icons.delete_outline_rounded, renk: Colors.white38),
        ),
      ),
    );
  }
}

class KissalarPage extends StatelessWidget {
  const KissalarPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const KissalarVePeygamberlerPage();
  }
}

class DiniRadyoPage extends StatefulWidget {
  const DiniRadyoPage({super.key});

  @override
  State<DiniRadyoPage> createState() => _DiniRadyoPageState();
}

class _DiniRadyoPageState extends State<DiniRadyoPage> {
  RadyoKategori? _filtre;
  bool _sadeceFavoriler = false;
  String? _dilFiltresi;

  List<RadyoKanali> get _kanallar =>
      CanliYayinKonfigurasyonu.guncel.radyoKanallari;

  List<RadyoKanali> get _filtrelenmis =>
      _filtre == null
          ? _kanallar
          : _kanallar.where((k) => k.kategori == _filtre).toList();

  List<RadyoKanali> get _gorunenKanallar => _sadeceFavoriler
      ? _filtrelenmis
          .where((k) => RadyoOynaticiStore.favoriMi(k.url))
          .toList()
      : _filtrelenmis;

  List<RadyoIstasyonu> get _dunyaIstasyonlari {
    final istasyonlar = CanliYayinKonfigurasyonu.radyoIstasyonlari;
    if (_dilFiltresi == null) return istasyonlar;
    return istasyonlar
        .where((s) => s.dil.toLowerCase() == _dilFiltresi)
        .toList();
  }

  /// Kanalları kategoriye göre gruplar (liste sırası korunur).
  Map<RadyoKategori, List<RadyoKanali>> _grupla() {
    final gruplar = <RadyoKategori, List<RadyoKanali>>{};
    for (final kanal in _gorunenKanallar) {
      gruplar.putIfAbsent(kanal.kategori, () => []).add(kanal);
    }
    return gruplar;
  }

  @override
  void initState() {
    super.initState();
    RadyoOynaticiStore.baslat(kanallar: _kanallar);
  }

  Future<void> _kanallariYenile() async {
    final onceki = _kanallar;
    final basarili = await CanliYayinKonfigurasyonu.manuelYenile();
    if (!mounted) return;
    final yenilendi = onceki.length != _kanallar.length ||
        onceki.map((k) => k.url).toSet() !=
            _kanallar.map((k) => k.url).toSet();
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: basarili ? Renkler.seciliYuzey : Renkler.kart,
        content: Text(
          basarili
              ? (yenilendi
                  ? 'Kanal listesi güncellendi. (${_kanallar.length} kanal)'
                  : 'Kanal listesi güncel. (${_kanallar.length} kanal)')
              : 'Sunucudan kanal listesi alınamadı; son kayıtlı liste kullanılıyor.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mevcutKategoriler = _kanallar.map((k) => k.kategori).toSet();
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text("Dini Radyo & İlahi Akışı"),
        backgroundColor: Renkler.seciliYuzey,
        actions: [
          IconButton(
            tooltip: 'Kanalları Güncelle',
            onPressed: _kanallariYenile,
            icon: const UcdIkon(ikon: Icons.sync_rounded, renk: Colors.white70),
          ),
        ],
      ),
      body: Column(
        children: [
          _bilgiBanneri(),
          ValueListenableBuilder<RadyoKanali?>(
            valueListenable: RadyoOynaticiStore.calanKanal,
            builder: (context, calan, _) => calan == null
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: RadyoMediaPlayer(kanallar: _kanallar),
                  ),
          ),
          _kategoriFiltreleri(mevcutKategoriler),
          Expanded(
            child: _kanallar.isEmpty
                ? const Center(
                    child: Text(
                      'Kanal bulunamadı. Güncelle butonu ile yeniden deneyin.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : _kanalListesi(),
          ),
        ],
      ),
      bottomNavigationBar: const RadyoMiniOynatici(),
    );
  }

  Widget _bilgiBanneri() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Renkler.seciliYuzey.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UcdIkon(ikon: Icons.radio_rounded, renk: Colors.indigoAccent),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                '7/24 kesintisiz Kur\'an tilaveti, ilahi ve dini sohbet akışı. '
                'Kanallar sunucu tarafından yönetilir; uygulama güncellemesi '
                'gerektirmez.',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kategoriFiltreleri(Set<RadyoKategori> mevcutKategoriler) {
    final hepsiSecili = _filtre == null && !_sadeceFavoriler;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          _filtreChip(
            etiket: 'Tümü (${_kanallar.length})',
            secili: hepsiSecili,
            onTap: () => setState(() {
              _filtre = null;
              _sadeceFavoriler = false;
            }),
          ),
          ValueListenableBuilder<Set<String>>(
            valueListenable: RadyoOynaticiStore.favoriler,
            builder: (context, favoriler, _) => Padding(
              padding: const EdgeInsets.only(left: 6),
              child: _filtreChip(
                etiket: '❤ Favoriler (${favoriler.length})',
                secili: _sadeceFavoriler,
                onTap: () => setState(() => _sadeceFavoriler = !_sadeceFavoriler),
              ),
            ),
          ),
          for (final kategori in mevcutKategoriler)
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: _filtreChip(
                etiket: kategori.etiket,
                secili: _filtre == kategori,
                onTap: () => setState(() {
                  _filtre = kategori;
                  _sadeceFavoriler = false;
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _filtreChip({
    required String etiket,
    required bool secili,
    required VoidCallback onTap,
  }) {
    return ChoiceChip(
      label: Text(etiket),
      selected: secili,
      onSelected: (_) => onTap(),
      selectedColor: Renkler.seciliYuzey,
      backgroundColor: Renkler.kart,
      side: BorderSide(
        color: secili ? Renkler.vurgu : Renkler.cerceve,
      ),
      labelStyle: TextStyle(
        color: secili ? Colors.white : Colors.white70,
        fontSize: 12.5,
        fontWeight: secili ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      showCheckmark: false,
    );
  }

  Widget _kanalListesi() {
    final gruplar = _grupla();
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: [
        ValueListenableBuilder<String?>(
          valueListenable: RadyoOynaticiStore.hata,
          builder: (context, hata, _) => hata == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Text(
                    hata,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                  ),
                ),
        ),
        if (_dunyaGorunur) ..._dunyaBolumu(),
        for (final kategori in gruplar.keys) ...[
          _grupBasligi(kategori, gruplar[kategori]!.length),
          for (final kanal in gruplar[kategori]!) _kanalKarti(kanal),
        ],
      ],
    );
  }

  /// Tüm liste görünümü açıkken (kategori/favori filtresi kapalı) üstte
  /// "Dünya Radyoları" bölümü gösterilir.
  bool get _dunyaGorunur => _filtre == null && !_sadeceFavoriler;

  List<Widget> _dunyaBolumu() {
    final istasyonlar = _dunyaIstasyonlari;
    return [
      _dunyaBasligi(istasyonlar.length),
      _dilFiltreleri(),
      for (final istasyon in istasyonlar) _dunyaKarti(istasyon),
      const SizedBox(height: 12),
      Row(
        children: [
          const Expanded(child: Divider(color: Colors.white12)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Türkiye & Suudi kanalları',
              style: TextStyle(color: Colors.white38, fontSize: 11.5),
            ),
          ),
          const Expanded(child: Divider(color: Colors.white12)),
        ],
      ),
    ];
  }

  Widget _dunyaBasligi(int adet) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Row(
        children: [
          const UcdIkon(ikon: Icons.public_rounded, renk: Colors.tealAccent, boyut: 18),
          const SizedBox(width: 8),
          const Text(
            'Dünya Radyoları',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.tealAccent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$adet',
              style: const TextStyle(color: Colors.tealAccent, fontSize: 12),
            ),
          ),
          const Spacer(),
          Text(
            'global radyo_istasyonlari',
            style: TextStyle(color: Colors.white24, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _dilFiltreleri() {
    final diller = CanliYayinKonfigurasyonu.radyoIstasyonlari
        .map((s) => s.dil.toLowerCase())
        .toSet()
        .toList();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          _dilChip('Tümü', null),
          for (final dil in diller)
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: _dilChip(radyoDilEtiketi(dil), dil),
            ),
        ],
      ),
    );
  }

  Widget _dilChip(String etiket, String? dil) {
    final secili = _dilFiltresi == dil;
    return ChoiceChip(
      label: Text(etiket),
      selected: secili,
      onSelected: (_) => setState(() => _dilFiltresi = dil),
      selectedColor: Colors.tealAccent.withValues(alpha: 0.25),
      backgroundColor: Renkler.kart,
      side: BorderSide(color: secili ? Colors.tealAccent : Renkler.cerceve),
      labelStyle: TextStyle(
        color: secili ? Colors.tealAccent : Colors.white70,
        fontSize: 12.5,
        fontWeight: secili ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      showCheckmark: false,
    );
  }

  Widget _dunyaKarti(RadyoIstasyonu istasyon) {
    final kanal = istasyon.kanal;
    return ValueListenableBuilder<RadyoKanali?>(
      valueListenable: RadyoOynaticiStore.calanKanal,
      builder: (context, calan, _) => ValueListenableBuilder<bool>(
        valueListenable: RadyoOynaticiStore.calyor,
        builder: (context, calyor, _) => ValueListenableBuilder<bool>(
          valueListenable: RadyoOynaticiStore.yukleniyor,
          builder: (context, yukleniyor, _) =>
              ValueListenableBuilder<Set<String>>(
            valueListenable: RadyoOynaticiStore.favoriler,
            builder: (context, favoriler, _) {
              final caliyor = calan?.url == kanal.url && calyor;
              final yukluyor = calan?.url == kanal.url && yukleniyor;
              final favori = favoriler.contains(kanal.url);
              return Card(
                color: Renkler.kart,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  leading: GestureDetector(
                    onTap: () => RadyoOynaticiStore.oynat(kanal,
                        kanallar: _dunyaIstasyonlari
                            .map((s) => s.kanal)
                            .toList()),
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: caliyor
                            ? Colors.tealAccent.withValues(alpha: 0.25)
                            : Renkler.seciliYuzey,
                        shape: BoxShape.circle,
                      ),
                      child: yukluyor
                          ? const Padding(
                              padding: EdgeInsets.all(13),
                              child:
                                  CircularProgressIndicator(strokeWidth: 2.4),
                            )
                          : UcdIkon(ikon: 
                              caliyor ? Icons.pause_rounded : Icons.play_arrow_rounded, renk: caliyor
                                  ? Colors.tealAccent
                                  : Renkler.vurgu, boyut: 26,
                            ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Flexible(
                        child: Text(
                          istasyon.kanalAdi,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Renkler.seciliYuzey.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Renkler.cerceve2),
                        ),
                        child: Text(
                          radyoDilEtiketi(istasyon.dil),
                          style: const TextStyle(
                            color: Colors.tealAccent,
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      caliyor
                          ? '🔴 Canlı akış devam ediyor...'
                          : (istasyon.aciklama.isEmpty
                              ? istasyon.kategori
                              : istasyon.aciklama),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    tooltip:
                        favori ? 'Favorilerden Çıkar' : 'Favorilere Ekle',
                    onPressed: () =>
                        RadyoOynaticiStore.favoriDegistir(kanal.url),
                    icon: UcdIkon(ikon: 
                      favori ? Icons.favorite_rounded : Icons.favorite_border_rounded, renk: favori ? Colors.pinkAccent : Colors.white30, boyut: 22,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _grupBasligi(RadyoKategori kategori, int adet) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 8),
      child: Row(
        children: [
          UcdIkon(ikon: _kategoriIkon(kategori), renk: Renkler.vurgu, boyut: 18),
          const SizedBox(width: 8),
          Text(
            kategori.etiket,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$adet',
              style: TextStyle(color: Renkler.vurgu, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  IconData _kategoriIkon(RadyoKategori kategori) {
    switch (kategori) {
      case RadyoKategori.tilavet:
        return Icons.menu_book_rounded;
      case RadyoKategori.ilahi:
        return Icons.music_note_rounded;
      case RadyoKategori.dini:
        return Icons.forum_rounded;
      case RadyoKategori.yurtdisi:
        return Icons.public_rounded;
    }
  }

  Widget _kanalKarti(RadyoKanali kanal) {
    return ValueListenableBuilder<RadyoKanali?>(
      valueListenable: RadyoOynaticiStore.calanKanal,
      builder: (context, calan, _) => ValueListenableBuilder<bool>(
        valueListenable: RadyoOynaticiStore.calyor,
        builder: (context, calyor, _) => ValueListenableBuilder<bool>(
          valueListenable: RadyoOynaticiStore.yukleniyor,
          builder: (context, yukleniyor, _) =>
              ValueListenableBuilder<Set<String>>(
            valueListenable: RadyoOynaticiStore.favoriler,
            builder: (context, favoriler, _) {
              final caliyor = calan?.url == kanal.url && calyor;
              final yukluyor = calan?.url == kanal.url && yukleniyor;
              final favori = favoriler.contains(kanal.url);
              return Card(
                color: Renkler.kart,
                margin: const EdgeInsets.only(bottom: 10),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: GestureDetector(
                    onTap: () => RadyoOynaticiStore.oynat(kanal,
                        kanallar: _kanallar),
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: caliyor
                            ? Colors.indigoAccent.withValues(alpha: 0.25)
                            : Renkler.seciliYuzey,
                        shape: BoxShape.circle,
                      ),
                      child: yukluyor
                          ? const Padding(
                              padding: EdgeInsets.all(13),
                              child: CircularProgressIndicator(strokeWidth: 2.4),
                            )
                          : UcdIkon(ikon: 
                              caliyor ? Icons.pause_rounded : Icons.play_arrow_rounded, renk: caliyor ? Colors.indigoAccent : Renkler.vurgu, boyut: 26,
                            ),
                    ),
                  ),
                  title: Text(
                    kanal.ad,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      caliyor ? '🔴 Canlı akış devam ediyor...' : kanal.aciklama,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    tooltip: favori ? 'Favorilerden Çıkar' : 'Favorilere Ekle',
                    onPressed: () => RadyoOynaticiStore.favoriDegistir(kanal.url),
                    icon: UcdIkon(ikon: 
                      favori ? Icons.favorite_rounded : Icons.favorite_border_rounded, renk: favori ? Colors.pinkAccent : Colors.white30, boyut: 22,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildStandardSubPage(String title, List<Widget> children) {
  return Scaffold(
    backgroundColor: Renkler.zemin,
    appBar: AppBar(title: Text(title), backgroundColor: Renkler.seciliYuzey),
    body: ListView(padding: EdgeInsets.all(16), children: children),
  );
}

Widget _item(String title, String subtitle) {
  return Card(
    color: Renkler.kart,
    margin: EdgeInsets.only(bottom: 10),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white70, fontSize: 12),
      ),
    ),
  );
}
