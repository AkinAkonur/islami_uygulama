import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../l10n/app_localizations.dart';
import '../l10n/dil_hizmetleri.dart';
import '../services/gemini_servisi.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

/// Dokunma imlecine göre X/Y ekseninde perspektifli olarak eğilen 3D kart.
/// Kartın içinden geçen ışık ve gölge derinlik hissi verir.
class _TiltKart extends StatefulWidget {
  final Widget child;
  final double maxTilt;

  const _TiltKart({required this.child, this.maxTilt = 0.09});

  @override
  State<_TiltKart> createState() => _TiltKartState();
}

class _TiltKartState extends State<_TiltKart> with TickerProviderStateMixin {
  late final Ticker _ticker;
  double _hedefX = 0, _hedefY = 0;
  double _x = 0, _y = 0;
  bool _aktif = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_tik)..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tik(Duration _) {
    final nx = _x + (_hedefX - _x) * 0.16;
    final ny = _y + (_hedefY - _y) * 0.16;
    if ((nx - _x).abs() < 0.0005 && (ny - _y).abs() < 0.0005 && !_aktif) {
      if (_x != 0 || _y != 0) {
        _x = 0;
        _y = 0;
        if (mounted) setState(() {});
      }
      return;
    }
    _x = nx;
    _y = ny;
    if (mounted) setState(() {});
  }

  void _git(Offset? konum, Size boyut) {
    if (!boyut.width.isFinite || !boyut.height.isFinite) {
      _aktif = false;
      _hedefX = 0;
      _hedefY = 0;
      return;
    }
    if (konum == null) {
      _aktif = false;
      _hedefX = 0;
      _hedefY = 0;
    } else {
      _aktif = true;
      _hedefX = ((konum.dx / boyut.width) - 0.5) * 2;
      _hedefY = ((konum.dy / boyut.height) - 0.5) * 2;
    }
    _ticker.start();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, kosullar) {
        final boyut = Size(kosullar.maxWidth, kosullar.maxHeight);
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0016)
            ..rotateY(_x * widget.maxTilt)
            ..rotateX(-_y * widget.maxTilt),
          child: Listener(
            onPointerDown: (e) => _git(e.localPosition, boyut),
            onPointerMove: (e) => _git(e.localPosition, boyut),
            onPointerUp: (_) => _git(null, boyut),
            onPointerCancel: (_) => _git(null, boyut),
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// Kartın üzerinden kayan parlak ışık çizgisi (specular yansıma).
class _ParlakYansima extends StatefulWidget {
  final double radius;

  const _ParlakYansima({this.radius = 20});

  @override
  State<_ParlakYansima> createState() => _ParlakYansimaState();
}

class _ParlakYansimaState extends State<_ParlakYansima>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2600),
  )..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          return LayoutBuilder(
            builder: (context, kosullar) {
              if (!kosullar.maxWidth.isFinite ||
                  !kosullar.maxHeight.isFinite) {
                return const SizedBox.shrink();
              }
              final yuzey = 140.0;
              final dx = (_c.value * (kosullar.maxWidth + 2 * yuzey)) - yuzey;
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.radius),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: dx,
                      width: yuzey,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withValues(alpha: 0),
                              Colors.white.withValues(alpha: 0.10),
                              Colors.white.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Hafif iç ışıklı, glossy üst vurgulu cam (glass) yüzey.
class _CamKart extends StatelessWidget {
  final Widget child;
  final double radius;
  final EdgeInsets padding;

  const _CamKart({
    required this.child,
    this.radius = 20,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Renkler.yuzey.withValues(alpha: 1),
            Renkler.kart,
            Renkler.zemin,
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: Renkler.cerceve2.withValues(alpha: 0.8),
          width: 0.8,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 1,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0),
                    Colors.white.withValues(alpha: 0.16),
                    Colors.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// AI kategorisi: kod, ikon ve modele giden ek talimat.
class _AiKategori {
  final String kod;
  final IconData ikon;
  final String talimat;

  const _AiKategori({
    required this.kod,
    required this.ikon,
    required this.talimat,
  });
}

class AiTefsirPage extends StatefulWidget {
  const AiTefsirPage({super.key});

  @override
  State<AiTefsirPage> createState() => _AiTefsirPageState();
}

class _AiTefsirPageState extends State<AiTefsirPage> {
  final TextEditingController _queryController = TextEditingController();
  final GeminiServisi _gemini = GeminiServisi();
  final ScrollController _kaydirma = ScrollController();
  String _seciliKategori = "tefsir";
  bool _isLoading = false;

  String? _yanitText;
  String? _hataText;

  @override
  void dispose() {
    _queryController.dispose();
    _kaydirma.dispose();
    super.dispose();
  }

  /// Kullanıcının istediği her konuyu bulabildiği kapsamlı kategori seti.
  static const List<_AiKategori> _kategoriler = [
    _AiKategori(
      kod: 'tefsir',
      ikon: Icons.menu_book_rounded,
      talimat: "Kur'an ayeti veya suresini klasik tefsirler (İbn Kesîr, "
          "Taberî, Râzî, Elmalılı) ve dilbilimsel açıklamayla detaylı yorumla. "
          "Ayet numarası verildiyse metni ve meramını açıkla.",
    ),
    _AiKategori(
      kod: 'fikih',
      ikon: Icons.mosque_rounded,
      talimat: "Namaz, oruç, zekât, hac, temizlik ve günlük ibadet konularında "
          "fıkıh mezheplerinin görüşlerini gözeterek sade ve pratik açıklamalar "
          "yap. Görüş farkı varsa kısaca belirt; kesin fetva gereken konularda "
          "bir âlime danışmayı hatırlat.",
    ),
    _AiKategori(
      kod: 'akaid',
      ikon: Icons.verified_user_rounded,
      talimat: "Akaid ve iman esaslarını (Allah'a iman, ahiret, melekler, "
          "kitaplar, peygamberler, kader) kaynaklarıyla ve sade biçimde açıkla.",
    ),
    _AiKategori(
      kod: 'hadis',
      ikon: Icons.collections_bookmark_rounded,
      talimat: "Hadis ve sünnet konularını kaynak göstererek (Buhârî, Müslim "
          "vb.) açıkla; sahih ile zayıf hadis arasındaki farkı belirt.",
    ),
    _AiKategori(
      kod: 'siyer',
      ikon: Icons.history_edu_rounded,
      talimat: "Peygamberimizin hayatı, sahabe ve İslam tarihi konularını "
          "kronolojik ve kaynaklı biçimde anlat.",
    ),
    _AiKategori(
      kod: 'dua',
      ikon: Icons.front_hand_rounded,
      talimat: "Dua, zikir ve tesbih konularında Kur'an'dan ve sahih "
          "kaynaklardan örnekler ver; Arapça metni, okunuşu ve anlamını "
          "birlikte sun.",
    ),
    _AiKategori(
      kod: 'aile',
      ikon: Icons.family_restroom_rounded,
      talimat: "Nikâh, evlilik, boşanma, anne-baba hakları, çocuk terbiyesi ve "
          "aile hayatı konularını İslam ahlakı çerçevesinde dengeli ve "
          "uygulanabilir biçimde açıkla.",
    ),
    _AiKategori(
      kod: 'teselli',
      ikon: Icons.volunteer_activism_rounded,
      talimat: "Kaygı, keder ve umutsuzluğa karşı Kur'an'dan ve hadislerden "
          "ferahlatıcı, şefkatli ve güven veren yanıtlar ver. Kısa, sıcak ve "
          "manevi bir üslup kullan.",
    ),
    _AiKategori(
      kod: 'karsilastirma',
      ikon: Icons.compare_arrows_rounded,
      talimat: "İki veya daha fazla konuyu (ayet, görüş, uygulama) yan yana "
          "karşılaştır; benzerlik ve farklılıkları tablo/madde halinde nesnel "
          "şekilde sun.",
    ),
    _AiKategori(
      kod: 'ogrenme',
      ikon: Icons.school_rounded,
      talimat: "Soruya net, düzenli, madde madde ve başlangıç seviyesinden "
          "akademik seviyeye açıklamalı eğitici bir yanıt ver. Terimleri "
          "tanımla ve örnek ver.",
    ),
  ];

  _AiKategori get _aktifKategori => _kategoriler.firstWhere(
        (k) => k.kod == _seciliKategori,
        orElse: () => _kategoriler.first,
      );

  /// Arkada gezinen yumuşak ışık küreleri (paralaks derinlik hissi).
  Widget _arkaPlan(double ofset) {
    final renk1 = Renkler.bannerUst.withValues(alpha: 0.22);
    final renk2 = Renkler.bannerAlt.withValues(alpha: 0.30);
    final renk3 = Renkler.vurgu.withValues(alpha: 0.10);
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            // Üstte parlayan tepe ışığı
            Positioned(
              top: -120 + ofset * 0.25,
              right: -60,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [renk1, Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 200 - ofset * 0.12,
              left: -80,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [renk2, Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -100 + ofset * 0.18,
              right: -40,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [renk3, Colors.transparent],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _kaydirmaOfset() =>
      _kaydirma.hasClients ? _kaydirma.offset : 0.0;

  Future<void> _askAi(String query) async {
    if (query.trim().isEmpty || _isLoading) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
      _yanitText = null;
      _hataText = null;
    });

    try {
      if (!_gemini.hazir) {
        throw const GemiException(
          "API anahtarı tanımlı değil.\nDerleme: flutter run --dart-define=GEMINI_API_KEY=<anahtar>",
        );
      }
      final kategori = _aktifKategori;
      final dilKod = DilHizmetleri.aktifDil.value.languageCode;
      final text = await _gemini.sor(
        query,
        dilKodu: dilKod,
        ekTalimat: "${kategori.kod.toUpperCase()} MODU etkin. ${kategori.talimat}",
      );
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _yanitText = text;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _hataText = 'Hata: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF01140E),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leadingWidth: 68,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Center(
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0C382A), Color(0xFF021711)],
                ),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.3),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Color(0xFF34D399),
                  size: 18,
                ),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  l.t('ai.title'),
                  style: const TextStyle(
                    color: Color(0xFFFFD54F),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF34D399),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF34D399).withValues(alpha: 0.6),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              l.t('ai.subtitle'),
              style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
            ),
          ],
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF143B2C), Color(0xFF09241A)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFFFFC107).withValues(alpha: 0.5),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x33FFD54F),
                      offset: const Offset(0, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFFFD54F),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l.t('ai.gunlukHak'),
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          '5 / 5',
                          style: TextStyle(
                            color: Color(0xFFFFD54F),
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _kaydirma,
            builder: (context, _) => _arkaPlan(_kaydirmaOfset()),
          ),
          SingleChildScrollView(
            controller: _kaydirma,
            padding:
                EdgeInsets.fromLTRB(18, kToolbarHeight + 16, 18, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fetvaKarti(l),
                const SizedBox(height: 20),
                _bolumBaslik(l, l.t('ai.mode'),
                    actionText: l.t('ai.modeAlt')),
                const SizedBox(height: 12),
                _kategoriSecici(l),
                const SizedBox(height: 24),
                _soruAlan(l),
                const SizedBox(height: 24),
                _bolumBaslik(l, l.t('ai.ornekBaslik'),
                    actionText: l.t('ai.dokunSoru'), isLightning: true),
                const SizedBox(height: 12),
                _hizliOrnekler(l),
                const SizedBox(height: 24),
                _bolumBaslik(l, l.t('ai.tefekkur'),
                    actionText: l.t('ai.tefekkurKaynak')),
                const SizedBox(height: 12),
                _tefekkurKarti(),
                const SizedBox(height: 20),

                if (_isLoading)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                          CircularProgressIndicator(color: Renkler.vurgu),
                        ],
                      ),
                    ),
                  ),

                if (!_isLoading &&
                    !_gemini.hazir &&
                    _yanitText == null &&
                    _hataText == null)
                  _apiUyarisi(l),

                if (_hataText != null) _hataKarti(l),

                if (_yanitText != null) _yanitKarti(l),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- ANA BÖLÜMLER ----------------

  Widget _bolumBaslik(AppLocalizations l, String title,
      {String? actionText, bool isLightning = false}) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 14,
          decoration: BoxDecoration(
            color: const Color(0xFFFFC107),
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFC107).withValues(alpha: 0.5),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        if (isLightning) ...[
          const Icon(Icons.bolt, color: Color(0xFFFFC107), size: 14),
          const SizedBox(width: 2),
        ],
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFFFD54F),
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        const Spacer(),
        if (actionText != null)
          Text(
            actionText,
            style: const TextStyle(
              color: Color(0xFF34D399),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _fetvaKarti(AppLocalizations l) {
    final metin = l.t('ai.disclaimer');
    final idx = metin.indexOf('fetva');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A3326), Color(0xFF031F16)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFFFC107).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            offset: const Offset(0, 6),
            blurRadius: 14,
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const RadialGradient(
                    colors: [Color(0xFF332608), Color(0xFF141003)],
                  ),
                  border: Border.all(
                    color: const Color(0xFFFFC107).withValues(alpha: 0.6),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFC107).withValues(alpha: 0.25),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Color(0xFFFFD54F),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.t('ai.noticeTitle'),
                      style: const TextStyle(
                        color: Color(0xFFFFD54F),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color(0xFFD1FAE5),
                          fontSize: 11.5,
                          height: 1.45,
                        ),
                        children: [
                          if (idx >= 0) ...[
                            TextSpan(text: metin.substring(0, idx)),
                            TextSpan(
                              text: metin.substring(idx, idx + 5),
                              style: const TextStyle(
                                color: Color(0xFFFFD54F),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            TextSpan(
                                text: metin.substring(idx + 5)),
                          ] else
                            TextSpan(text: metin),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned.fill(child: _ParlakYansima(radius: 16)),
        ],
      ),
    );
  }

  Widget _kategoriSecici(AppLocalizations l) {
    return SizedBox(
      height: 64,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _kategoriler.length,
        itemBuilder: (context, index) {
          final kategori = _kategoriler[index];
          final isSelected = kategori.kod == _seciliKategori;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _seciliKategori = kategori.kod),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF164736), Color(0xFF08271C)],
                      )
                    : const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF07261C), Color(0xFF021711)],
                      ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFFFC107)
                      : const Color(0xFF10B981).withValues(alpha: 0.2),
                  width: isSelected ? 1.5 : 1.0,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0x33FFD54F),
                          offset: const Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          offset: const Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    kategori.ikon,
                    size: 16,
                    color: isSelected
                        ? const Color(0xFFFFD54F)
                        : const Color(0xFF34D399),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    l.t('ai.c.${kategori.kod}'),
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF94A3B8),
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _soruAlan(AppLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l.t('ai.yardimBaslik'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.star, color: Color(0xFFFFC107), size: 12),
                const SizedBox(width: 4),
                Text(
                  l.t('ai.c.${_aktifKategori.kod}'),
                  style: const TextStyle(
                    color: Color(0xFFFFD54F),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF031C14),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFF10B981).withValues(alpha: 0.3),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF0F4735), Color(0xFF05251B)],
                      ),
                      border: Border.all(
                        color: const Color(0xFF34D399).withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFF34D399),
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _queryController,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                      cursorColor: const Color(0xFF34D399),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _askAi(_queryController.text),
                      decoration: InputDecoration(
                        hintText: l.t('ai.hint'),
                        hintStyle: const TextStyle(
                          color: Color(0xFF5A786E),
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF082E22),
                      border: Border.all(
                        color: const Color(0xFF10B981).withValues(alpha: 0.2),
                      ),
                    ),
                    child: const Icon(
                      Icons.mic_none_rounded,
                      color: Color(0xFF34D399),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () => _askAi(_queryController.text),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFFFE082), Color(0xFFFFB300)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFC107).withValues(alpha: 0.4),
                            offset: const Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: _isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(10),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Color(0xFF2E1C00),
                              ),
                            )
                          : const Icon(
                              Icons.arrow_upward_rounded,
                              color: Color(0xFF2E1C00),
                              size: 22,
                            ),
                    ),
                  ),
                ],
              ),
              Positioned.fill(child: _ParlakYansima(radius: 22)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _hizliOrnekler(AppLocalizations l) {
    final kategori = _aktifKategori;
    return Column(
      children: [
        for (var i = 1; i <= 3; i++)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final soru = l.t('ai.cs.${kategori.kod}.$i');
              _queryController.text = soru;
              _askAi(soru);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF093124), Color(0xFF031E15)],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.25),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(kategori.ikon,
                      color: const Color(0xFF34D399), size: 18),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l.t('ai.cs.${kategori.kod}.$i'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFF047857),
                    size: 13,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _tefekkurKarti() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B3B2B), Color(0xFF041F16)],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFFC107).withValues(alpha: 0.4),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            offset: const Offset(0, 8),
            blurRadius: 18,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFFC107).withValues(alpha: 0.18),
                  border: Border.all(
                    color: const Color(0xFFFFC107).withValues(alpha: 0.5),
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Color(0xFFFFD54F),
                  size: 16,
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nur AI • Âlim Modu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Tefsir Analizi',
                      style: TextStyle(
                        color: Color(0xFF34D399),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFF34D399).withValues(alpha: 0.3),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check,
                        color: Color(0xFF34D399), size: 12),
                    SizedBox(width: 4),
                    Text(
                      'Onaylı Tefsir',
                      style: TextStyle(
                        color: Color(0xFF34D399),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFFD54F),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.5,
              shadows: [
                Shadow(
                  color: Color(0x33FFD54F),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '"Andolsun, eğer şükrederseniz elbette size nimetimi artırırım."',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFD1FAE5),
              fontSize: 12.5,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'İBRAHİM SURESİ, 7. AYET',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFFFC107),
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: const Color(0xFF031A12),
              border: Border.all(
                color: const Color(0xFF10B981).withValues(alpha: 0.2),
              ),
            ),
            child: const Text.rich(
              TextSpan(
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 11.5,
                  height: 1.45,
                ),
                children: [
                  TextSpan(
                    text: 'Kısa Tefsir Özeti: ',
                    style: TextStyle(
                      color: Color(0xFFFFD54F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "Şükür sadece dille 'elhamdülillah' demek değil; "
                        'verilen her nimeti (akıl, sağlık, mal) Allah\'ın '
                        'rızasına uygun sarf etmektir.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              final soru = 'İbrahim Suresi 7. ayetin tefsirini yap.';
              _queryController.text = soru;
              _askAi(soru);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0F4735), Color(0xFF05251B)],
                ),
                border: Border.all(
                  color: const Color(0xFFFFC107).withValues(alpha: 0.4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sohbeti Başlat & Tefsiri Derinleştir',
                    style: TextStyle(
                      color: Color(0xFFFFD54F),
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward,
                      color: Color(0xFFFFD54F), size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _apiUyarisi(AppLocalizations l) {
    return _TiltKart(
      child: _CamKart(
        radius: 16,
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Renkler.vurgu, Renkler.bannerAlt],
                ),
              ),
              child: UcdIkon(ikon: Icons.key_off_rounded, renk: Colors.white, boyut: 20),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.t('ai.apiMissingTitle'),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    l.t('ai.apiMissingBody'),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.5,
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

  Widget _hataKarti(AppLocalizations l) {
    return _TiltKart(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.redAccent.withValues(alpha: 0.15),
              Renkler.zemin,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.redAccent.withValues(alpha: 0.6)),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent.withValues(alpha: 0.2),
              ),
              child:
                  UcdIkon(ikon: Icons.error_outline_rounded, renk: Colors.redAccent, boyut: 20),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                _hataText!,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _yanitKarti(AppLocalizations l) {
    final kategori = _aktifKategori;
    return _TiltKart(
      child: _CamKart(
        radius: 24,
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Renkler.vurgu, Renkler.bannerAlt],
                        ),
                      ),
                      child: UcdIkon(ikon: Icons.auto_awesome,
                          renk: Colors.white, boyut: 20),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "${l.t('ai.answerTitle')} (${l.t('ai.c.${kategori.kod}')})",
                        style: TextStyle(
                          color: Renkler.acikVurgu,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Renkler.cerceve2, height: 24),
                Text(
                  _yanitText!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Renkler.vurgu.withValues(alpha: 0.12),
                        Renkler.zemin.withValues(alpha: 0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Renkler.cerceve2,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UcdIkon(ikon: Icons.verified_user_rounded,
                          renk: Renkler.vurgu, boyut: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "${l.t('ai.kaynak')}: ${l.t('ai.kaynakNot')}",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _TiltKart(
                      maxTilt: 0.2,
                      child: IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l.t('ai.fbUp'))),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                        ),
                        icon: UcdIkon(ikon: Icons.thumb_up_rounded,
                            renk: Colors.white60, boyut: 20),
                      ),
                    ),
                    SizedBox(width: 8),
                    _TiltKart(
                      maxTilt: 0.2,
                      child: IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l.t('ai.fbDown'))),
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                        ),
                        icon: UcdIkon(ikon: Icons.thumb_down_rounded,
                            renk: Colors.white60, boyut: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned.fill(child: _ParlakYansima(radius: 24)),
          ],
        ),
      ),
    );
  }
}