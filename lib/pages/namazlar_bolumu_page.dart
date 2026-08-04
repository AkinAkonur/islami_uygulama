import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../screens/namaz_screen.dart';
import '../screens/guide_screen.dart';
import '../screens/wudu_screen.dart';
import '../screens/qada_screen.dart';
import '../screens/special_screen.dart';
import '../screens/gorsel_kilinis_screen.dart';

class NamazlarBolumuPage extends StatefulWidget {
  const NamazlarBolumuPage({super.key});

  @override
  State<NamazlarBolumuPage> createState() => _NamazlarBolumuPageState();
}

class _NamazlarBolumuPageState extends State<NamazlarBolumuPage> {
  String _selectedMadhab = "Hanefî";
  int _activeStepIndex = 0;

  final List<Map<String, String>> _namazSteps = [
    {
      "title": "1. İftitah Tekbiri & Kıyam",
      "desc": "Ayakta kıbleye yönelerek niyet edilir ve 'Allahu Ekber' denilerek eller kulak (erkekler) veya omuz (kadınlar) hizasına kaldırılıp göğüs üzerinde bağlanır.",
      "detail": "Okunanlar: Sübhaneke, Eûzü-Besmele, Fâtiha ve Zamm-ı Sure."
    },
    {
      "title": "2. Rükû",
      "desc": "'Allahu Ekber' diyerek bel 90 derece bükülür, eller diz kapakları üzerine konur ve sırt düz tutulur.",
      "detail": "Zikir: 3 defa 'Sübhane rabbiye'l-azîm' denir."
    },
    {
      "title": "3. Kavme (Rükûdan Doğrulma)",
      "desc": "'Semiallâhu limen hamideh' diyerek tam dik duruşa geçilir ve ardından 'Rabbena leke'l-hamd' denir.",
      "detail": "Ayakta sükûnetle durulur."
    },
    {
      "title": "4. Secde (1. ve 2. Secde)",
      "desc": "'Allahu Ekber' denilerek alın, burun, eller, dizler ve ayak parmakları yere konur.",
      "detail": "Zikir: 3 defa 'Sübhane rabbiye'l-a'lâ' denir."
    },
    {
      "title": "5. Oturuş (Kaide-i Ula / Akhire)",
      "desc": "İki secde arasında kısa bir oturuş (Celse) yapıldıktan sonra son oturuşta Ettehiyyâtü, Salli-Bârik ve Rabbenâ duaları okunur.",
      "detail": "Selâm: Önce sağ omuza 'Es-selâmu aleyküm ve rahmetullah', sonra sol omuza verilerek namaz tamamlanır."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("Kapsamlı Namaz & Görsel Rehber"),
        backgroundColor: Renkler.seciliYuzey,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: DropdownButton<String>(
              value: _selectedMadhab,
              dropdownColor: Renkler.seciliYuzey,
              style: TextStyle(color: Renkler.vurgu, fontWeight: FontWeight.bold, fontSize: 13),
              underline: SizedBox(),
              items: ["Hanefî", "Şâfiî", "Mâlikî", "Hanbelî"].map((m) {
                return DropdownMenuItem(value: m, child: Text("Mezhep: $m"));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedMadhab = val);
              },
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Banner & Madhab status
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Renkler.seciliYuzey, Renkler.zemin],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.accessibility_new, color: Renkler.vurgu, size: 36),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mezhep: $_selectedMadhab (Görsel Adım Rehberi)",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Tüm fıkhi detaylar, rekatlar, abdest ve interaktif kılınış adımları aşağıdadır.",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // HIZLI ERİŞİM: Hazır ekranlar
          _sectionTitle("📂 Namaz Modülleri (Hızlı Erişim)"),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: [
              _hizliKart(context, Icons.nightlight, "Namaz & İbadet", "Vakitler ve merkez", NamazScreen(), Colors.green),
              _hizliKart(context, Icons.menu_book, "Adım Adım Kılınış", "Rehber & Stepper", GuideScreen(), Colors.lightGreen),
              _hizliKart(context, Icons.water_drop, "Abdest & Gusül", "Temizlik Esasları", WuduScreen(), Colors.teal),
              _hizliKart(context, Icons.calendar_today, "Kaza Takipçisi", "Takvim & Liste", QadaScreen(), Colors.orange),
              _hizliKart(context, Icons.healing, "Özel Durumlar", "Seferî & Hasta", SpecialScreen(), Colors.blueAccent),
              _hizliKart(context, Icons.self_improvement, "Görsel Kılınış & Abdest", "Şemalı Adım Rehberi", GorselKilinisScreen(), Colors.cyan),
            ],
          ),
          SizedBox(height: 20),

          // İNTERAKTİF ADIM ADIM KILINIŞ REHBERİ
          _sectionTitle("🚶‍♂️ İnteraktif Adım Adım Kılınış (Görsel Akış)"),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Renkler.cerceve2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _namazSteps[_activeStepIndex]["title"]!,
                      style: TextStyle(color: Renkler.vurgu, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Adım ${_activeStepIndex + 1} / ${_namazSteps.length}",
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  _namazSteps[_activeStepIndex]["desc"]!,
                  style: TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Renkler.cerceve2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _namazSteps[_activeStepIndex]["detail"]!,
                    style: TextStyle(color: Renkler.vurgu, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Renkler.cerceve2,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _activeStepIndex > 0
                          ? () => setState(() => _activeStepIndex--)
                          : null,
                      child: Text("Önceki Adım"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Renkler.vurgu,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: _activeStepIndex < _namazSteps.length - 1
                          ? () => setState(() => _activeStepIndex++)
                          : () => setState(() => _activeStepIndex = 0),
                      child: Text(_activeStepIndex < _namazSteps.length - 1 ? "Sonraki Adım" : "Başa Dön"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // DİĞER KAPSAMLI BÖLÜMLER
          _sectionTitle("💧 1. Hazırlık & Temizlik (6 Şart)"),
          _expandableTile("Abdest ve Gusül Rehberi", "Adım adım abdest, gusül gerektiren durumlar, abdesti bozan 10+ madde.", [
            "• Farzları: Yüzü yıkamak, elleri kollarla beraber yıkamak, başın dörtte birini meshetmek, ayakları topuklarla beraber yıkamak.",
            "• Sünnetleri: Besmele ile başlamak, elleri bileklere kadar yıkamak, ağız ve buruna su vermek, misvak kullanmak.",
            "• Bozanlar: İdrar, dışkı, yellenme, kan/irin akması, ağız dolusu kusma, namazda sesli gülmek, uyku."
          ]),
          _expandableTile("Teyemmüm, Mest & Sargı Üzerine Mesh", "Su bulunmadığında veya sağlık sorununda teyemmüm ve mesh hükümleri.", [
            "• Teyemmüm: Su bulunmadığında veya kullanma imkanı olmadığında temiz toprakla niyet edilerek alın ve kollara mesh edilir.",
            "• Mest Üzerine Mesh: Abdestli iken giyilen mestler üzerine 24 saat (seferî için 72 saat) mesh edilebilir.",
            "• Sargı/Alçı Üzerine Mesh: Yaralı organlar üzerindeki sargı veya alçı çıkarılması zararlı ise üzerine mesh çekilir."
          ]),

          _sectionTitle("📐 2. Namazın Yapısı & Farzları"),
          _expandableTile("Dışındaki ve İçindeki Farzlar (Rükünler)", "Namazın 6 dış şartı, 6 iç rüknü ve 10 vacibi.", [
            "• Dışındaki 6 Farz (Şart): Hadesten taharet, necasetten taharet, setr-i avret, kıst-ı vakit, kıble yönü, niyet.",
            "• İçindeki 6 Farz (Rükün): İftitah tekbiri, kıyam, kıraat, rükû, secde, son oturuş.",
            "• 10 Vacip: Fâtiha okumak, zamm-ı sure eklemek, ilk oturuşta Tahiyyat okumak, secde ve rükûda ta'dîl-i erkân, vb."
          ]),
          _expandableTile("Sehiv Secdesi & Mekruh Vakitler", "Yanlışlık durumunda secde ve namaz kılınmayan yasak vakitler.", [
            "• Sehiv Secdesi: Vacip olan bir şey unutularak terk edildiğinde veya geciktirildiğinde namazın sonunda yapılır.",
            "• Mekruh Vakitler: Güneş doğarken (ilk 45 dk), tam tepedeyken (zeval), güneş batarken nafile namaz kılınmaz."
          ]),

          _sectionTitle("🕒 3. 5 Vakit Rekat Tablosu"),
          _expandableTile("Vakitlere Göre Rekat Dağılımı", "Sabah, Öğle, İkindi, Akşam, Yatsı ve Vitir rekatları.", [
            "• Sabah: 2 Sünnet, 2 Farz (Toplam 4)",
            "• Öğle: 4 İlk Sünnet, 4 Farz, 2 Son Sünnet (Toplam 10)",
            "• İkindi: 4 Sünnet, 4 Farz (Toplam 8)",
            "• Akşam: 3 Farz, 2 Sünnet (Toplam 5)",
            "• Yatsı: 4 Sünnet, 4 Farz, 2 Son Sünnet, 3 Vitir Vacip (Toplam 13)"
          ]),

          _sectionTitle("📜 4. Namazda Okunan Dualar & Sureler"),
          _expandableTile("Sübhaneke, Fâtiha, Zamm-ı Sureler ve Tahiyyat", "Arapça metin, okunuş ve anlamları.", [
            "• Sübhaneke: Subhaneke Allahümme ve bi hamdik...",
            "• Ettehiyyâtü: Et-tehiyyâtü lillâhi vessalevâtü vettayyibât...",
            "• Salli & Bârik: Allâhümme salli alâ Muhammed...",
            "• Rabbenâ Duaları: Rabbenâ âtinâ fi'ddünyâ haseneten..."
          ]),

          _sectionTitle("🤲 5. Özel Durumlar & Kolaylıklar"),
          _expandableTile("Kaza, Seferî ve Hasta Namazı", "Mazeretler, tertip kuralları ve oturanlar için ruhsatlar.", [
            "• Kaza Namazı: Kaçırılan farz namazlar tertibe uyularak kaza edilir (sünnetler kaza edilmez, sabah hariç).",
            "• Seferîlik: 90 km ve üzeri yolculuklarda 4 rekatlı farzlar 2 rekat olarak kılınır.",
            "• Hasta / Özürlü: Ayakta duramayacak olanlar oturarak, o da olmazsa yatarak ima ile kılabilir."
          ]),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Renkler.vurgu,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _hizliKart(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget targetPage,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => targetPage),
      ),
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandableTile(String title, String subtitle, List<String> bulletPoints) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve2),
      ),
      child: ExpansionTile(
        collapsedIconColor: Renkler.vurgu,
        iconColor: Renkler.vurgu,
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white60, fontSize: 11),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: bulletPoints
                  .map((bp) => Padding(
                        padding: EdgeInsets.only(bottom: 6.0),
                        child: Text(
                          bp,
                          style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
