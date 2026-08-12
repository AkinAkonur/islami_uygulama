import 'dart:io';
import 'dart:ui' as ui;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../services/dua_store.dart';
import '../services/dualar_verileri.dart';
import '../services/renkler.dart';

// ===========================================================================
// DUA DETAY SAYFASI
// 3'lü görünüm: Arapça metin, Latince okunuş ve Türkçe meal bir arada.
// Ayarlanabilir yazı boyutu, sesli dinleme (Kur'an âyetlerine dayanan
// dualar için), zikirmatik sayacı, favori ve görsel kart paylaşımı.
// ===========================================================================

class DuaDetayPage extends StatefulWidget {
  final DuaKaydi dua;
  final String? kategoriAdi;

  const DuaDetayPage({super.key, required this.dua, this.kategoriAdi});

  @override
  State<DuaDetayPage> createState() => _DuaDetayPageState();
}

class _DuaDetayPageState extends State<DuaDetayPage> {
  final AudioPlayer _player = AudioPlayer();
  bool _caliyor = false;
  bool _yukleniyorSes = false;
  String? _sesHata;
  final GlobalKey _kartAnahtari = GlobalKey();
  bool _paylasiliyor = false;

  @override
  void initState() {
    super.initState();
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _caliyor = false);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  DuaKaydi get dua => widget.dua;

  Future<void> _sesCal() async {
    final url = dua.sesUrl;
    if (url == null) return;
    if (_caliyor) {
      await _player.stop();
      if (mounted) setState(() => _caliyor = false);
      return;
    }
    setState(() {
      _yukleniyorSes = true;
      _sesHata = null;
    });
    try {
      await _player.play(UrlSource(url));
      if (mounted) {
        setState(() {
          _caliyor = true;
          _yukleniyorSes = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _yukleniyorSes = false;
          _sesHata = 'Ses yüklenemedi. İnternet bağlantınızı kontrol edin.';
        });
      }
    }
  }

  Future<void> _paylas() async {
    if (_paylasiliyor) return;
    setState(() => _paylasiliyor = true);
    try {
      final boyut = _kartAnahtari.currentContext?.size;
      if (boyut == null) throw Exception('Kart hazırlanamadı');
      final boundary = _kartAnahtari.currentContext!.findRenderObject()
          as RenderRepaintBoundary;
      final resim = await boundary.toImage(pixelRatio: 3);
      final byteData = await resim.toByteData(format: ui.ImageByteFormat.png);
      resim.dispose();
      if (byteData == null) throw Exception('Görsel oluşturulamadı');

      final dizin = await getTemporaryDirectory();
      final dosya = File('${dizin.path}/dua_${dua.id}.png');
      await dosya.writeAsBytes(byteData.buffer.asUint8List());

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(dosya.path, mimeType: 'image/png')],
          text: '${dua.baslik} 🤲 #islamiUygulama',
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paylaşım hazırlanamadı: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _paylasiliyor = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dua = widget.dua;
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.zemin,
        title: Text(
          dua.baslik,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (dua.sesUrl != null)
            IconButton(
              tooltip: 'Sesli dinle',
              icon: _yukleniyorSes
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      _caliyor ? Icons.stop_circle_outlined : Icons.play_circle_outline,
                      color: Renkler.vurgu,
                    ),
              onPressed: _yukleniyorSes ? null : _sesCal,
            ),
          ValueListenableBuilder<Set<String>>(
            valueListenable: DuaStore.favoriler,
            builder: (context, fav, _) {
              final secili = fav.contains(dua.id);
              return IconButton(
                tooltip: secili ? 'Favorilerden çıkar' : 'Favorilere ekle',
                icon: Icon(
                  secili ? Icons.favorite : Icons.favorite_border,
                  color: secili ? Colors.redAccent : Colors.white70,
                ),
                onPressed: () => DuaStore.favoriDegistir(dua.id),
              );
            },
          ),
          IconButton(
            tooltip: 'Görsel kart paylaş',
            icon: const Icon(Icons.share_outlined, color: Colors.white70),
            onPressed: _paylasiliyor ? null : _paylas,
          ),
        ],
      ),
      body: Column(
        children: [
          _FontBoyutuCubugu(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: [
                RepaintBoundary(
                  key: _kartAnahtari,
                  child: _DuaKarti(dua: dua, kategoriAdi: widget.kategoriAdi),
                ),
                if (_sesHata != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _sesHata!,
                      style: TextStyle(color: Colors.orangeAccent, fontSize: 12),
                    ),
                  ),
                if (dua.tekrar != null && dua.tekrar! > 0)
                  _Zikirmatik(dua: dua),
                const SizedBox(height: 12),
                _KaynakKarti(dua: dua),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// YAZI BOYUTU KONTROLÜ
// ===========================================================================
class _FontBoyutuCubugu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: DuaStore.fontBoyutu,
      builder: (context, boyut, _) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: Row(
              children: [
                const Icon(Icons.format_size, color: Colors.white54, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Slider(
                    value: boyut.clamp(13, 30),
                    min: 13,
                    max: 30,
                    activeColor: Renkler.vurgu,
                    inactiveColor: Renkler.cerceve2,
                    onChanged: (v) => DuaStore.fontBoyutuYaz(v),
                  ),
                ),
                Text(
                  '${boyut.round()}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ===========================================================================
// DUA KARTI (paylaşıma da aynı kart basılır)
// ===========================================================================
class _DuaKarti extends StatelessWidget {
  final DuaKaydi dua;
  final String? kategoriAdi;

  const _DuaKarti({required this.dua, this.kategoriAdi});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: DuaStore.fontBoyutu,
      builder: (context, boyut, _) {
        final arapcaBoyut = boyut + 6;
        final okunusBoyut = boyut - 2;
        final mealBoyut = boyut - 4;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Renkler.bannerUst, Renkler.bannerAlt],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Renkler.cerceve),
            boxShadow: [
              BoxShadow(
                color: Renkler.vurgu.withValues(alpha: 0.15),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.mosque_outlined, color: Renkler.acikVurgu, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      dua.baslik,
                      style: TextStyle(
                        color: Renkler.acikVurgu,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                dua.arapca,
                textAlign: TextAlign.center,
                textDirection: ui.TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: arapcaBoyut,
                  fontWeight: FontWeight.bold,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 14),
              Container(height: 1, color: Colors.white.withValues(alpha: 0.15)),
              const SizedBox(height: 14),
              Text(
                dua.okunus,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: okunusBoyut,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              Container(height: 1, color: Colors.white.withValues(alpha: 0.15)),
              const SizedBox(height: 14),
              Text(
                '"${dua.meal}"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: mealBoyut,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                dua.kaynak,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Renkler.acikVurgu,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ===========================================================================
// ZİKİRMATİK (tekrar sayacı)
// ===========================================================================
class _Zikirmatik extends StatefulWidget {
  final DuaKaydi dua;

  const _Zikirmatik({required this.dua});

  @override
  State<_Zikirmatik> createState() => _ZikirmatikState();
}

class _ZikirmatikState extends State<_Zikirmatik> {
  int _sayi = 0;

  @override
  void initState() {
    super.initState();
    _sayi = DuaStore.sayacOku(widget.dua.id);
  }

  Future<void> _arttir() async {
    final yeni = await DuaStore.sayacArttir(widget.dua.id);
    if (mounted) setState(() => _sayi = yeni);
  }

  Future<void> _sifirla() async {
    await DuaStore.sayacSifirla(widget.dua.id);
    if (mounted) setState(() => _sayi = 0);
  }

  @override
  Widget build(BuildContext context) {
    final hedef = widget.dua.tekrar ?? 0;
    final tamamlandi = hedef > 0 && _sayi >= hedef;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: tamamlandi ? Colors.greenAccent : Renkler.cerceve,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.radio_button_checked,
                color: tamamlandi ? Colors.greenAccent : Colors.pinkAccent,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tamamlandi
                      ? 'Zikirmatik tamamlandı, maşallah! 🎉'
                      : 'Zikirmatik · hedef: $hedef tekrar',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Sıfırla',
                icon: const Icon(Icons.refresh, color: Colors.white54, size: 18),
                onPressed: _sifirla,
              ),
            ],
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: _arttir,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: Renkler.seciliYuzey,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Text(
                    '$_sayi',
                    style: TextStyle(
                      color: tamamlandi ? Colors.greenAccent : Renkler.vurgu,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  if (hedef > 0) ...[
                    const SizedBox(height: 4),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (_sayi / hedef).clamp(0.0, 1.0),
                        minHeight: 5,
                        backgroundColor: Renkler.cerceve2,
                        valueColor: AlwaysStoppedAnimation(
                          tamamlandi ? Colors.greenAccent : Renkler.vurgu,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '$hedef',
                      style: const TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Dokunarak say · hedefe ulaşınca yeniden başlar',
            style: TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// KAYNAK KARTI
// ===========================================================================
class _KaynakKarti extends StatelessWidget {
  final DuaKaydi dua;

  const _KaynakKarti({required this.dua});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.menu_book_outlined, color: Colors.white38, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Kaynak: ${dua.kaynak}',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
