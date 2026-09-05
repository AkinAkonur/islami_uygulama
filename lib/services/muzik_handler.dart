import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import 'medya_kapak.dart';
import 'radyo_oynatici_store.dart';

/// Uygulamadaki tüm ses oynatmanın kalbi: `audio_service` medya oturumu ve
/// kilit ekranı bildirimi için arayüzü uygular. Tek [AudioPlayer] motorudur.
///
/// `AudioService.init` tarafından bir kez oluşturulur ve aktif instance
/// [aktif] üzerinden tüm modüllerin erişebileceği şekilde yayınlanır.
class MuzikHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _oynatici;

  /// İlk initialize edilen handler; UI katmanı MediaItem güncellemek için kullanır.
  static MuzikHandler? aktif;

  MuzikHandler(this._oynatici) {
    _oynatici.playbackEventStream.listen(_durumYayinla);
  }

  /// just_audio olaylarını media session'a aktarır (kilit ekranı durumu).
  void _durumYayinla(PlaybackEvent _) {
    if (playbackState.isClosed) return;
    final kontroller = <MediaControl>[
      MediaControl.skipToPrevious,
      if (_oynatici.playing) MediaControl.pause else MediaControl.play,
      MediaControl.skipToNext,
      MediaControl.stop,
    ];
    playbackState.add(PlaybackState(
      controls: kontroller,
      systemActions: const {
        MediaAction.seek,
      },
      // Kilit ekranı/çekmecedeki kısa kart: önceki - oynat/duraklat - sonraki.
      androidCompactActionIndices: const [0, 1, 2],
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

  /// Yeni "çalınan medya" bilgisini yayınlar (başlık, alt yazı, kapak).
  /// Kapak belirtilmemişse ortak [MedyaKapak] görseli otomatik enjekte edilir.
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
  Future<void> stop() => RadyoOynaticiStore.durdur();

  @override
  Future<void> seek(Duration position) => _oynatici.seek(position);

  @override
  Future<void> skipToNext() => RadyoOynaticiStore.sonraki();

  @override
  Future<void> skipToPrevious() => RadyoOynaticiStore.onceki();
}