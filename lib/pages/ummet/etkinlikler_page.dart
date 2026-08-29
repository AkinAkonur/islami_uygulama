import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/manevi_store.dart';
import '../../services/ummet_verileri.dart';
import '../../widgets/kart_sekilleri.dart';
import '../kabe_canli_page.dart';
import '../mekke_medine_sanal_tur_page.dart';

class EtkinliklerPage extends StatefulWidget {
  const EtkinliklerPage({super.key});

  @override
  State<EtkinliklerPage> createState() => _EtkinliklerPageState();
}

class _EtkinliklerPageState extends State<EtkinliklerPage> {
  bool _yukleniyor = true;
  List<Map<String, String>> _diniGunler = [];

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    await Future.delayed(Duration.zero);
    if (!mounted) return;
    setState(() {
      _diniGunler = ManeviStore.ozelGunler;
      _yukleniyor = false;
    });
  }

  bool _bugunMu(String tarih) {
    if (tarih.isEmpty) return false;
    final d = DateTime.now();
    final g = tarih.split('-');
    if (g.length < 3) return false;
    return int.tryParse(g[1]) == d.month && int.tryParse(g[2]) == d.day;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('et.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: _yukleniyor
          ? Center(child: CircularProgressIndicator(color: Renkler.vurgu))
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                _bilgiBanneri(l),
                SizedBox(height: 16),
                Text(
                  l.t('et.liveTitle'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                _canliYayinKarti(
                  ikon: Icons.location_city_rounded,
                  baslik: l.t('et.haramTitle'),
                  alt: l.t('et.haramSub'),
                  renk: Color(0xFFD4AF37),
                  tip: 'haram',
                ),
                _canliYayinKarti(
                  ikon: Icons.mosque_rounded,
                  baslik: l.t('et.nebeviTitle'),
                  alt: l.t('et.nebeviSub'),
                  renk: Color(0xFFEED07A),
                  tip: 'nebevi',
                ),
                _canliYayinKarti(
                  ikon: Icons.explore_rounded,
                  baslik: l.t('et.tourTitle'),
                  alt: l.t('et.tourSub'),
                  renk: Color(0xFFF2C14E),
                  tip: 'tur',
                ),
                SizedBox(height: 20),
                Text(
                  l.t('et.diniTitle'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                for (final e in ummetEtkinlikleri.reversed) ...[
                  _etkinlikKarti(e),
                  SizedBox(height: 10),
                ],
                SizedBox(height: 20),
                Text(
                  l.t('et.takvimTitle'),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                for (final g in _diniGunler.reversed.take(8)) ...[
                  _diniGunKarti(g),
                  SizedBox(height: 8),
                ],
                SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _bilgiBanneri(AppLocalizations l) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: Icons.videocam_rounded, renk: Renkler.vurgu, boyut: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  l.t('et.bannerTitle'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            l.t('et.bannerIntro'),
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _canliYayinKarti({
    required IconData ikon,
    required String baslik,
    required String alt,
    required Color renk,
    required String tip,
  }) {
    final l = AppLocalizations.of(context);
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: renk.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: UcdIkon(ikon: ikon, renk: renk, boyut: 24),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                baslik,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                      UcdIkon(ikon: Icons.circle_rounded, renk: Colors.redAccent, boyut: 8),
                  SizedBox(width: 4),
                  Text(
                    l.t('et.liveBadge'),
                    style: TextStyle(color: Colors.redAccent, fontSize: 8),
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Text(
          alt,
          style: TextStyle(color: Colors.white54, fontSize: 11),
        ),
        trailing: UcdIkon(ikon: Icons.play_circle_outline_rounded, renk: renk),
        onTap: () {
          if (tip == 'nebevi') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const KabeCanliPage(medineYayini: true),
              ),
            );
          } else if (tip == 'haram') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const KabeCanliPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MekkeMedineSanalTurPage(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _etkinlikKarti(UmmetEtkinligi e) {
    final bugun = _bugunMu(e.tarih);
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bugun ? Renkler.seciliYuzey : Renkler.kart,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: bugun ? Renkler.vurgu : Renkler.cerceve,
        ),
      ),
      child: Row(
        children: [
          Text(e.ikon, style: TextStyle(fontSize: 22)),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        e.ad,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    if (e.canli) ...[
                      SizedBox(width: 6),
                  UcdIkon(ikon: Icons.circle_rounded, renk: Colors.redAccent, boyut: 8),
                    ],
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  e.aciklama,
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _diniGunKarti(Map<String, String> g) {
    final tarih = g['tarih'] ?? '';
    final ad = g['ad'] ?? '';
    final ikon = g['ikon'] ?? '🌙';
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          Text(ikon, style: TextStyle(fontSize: 20)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              ad,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          if (tarih.length >= 10)
            Text(
              tarih.substring(0, 10),
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
        ],
      ),
    );
  }
}