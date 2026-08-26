import 'dart:async';
import 'package:flutter/material.dart';
import '../services/manevi_store.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';
import '../services/vakit_servisi.dart';
import 'kuran/hatim_takibi_page.dart';

class RamazanModuPage extends StatefulWidget {
  const RamazanModuPage({super.key});

  @override
  State<RamazanModuPage> createState() => _RamazanModuPageState();
}

class _RamazanModuPageState extends State<RamazanModuPage> {
  Timer? _timer;
  late DateTime _now;
  int _hatimSayfa = 0;

  String _iftarSaati = '20:17';
  String _sahurSaati = '04:12';
  int _iftarSaat = 20;
  int _iftarDakika = 17;
  int _sahurSaat = 4;
  int _sahurDakika = 12;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
    _hatimYukle();
    _vakitleriYukle();
  }

  Future<void> _vakitleriYukle() async {
    final vakitler = await VakitServisi.gunlukVakitler();
    if (!mounted) return;
    setState(() {
      for (final v in vakitler) {
        if (v.ad == 'Akşam') {
          _iftarSaati = v.saatYaz;
          _iftarSaat = v.saat;
          _iftarDakika = v.dakika;
        } else if (v.ad == 'İmsak') {
          _sahurSaati = v.saatYaz;
          _sahurSaat = v.saat;
          _sahurDakika = v.dakika;
        }
      }
    });
  }

  Future<void> _hatimYukle() async {
    final durum = await ManeviStore.hatimDurumu();
    if (mounted) setState(() => _hatimSayfa = durum['bugun'] ?? 0);
  }

  Future<void> _hatimSayfasiniAc() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HatimTakibiPage()),
    );
    await _hatimYukle();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  (String, Duration) _kalanHesap() {
    final ramazanIci = ManeviStore.ramazanIci(_now);
    final bugunIftar = DateTime(
      _now.year,
      _now.month,
      _now.day,
      _iftarSaat,
      _iftarDakika,
    );
    final sahurSaat = DateTime(
      _now.year,
      _now.month,
      _now.day,
      _sahurSaat,
      _sahurDakika,
    );
    if (ramazanIci) {
      if (_now.isBefore(bugunIftar)) {
        return ('İftara kalan', bugunIftar.difference(_now));
      }
      final yarinSahur = sahurSaat.add(const Duration(days: 1));
      return ('Sahura kalan', yarinSahur.difference(_now));
    }
    final baslangic = ManeviStore.sonrakiRamazanBaslangic(_now);
    return ('Ramazan\'a kalan', baslangic.difference(_now));
  }

  String _kalanYaz(Duration d) {
    if (d.isNegative) d = Duration.zero;
    final g = d.inDays;
    final h = d.inHours % 24;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    if (g > 0) return '$g gün $h saat';
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final (etiket, kalan) = _kalanHesap();
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
                    _countdownKarti(etiket, kalan),
                    const SizedBox(height: 16),
                    _hatimKarti(),
                    const SizedBox(height: 16),
                    _ozelGunlerKarti(),
                    const SizedBox(height: 16),
                    _saatKarti(),
                    const SizedBox(height: 16),
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
            icon: const UcdIkon(ikon: Icons.arrow_back_ios_new_rounded, renk: Colors.white),
          ),
          const SizedBox(width: 8),
          const Text(
            'Ramazan Modu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const UcdIkon(ikon: Icons.nights_stay_rounded, renk: Colors.white54, boyut: 24),
        ],
      ),
    );
  }

  Widget _countdownKarti(String etiket, Duration kalan) {
    final ramazanIci = ManeviStore.ramazanIci(_now);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: ramazanIci
              ? [Renkler.vurgu, Renkler.vurgu.withValues(alpha: 0.55)]
              : [Renkler.bannerUst, Renkler.bannerAlt],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🌙', style: TextStyle(fontSize: 28)),
              const SizedBox(width: 10),
              Text(
                ramazanIci ? 'Ramazan ayındasın' : 'Ramazan ayına hazırlık',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            etiket,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            _kalanYaz(kalan),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hatimKarti() {
    return GestureDetector(
      onTap: _hatimSayfasiniAc,
      child: Container(
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
                UcdIkon(ikon: Icons.auto_stories_rounded, renk: Renkler.vurgu, boyut: 20),
                SizedBox(width: 8),
                Text(
                  'Günlük Hatim Hedefi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  '$_hatimSayfa / 20 sayfa',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const Spacer(),
                Text(
                  '${(_hatimSayfa / 20 * 100).round()}%',
                  style: TextStyle(
                    color: Renkler.vurgu,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (_hatimSayfa / 20).clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: Renkler.cerceve,
                valueColor: AlwaysStoppedAnimation<Color>(Renkler.vurgu),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: _hatimSayfasiniAc,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Renkler.vurgu,
                  side: BorderSide(color: Renkler.vurgu.withValues(alpha: 0.6)),
                ),
                icon: UcdIkon(ikon: Icons.arrow_forward_rounded, renk: Renkler.vurgu, boyut: 16),
                label: const Text('Hatim sayfasına git'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ozelGunlerKarti() {
    final bugun =
        '${_now.year}-${_now.month.toString().padLeft(2, '0')}-${_now.day.toString().padLeft(2, '0')}';
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
              UcdIkon(ikon: Icons.event_rounded, renk: Renkler.vurgu, boyut: 20),
              SizedBox(width: 8),
              Text(
                'Özel Günler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Kandiller ve mübarek günler (Diyanet takvimi · otomatik güncellenir)',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 12),
          ...ManeviStore.ozelGunler.map(
            (g) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Text(g['ikon']!, style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      g['ad']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    g['tarih']!,
                    style: TextStyle(
                      color: g['tarih'] == bugun
                          ? Renkler.vurgu
                          : Colors.white54,
                      fontSize: 12,
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

  Widget _saatKarti() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(child: _saatKutusu('🌅 Sahur sonu', _sahurSaati)),
          const SizedBox(width: 12),
          Expanded(child: _saatKutusu('🌇 İftar', _iftarSaati)),
        ],
      ),
    );
  }

  Widget _saatKutusu(String etiket, String saat) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(etiket, style: TextStyle(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            saat,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}

/// Ana ekranda, vakit kartlarının hemen altında görünen canlı geri sayım bandı.
class RamazanBanner extends StatefulWidget {
  const RamazanBanner({super.key});

  @override
  State<RamazanBanner> createState() => _RamazanBannerState();
}

class _RamazanBannerState extends State<RamazanBanner> {
  Timer? _timer;
  late DateTime _now;
  int _iftarSaat = 20;
  int _iftarDakika = 17;
  int _sahurSaat = 4;
  int _sahurDakika = 12;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
    _vakitleriYukle();
  }

  Future<void> _vakitleriYukle() async {
    final vakitler = await VakitServisi.gunlukVakitler();
    if (!mounted) return;
    setState(() {
      for (final v in vakitler) {
        if (v.ad == 'Akşam') {
          _iftarSaat = v.saat;
          _iftarDakika = v.dakika;
        } else if (v.ad == 'İmsak') {
          _sahurSaat = v.saat;
          _sahurDakika = v.dakika;
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _kalanYaz(Duration d) {
    if (d.isNegative) d = Duration.zero;
    final g = d.inDays;
    final h = d.inHours % 24;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    if (g > 0) return '$g gün $h saat';
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final ramazanIci = ManeviStore.ramazanIci(_now);
    String etiket;
    Duration kalan;
    if (ramazanIci) {
      final iftar = DateTime(
        _now.year,
        _now.month,
        _now.day,
        _iftarSaat,
        _iftarDakika,
      );
      if (_now.isBefore(iftar)) {
        etiket = 'İftara kalan';
        kalan = iftar.difference(_now);
      } else {
        etiket = 'Sahura kalan';
        kalan = DateTime(
          _now.year,
          _now.month,
          _now.day,
          _sahurSaat,
          _sahurDakika,
        ).add(const Duration(days: 1)).difference(_now);
      }
    } else {
      etiket = 'Ramazan\'a kalan';
      kalan = ManeviStore.sonrakiRamazanBaslangic(_now).difference(_now);
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RamazanModuPage()),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Renkler.vurgu, Renkler.vurgu.withValues(alpha: 0.55)],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Renkler.vurgu.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Text('🌙', style: TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ramazan Modu · $etiket',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _kalanYaz(kalan),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      fontFeatures: [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
            const UcdIkon(ikon: Icons.chevron_right_rounded, renk: Colors.white70),
          ],
        ),
      ),
    );
  }
}
