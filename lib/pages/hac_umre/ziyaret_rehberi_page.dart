import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/renkler.dart';
import 'hac_umre_verileri.dart';
import 'ziyaret_verileri.dart';

// ===========================================================================
// MEKKE & MEDİNE ZİYARET REHBERİ
// Tarihî ve kutsal mekânlar; detaylar, ziyaret adabı ve haritada konum.
// ===========================================================================

class ZiyaretRehberiPage extends StatefulWidget {
  const ZiyaretRehberiPage({super.key});

  @override
  State<ZiyaretRehberiPage> createState() => _ZiyaretRehberiPageState();
}

class _ZiyaretRehberiPageState extends State<ZiyaretRehberiPage> {
  String _seciliBolum = ziyaretBolumleri.first;

  List<ZiyaretMekani> get _mekanlar => ziyaretMekanlari
      .where((m) => m.bolum == _seciliBolum)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Ziyaret Rehberi'),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: Column(
        children: [
          // Bölüm seçici (Mekke / Medine)
          Container(
            color: Renkler.yuzey,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                for (final b in ziyaretBolumleri)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _BolumButonu(
                        ad: b,
                        secili: b == _seciliBolum,
                        onTap: () => setState(() => _seciliBolum = b),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _mekanlar.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      '$_seciliBolum ziyaret mekânları · '
                      '${_mekanlar.length} yer',
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  );
                }
                final mekan = _mekanlar[index - 1];
                return _MekanKarti(
                  mekan: mekan,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _MekanDetayPage(mekan: mekan),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BolumButonu extends StatelessWidget {
  final String ad;
  final bool secili;
  final VoidCallback onTap;

  const _BolumButonu({
    required this.ad,
    required this.secili,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: secili ? Renkler.seciliYuzey : Renkler.kart,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: secili ? Renkler.vurgu.withValues(alpha: 0.5) : Renkler.cerceve,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              ad == 'Mekke' ? Icons.mosque_outlined : Icons.location_city,
              color: secili ? Renkler.vurgu : Colors.white38,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              ad,
              style: TextStyle(
                color: secili ? Colors.white : Colors.white54,
                fontWeight: secili ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MekanKarti extends StatelessWidget {
  final ZiyaretMekani mekan;
  final VoidCallback onTap;

  const _MekanKarti({required this.mekan, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final renk = Renkler.vurgu;
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: renk.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(_ikon(mekan.ikon), color: renk, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mekan.ad,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            mekan.kategori,
                            style: const TextStyle(
                                color: Colors.white54, fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      mekan.kisaAciklama,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.white24),
            ],
          ),
        ),
      ),
    );
  }

  static IconData _ikon(String ad) => switch (ad) {
        'mosque' => Icons.mosque_outlined,
        'grass' => Icons.eco_outlined,
        'terrain' => Icons.terrain,
        'landscape' => Icons.landscape,
        'book' => Icons.menu_book_outlined,
        _ => Icons.place_outlined,
      };
}

// ===========================================================================
// MEKÂN DETAY SAYFASI
// ===========================================================================
class _MekanDetayPage extends StatelessWidget {
  final ZiyaretMekani mekan;

  const _MekanDetayPage({required this.mekan});

  Future<void> _haritadaAc() async {
    if (mekan.enlem == null || mekan.boylam == null) return;
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1'
      '&query=${mekan.enlem},${mekan.boylam}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(mekan.ad),
        backgroundColor: Renkler.seciliYuzey,
        actions: [
          if (mekan.enlem != null && mekan.boylam != null)
            IconButton(
              tooltip: 'Haritada aç',
              onPressed: _haritadaAc,
              icon: const Icon(Icons.map_outlined),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Renkler.bannerUst, Renkler.bannerAlt],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.place_outlined,
                        color: Renkler.acikVurgu, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${mekan.bolum} · ${mekan.kategori}',
                      style: TextStyle(
                        color: Renkler.acikVurgu,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  mekan.kisaAciklama,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          if (mekan.detaylar.isNotEmpty) ...[
            const SizedBox(height: 16),
            _Bolum(
              ikon: Icons.menu_book_outlined,
              baslik: 'Bilgiler',
              renk: Renkler.vurgu,
              cocuklar: [
                for (final d in mekan.detaylar)
                  _madde(ikon: Icons.check_circle_outline, metin: d),
              ],
            ),
          ],
          if (mekan.ziyaretAdabi.isNotEmpty) ...[
            const SizedBox(height: 12),
            _Bolum(
              ikon: Icons.volunteer_activism_outlined,
              baslik: 'Ziyaret Adabı',
              renk: Colors.tealAccent,
              cocuklar: [
                for (final a in mekan.ziyaretAdabi)
                  _madde(ikon: Icons.favorite_outline, metin: a),
              ],
            ),
          ],
          if (mekan.enlem != null && mekan.boylam != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Renkler.vurgu,
                side: BorderSide(color: Renkler.cerceve),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _haritadaAc,
              icon: const Icon(Icons.map_outlined),
              label: const Text('Google Haritalar\'da Aç'),
            ),
            const SizedBox(height: 6),
            const Center(
              child: Text(
                'Koordinat: ${""}',
                style: TextStyle(color: Colors.white24, fontSize: 11),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _madde({required IconData ikon, required String metin}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(ikon, color: Colors.white38, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              metin,
              style: const TextStyle(
                  color: Colors.white70, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bolum extends StatelessWidget {
  final IconData ikon;
  final String baslik;
  final Color renk;
  final List<Widget> cocuklar;

  const _Bolum({
    required this.ikon,
    required this.baslik,
    required this.renk,
    required this.cocuklar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: renk.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ikon, color: renk, size: 18),
              const SizedBox(width: 8),
              Text(
                baslik,
                style: TextStyle(
                  color: renk,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...cocuklar,
        ],
      ),
    );
  }
}
