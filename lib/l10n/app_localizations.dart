import 'package:flutter/material.dart';

import 'ar.dart' as ar;
import 'bn.dart' as bn;
import 'en.dart' as en;
import 'fr.dart' as fr;
import 'id.dart' as id;
import 'ms.dart' as ms;
import 'ru.dart' as ru;
import 'tr.dart' as tr;
import 'ur.dart' as ur;

/// Uygulama çapında kullanılan anahtar bazlı çeviri katmanı.
///
/// Her dil kendi sabit dosyasını (`lib/l10n/`) sağlar; bulunamayan anahtar
/// Türkçe'ye (ana dil) düşer; o da yoksa anahtarın kendisi gösterilir.
///
/// Din'î terimler (ezân, kıble, zekât, tesbih, namaz vakitleri vb.) her dilin
/// en yaygın kabul gören karşılığıyla çevrilmiştir.
class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static final Map<String, Map<String, String>> _diller = {
    'tr': tr.trDil,
    'en': en.enDil,
    'ar': ar.arDil,
    'id': id.idDil,
    'ms': ms.msDil,
    'ur': ur.urDil,
    'bn': bn.bnDil,
    'fr': fr.frDil,
    'ru': ru.ruDil,
  };

  /// Aktif dile ait çeviri haritası.
  Map<String, String> get _aktif =>
      _diller[locale.languageCode] ?? tr.trDil;

  /// Anahtar için çeviriyi getirir; eksik anahtar Türkçe'den beslenir.
  String t(String anahtar) {
    return _aktif[anahtar] ?? tr.trDil[anahtar] ?? anahtar;
  }

  /// Namaz vakitleri API'sinden gelen Türkçe isimleri aktif dile çevirir.
  String vakitAdi(String turkceAd) {
    final renderet = switch (turkceAd) {
      'İmsak' => _aktif['p.imsak'],
      'Güneş' => _aktif['p.gunes'],
      'Öğle' => _aktif['p.ogle'],
      'İkindi' => _aktif['p.ikindi'],
      'Akşam' => _aktif['p.aksam'],
      'Yatsı' => _aktif['p.yatsi'],
      _ => turkceAd,
    };
    return renderet ?? turkceAd;
  }

  /// Arapça ve Urduca sağdan sola (RTL) okunur.
  bool get rtlMi => ['ar', 'ur'].contains(locale.languageCode);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['tr', 'en', 'ar', 'id', 'ms', 'ur', 'bn', 'fr', 'ru']
          .contains(locale.languageCode.toLowerCase());

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}