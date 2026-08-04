import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class GunlukIyilikGorevleriPage extends StatefulWidget {
  const GunlukIyilikGorevleriPage({super.key});

  @override
  State<GunlukIyilikGorevleriPage> createState() =>
      _GunlukIyilikGorevleriPageState();
}

class _GunlukIyilikGorevleriPageState extends State<GunlukIyilikGorevleriPage> {
  Set<String> _tamamlananlar = {};
  int _toplam = 0;
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final tamamlananlar = await UmmetStore.gorevlerBugun();
    final toplam = await UmmetStore.gorevToplamTamamlanan();
    if (!mounted) return;
    setState(() {
      _tamamlananlar = tamamlananlar;
      _toplam = toplam;
      _yukleniyor = false;
    });
  }

  double get _ummetOrani {
    final ek = (_toplam * 0.08).clamp(0.0, 9.9);
    return (63.8 + ek).clamp(63.8, 99.9);
  }

  Future<void> _tamamla(Map<String, String> gorev, bool tamam) async {
    await UmmetStore.gorevTikla(gorev['id']!, tamam);
    if (!mounted) return;
    setState(() {
      if (tamam) {
        _tamamlananlar.add(gorev['id']!);
        _toplam += 1;
      } else {
        _tamamlananlar.remove(gorev['id']!);
      }
    });
    if (tamam) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Tamamladın: ${gorev['ad']} ✨ Sevap hanene yazıldı.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Renkler.bannerUst,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bugun = DateTime.now();
    final ayAdi = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
    ][bugun.month - 1];
    final tarih = '$ayAdi ${bugun.day}, ${bugun.year}';

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Günlük İyilik Görevleri',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: _yukleniyor
          ? Center(
              child: CircularProgressIndicator(color: Renkler.vurgu),
            )
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                Container(
                  padding: EdgeInsets.all(16),
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
                          Icon(Icons.today_outlined,
                              color: Renkler.vurgu, size: 20),
                          SizedBox(width: 8),
                          Text(
                            tarih,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Ümmet genelinde bugün tamamlanma: %${_ummetOrani.toStringAsFixed(1)}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '${_tamamlananlar.length}/${gunlukGorevler.length}',
                            style: TextStyle(
                              color: Renkler.vurgu,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _ummetOrani / 100,
                          minHeight: 8,
                          backgroundColor: Colors.black.withValues(alpha: 0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Renkler.vurgu),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Mikro sorumluluklar, büyük ümmet tabloları oluşturur. Bugün birini sevindir; yarın binler sevinsin.',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                for (final gorev in gunlukGorevler) ...[
                  _gorevKarti(gorev),
                  SizedBox(height: 12),
                ],
                SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _gorevKarti(Map<String, String> gorev) {
    final tamam = _tamamlananlar.contains(gorev['id']);
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: tamam
              ? Renkler.vurgu.withValues(alpha: 0.5)
              : Renkler.cerceve,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _tamamla(gorev, !tamam),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: tamam
                      ? Renkler.bannerUst
                      : Renkler.yuzey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(gorev['ikon']!,
                    style: TextStyle(fontSize: 22)),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gorev['ad']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration:
                            tamam ? TextDecoration.lineThrough : null,
                        decorationColor: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      gorev['detay']!,
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      gorev['delil']!,
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: tamam
                      ? Renkler.vurgu
                      : Colors.transparent,
                  border: Border.all(
                    color: tamam
                        ? Renkler.vurgu
                        : Colors.white38,
                    width: 2,
                  ),
                ),
                child: tamam
                    ? Icon(Icons.check,
                        color: Renkler.zemin, size: 16)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
