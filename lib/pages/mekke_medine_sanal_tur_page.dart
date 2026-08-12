// ===========================================================================
// MEKKE & MEDİNE 360° SANAL TUR / GÖRSELLER
// ---------------------------------------------------------------------------
// İnteraktif Medya Merkezi modülü: dünyanın neresinden olursanız olun kutsal
// mekânları anlık izleyin.
//  🔴 Canlı Yayınlar: Mescid-i Haram (Kâbe) ve Mescid-i Nebevî canlı yayını
//     YouTube IFrame gömme ile (kalite internet hızına göre otomatik).
//  🎥 360° Sanal Tur: 360 derece video turlar.
//  📍 Mekânlar: Google Haritalar üzerinden konum & yol tarifi.
// ===========================================================================

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/canli_yayin_konfigurasyonu.dart';
import '../services/renkler.dart';
import 'youtube_embed_page.dart';

class SanalTurNoktasi {
  final String baslik;
  final String videoId;
  final String aciklama;

  const SanalTurNoktasi({
    required this.baslik,
    required this.videoId,
    required this.aciklama,
  });
}

class MekanKaydi {
  final String ad;
  final String aciklama;
  final double enlem;
  final double boylam;
  final IconData ikon;
  final Color renk;

  const MekanKaydi({
    required this.ad,
    required this.aciklama,
    required this.enlem,
    required this.boylam,
    required this.ikon,
    required this.renk,
  });
}

class MekkeMedineSanalTurPage extends StatelessWidget {
  const MekkeMedineSanalTurPage({super.key});

  /// 360° video turlar. Video ID'leri Remote Config üzerinden de
  /// yönetilebilir; bu liste uygulama-içi görsellik için sabittir.
  static const _sanalTurler = [
    SanalTurNoktasi(
      baslik: 'Kâbe 360° Sanal Tur (Mekke)',
      videoId: 'Q0yzeIgxdSQ',
      aciklama:
          'Kâbe-i Muazzama çevresinin 360 derece sanal turu: tavaf alanı, '
          'Hacerü\'l-Esved ve Mescid-i Haram\'ın ihtişamı.',
    ),
    SanalTurNoktasi(
      baslik: 'Mekke Turu 2026 · 360° Kâbe Deneyimi',
      videoId: 'Uggk1UJ9IpY',
      aciklama:
          'Mekke\'nin güncel 360° turu. Cihazınızı çevirerek veya parmağınızla '
          'sürükleyerek kutsal mekânda gezinebilirsiniz.',
    ),
  ];

  static const _mekanlar = [
    MekanKaydi(
      ad: 'Mescid-i Haram ve Kâbe',
      aciklama: 'Tavaf alanı ve Kâbe-i Muazzama · Mekke',
      enlem: 21.4225,
      boylam: 39.8262,
      ikon: Icons.mosque_outlined,
      renk: Colors.tealAccent,
    ),
    MekanKaydi(
      ad: 'Mescid-i Nebevî',
      aciklama: 'Ravza-i Mutahhara ve Yeşil Kubbe · Medine',
      enlem: 24.4672,
      boylam: 39.6111,
      ikon: Icons.place_outlined,
      renk: Colors.greenAccent,
    ),
    MekanKaydi(
      ad: 'Arafat Dağı',
      aciklama: 'Vakfe alanı · Hac günü dualar',
      enlem: 21.3549,
      boylam: 39.9843,
      ikon: Icons.terrain_outlined,
      renk: Colors.amberAccent,
    ),
    MekanKaydi(
      ad: 'Mina',
      aciklama: 'Şeytan taşlama ve mina çadırları',
      enlem: 21.4133,
      boylam: 39.8933,
      ikon: Icons.holiday_village_outlined,
      renk: Colors.deepOrangeAccent,
    ),
    MekanKaydi(
      ad: 'Müzdelife',
      aciklama: 'Gecelenecek açık alan · hedy kesimi',
      enlem: 21.3867,
      boylam: 39.8902,
      ikon: Icons.nights_stay_outlined,
      renk: Colors.indigoAccent,
    ),
    MekanKaydi(
      ad: 'Hira Mağarası',
      aciklama: 'İlk vahyin indiği Nur Dağı',
      enlem: 21.4575,
      boylam: 39.8589,
      ikon: Icons.landscape_outlined,
      renk: Colors.purpleAccent,
    ),
    MekanKaydi(
      ad: 'Sevr Mağarası',
      aciklama: 'Hicret yolculuğunda gizlenilen mağara',
      enlem: 21.3786,
      boylam: 39.8531,
      ikon: Icons.hiking_outlined,
      renk: Colors.blueAccent,
    ),
    MekanKaydi(
      ad: 'Cennetü\'l-Bakî',
      aciklama: 'Medine mezarlığı · sahabe kabirleri',
      enlem: 24.463,
      boylam: 39.6149,
      ikon: Icons.park_outlined,
      renk: Colors.lightGreenAccent,
    ),
  ];

  Future<void> _haritadaAc(BuildContext context, MekanKaydi mekan) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query='
      '${mekan.enlem},${mekan.boylam}',
    );
    try {
      final acildi = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!acildi && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harita açılamadı')),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Harita açılamadı')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mekkeCanliId = CanliYayinKonfigurasyonu.guncel.youtubeVideoId;
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Mekke & Medine Sanal Tur'),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _davetBanneri(),
          const SizedBox(height: 18),

          _bolumBasligi('🔴 Canlı Yayınlar', '7/24 kesintisiz · otomatik kalite'),
          const SizedBox(height: 10),
          if (mekkeCanliId.isNotEmpty)
            _videoKarti(
              ikon: Icons.mosque_outlined,
              renk: Colors.redAccent,
              baslik: 'Mescid-i Haram - Kâbe Canlı',
              alt: 'Resmî Suudi yayını · tavaf ve namazlar canlı',
              canli: true,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => YoutubeEmbedPage(
                    videoId: mekkeCanliId,
                    baslik: 'Kâbe Canlı Yayın',
                    aciklama:
                        'Mescid-i Haram 7/24 canlı yayını: tavaf alanı, '
                        'Hacerü\'l-Esved ve namaz vakitlerinde imamların '
                        'kıldırdığı namazlar. Kalite internet hızınıza göre '
                        'otomatik belirlenir.',
                  ),
                ),
              ),
            ),
          _videoKarti(
            ikon: Icons.place_outlined,
            renk: Colors.greenAccent,
            baslik: 'Mescid-i Nebevî Canlı',
            alt: 'Medine · Ravza-i Mutahhara ve Yeşil Kubbe',
            canli: true,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const YoutubeEmbedPage(
                  videoId: 'QYCZzl--IQs',
                  baslik: 'Mescid-i Nebevî Canlı Yayın',
                  aciklama:
                      'Mescid-i Nebevî 7/24 canlı yayını: Ravza-i Mutahhara, '
                      'Yeşil Kubbe ve Medine\'nin huzur veren atmosferi.',
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),

          _bolumBasligi('🎥 360° Sanal Tur', 'cihazı çevirerek gezin'),
          const SizedBox(height: 10),
          for (final tur in _sanalTurler)
            _videoKarti(
              ikon: Icons.threesixty_rounded,
              renk: Colors.amberAccent,
              baslik: tur.baslik,
              alt: tur.aciklama,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => YoutubeEmbedPage(
                    videoId: tur.videoId,
                    baslik: tur.baslik,
                    aciklama: tur.aciklama,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 18),

          _bolumBasligi('📍 Mekânlar', 'Google Haritalar\'da aç ve yol tarifi al'),
          const SizedBox(height: 10),
          for (final mekan in _mekanlar)
            _mekanKarti(context, mekan),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _davetBanneri() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.travel_explore, color: Colors.white, size: 26),
              SizedBox(width: 10),
              Text(
                'Kutsal mekânları keşfet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'İster Hac/Umre öncesi keşif, ister hasret gideren sanal bir '
            'ziyaret: Mekke ve Medine artık bir dokunuşla sizinle.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bolumBasligi(String baslik, String alt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          baslik,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          alt,
          style: const TextStyle(color: Colors.white38, fontSize: 12),
        ),
      ],
    );
  }

  Widget _videoKarti({
    required IconData ikon,
    required Color renk,
    required String baslik,
    required String alt,
    required VoidCallback onTap,
    bool canli = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: renk.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(ikon, color: renk, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          baslik,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (canli)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.circle, size: 6, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                'CANLI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alt,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.play_circle_outline, color: Colors.white38),
          ],
        ),
      ),
    );
  }

  Widget _mekanKarti(BuildContext context, MekanKaydi mekan) {
    return GestureDetector(
      onTap: () => _haritadaAc(context, mekan),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: mekan.renk.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(mekan.ikon, color: mekan.renk, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mekan.ad,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    mekan.aciklama,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.map_outlined, color: Colors.white38, size: 22),
          ],
        ),
      ),
    );
  }
}