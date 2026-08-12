import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'hac_umre_store.dart';
import 'hac_umre_verileri.dart';
import 'ibadet_akis_verileri.dart';

// ===========================================================================
// TAVAF & SA'Y - AKILLI SAYAÇ
// • Ekranın herhangi bir yerine dokunarak artır
// • Her turda kısa titreşim, 7/7'de 3 uzun titreşim (haptic geri bildirim)
// • True Black (OLED) tema: güneş altında okunabilirlik + pil tasarrufu
// • Her şavtta değişen dua (tavaf için), Sa'y için Safa-Merve duası
// ===========================================================================

class SayacSayfasi extends StatefulWidget {
  final SayacTuru tur;

  const SayacSayfasi({super.key, required this.tur});

  @override
  State<SayacSayfasi> createState() => _SayacSayfasiState();
}

class _SayacSayfasiState extends State<SayacSayfasi> {
  int _sira = 0;
  int _toplam = 0;
  bool _yuklendi = false;
  bool _kutlama = false;
  Timer? _kutlamaZamani;

  static const Color _siyah = Color(0xFF000000);

  SayacTuru get tur => widget.tur;

  String get _kayitAnahtari => '${tur.name}_sayaci';

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  @override
  void dispose() {
    _kutlamaZamani?.cancel();
    super.dispose();
  }

  Future<void> _yukle() async {
    final durum = await HacUmreStore.sayacDurumlari();
    if (mounted) {
      setState(() {
        _sira = durum[_kayitAnahtari] ?? 0;
        _yuklendi = true;
      });
    }
  }

  Future<void> _artir() async {
    HapticFeedback.lightImpact();
    final yeni = (_sira + 1);
    if (yeni > tur.hedef) {
      setState(() => _sira = 0);
      await HacUmreStore.sayacKaydet(_kayitAnahtari, 0);
      return;
    }
    setState(() {
      _sira = yeni;
      _toplam++;
    });
    await HacUmreStore.sayacKaydet(_kayitAnahtari, _sira);
    if (_sira == tur.hedef) {
      _kutlamaliTitresim();
    }
  }

  Future<void> _kutlamaliTitresim() async {
    setState(() => _kutlama = true);
    for (var i = 0; i < 3; i++) {
      await HapticFeedback.vibrate();
      await Future.delayed(const Duration(milliseconds: 220));
    }
    _kutlamaZamani = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _kutlama = false);
    });
  }

  Future<void> _onceki() async {
    if (_sira == 0) return;
    HapticFeedback.selectionClick();
    setState(() {
      _sira--;
      _kutlama = false;
    });
    await HacUmreStore.sayacKaydet(_kayitAnahtari, _sira);
  }

  Future<void> _sifirla() async {
    HapticFeedback.mediumImpact();
    setState(() {
      _sira = 0;
      _kutlama = false;
    });
    await HacUmreStore.sayacKaydet(_kayitAnahtari, 0);
  }

  /// Aktif şavta ait dua.
  DuaMetni _aktifDua() {
    if (tur == SayacTuru.say) return sayDuasi;
    final index = _sira.clamp(1, 7) - 1;
    return tavafSekizDualari[index].dua;
  }

  @override
  Widget build(BuildContext context) {
    if (!_yuklendi) {
      return const Scaffold(
        backgroundColor: _siyah,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white24),
        ),
      );
    }
    final tamamlandi = _sira >= tur.hedef;
    final dua = _aktifDua();

    return Scaffold(
      backgroundColor: _siyah,
      appBar: AppBar(
        title: Text('${tur.ad} Sayacı'),
        backgroundColor: _siyah,
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _artir,
        child: SafeArea(
          child: Column(
            children: [
              // Başlık satırı
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
                child: Row(
                  children: [
                    Text(
                      tur == SayacTuru.tavaf
                          ? 'KÂBE TAVAFI'
                          : 'SAFA - MERVE',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Toplam: $_toplam',
                      style: const TextStyle(
                          color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Sayaç
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Column(
                      key: ValueKey(_sira),
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$_sira',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 150,
                            fontWeight: FontWeight.bold,
                            fontFeatures: [FontFeature.tabularFigures()],
                          ),
                        ),
                        Text(
                          tamamlandi
                              ? '${tur.hedef}/${tur.hedef} · Tebrikler! 🕋'
                              : '${_sira} / ${tur.hedef}',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '— EKRANIN HERHANGİ BİR YERİNE DOKUNARAK ARTIR —',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white24,
                            fontSize: 11,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Dua kartı
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimatedOpacity(
                  opacity: 1,
                  duration: const Duration(milliseconds: 300),
                  child: _SiyahDuaKarti(dua: dua, sira: _sira, tur: tur),
                ),
              ),
              const SizedBox(height: 16),
              // Alt kontroller
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white70,
                          side: const BorderSide(color: Colors.white24),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _sira == 0 ? null : _onceki,
                        icon: const Icon(Icons.arrow_back, size: 18),
                        label: const Text('Önceki Şavt'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white70,
                          side: const BorderSide(color: Colors.white24),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _sira == 0 ? null : _sifirla,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: const Text('Sıfırla'),
                      ),
                    ),
                  ],
                ),
              ),
              // Kutlama bandı
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: _kutlama ? 44 : 0,
                color: _kutlama ? const Color(0xFF14301E) : _siyah,
                child: _kutlama
                    ? const Center(
                        child: Text(
                          'Mâşâallah, ibadetin kabul olsun 🤲',
                          style: TextStyle(
                            color: Color(0xFF7EE0A8),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// SİYAH (TRUE BLACK) DUA KARTI
// ===========================================================================
class _SiyahDuaKarti extends StatelessWidget {
  final DuaMetni dua;
  final int sira;
  final SayacTuru tur;

  const _SiyahDuaKarti({
    required this.dua,
    required this.sira,
    required this.tur,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2A2A)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                tur == SayacTuru.tavaf
                    ? Icons.rotate_90_degrees_cw
                    : Icons.swap_horiz,
                color: Colors.white38,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  tur == SayacTuru.tavaf
                      ? '${sira.clamp(1, 7)}. Şavt Duası'
                      : 'Sa\'y Duası',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (dua.kaynak.isNotEmpty)
                Flexible(
                  child: Text(
                    dua.kaynak,
                    textAlign: TextAlign.right,
                    style: const TextStyle(color: Colors.white24, fontSize: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            dua.arapca,
            textAlign: TextAlign.center,
            textDirection: ui.TextDirection.rtl,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            dua.okunus,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '"${dua.meal}"',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
