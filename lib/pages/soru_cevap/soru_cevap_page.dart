// lib/pages/soru_cevap/soru_cevap_page.dart
// Soru-Cevap (Fetva) modülü — üç deneyimi tek veriden besler:
//   1. Bilgi Bankası: kategorize edilmiş SSS, akordeon tasarım + kaynak.
//   2. Bilgi Testleri: seviyeli quiz + rozetler (oyunlaştırma).
//   3. Günün Sorusu: günde bir değişen flashcard (soru → cevap + ayet).
// Veriler tamamen çevrimdışı gömülüdür (SoruCevapVerileri).

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/renkler.dart';
import '../../widgets/kart_sekilleri.dart';
import 'soru_cevap_model.dart';
import 'soru_cevap_store.dart';
import 'soru_cevap_verileri.dart';

class SoruCevapPage extends StatefulWidget {
  final int baslangicSekme;

  const SoruCevapPage({super.key, this.baslangicSekme = 0});

  @override
  State<SoruCevapPage> createState() => _SoruCevapPageState();
}

class _SoruCevapPageState extends State<SoruCevapPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    SoruCevapStore.yukle();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.baslangicSekme.clamp(0, 2),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        title: const Text(
          'Soru-Cevap (Fetva)',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Renkler.vurgu,
          labelColor: Renkler.vurgu,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: '📚 Bilgi Bankası'),
            Tab(text: '🎯 Bilgi Testleri'),
            Tab(text: '📅 Günün Sorusu'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [_BilgiBankasi(), _BilgiTestleri(), _GununSorusu()],
      ),
    );
  }
}

// ===========================================================================
// 1. BİLGİ BANKASI — Akordeon SSS
// ===========================================================================
class _BilgiBankasi extends StatefulWidget {
  const _BilgiBankasi();

  @override
  State<_BilgiBankasi> createState() => _BilgiBankasiState();
}

class _BilgiBankasiState extends State<_BilgiBankasi> {
  String _arama = '';
  String? _seciliKategori;

  @override
  Widget build(BuildContext context) {
    final aramaAktif = _arama.trim().isNotEmpty;

    List<SoruCevapSorusu> liste;
    if (aramaAktif) {
      liste = SoruCevapVerileri.ara(_arama);
    } else if (_seciliKategori != null) {
      liste = SoruCevapVerileri.kategoriyeGore(_seciliKategori!);
    } else {
      liste = SoruCevapVerileri.tumSorular;
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: Renkler.yuzey,
          child: Column(
            children: [
              TextField(
                onChanged: (val) => setState(() => _arama = val),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Soru, kavram veya ayet arayın...',
                  hintStyle: const TextStyle(
                    color: Colors.white38,
                    fontSize: 13,
                  ),
                  prefixIcon: const UcdIkon(ikon: Icons.search_rounded, renk: Colors.white54, boyut: 20),
                  suffixIcon: aramaAktif
                      ? IconButton(
                          icon: const UcdIkon(ikon: Icons.clear_rounded, renk: Colors.white38, boyut: 20),
                          onPressed: () => setState(() => _arama = ''),
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
              if (!aramaAktif) ...[
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _kategoriChip(null, '✨ Tümü'),
                      for (final k in SoruCevapVerileri.kategoriler)
                        _kategoriChip(k.ad, '${k.emoji} ${k.ad}'),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (!aramaAktif)
                _infoBanner(
                  'Günlük hayata ve Kur\'an kıssalarına dair merak edilenler. '
                  'Bir soruya dokunun; cevabı ve kaynağı aynı yerde açılır.',
                ),
              if (aramaAktif)
                Text(
                  '${liste.length} sonuç bulundu',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              const SizedBox(height: 10),
              if (liste.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      'Aradığınıza uygun soru bulunamadı.\nFarklı bir sözcük deneyin.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54),
                    ),
                  ),
                )
              else
                for (final soru in liste) _FaqKarti(soru: soru),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kategoriChip(String? kategori, String etiket) {
    final secili = _seciliKategori == kategori;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _seciliKategori = kategori),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: secili ? Renkler.seciliYuzey : Renkler.kart,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: secili ? Renkler.vurgu : Renkler.cerceve),
          ),
          child: Center(
            child: Text(
              etiket,
              style: TextStyle(
                color: secili ? Renkler.vurgu : Colors.white70,
                fontSize: 12,
                fontWeight: secili ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

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
}

/// Tek soru akordeon kartı (genişleyen cevap + kaynak).
class _FaqKarti extends StatefulWidget {
  final SoruCevapSorusu soru;

  const _FaqKarti({required this.soru});

  @override
  State<_FaqKarti> createState() => _FaqKartiState();
}

class _FaqKartiState extends State<_FaqKarti> {
  bool _acik = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.soru;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _acik ? Renkler.vurgu : Renkler.cerceve),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _acik = !_acik),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _seviyeEtiketi(s),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      s.soru,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  AnimatedRotation(
                    turns: _acik ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: UcdIkon(
                      ikon: Icons.expand_more_rounded,
                      renk: _acik ? Renkler.vurgu : Colors.white38,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: _acik
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Renkler.cerceve,
                          margin: const EdgeInsets.only(bottom: 12),
                        ),
                        Text(
                          s.cevap,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13.5,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => _kaynakGoster(context, s),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Renkler.seciliYuzey.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UcdIkon(
                                  ikon: Icons.menu_book_rounded,
                                  renk: Renkler.vurgu,
                                  boyut: 14,
                                ),
                                const SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    s.kaynak,
                                    style: TextStyle(
                                      color: Renkler.vurgu,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }

  Widget _seviyeEtiketi(SoruCevapSorusu s) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Renkler.zemin,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${s.seviyeEmoji} ${s.seviyeAdi}',
        style: const TextStyle(color: Colors.white54, fontSize: 10),
      ),
    );
  }

  void _kaynakGoster(BuildContext context, SoruCevapSorusu s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Renkler.yuzey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '📚 Kaynak',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              s.kaynak,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            if (s.ilgiliAyet != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Renkler.kart,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  s.ilgiliAyet!,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 12.5,
                    height: 1.6,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Text(
              'Bu içerik; Diyanet İşleri Başkanlığı ilmihal ve fetvaları, '
              'Kur\'an meali ile Sahih-i Buhari ve Sahih-i Müslim gibi hadis '
              'kaynakları esas alınarak hazırlanmıştır.',
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 11,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// 2. BİLGİ TESTLERİ — Seviyeli quiz + rozetler
// ===========================================================================
class _BilgiTestleri extends StatelessWidget {
  const _BilgiTestleri();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: SoruCevapStore.toplamDogru,
      builder: (context, dogru, _) => ValueListenableBuilder<int>(
        valueListenable: SoruCevapStore.toplamYanit,
        builder: (context, yanit, _) =>
            _TestIcerigi(dogru: dogru, yanit: yanit),
      ),
    );
  }
}

class _TestIcerigi extends StatefulWidget {
  final int dogru;
  final int yanit;

  const _TestIcerigi({required this.dogru, required this.yanit});

  @override
  State<_TestIcerigi> createState() => _TestIcerigiState();
}

class _TestIcerigiState extends State<_TestIcerigi> {
  SoruSeviyesi _seviye = SoruSeviyesi.kolay;
  final Set<String> _acikKartlar = {};

  @override
  Widget build(BuildContext context) {
    final sorular = SoruCevapVerileri.seviyeyeGore(_seviye);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _rozetKartlari(widget.dogru),
        const SizedBox(height: 14),
        Text(
          'Seviye seçin ve soruları çözün. Doğru cevapladıkça rozet kazanırsınız.',
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final seviye in SoruSeviyesi.values) _seviyeChip(seviye),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          '${sorular.length} soru · ${_seviyeEtiket(_seviye)}',
          style: const TextStyle(color: Colors.white38, fontSize: 11),
        ),
        const SizedBox(height: 8),
        for (final soru in sorular)
          _TestSoruKarti(
            soru: soru,
            acik: _acikKartlar.contains(soru.id),
            onToggle: (acik) => setState(
              () => acik
                  ? _acikKartlar.add(soru.id)
                  : _acikKartlar.remove(soru.id),
            ),
          ),
      ],
    );
  }

  Widget _seviyeChip(SoruSeviyesi seviye) {
    final secili = _seviye == seviye;
    final etiket = switch (seviye) {
      SoruSeviyesi.kolay => '🌱 Başlangıç',
      SoruSeviyesi.orta => '⭐ Orta',
      SoruSeviyesi.zor => '🔥 İleri',
    };
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _seviye = seviye),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: secili ? Renkler.seciliYuzey : Renkler.kart,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: secili ? Renkler.vurgu : Renkler.cerceve),
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

  String _seviyeEtiket(SoruSeviyesi seviye) => switch (seviye) {
    SoruSeviyesi.kolay => 'Başlangıç seviyesi',
    SoruSeviyesi.orta => 'Orta seviye',
    SoruSeviyesi.zor => 'İleri seviye',
  };

  Widget _rozetKartlari(int dogru) {
    final kazananlar = SoruCevapStore.kazanilanRozetler;
    final kalan = SoruCevapStore.sonrakiRozetIcinKalan();
    return Container(
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
              UcdIkon(ikon: Icons.emoji_events_rounded, renk: Renkler.vurgu, boyut: 20),
              const SizedBox(width: 8),
              const Text(
                'Rozetlerim',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const Spacer(),
              Text(
                '$dogru doğru · ${widget.yanit} yanıt',
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (kazananlar.isEmpty)
            Text(
              kalan > 0
                  ? 'Henüz rozet yok. Sonraki rozet için $kalan doğru cevap daha gerekiyor.'
                  : 'Tüm rozetleri kazandınız!',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final r in kazananlar)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Renkler.seciliYuzey.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Renkler.vurgu),
                    ),
                    child: Text(
                      '${r.emoji} ${r.ad}',
                      style: TextStyle(
                        color: Renkler.vurgu,
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          if (kazananlar.isNotEmpty && kalan > 0) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: (dogru % 30) / 30,
                minHeight: 6,
                backgroundColor: Renkler.zemin,
                color: Renkler.vurgu,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Sonraki rozet: $kalan doğru kaldı',
              style: const TextStyle(color: Colors.white38, fontSize: 10.5),
            ),
          ],
        ],
      ),
    );
  }
}

/// Şıklı test sorusu kartı. Cevap verilince açıklama ve kaynak açılır.
class _TestSoruKarti extends StatefulWidget {
  final SoruCevapSorusu soru;
  final bool acik;
  final ValueChanged<bool> onToggle;

  const _TestSoruKarti({
    required this.soru,
    required this.acik,
    required this.onToggle,
  });

  @override
  State<_TestSoruKarti> createState() => _TestSoruKartiState();
}

class _TestSoruKartiState extends State<_TestSoruKarti> {
  int? _secim;

  @override
  Widget build(BuildContext context) {
    final s = widget.soru;
    final cevaplandi = _secim != null;
    final dogru = cevaplandi && _secim == s.dogruIndex;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: cevaplandi
              ? (dogru ? const Color(0xFF66BB6A) : const Color(0xFFE57373))
              : Renkler.cerceve,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        s.soru,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Renkler.zemin,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        s.seviyeEmoji,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (s.secenekler != null)
                  for (var i = 0; i < s.secenekler!.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: cevaplandi
                            ? null
                            : () {
                                setState(() => _secim = i);
                                SoruCevapStore.cevapKaydet(
                                  s,
                                  i == s.dogruIndex,
                                );
                              },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color:
                                cevaplandi && i == _secim && i != s.dogruIndex
                                ? const Color(0xFF7B3B3B)
                                : Renkler.zemin,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: cevaplandi && i == s.dogruIndex
                                  ? const Color(0xFF66BB6A)
                                  : cevaplandi && i == _secim
                                  ? const Color(0xFFE57373)
                                  : Renkler.cerceve,
                            ),
                          ),
                          child: Row(
                            children: [
                              UcdIkon(
                                ikon: cevaplandi && i == s.dogruIndex
                                    ? Icons.check_circle_rounded
                                    : cevaplandi && i == _secim
                                    ? Icons.cancel_rounded
                                    : Icons.radio_button_unchecked_rounded,
                                renk: cevaplandi && i == s.dogruIndex
                                    ? const Color(0xFF66BB6A)
                                    : Colors.white38,
                                boyut: 18,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  s.secenekler![i],
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                if (cevaplandi) ...[
                  const SizedBox(height: 4),
                  Text(
                    dogru
                        ? '✅ Doğru!'
                        : '❌ Yanlış. Doğru cevap: ${s.secenekler![s.dogruIndex!]}',
                    style: TextStyle(
                      color: dogru
                          ? const Color(0xFF66BB6A)
                          : const Color(0xFFE57373),
                      fontSize: 12.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => widget.onToggle(!widget.acik),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UcdIkon(
                          ikon: widget.acik ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          renk: Renkler.vurgu,
                          boyut: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.acik ? 'Açıklamayı gizle' : 'Açıklamayı gör',
                          style: TextStyle(
                            color: Renkler.vurgu,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: widget.acik
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Renkler.cerceve,
                          margin: const EdgeInsets.only(bottom: 12),
                        ),
                        Text(
                          s.cevap,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12.5,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            UcdIkon(
                              ikon: Icons.menu_book_rounded,
                              renk: Renkler.vurgu,
                              boyut: 14,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                s.kaynak,
                                style: TextStyle(
                                  color: Renkler.vurgu,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// 3. GÜNÜN SORUSU — Flashcard
// ===========================================================================
class _GununSorusu extends StatefulWidget {
  const _GununSorusu();

  @override
  State<_GununSorusu> createState() => _GununSorusuState();
}

class _GununSorusuState extends State<_GununSorusu> {
  late final SoruCevapSorusu _soru = SoruCevapVerileri.gununSorusu();
  bool _cevir = false;
  int? _secim;

  @override
  void initState() {
    super.initState();
    SoruCevapStore.gunlukCevaplandi.addListener(_cevaplandiDegisti);
  }

  @override
  void dispose() {
    SoruCevapStore.gunlukCevaplandi.removeListener(_cevaplandiDegisti);
    super.dispose();
  }

  void _cevaplandiDegisti() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Renkler.seciliYuzey.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Renkler.cerceve),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UcdIkon(ikon: Icons.event_available_rounded, renk: Renkler.vurgu, boyut: 18),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Her gün tek bir soru. Önce düşünün, sonra cevabı ve '
                  'ilgili ayeti açın. Günde bir kez doğru cevap puanınızı artırır.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _flashcard(),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: SoruCevapStore.gunlukCevaplandi,
          builder: (context, cevaplandi, _) => _durumSatiri(cevaplandi),
        ),
      ],
    );
  }

  Widget _flashcard() {
    final cevaplandi = SoruCevapStore.gunlukCevaplandi.value;
    final quizVar = _soru.quizVar;

    return GestureDetector(
      onTap: () => setState(() => _cevir = !_cevir),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) {
          return FadeTransition(
            opacity: anim,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.96, end: 1).animate(anim),
              child: child,
            ),
          );
        },
        child: _cevir ? _kartArkaYuz() : _kartOnYuz(quizVar, cevaplandi),
      ),
    );
  }

  Widget _kartOnYuz(bool quizVar, bool cevaplandi) {
    return Container(
      key: const ValueKey('on'),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Renkler.vurgu.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '📅 Günün Sorusu',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              if (cevaplandi)
                const Text(
                  '✓',
                  style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _soru.soru,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.5,
            ),
          ),
          if (quizVar && !cevaplandi) ...[
            const SizedBox(height: 16),
            const Text(
              'Cevabınızı düşünün, sonra karta dokunarak açın.',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
          const SizedBox(height: 20),
          UcdIkon(ikon: Icons.touch_app_rounded, renk: Colors.white70, boyut: 22),
          const SizedBox(height: 6),
          const Text(
            'Cevabı görmek için dokunun',
            style: TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _kartArkaYuz() {
    final s = _soru;
    return Container(
      key: const ValueKey('arka'),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Renkler.vurgu),
      ),
      child: Column(
        children: [
          const Text(
            '💡 Cevap',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            s.cevap,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.7,
            ),
          ),
          if (s.ilgiliAyet != null) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.zemin,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.ilgiliAyet!,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12.5,
                      height: 1.6,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              UcdIkon(ikon: Icons.menu_book_rounded, renk: Renkler.vurgu, boyut: 14),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  s.kaynak,
                  style: TextStyle(
                    color: Renkler.vurgu,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Karta dokunun: soruya dönün',
            style: TextStyle(color: Colors.white38, fontSize: 10.5),
          ),
        ],
      ),
    );
  }

  Widget _durumSatiri(bool cevaplandi) {
    final s = _soru;
    return Column(
      children: [
        if (cevaplandi)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1B3B2A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF66BB6A)),
            ),
            child: const Row(
              children: [
                UcdIkon(ikon: Icons.check_circle_rounded, renk: const Color(0xFF66BB6A), boyut: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Bugünün sorusunu cevapladınız. Yarın yeni bir soru sizi bekliyor.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ],
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '📋 Bu soru aynı zamanda Bilgi Testleri\'nde de var.',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
                const SizedBox(height: 8),
                if (s.secenekler != null) ...[
                  const Text(
                    'Şıklardan cevaplamak ister misiniz?',
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (var i = 0; i < s.secenekler!.length; i++)
                        GestureDetector(
                          onTap: _secim != null
                              ? null
                              : () async {
                                  setState(() => _secim = i);
                                  await SoruCevapStore.cevapKaydet(
                                    s,
                                    i == s.dogruIndex,
                                  );
                                  if (i == s.dogruIndex) {
                                    await SoruCevapStore.gunlukIsaretle();
                                  }
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _secim == i
                                  ? (i == s.dogruIndex
                                        ? const Color(0xFF2E5B3E)
                                        : const Color(0xFF7B3B3B))
                                  : Renkler.zemin,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _secim == i
                                    ? (i == s.dogruIndex
                                          ? const Color(0xFF66BB6A)
                                          : const Color(0xFFE57373))
                                    : Renkler.cerceve,
                              ),
                            ),
                            child: Text(
                              s.secenekler![i],
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (_secim != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      _secim == s.dogruIndex
                          ? '✅ Doğru cevapladınız! Açıklamayı görmek için karta dokunun.'
                          : '❌ Doğru cevap: ${s.secenekler![s.dogruIndex!]}. Açıklama için karta dokunun.',
                      style: TextStyle(
                        color: _secim == s.dogruIndex
                            ? const Color(0xFF66BB6A)
                            : const Color(0xFFE57373),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ] else
                  const Text(
                    'Karta dokunarak cevabı açabilirsiniz.',
                    style: TextStyle(color: Colors.white54, fontSize: 11),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Renkler.vurgu,
              side: BorderSide(color: Renkler.vurgu.withValues(alpha: 0.6)),
            ),
            icon: UcdIkon(ikon: Icons.share_rounded, renk: Renkler.vurgu, boyut: 16),
            label: const Text('Bu soruyu paylaş'),
            onPressed: () {
              Clipboard.setData(
                ClipboardData(
                  text:
                      '📅 Günün Sorusu\n\n${_soru.soru}\n\n${_soru.cevap}\n\nKaynak: ${_soru.kaynak}',
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Soru metni kopyalandı'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
