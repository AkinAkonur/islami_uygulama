import 'package:flutter/material.dart';

import '../../services/manevi_store.dart';
import '../../services/renkler.dart';
import '../dua_kardesligi/dua_kardesligi_page.dart';
import '../soru_cevap/soru_cevap_verileri.dart';
import 'gunluk_hedef_dialoglar.dart';
import 'gunluk_hedef_kutlama.dart';
import 'gunluk_hedef_store.dart';
import 'gunluk_hedef_verileri.dart';
import 'gunluk_hedef_widgetler.dart';

class GunlukHedeflerPage extends StatefulWidget {
  const GunlukHedeflerPage({super.key});

  @override
  State<GunlukHedeflerPage> createState() => _GunlukHedeflerPageState();
}

class _GunlukHedeflerPageState extends State<GunlukHedeflerPage> {
  List<bool> _hafta = List.filled(7, false);
  Set<String> _namaz = {};
  bool _hazir = false;

  @override
  void initState() {
    super.initState();
    GunlukHedefStore.kutlama.addListener(_kutlamayiGoster);
    _yukle();
  }

  @override
  void dispose() {
    GunlukHedefStore.kutlama.removeListener(_kutlamayiGoster);
    super.dispose();
  }

  Future<void> _yukle() async {
    await GunlukHedefStore.yukle();
    await _tazele();
    if (mounted) setState(() => _hazir = true);
  }

  Future<void> _tazele() async {
    final hafta = await GunlukHedefStore.sonYediGun();
    final namaz = await ManeviStore.bugunNamaz();
    if (!mounted) return;
    setState(() {
      _hafta = hafta;
      _namaz = namaz;
    });
  }

  void _kutlamayiGoster() {
    final sonuc = GunlukHedefStore.kutlama.value;
    if (sonuc == null || !mounted) return;
    GunlukHedefStore.kutlama.value = null;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Kutlama',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, _, _) => KutlamaEkrani(
        sonuc: sonuc,
        seri: GunlukHedefStore.seri,
      ),
    );
  }

  Future<void> _goreveGit(GunlukHedefTipi tip) async {
    switch (tip) {
      case GunlukHedefTipi.kissa:
        final okundu = await showDialog<bool>(
          context: context,
          builder: (context) => KissaDialogi(kissa: gununKissasi()),
        );
        if (okundu == true) await GunlukHedefStore.kissaTamamla();
      case GunlukHedefTipi.soru:
        final dogru = await showDialog<bool>(
          context: context,
          builder: (context) => SoruDialogi(
            soru: SoruCevapVerileri.gununSorusu(),
          ),
        );
        if (dogru == true) await GunlukHedefStore.soruDogru();
      case GunlukHedefTipi.kardeslik:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DuaKardesligiPage()),
        );
        await _tazele();
      case GunlukHedefTipi.zikir:
        final tamam = await showDialog<bool>(
          context: context,
          builder: (context) => ZikirSayaci(
            baslangic:
                GunlukHedefStore.bugunIlerleme[GunlukHedefTipi.zikir] ?? 0,
          ),
        );
        if (tamam == true) await _tazele();
    }
  }

  Future<void> _namazTikla(String vakit) async {
    final yeni = await ManeviStore.namazTikla(vakit, !_namaz.contains(vakit));
    if (mounted) setState(() => _namaz = yeni);
  }

  Future<void> _dondurucuAl() async {
    final ok = await GunlukHedefStore.dondurucuAl();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok ? 'Seri Dondurucu satın alındı! 🧊' : 'Yetersiz XP.',
        ),
        backgroundColor: ok ? Colors.green : Colors.blueGrey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Günlük Hedefler & Streak'),
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
      ),
      body: !_hazir
          ? const Center(child: CircularProgressIndicator(color: Colors.white54))
          : ValueListenableBuilder<int>(
              valueListenable: GunlukHedefStore.surum,
              builder: (context, _, _) => CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: _StreakHeroKarti()),
                  SliverToBoxAdapter(child: _HaftaSeridi(hafta: _hafta)),
                  SliverToBoxAdapter(child: _bolumBasligi('📋 Bugünün Hedefleri')),
                  SliverList.builder(
                    itemCount: gunlukGorevler.length,
                    itemBuilder: (context, index) {
                      final gorev = gunlukGorevler[index];
                      return _GorevKarti(
                        gorev: gorev,
                        ilerleme:
                            GunlukHedefStore.bugunIlerleme[gorev.tip] ?? 0,
                        onTap: () => _goreveGit(gorev.tip),
                      );
                    },
                  ),
                  SliverToBoxAdapter(child: _bolumBasligi('🕌 Namaz · 5 Vakit')),
                  SliverToBoxAdapter(
                    child: NamazKarti(namaz: _namaz, onTikla: _namazTikla),
                  ),
                  SliverToBoxAdapter(child: _bolumBasligi('🏅 Kilometre Taşları')),
                  const SliverToBoxAdapter(child: RozetlerBolumu()),
                  SliverToBoxAdapter(child: _bolumBasligi('🛒 Mağaza')),
                  SliverToBoxAdapter(child: MagazaKarti(onAl: _dondurucuAl)),
                  SliverToBoxAdapter(child: _bolumBasligi('📊 İstatistik')),
                  const SliverToBoxAdapter(child: IstatistikKarti()),
                  const SliverToBoxAdapter(child: SizedBox(height: 40)),
                ],
              ),
            ),
    );
  }

  Widget _bolumBasligi(String baslik) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        baslik,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _StreakHeroKarti extends StatelessWidget {
  const _StreakHeroKarti();

  @override
  Widget build(BuildContext context) {
    final tamam = GunlukHedefStore.bugunTamamlanan;
    final toplam = gunlukGorevler.length;
    final seri = GunlukHedefStore.seri;
    final oran = toplam == 0 ? 0.0 : tamam / toplam;
    final korundu = GunlukHedefStore.bugunKorundu;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            height: 92,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 92,
                  height: 92,
                  child: CircularProgressIndicator(
                    value: oran,
                    strokeWidth: 8,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.white.withValues(alpha: 0.15),
                    valueColor: AlwaysStoppedAnimation<Color>(Renkler.vurgu),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(seri > 0 ? '🔥' : '🌱',
                        style: const TextStyle(fontSize: 22)),
                    const SizedBox(height: 2),
                    Text(
                      '$seri',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      'gün',
                      style: TextStyle(color: Colors.white54, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seri > 0 ? 'Serin devam ediyor' : 'Serine başla',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  korundu
                      ? 'Seri Dondurucu ile bugün korundu. Hedefini tamamla!'
                      : 'Bugün $tamam/$toplam görev tamam. Tümü bitince seri '
                          '1 gün uzar.',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bugün kazanılan: ${GunlukHedefStore.bugunKazanilanXp} / '
                  '${GunlukHedefStore.gunlukMaxXp} XP',
                  style: TextStyle(
                    color: Renkler.acikVurgu,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HaftaSeridi extends StatelessWidget {
  const _HaftaSeridi({required this.hafta});

  final List<bool> hafta;

  static const _gunAdlari = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          for (var i = 0; i < 7; i++) ...[
            Expanded(
              child: Column(
                children: [
                  Text(
                    i == 6 ? 'Bugün' : _gunAdlari[i],
                    style: TextStyle(
                      color: i == 6 ? Renkler.vurgu : Colors.white54,
                      fontSize: 10,
                      fontWeight:
                          i == 6 ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hafta[i] ? '🔥' : '·',
                    style: TextStyle(
                      fontSize: 18,
                      color: hafta[i]
                          ? null
                          : Colors.white.withValues(alpha: 0.25),
                    ),
                  ),
                ],
              ),
            ),
            if (i != 6) Container(width: 1, height: 26, color: Colors.white12),
          ],
        ],
      ),
    );
  }
}

class _GorevKarti extends StatelessWidget {
  const _GorevKarti({
    required this.gorev,
    required this.ilerleme,
    required this.onTap,
  });

  final GunlukHedefGorev gorev;
  final int ilerleme;
  final VoidCallback onTap;

  String get _eylemEtiketi {
    switch (gorev.tip) {
      case GunlukHedefTipi.kissa:
        return 'Oku';
      case GunlukHedefTipi.soru:
        return 'Çöz';
      case GunlukHedefTipi.kardeslik:
        return 'Amin De';
      case GunlukHedefTipi.zikir:
        return 'Zikret';
    }
  }

  @override
  Widget build(BuildContext context) {
    final tamamMi = ilerleme >= gorev.hedefSayi;
    final oran = (ilerleme / gorev.hedefSayi).clamp(0.0, 1.0);
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: tamamMi ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(gorev.ikon,
                        style: const TextStyle(fontSize: 20)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gorev.ad,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          gorev.aciklama,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (tamamMi)
                    const Icon(Icons.check_circle,
                        color: Colors.greenAccent, size: 26)
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '+${gorev.xp} XP',
                          style: TextStyle(
                            color: Renkler.vurgu,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _eylemEtiketi,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              if (gorev.hedefSayi > 1) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: oran,
                          minHeight: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.1),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Renkler.vurgu),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$ilerleme/${gorev.hedefSayi}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
