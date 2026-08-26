import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

/// Dua Odaları: Şifa, Borç/Rızık, Sınav, Aile Huzuru ve Hidayet odalarından
/// oluşan, bulut tabanlı arama / sayfalama / önbellekleme mantığıyla çalışan
/// dua modülüdür.
class DuaOdalariPage extends StatefulWidget {
  const DuaOdalariPage({super.key});

  @override
  State<DuaOdalariPage> createState() => _DuaOdalariPageState();
}

class _DuaOdalariPageState extends State<DuaOdalariPage> {
  final Map<String, int> _katilimlar = {};
  bool _yukleniyor = true;
  final TextEditingController _aramaCtrl = TextEditingController();
  String _aramaSorgusu = '';
  List<Map<String, dynamic>> _aramaSonuclari = [];
  bool _aramaAktif = false;

  static const _tabanKatilim = {
    'sifa': 12480,
    'borc': 9320,
    'sinav': 15740,
    'aile': 11060,
    'hidayet': 8750,
  };

  @override
  void initState() {
    super.initState();
    _yukle();
    _aramaCtrl.addListener(_aramaDegisti);
  }

  @override
  void dispose() {
    _aramaCtrl.dispose();
    super.dispose();
  }

  Future<void> _yukle() async {
    final katilimlar = <String, int>{};
    for (final k in duaKategorileri) {
      katilimlar[k['id']!] =
          _tabanKatilim[k['id']]! + await UmmetStore.odaKatilim(k['id']!);
    }
    if (!mounted) return;
    setState(() {
      _katilimlar.addAll(katilimlar);
      _yukleniyor = false;
    });
  }

  void _aramaDegisti() {
    final sorgu = _aramaCtrl.text;
    setState(() {
      _aramaSorgusu = sorgu;
      _aramaAktif = sorgu.trim().isNotEmpty;
      if (_aramaAktif) {
        _aramaSonuclari = UmmetStore.duaAra(sorgu, onSayfa: 12);
      } else {
        _aramaSonuclari = [];
      }
    });
    if (_aramaAktif) _aramaKullanicilariDahilEt();
  }

  Future<void> _aramaKullanicilariDahilEt() async {
    if (_aramaSorgusu.trim().isEmpty) return;
    final kullanici = await UmmetStore.kullaniciOdaDualari();
    final s = _aramaSorgusu.trim().toLowerCase();
    final kullaniciSonuc = kullanici
        .where(
          (d) =>
              (d['baslik'] ?? '').toLowerCase().contains(s) ||
              (d['turkce'] ?? '').toLowerCase().contains(s) ||
              (d['okunus'] ?? '').toLowerCase().contains(s),
        )
        .map(
          (d) => <String, dynamic>{
            'odaId': d['odaId'],
            'odaAd': '',
            'odaIkon': '',
            ...d,
          },
        )
        .toList();
    if (!mounted) return;
    setState(() {
      _aramaSonuclari = [...kullaniciSonuc, ..._aramaSonuclari];
    });
  }

  Future<void> _odaDuaSil(String duaId) async {
    await UmmetStore.odaDuaSil(duaId);
    _aramaDegisti();
  }

  Future<void> _odayaKatil(String id) async {
    await UmmetStore.odaKatil(id);
    setState(() {
      _katilimlar[id] = (_katilimlar[id] ?? 0) + 1;
    });
  }

  Future<void> _duaListemeGit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const _DuaListemPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Dua Odaları',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Kişisel Dua Listem',
            onPressed: _duaListemeGit,
            icon: const Icon(Icons.favorite_outline, color: Colors.white),
          ),
        ],
      ),
      body: _yukleniyor
          ? Center(child: CircularProgressIndicator(color: Renkler.vurgu))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: _aramaCubugu(),
                ),
                if (_aramaAktif)
                  Expanded(child: _aramaSonucListesi())
                else
                  Expanded(child: _odaListesi()),
              ],
            ),
    );
  }

  Widget _aramaCubugu() {
    return TextField(
      controller: _aramaCtrl,
      style: const TextStyle(color: Colors.white),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Dua ara… (örn. "sınav", "borç", "şifa")',
        hintStyle: TextStyle(color: Colors.white38),
        prefixIcon: const Icon(Icons.search, color: Colors.white54),
        suffixIcon: _aramaSorgusu.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear, color: Colors.white54),
                onPressed: () {
                  _aramaCtrl.clear();
                  setState(() {
                    _aramaAktif = false;
                    _aramaSonuclari = [];
                  });
                },
              ),
        filled: true,
        fillColor: Renkler.yuzey,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Renkler.cerceve2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Renkler.cerceve2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Renkler.vurgu, width: 1.5),
        ),
      ),
    );
  }

  Widget _aramaSonucListesi() {
    final sonuc = _aramaSonuclari;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          sonuc.isEmpty
              ? 'Sonuç bulunamadı'
              : '${sonuc.length} dua bulundu · "$_aramaSorgusu"',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        const SizedBox(height: 12),
        if (sonuc.isEmpty)
          _bosDurum()
        else
          for (final dua in sonuc) ...[
            _duaKarti(dua),
            const SizedBox(height: 12),
          ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _bosDurum() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Icon(Icons.search_off, color: Colors.white24, size: 48),
          const SizedBox(height: 12),
          Text(
            'Farklı bir kelime deneyin ya da bir odaya girin.',
            style: TextStyle(color: Colors.white38, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _odaListesi() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Renkler.bannerUst, Renkler.bannerAlt],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kategorize Dua Odaları',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Bir odaya gir, o konudaki duaları oku ve ümmetle birlikte niyet et. Her oda, binlerce kardeşin ortak duasıyla canlıdır.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (final k in duaKategorileri) ...[
          _odaKarti(context, k),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _odaKarti(BuildContext context, Map<String, String> kategori) {
    final id = kategori['id']!;
    final katilim = _katilimlar[id] ?? 0;
    final etiketler = (kategori['etiketler'] ?? '')
        .split(',')
        .where((e) => e.isNotEmpty)
        .toList();
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(kategori['ikon']!, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kategori['ad']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        kategori['aciklama']!,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final et in etiketler)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      et,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.groups, color: Renkler.vurgu, size: 16),
                const SizedBox(width: 6),
                Text(
                  '${binlikSayi(katilim)} kardeş odada',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const Spacer(),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Renkler.vurgu,
                    side: BorderSide(color: Renkler.cerceve2),
                  ),
                  onPressed: () async {
                    await _odayaKatil(id);
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _OdaDetayPage(kategori: kategori),
                      ),
                    );
                  },
                  child: const Text('Odaya Katıl'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Paylaşım metnini kart üzerinden oluşturur.
  String _duaPaylasimMetni(Map<String, dynamic> dua) {
    final oda = dua['odaAd'] ?? dua['odaId'];
    return '🤲 ${dua['baslik']}\n\n'
        '${dua['arapca']}\n\n'
        '${dua['turkce']}\n\n'
        '— Dua Odaları · $oda\n#islamiUygulama';
  }

  // Oda/arama listesinde kullanılan ortak dua kartı.
  Widget _duaKarti(Map<String, dynamic> dua) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    dua['baslik']!,
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (dua['odaIkon'] != null) Text(dua['odaIkon']!),
                if (dua['kullanicidan'] == 'true') ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Renkler.vurgu.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Senin duan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Duayı sil',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.white38,
                      size: 20,
                    ),
                    onPressed: () => _odaDuaSil(dua['id']!),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Text(
              dua['arapca']!,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.8,
              ),
            ),
            if ((dua['okunus'] ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                dua['okunus']!,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              dua['turkce']!,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              dua['kaynak']!,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
            if ((dua['fazilet'] ?? '').isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Renkler.seciliYuzey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.auto_awesome, color: Renkler.vurgu, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        dua['fazilet']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
            _duaAksiyonSatiri(dua),
          ],
        ),
      ),
    );
  }

  Widget _duaAksiyonSatiri(Map<String, dynamic> dua) {
    final odaId = dua['odaId']!;
    final baslik = dua['baslik']!;
    final anahtar = '$odaId|$baslik';
    return Row(
      children: [
        _ikonAksiyon(
          tooltip: 'Kopyala',
          ikon: Icons.copy_outlined,
          onTap: () async {
            await Clipboard.setData(
              ClipboardData(
                text:
                    '${dua['arapca']}\n\n${dua['turkce']}\n\n${dua['kaynak']}',
              ),
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Dua panoya kopyalandı'),
                  backgroundColor: Renkler.bannerUst,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
        _ikonAksiyon(
          tooltip: 'Paylaş',
          ikon: Icons.share_outlined,
          onTap: () async {
            await SharePlus.instance.share(
              ShareParams(text: _duaPaylasimMetni(dua)),
            );
          },
        ),
        _DinletButonu(dua: dua),
        const Spacer(),
        _FavoriButonu(odaId: odaId, baslik: baslik, anahtar: anahtar),
        const SizedBox(width: 4),
        _AminButonu(odaId: odaId, baslik: baslik),
      ],
    );
  }

  Widget _ikonAksiyon({
    required String tooltip,
    required IconData ikon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      onPressed: onTap,
      icon: Icon(ikon, color: Colors.white54, size: 20),
    );
  }
}

/// Tek bir duayı TTS ile dinletme butonu.
class _DinletButonu extends StatefulWidget {
  const _DinletButonu({required this.dua});

  final Map<String, dynamic> dua;

  @override
  State<_DinletButonu> createState() => _DinletButonuState();
}

class _DinletButonuState extends State<_DinletButonu> {
  final FlutterTts _tts = FlutterTts();
  bool _caliyor = false;

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _dinle() async {
    if (_caliyor) {
      await _tts.stop();
      if (mounted) setState(() => _caliyor = false);
      return;
    }
    try {
      await _tts.stop();
      await _tts.setLanguage('ar');
      await _tts.setSpeechRate(0.45);
      final metin = (widget.dua['okunus'] ?? '').isNotEmpty
          ? widget.dua['okunus']
          : widget.dua['arapca'];
      final sonuc = await _tts.speak(metin as String);
      if (mounted) {
        setState(() => _caliyor = sonuc == 1 || sonuc == 0);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cihazınızda Arapça ses bulunamadı.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _caliyor ? 'Durdur' : 'Dinle',
      visualDensity: VisualDensity.compact,
      onPressed: _dinle,
      icon: Icon(
        _caliyor ? Icons.stop_circle_outlined : Icons.volume_up_outlined,
        color: _caliyor ? Renkler.vurgu : Colors.white54,
        size: 20,
      ),
    );
  }
}

/// Kalp simgesiyle favoriye alma/kaldırma.
class _FavoriButonu extends StatefulWidget {
  const _FavoriButonu({
    required this.odaId,
    required this.baslik,
    required this.anahtar,
  });

  final String odaId;
  final String baslik;
  final String anahtar;

  @override
  State<_FavoriButonu> createState() => _FavoriButonuState();
}

class _FavoriButonuState extends State<_FavoriButonu> {
  bool _favori = false;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final durum = await UmmetStore.duaFavoriMi(widget.anahtar);
    if (mounted) setState(() => _favori = durum);
  }

  Future<void> _degistir() async {
    final yeni = await UmmetStore.duaFavoriDegistir(widget.anahtar);
    if (!mounted) return;
    setState(() => _favori = yeni);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          yeni
              ? 'Kişisel Dua Listene eklendi'
              : 'Kişisel Dua Listenden kaldırıldı',
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _favori ? 'Listemden çıkar' : 'Kişisel Dua Listeme ekle',
      visualDensity: VisualDensity.compact,
      onPressed: _degistir,
      icon: Icon(
        _favori ? Icons.favorite : Icons.favorite_border,
        color: _favori ? Colors.redAccent : Colors.white54,
        size: 20,
      ),
    );
  }
}

/// Âmin butonu ve katılım sayacı.
class _AminButonu extends StatefulWidget {
  const _AminButonu({required this.odaId, required this.baslik});

  final String odaId;
  final String baslik;

  @override
  State<_AminButonu> createState() => _AminButonuState();
}

class _AminButonuState extends State<_AminButonu> {
  int _ekAmin = 0;
  bool _aminVerdi = false;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final sayi = await UmmetStore.duaAminSayisi(widget.odaId, widget.baslik);
    if (mounted) {
      setState(() {
        _ekAmin = sayi;
        _aminVerdi = sayi > 0;
      });
    }
  }

  Future<void> _aminVer() async {
    if (_aminVerdi) return;
    final sayi = await UmmetStore.duaAminVer(widget.odaId, widget.baslik);
    if (!mounted) return;
    setState(() {
      _ekAmin = sayi;
      _aminVerdi = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Âmin dediniz 🤲 Ümmetle birlikte katıldınız.'),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taban = int.tryParse(_tabanAmin) ?? 0;
    final toplam = taban + _ekAmin;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: _aminVerdi ? Renkler.seciliYuzey : Renkler.vurgu,
            foregroundColor: _aminVerdi ? Colors.white70 : Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: _aminVer,
          child: Text(
            _aminVerdi ? 'Âmin ✓' : 'Âmin',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${binlikSayi(toplam)} kişi',
          style: const TextStyle(color: Colors.white38, fontSize: 10),
        ),
      ],
    );
  }

  String get _tabanAmin {
    final dualar = kategoriDualari[widget.odaId] ?? [];
    for (final d in dualar) {
      if (d['baslik'] == widget.baslik) return d['amin'] ?? '0';
    }
    return '0';
  }
}

class _OdaDetayPage extends StatefulWidget {
  const _OdaDetayPage({required this.kategori});

  final Map<String, String> kategori;

  @override
  State<_OdaDetayPage> createState() => _OdaDetayPageState();
}

class _OdaDetayPageState extends State<_OdaDetayPage> {
  static const _sayfaBoyutu = 6;

  String? _seciliEtiket;
  final List<Map<String, dynamic>> _gorunenDualar = [];
  bool _dahaVar = true;
  bool _yukleniyor = true;
  bool _dahaYukleniyor = false;
  final ScrollController _kaydirici = ScrollController();
  int _okunma = 0;

  List<String> get _etiketler => (widget.kategori['etiketler'] ?? '')
      .split(',')
      .where((e) => e.isNotEmpty)
      .toList();

  @override
  void initState() {
    super.initState();
    _kaydirici.addListener(_kaydirmaDinle);
    _ilkSayfayiYukle();
  }

  @override
  void dispose() {
    _kaydirici.dispose();
    super.dispose();
  }

  void _kaydirmaDinle() {
    if (!_kaydirici.hasClients) return;
    if (_kaydirici.position.pixels >=
        _kaydirici.position.maxScrollExtent - 200) {
      _dahaYukle();
    }
  }

  Future<List<Map<String, dynamic>>> _kaynakDualar() async {
    final hepsi = await UmmetStore.odaDualariHepsi(widget.kategori['id']!);
    if (_seciliEtiket == null) return hepsi;
    return hepsi.where((d) => (d['etiket'] ?? '') == _seciliEtiket).toList();
  }

  Future<void> _ilkSayfayiYukle() async {
    setState(() {
      _yukleniyor = true;
      _dahaVar = true;
      _gorunenDualar.clear();
    });
    // Bulut gecikmesi simülasyonu; ilk açılışta küçük bir sayfa yüklenir.
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;
    final kaynak = await _kaynakDualar();
    setState(() {
      _gorunenDualar.addAll(kaynak.take(_sayfaBoyutu));
      _dahaVar = kaynak.length > _sayfaBoyutu;
      _yukleniyor = false;
    });
  }

  Future<void> _dahaYukle() async {
    if (_dahaYukleniyor || !_dahaVar || _yukleniyor) return;
    setState(() => _dahaYukleniyor = true);
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    final kaynak = await _kaynakDualar();
    setState(() {
      _gorunenDualar.addAll(
        kaynak.skip(_gorunenDualar.length).take(_sayfaBoyutu),
      );
      _dahaVar = _gorunenDualar.length < kaynak.length;
      _dahaYukleniyor = false;
    });
  }

  Future<void> _odaDuaEt() async {
    setState(() => _okunma++);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Bu odada dua ettin: ${widget.kategori['ad']} 🤲',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _odaDuaSil(String duaId) async {
    await UmmetStore.odaDuaSil(duaId);
    await _ilkSayfayiYukle();
  }

  Future<void> _duaEkleDialog() async {
    final baslik = TextEditingController();
    final arapca = TextEditingController();
    final turkce = TextEditingController();
    final kaynak = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Renkler.yuzey,
        title: Row(
          children: [
            const Icon(Icons.add_link, color: Colors.white),
            const SizedBox(width: 8),
            const Text(
              'Dua Ekle',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: baslik,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Duanın adı',
                  labelStyle: TextStyle(color: Colors.white70),
                  hintText: 'Örn. Sabah Duası',
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: arapca,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Arapça metin',
                  labelStyle: TextStyle(color: Colors.white70),
                  hintText: 'Dua metnini Arapça yazın',
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: turkce,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Türkçe anlamı',
                  labelStyle: TextStyle(color: Colors.white70),
                  hintText: 'Okunuşu ve anlamı',
                  hintStyle: TextStyle(color: Colors.white38),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: kaynak,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Kaynak (isteğe bağlı)',
                  labelStyle: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Vazgeç',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Renkler.vurgu,
              foregroundColor: Renkler.zemin,
            ),
            onPressed: () async {
              final b = baslik.text.trim();
              final a = arapca.text.trim();
              final t = turkce.text.trim();
              if (b.isEmpty || (a.isEmpty && t.isEmpty)) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Duanın adı ile Arapça veya Türkçe metnini girin.',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }
              await UmmetStore.odaDuaEkle(
                odaId: widget.kategori['id']!,
                baslik: b,
                arapca: a,
                secimi: t,
                kaynak: kaynak.text.trim(),
              );
              if (!ctx.mounted) return;
              Navigator.of(ctx).pop();
              await _ilkSayfayiYukle();
              setState(() => _seciliEtiket = null);
            },
            icon: const Icon(Icons.check),
            label: const Text('Kaydet'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          '${widget.kategori['ikon']} ${widget.kategori['ad']} Odası',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Kişisel Dua Listem',
            onPressed: _duaListemeGit,
            icon: const Icon(Icons.favorite_outline, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Renkler.bannerUst, Renkler.bannerAlt],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '"${widget.kategori['aciklama']}"',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(Icons.self_improvement, color: Renkler.vurgu, size: 26),
                ],
              ),
            ),
          ),
          if (_etiketler.isNotEmpty)
            SizedBox(
              height: 52,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                children: [
                  _etiketChip(null, 'Tümü'),
                  for (final et in _etiketler) _etiketChip(et, et),
                ],
              ),
            ),
          Expanded(
            child: _yukleniyor
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    color: Renkler.vurgu,
                    onRefresh: _ilkSayfayiYukle,
                    child: ListView(
                      controller: _kaydirici,
                      padding: const EdgeInsets.all(16),
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        if (_gorunenDualar.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  color: Colors.white24,
                                  size: 44,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Bu etikette henüz dua yok.',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          for (final dua in _gorunenDualar) ...[
                            _duaKarti(dua),
                            const SizedBox(height: 12),
                          ],
                        if (_dahaYukleniyor)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 8),
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: Renkler.vurgu,
                            foregroundColor: Renkler.zemin,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: _odaDuaEt,
                          icon: const Icon(Icons.favorite_outline),
                          label: Text(
                            _okunma == 0
                                ? 'Bu Odada Dua Ettim'
                                : 'Tekrar Dua Ettim ($_okunma)',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _duaEkleDialog,
        backgroundColor: Renkler.vurgu,
        foregroundColor: Renkler.zemin,
        icon: const Icon(Icons.add),
        label: const Text(
          'Dua Ekle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _etiketChip(String? deger, String etiket) {
    final secili = _seciliEtiket == deger;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(etiket),
        selected: secili,
        labelStyle: TextStyle(
          color: secili ? Renkler.zemin : Colors.white70,
          fontWeight: secili ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
        selectedColor: Renkler.vurgu,
        backgroundColor: Renkler.yuzey,
        side: BorderSide(color: Renkler.cerceve2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onSelected: (_) {
          setState(() => _seciliEtiket = deger);
          _ilkSayfayiYukle();
        },
      ),
    );
  }

  Widget _duaKarti(Map<String, dynamic> dua) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    dua['baslik']!,
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                if ((dua['etiket'] ?? '').isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      dua['etiket']!,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                      ),
                    ),
                  ),
                if (dua['kullanicidan'] == 'true') ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Renkler.vurgu.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Senin duan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Duayı sil',
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.white38,
                      size: 20,
                    ),
                    onPressed: () => _odaDuaSil(dua['id']!),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Text(
              dua['arapca']!,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.8,
              ),
            ),
            if ((dua['okunus'] ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                dua['okunus']!,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              dua['turkce']!,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              dua['kaynak']!,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
            if ((dua['fazilet'] ?? '').isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Renkler.seciliYuzey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.auto_awesome, color: Renkler.vurgu, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        dua['fazilet']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
            _duaAksiyonSatiri(dua),
          ],
        ),
      ),
    );
  }

  Widget _duaAksiyonSatiri(Map<String, dynamic> dua) {
    final odaId = dua['odaId']!;
    final baslik = dua['baslik']!;
    final anahtar = '$odaId|$baslik';
    return Row(
      children: [
        _ikonAksiyon(
          tooltip: 'Kopyala',
          ikon: Icons.copy_outlined,
          onTap: () async {
            await Clipboard.setData(
              ClipboardData(
                text:
                    '${dua['arapca']}\n\n${dua['turkce']}\n\n${dua['kaynak']}',
              ),
            );
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Dua panoya kopyalandı'),
                  backgroundColor: Renkler.bannerUst,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
        ),
        _ikonAksiyon(
          tooltip: 'Paylaş',
          ikon: Icons.share_outlined,
          onTap: () async {
            await SharePlus.instance.share(
              ShareParams(
                text:
                    '🤲 ${dua['baslik']}\n\n'
                    '${dua['arapca']}\n\n'
                    '${dua['turkce']}\n\n'
                    '— Dua Odaları · ${widget.kategori['ad']}\n#islamiUygulama',
              ),
            );
          },
        ),
        _DinletButonu(dua: dua),
        const Spacer(),
        _FavoriButonu(odaId: odaId, baslik: baslik, anahtar: anahtar),
        const SizedBox(width: 4),
        _AminButonu(odaId: odaId, baslik: baslik),
      ],
    );
  }

  Widget _ikonAksiyon({
    required String tooltip,
    required IconData ikon,
    required VoidCallback onTap,
  }) {
    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      onPressed: onTap,
      icon: Icon(ikon, color: Colors.white54, size: 20),
    );
  }

  Future<void> _duaListemeGit() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const _DuaListemPage()),
    );
  }
}

/// Kişisel Dua Listesi: kullanıcının kalp ile işaretlediği dualar.
class _DuaListemPage extends StatefulWidget {
  const _DuaListemPage();

  @override
  State<_DuaListemPage> createState() => _DuaListemPageState();
}

class _DuaListemPageState extends State<_DuaListemPage> {
  bool _yukleniyor = true;
  List<Map<String, String>> _dualari = [];

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final liste = await UmmetStore.duaFavoriDualari();
    if (!mounted) return;
    setState(() {
      _dualari = liste;
      _yukleniyor = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text(
          'Kişisel Dua Listem',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: _yukleniyor
          ? const Center(child: CircularProgressIndicator())
          : _dualari.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, color: Colors.white24, size: 48),
                  SizedBox(height: 12),
                  Text(
                    'Henüz dua eklemediniz.\nDuaların yanındaki kalbe dokunarak ekleyin.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${_dualari.length} dua listenizde',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 12),
                for (final d in _dualari) ...[
                  Card(
                    color: Renkler.kart,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Renkler.cerceve),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  d['baslik']!,
                                  style: TextStyle(
                                    color: Renkler.vurgu,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Text(
                                '${d['odaIkon']} ${d['odaAd']}',
                                style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            d['arapca']!,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              height: 1.7,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            d['turkce']!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () async {
                                  await Clipboard.setData(
                                    ClipboardData(
                                      text:
                                          '${d['arapca']}\n\n${d['turkce']}\n\n${d['kaynak']}',
                                    ),
                                  );
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Dua panoya kopyalandı'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.copy_outlined,
                                  color: Colors.white54,
                                  size: 20,
                                ),
                              ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () async {
                                  await UmmetStore.duaFavoriDegistir(
                                    '${d['odaId']}|${d['baslik']}',
                                  );
                                  _yukle();
                                },
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
    );
  }
}
