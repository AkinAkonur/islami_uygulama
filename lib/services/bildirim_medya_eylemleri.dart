import 'package:flutter/foundation.dart';

import 'muzik_handler.dart';
import 'radyo_oynatici_store.dart';

/// Bildirim penceresindeki 3D çal / duraklat / durdur düğmelerinin
/// karşılığını uygular.
///
/// `flutter_local_notifications` bir eylem düğmesine basıldığında yalnızca
/// `actionId` döndürür; bu sınıf o kimliği uygulamanın ses motoruna
/// ([MuzikHandler] → `just_audio`) çevirir. Böylece bildirimdeki ikonlar
/// gerçekten çalışır: dokunulduğunda ses başlar, duraklar veya durur.
class BildirimMedyaEylemleri {
  BildirimMedyaEylemleri._();

  static const String cal = 'medya_cal';
  static const String duraklat = 'medya_duraklat';
  static const String durdur = 'medya_durdur';

  /// Eylem kimliği bu sınıfa ait mi?
  static bool tanir(String? actionId) =>
      actionId == cal || actionId == duraklat || actionId == durdur;

  /// Bildirimden gelen eylemi uygular. Bilinmeyen kimlikleri yok sayar.
  static Future<void> isle(String? actionId) async {
    final handler = MuzikHandler.aktif;
    try {
      switch (actionId) {
        case cal:
          if (handler != null) {
            await handler.play();
          } else {
            await RadyoOynaticiStore.player.play();
          }
          break;
        case duraklat:
          if (handler != null) {
            await handler.pause();
          } else {
            await RadyoOynaticiStore.player.pause();
          }
          break;
        case durdur:
          if (handler != null) {
            await handler.stop();
          } else {
            await RadyoOynaticiStore.durdur();
          }
          break;
        default:
          return;
      }
    } catch (e) {
      debugPrint('[Bildirim] medya eylemi ($actionId) uygulanamadı: $e');
    }
  }
}
