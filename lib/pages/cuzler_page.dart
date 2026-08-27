import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/cuz_hatim_store.dart';
import '../services/kuran_verileri.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';
import 'cuz_okuma_page.dart';
import 'hatim_duasi_page.dart';

/// Ana sayfadaki "Cüz'ler" girişinden açılan sayfa.
/// 30 cüzün tamamı uygulamayla birlikte gelir (assets/cuzler), bu yüzden
/// internet olmadan da okunabilir. Cüzlerin okunma durumu cihazda saklanır
/// ve yeşil onay ile gösterilir.
class CuzlerPage extends StatefulWidget {
  const CuzlerPage({super.key});

  @override
  State<CuzlerPage> createState() => _CuzlerPageState();
}

class _CuzlerPageState extends State<CuzlerPage> {
  List<bool> _okundu = List.filled(30, false);
  bool _yuklendi = false;

  @override
  void initState() {
    super.initState();
    _durumlariOku();
  }

  Future<void> _durumlariOku() async {
    final durum = await CuzHatimStore.oku();
    if (!mounted) return;
    setState(() {
      _okundu = durum;
      _yuklendi = true;
    });
  }

  Future<void> _cuzuAc(int cuzNo) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CuzOkumaPage(cuzNo: cuzNo)),
    );
    await _durumlariOku();
  }

  void _hatimDuasiAc() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HatimDuasiPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final okunan = _okundu.where((e) => e).length;

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('h.cuzler'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Hatim Duası',
            onPressed: _hatimDuasiAc,
            icon: UcdIkon(
              ikon: Icons.auto_stories_rounded,
              renk: Renkler.vurgu,
            ),
          ),
        ],
      ),
      body: _yuklendi
          ? _icerik(okunan)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _icerik(int okunan) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _ilerlemeKarti(okunan),
        const SizedBox(height: 16),
        for (var i = 0; i < 30; i++) _cuzKarti(i + 1),
      ],
    );
  }

  Widget _ilerlemeKarti(int okunan) {
    final oran = okunan / 30;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Hatim İlerlemesi',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$okunan / 30',
                style: TextStyle(color: Renkler.acikVurgu, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: oran,
              minHeight: 8,
              backgroundColor: Colors.white12,
              valueColor: AlwaysStoppedAnimation(Renkler.vurgu),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            okunan == 0
                ? 'Bir cüzü okuduğunda okundu olarak işaretleyebilirsin.'
                : okunan == 30
                ? 'Tebrikler! Tüm cüzleri okudun.'
                : '${30 - okunan} cüz kaldı. Kolay gelsin.',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Renkler.vurgu.withValues(alpha: 0.6)),
              ),
              onPressed: _hatimDuasiAc,
              icon: const UcdIkon(
                ikon: Icons.auto_stories_rounded,
                renk: Colors.white,
                boyut: 18,
              ),
              label: const Text('Hatim Duası'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cuzKarti(int cuzNo) {
    final okundu = _okundu[cuzNo - 1];
    final amme = cuzNo == 30;
    return Card(
      color: okundu ? Renkler.seciliYuzey : Renkler.kart,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: okundu
              ? Renkler.vurgu
              : amme
              ? Renkler.vurgu.withValues(alpha: 0.4)
              : Renkler.cerceve,
        ),
      ),
      child: ListTile(
        onTap: () => _cuzuAc(cuzNo),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Renkler.yuzey,
            shape: BoxShape.circle,
            border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
          ),
          alignment: Alignment.center,
          child: Text(
            '$cuzNo',
            style: TextStyle(
              color: Renkler.vurgu,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        title: Text(
          '$cuzNo. Cüz',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          (cuzBaslangic[cuzNo] ?? '') + (amme ? ' (Amme)' : ''),
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (okundu)
              const Tooltip(
                message: 'Okundu',
                child: UcdIkon(
                  ikon: Icons.check_circle_rounded,
                  renk: Colors.greenAccent,
                ),
              )
            else
              const UcdIkon(ikon: Icons.circle_outlined, renk: Colors.white24),
            const SizedBox(width: 6),
            UcdIkon(ikon: Icons.chevron_right, renk: Colors.white38, boyut: 20),
          ],
        ),
      ),
    );
  }
}
