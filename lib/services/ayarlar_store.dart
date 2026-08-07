import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Kullanıcı ayarlarının kalıcı deposu. Değerler değişince UI otomatik
/// dinler (ValueNotifier) ve uygulama açıldığında geri yüklenir.
class AyarlarStore {
  AyarlarStore._();

  static const _karanlik = 'ayar_karanlik_mod';
  static const _masterBildirim = 'ayar_master_bildirim';
  static const _konumOtomatik = 'ayar_konum_otomatik';
  static const _hesapMethodu = 'ayar_hesap_methodu';

  static Future<SharedPreferences> get _p => SharedPreferences.getInstance();

  /// Karanlık mod; değişince tüm uygulama teması yeniden çizilir.
  static final ValueNotifier<bool> karanlikMod = ValueNotifier<bool>(true);

  /// Başlangıçta kayıtlı ayarları yükler.
  static Future<void> baslat() async {
    final p = await _p;
    karanlikMod.value = p.getBool(_karanlik) ?? true;
  }

  static Future<bool> karanlikOku() async =>
      (await _p).getBool(_karanlik) ?? true;

  static Future<void> karanlikYaz(bool deger) async {
    await (await _p).setBool(_karanlik, deger);
    karanlikMod.value = deger;
  }

  static Future<bool> masterBildirimOku() async =>
      (await _p).getBool(_masterBildirim) ?? true;

  static Future<void> masterBildirimYaz(bool deger) async {
    await (await _p).setBool(_masterBildirim, deger);
  }

  static Future<bool> konumOtomatikOku() async =>
      (await _p).getBool(_konumOtomatik) ?? true;

  static Future<void> konumOtomatikYaz(bool deger) async {
    await (await _p).setBool(_konumOtomatik, deger);
  }

  /// Hesaplama yöntemi kodu (ör. "13" = Diyanet, "3" = MWL). Boşsa
  /// ülkeye göre varsayılan uygulanır.
  static Future<String?> metotOku() async =>
      (await _p).getString(_hesapMethodu);

  static Future<void> metotYaz(String kod) async {
    await (await _p).setString(_hesapMethodu, kod);
  }

  static const String diyanetKod = '13';
  static const String mwlKod = '3';

  static String metotEtiketi(String kod) {
    return switch (kod) {
      '13' => 'Diyanet (Türkiye)',
      '3' => 'MWL (Dünya Geneli)',
      '2' => 'ISNA (Kuzey Amerika)',
      '1' => 'Karaçi (Güney Asya)',
      '4' => 'Ümmü\'l-Kura (Mekke)',
      '5' => 'Mısır (Afrika / Orta Doğu)',
      _ => 'Ülkeye göre otomatik',
    };
  }
}
