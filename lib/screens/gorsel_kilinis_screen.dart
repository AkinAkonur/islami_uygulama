import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

enum NamazPosture { kiyam, ruku, secde, oturus }

class GorselKilinisScreen extends StatelessWidget {
  const GorselKilinisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Renkler.zemin,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).t('g.visualGuide'),
              style: TextStyle(fontWeight: FontWeight.bold, color: Renkler.vurgu),
            ),
          backgroundColor: Renkler.seciliYuzey,
          elevation: 0,
          iconTheme: IconThemeData(color: Renkler.vurgu),
          bottom: TabBar(
            indicatorColor: Renkler.vurgu,
            labelColor: Renkler.vurgu,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: [
              Tab(text: "5 Vakit Kılınış"),
              Tab(text: "Görsel Abdest"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _KilinisTab(),
            _AbdestTab(),
          ],
        ),
      ),
    );
  }
}

class _Durus {
  final NamazPosture pozisyon;
  final String etiket;
  final String kisa;
  final String detay;

  const _Durus(this.pozisyon, this.etiket, this.kisa, this.detay);
}

class _Rekat {
  final String ad;
  final String hukuk;
  final List<_Durus> duruslar;

  const _Rekat(this.ad, this.hukuk, this.duruslar);
}

class _VakitPlani {
  final String ad;
  final String ozet;
  final IconData ikon;
  final List<_Rekat> rekatlar;

  const _VakitPlani(this.ad, this.ozet, this.ikon, this.rekatlar);
}

_Durus _ky(String detay) =>
    _Durus(NamazPosture.kiyam, "Kıyam", "Kıraat", detay);

_Durus _rk() => _Durus(
    NamazPosture.ruku,
    "Rükû",
    "3x 'Azîm",
    "Rükûda 3 defa 'Sübhâne rabbiye'l-azîm' denir. Bel 90 derece bükülür, eller dizlere konur.");

_Durus _sc() => _Durus(
    NamazPosture.secde,
    "Secde",
    "3x 'A'lâ",
    "Secdede 3 defa 'Sübhâne rabbiye'l-a'lâ' denir. Alın ve burun yere değer.");

_Durus _cl() => _Durus(NamazPosture.oturus, "Celse", "Kısa oturuş",
    "İki secde arasında 'Sübhânallah' diyecek kadar kısa bir süre oturulur.");

_Durus _ot(String detay) => _Durus(NamazPosture.oturus, "Oturuş", "Dualar", detay);

_Durus _sl() => _Durus(NamazPosture.oturus, "Selâm", "Selâm",
    "Önce sağa, sonra sola 'Es-selâmu aleyküm ve rahmetullah' denilerek namaz tamamlanır.");

_Durus _ilksira() => _ky(
    "Niyet edilir, iftitah tekbiri alınır. Sübhaneke, Eûzü-Besmele, Fâtiha ve zamm-ı sure okunur.");

_Durus _fathazamm() => _ky("Fâtiha ve zamm-ı sure okunur.");

_Durus _sadecefatiha() => _ky("Bu rekatte sadece Fâtiha okunur, zamm-ı sure okunmaz.");

_Durus _kunut() => _ky(
    "Niyet, iftitah tekbiri, Sübhaneke, Fâtiha ve zamm-ı sureden sonra Kunut duaları okunur.");

_Durus _ilkOturus() => _ot("Oturuşta Ettehiyyâtü okunur.");

_Durus _sonOturus() =>
    _ot("Oturuşta Ettehiyyâtü, Salli-Bârik ve Rabbenâ duaları okunur.");

_Rekat _rekat(String ad, String hukuk, List<_Durus> duruslar) =>
    _Rekat(ad, hukuk, duruslar);

final List<_VakitPlani> _vakitler = [
  _VakitPlani("Sabah", "4 rekat: 2 Sünnet + 2 Farz", Icons.wb_twilight_rounded, [
    _rekat("1. Rekat (Sünnet)", "SÜNNET", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("2. Rekat (Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
      _sl(),
    ]),
    _rekat("3. Rekat (Farz)", "FÂRZ", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("4. Rekat (Farz)", "FÂRZ", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _sonOturus(),
      _sl(),
    ]),
  ]),
  _VakitPlani("Öğle", "10 rekat: 4 Sünnet + 4 Farz + 2 Son Sünnet", Icons.wb_sunny_rounded, [
    _rekat("1. Rekat (İlk Sünnet)", "SÜNNET", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("2. Rekat (İlk Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
    ]),
    _rekat("3. Rekat (İlk Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("4. Rekat (İlk Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
      _sl(),
    ]),
    _rekat("5. Rekat (Farz)", "FÂRZ", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("6. Rekat (Farz)", "FÂRZ", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
    ]),
    _rekat("7. Rekat (Farz)", "FÂRZ", [
      _sadecefatiha(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("8. Rekat (Farz)", "FÂRZ", [
      _sadecefatiha(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _sonOturus(),
      _sl(),
    ]),
    _rekat("9. Rekat (Son Sünnet)", "SÜNNET", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("10. Rekat (Son Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
      _sl(),
    ]),
  ]),
  _VakitPlani("İkindi", "8 rekat: 4 Sünnet + 4 Farz", Icons.brightness_5_rounded, [
    _rekat("1. Rekat (Sünnet)", "SÜNNET", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("2. Rekat (Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
    ]),
    _rekat("3. Rekat (Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("4. Rekat (Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
      _sl(),
    ]),
    _rekat("5. Rekat (Farz)", "FÂRZ", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("6. Rekat (Farz)", "FÂRZ", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
    ]),
    _rekat("7. Rekat (Farz)", "FÂRZ", [
      _sadecefatiha(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("8. Rekat (Farz)", "FÂRZ", [
      _sadecefatiha(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _sonOturus(),
      _sl(),
    ]),
  ]),
  _VakitPlani("Akşam", "5 rekat: 3 Farz + 2 Sünnet", Icons.landscape_rounded, [
    _rekat("1. Rekat (Farz)", "FÂRZ", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("2. Rekat (Farz)", "FÂRZ", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
    ]),
    _rekat("3. Rekat (Farz)", "FÂRZ", [
      _sadecefatiha(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _sonOturus(),
      _sl(),
    ]),
    _rekat("4. Rekat (Sünnet)", "SÜNNET", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("5. Rekat (Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
      _sl(),
    ]),
  ]),
  _VakitPlani("Yatsı", "13 rekat: 4 Sünnet + 4 Farz + 2 Son Sünnet + 3 Vitir",
      Icons.nights_stay_rounded, [
    _rekat("1. Rekat (İlk Sünnet)", "SÜNNET", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("2. Rekat (İlk Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
    ]),
    _rekat("3. Rekat (İlk Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("4. Rekat (İlk Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
      _sl(),
    ]),
    _rekat("5. Rekat (Farz)", "FÂRZ", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("6. Rekat (Farz)", "FÂRZ", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
    ]),
    _rekat("7. Rekat (Farz)", "FÂRZ", [
      _sadecefatiha(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("8. Rekat (Farz)", "FÂRZ", [
      _sadecefatiha(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _sonOturus(),
      _sl(),
    ]),
    _rekat("9. Rekat (Son Sünnet)", "SÜNNET", [
      _ilksira(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("10. Rekat (Son Sünnet)", "SÜNNET", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _ilkOturus(),
      _sl(),
    ]),
    _rekat("11. Rekat (Vitir)", "VÂCİP", [
      _kunut(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("12. Rekat (Vitir)", "VÂCİP", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
    ]),
    _rekat("13. Rekat (Vitir)", "VÂCİP", [
      _fathazamm(),
      _rk(),
      _sc(),
      _cl(),
      _sc(),
      _sonOturus(),
      _sl(),
    ]),
  ]),
];

class _AbdestAdimi {
  final String ad;
  final String hukuk;
  final String bolge;
  final String detay;

  const _AbdestAdimi(this.ad, this.hukuk, this.bolge, this.detay);
}

const List<_AbdestAdimi> _abdestAdimlari = [
  _AbdestAdimi("Niyet & Besmele", "ŞART", "hepsi",
      "Abdest almaya niyet edilir ve 'Eûzü billâhi mine'ş-şeytâni'r-racîm, Bismillâhi'r-rahmâni'r-rahîm' denir."),
  _AbdestAdimi("Elleri yıkamak", "SÜNNET", "eller",
      "Eller bileklere kadar 3 defa yıkanır; parmak araları iyice ovulur."),
  _AbdestAdimi("Ağzı çalkalamak", "SÜNNET", "agiz",
      "Sağ avuçla 3 defa su alınır, ağız iyice çalkalanır."),
  _AbdestAdimi("Buruna su vermek", "SÜNNET", "burun",
      "Burna 3 defa su çekilir, sol elle sümkürülerek temizlenir."),
  _AbdestAdimi("Yüzü yıkamak", "FARZ", "yuz",
      "Alından saç bitimine, kulak yumuşağına ve çene altına kadar yüz 3 defa yıkanır."),
  _AbdestAdimi("Kolları yıkamak", "FARZ", "kollar",
      "Önce sağ kol, sonra sol kol dirseklerle birlikte 3 defa yıkanır."),
  _AbdestAdimi("Başı mesh etmek", "FARZ", "bas",
      "Islak elle başın dörtte biri mesh edilir."),
  _AbdestAdimi("Kulak & boyun meshi", "SÜNNET", "kulak",
      "Serçe parmakla kulak içi, baş parmakla kulak arkası meshedilir; boyun ellerin sırtıyla meshedilir."),
  _AbdestAdimi("Ayakları yıkamak", "FARZ", "ayaklar",
      "Önce sağ ayak, sonra sol ayak topuklarla birlikte 3 defa yıkanır; parmak araları ovulur."),
  _AbdestAdimi("Abdest duası", "SÜNNET", "hepsi",
      "Abdest sonrası 'Eşhedü en lâ ilâhe illallâh ve eşhedü enne Muhammeden abdühû ve rasûlüh' denir."),
];

class _KilinisTab extends StatefulWidget {
  @override
  State<_KilinisTab> createState() => _KilinisTabState();
}

class _KilinisTabState extends State<_KilinisTab> {
  int _seciliVakit = 0;

  @override
  Widget build(BuildContext context) {
    final plan = _vakitler[_seciliVakit];
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _introBanner(
          Icons.accessibility_new_rounded,
          "Görsel Kılınış Rehberi",
          "Hanefî usulüne göre her vakit, rekat rekat şemalı olarak gösterilir.",
        ),
        SizedBox(height: 20),
        Text(
          "Namazın Temel Duruşları",
          style: TextStyle(
            color: Renkler.vurgu,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 134,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _durusKutu(NamazPosture.kiyam, "Kıyam", "Ayakta kıraat"),
              _durusKutu(NamazPosture.ruku, "Rükû", "3x 'Azîm"),
              _durusKutu(NamazPosture.secde, "Secde", "3x 'A'lâ"),
              _durusKutu(NamazPosture.oturus, "Oturuş", "Dualar"),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Vakit Seç",
          style: TextStyle(
            color: Renkler.vurgu,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _vakitler.asMap().entries.map((e) {
              final v = e.value;
              final secili = e.key == _seciliVakit;
              return Padding(
                padding: EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  avatar: UcdIkon(ikon: v.ikon, boyut: 16,
                      renk: secili ? Colors.black : Renkler.vurgu),
                  label: Text(v.ad),
                  selected: secili,
                  selectedColor: Renkler.vurgu,
                  backgroundColor: Renkler.kart,
                  labelStyle: TextStyle(
                    color: secili ? Colors.black : Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                  side: BorderSide(color: secili ? Renkler.vurgu : Renkler.cerceve2),
                  onSelected: (_) => setState(() => _seciliVakit = e.key),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Renkler.yuzey,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Renkler.cerceve2),
          ),
          child: Row(
            children: [
              UcdIkon(ikon: plan.ikon, renk: Renkler.vurgu, boyut: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "${plan.ad} Namazı: ${plan.ozet}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        ...plan.rekatlar.asMap().entries.map((e) {
          final no = e.key + 1;
          final rekat = e.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: _RekatKarti(no: no, rekat: rekat),
          );
        }),
        SizedBox(height: 8),
        Text(
          "Şemalardaki her duruşa dokunarak okunuş detayını görebilirsin. Rekat planı Hanefî mezhebine göredir.",
          style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.4),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _introBanner(IconData icon, String baslik, String aciklama) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.seciliYuzey, Renkler.zemin],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          UcdIkon(ikon: icon, renk: Renkler.vurgu, boyut: 36),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  aciklama,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _durusKutu(NamazPosture durus, String ad, String aciklama) {
    return Container(
      width: 84,
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve2),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 56,
            height: 60,
            child: CustomPaint(
              painter: _NamazDurusPainter(durus: durus, renk: Renkler.vurgu),
            ),
          ),
          SizedBox(height: 6),
          Text(
            ad,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            aciklama,
            style: TextStyle(color: Colors.white54, fontSize: 9),
          ),
        ],
      ),
    );
  }
}

class _RekatKarti extends StatefulWidget {
  final int no;
  final _Rekat rekat;

  const _RekatKarti({required this.no, required this.rekat});

  @override
  State<_RekatKarti> createState() => _RekatKartiState();
}

class _RekatKartiState extends State<_RekatKarti> {
  int _seciliDurus = 0;

  @override
  Widget build(BuildContext context) {
    final duruslar = widget.rekat.duruslar;
    final secili = duruslar[_seciliDurus];
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Renkler.cerceve2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.rekat.ad,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (widget.rekat.hukuk.isNotEmpty)
                _hukukRozet(widget.rekat.hukuk),
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 108,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < duruslar.length; i++) ...[
                  _durusIkonu(duruslar[i], secili: i == _seciliDurus,
                      onTap: () => setState(() => _seciliDurus = i)),
                  if (i < duruslar.length - 1)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: UcdIkon(
                        ikon: Icons.chevron_right,
                        boyut: 10,
                        renk: Colors.white24,
                      ),
                    ),
                ],
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Renkler.cerceve2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UcdIkon(ikon: Icons.info_outline_rounded, boyut: 16, renk: Renkler.vurgu),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    secili.detay,
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hukukRozet(String hukuk) {
    final farz = hukuk == "FÂRZ" || hukuk == "ŞART";
    final vacip = hukuk == "VÂCİP";
    final renk = farz
        ? Renkler.vurgu
        : vacip
            ? Colors.orangeAccent
            : Renkler.cerceve2;
    final yazi = farz || vacip ? Colors.black : Colors.white70;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: renk,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        hukuk,
        style: TextStyle(
          color: yazi,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _durusIkonu(
    _Durus durus, {
    required bool secili,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 62,
        margin: EdgeInsets.only(right: 4),
        padding: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: secili ? Renkler.seciliYuzey : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: secili ? Renkler.vurgu : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: 42,
              height: 46,
              child: CustomPaint(
                painter: _NamazDurusPainter(
                  durus: durus.pozisyon,
                  renk: secili ? Renkler.vurgu : Renkler.acikVurgu,
                ),
              ),
            ),
            Text(
              durus.etiket,
              style: TextStyle(
                color: secili ? Renkler.vurgu : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 9,
              ),
            ),
            Text(
              durus.kisa,
              style: TextStyle(color: Colors.white38, fontSize: 8),
            ),
          ],
        ),
      ),
    );
  }
}

class _AbdestTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Renkler.seciliYuzey, Renkler.zemin],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              UcdIkon(ikon: Icons.water_drop_rounded, renk: Renkler.vurgu, boyut: 36),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Abdest Nasıl Alınır?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "10 adımda, vücut şemasıyla hangi bölgenin yıkandığı vurgulanarak gösterilir.",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          "Abdestin Farzları (4)",
          style: TextStyle(
            color: Renkler.vurgu,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _hukukChip("Yüzü yıkamak", true),
            _hukukChip("Kolları yıkamak", true),
            _hukukChip("Başın mesh'i", true),
            _hukukChip("Ayakları yıkamak", true),
          ],
        ),
        SizedBox(height: 16),
        Text(
          "Abdestin Sünnetleri (6)",
          style: TextStyle(
            color: Renkler.vurgu,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _hukukChip("Niyet & Besmele", false),
            _hukukChip("Elleri yıkamak", false),
            _hukukChip("Ağız çalkalamak", false),
            _hukukChip("Buruna su vermek", false),
            _hukukChip("Kulak & boyun meshi", false),
            _hukukChip("Abdest duası", false),
          ],
        ),
        SizedBox(height: 20),
        Text(
          "Adım Adım Görsel Abdest",
          style: TextStyle(
            color: Renkler.vurgu,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        ..._abdestAdimlari.asMap().entries.map((e) {
          final no = e.key + 1;
          final adim = e.value;
          return _AbdestKarti(no: no, adim: adim);
        }),
        SizedBox(height: 8),
        Text(
          "Farz adımları atlanırsa abdest geçersiz olur; sünnet adımları abdestin sevabını artırır.",
          style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.4),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _hukukChip(String ad, bool farz) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: farz ? Renkler.vurgu : Renkler.cerceve2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        ad,
        style: TextStyle(
          color: farz ? Colors.black : Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _AbdestKarti extends StatelessWidget {
  final int no;
  final _AbdestAdimi adim;

  const _AbdestKarti({required this.no, required this.adim});

  @override
  Widget build(BuildContext context) {
    final farz = adim.hukuk == "FARZ" || adim.hukuk == "ŞART";
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: farz ? Renkler.vurgu.withValues(alpha: 0.4) : Renkler.cerceve2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Renkler.vurgu,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "$no",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 72,
            height: 86,
            decoration: BoxDecoration(
              color: Renkler.yuzey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(4),
              child: CustomPaint(
                painter: _AbdestFiguruPainter(
                  bolge: adim.bolge,
                  tabRenk: Renkler.cerceve2,
                  vurguRenk: Renkler.vurgu,
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        adim.ad,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: farz ? Renkler.vurgu : Renkler.cerceve2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        adim.hukuk,
                        style: TextStyle(
                          color: farz ? Colors.black : Colors.white70,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  adim.detay,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11.5,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NamazDurusPainter extends CustomPainter {
  final NamazPosture durus;
  final Color renk;

  const _NamazDurusPainter({required this.durus, required this.renk});

  @override
  void paint(Canvas canvas, Size size) {
    final olcek = size.width / 100;
    canvas.save();
    canvas.translate(0, (size.height - size.width) / 2);
    canvas.scale(olcek);

    final boya = Paint()
      ..color = renk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    void ciz(List<Offset> noktalar) {
      final yol = Path()..moveTo(noktalar.first.dx, noktalar.first.dy);
      for (final n in noktalar.skip(1)) {
        yol.lineTo(n.dx, n.dy);
      }
      canvas.drawPath(yol, boya);
    }

    Offset kafa;
    List<Offset> govde;
    List<Offset> kol1;
    List<Offset> kol2;
    List<Offset> bacak1;
    List<Offset> bacak2;

    switch (durus) {
      case NamazPosture.kiyam:
        kafa = const Offset(50, 14);
        govde = const [Offset(50, 24), Offset(50, 56)];
        kol1 = const [Offset(50, 27), Offset(40, 47)];
        kol2 = const [Offset(50, 27), Offset(60, 47)];
        bacak1 = const [Offset(50, 56), Offset(44, 88)];
        bacak2 = const [Offset(50, 56), Offset(56, 88)];
        break;
      case NamazPosture.ruku:
        kafa = const Offset(43, 21);
        govde = const [Offset(43, 29), Offset(52, 58)];
        kol1 = const [Offset(43, 31), Offset(50, 66)];
        kol2 = const [Offset(43, 31), Offset(62, 60)];
        bacak1 = const [Offset(52, 58), Offset(50, 88)];
        bacak2 = const [Offset(52, 58), Offset(60, 86)];
        break;
      case NamazPosture.secde:
        kafa = const Offset(30, 73);
        govde = const [Offset(38, 67), Offset(66, 64)];
        kol1 = const [Offset(40, 67), Offset(31, 77)];
        kol2 = const [Offset(44, 65), Offset(37, 77)];
        bacak1 = const [Offset(66, 64), Offset(74, 70)];
        bacak2 = const [Offset(66, 64), Offset(72, 80)];
        break;
      case NamazPosture.oturus:
        kafa = const Offset(50, 24);
        govde = const [Offset(50, 32), Offset(50, 56)];
        kol1 = const [Offset(50, 34), Offset(44, 52)];
        kol2 = const [Offset(50, 34), Offset(56, 52)];
        bacak1 = const [Offset(50, 56), Offset(50, 80)];
        bacak2 = const [Offset(58, 56), Offset(58, 80)];
        break;
    }

    canvas.drawCircle(kafa, 8, boya..style = PaintingStyle.fill);
    boya.style = PaintingStyle.stroke;
    ciz(govde);
    ciz(kol1);
    ciz(kol2);
    ciz(bacak1);
    ciz(bacak2);

    if (durus == NamazPosture.oturus) {
      ciz(const [Offset(50, 80), Offset(58, 80)]);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _NamazDurusPainter oldDelegate) =>
      oldDelegate.durus != durus || oldDelegate.renk != renk;
}

class _AbdestFiguruPainter extends CustomPainter {
  final String bolge;
  final Color tabRenk;
  final Color vurguRenk;

  const _AbdestFiguruPainter({
    required this.bolge,
    required this.tabRenk,
    required this.vurguRenk,
  });

  static const Offset _kafa = Offset(50, 18);
  static const double _kafaYaricap = 10;

  @override
  void paint(Canvas canvas, Size size) {
    final olcek = size.width / 100;
    canvas.save();
    canvas.translate(0, (size.height - size.width) / 2);
    canvas.scale(olcek);

    final boya = Paint()
      ..color = tabRenk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    void ciz(List<Offset> noktalar) {
      final yol = Path()..moveTo(noktalar.first.dx, noktalar.first.dy);
      for (final n in noktalar.skip(1)) {
        yol.lineTo(n.dx, n.dy);
      }
      canvas.drawPath(yol, boya);
    }

    const govde = [Offset(50, 30), Offset(50, 58)];
    const kol1 = [Offset(50, 32), Offset(38, 54)];
    const kol2 = [Offset(50, 32), Offset(62, 54)];
    const bacak1 = [Offset(50, 58), Offset(44, 84)];
    const bacak2 = [Offset(50, 58), Offset(56, 84)];

    canvas.drawCircle(_kafa, _kafaYaricap, boya..style = PaintingStyle.fill);
    boya.style = PaintingStyle.stroke;
    ciz(govde);
    ciz(kol1);
    ciz(kol2);
    ciz(bacak1);
    ciz(bacak2);

    final vurguBoya = Paint()
      ..color = vurguRenk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    switch (bolge) {
      case "hepsi":
        vurguBoya.strokeWidth = 6;
        canvas.drawCircle(_kafa, _kafaYaricap,
            vurguBoya..style = PaintingStyle.fill);
        vurguBoya.style = PaintingStyle.stroke;
        ciz(govde);
        ciz(kol1);
        ciz(kol2);
        ciz(bacak1);
        ciz(bacak2);
        break;
      case "yuz":
        canvas.drawCircle(_kafa, _kafaYaricap,
            vurguBoya..style = PaintingStyle.fill);
        break;
      case "agiz":
        vurguBoya.style = PaintingStyle.fill;
        canvas.drawCircle(const Offset(50, 22), 4, vurguBoya);
        break;
      case "burun":
        vurguBoya.style = PaintingStyle.fill;
        canvas.drawCircle(const Offset(50, 16), 3.5, vurguBoya);
        break;
      case "eller":
        vurguBoya.style = PaintingStyle.fill;
        canvas.drawCircle(const Offset(38, 54), 6, vurguBoya);
        canvas.drawCircle(const Offset(62, 54), 6, vurguBoya);
        break;
      case "kollar":
        ciz(kol1);
        ciz(kol2);
        break;
      case "bas":
        final alan = Rect.fromCircle(center: _kafa, radius: _kafaYaricap);
        canvas.drawArc(alan, 3.14159, 3.14159, false, vurguBoya);
        break;
      case "kulak":
        vurguBoya.style = PaintingStyle.fill;
        canvas.drawCircle(const Offset(39.5, 18), 3.5, vurguBoya);
        canvas.drawCircle(const Offset(60.5, 18), 3.5, vurguBoya);
        break;
      case "boyun":
        ciz(const [Offset(50, 28), Offset(50, 34)]);
        break;
      case "ayaklar":
        vurguBoya.style = PaintingStyle.fill;
        canvas.drawCircle(const Offset(44, 84), 6, vurguBoya);
        canvas.drawCircle(const Offset(56, 84), 6, vurguBoya);
        break;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _AbdestFiguruPainter oldDelegate) =>
      oldDelegate.bolge != bolge ||
      oldDelegate.tabRenk != tabRenk ||
      oldDelegate.vurguRenk != vurguRenk;
}
