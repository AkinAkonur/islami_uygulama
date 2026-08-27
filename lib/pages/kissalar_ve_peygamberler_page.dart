// lib/pages/kissalar_ve_peygamberler_page.dart
// Kıssalar ve Peygamberler ana sayfası: gerçek veri kayıtları üzerinde
// 5 sekme — Peygamberler Tarihi (kronolojik), Kur'an Kıssaları, Siyer-i
// Nebî, Peygamber Duaları Kataloğu ve Tematik Hikayeler. Arama, tüm
// sekmeleri kapsar. Veriler tamamen çevrimdışıdır (KissalarVerileri).

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';
import 'kissalar/dualar_verileri.dart';
import 'kissalar/ibret_verileri.dart';
import 'kissalar/kissa_detay_page.dart';
import 'kissalar/kissa_store.dart';
import 'kissalar/kissalar_verileri.dart';
import 'kissalar/peygamberler_verileri.dart';
import 'kissalar/siyer_verileri.dart';

class KissalarVePeygamberlerPage extends StatefulWidget {
  const KissalarVePeygamberlerPage({super.key});

  @override
  State<KissalarVePeygamberlerPage> createState() =>
      _KissalarVePeygamberlerPageState();
}

class _KissalarVePeygamberlerPageState extends State<KissalarVePeygamberlerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _aramaSorgusu = '';
  String? _seciliTema;

  @override
  void initState() {
    super.initState();
    // Veri kayıt defteri: her kategori yalnızca bir kez kaydedilir.
    peygamberlerKaydet();
    siyerKaydet();
    ibretKaydet();
    KissaStore.yukle();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool get _aramaAktif => _aramaSorgusu.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        title: Text(
          l.t('kp.titleKP'),
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Renkler.vurgu,
          labelColor: Renkler.vurgu,
          unselectedLabelColor: Colors.white54,
          tabs: [
            Tab(text: l.t('kp.tabProphets')),
            Tab(text: l.t('kp.tabQuran')),
            Tab(text: l.t('kp.tabSeerah')),
            Tab(text: l.t('kp.tabDua')),
            Tab(text: l.t('kp.tabThematic')),
          ],
        ),
      ),
      body: Column(
        children: [
          _aramaKutusu(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPeygamberlerTarihi(),
                _buildKuranKissalari(),
                _buildSiyeriNebi(),
                _buildPeygamberDualari(),
                _buildTematikHikayeler(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------- ARAMA -----------------------------

  Widget _aramaKutusu() {
    final l = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      color: Renkler.yuzey,
      child: TextField(
        onChanged: (val) => setState(() => _aramaSorgusu = val),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText:
              l.t('kp.searchHint'),
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
          prefixIcon: const UcdIkon(ikon: Icons.search_rounded, renk: Colors.white54, boyut: 20),
          suffixIcon: _aramaAktif
              ? IconButton(
                  icon: const UcdIkon(ikon: Icons.clear_rounded, renk: Colors.white38, boyut: 20),
                  onPressed: () => setState(() => _aramaSorgusu = ''),
                )
              : null,
          filled: true,
          fillColor: Renkler.kart,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /// Arama sonuçlarını (tüm kategoriler) ortak kart listesiyle gösterir.
  Widget _aramaSonuclari() {
    final sonuclar = KissalarVerileri.ara(_aramaSorgusu);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '${sonuclar.length} sonuç bulundu',
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        const SizedBox(height: 10),
        if (sonuclar.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Aradığınıza uygun içerik bulunamadı.\nFarklı bir sözcük deneyin.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54),
              ),
            ),
          )
        else
          for (final kissa in sonuclar) _kissaKarti(kissa),
      ],
    );
  }

  // ----------------------- 1. PEYGAMBERLER TARİHİ -----------------------

  Widget _buildPeygamberlerTarihi() {
    if (_aramaAktif) return _aramaSonuclari();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoBanner(
          'İnsanlığın hidayet zinciri: Hz. Âdem\'den Hz. Îsâ\'ya kadar '
          'Kur\'an\'da geçen peygamberler kronolojik sırayla. Her kartta '
          'kimlik bilgileri, mucizeler, dualar ve kavimlerin akıbeti bulunur.',
        ),
        for (final grup in peygamberlerKategorisi.gruplar) ...[
          _grupBasligi(grup.ad, grup.aciklama),
          for (var i = 0; i < grup.kisalar.length; i++)
            _kronolojiSatiri(i, grup.kisalar[i], grup.kisalar.length),
        ],
      ],
    );
  }

  /// Kronolojik zaman çizelgesi satırı (numaralı daire + kart).
  Widget _kronolojiSatiri(int index, KissaKaydi kissa, int toplam) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  '${index + 1}',
                  style: TextStyle(
                    color: Renkler.vurgu,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            if (index != toplam - 1)
              Container(width: 2, height: 64, color: Renkler.cerceve),
          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _kissaKarti(kissa, zeminDolu: true),
          ),
        ),
      ],
    );
  }

  // ----------------------- 2. KUR'AN KISSALARI -----------------------

  Widget _buildKuranKissalari() {
    if (_aramaAktif) return _aramaSonuclari();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoBanner(
          'Şahsiyet kıssaları (Hz. Meryem, Lokman, Zülkarneyn, Hızır, '
          'Ashâb-ı Kehf, Karun, Talut-Calut) ve ibretlik olaylar (Habil-Kabil, '
          'Fil Vakası, Ashâb-ı Uhdud, Ashâb-ı Sebt, Ashâb-ı Karye, İrem) '
          'ayet ve hadis destekli olarak burada.',
        ),
        for (final grup in ibretKategorisi.gruplar) ...[
          _grupBasligi(grup.ad, grup.aciklama),
          for (final kissa in grup.kisalar) _kissaKarti(kissa),
        ],
      ],
    );
  }

  // ----------------------- 3. SİYER-İ NEBİ -----------------------

  Widget _buildSiyeriNebi() {
    if (_aramaAktif) return _aramaSonuclari();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoBanner(
          'Hz. Muhammed (s.a.v.)\'in hayatı dönemsel olarak: doğumu, '
          'Mekke ve Medine dönemleri, gazveler, Veda Haccı, Şemail-i Şerif '
          'ile Ehl-i Beyt ve Aşere-i Mübeşşere.',
        ),
        for (final grup in siyerKategorisi.gruplar) ...[
          _grupBasligi(grup.ad, grup.aciklama),
          for (final kissa in grup.kisalar) _kissaKarti(kissa),
        ],
      ],
    );
  }

  // ----------------------- 4. PEYGAMBER DUALARI -----------------------

  Widget _buildPeygamberDualari() {
    final dualar = _aramaAktif
        ? PeygamberDualariVerileri.ara(_aramaSorgusu)
        : PeygamberDualariVerileri.tumu;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _infoBanner(
          'Kur\'an\'da geçen peygamber duaları: Arapça metin, okunuş, meal '
          've hangi durumda okunacağı. Karta dokununca tam detay açılır.',
        ),
        const SizedBox(height: 10),
        for (final dua in dualar) _duaKarti(dua),
      ],
    );
  }

  Widget _duaKarti(PeygamberDuasi dua) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _duaDetayGoster(dua),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
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
              children: [
                Expanded(
                  child: Text(
                    dua.peygamber,
                    style: TextStyle(color: Renkler.vurgu, fontSize: 12),
                  ),
                ),
                Text(
                  dua.kaynak,
                  style: const TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              dua.baslik,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              dua.arapca,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.amberAccent,
                fontSize: 15,
                height: 1.8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              dua.meal,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white60, fontSize: 12.5, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  void _duaDetayGoster(PeygamberDuasi dua) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Renkler.yuzey,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Renkler.cerceve,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                dua.peygamber,
                style: TextStyle(color: Renkler.vurgu, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                dua.baslik,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                dua.arapca,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.amberAccent,
                  fontSize: 21,
                  height: 2,
                ),
              ),
              const SizedBox(height: 12),
              _duaDetaySatir('Okunuşu', dua.okunus),
              _duaDetaySatir('Meali', dua.meal),
              _duaDetaySatir('Ne zaman okunur', dua.durum),
              _duaDetaySatir('Kaynak', dua.kaynak),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Renkler.vurgu,
                    foregroundColor: Colors.black87,
                  ),
                  icon: const UcdIkon(ikon: Icons.copy_rounded, renk: Colors.black87, boyut: 18),
                  label: const Text('Arapça Metni Kopyala'),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: dua.arapca));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Dua metni kopyalandı'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _duaDetaySatir(String baslik, String deger) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            baslik,
            style: TextStyle(color: Renkler.vurgu, fontSize: 12),
          ),
          const SizedBox(height: 3),
          Text(
            deger,
            style: const TextStyle(color: Colors.white70, fontSize: 13.5, height: 1.6),
          ),
        ],
      ),
    );
  }

  // ----------------------- 5. TEMATİK HİKAYELER -----------------------

  Widget _buildTematikHikayeler() {
    final tumTemalar = KissalarVerileri.tumTemalar;
    List<KissaKaydi> liste;
    if (_seciliTema == null) {
      liste = KissalarVerileri.tumKisalar;
    } else {
      liste = KissalarVerileri.temayaGore(_seciliTema!);
    }
    if (_aramaAktif) {
      final sorgu = _aramaSorgusu.trim().toLowerCase();
      liste = [
        for (final k in liste)
          if (k.aramaMetni.contains(sorgu)) k,
      ];
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Bir kavram seçin: Sabır, Adalet, Tevhid, Mucize... Tüm kıssalar '
          'bu temalarla etiketlidir.',
          style: const TextStyle(color: Colors.white54, fontSize: 12.5, height: 1.5),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 46,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _temaChip(null, '✨ Tümü'),
              for (final tema in tumTemalar) _temaChip(tema, tema),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${liste.length} içerik bulundu',
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
        const SizedBox(height: 8),
        if (liste.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                'Bu temaya uygun içerik bulunamadı.',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          )
        else
          for (final kissa in liste) _kissaKarti(kissa),
      ],
    );
  }

  Widget _temaChip(String? tema, String etiket) {
    final secili = _seciliTema == tema;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _seciliTema = tema),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: secili ? Renkler.seciliYuzey : Renkler.kart,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: secili ? Renkler.vurgu : Renkler.cerceve,
            ),
          ),
          child: Center(
            child: Text(
              etiket,
              style: TextStyle(
                color: secili ? Renkler.vurgu : Colors.white70,
                fontSize: 12.5,
                fontWeight: secili ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --------------------------- ORTAK PARÇALAR ---------------------------

  Widget _infoBanner(String metin) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UcdIkon(ikon: Icons.info_outline_rounded, renk: Renkler.vurgu, boyut: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              metin,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _grupBasligi(String ad, String aciklama) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ad,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            aciklama,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// Ortak kıssa kartı. [zeminDolu] kronolojik satırda kart zeminini
  /// kalınlaştırır (timeline bloğu içinde kontrast için).
  Widget _kissaKarti(KissaKaydi kissa, {bool zeminDolu = false}) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KissaDetayPage(kissa: kissa),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Renkler.seciliYuzey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  kissa.emoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          kissa.baslik,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (kissa.donem.isNotEmpty)
                        Text(
                          kissa.donem,
                          style: TextStyle(
                            color: Renkler.vurgu,
                            fontSize: 10.5,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    kissa.ozet,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                  if (kissa.temalar.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (final tema in kissa.temalar)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Renkler.cerceve.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              tema,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Padding(
              padding: EdgeInsets.only(top: 14),
              child: UcdIkon(ikon: Icons.chevron_right_rounded, renk: Colors.white24, boyut: 20),
            ),
          ],
        ),
      ),
    );
  }
}