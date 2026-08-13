// ===========================================================================
// MEDYA İNDİRME SERVİSİ - Çevrimdışı dinleme altyapısı
// ---------------------------------------------------------------------------
// URL tabanlı ses içeriklerini (kıssa sesUrl / podcast bölümü) Wi-Fi üzerinden
// cihaza indirir; indirilenler `getApplicationDocumentsDirectory()/
// indirilenler/` klasöründe saklanır ve manifest (ad, yol, boyut) cihazda
// kalıcı tutulur. İndirilen dosya varsa oynatma yerel yoldan yapılır.
// Kıssa metinleri zaten çevrimdışıdır (TTS); bu servis gerçek ses dosyaları
// için hazır altyapı sağlar.
// ===========================================================================

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// İndirilen bir ses dosyasının kaydı.
@immutable
class IndirmeKaydi {
  final String url;
  final String ad;
  final String yerelYol;
  final int boyut;

  const IndirmeKaydi({
    required this.url,
    required this.ad,
    required this.yerelYol,
    required this.boyut,
  });

  Map<String, dynamic> toJson() => {
        'url': url,
        'ad': ad,
        'yerelYol': yerelYol,
        'boyut': boyut,
      };

  factory IndirmeKaydi.fromJson(Map<String, dynamic> json) => IndirmeKaydi(
        url: json['url'] as String,
        ad: (json['ad'] as String?) ?? 'İndirilen',
        yerelYol: json['yerelYol'] as String,
        boyut: (json['boyut'] as num?)?.toInt() ?? 0,
      );
}

class MedyaIndirmeServisi {
  MedyaIndirmeServisi._();

  static final MedyaIndirmeServisi instance = MedyaIndirmeServisi._();

  static const _manifestAnahtari = 'medya_indirilenler';

  /// url -> indirme kaydı (başarıyla tamamlananlar).
  final ValueNotifier<Map<String, IndirmeKaydi>> indirilenler =
      ValueNotifier<Map<String, IndirmeKaydi>>({});

  /// url -> 0.0..1.0 indirme ilerlemesi.
  final ValueNotifier<Map<String, double>> ilerleme =
      ValueNotifier<Map<String, double>>({});

  /// Şu an indirilmekte olan url'ler.
  final ValueNotifier<Set<String>> calisan = ValueNotifier<Set<String>>({});

  bool _yuklendi = false;

  /// Manifest'i belleğe yükler (sayfa açılışında çağrılır).
  Future<void> yukle() async {
    if (_yuklendi) return;
    _yuklendi = true;
    try {
      final p = await SharedPreferences.getInstance();
      final ham = p.getString(_manifestAnahtari);
      if (ham == null) return;
      final liste = jsonDecode(ham) as List;
      final map = <String, IndirmeKaydi>{};
      for (final j in liste) {
        final kayit = IndirmeKaydi.fromJson(
          (j as Map).cast<String, dynamic>(),
        );
        // Dosya silinmişse kayıttan düş.
        if (File(kayit.yerelYol).existsSync()) map[kayit.url] = kayit;
      }
      indirilenler.value = map;
    } catch (_) {
      // Bozuk manifest yok sayılır.
    }
  }

  /// İndirilmiş bir dosyanın yerel yolu; yoksa null.
  String? yerelYolu(String url) => indirilenler.value[url]?.yerelYol;

  bool indirildiMi(String url) => yerelYolu(url) != null;

  /// URL'den ses dosyasını parça parça indirir; [ad] manifest etiketidir.
  /// Başarı → true; hata → false.
  Future<bool> indir(String url, String ad) async {
    if (indirildiMi(url)) return true;
    if (calisan.value.contains(url)) return false;

    calisan.value = {...calisan.value, url};
    ilerleme.value = {...ilerleme.value, url: 0.0};
    try {
      final klasor = await getApplicationDocumentsDirectory();
      final hedefKlasor = Directory('${klasor.path}${Platform.pathSeparator}indirilenler');
      if (!hedefKlasor.existsSync()) await hedefKlasor.create(recursive: true);

      final dosyaAdi =
          '${DateTime.now().millisecondsSinceEpoch}_${_dosyaAdi(url)}';
      final dosya = File(
        '${hedefKlasor.path}${Platform.pathSeparator}$dosyaAdi',
      );

      final istek = http.Request('GET', Uri.parse(url));
      final yanit = await istek.send().timeout(const Duration(minutes: 10));
      if (yanit.statusCode != 200) {
        await dosya.delete().catchError((_) => dosya);
        return false;
      }

      final toplam = yanit.contentLength ?? 0;
      var okunan = 0;
      final cikti = dosya.openWrite();
      await for (final parca in yanit.stream) {
        cikti.add(parca);
        okunan += parca.length;
        if (toplam > 0) {
          ilerleme.value = {
            ...ilerleme.value,
            url: (okunan / toplam).clamp(0.0, 1.0),
          };
        }
      }
      await cikti.flush();
      await cikti.close();

      final kayit = IndirmeKaydi(
        url: url,
        ad: ad,
        yerelYol: dosya.path,
        boyut: okunan,
      );
      indirilenler.value = {...indirilenler.value, url: kayit};
      await _manifestKaydet();
      return true;
    } catch (_) {
      return false;
    } finally {
      calisan.value = {...calisan.value}..remove(url);
      ilerleme.value = {...ilerleme.value}..remove(url);
    }
  }

  /// İndirilmiş kaydı ve dosyayı siler.
  Future<void> sil(String url) async {
    final kayit = indirilenler.value[url];
    if (kayit != null) {
      try {
        final dosya = File(kayit.yerelYol);
        if (dosya.existsSync()) await dosya.delete();
      } catch (_) {}
      indirilenler.value = {...indirilenler.value}..remove(url);
      await _manifestKaydet();
    }
  }

  /// Dosya adı üretir: url'nin son parçası (boşsa ses_<zaman>).
  String _dosyaAdi(String url) {
    final parcali = Uri.parse(url).pathSegments;
    if (parcali.isNotEmpty) {
      final son = parcali.last;
      if (son.isNotEmpty && son.length <= 80) return son;
    }
    return 'ses_${DateTime.now().millisecondsSinceEpoch}.mp3';
  }

  Future<void> _manifestKaydet() async {
    try {
      final p = await SharedPreferences.getInstance();
      await p.setString(
        _manifestAnahtari,
        jsonEncode([
          for (final k in indirilenler.value.values) k.toJson(),
        ]),
      );
    } catch (_) {}
  }
}
