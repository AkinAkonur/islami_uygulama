import 'dart:ui' as ui;
import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Uygulama dilinin kalıcı yönetimi.
///
/// - İlk açılışta kayıtlı bir dil yoksa cihaz dilini otomatik algılar.
/// - Ayarlar sayfasından seçilen dil kaydedilir ve anında uygulanır.
/// - Değişince `aktifDil` dinleyen tüm ekranlar yeniden çizilir.
class DilHizmetleri {
  DilHizmetleri._();

  static const _anahtar = 'ayar_dil';

  static const List<Locale> desteklenenler = [
    Locale('tr'),
    Locale('en'),
    Locale('ar'),
    Locale('id'),
    Locale('ms'),
    Locale('ur'),
    Locale('bn'),
    Locale('fr'),
    Locale('ru'),
  ];

  static const String varsayilanKod = 'tr';

  /// Kullanıcının seçtiği dilin kodu (örn. "tr", "ar"). Cihaz dilinden
  /// farklıysa kullanıcının tercihi sanki uygulanır.
  static final ValueNotifier<Locale> aktifDil =
      ValueNotifier<Locale>(const Locale(varsayilanKod));

  /// Cihazın tercih ettiği dili, desteklenen diller listesinde eşleştirir.
  static Locale _cihazDiliniBul() {
    final tercihler = ui.PlatformDispatcher.instance.locales;
    if (tercihler.isEmpty) return const Locale(varsayilanKod);
    for (final l in tercihler) {
      final kod = l.languageCode.toLowerCase();
      for (final desteklenen in desteklenenler) {
        if (desteklenen.languageCode == kod) return desteklenen;
      }
    }
    return const Locale(varsayilanKod);
  }

  /// Uygulama açılışında aktif dili belirler: kayıtlı tercihi, yoksa cihaz
  /// dilini kullanır. main() içinde runApp öncesinde çağrılır.
  static Future<Locale> baslat() async {
    final p = await SharedPreferences.getInstance();
    final kayitli = p.getString(_anahtar);
    Locale aktif;
    if (kayitli != null && kayitli.isNotEmpty) {
      aktif = Locale(kayitli);
    } else {
      aktif = _cihazDiliniBul();
      // İlk açılışta cihaz dilini kalıcı yap ki bir daha algılanmasın.
      await p.setString(_anahtar, aktif.languageCode);
    }
    aktifDil.value = aktif;
    return aktif;
  }

  /// Seçilen kodu desteklenen bir dil olarak kaydeder ve uygular.
  static Future<void> sec(String kod) async {
    if (!desteklenenler.any((l) => l.languageCode == kod)) return;
    final p = await SharedPreferences.getInstance();
    await p.setString(_anahtar, kod);
    aktifDil.value = Locale(kod);
  }

  /// Düzenli tutmak için listelenebilir (kod, çevrilecek ad).
  static const List<({String kod, String ad})> secenekler = [
    (kod: 'tr', ad: 'Türkçe'),
    (kod: 'en', ad: 'English'),
    (kod: 'ar', ad: 'العربية'),
    (kod: 'id', ad: 'Bahasa Indonesia'),
    (kod: 'ms', ad: 'Bahasa Melayu'),
    (kod: 'ur', ad: 'اردو'),
    (kod: 'bn', ad: 'বাংলা'),
    (kod: 'fr', ad: 'Français'),
    (kod: 'ru', ad: 'Русский'),
  ];
}