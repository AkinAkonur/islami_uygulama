import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/kart_sekilleri.dart';
import '../services/bildirim_merkezi.dart';
import '../services/gercek_bildirimler.dart';
import '../services/renkler.dart';
import '../services/vakit_servisi.dart';
import '../screens/namaz_screen.dart';
import 'gunluk_gorev_page.dart';
import 'ramazan_modu_page.dart';
import 'ummet_bolumu_page.dart';
import 'kuran/sure_listesi_page.dart';
import 'kuran/hatim_takibi_page.dart';

class BildirimlerSayfasi extends StatefulWidget {
  const BildirimlerSayfasi({super.key});

  @override
  State<BildirimlerSayfasi> createState() => _BildirimlerSayfasiState();
}

class _BildirimlerSayfasiState extends State<BildirimlerSayfasi> {
  List<Bildirim> _liste = [];
  bool _sessiz = false;
  int _kaza = 0;
  Map<BildirimTipi, bool> _ayarlar = {};
  List<VakitBilgisi> _vakitler = VakitServisi.varsayilan;
  String? _sehir;
  Timer? _tazeleyici;

  @override
  void initState() {
    super.initState();
    _yukle();
    _tazeleyici = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _tazele(),
    );
  }

  @override
  void dispose() {
    _tazeleyici?.cancel();
    super.dispose();
  }

  /// Bugün listesini ve sıradaki vakit vurgusunu canlı tutar.
  Future<void> _tazele() async {
    await BildirimMerkezi.guncelle();
    final liste = await BildirimMerkezi.listeyiOku();
    if (!mounted) return;
    setState(() => _liste = liste);
  }

  Future<void> _yukle() async {
    await BildirimMerkezi.guncelle();
    final liste = await BildirimMerkezi.listeyiOku();
    final sessiz = await BildirimMerkezi.sessizDurumu();
    final kaza = await BildirimMerkezi.kazaOku();
    final ayarlar = <BildirimTipi, bool>{};
    for (final t in BildirimTipi.values) {
      ayarlar[t] = await BildirimMerkezi.ayarOku(t);
    }
    final vakitler = await VakitServisi.gunlukVakitler();
    final sehir = await VakitServisi.sehirOku();
    if (mounted) {
      setState(() {
        _liste = liste;
        _sessiz = sessiz;
        _kaza = kaza;
        _ayarlar = ayarlar;
        _vakitler = vakitler;
        _sehir = sehir;
      });
    }
  }

  Future<void> _hepsiniOkundu() async {
    await BildirimMerkezi.hepsiniOkunduYap();
    final guncelListe = await BildirimMerkezi.listeyiOku();
    if (mounted) {
      setState(() {
        _liste = guncelListe;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tüm bildirimler okundu olarak işaretlendi.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _sessizDegistir([bool? hedefDeger]) async {
    if (hedefDeger != null && hedefDeger == _sessiz) return;

    final yeni = await BildirimMerkezi.sessizDegistir();
    await GercekBildirimler.planla();
    await BildirimMerkezi.guncelle();
    final guncelListe = await BildirimMerkezi.listeyiOku();

    if (mounted) {
      setState(() {
        _sessiz = yeni;
        _liste = guncelListe;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _sessiz ? 'Sessiz mod aktif edildi.' : 'Sessiz mod kapatıldı.',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _ayarDegistir(BildirimTipi tip, bool deger) async {
    await BildirimMerkezi.ayarYaz(tip, deger);
    await BildirimMerkezi.guncelle();
    await GercekBildirimler.planla();
    final guncelListe = await BildirimMerkezi.listeyiOku();
    if (mounted) {
      setState(() {
        _ayarlar[tip] = deger;
        _liste = guncelListe;
      });
    }
  }

  Future<void> _kazaDegistir(int delta) async {
    final yeniKaza = _kaza + delta;
    if (yeniKaza < 0) return;

    await BildirimMerkezi.kazaYaz(yeniKaza);
    await BildirimMerkezi.guncelle(); // Listeyi yeni kaza sayısıyla güncelle
    final guncelListe = await BildirimMerkezi.listeyiOku();

    if (mounted) {
      setState(() {
        _kaza = yeniKaza;
        _liste = guncelListe;
      });
    }
  }

  Widget? _hedefSayfa(String hedef) {
    switch (hedef) {
      case 'namaz':
        return const NamazScreen();
      case 'gorevler':
        return const GunlukGorevPage();
      case 'ramazan':
        return const RamazanModuPage();
      case 'kuran':
        return const SureListesiPage();
      case 'hatim':
        return const HatimTakibiPage();
      case 'ummet':
        return const UmmetBolumuPage();
      default:
        return null;
    }
  }

  Future<void> _tikla(Bildirim b) async {
    await BildirimMerkezi.biriniOkunduYap(b.id);
    final guncelListe = await BildirimMerkezi.listeyiOku();
    if (mounted) {
      setState(() {
        _liste = guncelListe;
      });
    }
    if (!mounted) return;
    final sayfa = _hedefSayfa(b.hedef);
    if (sayfa != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => sayfa));
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
                    _sessizKarti(),
                    const SizedBox(height: 16),
                    _ayarlarKarti(),
                    const SizedBox(height: 16),
                    _vakitleriKarti(),
                    const SizedBox(height: 16),
                    _listeKarti(),
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
            icon: const UcdIkon(ikon: Icons.arrow_back_ios_new, renk: Colors.white),
            tooltip: 'Geri',
          ),
          const SizedBox(width: 8),
          const Text(
            'Bildirimler',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: _hepsiniOkundu,
            tooltip: 'Tümünü okundu yap',
            icon: const UcdIkon(ikon: Icons.done_all_rounded, renk: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _sessizKarti() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _sessiz
              ? [Colors.blueGrey.shade700, Colors.blueGrey.shade900]
              : [Renkler.vurgu, Renkler.vurgu.withValues(alpha: 0.55)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => _sessizDegistir(),
            borderRadius: BorderRadius.circular(20),
            child: UcdIkon(
              ikon: _sessiz ? Icons.notifications_off_rounded : Icons.nights_stay_rounded,
              renk: Colors.white,
              boyut: 26,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => _sessizDegistir(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _sessiz ? 'Sessiz mod AÇIK' : 'Sessiz vakit',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _sessiz
                        ? 'Düğün, toplantı, yolculuk… bildirimler bekletiliyor.'
                        : 'Gece 21:00 - 06:00 arası otomatik sessizdir. Tek dokunuşla sessize al.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Switch(
            value: _sessiz,
            onChanged: (val) => _sessizDegistir(val),
            activeThumbColor: Colors.white,
            activeTrackColor: Colors.black26,
          ),
        ],
      ),
    );
  }

  Widget _ayarlarKarti() {
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
              UcdIkon(ikon: Icons.tune_rounded, renk: Renkler.vurgu, boyut: 20),
              const SizedBox(width: 8),
              const Text(
                'Bildirim Türleri',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _ayarSatiri(
            ikon: '🕌',
            baslik: 'Namaz Bildirimleri',
            aciklama: 'Vakit, kamet, kaza hatırlatmaları',
            deger: _ayarlar[BildirimTipi.namaz] ?? true,
            onChanged: (v) => _ayarDegistir(BildirimTipi.namaz, v),
          ),
          _ayarSatiri(
            ikon: '🌅',
            baslik: 'Günlük Maneviyat',
            aciklama: 'Günün ayeti, iyilik görevi, hatim hedefi',
            deger: _ayarlar[BildirimTipi.gunluk] ?? true,
            onChanged: (v) => _ayarDegistir(BildirimTipi.gunluk, v),
          ),
          _ayarSatiri(
            ikon: '🌙',
            baslik: 'Özel Günler',
            aciklama: 'Cuma, kandil, iftar, Kadir Gecesi',
            deger: _ayarlar[BildirimTipi.ozelGun] ?? true,
            onChanged: (v) => _ayarDegistir(BildirimTipi.ozelGun, v),
          ),
          _ayarSatiri(
            ikon: '🌍',
            baslik: 'Ümmet Bağlantıları',
            aciklama: 'Dua zinciri, kardeşlik mesajları',
            deger: _ayarlar[BildirimTipi.ummet] ?? true,
            onChanged: (v) => _ayarDegistir(BildirimTipi.ummet, v),
          ),
          const Divider(color: Colors.white12, height: 20),
          Row(
            children: [
              UcdIkon(
                ikon: Icons.exposure_plus_1_rounded,
                renk: Renkler.vurgu,
                boyut: 20,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Kaza namaz sayım',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              IconButton(
                onPressed: _kaza > 0 ? () => _kazaDegistir(-1) : null,
                icon: const UcdIkon(ikon: Icons.remove_circle_outline_rounded, renk: Colors.white70, boyut: 22),
                color: Renkler.vurgu,
                tooltip: 'Eksilt',
              ),
              Text(
                '$_kaza',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => _kazaDegistir(1),
                icon: const UcdIkon(ikon: Icons.add_circle_outline_rounded, renk: Colors.white70, boyut: 22),
                color: Renkler.vurgu,
                tooltip: 'Artır',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ayarSatiri({
    required String ikon,
    required String baslik,
    required String aciklama,
    required bool deger,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: InkWell(
        onTap: () => onChanged(!deger),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
          child: Row(
            children: [
              Text(ikon, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      baslik,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      aciklama,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: deger,
                onChanged: onChanged,
                activeThumbColor: Renkler.vurgu,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Bugünün gerçek namaz vakitlerini, sıradaki vakit vurgusuyla gösterir.
  Widget _vakitleriKarti() {
    final now = DateTime.now();
    final simdiDk = now.hour * 60 + now.minute;
    VakitBilgisi? siradaki;
    for (final v in _vakitler) {
      if (v.dakikaToplam > simdiDk) {
        siradaki = v;
        break;
      }
    }
    final konum = _sehir ?? 'Konumuna göre';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: Icons.schedule_rounded, renk: Renkler.vurgu, boyut: 20),
              const SizedBox(width: 8),
              const Text(
                'Bugünün Namaz Vakitleri',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  konum,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._vakitler.map(
            (v) {
              final aktif = v == siradaki;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: aktif ? Renkler.vurgu : Colors.white24,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      v.ad,
                      style: TextStyle(
                        color: aktif ? Colors.white : Colors.white70,
                        fontSize: 14,
                        fontWeight: aktif ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      v.saatYaz,
                      style: TextStyle(
                        color: aktif ? Renkler.vurgu : Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    if (aktif) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Renkler.vurgu.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Sıradaki',
                          style: TextStyle(
                            color: Renkler.vurgu,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _listeKarti() {
    if (_liste.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Renkler.kart.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Column(
          children: [
            UcdIkon(ikon: Icons.notifications_outlined, renk: Colors.white38, boyut: 40),
            SizedBox(height: 10),
            Text(
              'Henüz bildirim yok',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              'Sessiz yardımcı seni yalnız bırakmaz.',
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ],
        ),
      );
    }

    final bugun = DateTime.now();
    final dun = bugun.subtract(const Duration(days: 1));
    String gunKey(DateTime d) =>
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

    final gruplar = <String, List<Bildirim>>{
      'Bugün': [],
      'Dün': [],
      'Önceki': [],
    };

    for (final b in _liste) {
      final key = gunKey(b.zaman);
      if (key == gunKey(bugun)) {
        gruplar['Bugün']!.add(b);
      } else if (key == gunKey(dun)) {
        gruplar['Dün']!.add(b);
      } else {
        gruplar['Önceki']!.add(b);
      }
    }

    int sirala(Bildirim a, Bildirim b) {
      final pa = _oncelik(a.tip);
      final pb = _oncelik(b.tip);
      if (pa != pb) return pa.compareTo(pb);
      return b.zaman.compareTo(a.zaman);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sessiz Yardımcı',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Günde en fazla 5 bildirim — önce namaz, sonra günün geri kalanı.',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        const SizedBox(height: 12),
        for (final grup in ['Bugün', 'Dün', 'Önceki'])
          if (gruplar[grup]!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                grup,
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...(gruplar[grup]!..sort(sirala)).map(_bildirimKarti),
          ],
      ],
    );
  }

  int _oncelik(BildirimTipi tip) {
    switch (tip) {
      case BildirimTipi.namaz:
        return 0;
      case BildirimTipi.ozelGun:
        return 1;
      case BildirimTipi.gunluk:
        return 2;
      case BildirimTipi.ummet:
      case BildirimTipi.diger:
        return 3;
    }
  }

  Widget _bildirimKarti(Bildirim b) {
    final (renk, ikon) = _tipGorsel(b.tip);
    return GestureDetector(
      onTap: () => _tikla(b),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: b.okundu
              ? Renkler.kart.withValues(alpha: 0.7)
              : Renkler.seciliYuzey,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: b.okundu
                ? Colors.transparent
                : Renkler.vurgu.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: renk.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: UcdIkon(ikon: ikon, renk: renk, boyut: 20),
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
                          b.baslik,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: b.okundu
                                ? FontWeight.w500
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!b.okundu)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    b.mesaj,
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${b.zaman.hour.toString().padLeft(2, '0')}:${b.zaman.minute.toString().padLeft(2, '0')}',
              style: const TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  (Color, IconData) _tipGorsel(BildirimTipi tip) {
    switch (tip) {
      case BildirimTipi.namaz:
        return (Renkler.vurgu, Icons.mosque_rounded);
      case BildirimTipi.gunluk:
        return (Colors.amberAccent, Icons.wb_sunny_rounded);
      case BildirimTipi.ozelGun:
        return (Colors.purpleAccent, Icons.nights_stay_rounded);
      case BildirimTipi.ummet:
      case BildirimTipi.diger:
        return (Colors.cyanAccent, Icons.public_rounded);
    }
  }
}
