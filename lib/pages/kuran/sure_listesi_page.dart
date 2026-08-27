import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/kuran_api.dart';
import 'sure_detay_page.dart';

class SureListesiPage extends StatefulWidget {
  const SureListesiPage({super.key});

  @override
  State<SureListesiPage> createState() => _SureListesiPageState();
}

class _SureListesiPageState extends State<SureListesiPage> {
  List<SureBilgisi>? _sureler;
  String? _hata;
  bool _yukleniyor = true;
  String _arama = '';

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    setState(() {
      _yukleniyor = true;
      _hata = null;
    });
    try {
      final sureler = await KuranApi.instance.sureleriGetir();
      if (mounted) {
        setState(() {
          _sureler = sureler;
          _yukleniyor = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hata = e.toString();
          _yukleniyor = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('sl.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: (v) => setState(() => _arama = v),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: l.t('sl.searchHint'),
                hintStyle: TextStyle(color: Colors.white38),
                prefixIcon: Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Renkler.kart,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(child: _icerik(l)),
        ],
      ),
    );
  }

  Widget _icerik(AppLocalizations l) {
    if (_yukleniyor) {
      return Center(
        child: CircularProgressIndicator(color: Renkler.vurgu),
      );
    }
    if (_hata != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, color: Colors.white38, size: 48),
            SizedBox(height: 12),
            Text(
              l.t('sl.loadError'),
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Renkler.vurgu),
              onPressed: _yukle,
              child: Text(l.t('sl.retry')),
            ),
          ],
        ),
      );
    }

    final filtreli = _sureler!.where((s) {
      final q = _arama.trim().toLowerCase();
      if (q.isEmpty) return true;
      return s.turkceAdi.toLowerCase().contains(q) ||
          s.arapcaAdi.contains(_arama.trim()) ||
          s.numara.toString() == q ||
          s.anlami.toLowerCase().contains(q);
    }).toList();

    if (filtreli.isEmpty) {
      return Center(
        child: Text(
          l.t('sl.noResult'),
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 20),
      itemCount: filtreli.length,
      itemBuilder: (context, index) {
        final s = filtreli[index];
        final mekkiMi = s.inisYeri == 'Mekkî';
        return Card(
          color: Renkler.kart,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Renkler.cerceve),
          ),
          child: ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SureDetayPage(sureNo: s.numara),
              ),
            ),
            leading: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Renkler.seciliYuzey,
                shape: BoxShape.circle,
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
              ),
              alignment: Alignment.center,
              child: Text(
                '${s.numara}',
                style: TextStyle(color: Renkler.vurgu, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    '${s.numara}. ${s.turkceAdi}',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Text(
                  s.arapcaAdi,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Text(
                '${s.anlami} • ${l.t('sl.verseCount').replaceFirst('{count}', '${s.ayetSayisi}')} • ${s.inisYeri}',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ),
            trailing: mekkiMi
                ? Icon(Icons.wb_sunny_outlined, color: Colors.orangeAccent, size: 16)
                : Icon(Icons.home_outlined, color: Colors.blueAccent, size: 16),
          ),
        );
      },
    );
  }
}
