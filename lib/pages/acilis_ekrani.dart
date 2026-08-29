import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AcilisEkrani extends StatefulWidget {
  const AcilisEkrani({super.key, required this.sonraki});

  final Widget sonraki;

  @override
  State<AcilisEkrani> createState() => _AcilisEkraniState();
}

class _AcilisEkraniState extends State<AcilisEkrani> {
  static const _videoYolu = 'assets/branding/Acilis.mp4';

  VideoPlayerController? _video;
  Timer? _fallback;
  bool _gecti = false;

  @override
  void initState() {
    super.initState();
    _video = VideoPlayerController.asset(_videoYolu)..addListener(_dinle);
    _video!.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      unawaited(_video!.play());
    }).catchError((Object _) {
      // Video yuklenemezse (test ortami vb.) fallback zamanlayici devreye girer.
    });
    _fallback = Timer(const Duration(seconds: 3), _gec);
  }

  void _dinle() {
    final v = _video;
    if (v == null || !v.value.isInitialized) return;
    if (v.value.position >= v.value.duration && v.value.duration > Duration.zero) {
      _gec();
    }
  }

  void _gec() {
    if (_gecti || !mounted) return;
    _gecti = true;
    _fallback?.cancel();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, _, _) => widget.sonraki,
        transitionsBuilder: (_, animasyon, _, cocuk) =>
            FadeTransition(opacity: animasyon, child: cocuk),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _fallback?.cancel();
    _video?.removeListener(_dinle);
    _video?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final video = _video;
    final hazir = video != null && video.value.isInitialized;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _gec,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: Colors.black),
            Center(
              child: hazir
                  ? AspectRatio(
                      aspectRatio: video.value.aspectRatio,
                      child: VideoPlayer(video),
                    )
                  : const CircularProgressIndicator(color: Colors.white),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 48,
              child: IgnorePointer(
                child: Text(
                  'Devam etmek için dokunun',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}