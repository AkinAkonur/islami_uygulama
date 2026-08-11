import 'package:flutter/material.dart';

import '../l10n/dil_hizmetleri.dart';
import '../services/hadis_kutuphanesi_service.dart';
import '../services/renkler.dart';

class HadisKutuphanesiPage extends StatefulWidget {
  const HadisKutuphanesiPage({super.key});

  @override
  State<HadisKutuphanesiPage> createState() => _HadisKutuphanesiPageState();
}

class _HadisKutuphanesiPageState extends State<HadisKutuphanesiPage> {
  final Set<String> _hazirKitaplar = <String>{};
  List<HadisKitabi> _kitaplar = const [];
  String _dilKod = 'tr';
  String? _listeHata;
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    DilHizmetleri.aktifDil.addListener(_dilDegisti);
    _yukle();
  }

  @override
  void dispose() {
    DilHizmetleri.aktifDil.removeListener(_dilDegisti);
    super.dispose();
  }

  void _dilDegisti() {
    if (!mounted) return;
    setState(() => _yukle());
  }

  Future<void> _yukle() async {
    final dil = DilHizmetleri.aktifDil.value.languageCode;
    setState(() {
      _dilKod = dil;
      _yukleniyor = true;
      _listeHata = null;
    });
    final kitaplar = await HadisKutuphanesiService.instance.kitaplariGetir(
      dil,
      agYok: () {
        if (!mounted) return;
        setState(() {
          _listeHata =
              'Kitap listesi alınamadı. İnternet bağlantınızı kontrol edin; indirilen kitaplar çevrimdışı çalışmaya devam eder.';
        });
      },
    );
    final hazir = <String>{};
    for (final kitap in kitaplar) {
      if (await HadisKutuphanesiService.instance.kitapHazir(kitap.kod)) {
        hazir.add(kitap.kod);
      }
    }
    if (!mounted) return;
    setState(() {
      _kitaplar = kitaplar;
      _hazirKitaplar..clear()..addAll(hazir);
      _yukleniyor = false;
    });
  }

  Future<void> _kitapAc(HadisKitabi kitap) async {
    if (_hazirKitaplar.contains(kitap.kod)) {
      _kitapSayfasiAc(kitap);
      return;
    }
    final basarili = await _indirVeAc(kitap);
    if (basarili && mounted) _kitapSayfasiAc(kitap);
  }

  Future<bool> _indirVeAc(HadisKitabi kitap) async {
    final cevap = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _IndirmeDialogu(kitap: kitap),
    );
    if (cevap == true && mounted) {
      setState(() => _hazirKitaplar.add(kitap.kod));
    }
    return cevap == true;
  }

  void _kitapSayfasiAc(HadisKitabi kitap) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => _KitapSayfasi(kitap: kitap)),
    );
  }

  String _dilAdi() {
    for (final s in DilHizmetleri.secenekler) {
      if (s.kod == _dilKod) return s.ad;
    }
    return _dilKod;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text(
          'Hadis Kütüphanesi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
      ),
      body: _icerik(),
    );
  }

  Widget _icerik() {
    if (_yukleniyor) {
      return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
    }
    if (_kitaplar.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.menu_book_outlined,
                  color: Colors.white38, size: 48),
              const SizedBox(height: 12),
              const Text(
                'Bu dil için hadis kitabı bulunamadı. Ayarlar bölümünden desteklenen bir dil seçebilirsiniz.',
                style: TextStyle(color: Colors.white70, height: 1.4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Renkler.vurgu,
                  foregroundColor: Colors.black,
                ),
                onPressed: () => setState(() => _yukle()),
                icon: const Icon(Icons.refresh),
                label: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _aciklamaKarti(),
        if (_listeHata != null) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
            ),
            child: Text(
              _listeHata!,
              style: const TextStyle(color: Colors.orangeAccent, fontSize: 11),
            ),
          ),
        ],
        const SizedBox(height: 14),
        for (final kitap in _kitaplar) _kitapKarti(kitap),
        const SizedBox(height: 8),
        const Text(
          'Kaynak: compressed_hadith_sqlite (MIT) • Kitaplar ilk açılışta indirilir, sonra çevrimdışı çalışır.',
          style: TextStyle(color: Colors.white38, fontSize: 10),
        ),
      ],
    );
  }

  Widget _aciklamaKarti() {
    final indirilen = _hazirKitaplar.length;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.translate, color: Renkler.vurgu, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Dil: ${_dilAdi()} • ${_kitaplar.length} kitap • $indirilen kitap cihazda hazır.',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kitapKarti(HadisKitabi kitap) {
    final hazir = _hazirKitaplar.contains(kitap.kod);
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 16, right: 4),
        leading: CircleAvatar(
          backgroundColor: Renkler.vurgu.withValues(alpha: 0.15),
          child: Icon(
            Icons.menu_book,
            color: Renkler.vurgu,
            size: 20,
          ),
        ),
        title: Text(
          kitap.adYerli,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          '${kitap.hadisSayisi} hadis • ${kitap.bolumSayisi} bölüm • ${kitap.boyutMetni}',
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hazir)
              const Icon(Icons.offline_pin_outlined,
                  color: Colors.greenAccent, size: 18)
            else
              IconButton(
                tooltip: 'İndir',
                onPressed: () => _kitapAc(kitap),
                icon: const Icon(Icons.download_outlined,
                    color: Colors.white54, size: 20),
              ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
        onTap: () => _kitapAc(kitap),
      ),
    );
  }
}

// ===========================================================================
// İNDİRME DİYALOĞU (yeniden deneme destekli)
// ===========================================================================
class _IndirmeDialogu extends StatefulWidget {
  const _IndirmeDialogu({required this.kitap});

  final HadisKitabi kitap;

  @override
  State<_IndirmeDialogu> createState() => _IndirmeDialoguState();
}

class _IndirmeDialoguState extends State<_IndirmeDialogu> {
  double _oran = 0;
  String _durum = 'Hazırlanıyor…';
  String? _hata;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _baslat());
  }

  Future<void> _baslat() async {
    setState(() {
      _hata = null;
      _oran = 0;
      _durum = 'İndiriliyor…';
    });
    try {
      final servis = HadisKutuphanesiService.instance;
      await servis.bolumler(
        widget.kitap.kod,
        ilerleme: (indirilen, toplam) {
          if (!mounted) return;
          setState(() {
            _durum = '${(indirilen / (1024 * 1024)).toStringAsFixed(1)} / ${(toplam / (1024 * 1024)).toStringAsFixed(1)} MB';
            _oran = toplam > 0 ? indirilen / toplam : 0;
          });
        },
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hata = 'İndirme başarısız oldu. İnternet bağlantınızı kontrol edin ve tekrar deneyin.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Renkler.kart,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        widget.kitap.adYerli,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LinearProgressIndicator(
            value: _hata != null ? null : _oran,
            backgroundColor: const Color(0xFF353534),
            valueColor: AlwaysStoppedAnimation(Renkler.vurgu),
            minHeight: 6,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Text(
            _hata ?? _durum,
            style: TextStyle(
              color: _hata != null ? Colors.orangeAccent : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        if (_hata == null)
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç'),
          )
        else ...[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Kapat'),
          ),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Renkler.vurgu,
              foregroundColor: Colors.black,
            ),
            onPressed: _baslat,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Tekrar Dene'),
          ),
        ],
      ],
    );
  }
}

// ===========================================================================
// KİTAP SAYFASI: ARAMA + BÖLÜMLER
// ===========================================================================
class _KitapSayfasi extends StatefulWidget {
  const _KitapSayfasi({required this.kitap});

  final HadisKitabi kitap;

  @override
  State<_KitapSayfasi> createState() => _KitapSayfasiState();
}

class _KitapSayfasiState extends State<_KitapSayfasi> {
  final TextEditingController _arama = TextEditingController();
  List<HadisBolumu>? _bolumler;
  List<HadisKaydi> _sonuclar = const [];
  String? _hata;
  bool _aramaYapiliyor = false;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  @override
  void dispose() {
    _arama.dispose();
    super.dispose();
  }

  Future<void> _yukle() async {
    setState(() {
      _bolumler = null;
      _hata = null;
    });
    try {
      final bolumler =
          await HadisKutuphanesiService.instance.bolumler(widget.kitap.kod);
      if (!mounted) return;
      setState(() => _bolumler = bolumler);
    } catch (e) {
      if (!mounted) return;
      setState(() => _hata = 'Bölümler alınamadı: $e');
    }
  }

  Future<void> _aramaYap(String sorgu) async {
    final temiz = sorgu.trim();
    if (temiz.length < 2) {
      setState(() {
        _sonuclar = const [];
        _aramaYapiliyor = false;
      });
      return;
    }
    setState(() => _aramaYapiliyor = true);
    try {
      final sonuclar =
          await HadisKutuphanesiService.instance.ara(widget.kitap.kod, temiz);
      if (!mounted) return;
      setState(() {
        _sonuclar = sonuclar;
        _aramaYapiliyor = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _sonuclar = const [];
        _aramaYapiliyor = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          widget.kitap.adYerli,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Kitabı kaldır',
            onPressed: _kaldir,
            icon: const Icon(Icons.delete_outline, color: Colors.white54),
          ),
        ],
      ),
      body: Column(
        children: [
          _aramaCubugu(),
          Expanded(child: _icerik()),
        ],
      ),
    );
  }

  Future<void> _kaldir() async {
    final onay = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Renkler.kart,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Kitabı kaldır',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          '${widget.kitap.adYerli} cihazınızdan silinecek. İsterseniz yeniden indirebilirsiniz.',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sil'),
          ),
        ],
      ),
    );
    if (onay != true || !mounted) return;
    await HadisKutuphanesiService.instance.sil(widget.kitap.kod);
    if (!mounted) return;
    Navigator.pop(context);
  }

  Widget _aramaCubugu() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: _arama,
        onChanged: _aramaYap,
        style: const TextStyle(color: Colors.white),
        cursorColor: Renkler.vurgu,
        decoration: InputDecoration(
          hintText: 'Bu kitapta ara…',
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 20),
          suffixIcon: _arama.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _arama.clear();
                    _aramaYap('');
                  },
                  icon: const Icon(Icons.close, color: Colors.white38, size: 18),
                )
              : null,
          filled: true,
          fillColor: Renkler.kart,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _icerik() {
    final aramaAktif = _arama.text.trim().length >= 2;
    if (aramaAktif) return _aramaSonuclari();
    if (_hata != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.white38, size: 44),
            const SizedBox(height: 12),
            Text(
              _hata!,
              style: const TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    final bolumler = _bolumler;
    if (bolumler == null) {
      return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        Text(
          '${bolumler.length} Bölüm',
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
        const SizedBox(height: 8),
        for (final bolum in bolumler) _bolumKarti(bolum),
      ],
    );
  }

  Widget _bolumKarti(HadisBolumu bolum) {
    final ad = bolum.adYerli.isNotEmpty ? bolum.adYerli : bolum.ad;
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        title: Text(
          ad,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          '${bolum.hadisSayisi} hadis',
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => _BolumSayfasi(
              kitap: widget.kitap,
              bolum: bolum,
            ),
          ),
        ),
      ),
    );
  }

  Widget _aramaSonuclari() {
    if (_aramaYapiliyor) {
      return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
    }
    if (_sonuclar.isEmpty) {
      return const Center(
        child: Text(
          'Sonuç bulunamadı.',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      children: [
        Text(
          '${_sonuclar.length} sonuç',
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
        const SizedBox(height: 8),
        for (final sonuc in _sonuclar) _hadisKarti(sonuc),
      ],
    );
  }

  Widget _hadisKarti(HadisKaydi hadis) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.cerceve2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _numaraRozeti(hadis.hadisNo),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  hadis.bolum,
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (hadis.derece != null) _dereceEtiketi(hadis.derece!),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            hadis.metin,
            style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.45),
          ),
          if (hadis.alim != null) ...[
            const SizedBox(height: 6),
            Text(
              hadis.alim!,
              style: const TextStyle(color: Colors.white38, fontSize: 10),
            ),
          ],
        ],
      ),
    );
  }
}

// ===========================================================================
// BÖLÜM SAYFASI: HADİSLER (sonsuz kaydırma)
// ===========================================================================
class _BolumSayfasi extends StatefulWidget {
  const _BolumSayfasi({required this.kitap, required this.bolum});

  final HadisKitabi kitap;
  final HadisBolumu bolum;

  @override
  State<_BolumSayfasi> createState() => _BolumSayfasiState();
}

class _BolumSayfasiState extends State<_BolumSayfasi> {
  static const _sayfaBoyutu = 40;

  final ScrollController _kaydirici = ScrollController();
  final List<HadisKaydi> _hadisler = [];
  bool _yukleniyor = false;
  bool _bitti = false;

  @override
  void initState() {
    super.initState();
    _kaydirici.addListener(_kaydirmaKontrol);
    _dahaYukle();
  }

  @override
  void dispose() {
    _kaydirici.dispose();
    super.dispose();
  }

  void _kaydirmaKontrol() {
    if (_kaydirici.position.pixels >=
        _kaydirici.position.maxScrollExtent - 400) {
      _dahaYukle();
    }
  }

  Future<void> _dahaYukle() async {
    if (_yukleniyor || _bitti) return;
    setState(() => _yukleniyor = true);
    try {
      final yeni = await HadisKutuphanesiService.instance.bolumHadisleri(
        widget.kitap.kod,
        widget.bolum.id,
        limit: _sayfaBoyutu,
        offset: _hadisler.length,
      );
      if (!mounted) return;
      setState(() {
        _hadisler.addAll(yeni);
        _bitti = yeni.length < _sayfaBoyutu;
        _yukleniyor = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _yukleniyor = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ad = widget.bolum.adYerli.isNotEmpty
        ? widget.bolum.adYerli
        : widget.bolum.ad;
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          ad,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
      ),
      body: ListView.builder(
        controller: _kaydirici,
        padding: const EdgeInsets.all(16),
        itemCount: _hadisler.length + (_yukleniyor ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _hadisler.length) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Renkler.vurgu,
                  ),
                ),
              ),
            );
          }
          return _hadisKarti(_hadisler[index]);
        },
      ),
    );
  }

  Widget _hadisKarti(HadisKaydi hadis) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _numaraRozeti(hadis.hadisNo),
              const Spacer(),
              if (hadis.derece != null) _dereceEtiketi(hadis.derece!),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            hadis.metin,
            style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5),
          ),
          if (hadis.alim != null) ...[
            const SizedBox(height: 8),
            Text(
              hadis.alim!,
              style: const TextStyle(color: Colors.white38, fontSize: 10),
            ),
          ],
        ],
      ),
    );
  }
}

// ===========================================================================
// ORTAK PARÇALAR
// ===========================================================================
Widget _numaraRozeti(int no) {
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      color: Renkler.seciliYuzey,
      shape: BoxShape.circle,
      border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
    ),
    alignment: Alignment.center,
    child: Text(
      '$no',
      style: TextStyle(
        color: Renkler.vurgu,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _dereceEtiketi(String derece) {
  final renk = switch (derece.toLowerCase()) {
    'sahih' => Colors.greenAccent,
    'hasan' => Colors.amberAccent,
    'hasan sahih' => Colors.amberAccent,
    _ => Colors.orangeAccent,
  };
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: renk.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: renk.withValues(alpha: 0.4)),
    ),
    child: Text(
      derece,
      style: TextStyle(
        color: renk,
        fontSize: 9,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
