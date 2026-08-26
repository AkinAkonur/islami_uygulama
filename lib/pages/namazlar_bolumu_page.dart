import 'package:flutter/material.dart';
import '../screens/namaz_screen.dart';
import '../screens/guide_screen.dart';
import '../screens/wudu_screen.dart';
import '../screens/qada_screen.dart';
import '../screens/special_screen.dart';
import '../screens/gorsel_kilinis_screen.dart';
import '../widgets/kart_sekilleri.dart';

// ===========================================================================
// MODERNIZE EDİLMİŞ 3D NAMAZ PANELİ V2
// Koyu yeşil gradient zemin + altın (D4AF37) vurgular + 3D lüks kart efektleri.
// ===========================================================================

const Color _gold = Color(0xFFD4AF37);
const Color _bgTop = Color(0xFF1B3022);
const Color _bgBottom = Color(0xFF0B150E);
const Color _cardTop = Color(0xFF29432F);
const Color _cardBottom = Color(0xFF16271C);
const Color _cardDeep = Color(0xFF10201A);

class NamazlarBolumuPage extends StatefulWidget {
  const NamazlarBolumuPage({super.key});

  @override
  State<NamazlarBolumuPage> createState() => _NamazlarBolumuPageState();
}

class _NamazlarBolumuPageState extends State<NamazlarBolumuPage> {
  String _selectedMadhab = "Hanefî";
  int _activeStepIndex = 0;

  static const List<Map<String, String>> _namazSteps = [
    {
      "title": "1. İftitah Tekbiri & Kıyam",
      "desc":
          "Ayakta kıbleye yönelerek niyet edilir ve 'Allahu Ekber' denilerek eller kulak (erkekler) veya omuz (kadınlar) hizasına kaldırılıp göğüs üzerinde bağlanır.",
      "detail": "Okunanlar: Sübhaneke, Eûzü-Besmele, Fâtiha ve Zamm-ı Sure.",
    },
    {
      "title": "2. Rükû",
      "desc":
          "'Allahu Ekber' denilerek eğilir, eller dizlere konur ve en az üç kez 'Sübhâne Rabbiye'l-azîm' denir.",
      "detail": "Sırt düz, gözler secde yerine bakar. Sakinleşip doğrulunur.",
    },
    {
      "title": "3. Secde",
      "desc":
          "'Allahu Ekber' ile secdeye gidilir, en az üç kez 'Sübhâne Rabbiye'l-a'lâ' denir.",
      "detail": "Alın ve burun yere değer; iki secde arası oturulup sakinleşilir.",
    },
    {
      "title": "4. Kâde-i Âhire & Tahiyyat",
      "desc":
          "Son oturuşta Tahiyyat, Salli ve Bârik duaları okunarak selam vermeye hazırlanılır.",
      "detail": "Okunanlar: Ettehiyyâtü, Salli-Bârik, Rabbenâ üğlülleri.",
    },
    {
      "title": "5. Selam",
      "desc":
          "Önce sağ omuza, ardından sol omuza dönülerek 'Es-selâmü aleyküm ve rahmetullah' denir ve namaz tamamlanır.",
      "detail": "Namazdan sonra tesbih ve dua ile ibadet sonlandırılır.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgBottom,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_bgTop, _bgBottom],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _header(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _currentSectCard(),
                    const SizedBox(height: 20),
                    _sectionTitle("📂 Namaz Modülleri (Hızlı Erişim)"),
                    const SizedBox(height: 12),
                    _modulesGrid(),
                    const SizedBox(height: 20),
                    _sectionTitle("🚶‍♂️ İnteraktif Adım Adım Kılınış (Görsel Akış)"),
                    const SizedBox(height: 12),
                    _interactiveGuide(),
                    const SizedBox(height: 20),
                    _sectionTitle("💧 1. Hazırlık & Temizlik (6 Şart)"),
                    const SizedBox(height: 12),
                    _expandableTile(
                      "Abdest ve Gusül Rehberi",
                      "Adım adım abdest, gusül gerektiren durumlar, abdesti bozan 10+ madde.",
                      [
                        "• Farzları: Yüzü yıkamak, elleri kollarla beraber yıkamak, başın dörtte birini meshetmek, ayakları topuklarla beraber yıkamak.",
                        "• Sünnetleri: Besmele ile başlamak, elleri bileklere kadar yıkamak, ağız ve buruna su vermek, misvak kullanmak.",
                        "• Bozanlar: İdrar, dışkı, yellenme, kan/irin akması, ağız dolusu kusma, namazda sesli gülmek, uyku.",
                      ],
                      Icons.description_rounded,
                    ),
                    _expandableTile(
                      "Teyemmüm, Mest & Sargı Üzerine Mesh",
                      "Su bulunmadığında veya sağlık sorununda teyemmüm ve mesh hükümleri.",
                      [
                        "• Teyemmüm: Su bulunmadığında veya kullanma imkanı olmadığında temiz toprakla niyet edilerek alın ve kollara mesh edilir.",
                        "• Mest Üzerine Mesh: Abdestli iken giyilen mestler üzerine 24 saat (seferî için 72 saat) mesh edilebilir.",
                        "• Sargı/Alçı Üzerine Mesh: Yaralı organlar üzerindeki sargı veya alçı çıkarılması zararlı ise üzerine mesh çekilir.",
                      ],
                      Icons.public_rounded,
                    ),
                    const SizedBox(height: 20),
                    _sectionTitle("📐 2. Namazın Yapısı & Farzları"),
                    const SizedBox(height: 12),
                    _expandableTile(
                      "Dışındaki ve İçindeki Farzlar (Rükünler)",
                      "Namazın 6 dış şartı, 6 iç rüknü ve 10 vacibi.",
                      [
                        "• Dışındaki 6 Farz (Şart): Hadesten taharet, necasetten taharet, setr-i avret, kıst-ı vakit, kıble yönü, niyet.",
                        "• İçindeki 6 Farz (Rükün): İftitah tekbiri, kıyam, kıraat, rükû, secde, son oturuş.",
                        "• 10 Vacip: Fâtiha okumak, zamm-ı sure eklemek, ilk oturuşta Tahiyyat okumak, secde ve rükûda ta'dîl-i erkân, vb.",
                      ],
                      Icons.account_balance_rounded,
                    ),
                    _expandableTile(
                      "Sehiv Secdesi & Mekruh Vakitler",
                      "Yanlışlık durumunda secde ve namaz kılınmayan yasak vakitler.",
                      [
                        "• Sehiv Secdesi: Vacip olan bir şey unutularak terk edildiğinde veya geciktirildiğinde namazın sonunda yapılır.",
                        "• Mekruh Vakitler: Güneş doğarken (ilk 45 dk), tam tepedeyken (zeval), güneş batarken nafile namaz kılınmaz.",
                      ],
                      Icons.schedule_rounded,
                    ),
                    const SizedBox(height: 20),
                    _sectionTitle("🕒 3. 5 Vakit Rekat Tablosu"),
                    const SizedBox(height: 12),
                    _expandableTile(
                      "Vakitlere Göre Rekat Dağılımı",
                      "Sabah, Öğle, İkindi, Akşam, Yatsı ve Vitir rekatları.",
                      [
                        "• Sabah: 2 Sünnet, 2 Farz (Toplam 4)",
                        "• Öğle: 4 İlk Sünnet, 4 Farz, 2 Son Sünnet (Toplam 10)",
                        "• İkindi: 4 Sünnet, 4 Farz (Toplam 8)",
                        "• Akşam: 3 Farz, 2 Sünnet (Toplam 5)",
                        "• Yatsı: 4 Sünnet, 4 Farz, 2 Son Sünnet, 3 Vitir Vacip (Toplam 13)",
                      ],
                      Icons.access_time_rounded,
                    ),
                    const SizedBox(height: 20),
                    _sectionTitle("📜 4. Namazda Okunan Dualar & Sureler"),
                    const SizedBox(height: 12),
                    _expandableTile(
                      "Sübhaneke, Fâtiha, Zamm-ı Sureler ve Tahiyyat",
                      "Arapça metin, okunuş ve anlamları.",
                      [
                        "• Sübhaneke: Subhaneke Allahümme ve bi hamdik...",
                        "• Ettehiyyâtü: Et-tehiyyâtü lillâhi vessalevâtü vettayyibât...",
                        "• Salli & Bârik: Allâhümme salli alâ Muhammed...",
                        "• Rabbenâ Duaları: Rabbenâ âtinâ fi'ddünyâ haseneten...",
                      ],
                      Icons.menu_book_rounded,
                    ),
                    const SizedBox(height: 20),
                    _sectionTitle("🤲 5. Özel Durumlar & Kolaylıklar"),
                    const SizedBox(height: 12),
                    _expandableTile(
                      "Kaza, Seferî ve Hasta Namazı",
                      "Mazeretler, tertip kuralları ve oturanlar için ruhsatlar.",
                      [
                        "• Kaza Namazı: Kaçırılan farz namazlar tertibe uyularak kaza edilir (sünnetler kaza edilmez, sabah hariç).",
                        "• Seferîlik: 90 km ve üzeri yolculuklarda 4 rekatlı farzlar 2 rekat olarak kılınır.",
                        "• Hasta / Özürlü: Ayakta duramayacak olanlar oturarak, o da olmazsa yatarak ima ile kılabilir.",
                      ],
                      Icons.healing_rounded,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------- HEADER -------------------------
  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
      child: Row(
        children: [
          Expanded(
            child: _goldText(
              "Kapsamlı Namaz & Görsel Rehber",
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          _goldIconWrap(
            icon: Icons.compass_calibration_rounded,
            size: 22,
          ),
          const SizedBox(width: 10),
          _madhabDropdown(),
        ],
      ),
    );
  }

  Widget _madhabDropdown() {
    return Theme(
      data: ThemeData(brightness: Brightness.dark),
      child: PopupMenuButton<String>(
        initialValue: _selectedMadhab,
        color: _cardDeep,
        icon: const UcdIkon(ikon: Icons.expand_more_rounded, renk: _gold),
        onSelected: (v) => setState(() => _selectedMadhab = v),
        itemBuilder: (context) => ["Hanefî", "Şâfiî", "Mâlikî", "Hanbelî"]
            .map((m) => PopupMenuItem(
                  value: m,
                  child: Text(
                    "Mezhep: $m",
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ------------------- MEZHEP / CURRENT SECT CARD -------------------
  Widget _currentSectCard() {
    return _lux3dCard(
      padding: const EdgeInsets.all(18),
      radius: 22,
      gradientColors: const [_cardTop, _cardDeep],
      borderColor: _gold.withValues(alpha: 0.55),
      child: Row(
        children: [
          _goldIconBox(
            icon: Icons.explore_rounded,
            size: 34,
            boxSize: 60,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mezhep: $_selectedMadhab (Görsel Adım Rehberi)",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Tüm fıkhi detaylar, rekatlar, abdest ve interaktif kılınış adımları aşağıdadır.",
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------- MODULES GRID -------------------
  Widget _modulesGrid() {
    final items = <({IconData icon, String title, String subtitle, Widget page})>[
      (
        icon: Icons.nightlight_rounded,
        title: "Namaz & İbadet",
        subtitle: "Vakitler ve merkez",
        page: const NamazScreen(),
      ),
      (
        icon: Icons.menu_book_rounded,
        title: "Adım Adım Kılınış",
        subtitle: "Rehber & Stepper",
        page: const GuideScreen(),
      ),
      (
        icon: Icons.water_drop_rounded,
        title: "Abdest & Gusül",
        subtitle: "Temizlik Esasları",
        page: const WuduScreen(),
      ),
      (
        icon: Icons.calendar_month_rounded,
        title: "Kaza Takipçisi",
        subtitle: "Takvim & Liste",
        page: const QadaScreen(),
      ),
      (
        icon: Icons.health_and_safety_rounded,
        title: "Özel Durumlar",
        subtitle: "Seferî & Hasta",
        page: const SpecialScreen(),
      ),
      (
        icon: Icons.self_improvement_rounded,
        title: "Görsel Kılınış & Abdest",
        subtitle: "Şemalı Adım Rehberi",
        page: const GorselKilinisScreen(),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (context, i) {
        final it = items[i];
        return _moduleCard(it.icon, it.title, it.subtitle, it.page);
      },
    );
  }

  Widget _moduleCard(IconData icon, String title, String subtitle, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_cardTop, _cardDeep],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _gold.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
            BoxShadow(
              color: _gold.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFEED07A), Color(0xFF9A7B1E)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: _gold.withValues(alpha: 0.45),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: UcdIkon(ikon: icon, renk: const Color(0xFF10201A), boyut: 20),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 9,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------- INTERACTIVE GUIDE -------------------
  Widget _interactiveGuide() {
    final step = _namazSteps[_activeStepIndex];
    return _lux3dCard(
      padding: const EdgeInsets.all(18),
      radius: 22,
      gradientColors: const [_cardTop, _cardDeep],
      borderColor: _gold.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  step["title"]!,
                  style: const TextStyle(
                    color: _gold,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "Adım ${_activeStepIndex + 1} / ${_namazSteps.length}",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: (_activeStepIndex + 1) / _namazSteps.length,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation(_gold),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            step["desc"]!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _gold.withValues(alpha: 0.3)),
            ),
            child: Text(
              step["detail"]!,
              style: const TextStyle(
                color: _gold,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navButton(
                label: "Önceki Adım",
                filled: false,
                onTap: _activeStepIndex > 0
                    ? () => setState(() => _activeStepIndex--)
                    : null,
              ),
              _navButton(
                label: _activeStepIndex < _namazSteps.length - 1
                    ? "Sonraki Adım"
                    : "Başa Dön",
                filled: true,
                onTap: () => setState(() {
                  if (_activeStepIndex < _namazSteps.length - 1) {
                    _activeStepIndex++;
                  } else {
                    _activeStepIndex = 0;
                  }
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton({
    required String label,
    required bool filled,
    required VoidCallback? onTap,
  }) {
    final bg = filled
        ? const LinearGradient(colors: [_gold, Color(0xFFB8912B)])
        : const LinearGradient(colors: [Color(0xFF21382A), Color(0xFF15271C)]);
    final fg = filled ? const Color(0xFF12301F) : _gold;
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: bg,
          borderRadius: BorderRadius.circular(14),
          border: filled
              ? null
              : Border.all(color: _gold.withValues(alpha: 0.4)),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: _gold.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              label,
              style: TextStyle(
                color: fg,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------- EXPANDABLE TILES -------------------
  Widget _expandableTile(String title, String desc, List<String> items, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_cardTop, _cardBottom],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _gold.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          leading: _goldIconWrap(icon: icon, size: 22),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            desc,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 12,
            ),
          ),
          iconColor: _gold,
          collapsedIconColor: _gold,
          children: items.map((item) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.75),
                    fontSize: 12.5,
                    height: 1.55,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ------------------- SECTION TITLE -------------------
  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_gold, Color(0xFFB8912B)],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  // ------------------- LUX 3D CARD WRAPPER -------------------
  Widget _lux3dCard({
    required Widget child,
    required EdgeInsets padding,
    required double radius,
    required List<Color> gradientColors,
    Color? borderColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? _gold.withValues(alpha: 0.15)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          // Derinlik (3D) gölgesi
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          // Altın ambiyans
          BoxShadow(
            color: _gold.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Üst cam parlaması (glossy)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.35],
                ),
              ),
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }

  // ------------------- GOLD MISC -------------------
  Widget _goldIconWrap({required IconData icon, required double size}) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4AF37), Color(0xFF9A7B1E)],
        ),
        boxShadow: [
          BoxShadow(
            color: _gold.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: UcdIkon(ikon: icon, renk: const Color(0xFF10201A), boyut: size),
    );
  }

  Widget _goldIconBox({required IconData icon, required double size, required double boxSize}) {
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD4AF37), Color(0xFF8F7218)],
        ),
        boxShadow: [
          BoxShadow(
            color: _gold.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: UcdIkon(ikon: icon, renk: const Color(0xFF11230F), boyut: size),
    );
  }

  Widget _goldText(
    String text, {
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color color = _gold,
  }) {
    return Text(text, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}
