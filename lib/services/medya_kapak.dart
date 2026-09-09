import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Medya ve namaz bildirimlerinde kullanılan 3D görünümlü görselleri sağlar.
///
/// `audio_service` artwork'ü ve `flutter_local_notifications` büyük resim /
/// büyük ikon alanları yalnızca gerçek bir dosya yolu (`file://`) veya ağ
/// URL'si yükler; Flutter asset'i (`asset://`) desteklemez. Bu yüzden paket
/// içindeki görseller uygulama ilk açılışta kendi dizinine kopyalanır.
class MedyaKapak {
  MedyaKapak._();

  /// Paketteki altın çerçeveli kapak görseli (çekmece/kilit ekranı kartında
  /// 3D zümrüt-altın görünümü veren artwork).
  static const String _kapakAsset = 'assets/gorseller/medya_kapak_bildirim.jpg';

  /// Bildirim penceresinin geniş (BigPicture) 3D afişi.
  static const String _bannerAsset = 'assets/gorseller/bildirim_3d_banner.png';

  /// Bildirim kartının sağ üst köşesindeki 3D kubbe ikonu.
  static const String _ikonAsset = 'assets/gorseller/bildirim_3d_ikon.png';

  static Uri? _uri;
  static String? _bannerYol;
  static String? _ikonYol;

  /// Bildirim artwork'ü olarak kullanılacak dosya URI'si; hazırlanamadıysa null.
  static Uri? get uri => _uri;

  /// BigPicture stilinde kullanılacak 3D afiş dosya yolu; yoksa null.
  static String? get bannerYol => _bannerYol;

  /// Bildirimin büyük ikonu için 3D kubbe dosya yolu; yoksa null.
  static String? get ikonYol => _ikonYol;

  /// Paketteki görselleri uygulama dizinine kopyalar.
  /// Başarısız olursa ilgili alan null kalır; bildirim yine de varsayılan
  /// ikonla çalışır.
  static Future<void> hazirla() async {
    _uri = null;
    _bannerYol = null;
    _ikonYol = null;
    try {
      final dizin = await getApplicationSupportDirectory();
      final kapak = await _kopyala(_kapakAsset, dizin, 'medya_kapak_bildirim.jpg');
      if (kapak != null) _uri = Uri.file(kapak);
      _bannerYol = await _kopyala(_bannerAsset, dizin, 'bildirim_3d_banner.png');
      _ikonYol = await _kopyala(_ikonAsset, dizin, 'bildirim_3d_ikon.png');
    } catch (_) {
      // Görseller hazırlanamazsa bildirimler sade stille gösterilir.
    }
  }

  /// Tek bir asset'i hedef dizine kopyalar ve tam yolunu döndürür.
  static Future<String?> _kopyala(
    String asset,
    Directory dizin,
    String dosyaAdi,
  ) async {
    try {
      final dosya = File('${dizin.path}/$dosyaAdi');
      final veri = await rootBundle.load(asset);
      final bayt = veri.buffer.asUint8List();
      // Yeni sürümde görsel değişmiş olabilir: boyut farklıysa tazele.
      if (!await dosya.exists() || await dosya.length() != bayt.length) {
        await dosya.writeAsBytes(bayt, flush: true);
      }
      return dosya.path;
    } catch (_) {
      return null;
    }
  }
}
