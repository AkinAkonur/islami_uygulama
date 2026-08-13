import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Namaz vakitleri için izlenebilen vakitler (şema sırasıyla):
/// İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı.
enum NamazVakti {
  imsak('imsak', 'İmsak', [0, 5, 10, 15, 30, 45, 60], 15),
  gunes('gunes', 'Güneş', [0, 5, 10, 15, 30], 10),
  ogle('ogle', 'Öğle', [0, 5, 10, 15, 20, 30, 45], 20),
  ikindi('ikindi', 'İkindi', [0, 5, 10, 15, 20, 30, 45], 20),
  aksam('aksam', 'Akşam', [0, 5, 10, 15, 30, 45, 60], 15),
  yatsi('yatsi', 'Yatsı', [0, 5, 10, 15, 30, 45, 60], 30);

  const NamazVakti(this.kod, this.ad, this.secenekler, this.varsayilan);

  /// Şemadaki sabit vakit kodu (örn. "imsak").
  final String kod;

  /// VakitServisi ile aynı Türkçe görünen ad (örn. "İmsak").
  final String ad;

  /// Kullanıcıya sunulan "dakika önce" seçenekleri (0 = vaktinde).
  final List<int> secenekler;

  /// Varsayılan hatırlatma süresi (dakika önce).
  final int varsayilan;

  /// Vakit adından (API'den gelen Türkçe ad) enum'a dönüştürür.
  static NamazVakti? adindan(String ad) {
    for (final v in values) {
      if (v.ad == ad) return v;
    }
    return null;
  }

  /// Şema kodundan enum'a dönüştürür.
  static NamazVakti? kodundan(String kod) {
    for (final v in values) {
      if (v.kod == kod) return v;
    }
    return null;
  }

  /// Dropdown için "Kapalı" (-1) dahil tüm seçenekler.
  static List<int> tumSecenekler(NamazVakti v) => [-1, ...v.secenekler];
}

/// Namaz vakitleri hatırlatma tercihleri.
///
/// Kalıcı JSON şeması (SharedPreferences anahtarı: `namaz_bildirim_ayarlari`):
///
/// ```json
/// {
///   "namaz_bildirim_ayarlari": {
///     "versiyon": "1.0.0",
///     "aciklama": "Her vakit için hatırlatma süresi (dakika önce). -1 = Kapalı",
///     "genel_durum": {
///       "bildirimler_aktif_mi": true,
///       "titresim": true,
///       "ozel_ses": "ezan_kisa.mp3"
///     },
///     "vakit_tercihleri": [
///       {"vakit_kodu": "imsak", "vakit_adi": "İmsak",
///        "hatirlatma_dakika_once": 15, "secenekler": [0,5,10,15,30,45,60]},
///       ...
///     ]
///   }
/// }
/// ```
class NamazBildirimAyarlari {
  NamazBildirimAyarlari._();

  static const String depoAnahtari = 'namaz_bildirim_ayarlari';

  /// Şema sürümü — şema değişirse migrasyon buradan yönetilir.
  static const String versiyon = '1.0.0';

  /// Genel durum: bildirimler açık mı (BildirimMerkezi master'ı ile eş tutulur).
  static final ValueNotifier<bool> aktif = ValueNotifier(true);

  /// Genel durum: bildirimde titreşim.
  static final ValueNotifier<bool> titresim = ValueNotifier(true);

  /// Genel durum: özel bildirim sesi (şema alanı; varsayılan değer).
  /// Uygulama paketinde `ezan_kisa.mp3` gibi bir raw ses kaynağı eklenirse
  /// bu alan bildirimlerde kullanılabilir.
  static const String ozelSes = 'ezan_kisa.mp3';

  /// Vakit başına hatırlatma süresi (dakika önce; -1 = Kapalı).
  static final ValueNotifier<Map<NamazVakti, int>> dakikalar = ValueNotifier({
    for (final v in NamazVakti.values) v: v.varsayilan,
  });

  static bool _yuklendi = false;

  /// Şema yapısını döndürür (testler ve hata ayıklama için).
  static Map<String, dynamic> jsonSema() => {
        'namaz_bildirim_ayarlari': {
          'versiyon': versiyon,
          'aciklama':
              'Her vakit için hatırlatma süresi (dakika önce). -1 = Kapalı',
          'genel_durum': {
            'bildirimler_aktif_mi': aktif.value,
            'titresim': titresim.value,
            'ozel_ses': ozelSes,
          },
          'vakit_tercihleri': [
            for (final v in NamazVakti.values)
              {
                'vakit_kodu': v.kod,
                'vakit_adi': v.ad,
                'hatirlatma_dakika_once': dakikalar.value[v],
                'secenekler': v.secenekler,
              },
          ],
        },
      };

  /// Kayıtlı ayarları yükler; ilk açılışta şemadaki varsayılanlar kullanılır.
  static Future<void> yukle() async {
    if (_yuklendi) return;
    _yuklendi = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final ham = prefs.getString(depoAnahtari);
      if (ham == null) return;
      final kok = jsonDecode(ham);
      if (kok is! Map) return;
      final kutu = kok['namaz_bildirim_ayarlari'];
      if (kutu is! Map) return;

      final genel = kutu['genel_durum'];
      if (genel is Map) {
        final aktifMi = genel['bildirimler_aktif_mi'];
        if (aktifMi is bool) aktif.value = aktifMi;
        final tit = genel['titresim'];
        if (tit is bool) titresim.value = tit;
      }

      final tercihler = kutu['vakit_tercihleri'];
      if (tercihler is List) {
        for (final t in tercihler) {
          if (t is! Map) continue;
          final v = NamazVakti.kodundan('${t['vakit_kodu']}');
          final dk = t['hatirlatma_dakika_once'];
          if (v == null || dk is! int) continue;
          dakikalar.value[v] = dk;
        }
      }
    } catch (_) {
      // Bozuk kayıt — varsayılanlarla devam et.
    }
  }

  /// Bir vakit için hatırlatma süresini ayarlar ve kalıcılaştırır.
  static Future<void> ayarla(NamazVakti vakit, int dakikaOnce) async {
    dakikalar.value = {...dakikalar.value, vakit: dakikaOnce};
    await _kaydet();
  }

  /// Vaktin bildirimi kapalı mı (-1)?
  static bool kapaliMi(NamazVakti vakit) => dakikalar.value[vakit] == -1;

  /// Vakit için hatırlatma süresi (dakika önce; 0 = vaktinde).
  static int dakikaOnce(NamazVakti vakit) => dakikalar.value[vakit] ?? 0;

  /// Genel titreşim tercihini ayarlar ve kalıcılaştırır.
  static Future<void> titresimAyarla(bool deger) async {
    titresim.value = deger;
    await _kaydet();
  }

  /// Genel açık/kapalı durumunu ayarlar ve kalıcılaştırır.
  static Future<void> aktifAyarla(bool deger) async {
    aktif.value = deger;
    await _kaydet();
  }

  static Future<void> _kaydet() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(depoAnahtari, jsonEncode(jsonSema()));
    } catch (_) {
      // Kalıcılık hatası — bellek içi durum geçerli kalır.
    }
  }

  /// Testlerde temiz durum için depoyu sıfırlar (kayıtlı veriyi de siler).
  @visibleForTesting
  static Future<void> sifirla() async {
    _yuklendi = false;
    aktif.value = true;
    titresim.value = true;
    dakikalar.value = {
      for (final v in NamazVakti.values) v: v.varsayilan,
    };
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(depoAnahtari);
    } catch (_) {}
  }

  /// Testlerde bellek içi durumu düşürür ama kaydedilmiş veriyi korur
  /// (yeniden yükleme davranışını test etmek için).
  @visibleForTesting
  static void bellektenDusur() {
    _yuklendi = false;
  }
}
