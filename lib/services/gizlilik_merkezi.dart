// ===========================================================================
// GİZLİLİK MERKEZİ SERVİSİ - KVKK/GDPR "Özel Nitelikli Kişisel Veri" bilinci
// ---------------------------------------------------------------------------
// Dini uygulamalarda kullanıcının inanç/ibadet/ dinleme alışkanlıkları hassas
// veridir. Bu servis üç katmanı yönetir:
//   1. JSON tabanlı "gizlilik_merkezi" şeması: izin kartları, kullanıcı hakları
//      ve yasal metinler tek kaynaktan (gömülü JSON) beslenir; uzak yapılandırma
//      gibi daha sonra sunucudan da gelenilebilir.
//   2. Minimal veri prensibi: tüm kullanıcı verileri cihazdadır, sunucuya hiçbir
//      şey gönderilmez. "Verilerimi İndir" cihazdaki her şeyi JSON dökümü yapar;
//      "Hesabımı ve Verilerimi Sil" (unutulma hakkı) tümünü kalıcı siler.
//   3. İzleme/analitik denetimi: analiz kapatma anahtarı kullanıcıya aittir.
// ===========================================================================

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'canli_yayin_konfigurasyonu.dart';
import 'manevi_store.dart';
import 'medya_indirme_servisi.dart';
import 'radyo_oynatici_store.dart';
import 'sesli_oynatma_store.dart';

/// Gömülü gizlilik_merkezi JSON şeması (çok dilli yapıya hazır tek kaynak).
const String gomuluGizlilikMerkeziJson = '''
{
  "gizlilik_merkezi": {
    "baslik": "Gizlilik ve Veri Güvenliğiniz",
    "alt_baslik": "Verileriniz size emanet edildiği gibi, bize de emanettir.",
    "izin_kartlari": [
      {
        "id": "izin_konum",
        "ikon": "location_on",
        "baslik": "Konum Verisi",
        "aciklama": "Namaz vakitleri ve Kıble pusulası için kullanılır. Hiçbir zaman sunucularımıza gönderilmez veya saklanmaz.",
        "durum_aktif_mi": true,
        "degistirilebilir_mi": true
      },
      {
        "id": "izin_depolama",
        "ikon": "folder",
        "baslik": "Çevrimdışı Depolama",
        "aciklama": "Sadece indirdiğiniz podcastleri ve sesli kıssaları telefonunuzda saklamak için kullanılır.",
        "durum_aktif_mi": true,
        "degistirilebilir_mi": false
      },
      {
        "id": "izin_analitik",
        "ikon": "analytics",
        "baslik": "İyileştirme ve İstatistikler",
        "aciklama": "Hangi radyo kanallarının veya içeriklerin daha çok sevildiğini anonim olarak analiz ederiz. Kim olduğunuzu asla bilmeyiz.",
        "durum_aktif_mi": false,
        "degistirilebilir_mi": true
      }
    ],
    "kullanici_haklari": [
      {
        "aksiyon_id": "veri_indir",
        "buton_metni": "Tüm Verilerimi İndir",
        "tehlike_seviyesi": "dusuk"
      },
      {
        "aksiyon_id": "hesap_sil",
        "buton_metni": "Hesabımı ve Tüm Verilerimi Kalıcı Olarak Sil",
        "tehlike_seviyesi": "yuksek",
        "uyari": "Bu işlem geri alınamaz. Favorileriniz, çevrimdışı içerikleriniz ve dinleme geçmişiniz anında silinir."
      }
    ],
    "yasal_metinler": {
      "kisa_ozet": "Uygulamayı kullanarak toplanan verilerin sadece size daha iyi bir dini içerik deneyimi sunmak için kullanıldığını kabul etmiş olursunuz. Verilerinizi hiçbir üçüncü şahıs veya reklam şirketiyle satmıyor ve paylaşmıyoruz; tüm veriler cihazınızda kalır.",
      "tam_metin_url": "https://islamiuygulama.app/legal/gizlilik-politikasi"
    }
  }
}
''';

/// JSON'daki bir izin kartı.
class GizlilikIzinKarti {
  final String id;
  final String ikon;
  final String baslik;
  final String aciklama;
  final bool durumAktifMi;
  final bool degistirilebilirMi;

  const GizlilikIzinKarti({
    required this.id,
    required this.ikon,
    required this.baslik,
    required this.aciklama,
    required this.durumAktifMi,
    required this.degistirilebilirMi,
  });

  factory GizlilikIzinKarti.json(Map<String, dynamic> j) => GizlilikIzinKarti(
    id: j['id'] as String? ?? '',
    ikon: j['ikon'] as String? ?? 'info',
    baslik: j['baslik'] as String? ?? '',
    aciklama: j['aciklama'] as String? ?? '',
    durumAktifMi: j['durum_aktif_mi'] as bool? ?? false,
    degistirilebilirMi: j['degistirilebilir_mi'] as bool? ?? false,
  );
}

/// JSON'daki bir kullanıcı hakkı (veri indir / hesap sil).
class GizlilikKullaniciHakki {
  final String aksiyonId;
  final String butonMetni;
  final String tehlikeSeviyesi; // "dusuk" | "yuksek"
  final String uyari;

  const GizlilikKullaniciHakki({
    required this.aksiyonId,
    required this.butonMetni,
    required this.tehlikeSeviyesi,
    this.uyari = '',
  });

  bool get tehlikeliMi => tehlikeSeviyesi == 'yuksek';

  factory GizlilikKullaniciHakki.json(Map<String, dynamic> j) =>
      GizlilikKullaniciHakki(
        aksiyonId: j['aksiyon_id'] as String? ?? '',
        butonMetni: j['buton_metni'] as String? ?? '',
        tehlikeSeviyesi: j['tehlike_seviyesi'] as String? ?? 'dusuk',
        uyari: j['uyari'] as String? ?? '',
      );
}

/// Yasal bilgilendirme metinleri.
class GizlilikYasalMetinler {
  final String kisaOzet;
  final String tamMetinUrl;

  const GizlilikYasalMetinler({
    required this.kisaOzet,
    required this.tamMetinUrl,
  });

  factory GizlilikYasalMetinler.json(Map<String, dynamic> j) =>
      GizlilikYasalMetinler(
        kisaOzet: j['kisa_ozet'] as String? ?? '',
        tamMetinUrl: j['tam_metin_url'] as String? ?? '',
      );
}

/// Tüm gizlilik merkezi içeriği (tek JSON şemasından).
class GizlilikMerkeziVerisi {
  final String baslik;
  final String altBaslik;
  final List<GizlilikIzinKarti> izinKartlari;
  final List<GizlilikKullaniciHakki> kullaniciHaklari;
  final GizlilikYasalMetinler yasalMetinler;

  const GizlilikMerkeziVerisi({
    required this.baslik,
    required this.altBaslik,
    required this.izinKartlari,
    required this.kullaniciHaklari,
    required this.yasalMetinler,
  });

  factory GizlilikMerkeziVerisi.json(Map<String, dynamic> j) {
    final merkez = j['gizlilik_merkezi'] as Map<String, dynamic>? ?? j;
    return GizlilikMerkeziVerisi(
      baslik: merkez['baslik'] as String? ?? 'Gizlilik ve Veri Güvenliğiniz',
      altBaslik: merkez['alt_baslik'] as String? ?? '',
      izinKartlari: [
        for (final k in (merkez['izin_kartlari'] as List? ?? []))
          if (k is Map<String, dynamic>) GizlilikIzinKarti.json(k),
      ],
      kullaniciHaklari: [
        for (final k in (merkez['kullanici_haklari'] as List? ?? []))
          if (k is Map<String, dynamic>) GizlilikKullaniciHakki.json(k),
      ],
      yasalMetinler: GizlilikYasalMetinler.json(
        (merkez['yasal_metinler'] as Map<String, dynamic>?) ?? const {},
      ),
    );
  }

  GizlilikIzinKarti? izinKarti(String id) {
    for (final k in izinKartlari) {
      if (k.id == id) return k;
    }
    return null;
  }
}

/// Gizlilik merkezinin çalışma mantığı.
class GizlilikMerkeziServisi {
  GizlilikMerkeziServisi._();

  static const _kAnalitikKapali = 'gizlilik_analitik_kapali';

  /// İzin/istatistik toplama kapalı mı? (kullanıcı tercihi; kalıcıdır)
  static final ValueNotifier<bool> analitikKapali = ValueNotifier<bool>(false);

  static bool _basladi = false;

  /// Gizlilik merkezi içeriği (gömülü JSON şemasından).
  static GizlilikMerkeziVerisi? _veri;

  static GizlilikMerkeziVerisi get veri {
    if (_veri != null) return _veri!;
    try {
      final ham = jsonDecode(gomuluGizlilikMerkeziJson);
      _veri = GizlilikMerkeziVerisi.json(ham as Map<String, dynamic>);
    } catch (_) {
      _veri = const GizlilikMerkeziVerisi(
        baslik: 'Gizlilik ve Veri Güvenliğiniz',
        altBaslik: '',
        izinKartlari: [],
        kullaniciHaklari: [],
        yasalMetinler: GizlilikYasalMetinler(
          kisaOzet: '',
          tamMetinUrl: '',
        ),
      );
    }
    return _veri!;
  }

  /// Uygulama açılışında bir kez çağrılır: kayıtlı analitik tercihi yükler.
  static Future<void> baslat() async {
    if (_basladi) return;
    _basladi = true;
    try {
      final p = await SharedPreferences.getInstance();
      analitikKapali.value = p.getBool(_kAnalitikKapali) ?? false;
    } catch (_) {}
  }

  /// Analitik kapatma anahtarını değiştirir (kalıcı).
  static Future<void> analitikDegistir(bool kapali) async {
    analitikKapali.value = kapali;
    try {
      final p = await SharedPreferences.getInstance();
      await p.setBool(_kAnalitikKapali, kapali);
    } catch (_) {}
  }

  /// Konum izni şu an verilmiş mi? (hata durumunda false döner)
  static Future<bool> konumAktifMi() async {
    try {
      final durum = await Geolocator.checkPermission();
      return durum == LocationPermission.always ||
          durum == LocationPermission.whileInUse;
    } catch (_) {
      return false;
    }
  }

  /// Kullanıcıyı cihazın uygulama ayarlarına yönlendirir (izni orada iptal eder).
  static Future<void> cihazKonumAyarlariniAc() async {
    try {
      await Geolocator.openAppSettings();
    } catch (_) {}
  }

  /// Cihazda saklanan TÜM kullanıcı verilerinin sadeleştirilmiş JSON dökümünü
  /// üretir (dosya sistemi olmadan; test edilebilir saf katman).
  static Future<Map<String, dynamic>> veriOzgunle() async {
    final p = await SharedPreferences.getInstance();
    final veri = <String, dynamic>{};
    for (final key in p.getKeys()) {
      final deger = p.get(key);
      if (deger is List) continue; // StringList'ler ayrıca toplanır
      veri[key] = deger;
    }
    for (final key in p.getKeys()) {
      final deger = p.get(key);
      if (deger is List) veri[key] = deger;
    }
    return {
      'uygulama': 'islami_uygulama',
      'olusturma_tarihi': DateTime.now().toIso8601String(),
      'aciklama':
          'Bu dosya, uygulamanın yalnızca cihazınızda sakladığı tüm verilerinizin dökümüdür. Sunucuya hiçbir veri iletilmez.',
      'veri': veri,
      'indirilen_ses_dosyalari': [
        for (final k in MedyaIndirmeServisi.instance.indirilenler.value.values)
          {'ad': k.ad, 'url': k.url, 'yerel_yol': k.yerelYol, 'boyut': k.boyut},
      ],
    };
  }

  /// "Verilerimi İndir": JSON dökümünü cihaza yazar ve paylaşım sayfası açar.
  /// Başarı → dosya yolu; hata → null.
  static Future<String?> verileriDisaAktar() async {
    try {
      final cikti = await veriOzgunle();
      final klasor = await getTemporaryDirectory();
      final dosya = File(
        '${klasor.path}${Platform.pathSeparator}islami_uygulama_verilerim.json',
      );
      await dosya.writeAsString(
        const JsonEncoder.withIndent('  ').convert(cikti),
      );
      await SharePlus.instance.share(
        ShareParams(files: [XFile(dosya.path, mimeType: 'application/json')]),
      );
      return dosya.path;
    } catch (_) {
      return null;
    }
  }

  /// "Hesabımı ve Verilerimi Sil" (unutulma hakkı): cihazdaki tüm kullanıcı
  /// verilerini, indirilen ses dosyalarını ve bellekteki durumları kalıcı siler.
  static Future<void> verileriSil() async {
    // 1) İndirilen ses dosyaları.
    try {
      final klasor = await getApplicationDocumentsDirectory();
      final hedef = Directory(
        '${klasor.path}${Platform.pathSeparator}indirilenler',
      );
      if (hedef.existsSync()) await hedef.delete(recursive: true);
    } catch (_) {}
    // 2) Tüm kalıcı tercihler/veriler.
    try {
      final p = await SharedPreferences.getInstance();
      await p.clear();
    } catch (_) {}
    // 3) Bellekteki durumlar (UI anında temiz görünsün).
    RadyoOynaticiStore.favoriler.value = {};
    RadyoOynaticiStore.ses.value = 100;
    RadyoOynaticiStore.uykuDk.value = null;
    RadyoOynaticiStore.uykuKalanDk.value = null;
    try {
      await RadyoOynaticiStore.player.stop();
    } catch (_) {}
    RadyoOynaticiStore.calanKanal.value = null;
    RadyoOynaticiStore.calyor.value = false;
    RadyoOynaticiStore.yukleniyor.value = false;
    RadyoOynaticiStore.hata.value = null;

    ManeviStore.kuranKonumu.value = const KuranKonumu(
      sureNo: 2,
      ayetNo: 255,
      sureAdi: 'Bakara',
    );
    SesliOynatmaStore.sonKissaId.value = null;
    SesliOynatmaStore.sonKissaAd.value = null;
    SesliOynatmaStore.sonKanalUrl.value = null;
    SesliOynatmaStore.sonKanalAd.value = null;
    SesliOynatmaStore.podcastPozisyonMs.value = 0;
    SesliOynatmaStore.hiz.value = 1.0;
    SesliOynatmaStore.uykuDk.value = null;
    SesliOynatmaStore.uykuKalanDk.value = null;

    MedyaIndirmeServisi.instance.indirilenler.value = {};
    MedyaIndirmeServisi.instance.ilerleme.value = {};
    MedyaIndirmeServisi.instance.calisan.value = {};

    analitikKapali.value = false;
    // Yapılandırma önbelleği de temizlendi; gömülü varsayılanlara dön.
    CanliYayinKonfigurasyonu.aktif.value = CanliYayinKonfig.varsayilan();
  }

  /// Gizlilik metnindeki ikon adını gerçek ikona çevirir (sayfa ortak kullanımı).
  static IconData ikonCevir(String ad, {IconData? varsayilan}) {
    switch (ad) {
      case 'location_on':
        return Icons.location_on;
      case 'folder':
        return Icons.folder;
      case 'analytics':
        return Icons.analytics;
      case 'download':
        return Icons.download;
      case 'delete':
        return Icons.delete_forever;
      default:
        return varsayilan ?? Icons.info_outline;
    }
  }
}