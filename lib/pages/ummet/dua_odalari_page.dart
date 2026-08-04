import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class DuaOdalariPage extends StatefulWidget {
  const DuaOdalariPage({super.key});

  @override
  State<DuaOdalariPage> createState() => _DuaOdalariPageState();
}

class _DuaOdalariPageState extends State<DuaOdalariPage> {
  final Map<String, int> _katilimlar = {};
  bool _yukleniyor = true;

  static const _tabanKatilim = {
    'sifa': 12480,
    'borc': 9320,
    'sinav': 15740,
    'aile': 11060,
    'hidayet': 8750,
  };

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final katilimlar = <String, int>{};
    for (final k in duaKategorileri) {
      katilimlar[k['id']!] =
          _tabanKatilim[k['id']]! + await UmmetStore.odaKatilim(k['id']!);
    }
    if (!mounted) return;
    setState(() {
      _katilimlar.addAll(katilimlar);
      _yukleniyor = false;
    });
  }

  Future<void> _odayaKatil(String id) async {
    await UmmetStore.odaKatil(id);
    setState(() {
      _katilimlar[id] = (_katilimlar[id] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Dua Odaları',
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
                      Text(
                        'Kategorize Dua Odaları',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Bir odaya gir, o konudaki duaları oku ve ümmetle birlikte niyet et. Her oda, binlerce kardeşin ortak duasıyla canlıdır.',
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
                for (final k in duaKategorileri) ...[
                  _odaKarti(context, k),
                  SizedBox(height: 12),
                ],
                SizedBox(height: 20),
              ],
            ),
    );
  }

  Widget _odaKarti(BuildContext context, Map<String, String> kategori) {
    final id = kategori['id']!;
    final katilim = _katilimlar[id] ?? 0;
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(kategori['ikon']!, style: TextStyle(fontSize: 28)),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        kategori['ad']!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        kategori['aciklama']!,
                        style: TextStyle(
                            color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.groups, color: Renkler.vurgu, size: 16),
                SizedBox(width: 6),
                Text(
                  '${binlikSayi(katilim)} kardeş odada',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                Spacer(),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Renkler.vurgu,
                    side: BorderSide(color: Renkler.cerceve2),
                  ),
                  onPressed: () async {
                    await _odayaKatil(id);
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => _OdaDetayPage(kategori: kategori),
                      ),
                    );
                  },
                  child: Text('Odaya Katıl'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OdaDetayPage extends StatefulWidget {
  const _OdaDetayPage({required this.kategori});

  final Map<String, String> kategori;

  @override
  State<_OdaDetayPage> createState() => _OdaDetayPageState();
}

class _OdaDetayPageState extends State<_OdaDetayPage> {
  int _okunma = 0;

  Future<void> _duaOku() async {
    setState(() => _okunma++);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Bu odada dua ettin: ${widget.kategori['ad']} 🤲',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final id = widget.kategori['id']!;
    final dualar = kategoriDualari[id] ?? [];
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          '${widget.kategori['ikon']} ${widget.kategori['ad']} Odası',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
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
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '"${widget.kategori['aciklama']}"',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.self_improvement,
                    color: Renkler.vurgu, size: 26),
              ],
            ),
          ),
          SizedBox(height: 16),
          for (final dua in dualar) ...[
            _duaKarti(dua),
            SizedBox(height: 12),
          ],
          SizedBox(height: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: Renkler.vurgu,
              foregroundColor: Renkler.zemin,
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _duaOku,
            icon: Icon(Icons.favorite_outline),
            label: Text(
              _okunma == 0
                  ? 'Bu Odada Dua Ettim'
                  : 'Tekrar Dua Ettim ($_okunma)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _duaKarti(Map<String, String> dua) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dua['baslik']!,
              style: TextStyle(
                color: Renkler.vurgu,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 12),
            Text(
              dua['arapca']!,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.8,
              ),
            ),
            SizedBox(height: 12),
            Text(
              dua['turkce']!,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            SizedBox(height: 10),
            Text(
              dua['kaynak']!,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.white38,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
