import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class ManeviHalkalarPage extends StatefulWidget {
  const ManeviHalkalarPage({super.key});

  @override
  State<ManeviHalkalarPage> createState() => _ManeviHalkalarPageState();
}

class _ManeviHalkalarPageState extends State<ManeviHalkalarPage> {
  final Map<String, bool> _katilimlar = {};
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final katilimlar = <String, bool>{};
    for (final h in maneviHalkalar) {
      katilimlar[h.id] = await UmmetStore.halkadaMis(h.id);
    }
    if (!mounted) return;
    setState(() {
      _katilimlar.addAll(katilimlar);
      _yukleniyor = false;
    });
  }

  Future<void> _katil(ManeviHalka halka) async {
    final simdi = !(_katilimlar[halka.id] ?? false);
    if (simdi) {
      await UmmetStore.halkayaKatil(halka.id);
    } else {
      await UmmetStore.halkadanAyril(halka.id);
    }
    if (!mounted) return;
    setState(() => _katilimlar[halka.id] = simdi);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          simdi
              ? 'Halkaya katıldın: ${halka.ad} 🤲'
              : 'Halkadan ayrıldın: ${halka.ad}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final katildiklarim = _katilimlar.values.where((b) => b).length;
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Manevi Gelişim Halkaları',
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
                Container(
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
                          Icon(Icons.groups_2_outlined,
                              color: Renkler.vurgu, size: 22),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '$katildiklarim halkaya katıldın',
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
                        'Küçük ama düzenli ibadet alışkanlıkları, büyük manevi ilerlemelere dönüşür. Bir halkaya katıl, ümmetle birlikte geliş.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                for (final h in maneviHalkalar) ...[
                  _halkaKarti(h),
                  SizedBox(height: 10),
                ],
                SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _halkaKarti(ManeviHalka h) {
    final katildi = _katilimlar[h.id] ?? false;

    return Card(
      color: katildi ? Renkler.seciliYuzey : Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: katildi ? Renkler.vurgu : Renkler.cerceve,
          width: katildi ? 1.5 : 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(h.ikon, style: TextStyle(fontSize: 26)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    h.ad,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    h.aciklama,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '${binlikSayi(h.uyeTabani)} kardeş birlikte',
                    style: TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Switch(
              value: katildi,
              activeThumbColor: Renkler.vurgu,
              inactiveThumbColor: Colors.white54,
              activeTrackColor: Renkler.vurgu.withValues(alpha: 0.3),
              onChanged: (_) => _katil(h),
            ),
          ],
        ),
      ),
    );
  }
}