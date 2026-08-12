// lib/pages/kissalar_ve_peygamberler_page.dart

import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../models/kissalar_model.dart';
import '../services/akilli_arama_servisi.dart';
import 'peygamber_detay_page.dart';

class KissalarVePeygamberlerPage extends StatefulWidget {
  const KissalarVePeygamberlerPage({super.key});

  @override
  State<KissalarVePeygamberlerPage> createState() =>
      _KissalarVePeygamberlerPageState();
}

class _KissalarVePeygamberlerPageState extends State<KissalarVePeygamberlerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  IcerikModu _aktifMod = IcerikModu.kesif;
  String _aramaSorgusu = '';

  // Örnek Veritabanı Verisi
  final List<PeygamberModel> _peygamberler = [
    PeygamberModel(
      id: '1',
      isim: CiftIsim(
        islamiIsim: 'Hz. İbrahim',
        evrenselIsim: 'Prophet Abraham',
        alternatifAramaKeyleri: ['Abraham', 'Ibrahim', 'Abrahim'],
      ),
      kronolojikSira: 1,
      donem: 'M.Ö. 2000',
      gonderildigiKavim: 'Babil ve Keldani Halkı',
      cografiHarita: [
        HaritaNoktasi(
          konumAdi: 'Babil / Ur Şehri',
          bugunkuKarsiligi: 'Güney Irak / Nasiriye',
          enlem: 30.9629,
          boylam: 46.1031,
        ),
      ],
      kesifIcerigi: {
        'tr':
            'Hz. İbrahim [sozluk:hanif]Hanif[/sozluk] dininin önderidir. [sahabe:1]Hz. İsmail[/sahabe] ve Hz. İshak\'ın babasıdır.',
      },
      derinIcerigi: {
        'tr':
            'Klasik kaynaklarda İbn Kesir şöyle nakleder: Babil kralı Nemrut ile olan tevhid mücadelesi...',
      },
      kaynaklar: [
        KaynakAtfi(
          eserAdi: 'Kısas-ı Enbiya',
          yazar: 'İbn Kesir',
          ciltSayfa: 'Cilt 1, s. 150',
        ),
      ],
      farkliGorusler: [
        {
          'baslik': 'Ateşe Atıldığı Yer',
          'icerik':
              'Urfa Balıklıgöl rivayetinin yanında Babil bölgesi rivayeti de mevcuttur.',
        },
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final filtrelenmisPeygamberler = AkilliAramaServisi.aramaYap(
      _aramaSorgusu,
      _peygamberler,
    );

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        title: const Text(
          'Kıssalar ve Peygamberler',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          // Keşif / Derin Okuma Modu Değiştirici Switch
          Row(
            children: [
              Text(
                _aktifMod == IcerikModu.kesif ? 'Keşif' : 'Derin',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                value: _aktifMod == IcerikModu.derinOkuma,
                activeThumbColor: Renkler.vurgu,
                onChanged: (val) {
                  setState(() {
                    _aktifMod = val ? IcerikModu.derinOkuma : IcerikModu.kesif;
                  });
                },
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Renkler.vurgu,
          labelColor: Renkler.vurgu,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: 'Peygamberler Tarihi'),
            Tab(text: 'Siyer-i Nebi'),
            Tab(text: 'Kur\'an Kıssaları'),
            Tab(text: 'Tematik Hikayeler'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Gelişmiş Çift İsimli Arama Arayüzü
          Container(
            padding: const EdgeInsets.all(12),
            color: Renkler.yuzey,
            child: TextField(
              onChanged: (val) => setState(() => _aramaSorgusu = val),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText:
                    'İsim, mekan, kavram arayın (Örn: Abraham, Nuh, Asa)...',
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Renkler.kart,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPeygamberlerTimeline(filtrelenmisPeygamberler),
                _buildSiyeriNebiKategorileri(),
                _buildKuranKissalariKavimler(),
                _buildTematikHikayeler(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 1. KRONOLOJİK ZAMAN ÇİZELGESİ (TIMELINE)
  Widget _buildPeygamberlerTimeline(List<PeygamberModel> liste) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: liste.length,
      itemBuilder: (context, index) {
        final p = liste[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    PeygamberDetayPage(peygamber: p, mod: _aktifMod),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline Sol Çizgi ve İkon
              Column(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Renkler.vurgu, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '${p.kronolojikSira}',
                        style: TextStyle(
                          color: Renkler.vurgu,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (index != liste.length - 1)
                    Container(width: 2, height: 80, color: Renkler.cerceve),
                ],
              ),
              const SizedBox(width: 14),

              // İçerik Kartı
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Renkler.kart,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Renkler.cerceve),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            p.isim.getGosterimIsmi('tr'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            p.donem,
                            style: TextStyle(
                              color: Renkler.vurgu,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Kavim: ${p.gonderildigiKavim}',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        p.cografiHarita.first.bugunkuKarsiligi,
                        style: const TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 2. SİYER-İ NEBİ DÖNEMSEL KATEGORİLERİ
  Widget _buildSiyeriNebiKategorileri() {
    final kategoriler = [
      {
        'baslik': 'Mekke Dönemi',
        'alt': 'Doğumu, Gençliği ve Vahiy Dönemi',
        'ikon': Icons.brightness_5,
      },
      {
        'baslik': 'Hicret',
        'alt': 'Mekke\'den Medine\'ye Yolculuk Rotası',
        'ikon': Icons.alt_route,
      },
      {
        'baslik': 'Medine Dönemi',
        'alt': 'Devletleşme, Sosyal Hayat ve Mescid-i Nebevi',
        'ikon': Icons.mosque,
      },
      {
        'baslik': 'Savaşlar ve Seriyyeler',
        'alt': 'Bedir, Uhud, Hendek ve Taktik Haritalar',
        'ikon': Icons.shield,
      },
      {
        'baslik': 'Veda Haccı ve Vefatı',
        'alt': 'İnsan Hakları Evrensel Beyannamesi Niteliğinde Hitap',
        'ikon': Icons.menu_book,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: kategoriler.length,
      itemBuilder: (context, i) {
        final item = kategoriler[i];
        return Card(
          color: Renkler.kart,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: Icon(
              item['ikon'] as IconData,
              color: Renkler.vurgu,
              size: 28,
            ),
            title: Text(
              item['baslik'] as String,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              item['alt'] as String,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.white38),
            onTap: () {},
          ),
        );
      },
    );
  }

  // 3. KUR'AN KISSALARI VE KAVİMLER
  Widget _buildKuranKissalariKavimler() {
    final kavimler = [
      'Âd Kavmi (Hz. Hud)',
      'Semûd Kavmi (Hz. Salih)',
      'Medyen Halkı (Hz. Şuayb)',
      'Ashâb-ı Kehf',
    ];
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemCount: kavimler.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Renkler.kart,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Renkler.cerceve),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.groups_outlined, color: Renkler.vurgu, size: 32),
              const SizedBox(height: 8),
              Text(
                kavimler[i],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 4. TEMATİK VE DUYGU FİLTRELİ İBRETLİK HİKAYELER
  Widget _buildTematikHikayeler() {
    final duygular = [
      'Sabır',
      'Şükür',
      'Adalet',
      'Tövbe',
      'Merhamet',
      'Tevekkül',
    ];
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: duygular.length,
            itemBuilder: (context, i) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Renkler.seciliYuzey,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Renkler.vurgu),
                ),
                child: Text(
                  duygular[i],
                  style: TextStyle(color: Renkler.vurgu, fontSize: 12),
                ),
              );
            },
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Seçilen temaya ait ibretlik hikayeler listelenecek.',
              style: TextStyle(color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }
}
