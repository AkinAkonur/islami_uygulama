import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class ZekatHesaplayiciPage extends StatefulWidget {
  const ZekatHesaplayiciPage({super.key});

  @override
  State<ZekatHesaplayiciPage> createState() => _ZekatHesaplayiciPageState();
}

class _ZekatHesaplayiciPageState extends State<ZekatHesaplayiciPage> {
  final List<ZekatKalemi> _kalemler =
      zekatKalemAdlari.map((a) => ZekatKalemi(a)).toList();
  final _altinCtrl = TextEditingController();

  double get _toplam =>
      _kalemler.fold(0.0, (a, k) => a + k.tutar) + _altinDegeri;

  double get _altinDegeri {
    final gram = double.tryParse(_altinCtrl.text) ?? 0;
    return gram * _altinFiyat();
  }

  double _altinFiyat() {
    // Örnek gram altın fiyatı (kullanıcı güncel değeriyle değiştirebilir).
    // Basit tahmin: 80 gram altın nisap kabul edilir.
    return 2400.0;
  }

  double get _nisapDegeri => nisapAltinGram * _altinFiyat();

  bool get _nisabaUlasti => _toplam >= _nisapDegeri;

  double get _zekatTutari => _nisabaUlasti ? _toplam * 0.025 : 0;

  @override
  void dispose() {
    _altinCtrl.dispose();
    super.dispose();
  }

  void _hesapla() {
    FocusScope.of(context).unfocus();
    setState(() {});
  }

  void _sifirla() {
    for (final k in _kalemler) {
      k.tutar = 0;
    }
    _altinCtrl.clear();
    setState(() {});
  }

  void _bagisaGonder() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _zekatTutari <= 0
              ? 'Zekat tutarınız hesaplanınca paylaşabilirsiniz.'
              : '${_zekatTutari.toStringAsFixed(0)} TL zekatınızı seçtiğiniz güvenilir kurum üzerinden ulaştırabilirsiniz. 💚',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  InputDecoration _dekor(String hint, IconData ikon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
      prefixIcon: Icon(ikon, color: Renkler.vurgu, size: 20),
      filled: true,
      fillColor: Renkler.yuzey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Zekat & Sadaka Hesaplayıcı',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _bilgiBanneri(),
          SizedBox(height: 16),
          _altinKarti(),
          SizedBox(height: 16),
          _varliklarKarti(),
          SizedBox(height: 16),
          _sonucKarti(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bilgiBanneri() {
    return Container(
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
              Icon(Icons.calculate, color: Renkler.vurgu, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Zekatını hesapla, ihtiyaç sahibine ulaştır',
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
            'Nisap 80,18 gram altın veya değeridir; üzerinden bir kamerî yıl geçen varlığın %2,5\'u verilir. Hesaplanan tutar, seçtiğiniz güvenilir kurum üzerinden ihtiyaç sahibine ulaştırılabilir.',
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _altinKarti() {
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
                Icon(Icons.monetization_on, color: Renkler.vurgu, size: 20),
                SizedBox(width: 8),
                Text(
                  'Altın Miktarı',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: _altinCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
              style: TextStyle(color: Colors.white),
              decoration: _dekor('Kaç gram altının var?', Icons.stars_outlined),
              onSubmitted: (_) => _hesapla(),
            ),
            SizedBox(height: 8),
            Text(
              'Örnek gram fiyatı: ${_altinFiyat().toStringAsFixed(0)} TL • Nisap: ${_nisapDegeri.toStringAsFixed(0)} TL (${nisapAltinGram} gram altın)',
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _varliklarKarti() {
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
                Icon(Icons.account_balance_wallet, color: Renkler.vurgu, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Zekata Tabi Varlıklar (TL)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _sifirla,
                  child: Text('Sıfırla', style: TextStyle(color: Renkler.vurgu)),
                ),
              ],
            ),
            SizedBox(height: 6),
            for (final k in _kalemler) _kalemSatiri(k),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Renkler.vurgu,
                  foregroundColor: Renkler.zemin,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: _hesapla,
                icon: Icon(Icons.calculate_outlined),
                label: Text(
                  'Zekatımı Hesapla',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kalemSatiri(ZekatKalemi kalem) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: TextField(
        style: TextStyle(color: Colors.white, fontSize: 13),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))
        ],
        decoration: InputDecoration(
          labelText: kalem.ad,
          labelStyle: TextStyle(color: Colors.white54, fontSize: 13),
          filled: true,
          fillColor: Renkler.yuzey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          suffixText: 'TL',
          suffixStyle: TextStyle(color: Colors.white38, fontSize: 12),
        ),
        onChanged: (v) {
          kalem.tutar = double.tryParse(v.replaceAll(',', '.')) ?? 0;
          setState(() {});
        },
      ),
    );
  }

  Widget _sonucKarti() {
    return Card(
      color: _nisabaUlasti ? Renkler.seciliYuzey : Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: _nisabaUlasti ? Renkler.vurgu : Renkler.cerceve,
          width: _nisabaUlasti ? 1.5 : 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _nisabaUlasti
                      ? Icons.check_circle
                      : Icons.info_outline,
                  color: _nisabaUlasti ? Renkler.vurgu : Colors.white54,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Sonuç',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _sonucSatiri('Toplam varlık', _toplam),
            _sonucSatiri('Nisap sınırı', _nisapDegeri),
            Divider(color: Colors.white24, height: 20),
            if (_nisabaUlasti)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Zekatınız:',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  Text(
                    '${_zekatTutari.toStringAsFixed(0)} TL',
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              )
            else
              Text(
                'Varlıklarınız nisap sınırının altında. Şu an zekat yükümlülüğünüz bulunmuyor; gönüllü sadaka vermeye devam edebilirsiniz.',
                style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
              ),
            SizedBox(height: 12),
            if (_zekatTutari > 0)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Renkler.vurgu,
                    foregroundColor: Renkler.zemin,
                  ),
                  onPressed: _bagisaGonder,
                  icon: Icon(Icons.volunteer_activism, size: 18),
                  label: Text(
                    'Zekatımı Ulaştır',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _sonucSatiri(String ad, double deger) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(ad, style: TextStyle(color: Colors.white54, fontSize: 13)),
          Text(
            '${deger.toStringAsFixed(0)} TL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
