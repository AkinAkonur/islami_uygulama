import 'package:flutter/material.dart';
import '../services/location_and_mosque_service.dart';
import '../services/renkler.dart';

/// GPS konumuna göre en yakın camileri Overpass API'den çekip listeler.
class YakindakiCamilerPage extends StatefulWidget {
  const YakindakiCamilerPage({super.key});

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
    final camiler = await LocationAndMosqueService.getKonumVeCamiler(context);
    if (!mounted) return;
    setState(() => _camiler = camiler);
  }

  String _mesafeYaz(double metre) {
    if (metre < 1000) return '${metre.round()} m';
    return '${(metre / 1000).toStringAsFixed(1)} km';
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
            icon: const Icon(Icons.refresh),
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
                        Icon(
                          Icons.mosque_outlined,
                          color: Colors.white38,
                          size: 56,
                        ),
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
                          icon: const Icon(Icons.refresh, size: 18),
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
                        leading: CircleAvatar(
                          backgroundColor: Renkler.seciliYuzey,
                          child: Icon(
                            Icons.mosque_outlined,
                            color: Renkler.vurgu,
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
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.white38,
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}