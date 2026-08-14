import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class SoruCevapPage extends StatefulWidget {
  const SoruCevapPage({super.key});

  @override
  State<SoruCevapPage> createState() => _SoruCevapPageState();
}

class _SoruCevapPageState extends State<SoruCevapPage> {
  String _seciliKategori = 'Tümü';
  String _arama = '';
  final _aramaCtrl = TextEditingController();

  @override
  void dispose() {
    _aramaCtrl.dispose();
    super.dispose();
  }

  List<FetvaKaydi> get _filtreli {
    return fetvaArsivi.where((f) {
      final kategoriUygun = _seciliKategori == 'Tümü' ||
          f.kategori == _seciliKategori;
      final metin = '${f.soru} ${f.cevap}'.toLowerCase();
      final aramaUygun =
          _arama.isEmpty || metin.contains(_arama.toLowerCase());
      return kategoriUygun && aramaUygun;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Soru-Cevap & Fetva Arşivi',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: Column(
        children: [
          _bilgiBanneri(),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _aramaCtrl,
              style: TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Ara: namaz, oruç, zekat...',
                hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
                prefixIcon: Icon(Icons.search, color: Renkler.vurgu, size: 20),
                filled: true,
                fillColor: Renkler.yuzey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => _arama = v),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (final k in ['Tümü', ...fetvaKategorileri])
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(k),
                      selected: _seciliKategori == k,
                      onSelected: (_) => setState(() => _seciliKategori = k),
                      selectedColor: Renkler.vurgu,
                      backgroundColor: Renkler.kart,
                      labelStyle: TextStyle(
                        color: _seciliKategori == k
                            ? Renkler.zemin
                            : Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: _filtreli.isEmpty
                ? Center(
                    child: Text(
                      'Sonuç bulunamadı.\nFarklı bir arama deneyin.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(16, 4, 16, 24),
                    itemCount: _filtreli.length,
                    itemBuilder: (context, i) => _fetvaKarti(_filtreli[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _bilgiBanneri() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(16, 12, 16, 0),
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
              Icon(Icons.menu_book, color: Renkler.vurgu, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Güvenilir Kaynaklardan Fetva',
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
            'Fıkhi, akidevi ve ahlaki merak ettikleriniz; muteber kaynaklara dayandırılmış yanıtlarla. Sık sorulan sorular kategorilere ayrılmıştır. Kesin fetva için yetkili kurum ve alimlere danışın.',
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _fetvaKarti(FetvaKaydi f) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.help_outline, color: Renkler.vurgu, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    f.soru,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                f.cevap,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Renkler.bannerUst,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    f.kategori,
                    style: TextStyle(
                      color: Renkler.acikVurgu,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  f.kaynak,
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}