import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../l10n/app_localizations.dart';
import '../l10n/dil_hizmetleri.dart';
import '../services/gemini_servisi.dart';
import '../services/renkler.dart';

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
        boxShadow: [
          BoxShadow(
            color: Renkler.vurgu.withValues(alpha: 0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
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
      ikon: Icons.menu_book,
      talimat: "Kur'an ayeti veya suresini klasik tefsirler (İbn Kesîr, "
          "Taberî, Râzî, Elmalılı) ve dilbilimsel açıklamayla detaylı yorumla. "
          "Ayet numarası verildiyse metni ve meramını açıkla.",
    ),
    _AiKategori(
      kod: 'fikih',
      ikon: Icons.mosque,
      talimat: "Namaz, oruç, zekât, hac, temizlik ve günlük ibadet konularında "
          "fıkıh mezheplerinin görüşlerini gözeterek sade ve pratik açıklamalar "
          "yap. Görüş farkı varsa kısaca belirt; kesin fetva gereken konularda "
          "bir âlime danışmayı hatırlat.",
    ),
    _AiKategori(
      kod: 'akaid',
      ikon: Icons.verified_user,
      talimat: "Akaid ve iman esaslarını (Allah'a iman, ahiret, melekler, "
          "kitaplar, peygamberler, kader) kaynaklarıyla ve sade biçimde açıkla.",
    ),
    _AiKategori(
      kod: 'hadis',
      ikon: Icons.collections_bookmark,
      talimat: "Hadis ve sünnet konularını kaynak göstererek (Buhârî, Müslim "
          "vb.) açıkla; sahih ile zayıf hadis arasındaki farkı belirt.",
    ),
    _AiKategori(
      kod: 'siyer',
      ikon: Icons.history_edu,
      talimat: "Peygamberimizin hayatı, sahabe ve İslam tarihi konularını "
          "kronolojik ve kaynaklı biçimde anlat.",
    ),
    _AiKategori(
      kod: 'dua',
      ikon: Icons.front_hand,
      talimat: "Dua, zikir ve tesbih konularında Kur'an'dan ve sahih "
          "kaynaklardan örnekler ver; Arapça metni, okunuşu ve anlamını "
          "birlikte sun.",
    ),
    _AiKategori(
      kod: 'aile',
      ikon: Icons.family_restroom,
      talimat: "Nikâh, evlilik, boşanma, anne-baba hakları, çocuk terbiyesi ve "
          "aile hayatı konularını İslam ahlakı çerçevesinde dengeli ve "
          "uygulanabilir biçimde açıkla.",
    ),
    _AiKategori(
      kod: 'teselli',
      ikon: Icons.volunteer_activism,
      talimat: "Kaygı, keder ve umutsuzluğa karşı Kur'an'dan ve hadislerden "
          "ferahlatıcı, şefkatli ve güven veren yanıtlar ver. Kısa, sıcak ve "
          "manevi bir üslup kullan.",
    ),
    _AiKategori(
      kod: 'karsilastirma',
      ikon: Icons.compare_arrows,
      talimat: "İki veya daha fazla konuyu (ayet, görüş, uygulama) yan yana "
          "karşılaştır; benzerlik ve farklılıkları tablo/madde halinde nesnel "
          "şekilde sun.",
    ),
    _AiKategori(
      kod: 'ogrenme',
      ikon: Icons.school,
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
      backgroundColor: Renkler.zemin,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [Colors.white, Renkler.acikVurgu],
          ).createShader(bounds),
          child: const Text(
            'AI',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: _TiltKart(
                maxTilt: 0.14,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Renkler.vurgu.withValues(alpha: 0.85),
                        Renkler.bannerAlt.withValues(alpha: 0.9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Renkler.vurgu.withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.auto_awesome,
                          color: Colors.white, size: 13),
                      SizedBox(width: 4),
                      Text(
                        "${l.t('ai.hak')}: 5/5",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _kaydirma,
            builder: (context, _) => _arkaPlan(_kaydirmaOfset()),
          ),
          SingleChildScrollView(
            controller: _kaydirma,
            padding: EdgeInsets.fromLTRB(16, kToolbarHeight + 20, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _disclaimer(l),
                SizedBox(height: 16),
                _kategoriSecici(l),
                SizedBox(height: 20),
                _soruAlan(l),
                SizedBox(height: 16),
                _hizliOrnekler(l),
                SizedBox(height: 24),

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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      Renkler.vurgu.withValues(alpha: 0.35),
                                  blurRadius: 24,
                                ),
                              ],
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
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- ANA BÖLÜMLER ----------------

  Widget _disclaimer(AppLocalizations l) {
    return _TiltKart(
      child: _CamKart(
        radius: 16,
        padding: EdgeInsets.all(12),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Renkler.vurgu, Renkler.bannerAlt],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Renkler.vurgu.withValues(alpha: 0.4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Icon(Icons.shield_outlined,
                      color: Colors.white, size: 18),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l.t('ai.disclaimer'),
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ),
              ],
            ),
            Positioned.fill(child: _ParlakYansima(radius: 16)),
          ],
        ),
      ),
    );
  }

  Widget _kategoriSecici(AppLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.t('ai.mode').toUpperCase(),
          style: TextStyle(
            color: Renkler.acikVurgu,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 48,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _kategoriler.length,
            itemBuilder: (context, index) {
              final kategori = _kategoriler[index];
              final isSelected = kategori.kod == _seciliKategori;
              return _TiltKart(
                maxTilt: 0.18,
                child: GestureDetector(
                  onTap: () => setState(() => _seciliKategori = kategori.kod),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutBack,
                    margin: EdgeInsets.only(right: 8),
                    padding:
                        EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Renkler.vurgu,
                                Renkler.bannerAlt.withValues(alpha: 0.95),
                              ],
                            )
                          : null,
                      color: isSelected
                          ? null
                          : Renkler.kart.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isSelected
                            ? Renkler.acikVurgu.withValues(alpha: 0.8)
                            : Renkler.cerceve2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color:
                                    Renkler.vurgu.withValues(alpha: 0.45),
                                blurRadius: 16,
                                spreadRadius: 1,
                                offset: const Offset(0, 5),
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          kategori.ikon,
                          color: isSelected ? Colors.white : Renkler.acikVurgu,
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          l.t('ai.c.${kategori.kod}'),
                          style: TextStyle(
                            color:
                                isSelected ? Colors.white : Colors.white70,
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _soruAlan(AppLocalizations l) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.t('ai.yardimBaslik'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        _TiltKart(
          child: _CamKart(
            radius: 20,
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _queryController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Renkler.vurgu,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) =>
                            _askAi(_queryController.text),
                        decoration: InputDecoration(
                          hintText: l.t('ai.hint'),
                          hintStyle: TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: Renkler.zemin.withValues(alpha: 0.6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.auto_awesome,
                              color: Renkler.vurgu, size: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    _TiltKart(
                      maxTilt: 0.16,
                      child: GestureDetector(
                        onTap: _isLoading
                            ? null
                            : () => _askAi(_queryController.text),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Renkler.vurgu,
                                Renkler.bannerAlt,
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Renkler.vurgu.withValues(alpha: 0.5),
                                blurRadius: 14,
                                spreadRadius: 1,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: _isLoading
                              ? Padding(
                                  padding: EdgeInsets.all(12),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(Icons.arrow_upward,
                                  color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned.fill(child: _ParlakYansima(radius: 20)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _hizliOrnekler(AppLocalizations l) {
    final kategori = _aktifKategori;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.t('ai.ornekBaslik').toUpperCase(),
          style: TextStyle(
            color: Colors.white54,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var i = 1; i <= 3; i++)
              _TiltKart(
                maxTilt: 0.2,
                child: ActionChip(
                  backgroundColor: Renkler.kart.withValues(alpha: 0.85),
                  side: BorderSide(color: Renkler.cerceve2),
                  elevation: 3,
                  avatar: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Renkler.vurgu.withValues(alpha: 0.9),
                          Renkler.bannerAlt,
                        ],
                      ),
                    ),
                    child: Icon(kategori.ikon,
                        color: Colors.white, size: 13),
                  ),
                  labelStyle:
                      TextStyle(color: Colors.white70, fontSize: 12),
                  label: Text(l.t('ai.cs.${kategori.kod}.$i')),
                  onPressed: () {
                    final soru = l.t('ai.cs.${kategori.kod}.$i');
                    _queryController.text = soru;
                    _askAi(soru);
                  },
                ),
              ),
          ],
        ),
      ],
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
                boxShadow: [
                  BoxShadow(
                    color: Renkler.vurgu.withValues(alpha: 0.4),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Icon(Icons.key_off, color: Colors.white, size: 20),
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
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withValues(alpha: 0.2),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
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
                  Icon(Icons.error_outline, color: Colors.redAccent, size: 20),
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
                        boxShadow: [
                          BoxShadow(
                            color: Renkler.vurgu.withValues(alpha: 0.5),
                            blurRadius: 14,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Icon(Icons.auto_awesome,
                          color: Colors.white, size: 20),
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
                      Icon(Icons.verified_user,
                          color: Renkler.vurgu, size: 16),
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
                        icon: Icon(Icons.thumb_up_outlined,
                            color: Colors.white60, size: 20),
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
                        icon: Icon(Icons.thumb_down_outlined,
                            color: Colors.white60, size: 20),
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