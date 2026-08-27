import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../widgets/kart_sekilleri.dart';
import 'ozel_sureler_verileri.dart';

class OzelSurelerPage extends StatefulWidget {
  const OzelSurelerPage({super.key});

  @override
  State<OzelSurelerPage> createState() => _OzelSurelerPageState();
}

class _OzelSurelerPageState extends State<OzelSurelerPage> {
  final AudioPlayer _player = AudioPlayer();
  int? _playingIndex;
  bool _isPlaying = false;
  final Set<int> _expandedCards = {};

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggleAudio(int index, OzelSureVerisi sure) async {
    if (sure.audioUrl.isEmpty) return;
    if (_playingIndex == index && _isPlaying) {
      await _player.pause();
      setState(() => _isPlaying = false);
    } else if (_playingIndex == index && !_isPlaying) {
      await _player.play();
      setState(() => _isPlaying = true);
    } else {
      await _player.stop();
      try {
        await _player.setUrl(sure.audioUrl);
        await _player.play();
        setState(() {
          _playingIndex = index;
          _isPlaying = true;
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Ses yüklenemedi: $e'),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
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
          l.t('oz.title'),
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            _player.stop();
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
          itemCount: ozelSureler.length,
          itemBuilder: (context, index) {
            final sure = ozelSureler[index];
            final isExpanded = _expandedCards.contains(index);
            final isCurrentlyPlaying = _playingIndex == index && _isPlaying;
            return _sureKarti(index, sure, isExpanded, isCurrentlyPlaying, l);
          },
        ),
      ),
    );
  }

  Widget _sureKarti(int index, OzelSureVerisi sure, bool isExpanded, bool isPlaying, AppLocalizations l) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Renkler.kart.withValues(alpha: 0.95),
            Renkler.kart,
          ],
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
          // Başlık + Play/Pause satırı
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _toggleExpand(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  //adge/ikon
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
                      child: Text(
                        sure.isSure ? '${sure.sureNo}' : '🤲',
                        style: TextStyle(
                          color: isPlaying ? Renkler.vurgu : Colors.white70,
                          fontSize: sure.isSure ? 16 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Başlık
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sure.baslik,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          sure.baslikEn,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Play/Pause butonu
                  if (sure.audioUrl.isNotEmpty)
                    GestureDetector(
                      onTap: () => _toggleAudio(index, sure),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: isPlaying ? Renkler.vurgu : Renkler.vurgu.withValues(alpha: 0.15),
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
                          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: isPlaying ? Colors.white : Renkler.vurgu,
                          size: 26,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  // Expand ikonu
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
          // Genişletilmiş içerik (Arapça + Meal)
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _expandedContent(sure),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _expandedContent(OzelSureVerisi sure) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ayırıcı
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

          // Arapça metin başlığı
          Row(
            children: [
              UcdIkon(ikon: Icons.auto_stories_rounded, renk: Renkler.vurgu, boyut: 16),
              const SizedBox(width: 6),
              Text(
                'Arapça',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Arapça metin
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: SelectableText(
              sure.arapca,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.amberAccent,
                fontSize: 22,
                height: 2.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Türkçe meal başlığı
          Row(
            children: [
              UcdIkon(ikon: Icons.translate_rounded, renk: Renkler.vurgu, boyut: 16),
              const SizedBox(width: 6),
              Text(
                'Türkçe Meal',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Türkçe meal
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: SelectableText(
              sure.mealTr,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.7,
              ),
            ),
          ),

          // Sure detay badge
          if (sure.sureNo != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                _badge('Sure ${sure.sureNo}'),
                if (sure.ayetBaslangic != null) ...[
                  const SizedBox(width: 8),
                  _badge('Ayet ${sure.ayetBaslangic}${sure.ayetBitis != null ? '-${sure.ayetBitis}' : ''}'),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Renkler.vurgu.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Renkler.vurgu,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
