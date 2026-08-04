import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/kuran_verileri.dart';
import 'sure_detay_page.dart';

class HatimTakibiPage extends StatefulWidget {
  const HatimTakibiPage({super.key});

  @override
  State<HatimTakibiPage> createState() => _HatimTakibiPageState();
}

class _HatimTakibiPageState extends State<HatimTakibiPage> {
  static const int _toplamSayfa = 604;

  int _sayfa = 1;
  int _hatimSayisi = 0;
  int _gunlukHedef = 4;
  int _bugunOkunan = 0;
  int _streak = 0;
  String _sonTarih = '';
  List<int> _ezberlenen = [];

  bool _yuklendi = false;

  String get _bugun {
    final t = DateTime.now();
    return '${t.year}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}';
  }

  String get _dugun {
    final t = DateTime.now().subtract(Duration(days: 1));
    return '${t.year}-${t.month.toString().padLeft(2, '0')}-${t.day.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final p = await SharedPreferences.getInstance();
    final bugun = _bugun;
    final sonTarih = p.getString('hatim_son_tarih') ?? '';
    var sayfa = p.getInt('hatim_sayfa') ?? 1;
    var hatim = p.getInt('hatim_sayisi') ?? 0;
    var bugunOkunan = p.getInt('hatim_bugun_okunan') ?? 0;
    var streak = p.getInt('hatim_streak') ?? 0;

    if (sonTarih != bugun && sonTarih != _dugun) {
      streak = 0;
      bugunOkunan = 0;
    } else if (sonTarih != bugun) {
      bugunOkunan = 0;
    }
    if (sayfa > _toplamSayfa) sayfa = _toplamSayfa;

    await p.setString('hatim_son_tarih', bugun);
    await p.setInt('hatim_streak', streak);

    if (mounted) {
      setState(() {
        _sayfa = sayfa;
        _hatimSayisi = hatim;
        _bugunOkunan = bugunOkunan;
        _streak = streak;
        _sonTarih = sonTarih;
        _ezberlenen = (p.getStringList('hatim_ezber') ?? []).map(int.parse).toList();
        _yuklendi = true;
      });
    }
  }

  Future<void> _kaydet() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('hatim_sayfa', _sayfa);
    await p.setInt('hatim_sayisi', _hatimSayisi);
    await p.setInt('hatim_bugun_okunan', _bugunOkunan);
    await p.setInt('hatim_streak', _streak);
    await p.setString('hatim_son_tarih', _bugun);
    await p.setStringList('hatim_ezber', _ezberlenen.map((e) => e.toString()).toList());
  }

  Future<void> _arttir(int adet) async {
    setState(() {
      _sayfa = (_sayfa + adet).clamp(1, _toplamSayfa);
      if (_sonTarih != _bugun) {
        _streak = _sonTarih == _dugun ? _streak + 1 : 1;
        _bugunOkunan = 0;
        _sonTarih = _bugun;
      }
      if (adet > 0) _bugunOkunan += adet;
    });
    await _kaydet();
    if (_sayfa >= _toplamSayfa) {
      _hatimTamamlandi();
    }
  }

  Future<void> _hatimTamamlandi() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: Renkler.seciliYuzey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          "🎉 Hatim Tamamlandı!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Text(
          "Rabbim kabul etsin. Mânevî yolculuğunuz devam etsin.",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Renkler.vurgu),
              onPressed: () {
                setState(() {
                  _hatimSayisi++;
                  _sayfa = 1;
                });
                Navigator.pop(ctx);
                _kaydet();
                Navigator.of(context).popUntil((r) => r.isFirst);
              },
              child: Text("Yeni Hatime Başla"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _ezberle(int sureNo) async {
    setState(() {
      if (_ezberlenen.contains(sureNo)) {
        _ezberlenen.remove(sureNo);
      } else {
        _ezberlenen.add(sureNo);
      }
    });
    await _kaydet();
  }

  @override
  Widget build(BuildContext context) {
    if (!_yuklendi) {
      return Scaffold(
        backgroundColor: Renkler.zemin,
        appBar: AppBar(
          title: Text("Hatim Takibi", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          backgroundColor: Renkler.yuzey,
          elevation: 0,
        ),
        body: Center(child: CircularProgressIndicator(color: Renkler.vurgu)),
      );
    }

    final ilerleme = _sayfa / _toplamSayfa;

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          "Hatim Takibi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // İlerleme kartı
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Renkler.bannerUst, Renkler.bannerAlt],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hatminiz",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$_hatimSayisi hatim tamamlandı',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  '$_sayfa / $_toplamSayfa sayfa',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 6),
                Text(
                  '%${(ilerleme * 100).toStringAsFixed(1)} ilerleme',
                  style: TextStyle(color: Renkler.acikVurgu, fontSize: 13),
                ),
                SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: ilerleme,
                    backgroundColor: Colors.black.withValues(alpha: 0.25),
                    valueColor: AlwaysStoppedAnimation<Color>(Renkler.vurgu),
                    minHeight: 8,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: BorderSide(color: Colors.white24),
                        ),
                        onPressed: () => _arttir(-1),
                        icon: Icon(Icons.remove, size: 18),
                        label: Text("Sayfa Geri"),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Renkler.vurgu,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () => _arttir(1),
                        icon: Icon(Icons.add, size: 18),
                        label: Text("Sayfa Okundu"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => _arttir(2),
                        child: Text("+2 sayfa", style: TextStyle(color: Renkler.acikVurgu, fontSize: 12)),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => _arttir(5),
                        child: Text("+5 sayfa", style: TextStyle(color: Renkler.acikVurgu, fontSize: 12)),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => _arttir(10),
                        child: Text("+10 sayfa", style: TextStyle(color: Renkler.acikVurgu, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Haftalık seri
          Row(
            children: [
              _istatistikKart(Icons.local_fire_department, '$_streak', 'Günlük seri (streak)'),
              SizedBox(width: 10),
              _istatistikKart(Icons.check_circle_outline, '$_bugunOkunan/$_gunlukHedef', "Bugünkü hedef (sayfa)"),
            ],
          ),
          SizedBox(height: 20),

          // Günlük hedef
          Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Renkler.cerceve2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🎯 Günlük Hedef (Hizb/Parti Planı)",
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "Günde 1 sayfa = 1 hatim ~20 ay. Günde 4 sayfa = ayda 1 hatim.",
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
                SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final hedef in [1, 2, 4, 5, 10, 20])
                      ChoiceChip(
                        label: Text('$hedef sf/gün', style: TextStyle(fontSize: 11)),
                        selected: _gunlukHedef == hedef,
                        selectedColor: Renkler.vurgu,
                        backgroundColor: Renkler.yuzey,
                        labelStyle: TextStyle(
                          color: _gunlukHedef == hedef ? Colors.black : Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (_) {
                          setState(() => _gunlukHedef = hedef);
                          _kaydet();
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          // Ezber takibi
          Text(
            "📚 Ezberlenen Sureler",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Ezberlediğiniz kısa sureleri işaretleyin; hatırlatma ve 'ezberi kuvvetlendirme' için takip altında kalır.",
            style: TextStyle(color: Colors.white54, fontSize: 11),
          ),
          SizedBox(height: 10),
          for (final k in kisaSureler)
            Card(
              color: Renkler.kart,
              margin: EdgeInsets.only(bottom: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: _ezberlenen.contains(k['no'])
                      ? Renkler.vurgu
                      : Renkler.cerceve,
                ),
              ),
              child: ListTile(
                dense: true,
                onTap: () => _ezberle(k['no'] as int),
                leading: Icon(
                  _ezberlenen.contains(k['no'])
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: _ezberlenen.contains(k['no'])
                      ? Renkler.vurgu
                      : Colors.white30,
                  size: 22,
                ),
                title: Text(
                  '${k['ad']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: _ezberlenen.contains(k['no']) ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  '${k['not']}',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.open_in_new, color: Colors.white38, size: 16),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SureDetayPage(sureNo: k['no'] as int),
                    ),
                  ),
                ),
              ),
            ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _istatistikKart(IconData ikon, String deger, String etiket) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Renkler.cerceve2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(ikon, color: Renkler.vurgu, size: 16),
                SizedBox(width: 6),
                Text(
                  deger,
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              etiket,
              style: TextStyle(color: Colors.white54, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
