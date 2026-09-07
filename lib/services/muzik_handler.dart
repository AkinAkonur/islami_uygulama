import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import 'medya_kapak.dart';

/// Uygulamadaki tüm ses oynatmanın kalbi: `audio_service` medya oturumu ve
/// kilit ekranı bildirimi için arayüzü uygular. Tek [AudioPlayer] motorudur.
///
/// `AudioService.init` tarafından bir kez oluşturulur ve aktif instance
/// [aktif] üzerinden tüm modüllerin erişebileceği şekilde yayınlanır.
///
/// Döngüsel bağımlılığı kırmak için `stop`, `skipToNext`, `skipToPrevious`
/// eylemleri constructor'da callback olarak verilir.
class MuzikHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _oynatici;
  final Future<void> Function()? onStop;
  final Future<void> Function()? onNext;
  final Future<void> Function()? onPrevious;

  static MuzikHandler? aktif;

  MuzikHandler(
    this._oynatici, {
    this.onStop,
    this.onNext,
    this.onPrevious,
  }) {
    _oynatici.playbackEventStream.listen(_durumYayinla);
  }

  void _durumYayinla(PlaybackEvent _) {
    if (playbackState.isClosed) return;
    final kontroller = <MediaControl>[
      if (_oynatici.playing) MediaControl.pause else MediaControl.play,
      MediaControl.stop,
    ];
    playbackState.add(PlaybackState(
      controls: kontroller,
      systemActions: const {
        MediaAction.seek,
      },
      androidCompactActionIndices: const [0, 1],
      processingState: _cevir(_oynatici.processingState),
      playing: _oynatici.playing,
      updatePosition: _oynatici.position,
      bufferedPosition: _oynatici.bufferedPosition,
      speed: _oynatici.speed,
      queueIndex: 0,
    ));
  }

  AudioProcessingState _cevir(ProcessingState s) {
    switch (s) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
      case ProcessingState.buffering:
        return AudioProcessingState.loading;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }

  void medyaHaber(MediaItem item) {
    if (item.artUri == null && MedyaKapak.uri != null) {
      item = item.copyWith(artUri: MedyaKapak.uri);
    }
    mediaItem.add(item);
  }

  @override
  Future<void> play() => _oynatici.play();

  @override
  Future<void> pause() => _oynatici.pause();

  @override
  Future<void> stop() async {
    await onStop?.call();
  }

  @override
  Future<void> seek(Duration position) => _oynatici.seek(position);

  @override
  Future<void> skipToNext() async {
    await onNext?.call();
  }

  @override
  Future<void> skipToPrevious() async {
    await onPrevious?.call();
  }
}
