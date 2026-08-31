import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';
import '../../widgets/kart_sekilleri.dart';

class ZekatHesaplayiciPage extends StatefulWidget {
  const ZekatHesaplayiciPage({super.key});

  @override
  State<ZekatHesaplayiciPage> createState() => _ZekatHesaplayiciPageState();
}

class _ZekatHesaplayiciPageState extends State<ZekatHesaplayiciPage> {
  final List<ZekatKalemi> _kalemler = zekatKalemleri
      .map((k) => k.kopya())
      .toList();
  final _altinCtrl = TextEditingController();
  final _altinFiyatCtrl = TextEditingController(text: '2400');
  final _fitreKisiCtrl = TextEditingController(text: '1');
  final _fitreBedelCtrl = TextEditingController(text: '200');

  List<ZekatKalemi> get _varliklar =>
      _kalemler.where((k) => !k.dusulur).toList();

  List<ZekatKalemi> get _borclar => _kalemler.where((k) => k.dusulur).toList();

  double get _varlikToplami => _varliklar.fold(0.0, (a, k) => a + k.tutar);

  double get _borcToplami => _borclar.fold(0.0, (a, k) => a + k.tutar);

  double get _matrah =>
      (_varlikToplami - _borcToplami).clamp(0.0, double.infinity);

  double get _altinDegeri {
    final gram = double.tryParse(_altinCtrl.text) ?? 0;
    return gram * _altinFiyat();
  }

  double _altinFiyat() {
    return double.tryParse(_altinFiyatCtrl.text) ?? 2400.0;
  }

  double get _nisapDegeri => nisapAltinGram * _altinFiyat();

  bool get _nisabaUlasti => _matrah >= _nisapDegeri;

  /// Kalem bazında oranlarla toplam zekât tutarı (nisaba ulaşılırsa).
  double get _zekatTutari {
    if (!_nisabaUlasti) return 0;
    return _varliklar.fold(0.0, (a, k) => a + k.tutar * k.oran);
  }

  double get _fitreTutari {
    final kisi = int.tryParse(_fitreKisiCtrl.text) ?? 1;
    final bedel = double.tryParse(_fitreBedelCtrl.text) ?? 200;
    return kisi * bedel;
  }

  double get _altinZekati {
    if (!_nisabaUlasti) return 0;
    return _altinDegeri * 0.025;
  }

  @override
  void dispose() {
    _altinCtrl.dispose();
    _altinFiyatCtrl.dispose();
    _fitreKisiCtrl.dispose();
    _fitreBedelCtrl.dispose();
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
              ? AppLocalizations.of(context).t('zh.donateSnackZero')
              : AppLocalizations.of(context)
                  .t('zh.donateSnack')
                  .replaceFirst(
                      '{amount}', _zekatTutari.toStringAsFixed(0)),
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
      prefixIcon: UcdIkon(ikon: ikon, renk: Renkler.vurgu, boyut: 20),
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
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('zh.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _bilgiBanneri(l),
            SizedBox(height: 16),
            _ayarKarti(l),
            SizedBox(height: 16),
            _altinKarti(l),
            SizedBox(height: 16),
            _varliklarKarti(l),
            SizedBox(height: 16),
            _fitreKarti(l),
            SizedBox(height: 16),
            _sonucKarti(l),
            SizedBox(height: 16),
            _rehberKarti(l),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _bilgiBanneri(AppLocalizations l) {
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
              UcdIkon(ikon: Icons.calculate_rounded, renk: Renkler.vurgu, boyut: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  l.t('zh.bannerTitle'),
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
            l.t('zh.bannerIntro'),
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _ayarKarti(AppLocalizations l) {
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
                UcdIkon(ikon: Icons.tune_rounded, renk: Renkler.vurgu, boyut: 20),
                SizedBox(width: 8),
                Text(
                  l.t('zh.nisapTitle'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              l.t('zh.nisapIntro'),
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                height: 1.5,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _altinFiyatCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              style: TextStyle(color: Colors.white),
              decoration: _dekor(l.t('zh.nisapHint'), Icons.paid_rounded),
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _altinKarti(AppLocalizations l) {
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
                UcdIkon(ikon: Icons.monetization_on_rounded, renk: Renkler.vurgu, boyut: 20),
                SizedBox(width: 8),
                Text(
                  l.t('zh.goldTitle'),
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              style: TextStyle(color: Colors.white),
              decoration: _dekor(l.t('zh.goldHint'), Icons.stars_rounded),
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 8),
            Text(
              l.t('zh.goldCalc')
                  .replaceFirst('{amount}', binlikSayi(_altinZekati.round()))
                  .replaceFirst('{price}', binlikSayi(_altinFiyat().round()))
                  .replaceFirst('{value}', binlikSayi(_altinDegeri.round())),
              style: TextStyle(color: Colors.white38, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _varliklarKarti(AppLocalizations l) {
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
                UcdIkon(
                  ikon: Icons.account_balance_wallet_rounded,
                  renk: Renkler.vurgu,
                  boyut: 20,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.t('zh.assetsTitle'),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _sifirla,
                  child: Text(
                    l.t('zh.reset'),
                    style: TextStyle(color: Renkler.vurgu),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            for (final k in _kalemler) _kalemSatiri(k, l),
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
                icon: UcdIkon(ikon: Icons.calculate_rounded, renk: Renkler.zemin),
                label: Text(
                  l.t('zh.calcBtn'),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kalemSatiri(ZekatKalemi kalem, AppLocalizations l) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 13),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
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
          Padding(
            padding: EdgeInsets.only(left: 14, top: 4),
            child: Text(
              '${kalem.dusulur ? l.t('zh.deducted') : l.t('zh.rate').replaceFirst('{rate}', (kalem.oran * 100).toStringAsFixed(0).replaceAll(".0", ""))} • ${kalem.aciklama}',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 10,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fitreKarti(AppLocalizations l) {
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
                UcdIkon(ikon: Icons.people_alt_rounded, renk: Renkler.vurgu, boyut: 20),
                SizedBox(width: 8),
                Text(
                  l.t('zh.fitreTitle'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              l.t('zh.fitreIntro'),
              style: TextStyle(
                color: Colors.white54,
                fontSize: 12,
                height: 1.5,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _fitreKisiCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    decoration: _dekor(l.t('zh.personCount'), Icons.person_outline_rounded),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _fitreBedelCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    style: TextStyle(color: Colors.white, fontSize: 13),
                    decoration: _dekor(
                      l.t('zh.perPerson'),
                      Icons.payments_rounded,
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              l.t('zh.totalFitre').replaceFirst('{amount}', binlikSayi(_fitreTutari.round())),
              style: TextStyle(
                color: Renkler.vurgu,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sonucKarti(AppLocalizations l) {
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
                UcdIkon(
                  ikon: _nisabaUlasti ? Icons.check_circle_rounded : Icons.info_outline_rounded,
                  renk: _nisabaUlasti ? Renkler.vurgu : Colors.white54,
                  boyut: 20,
                ),
                SizedBox(width: 8),
                Text(
                  l.t('zh.result'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _sonucSatiri(l.t('zh.assetsTotal'), _varlikToplami),
            if (_borcToplami > 0)
              _sonucSatiri(l.t('zh.deductedDebts'), _borcToplami),
            _sonucSatiri(l.t('zh.netAssets'), _matrah),
            _sonucSatiri(l.t('zh.nisapLimit'), _nisapDegeri),
            Divider(color: Colors.white24, height: 20),
            if (_nisabaUlasti) ...[
              Text(
                l.t('zh.yourZakat'),
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
              Text(
                '${binlikSayi(_zekatTutari.round())} TL',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (_varliklar.any((k) => k.oran != 0.025 && k.tutar > 0)) ...[
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Renkler.yuzey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    l.t('zh.mixedRates').replaceFirst(
                        '{items}',
                        _varliklar
                            .where((k) => k.tutar > 0)
                            .map((k) => '${k.ad} %${(k.oran * 100).toStringAsFixed(0)}')
                            .join(', ')),
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ] else
              Text(
                l.t('zh.belowNisap'),
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            SizedBox(height: 12),
            if (_zekatTutari > 0 || _fitreTutari > 0) ...[
              Row(
                children: [
                  if (_zekatTutari > 0) ...[
                    Expanded(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Renkler.vurgu,
                          foregroundColor: Renkler.zemin,
                        ),
                        onPressed: _bagisaGonder,
                        icon: UcdIkon(ikon: Icons.volunteer_activism_rounded, renk: Renkler.zemin, boyut: 18),
                        label: Text(
                          l.t('zh.deliverZakat'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  if (_zekatTutari > 0 && _fitreTutari > 0) SizedBox(width: 10),
                  if (_fitreTutari > 0 && _zekatTutari <= 0) ...[
                    Expanded(
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Renkler.vurgu,
                          foregroundColor: Renkler.zemin,
                        ),
                        onPressed: _bagisaGonder,
                        icon: UcdIkon(ikon: Icons.volunteer_activism_rounded, renk: Renkler.zemin, boyut: 18),
                        label: Text(
                          l.t('zh.deliverFitre'),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
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
            '${binlikSayi(deger.round())} TL',
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

  Widget _rehberKarti(AppLocalizations l) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UcdIkon(ikon: Icons.menu_book_rounded, renk: Renkler.vurgu, boyut: 20),
                SizedBox(width: 8),
                Text(
                  l.t('zh.guideTitle'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            for (var i = 1; i <= 7; i++)
              _rehberSorusu(l.t('zh.g${i}q'), l.t('zh.g${i}a')),
          ],
        ),
      ),
    );
  }

  Widget _rehberSorusu(String soru, String cevap) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.only(bottom: 10),
        collapsedIconColor: Colors.white38,
        iconColor: Renkler.vurgu,
        title: Text(
          soru,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              cevap,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
