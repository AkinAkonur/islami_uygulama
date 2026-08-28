import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../widgets/kart_sekilleri.dart';
import 'paylasim_kartlari_verileri.dart';

class PaylasimKartlariStudioPage extends StatefulWidget {
  const PaylasimKartlariStudioPage({super.key});

  @override
  State<PaylasimKartlariStudioPage> createState() =>
      _PaylasimKartlariStudioPageState();
}

class _PaylasimKartlariStudioPageState
    extends State<PaylasimKartlariStudioPage> {
  final GlobalKey _kartAnahtari = GlobalKey();

  KartIcerikTipi _tip = KartIcerikTipi.ayet;
  KartIcerik? _icerik;
  List<KartIcerik> _liste = kartAyetleri;
  int _temaIndex = 0;
  KartFormat _format = KartFormat.hikaye;
  bool _arapcaGoster = true;
  double _fontBoyutu = 20;
  bool _paylasiliyor = false;
  bool _dualarYukleniyor = false;
  bool _ozelIcerik = false;
  bool _otomatikArapca = true;
  bool _ceviriliyor = false;
  String? _sonArapca;
  Timer? _ceviriZamani;
  final TextEditingController _ozelMetin = TextEditingController();
  final TextEditingController _ozelKaynak = TextEditingController();
  final TextEditingController _ozelArapca = TextEditingController();

  @override
  void initState() {
    super.initState();
    _icerik = _liste.isNotEmpty ? _liste.first : null;
    _ozelMetin.addListener(_otomatikArapcaGuncelle);
  }

  @override
  void dispose() {
    _ceviriZamani?.cancel();
    _ozelMetin.removeListener(_otomatikArapcaGuncelle);
    _ozelMetin.dispose();
    _ozelKaynak.dispose();
    _ozelArapca.dispose();
    super.dispose();
  }

  KartTema get _tema => kartTemalari[_temaIndex];

  Future<void> _tipDegistir(KartIcerikTipi tip) async {
    if (_tip == tip) return;
    _ceviriZamani?.cancel();
    _ozelMetin.clear();
    _ozelKaynak.clear();
    _ozelArapca.clear();
    setState(() {
      _tip = tip;
      _ozelIcerik = false;
      _ceviriliyor = false;
      _sonArapca = null;
      if (tip == KartIcerikTipi.dua) _dualarYukleniyor = true;
    });
    final liste = await PaylasimKartlariVerileri.instance.listeGetir(tip);
    if (!mounted || _tip != tip) return;
    setState(() {
      _liste = liste;
      _icerik = liste.isNotEmpty ? liste.first : null;
      _dualarYukleniyor = false;
    });
  }

  void _icerikSec(KartIcerik icerik) {
    setState(() => _icerik = icerik);
  }

  KartIcerik? get _ozelKart {
    final metin = _ozelMetin.text.trim();
    if (metin.isEmpty) return null;
    final kaynak = _ozelKaynak.text.trim();
    final arapca = _ozelArapca.text.trim();
    var baslik = metin.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (baslik.length > 32) baslik = '${baslik.substring(0, 32)}…';
    return KartIcerik(
      id: 'ozel_kart',
      tip: _tip,
      baslik: baslik,
      kaynak: kaynak.isEmpty
          ? AppLocalizations.of(context).t('pks.myMessage')
          : kaynak,
      metin: metin,
      arapca: arapca.isEmpty ? null : arapca,
    );
  }

  void _ozelModGec(bool aktif) {
    _ceviriZamani?.cancel();
    setState(() {
      _ozelIcerik = aktif;
      _ceviriliyor = false;
      _sonArapca = null;
      _icerik = aktif ? _ozelKart : (_liste.isNotEmpty ? _liste.first : null);
    });
  }

  void _ozelIcerigiGuncelle() {
    setState(() => _icerik = _ozelKart);
  }

  void _otomatikArapcaGuncelle() {
    final metin = _ozelMetin.text.trim();
    if (!_otomatikArapca || metin.isEmpty) {
      _ceviriZamani?.cancel();
      if (_ceviriliyor) setState(() => _ceviriliyor = false);
      return;
    }
    _ceviriZamani?.cancel();
    _ceviriZamani = Timer(
      const Duration(milliseconds: 800),
      () => _arapcayaCevir(metin),
    );
  }

  Future<void> _arapcayaCevir(String metin) async {
    if (!mounted || !_otomatikArapca) return;
    setState(() => _ceviriliyor = true);
    try {
      String? sonuc;
      if (RegExp(r'[\u0600-\u06FF]').hasMatch(metin)) {
        sonuc = metin;
      } else {
        final uri = Uri.https(
          'translate.googleapis.com',
          '/translate_a/single',
          {'client': 'gtx', 'sl': 'auto', 'tl': 'ar', 'dt': 't', 'q': metin},
        );
        final yanit = await http.get(uri).timeout(const Duration(seconds: 10));
        if (yanit.statusCode != 200) return;
        final veri = jsonDecode(utf8.decode(yanit.bodyBytes)) as List;
        if (veri.isEmpty) return;
        final parcalar = veri.first as List;
        sonuc = parcalar
            .where((p) => p is List && p.isNotEmpty)
            .map((p) => (p as List).first as String)
            .join()
            .trim();
      }
      if (!mounted) return;
      if (!_otomatikArapca || !_ozelIcerik) return;
      if (sonuc.isEmpty) return;
      final mevcut = _ozelArapca.text.trim();
      if (mevcut.isNotEmpty && mevcut != _sonArapca) return;
      _sonArapca = sonuc;
      _ozelArapca.text = sonuc;
      setState(() => _icerik = _ozelKart);
    } catch (_) {
      // Ağ hatası: arapça alanı boş bırakılır
    } finally {
      if (mounted) setState(() => _ceviriliyor = false);
    }
  }

  void _otomatikArapcaDegis(bool v) {
    setState(() => _otomatikArapca = v);
    if (v) {
      _otomatikArapcaGuncelle();
    } else {
      _ceviriZamani?.cancel();
      setState(() => _ceviriliyor = false);
    }
  }

  void _rastgele() {
    final liste = _liste;
    if (liste.isEmpty) return;
    final yeni = liste[math.Random().nextInt(liste.length)];
    setState(() => _icerik = yeni);
  }

  Future<void> _paylas() async {
    final icerik = _icerik;
    if (icerik == null || _paylasiliyor) return;
    final l = AppLocalizations.of(context);
    setState(() => _paylasiliyor = true);
    try {
      final context = _kartAnahtari.currentContext;
      if (context == null) throw Exception('Kart hazırlanamadı');
      final boundary = context.findRenderObject()! as RenderRepaintBoundary;
      final resim = await boundary.toImage(pixelRatio: 3);
      final byteData = await resim.toByteData(format: ui.ImageByteFormat.png);
      resim.dispose();
      if (byteData == null) throw Exception('Görsel oluşturulamadı');

      final dizin = await getTemporaryDirectory();
      final dosya = File('${dizin.path}/paylasim_${icerik.id}.png');
      await dosya.writeAsBytes(byteData.buffer.asUint8List());

      final paylasimMetni =
          '${icerik.metin}\n${icerik.kaynak}\n\n${l.t('pks.shareText').replaceFirst('{uygulama}', uygulamaAdi)}';
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(dosya.path, mimeType: 'image/png')],
          text: paylasimMetni,
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                l.t('pks.shareError').replaceFirst('{hata}', '$e'),
              ),
            ),
          );
      }
    } finally {
      if (mounted) setState(() => _paylasiliyor = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final icerik = _icerik;
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
        title: Text(
          l.t('pks.title'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        actions: [
          IconButton(
            tooltip: l.t('pks.randomCard'),
            icon: const UcdIkon(ikon: Icons.shuffle_rounded, renk: Colors.white70, boyut: 24),
            onPressed: _rastgele,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          _FormatSecici(
            format: _format,
            onDegis: (f) => setState(() => _format = f),
          ),
          const SizedBox(height: 14),
          if (icerik != null)
            _KartOnizleme(
              anahtar: _kartAnahtari,
              icerik: icerik,
              tema: _tema,
              format: _format,
              fontBoyutu: _fontBoyutu,
              arapcaGoster: _arapcaGoster,
            ),
          const SizedBox(height: 16),
          _TemaSecici(
            seciliIndex: _temaIndex,
            onSec: (i) => setState(() => _temaIndex = i),
          ),
          const SizedBox(height: 14),
          _Secenekler(
            fontBoyutu: _fontBoyutu,
            arapcaGoster: _arapcaGoster,
            onFontBoyutu: (v) => setState(() => _fontBoyutu = v),
            onArapcaDegis: (v) => setState(() => _arapcaGoster = v),
          ),
          const SizedBox(height: 18),
          _IcerikSecici(
            tip: _tip,
            liste: _liste,
            seciliId: icerik?.id,
            dualarYukleniyor: _dualarYukleniyor,
            onTipDegis: _tipDegistir,
            onSec: _icerikSec,
            ozelMod: _ozelIcerik,
            onOzelGec: _ozelModGec,
            metinKontroller: _ozelMetin,
            kaynakKontroller: _ozelKaynak,
            arapcaKontroller: _ozelArapca,
            onIcerikDegis: _ozelIcerigiGuncelle,
            otomatikArapca: _otomatikArapca,
            ceviriliyor: _ceviriliyor,
            onOtomatikArapca: _otomatikArapcaDegis,
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: _PaylasButonu(
          paylasiliyor: _paylasiliyor,
          aktif: icerik != null,
          onPaylas: _paylas,
        ),
      ),
    );
  }
}

class _FormatSecici extends StatelessWidget {
  final KartFormat format;
  final ValueChanged<KartFormat> onDegis;

  const _FormatSecici({required this.format, required this.onDegis});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          for (final f in KartFormat.values)
            Expanded(
              child: GestureDetector(
                onTap: () => onDegis(f),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: format == f ? Renkler.vurgu : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UcdIkon(
                        ikon: f.ikon,
                        renk: format == f ? Colors.black : Colors.white70,
                        boyut: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        f.ad,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: format == f ? Colors.black : Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _KartOnizleme extends StatelessWidget {
  final GlobalKey anahtar;
  final KartIcerik icerik;
  final KartTema tema;
  final KartFormat format;
  final double fontBoyutu;
  final bool arapcaGoster;

  const _KartOnizleme({
    required this.anahtar,
    required this.icerik,
    required this.tema,
    required this.format,
    required this.fontBoyutu,
    required this.arapcaGoster,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxGenislik = constraints.maxWidth;
          final maxYukseklik = constraints.maxHeight;
          var genislik = 0.0;
          var yukseklik = 0.0;
          if (format == KartFormat.kare) {
            yukseklik = math.min(maxGenislik, maxYukseklik);
            genislik = yukseklik;
          } else {
            yukseklik = maxYukseklik;
            genislik = yukseklik * 9 / 16;
            if (genislik > maxGenislik) {
              genislik = maxGenislik;
              yukseklik = genislik * 16 / 9;
            }
          }
          return Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              width: genislik,
              height: yukseklik,
              child: RepaintBoundary(
                key: anahtar,
                child: _PaylasimKarti(
                  icerik: icerik,
                  tema: tema,
                  format: format,
                  fontBoyutu: fontBoyutu,
                  arapcaGoster: arapcaGoster,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PaylasimKarti extends StatelessWidget {
  final KartIcerik icerik;
  final KartTema tema;
  final KartFormat format;
  final double fontBoyutu;
  final bool arapcaGoster;

  const _PaylasimKarti({
    required this.icerik,
    required this.tema,
    required this.format,
    required this.fontBoyutu,
    required this.arapcaGoster,
  });

  IconData get _tipIkon => switch (icerik.tip) {
    KartIcerikTipi.ayet => Icons.menu_book_outlined,
    KartIcerikTipi.hadis => Icons.forum_outlined,
    KartIcerikTipi.dua => Icons.waving_hand_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final kare = format == KartFormat.kare;
    final desenRenk = tema.koyu ? Colors.white : Colors.black87;
    final disPadding = kare ? 22.0 : 26.0;
    final metinSatir = kare ? 5 : 9;
    final arapcaSatir = kare ? 3 : 6;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: tema.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(kare ? 22 : 28),
        border: Border.all(
          color: tema.ornament.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kare ? 22 : 28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _ArkaDesen(tema: tema, desenRenk: desenRenk),
            Padding(
              padding: EdgeInsets.all(disPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UcdIkon(ikon: _tipIkon, renk: tema.kaynak, boyut: 15),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          '${icerik.etiket} · ${icerik.kaynak}',
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: tema.kaynak,
                            fontSize: kare ? 12 : 13,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _Ornament(renk: tema.ornament),
                  const SizedBox(height: 12),
                  Expanded(child: _metinBolumu(kare, metinSatir, arapcaSatir)),
                  const SizedBox(height: 10),
                  _Filigran(tema: tema),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _metinBolumu(bool kare, int metinSatir, int arapcaSatir) {
    final arapcaVar =
        arapcaGoster && icerik.arapca != null && icerik.arapca!.isNotEmpty;
    final bolum = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _UyumluMetin(
            metin: icerik.metin,
            baslangic: _fontBoyutu(kare),
            minBoyut: 10,
            renk: tema.metin,
            agirlik: FontWeight.w700,
            satir: 1.35,
            maxSatir: metinSatir,
            hizalama: TextAlign.center,
          ),
        ),
        if (arapcaVar) ...[
          const SizedBox(height: 10),
          Container(height: 1, color: tema.ornament.withValues(alpha: 0.35)),
          const SizedBox(height: 10),
          Expanded(
            child: _UyumluMetin(
              metin: icerik.arapca!,
              baslangic: _fontBoyutu(kare) * 1.15,
              minBoyut: 12,
              renk: tema.arapca,
              agirlik: FontWeight.w600,
              satir: 1.7,
              maxSatir: arapcaSatir,
              hizalama: TextAlign.center,
              yon: TextDirection.rtl,
            ),
          ),
        ],
      ],
    );
    if (!tema.camEfekti) return bolum;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.55)),
      ),
      child: bolum,
    );
  }

  double _fontBoyutu(bool kare) => kare ? fontBoyutu * 0.92 : fontBoyutu;
}

class _Ornament extends StatelessWidget {
  final Color renk;

  const _Ornament({required this.renk});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(height: 1, color: renk.withValues(alpha: 0.5)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: UcdIkon(ikon: Icons.auto_awesome_rounded, renk: renk, boyut: 13),
        ),
        Expanded(
          child: Container(height: 1, color: renk.withValues(alpha: 0.5)),
        ),
      ],
    );
  }
}

class _Filigran extends StatelessWidget {
  final KartTema tema;

  const _Filigran({required this.tema});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UcdIkon(ikon: Icons.spa_rounded, renk: tema.filigran, boyut: 13),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            AppLocalizations.of(context)
                .t('pks.createdWith')
                .replaceFirst('{uygulama}', uygulamaAdi),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: tema.filigran,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _ArkaDesen extends StatelessWidget {
  final KartTema tema;
  final Color desenRenk;

  const _ArkaDesen({required this.tema, required this.desenRenk});

  @override
  Widget build(BuildContext context) {
    switch (tema.desen) {
      case 'yildiz':
        return CustomPaint(
          painter: _IslamiYildizPainter(desenRenk.withValues(alpha: 0.09)),
        );
      case 'kabe':
        return CustomPaint(
          painter: _KabeSiluetiPainter(desenRenk.withValues(alpha: 0.08)),
        );
      case 'hilal':
        return CustomPaint(
          painter: _HilalPainter(desenRenk.withValues(alpha: 0.10)),
        );
      case 'gokyuzu':
        return CustomPaint(
          painter: _NurPainter(Colors.white.withValues(alpha: 0.28)),
        );
      case 'isik':
        return CustomPaint(
          painter: _NurPainter(Colors.white.withValues(alpha: 0.16)),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _UyumluMetin extends StatelessWidget {
  final String metin;
  final double baslangic;
  final double minBoyut;
  final Color renk;
  final FontWeight agirlik;
  final double satir;
  final int maxSatir;
  final TextAlign hizalama;
  final TextDirection yon;

  const _UyumluMetin({
    required this.metin,
    required this.baslangic,
    required this.minBoyut,
    required this.renk,
    required this.agirlik,
    required this.satir,
    required this.maxSatir,
    required this.hizalama,
    this.yon = TextDirection.ltr,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boyut = _enUygunBoyut(
          metin: metin,
          maxGenislik: constraints.maxWidth,
          maxYukseklik: constraints.maxHeight,
          baslangic: baslangic,
          min: minBoyut,
          satir: satir,
          maxSatir: maxSatir,
          yon: yon,
        );
        return Text(
          metin,
          textAlign: hizalama,
          textDirection: yon,
          maxLines: maxSatir,
          overflow: TextOverflow.visible,
          style: TextStyle(
            color: renk,
            fontSize: boyut,
            fontWeight: agirlik,
            height: satir,
          ),
        );
      },
    );
  }

  double _enUygunBoyut({
    required String metin,
    required double maxGenislik,
    required double maxYukseklik,
    required double baslangic,
    required double min,
    required double satir,
    required int maxSatir,
    required TextDirection yon,
  }) {
    var b = baslangic;
    while (b > min) {
      final tp = TextPainter(
        text: TextSpan(
          text: metin,
          style: TextStyle(fontSize: b, height: satir),
        ),
        maxLines: maxSatir,
        textDirection: yon,
      )..layout(maxWidth: maxGenislik);
      final uyar = !tp.didExceedMaxLines && tp.height <= maxYukseklik + 1;
      tp.dispose();
      if (uyar) return b;
      b -= 1;
    }
    return min;
  }
}

class _TemaSecici extends StatelessWidget {
  final int seciliIndex;
  final ValueChanged<int> onSec;

  const _TemaSecici({required this.seciliIndex, required this.onSec});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('pks.chooseTheme'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 96,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: kartTemalari.length,
            itemBuilder: (context, index) {
              final tema = kartTemalari[index];
              final secili = index == seciliIndex;
              return GestureDetector(
                onTap: () => onSec(index),
                child: Container(
                  width: 92,
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: tema.gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: secili
                          ? Renkler.vurgu
                          : Colors.white.withValues(alpha: 0.15),
                      width: secili ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UcdIkon(
                        ikon: tema.ikon,
                        renk: tema.koyu ? tema.arapca : tema.metin,
                        boyut: 20,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        tema.ad,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: tema.koyu ? Colors.white : tema.metin,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Secenekler extends StatelessWidget {
  final double fontBoyutu;
  final bool arapcaGoster;
  final ValueChanged<double> onFontBoyutu;
  final ValueChanged<bool> onArapcaDegis;

  const _Secenekler({
    required this.fontBoyutu,
    required this.arapcaGoster,
    required this.onFontBoyutu,
    required this.onArapcaDegis,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Renkler.kart,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Row(
              children: [
                const UcdIkon(ikon: Icons.format_size_rounded, renk: Colors.white54, boyut: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Slider(
                    value: fontBoyutu.clamp(14, 30),
                    min: 14,
                    max: 30,
                    activeColor: Renkler.vurgu,
                    inactiveColor: Renkler.cerceve2,
                    onChanged: onFontBoyutu,
                  ),
                ),
                Text(
                  '${fontBoyutu.round()}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                AppLocalizations.of(context).t('pks.showArabic'),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
              subtitle: Text(
                AppLocalizations.of(context).t('pks.showArabicSub'),
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
              value: arapcaGoster,
              activeThumbColor: Renkler.vurgu,
              onChanged: onArapcaDegis,
            ),
          ],
        ),
      ),
    );
  }
}

class _IcerikSecici extends StatelessWidget {
  final KartIcerikTipi tip;
  final List<KartIcerik> liste;
  final String? seciliId;
  final bool dualarYukleniyor;
  final ValueChanged<KartIcerikTipi> onTipDegis;
  final ValueChanged<KartIcerik> onSec;
  final bool ozelMod;
  final ValueChanged<bool> onOzelGec;
  final TextEditingController metinKontroller;
  final TextEditingController kaynakKontroller;
  final TextEditingController arapcaKontroller;
  final VoidCallback onIcerikDegis;
  final bool otomatikArapca;
  final bool ceviriliyor;
  final ValueChanged<bool> onOtomatikArapca;

  const _IcerikSecici({
    required this.tip,
    required this.liste,
    required this.seciliId,
    required this.dualarYukleniyor,
    required this.onTipDegis,
    required this.onSec,
    required this.ozelMod,
    required this.onOzelGec,
    required this.metinKontroller,
    required this.kaynakKontroller,
    required this.arapcaKontroller,
    required this.onIcerikDegis,
    required this.otomatikArapca,
    required this.ceviriliyor,
    required this.onOtomatikArapca,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.t('pks.chooseContent'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (final t in KartIcerikTipi.values)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(
                    switch (t) {
                      KartIcerikTipi.ayet => l.t('pks.typeAyet'),
                      KartIcerikTipi.hadis => l.t('pks.typeHadis'),
                      KartIcerikTipi.dua => l.t('pks.typeDua'),
                    },
                    style: const TextStyle(fontSize: 12),
                  ),
                  selected: tip == t,
                  selectedColor: Renkler.vurgu,
                  backgroundColor: Renkler.kart,
                  labelStyle: TextStyle(
                    color: tip == t ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (_) => onTipDegis(t),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Material(
          color: ozelMod ? Renkler.seciliYuzey : Renkler.kart,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onOzelGec(!ozelMod),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: ozelMod ? Renkler.vurgu : Renkler.cerceve,
                  width: ozelMod ? 1.6 : 1,
                ),
              ),
              child: Row(
                children: [
                  UcdIkon(
                    ikon: Icons.edit_note_rounded,
                    renk: ozelMod ? Renkler.vurgu : Colors.white70,
                    boyut: 22,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.t('pks.writeOwn'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l.t('pks.writeOwnSub'),
                          style: const TextStyle(color: Colors.white54, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  UcdIkon(
                    ikon: ozelMod ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                    renk: ozelMod ? Renkler.vurgu : Colors.white38,
                    boyut: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (dualarYukleniyor)
          const SizedBox(
            height: 84,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          )
        else if (ozelMod)
          _OzelIcerikEditoru(
            metinKontroller: metinKontroller,
            kaynakKontroller: kaynakKontroller,
            arapcaKontroller: arapcaKontroller,
            onIcerikDegis: onIcerikDegis,
            otomatikArapca: otomatikArapca,
            ceviriliyor: ceviriliyor,
            onOtomatikArapca: onOtomatikArapca,
          )
        else if (liste.isEmpty)
          SizedBox(
            height: 84,
            child: Center(
              child: Text(
                l.t('pks.noContent'),
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ),
          )
        else
          SizedBox(
            height: 96,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: liste.length,
              itemBuilder: (context, index) {
                final icerik = liste[index];
                final secili = icerik.id == seciliId;
                return GestureDetector(
                  onTap: () => onSec(icerik),
                  child: Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: secili ? Renkler.seciliYuzey : Renkler.kart,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: secili ? Renkler.vurgu : Renkler.cerceve,
                        width: secili ? 1.6 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          icerik.baslik,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            icerik.metin,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: secili ? Colors.white70 : Colors.white54,
                              fontSize: 11,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _OzelIcerikEditoru extends StatelessWidget {
  final TextEditingController metinKontroller;
  final TextEditingController kaynakKontroller;
  final TextEditingController arapcaKontroller;
  final VoidCallback onIcerikDegis;
  final bool otomatikArapca;
  final bool ceviriliyor;
  final ValueChanged<bool> onOtomatikArapca;

  const _OzelIcerikEditoru({
    required this.metinKontroller,
    required this.kaynakKontroller,
    required this.arapcaKontroller,
    required this.onIcerikDegis,
    required this.otomatikArapca,
    required this.ceviriliyor,
    required this.onOtomatikArapca,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Material(
      color: Renkler.kart,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                l.t('pks.autoArabic'),
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
              subtitle: Text(
                ceviriliyor ? l.t('pks.translating') : l.t('pks.translateHint'),
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
              value: otomatikArapca,
              activeThumbColor: Renkler.vurgu,
              onChanged: onOtomatikArapca,
            ),
            const SizedBox(height: 4),
            TextField(
              controller: metinKontroller,
              onChanged: (_) => onIcerikDegis(),
              minLines: 2,
              maxLines: 4,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.4,
              ),
              decoration: InputDecoration(
                hintText: l.t('pks.messageHint'),
                hintStyle: TextStyle(color: Colors.white38, fontSize: 12),
                filled: true,
                fillColor: Renkler.zemin,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.cerceve),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.cerceve),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.vurgu),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: kaynakKontroller,
              onChanged: (_) => onIcerikDegis(),
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: l.t('pks.sourceHint'),
                hintStyle: TextStyle(color: Colors.white38, fontSize: 12),
                filled: true,
                fillColor: Renkler.zemin,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.cerceve),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.cerceve),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.vurgu),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: arapcaKontroller,
              onChanged: (_) => onIcerikDegis(),
              style: const TextStyle(color: Colors.white, fontSize: 13),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: l.t('pks.arabicHint'),
                hintStyle: TextStyle(color: Colors.white38, fontSize: 12),
                filled: true,
                fillColor: Renkler.zemin,
                isDense: true,
                suffixIcon: ceviriliyor
                    ? const Padding(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.cerceve),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.cerceve),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Renkler.vurgu),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaylasButonu extends StatelessWidget {
  final bool paylasiliyor;
  final bool aktif;
  final VoidCallback onPaylas;

  const _PaylasButonu({
    required this.paylasiliyor,
    required this.aktif,
    required this.onPaylas,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: aktif && !paylasiliyor ? onPaylas : null,
      icon: paylasiliyor
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.black,
              ),
            )
          : UcdIkon(ikon: Icons.share_rounded, renk: Colors.black, boyut: 20),
      label: Text(
        paylasiliyor
            ? AppLocalizations.of(context).t('pks.preparing')
            : AppLocalizations.of(context).t('pks.shareCta'),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Renkler.vurgu,
        foregroundColor: Colors.black,
        minimumSize: const Size.fromHeight(52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _IslamiYildizPainter extends CustomPainter {
  final Color renk;

  _IslamiYildizPainter(this.renk);

  @override
  void paint(Canvas canvas, Size size) {
    final boya = Paint()
      ..color = renk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;
    const aralik = 88.0;
    const r = 26.0;
    var x = aralik / 2;
    while (x < size.width + aralik) {
      var y = aralik / 2;
      while (y < size.height + aralik) {
        _sekizKolluYildiz(canvas, Offset(x, y), r, boya);
        y += aralik;
      }
      x += aralik;
    }
  }

  void _sekizKolluYildiz(Canvas canvas, Offset m, double r, Paint boya) {
    final path = Path();
    for (var i = 0; i < 16; i++) {
      final aci = i * math.pi / 8 - math.pi / 2;
      final yaricap = i.isEven ? r : r * 0.42;
      final pt = m + Offset(math.cos(aci) * yaricap, math.sin(aci) * yaricap);
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    canvas.drawPath(path, boya);
  }

  @override
  bool shouldRepaint(covariant _IslamiYildizPainter oldDelegate) =>
      oldDelegate.renk != renk;
}

class _KabeSiluetiPainter extends CustomPainter {
  final Color renk;

  _KabeSiluetiPainter(this.renk);

  @override
  void paint(Canvas canvas, Size size) {
    final boya = Paint()
      ..color = renk
      ..style = PaintingStyle.fill;

    const genislik = 56.0;
    const yukseklik = 72.0;
    var x = -10.0;
    while (x < size.width + genislik) {
      final p = Path()
        ..moveTo(x, size.height)
        ..lineTo(x, size.height - yukseklik + 24)
        ..arcToPoint(
          Offset(x + genislik, size.height - yukseklik + 24),
          radius: const Radius.circular(28),
          clockwise: false,
        )
        ..lineTo(x + genislik, size.height)
        ..close();
      canvas.drawPath(p, boya);
      x += genislik;
    }

    final domeM = Offset(size.width / 2, size.height - 4);
    final domeR = math.min(size.width * 0.3, 78.0);
    final kubbe = Path()
      ..moveTo(domeM.dx - domeR, domeM.dy)
      ..arcToPoint(
        Offset(domeM.dx + domeR, domeM.dy),
        radius: Radius.circular(domeR),
        clockwise: false,
      )
      ..close();
    canvas.drawPath(kubbe, boya);

    final finyal = Path.combine(
      PathOperation.difference,
      Path()..addOval(
        Rect.fromCircle(center: domeM + Offset(0, -domeR - 8), radius: 8),
      ),
      Path()..addOval(
        Rect.fromCircle(center: domeM + Offset(4, -domeR - 10), radius: 7),
      ),
    );
    canvas.drawPath(finyal, boya);

    for (final side in const [-1, 1]) {
      final mx = domeM.dx + side * domeR * 1.5;
      final minare = Path()
        ..moveTo(mx - 6, size.height)
        ..lineTo(mx - 6, size.height - 120)
        ..lineTo(mx - 3, size.height - 138)
        ..lineTo(mx + 3, size.height - 138)
        ..lineTo(mx + 6, size.height - 120)
        ..lineTo(mx + 6, size.height)
        ..close();
      canvas.drawPath(minare, boya);
    }
  }

  @override
  bool shouldRepaint(covariant _KabeSiluetiPainter oldDelegate) =>
      oldDelegate.renk != renk;
}

class _HilalPainter extends CustomPainter {
  final Color renk;

  _HilalPainter(this.renk);

  @override
  void paint(Canvas canvas, Size size) {
    final boya = Paint()
      ..color = renk
      ..style = PaintingStyle.fill;

    final merkez = Offset(size.width * 0.84, size.height * 0.14);
    final r = size.width * 0.17;
    final hilal = Path.combine(
      PathOperation.difference,
      Path()..addOval(Rect.fromCircle(center: merkez, radius: r)),
      Path()..addOval(
        Rect.fromCircle(
          center: merkez + Offset(r * 0.42, -r * 0.16),
          radius: r * 0.94,
        ),
      ),
    );
    canvas.drawPath(hilal, boya);

    final yildiz = Path();
    final sy = merkez + Offset(-r * 1.8, r * 0.5);
    const noktaSayisi = 10;
    for (var i = 0; i < noktaSayisi; i++) {
      final aci = i * math.pi / 5 - math.pi / 2;
      final yaricap = i.isEven ? r * 0.24 : r * 0.1;
      final pt = sy + Offset(math.cos(aci) * yaricap, math.sin(aci) * yaricap);
      if (i == 0) {
        yildiz.moveTo(pt.dx, pt.dy);
      } else {
        yildiz.lineTo(pt.dx, pt.dy);
      }
    }
    yildiz.close();
    canvas.drawPath(yildiz, boya);
  }

  @override
  bool shouldRepaint(covariant _HilalPainter oldDelegate) =>
      oldDelegate.renk != renk;
}

class _NurPainter extends CustomPainter {
  final Color renk;

  _NurPainter(this.renk);

  @override
  void paint(Canvas canvas, Size size) {
    final r = math.max(size.width, size.height) * 0.75;
    final merkez = Offset(size.width / 2, -r * 0.35);
    final grad = RadialGradient(
      colors: [renk, renk.withValues(alpha: 0.0)],
      stops: const [0, 1],
    ).createShader(Rect.fromCircle(center: merkez, radius: r));
    canvas.drawCircle(
      merkez,
      r,
      Paint()
        ..shader = grad
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant _NurPainter oldDelegate) =>
      oldDelegate.renk != renk;
}
