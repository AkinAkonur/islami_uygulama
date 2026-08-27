import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../../widgets/kart_sekilleri.dart';
import 'fikih_verileri.dart';
import 'hac_umre_verileri.dart';

// ===========================================================================
// DEM & FİDYE - FIKIH KARAR AĞACI
// İhram ihlali türüne göre mezhebe uygun cevap veren interaktif karar ağacı.
// Mezhep filtresiyle hükümler kullanıcının seçtiği mezhebe göre gösterilir.
// ===========================================================================

class FikihKararAgaciPage extends StatefulWidget {
  const FikihKararAgaciPage({super.key});

  @override
  State<FikihKararAgaciPage> createState() => _FikihKararAgaciPageState();
}

class _FikihKararAgaciPageState extends State<FikihKararAgaciPage> {
  String _seciliMezhep = mezhepler.first;
  String _aktifId = fikihKok.id;
  FikihSonuc? _sonuc;
  final List<String> _yol = [];

  bool get _kapta => _sonuc != null;

  void _adimSec(FikihSecenegi secenek) {
    final hedef = secenek.altDugumId;
    setState(() {
      _yol.add(secenek.etiket);
      if (hedef != null && fikihSonuclar.containsKey(hedef)) {
        _sonuc = fikihSonuclar[hedef];
        _aktifId = hedef;
      } else if (hedef != null && fikihDugumler.containsKey(hedef)) {
        _aktifId = hedef;
      }
    });
  }

  void _bastanBasla() {
    setState(() {
      _aktifId = fikihKok.id;
      _sonuc = null;
      _yol.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('fka.title')),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: Column(
        children: [
          _MezhepSecici(
            secili: _seciliMezhep,
            onSec: (m) => setState(() => _seciliMezhep = m),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (!_kapta)
                  _SoruKarti(
                    soru: fikihDugumler[_aktifId]!,
                    mezhep: _seciliMezhep,
                    onSec: _adimSec,
                    geri: _yol.isEmpty
                        ? null
                        : () => setState(() => _bastanBasla()),
                    l: l,
                  )
                else
                  _SonucKarti(sonuc: _sonuc!, mezhep: _seciliMezhep, l: l),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Renkler.kart,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: Colors.orangeAccent.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UcdIkon(ikon: Icons.info_outline_rounded,
                          renk: Colors.orangeAccent, boyut: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          fikihUyari,
                          style: TextStyle(
                              color: Colors.white54, fontSize: 11, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_kapta) ...[
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Renkler.vurgu,
                      side: BorderSide(color: Renkler.cerceve),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: _bastanBasla,
                    icon: UcdIkon(ikon: Icons.replay_rounded, renk: Renkler.vurgu),
                    label: Text(l.t('fka.restartBtn')),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// MEZHEP FİLTRESİ
// ===========================================================================
class _MezhepSecici extends StatelessWidget {
  final String secili;
  final ValueChanged<String> onSec;

  const _MezhepSecici({required this.secili, required this.onSec});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Renkler.yuzey,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const UcdIkon(ikon: Icons.filter_alt_rounded,
                renk: Colors.white38, boyut: 18),
            const SizedBox(width: 8),
            for (final m in mezhepler)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(m),
                  selected: m == secili,
                  selectedColor: Renkler.vurgu.withValues(alpha: 0.25),
                  backgroundColor: Renkler.kart,
                  labelStyle: TextStyle(
                    color: m == secili ? Colors.white : Colors.white54,
                    fontWeight:
                        m == secili ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: m == secili
                          ? Renkler.vurgu
                          : Renkler.cerceve,
                    ),
                  ),
                  onSelected: (_) => onSec(m),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// SORU KARTI
// ===========================================================================
class _SoruKarti extends StatelessWidget {
  final FikihDugumu soru;
  final String mezhep;
  final ValueChanged<FikihSecenegi> onSec;
  final VoidCallback? geri;
  final AppLocalizations l;

  const _SoruKarti({
    required this.soru,
    required this.mezhep,
    required this.onSec,
    required this.l,
    this.geri,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Renkler.vurgu.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: UcdIkon(ikon: Icons.account_tree_rounded,
                    renk: Renkler.vurgu, boyut: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.t('fka.decisionTree'),
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l.t('fka.mezhep').replaceFirst('{m}', mezhep),
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (geri != null)
                IconButton(
                  tooltip: l.t('fka.restartBtn'),
                  onPressed: geri,
                  icon: const UcdIkon(ikon: Icons.refresh_rounded, renk: Colors.white38),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            soru.soru,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          if (soru.aciklama != null) ...[
            const SizedBox(height: 8),
            Text(
              soru.aciklama!,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
          const SizedBox(height: 18),
          for (final s in soru.secenekler)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: Renkler.seciliYuzey,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => onSec(s),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        UcdIkon(ikon: Icons.radio_button_unchecked_rounded,
                            renk: Renkler.vurgu, boyut: 18),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            s.etiket,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const UcdIkon(ikon: Icons.chevron_right_rounded,
                            renk: Colors.white38, boyut: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ===========================================================================
// SONUÇ KARTI
// ===========================================================================
class _SonucKarti extends StatelessWidget {
  final FikihSonuc sonuc;
  final String mezhep;
  final AppLocalizations l;

  const _SonucKarti({required this.sonuc, required this.mezhep, required this.l});

  @override
  Widget build(BuildContext context) {
    final hukuk = sonuc.mezhepHukumleri[mezhep] ?? sonuc.ozet;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Renkler.vurgu.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child:
                    const UcdIkon(ikon: Icons.gavel_rounded, renk: Colors.white, boyut: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  sonuc.baslik,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            sonuc.ozet,
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('fka.perMezhep').replaceFirst('{m}', mezhep),
                  style: TextStyle(
                    color: Renkler.acikVurgu,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  hukuk,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l.t('fka.otherSchools'),
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          for (final m in mezhepler)
            if (m != mezhep)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('▸ ', style: TextStyle(color: Colors.white38)),
                    Expanded(
                      child: Text(
                        l.t('fka.schoolView')
                            .replaceFirst('{m}', m)
                            .replaceFirst('{h}', sonuc.mezhepHukumleri[m] ?? sonuc.ozet),
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
          if (sonuc.notlar.isNotEmpty) ...[
            const SizedBox(height: 4),
            for (final n in sonuc.notlar)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const UcdIkon(ikon: Icons.tips_and_updates_rounded,
                        renk: Colors.amberAccent, boyut: 16),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        n,
                        style: const TextStyle(
                            color: Colors.white54, fontSize: 12, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
