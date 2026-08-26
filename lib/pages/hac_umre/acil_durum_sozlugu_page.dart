import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../services/renkler.dart';
import '../../../widgets/kart_sekilleri.dart';
import 'acil_durum_verileri.dart';
import 'hac_umre_verileri.dart';

// ===========================================================================
// ACİL DURUM SÖZLÜĞÜ
// Arapça bilmeyen kullanıcı için sahada gerekli 30 temel cümle.
// "Dinle" butonu cihazın TTS motoruyla Arapçasını yüksek sesle okur
// (internet gerekmez; internet varsa Arapça ses kalitesi artar).
// ===========================================================================

class AcilDurumSozluguPage extends StatefulWidget {
  const AcilDurumSozluguPage({super.key});

  @override
  State<AcilDurumSozluguPage> createState() => _AcilDurumSozluguPageState();
}

class _AcilDurumSozluguPageState extends State<AcilDurumSozluguPage> {
  final FlutterTts _tts = FlutterTts();
  String _kategori = acilKategoriler.first;
  String? _caliyorId;
  String? _ttsHata;

  List<AcilCumle> get _cumleler =>
      acilCumleler.where((c) => c.kategori == _kategori).toList();

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('ar');
    _tts.setSpeechRate(0.45);
    _tts.awaitSpeakCompletion(false);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _dinle(AcilCumle cumle) async {
    if (_caliyorId == cumle.id) {
      await _tts.stop();
      if (mounted) setState(() => _caliyorId = null);
      return;
    }
    try {
      await _tts.stop();
      final sonuc = await _tts.speak(cumle.arapca);
      if (sonuc == 1 || sonuc == 0) {
        if (mounted) {
          setState(() {
            _caliyorId = cumle.id;
            _ttsHata = null;
          });
        }
      } else {
        if (mounted) {
          setState(() => _ttsHata = 'Cihazınızda Arapça ses yok. Kurunuz.');
        }
      }
    } catch (e) {
      if (mounted) setState(() => _ttsHata = 'Ses okunamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Acil Durum Sözlüğü'),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: Column(
        children: [
          // Kategori seçici
          Container(
            color: Renkler.yuzey,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  for (final k in acilKategoriler)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(k),
                        selected: k == _kategori,
                        selectedColor: Renkler.vurgu.withValues(alpha: 0.25),
                        backgroundColor: Renkler.kart,
                        labelStyle: TextStyle(
                          color: k == _kategori ? Colors.white : Colors.white54,
                          fontWeight:
                              k == _kategori ? FontWeight.bold : FontWeight.normal,
                          fontSize: 13,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: k == _kategori
                                ? Renkler.vurgu
                                : Renkler.cerceve,
                          ),
                        ),
                        onSelected: (_) => setState(() {
                          _kategori = k;
                          _caliyorId = null;
                        }),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Not
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Renkler.kart,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UcdIkon(ikon: Icons.info_outline_rounded, renk: Colors.white38, boyut: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      acilSozlukNotu,
                      style: TextStyle(color: Colors.white54, fontSize: 11, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_ttsHata != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Text(
                _ttsHata!,
                style: const TextStyle(color: Colors.orangeAccent, fontSize: 12),
              ),
            ),
          // Liste
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cumleler.length,
              itemBuilder: (context, index) {
                final c = _cumleler[index];
                return _CumleKarti(
                  cumle: c,
                  caliyor: _caliyorId == c.id,
                  onDinle: () => _dinle(c),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CumleKarti extends StatelessWidget {
  final AcilCumle cumle;
  final bool caliyor;
  final VoidCallback onDinle;

  const _CumleKarti({
    required this.cumle,
    required this.caliyor,
    required this.onDinle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: caliyor ? Renkler.seciliYuzey : Renkler.kart,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: caliyor
              ? Renkler.vurgu.withValues(alpha: 0.6)
              : Renkler.cerceve,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    cumle.turkce,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: caliyor ? 'Durdur' : 'Sesli dinle',
                  onPressed: onDinle,
                  style: IconButton.styleFrom(
                    backgroundColor: caliyor
                        ? Renkler.vurgu.withValues(alpha: 0.25)
                        : Colors.white.withValues(alpha: 0.06),
                  ),
                  icon: UcdIkon(
                    ikon: caliyor
                        ? Icons.stop_circle_rounded
                        : Icons.volume_up_rounded,
                    renk: caliyor ? Renkler.vurgu : Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cumle.arapca,
                    textDirection: ui.TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cumle.okunus,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            if (cumle.not.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const UcdIkon(ikon: Icons.tips_and_updates_rounded,
                      renk: Colors.amberAccent, boyut: 15),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      cumle.not,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
