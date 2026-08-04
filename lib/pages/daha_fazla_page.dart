import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../screens/namaz_screen.dart';

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
              Icons.person_outline,
              "Namaz Rehberi",
              "Kılınış, abdest, rekatlar ve nafile namazlar",
              NamazScreen(),
              Colors.greenAccent,
            ),
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
              Icons.explore_outlined,
              "Kıble & Cami Bul",
              "Pusula ile Kâbe yönü ve yakındaki camiler",
              KibleCamiPage(),
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

class NamazRehberiPage extends StatelessWidget {
  const NamazRehberiPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Namaz Rehberi", [
      _item("Abdest Nasıl Alınır?", "Adım adım sünnete uygun abdest tarifi ve duaları."),
      _item("Beş Vakit Namaz Kılınışı", "Sabah, Öğle, İkindi, Akşam ve Yatsı namazlarının rekatları ve duaları."),
      _item("Nafile Namazlar", "Teheccüt, Kuşha, Tesbih ve Tevekkül namazlarının faziletleri."),
    ]);
  }
}

class EsmaulHusnaPage extends StatelessWidget {
  const EsmaulHusnaPage({super.key});
  @override
  Widget build(BuildContext context) {
    final list = [
      {"name": "Allah", "meaning": "Eşi benzeri olmayan tek ilah"},
      {"name": "Ar-Rahman", "meaning": "Dünyada bütün mahlukata merhamet eden"},
      {"name": "Ar-Rahim", "meaning": "Ahirette sadece müminlere merhamet eden"},
      {"name": "El-Melik", "meaning": "Mülkün gerçek sahibi ve mutlak hükümdarı"},
      {"name": "El-Kuddus", "meaning": "Her türlü eksiklikten uzak ve mukaddes"},
      {"name": "Es-Selam", "meaning": "Selamet veren, huzur ve emniyet bahşeden"},
    ];
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(title: Text("Esma-ül Hüsna"), backgroundColor: Renkler.seciliYuzey),
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
                child: Text("${index + 1}", style: TextStyle(color: Colors.amber)),
              ),
              title: Text(item["name"]!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              subtitle: Text(item["meaning"]!, style: TextStyle(color: Colors.white70)),
            ),
          );
        },
      ),
    );
  }
}

class KibleCamiPage extends StatelessWidget {
  const KibleCamiPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Kıble & Cami Bul", [
      _item("Kıble Pusulası", "Bulunduğunuz konuma göre Kâbe yönü: 154° GD"),
      _item("Yakındaki Camiler", "GPS konumunuza en yakın camiler ve mescitler listeleniyor."),
    ]);
  }
}

class HicriTakvimPage extends StatelessWidget {
  const HicriTakvimPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Hicri Takvim & Önemli Günler", [
      _item("Bugün: 18 Safer 1448", "Mübarek üç aylara ve kandillere kalan süreler."),
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
  final TextEditingController _nakitController = TextEditingController();
  double _sonuc = 0;

  void _hesapla() {
    final val = double.tryParse(_nakitController.text) ?? 0;
    setState(() {
      _sonuc = val * 0.025;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(title: Text("Zekat Hesaplayıcı"), backgroundColor: Renkler.seciliYuzey),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nakit / Altın / Ticaret Malı Toplamı (TL)", style: TextStyle(color: Colors.white70)),
            SizedBox(height: 8),
            TextField(
              controller: _nakitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Renkler.kart,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                hintText: "Örn: 100000",
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Renkler.vurgu),
              onPressed: _hesapla,
              child: Text("Zekatını Hesapla"),
            ),
            SizedBox(height: 24),
            Text("Vermeniz Gereken Zekat: ${_sonuc.toStringAsFixed(2)} TL", style: TextStyle(color: Colors.amberAccent, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class HatimTakibiPage extends StatelessWidget {
  const HatimTakibiPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Hatim Takibi", [
      _item("1. Cüz - Bakara Suresi", "%100 Tamamlandı"),
      _item("2. Cüz - Bakara Suresi", "%45 İlerleme"),
      _item("3. Cüz - Al-i İmran", "Henüz Başlanmadı"),
    ]);
  }
}

class HadisKutuphanesiPage extends StatelessWidget {
  const HadisKutuphanesiPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Hadis-i Şerif Kütüphanesi", [
      _item("Ameller Niyetlere Göredir", "Buhari, Bed'ül-Vahy, 1"),
      _item("İki Nimet Vardır...", "Sahh-i Buhari, Rikak, 1"),
      _item("Kolaylaştırın, Zorlaştırmayın", "Buhari, İlim, 11"),
    ]);
  }
}

class KissalarPage extends StatelessWidget {
  const KissalarPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Peygamber Kıssaları & Sîre", [
      _item("Hz. Yusuf'un Sabrı", "Kuyudan Mısır Sultanlığına uzanan ilahi hikmet."),
      _item("Hz. Eyüp'ün İmtihanı", "Sabır ve tevekkülün en büyük timsali."),
      _item("Asr-ı Saadet Hatıraları", "Sahabelerin örnek hayatları."),
    ]);
  }
}

class SoruCevapPage extends StatelessWidget {
  const SoruCevapPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _buildStandardSubPage("Soru & Cevap (İlmihal SSS)", [
      _item("Sehiv Secdesi Ne Zaman Yapılır?", "Namazda unutulan veya geciktirilen vacipler için..."),
      _item("Abdesti Bozan Durumlar Nelerdir?", "Yara kanaması, uyku, tuvalet ihtiyacı vb."),
      _item("Oruçluyken Sakız Çiğnemek Orucu Bozar mı?", "İçindeki tatlandırıcı ve parçacıklar mideye ulaşırsa..."),
    ]);
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
      _item("Mescid-i Haram 7/24 Canlı", "Hacerü'l-Esved ve Tavaf alanı canlı kamera akışı aktif."),
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
      _item("Verileriniz Cihazınızda Kalır", "Uygulamamız hiçbir kişisel verinizi dış sunuculara kaydetmez. Tamamen uçtan uca gizlilik esasıyla çalışır."),
    ]);
  }
}

Widget _buildStandardSubPage(String title, List<Widget> children) {
  return Scaffold(
    backgroundColor: Renkler.zemin,
    appBar: AppBar(title: Text(title), backgroundColor: Renkler.seciliYuzey),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: children,
    ),
  );
}

Widget _item(String title, String subtitle) {
  return Card(
    color: Renkler.kart,
    margin: EdgeInsets.only(bottom: 10),
    child: ListTile(
      title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.white70, fontSize: 12)),
    ),
  );
}
