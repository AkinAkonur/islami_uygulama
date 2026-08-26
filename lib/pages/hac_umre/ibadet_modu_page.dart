import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../services/renkler.dart';
import '../../../widgets/kart_sekilleri.dart';
import 'hac_umre_store.dart';
import 'hac_umre_verileri.dart';
import 'ibadet_akis_verileri.dart';

// ===========================================================================
// İBADET MODU - ADIM ADIM REHBER
// Kullanıcı ibadet türünü seçer, adımları işaretler, her adımda detay kartı
// (ne yapılmalı / dua / sık yapılan hatalar) alt kısımdan kayar.
// ===========================================================================

class IbadetModuPage extends StatefulWidget {
  const IbadetModuPage({super.key});

  @override
  State<IbadetModuPage> createState() => _IbadetModuPageState();
}

class _IbadetModuPageState extends State<IbadetModuPage> {
  IbadetTuru _seciliTur = IbadetTuru.umre;
  Set<String> _tamamlanan = {};

  IbadetAkisi get _akis => ibadetAkilari.firstWhere((a) => a.tur == _seciliTur);

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final set = await HacUmreStore.tamamlananAdimlar(_seciliTur.name);
    if (mounted) setState(() => _tamamlanan = set);
  }

  Future<void> _turSec(IbadetTuru tur) async {
    if (tur == _seciliTur) return;
    setState(() => _seciliTur = tur);
    await _yukle();
  }

  Future<void> _adimTikla(String adimId) async {
    await HacUmreStore.adimTikla(_seciliTur.name, adimId);
    final set = await HacUmreStore.tamamlananAdimlar(_seciliTur.name);
    if (mounted) setState(() => _tamamlanan = set);
  }

  Future<void> _sifirla() async {
    final onay = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Renkler.kart,
        title: const Text(
          'Akışı sıfırla?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Tamamlanan tüm adımlar temizlenecek.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(
              'Vazgeç',
              style: TextStyle(color: Colors.white70),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Sıfırla',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
    if (onay != true) return;
    await HacUmreStore.akisSifirla(_seciliTur.name);
    await _yukle();
  }

  void _adimDetay(IbadetAdimi adim) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Renkler.kart,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (ctx, scrollController) =>
            _AdimDetayKarti(adim: adim, controller: scrollController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final akis = _akis;
    final toplam = akis.adimlar.length;
    final tamam = _tamamlanan.length;
    final ilerleme = toplam == 0 ? 0.0 : tamam / toplam;

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('İbadet Modu'),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: Column(
        children: [
          // İbadet türü seçimi
          SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              scrollDirection: Axis.horizontal,
              itemCount: ibadetAkilari.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final a = ibadetAkilari[index];
                final secili = a.tur == _seciliTur;
                return InkWell(
                  onTap: () => _turSec(a.tur),
                  borderRadius: BorderRadius.circular(16),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 150,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: secili ? Renkler.seciliYuzey : Renkler.kart,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: secili
                            ? Renkler.vurgu.withValues(alpha: 0.6)
                            : Renkler.cerceve,
                        width: secili ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            UcdIkon(
                              ikon: secili
                                  ? Icons.check_circle_rounded
                                  : Icons.radio_button_unchecked_rounded,
                              renk: secili ? Renkler.vurgu : Colors.white38,
                              boyut: 18,
                            ),
                            const Spacer(),
                            Text(
                              a.tur.vakit,
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          a.tur.ad,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          a.baslik,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // İlerleme çubuğu
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: ilerleme,
                      minHeight: 8,
                      backgroundColor: Renkler.cerceve2,
                      valueColor: AlwaysStoppedAnimation(Renkler.vurgu),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '$tamam/$toplam',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                IconButton(
                  tooltip: 'Sıfırla',
                  onPressed: tamam == 0 ? null : _sifirla,
                  icon: const UcdIkon(ikon: Icons.refresh_rounded, renk: Colors.white54),
                ),
              ],
            ),
          ),
          // Giriş notu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Renkler.cerceve),
              ),
              child: Text(
                akis.girisNotu,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Checklist
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              itemCount: akis.adimlar.length,
              itemBuilder: (context, index) {
                final adim = akis.adimlar[index];
                final isaretli = _tamamlanan.contains(adim.id);
                return Card(
                  color: isaretli
                      ? Renkler.seciliYuzey.withValues(alpha: 0.7)
                      : Renkler.kart,
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => _adimDetay(adim),
                    child: ListTile(
                      leading: InkWell(
                        onTap: () => _adimTikla(adim.id),
                        child: UcdIkon(
                          ikon: isaretli
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked_rounded,
                          renk: isaretli ? Colors.greenAccent : Colors.white38,
                          boyut: 26,
                        ),
                      ),
                      title: Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Renkler.vurgu.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Renkler.vurgu,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              adim.baslik,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          adim.kisaAciklama,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      trailing: const UcdIkon(
                        ikon: Icons.expand_less_rounded,
                        renk: Colors.white24,
                        boyut: 18,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// ADIM DETAY KARTI - ekranın altından kayan kart
// ===========================================================================
class _AdimDetayKarti extends StatelessWidget {
  final IbadetAdimi adim;
  final ScrollController controller;

  const _AdimDetayKarti({required this.adim, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            UcdIkon(ikon: Icons.fact_check_rounded, renk: Renkler.vurgu, boyut: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                adim.baslik,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _bolumKart(
            ikon: Icons.task_alt_rounded,
          renk: Colors.lightGreenAccent,
          baslik: 'Ne Yapılmalı?',
          cocuklar: [
            for (final m in adim.neYapilir)
              _madde(sira: adim.neYapilir.indexOf(m) + 1, metin: m),
          ],
        ),
        if (adim.dua != null) ...[
          const SizedBox(height: 12),
          _DuaKarti(dua: adim.dua!),
        ],
        if (adim.sikHatalar.isNotEmpty) ...[
          const SizedBox(height: 12),
          _bolumKart(
            ikon: Icons.warning_amber_rounded,
            renk: Colors.orangeAccent,
            baslik: 'Sık Yapılan Hatalar',
            cocuklar: [
              for (final h in adim.sikHatalar)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '⚠️ ',
                        style: TextStyle(color: Colors.orangeAccent),
                      ),
                      Expanded(
                        child: Text(
                          h,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _madde({required int sira, required String metin}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 1),
            decoration: BoxDecoration(
              color: Colors.lightGreenAccent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$sira',
              style: const TextStyle(
                color: Colors.lightGreenAccent,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              metin,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bolumKart({
    required IconData ikon,
    required Color renk,
    required String baslik,
    required List<Widget> cocuklar,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.yuzey,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: renk.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: ikon, renk: renk, boyut: 18),
              const SizedBox(width: 8),
              Text(
                baslik,
                style: TextStyle(
                  color: renk,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...cocuklar,
        ],
      ),
    );
  }
}

// ===========================================================================
// DUA KARTI (Arapça + okunuş + meal)
// ===========================================================================
class _DuaKarti extends StatelessWidget {
  final DuaMetni dua;

  const _DuaKarti({required this.dua});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const UcdIkon(
                ikon: Icons.volunteer_activism_rounded,
                renk: Colors.white70,
                boyut: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'Okunacak Dua',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              if (dua.kaynak.isNotEmpty)
                Flexible(
                  child: Text(
                    dua.kaynak,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.white54, fontSize: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            dua.arapca,
            textAlign: TextAlign.center,
            textDirection: ui.TextDirection.rtl,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.15)),
          const SizedBox(height: 12),
          Text(
            dua.okunus,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.15)),
          const SizedBox(height: 12),
          Text(
            '"${dua.meal}"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
