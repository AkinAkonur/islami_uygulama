import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/renkler.dart';
import 'hadis_kutuphanesi_page.dart';
import 'kissalar_ve_peygamberler_page.dart';
import 'soru_cevap/soru_cevap_page.dart';
import 'yakindaki_camiler_page.dart';

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
                  Icon(Icons.explore, color: Renkler.vurgu, size: 32),
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
              Icons.star_outline,
              "Esma-ül Hüsna",
              "Allah'ın 99 ismi ve derin anlamları",
              EsmaulHusnaPage(),
              Colors.amberAccent,
            ),
            _buildModuleCard(
              context,
              Icons.mosque_outlined,
              "Cami Bul",
              "Konumunuza yakın cami ve mescitleri listeleyin",
              const YakindakiCamilerPage(),
              Colors.tealAccent,
            ),
            _buildModuleCard(
              context,
              Icons.calendar_month_outlined,
              "Hicri Takvim",
              "Kandiller, dini bayramlar ve Ramazan sayacı",
              HicriTakvimPage(),
              Colors.orangeAccent,
            ),
            _buildModuleCard(
              context,
              Icons.calculate_outlined,
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
              Icons.menu_book_outlined,
              "Hatim Takibi",
              "Kur'an okuma ilerlemesi, cüz ve sayfa takibi",
              HatimTakibiPage(),
              Colors.blueAccent,
            ),
            _buildModuleCard(
              context,
              Icons.format_quote_outlined,
              "Hadis Kütüphanesi",
              "Kütüb-i Sitte'den seçkin hadisler ve günlük rehber",
              HadisKutuphanesiPage(),
              Colors.cyanAccent,
            ),
            _buildModuleCard(
              context,
              Icons.history_edu_outlined,
              "Kıssalar & Peygamberler",
              "Sîre-i Nebi, peygamberler tarihi ve ibretlik hikayeler",
              KissalarPage(),
              Colors.purpleAccent,
            ),
            _buildModuleCard(
              context,
              Icons.quiz_outlined,
              "Soru-Cevap (Fetva)",
              "Günlük hayata dair ilmihal ve SSS başlıkları",
              SoruCevapPage(),
              Colors.pinkAccent,
            ),
            _buildModuleCard(
              context,
              Icons.luggage_outlined,
              "Hac & Umre Rehberi",
              "Adım adım kutsal topraklar yolculuğu ve duaları",
              HacUmrePage(),
              Colors.amber,
            ),
            SizedBox(height: 24),

            // 3. TOPLULUK & MOTİVASYON
            _buildSectionHeader("🤲 Topluluk & Motivasyon"),
            SizedBox(height: 12),
            _buildModuleCard(
              context,
              Icons.groups_outlined,
              "Dua Kardeşliği",
              "Anonim olarak kardeşlerin için dua iste ve dua et",
              DuaKardesligiPage(),
              Colors.orange,
            ),
            _buildModuleCard(
              context,
              Icons.local_fire_department_outlined,
              "Günlük Hedefler / Streak",
              "İbadet alışkanlığı ve seri (streak) takibi",
              GunlukHedeflerPage(),
              Colors.deepOrangeAccent,
            ),
            _buildModuleCard(
              context,
              Icons.share_outlined,
              "Paylaşım Kartları",
              "WhatsApp ve Instagram için ayet/hadis görsel kartları",
              PaylasimKartlariPage(),
              Colors.lightBlueAccent,
            ),
            SizedBox(height: 24),

            // 4. ARAÇ & MEDYA
            _buildSectionHeader("🎧 Araç & Medya"),
            SizedBox(height: 12),
            _buildModuleCard(
              context,
              Icons.live_tv_outlined,
              "Kâbe Canlı Yayın",
              "7/24 Mescid-i Haram (Kâbe-i Muazzama) canlı yayını",
              KabeCanliPage(),
              Colors.redAccent,
            ),
            _buildModuleCard(
              context,
              Icons.radio_outlined,
              "Dini Radyo & İlahi",
              "Kesintisiz Kuran tilaveti, sohbet ve ilahi akışı",
              DiniRadyoPage(),
              Colors.indigoAccent,
            ),
            _buildModuleCard(
              context,
              Icons.security_outlined,
              "Gizlilik & Veri Güvenliği",
              "\"Verilerim cihazımda saklanır\" gizlilik taahhüdü",
              GizlilikVeriPage(),
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
          child: Icon(icon, color: color, size: 24),
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
        trailing: Icon(Icons.chevron_right, color: Colors.white38),
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
            icon: const Icon(Icons.calculate),
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
          child: Icon(Icons.menu_book_outlined, color: Renkler.vurgu, size: 20),
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
          icon: const Icon(Icons.delete_outline, color: Colors.white38),
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

class HacUmrePage extends StatelessWidget {
  const HacUmrePage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Hac & Umre Rehberi", [
      _item("İhrama Girüş & Mikat", "Niyet ve Telbiye duası"),
      _item("Tavaf Adımları", "Kâbe etrafında 7 şavt"),
      _item("Sa'y", "Sefa ve Merve tepeleri arası yürüyüş"),
    ]);
  }
}

class DuaKardesligiPage extends StatelessWidget {
  const DuaKardesligiPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Dua Kardeşliği (Anonim)", [
      _item("Hayırlı sınav sonucu için dua", "124 kişi amin dedi"),
      _item("Şifa bekleyen bir anne için", "89 kişi amin dedi"),
      _item("Borçlardan kurtulmak için", "210 kişi amin dedi"),
    ]);
  }
}

class GunlukHedeflerPage extends StatelessWidget {
  const GunlukHedeflerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Günlük Hedefler & Streak", [
      _item("5 Vakit Namaz Takibi", "Bugün: 4/5 Tamamlandı"),
      _item("100 Esma / Zikir", "Tamamlandı (Seri: 7 Gün 🔥)"),
      _item("Günün Ayetini Oku", "Tamamlandı"),
    ]);
  }
}

class PaylasimKartlariPage extends StatelessWidget {
  const PaylasimKartlariPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Paylaşım Kartları Stüdyosu", [
      _item("İnşirah Suresi Kartı", "WhatsApp/Instagram Hikaye formatında"),
      _item("Cuma Mesajı Şablonları", "Hazır hat yazılı görseller"),
    ]);
  }
}

class KabeCanliPage extends StatelessWidget {
  const KabeCanliPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Kâbe-i Muazzama Canlı Yayın", [
      _item(
        "Mescid-i Haram 7/24 Canlı",
        "Hacerü'l-Esved ve Tavaf alanı canlı kamera akışı aktif.",
      ),
    ]);
  }
}

class DiniRadyoPage extends StatelessWidget {
  const DiniRadyoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Dini Radyo & İlahi Akışı", [
      _item("Kur'an-ı Kerim Meali Radyosu", "7/24 Kesintisiz Tilavet"),
      _item("Seçkin İlahiler ve Tasavvuf", "Huzur veren sesler"),
    ]);
  }
}

class GizlilikVeriPage extends StatelessWidget {
  const GizlilikVeriPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Gizlilik ve Veri Güvenliği", [
      _item(
        "Verileriniz Cihazınızda Kalır",
        "Uygulamamız hiçbir kişisel verinizi dış sunuculara kaydetmez. Tamamen uçtan uca gizlilik esasıyla çalışır.",
      ),
    ]);
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
