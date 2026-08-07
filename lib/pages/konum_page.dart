import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../services/vakit_servisi.dart';
import 'kible_pusula_page.dart';

class KonumPage extends StatefulWidget {
  const KonumPage({super.key});

  @override
  State<KonumPage> createState() => _KonumPageState();
}

class _KonumPageState extends State<KonumPage> {
  List<VakitBilgisi> _vakitler = VakitServisi.varsayilan;
  String? _sehir;
  String? _ulke;
  (double, double)? _koordinat;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final vakitler = await VakitServisi.gunlukVakitler();
    final sehir = await VakitServisi.sehirOku();
    final ulke = await VakitServisi.ulkeOku();
    final koordinat = await VakitServisi.koordinatOku();
    if (!mounted) return;
    setState(() {
      _vakitler = vakitler;
      _sehir = sehir;
      _ulke = ulke;
      _koordinat = koordinat;
    });
  }

  String get _konumTxt {
    if (_sehir != null && _ulke != null) return '$_sehir, $_ulke';
    if (_sehir != null) return _sehir!;
    if (_koordinat != null) {
      return 'GPS: ${_koordinat!.$1.toStringAsFixed(3)}, '
          '${_koordinat!.$2.toStringAsFixed(3)}';
    }
    return 'Konum seçilmedi';
  }

  Future<void> _gpsIleBul() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    final ok = await VakitServisi.konumuOtomatikAl();
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    if (ok) {
      await _yukle();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konum izni verilmedi. Şehir seçebilirsin.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _konumSec() async {
    final sehirKutu = TextEditingController(text: _sehir ?? 'İstanbul');
    final ulkeKutu = TextEditingController(text: _ulke ?? 'Türkiye');

    final secildi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Renkler.kart,
        title: const Text(
          'Şehir Seç',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: sehirKutu,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Şehir',
                labelStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: ulkeKutu,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'Ülke',
                labelStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Örn: Şehir "İstanbul", Ülke "Türkiye"',
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Renkler.vurgu,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );

    if (secildi == true) {
      await VakitServisi.konumKaydet(
        sehir: sehirKutu.text.trim().isEmpty ? null : sehirKutu.text.trim(),
        ulke: ulkeKutu.text.trim().isEmpty ? null : ulkeKutu.text.trim(),
      );
      await _yukle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Renkler.bannerUst, Renkler.bannerAlt],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _baslikSatiri(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _konumKarti(context),
                    const SizedBox(height: 16),
                    _kibleKarti(context),
                    const SizedBox(height: 16),
                    _vakitKarti(),
                    const SizedBox(height: 16),
                    _uyariKarti(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baslikSatiri(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const SizedBox(width: 8),
          const Text(
            'Cami & Konum',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.location_on_outlined, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _konumKarti(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.vurgu, Renkler.vurgu.withValues(alpha: 0.55)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bulunduğun Yer',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _konumTxt,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Namaz vakitleri bu konuma göre hesaplanır.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _gpsIleBul,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                  ),
                  icon: const Icon(Icons.my_location, size: 18),
                  label: const Text('GPS ile Bul'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _konumSec,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                  ),
                  icon: const Icon(Icons.edit_location_alt_outlined, size: 18),
                  label: const Text('Şehir Seç'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kibleKarti(BuildContext context) {
    final koordinat = _koordinat;
    final aci = koordinat != null
        ? VakitServisi.kibleAcisi(koordinat.$1, koordinat.$2)
        : null;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const KiblePusulaPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Renkler.kart.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(Icons.explore_outlined, color: Renkler.vurgu, size: 34),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aci != null
                        ? 'Kıble yönün: ${aci.round()}° '
                            '${VakitServisi.yonEtiketi(aci)}'
                        : 'Kıble yönünü görmek için konumunu belirle',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Pusulayı aç ve Kâbe\'ye yönel',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }

  Widget _vakitKarti() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule_outlined, color: Renkler.vurgu, size: 20),
              SizedBox(width: 8),
              Text(
                'Bugünün Namaz Vakitleri',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._vakitler.map(
            (v) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Text(
                    v.ad,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const Spacer(),
                  Text(
                    v.saatYaz,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uyariKarti() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Renkler.vurgu, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Vakitler Diyanet/MWL yöntemiyle güncel konumuna göre '
              'hesaplanır. Konum izni vermezsen şehir seçerek kullanabilirsin.',
              style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}