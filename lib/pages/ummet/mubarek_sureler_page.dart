import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../widgets/kart_sekilleri.dart';
import 'mubarek_sureler_verileri.dart';

/// Mübarek sureler ve dualar sayfası.
///
/// Her kartta Arapça metin, okunuşu (latin/transliterasyon) ve Türkçe manası
/// görüntülenir. Play/Pause butonu, cihazın TTS motoruyla metni sesli okur;
/// internet gerektirmez. Okunuş sekmesi seçiliyken latin metin (Türkçe ses),
/// Arapça sekmesi seçiliyken Arapça metin (Arapça ses) okunur.
class MubarekSurelerPage extends StatefulWidget {
  const MubarekSurelerPage({super.key});

  @override
  State<MubarekSurelerPage> createState() => _MubarekSurelerPageState();
}

class _MubarekSurelerPageState extends State<MubarekSurelerPage> {
  final FlutterTts _tts = FlutterTts();
  final Set<int> _expandedCards = {};
  int? _playingIndex;
  bool _isPlaying = false;
  bool _arapcaOkunus = false;
  String? _ttsHata;

  @override
  void initState() {
    super.initState();
    _ttsKur();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  void _ttsKur() {
    _tts.awaitSpeakCompletion(false);
    _tts.setCompletionHandler(() {
      if (mounted && _isPlaying) {
        setState(() {
          _isPlaying = false;
          _playingIndex = null;
        });
      }
    });
    _tts.setCancelHandler(() {
      if (mounted && _isPlaying) setState(() => _isPlaying = false);
    });
    _tts.setErrorHandler((dynamic msg) {
      if (!mounted) return;
      setState(() {
        _isPlaying = false;
        _playingIndex = null;
        _ttsHata = 'Ses okunamadı: $msg';
      });
    });
  }

  Future<void> _toggleTts(int index, MubarekSureVerisi veri) async {
    if (_playingIndex == index && _isPlaying) {
      await _tts.stop();
      setState(() {
        _isPlaying = false;
        _playingIndex = null;
      });
      return;
    }
    try {
      await _tts.stop();
      final metin = _arapcaOkunus ? veri.arapca : veri.okunus;
      await _tts.setLanguage(_arapcaOkunus ? 'ar' : 'tr-TR');
      await _tts.setSpeechRate(0.5);
      await _tts.speak(metin.replaceAll('\n', ' '));
      setState(() {
        _playingIndex = index;
        _isPlaying = true;
        _ttsHata = null;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$_ttsHata ${e.toString()}'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedCards.contains(index)) {
        _expandedCards.remove(index);
      } else {
        _expandedCards.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        title: Text(
          l.t('ms.title'),
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            _tts.stop();
            Navigator.pop(context);
          },
          icon: const UcdIkon(ikon: Icons.arrow_back_ios_new, renk: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Renkler.bannerUst, Renkler.zemin],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: mubarekSureler.length,
          itemBuilder: (context, index) {
            final veri = mubarekSureler[index];
            final isExpanded = _expandedCards.contains(index);
            final isPlaying = _playingIndex == index && _isPlaying;
            return _kart(index, veri, isExpanded, isPlaying, l);
          },
        ),
      ),
    );
  }

  Widget _kart(
    int index,
    MubarekSureVerisi veri,
    bool isExpanded,
    bool isPlaying,
    AppLocalizations l,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.kart.withValues(alpha: 0.95), Renkler.kart],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPlaying ? Renkler.vurgu.withValues(alpha: 0.6) : Renkler.cerceve,
          width: isPlaying ? 1.5 : 1,
        ),
        boxShadow: isPlaying
            ? [
                BoxShadow(
                  color: Renkler.vurgu.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _toggleExpand(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isPlaying
                          ? Renkler.vurgu.withValues(alpha: 0.2)
                          : Renkler.seciliYuzey,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: UcdIkon(
                        ikon: Icons.auto_stories_rounded,
                        renk: isPlaying ? Renkler.vurgu : Colors.white70,
                        boyut: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          veri.baslik,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          veri.baslikEn,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleTts(index, veri),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: isPlaying
                            ? Renkler.vurgu
                            : Renkler.vurgu.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        boxShadow: isPlaying
                            ? [
                                BoxShadow(
                                  color: Renkler.vurgu.withValues(alpha: 0.4),
                                  blurRadius: 8,
                                ),
                              ]
                            : [],
                      ),
                      child: Icon(
                        isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: isPlaying ? Colors.white : Renkler.vurgu,
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: UcdIkon(
                      ikon: Icons.keyboard_arrow_down_rounded,
                      renk: Colors.white38,
                      boyut: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _genisletilmisIcerik(veri),
            crossFadeState:
                isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _genisletilmisIcerik(MubarekSureVerisi veri) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Renkler.cerceve,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Arapça metin
          _bolumBasligi(Icons.auto_stories_rounded, 'Arapça'),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: SelectableText(
              veri.arapca,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.amberAccent,
                fontSize: 20,
                height: 2.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Okunuş bölümü + TTS modu
          Row(
            children: [
              _bolumBasligi(Icons.record_voice_over_rounded, 'Okunuş'),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  final degisti = !_arapcaOkunus;
                  setState(() {
                    _arapcaOkunus = degisti;
                  });
                  if (_isPlaying && _playingIndex != null) {
                    _toggleTts(_playingIndex!, mubarekSureler[_playingIndex!]);
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Renkler.vurgu.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UcdIkon(
                        ikon: _arapcaOkunus
                            ? Icons.language_rounded
                            : Icons.translate_rounded,
                        renk: Renkler.vurgu,
                        boyut: 14,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _arapcaOkunus ? 'Arapça ses' : 'Türkçe ses',
                        style: TextStyle(
                          color: Renkler.vurgu,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: SelectableText(
              veri.okunus,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.8,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Türkçe mana
          _bolumBasligi(Icons.translate_rounded, 'Türkçe Mana'),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Renkler.vurgu.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: SelectableText(
              veri.mana,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.7,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bolumBasligi(IconData ikon, String metin) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        UcdIkon(ikon: ikon, renk: Renkler.vurgu, boyut: 16),
        const SizedBox(width: 6),
        Text(
          metin,
          style: TextStyle(
            color: Renkler.vurgu,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
