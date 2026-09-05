import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Medya bildirimindeki kapak görselini (artwork) sağlar.
///
/// audio_service artwork'ü yalnızca gerçek bir dosya yolu (`file://`) veya
/// ağ URL'si olarak yükler; Flutter asset'i (`asset://`) desteklemez. Bu yüzden
/// paket içindeki PNG, uygulama ilk açılışta kendi dizinine kopyalanır ve
/// `uri` üzerinden bildirim kartına verilir.
class MedyaKapak {
  MedyaKapak._();

  /// Paketteki altın çerçeveli kapak görseli (çekmece/kilit ekranı kartında
  /// 3D zümrüt-altın görünümü veren artwork).
  static const String _assetYol = 'assets/gorseller/medya_kapak_bildirim.jpg';

  static Uri? _uri;

  /// Bildirim artwork'ü olarak kullanılacak dosya URI'si; hazırlanamadıysa null.
  static Uri? get uri => _uri;

  /// Paketteki kapak görselini uygulama dizinine kopyalar ve [uri]'yi hazırlar.
  /// Başarısız olursa null kalır; bildirim yine de varsayılan ikonla çalışır.
  static Future<void> hazirla() async {
    try {
      final veri = await rootBundle.load(_assetYol);
      final dizin = await getApplicationSupportDirectory();
      final dosya = File('${dizin.path}/medya_kapak_bildirim.jpg');
      if (!await dosya.exists()) {
        await dosya.writeAsBytes(veri.buffer.asUint8List(), flush: true);
      }
      _uri = Uri.file(dosya.path);
    } catch (_) {
      _uri = null;
    }
  }
}