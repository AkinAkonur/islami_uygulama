import 'package:flutter/material.dart';
import '../services/location_and_mosque_service.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';
import '../services/turkiye_illeri.dart';
import '../services/vakit_servisi.dart';
import 'kible_pusula_page.dart';
import 'yakindaki_camiler_page.dart';

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
  List<Mosque>? _camiler;
  bool _camiYukleniyor = false;

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
    await _camiYukle();
  }

  Future<void> _camiYukle() async {
    final koordinat = _koordinat;
    if (koordinat == null) {
      if (mounted) setState(() => _camiler = null);
      return;
    }
    if (mounted) setState(() => _camiYukleniyor = true);
    final camiler = await LocationAndMosqueService.fetchNearbyMosques(
      koordinat.$1,
      koordinat.$2,
    );
    if (!mounted) return;
    setState(() {
      _camiler = camiler;
      _camiYukleniyor = false;
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
    final sonuc = await VakitServisi.konumuOtomatikAl();
    if (!mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    if (sonuc == KonumSonuc.basarili) {
      await _yukle();
      return;
    }
    if (sonuc == KonumSonuc.yaklasikBasarili) {
      await _yukle();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'GPS sinyali alınamadı; internete göre yaklaşık konum kullanıldı.',
          ),
          duration: Duration(seconds: 4),
        ),
      );
      return;
    }
    final mesaj = switch (sonuc) {
      KonumSonuc.servisKapali =>
        'Cihazın konum servisi kapalı. Açtıktan sonra tekrar dene.',
      KonumSonuc.izinReddedildi =>
        'Konum izni verilmedi. Tekrar denerken izin penceresini onayla ya da Şehir Seç ile devam et.',
      KonumSonuc.izinKaliciRed =>
        'Konum izni kalıcı reddedilmiş. Ayarlardan uygulamaya konum izni ver, sonra tekrar dene.',
      _ => 'Konum alınamadı. GPS sinyali zayıf olabilir; pencere yakınında veya dışarıda tekrar dene.',
    };
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mesaj), duration: const Duration(seconds: 4)),
    );
  }

  Future<void> _konumSec() async {
    final secilenIl = await showDialog<Il>(
      context: context,
      builder: (ctx) => const _IlSecimDialogu(),
    );
    if (secilenIl == null || !mounted) return;

    // İl seçildi: koordinatıyla birlikte kaydet; vakitler aşağıda hemen
    // güncellenir.
    await VakitServisi.konumKaydet(
      sehir: secilenIl.ad,
      ulke: 'Türkiye',
      lat: secilenIl.enlem,
      lng: secilenIl.boylam,
    );
    await _yukle();
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
                    _camiKarti(),
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
            icon: const UcdIkon(ikon: Icons.arrow_back_ios_new, renk: Colors.white),
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
          const UcdIkon(ikon: Icons.location_on_outlined, renk: Colors.white54),
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
                  icon: const UcdIkon(ikon: Icons.my_location, renk: Colors.white, boyut: 18),
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
                  icon: const UcdIkon(ikon: Icons.edit_location_alt_outlined, renk: Colors.white, boyut: 18),
                  label: const Text('Şehir Seç'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _camiKarti() {
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
              UcdIkon(ikon: Icons.mosque_rounded, renk: Renkler.vurgu, boyut: 20),
              const SizedBox(width: 8),
              const Text(
                'Yakındaki Camiler',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const UcdIkon(ikon: Icons.refresh, renk: Colors.white54, boyut: 20),
                onPressed: _camiYukleniyor ? null : _camiYukle,
                tooltip: 'Yenile',
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (_camiYukleniyor)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_camiler == null)
            _camiBosSatir(
              Icons.location_off_outlined,
              'Konumunu belirle; yakınındaki camiler burada listelenecek.',
            )
          else if (_camiler!.isEmpty)
            _camiBosSatir(
              Icons.mosque_rounded,
              'Yakınlarda cami bulunamadı. Konum iznini ve internet bağlantını kontrol et, sonra yenile.',
            )
          else
            Column(
              children: [
                for (final cami in _camiler!.take(5)) _camiSatiri(cami),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      final koordinat = _koordinat;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => YakindakiCamilerPage(
                            lat: koordinat?.$1,
                            lng: koordinat?.$2,
                          ),
                        ),
                      );
                    },
                    icon: const UcdIkon(ikon: Icons.chevron_right, renk: Colors.white, boyut: 18),
                    label: const Text('Tümünü Gör'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _camiBosSatir(IconData ikon, String metin) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          UcdIkon(ikon: ikon, renk: Colors.white38, boyut: 40),
          const SizedBox(height: 10),
          Text(
            metin,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _camiSatiri(Mosque cami) {
    return InkWell(
      onTap: () => _camiSec(cami),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            UcdIkon(ikon: Icons.mosque_rounded, renk: Renkler.vurgu, boyut: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cami.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    cami.distanceInMeters != null
                        ? _mesafeYaz(cami.distanceInMeters!)
                        : 'Uzaklık bilinmiyor',
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const UcdIkon(ikon: Icons.chevron_right, renk: Colors.white24),
          ],
        ),
      ),
    );
  }

  String _mesafeYaz(double metre) {
    if (metre < 1000) return '${metre.round()} m';
    return '${(metre / 1000).toStringAsFixed(1)} km';
  }

  Future<void> _camiSec(Mosque cami) async {
    await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Renkler.kart,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const UcdIkon(ikon: Icons.mosque_rounded, renk: Colors.white70),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      cami.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _camiEylemButonu(
                Icons.directions_walk,
                'Yürüyerek Yol Tarifi',
                () => Navigator.pop(ctx, 'walking'),
              ),
              const SizedBox(height: 10),
              _camiEylemButonu(
                Icons.directions_car,
                'Arabayla Yol Tarifi',
                () => Navigator.pop(ctx, 'driving'),
              ),
              const SizedBox(height: 10),
              _camiEylemButonu(
                Icons.map_outlined,
                'Haritada Gör',
                () => Navigator.pop(ctx, 'harita'),
              ),
            ],
          ),
        ),
      ),
    ).then((secim) async {
      if (secim == null || !mounted) return;
      if (secim == 'harita') {
        final acildi = await LocationAndMosqueService.haritadaGoster(cami);
        if (!acildi && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Harita uygulaması açılamadı.')),
          );
        }
        return;
      }
      final koordinat = _koordinat;
      final acildi = await LocationAndMosqueService.yolTarifiAc(
        cami,
        baslangicLat: koordinat?.$1.toString(),
        baslangicLng: koordinat?.$2.toString(),
        mod: secim,
      );
      if (!acildi && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Yol tarifi açılamadı.')),
        );
      }
    });
  }

  Widget _camiEylemButonu(
    IconData ikon,
    String baslik,
    VoidCallback onPressed,
  ) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        children: [
          UcdIkon(ikon: ikon, renk: Renkler.vurgu, boyut: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              baslik,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const UcdIkon(ikon: Icons.chevron_right, renk: Colors.white38),
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
            UcdIkon(ikon: Icons.explore_rounded, renk: Renkler.vurgu, boyut: 34),
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
            const UcdIkon(ikon: Icons.chevron_right, renk: Colors.white70),
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
              UcdIkon(ikon: Icons.schedule_outlined, renk: Renkler.vurgu, boyut: 20),
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
          UcdIkon(ikon: Icons.info_outline, renk: Renkler.vurgu, boyut: 18),
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

/// Türkiye'nin 81 ilini aramalı liste hâlinde gösteren seçim penceresi.
class _IlSecimDialogu extends StatefulWidget {
  const _IlSecimDialogu();

  @override
  State<_IlSecimDialogu> createState() => _IlSecimDialoguState();
}

class _IlSecimDialoguState extends State<_IlSecimDialogu> {
  String _arama = '';

  static String _norm(String metin) {
    const tr = 'çğıiöşü';
    const en = 'cgiosu';
    var sonuc = metin.toLowerCase();
    for (var i = 0; i < tr.length; i++) {
      sonuc = sonuc.replaceAll(tr[i], en[i]);
    }
    return sonuc;
  }

  List<Il> get _filtreliIller {
    final q = _norm(_arama.trim());
    if (q.isEmpty) return turkiyeIlleri;
    return turkiyeIlleri
        .where((il) => _norm(il.ad).contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtreli = _filtreliIller;
    return AlertDialog(
      backgroundColor: Renkler.kart,
      title: const Text(
        'Şehir Seç',
        style: TextStyle(color: Colors.white),
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: 420,
        child: Column(
          children: [
            TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              cursorColor: Renkler.vurgu,
              onChanged: (deger) => setState(() => _arama = deger),
              decoration: InputDecoration(
                hintText: 'İl ara… (örn. İstanbul)',
                hintStyle: const TextStyle(color: Colors.white38),
                prefixIcon: const UcdIkon(ikon: Icons.search, renk: Colors.white54),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Renkler.vurgu),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: filtreli.isEmpty
                  ? const Center(
                      child: Text(
                        'Eşleşen il bulunamadı',
                        style: TextStyle(color: Colors.white38),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filtreli.length,
                      itemBuilder: (ctx, i) {
                        final il = filtreli[i];
                        return ListTile(
                          leading: UcdIkon(
                            ikon: Icons.location_city,
                            renk: Renkler.vurgu,
                          ),
                          title: Text(
                            il.ad,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          trailing: const UcdIkon(
                            ikon: Icons.chevron_right,
                            renk: Colors.white24,
                          ),
                          onTap: () => Navigator.pop(ctx, il),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Vazgeç'),
        ),
      ],
    );
  }
}