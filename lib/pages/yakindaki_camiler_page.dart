import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_and_mosque_service.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

/// GPS konumuna göre en yakın camileri Overpass API'den çekip listeler.
/// `lat`/`lng` verilirse GPS almadan o koordinata göre camileri çeker.
class YakindakiCamilerPage extends StatefulWidget {
  const YakindakiCamilerPage({super.key, this.lat, this.lng});

  final double? lat;
  final double? lng;

  @override
  State<YakindakiCamilerPage> createState() => _YakindakiCamilerPageState();
}

class _YakindakiCamilerPageState extends State<YakindakiCamilerPage> {
  List<Mosque>? _camiler;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    setState(() => _camiler = null);
    final lat = widget.lat;
    final lng = widget.lng;
    final camiler = lat != null && lng != null
        ? await LocationAndMosqueService.fetchNearbyMosques(lat, lng)
        : await LocationAndMosqueService.getKonumVeCamiler(context);
    if (!mounted) return;
    setState(() => _camiler = camiler);
  }

  String _mesafeYaz(double metre) {
    if (metre < 1000) return '${metre.round()} m';
    return '${(metre / 1000).toStringAsFixed(1)} km';
  }

  Future<void> _camiSec(Mosque cami) async {
    final secim = await showModalBottomSheet<String>(context: context,
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
                   UcdIkon(ikon: Icons.mosque_rounded, renk: Colors.white70, boyut: 24),
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
              if (cami.distanceInMeters != null) ...[
                const SizedBox(height: 4),
                Text(
                  '${_mesafeYaz(cami.distanceInMeters!)} uzaklıkta',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
              const SizedBox(height: 16),
              _secimButonu(
                Icons.directions_walk,
                'Yürüyerek Yol Tarifi',
                'Google Maps / Apple Maps ile adım adım',
                () => Navigator.pop(ctx, 'walking'),
              ),
              const SizedBox(height: 10),
              _secimButonu(
                Icons.directions_car,
                'Arabayla Yol Tarifi',
                'Sürüş navigasyonu başlat',
                () => Navigator.pop(ctx, 'driving'),
              ),
              const SizedBox(height: 10),
              _secimButonu(
                Icons.map_outlined,
                'Haritada Gör',
                'Camiyi haritada konumlandır',
                () async {
                  Navigator.pop(ctx);
                  final acildi = await LocationAndMosqueService.haritadaGoster(
                    cami,
                  );
                  if (!acildi && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Harita uygulaması açılamadı.'),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
    if (secim != null && (secim == 'walking' || secim == 'driving')) {
      await _yolTarifi(cami, secim);
    }
  }
  Future<void> _yolTarifi(Mosque cami, String mod) async {
    Position? konum;
    try {
      konum = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 12),
        ),
      );
    } catch (_) {
      konum = null;
    }
    final acildi = await LocationAndMosqueService.yolTarifiAc(
      cami,
      baslangicLat: konum?.latitude.toString(),
      baslangicLng: konum?.longitude.toString(),
      mod: mod,
    );
    if (!acildi && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Yol tarifi açılamadı.')),
      );
    }
  }

  Widget _secimButonu(
    IconData ikon,
    String baslik,
    String alt,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  alt,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          const UcdIkon(ikon: Icons.chevron_right_rounded, renk: Colors.white38),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Yakındaki Camiler'),
        backgroundColor: Renkler.seciliYuzey,
        actions: [
          IconButton(
            icon: const UcdIkon(ikon: Icons.refresh_rounded, renk: Colors.white, boyut: 24),
            onPressed: _camiler == null ? null : _yukle,
          ),
        ],
      ),
      body: _camiler == null
          ? const Center(child: CircularProgressIndicator())
          : _camiler!.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          UcdIkon(ikon: Icons.mosque_rounded, renk: Colors.white38, boyut: 56),
                        const SizedBox(height: 12),
                        const Text(
                          'Cami bulunamadı.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Konum izni verdiğinden ve internet bağlantının açık '
                          'olduğundan emin ol; sonra yenile.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: _yukle,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Renkler.vurgu,
                            side: BorderSide(color: Renkler.vurgu),
                          ),
                          icon: UcdIkon(ikon: Icons.refresh_rounded, renk: Renkler.vurgu, boyut: 18),
                          label: const Text('Tekrar Dene'),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _camiler!.length,
                  itemBuilder: (context, index) {
                    final cami = _camiler![index];
                    return Card(
                      color: Renkler.kart,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _camiSec(cami),
                        leading: CircleAvatar(
                          backgroundColor: Renkler.seciliYuzey,
                          child: UcdIkon(
                            ikon: Icons.mosque_rounded,
                            renk: Renkler.vurgu,
                          ),
                        ),
                        title: Text(
                          cami.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          cami.distanceInMeters != null
                              ? '${_mesafeYaz(cami.distanceInMeters!)} uzaklıkta'
                              : 'Uzaklık bilinmiyor',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        trailing: const UcdIkon(ikon: Icons.chevron_right_rounded, renk: Colors.white38),
                      ),
                    );
                  },
                ),
    );
  }
}