// ===========================================================================
// SESLİ KISSALAR VE PODCASTLER (İnteraktif Medya Merkezi modülü)
// ---------------------------------------------------------------------------
// Kullanıcı deneyimi ilkeleri (JSON v1.0.0):
//  1. Sıfır Sürtünme: "Kaldığın Yerden Devam Et" + "Günün Kıssası" sabit
//     kartları sayfanın en üstünde; tek dokunuşla devam.
//  2. Duruma Göre İçerik: süre filtresi (<5, 5-15, 15-30, 30+ dk) ve ruh hali
//     / mod seçici (Huzur, Motivasyon, Uykudan Önce, Çocuk, Öğrenme).
//  3. Akıllı arama: başlık, özet, metin ve etiketler (Sabır, Dua...) üzerinde.
//  4. Bölünmeyen Deneyim: mini oynatıcı çubuğu; pozisyon ve hız kalıcılığı;
//     çevrimdışı indirme (MedyaIndirmeServisi) ve TTS ile çevrimdışı anlatım.
//  5. Gelişmiş oynatıcı: hız (0.75x-2x), uyku zamanlayıcısı, seslendiren,
//     tahmini süre ve bölüm (chapter) metadatası.
// ---------------------------------------------------------------------------
// İçerik kaynakları:
//  📖 Sesli Kıssalar: Kıssalar ve Peygamberler sayfasındaki tüm kayıtlar
//     cihazın TTS motoruyla sesli anlatıma çevrilir (internet gerektirmez).
//     Kayıtta CDN ses adresi (sesUrl) varsa öncelikle o akış/yerel dosya
//     oynatılır; "Oku" ile detay sayfası açılır.
//  🎙️ Podcastler & Radyo: yayın konfigürasyonundan (Remote Config
//     alternatifi) gelen radyo/podcast akışları tek dokunuşla dinlenir.
// ===========================================================================

import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import '../l10n/app_localizations.dart';
import '../services/canli_yayin_konfigurasyonu.dart';
import '../services/medya_indirme_servisi.dart';
import '../services/muzik_handler.dart';
import '../services/radyo_oynatici_store.dart';
import '../services/renkler.dart';
import '../services/sesli_oynatma_store.dart';
import 'kissalar/ibret_verileri.dart';
import 'kissalar/kissa_detay_page.dart';
import 'kissalar/kissa_store.dart';
import 'kissalar/kissalar_verileri.dart';
import 'kissalar/peygamberler_verileri.dart';
import 'kissalar/siyer_verileri.dart';
import '../widgets/kart_sekilleri.dart';

/// Süre filtresi seçenekleri (kullanıcı "Zamanım Var" mekanizması).
const List<({String id, String etiket, int minDk, int maksDk})>
_sureFiltreleri = [
  (id: 'mikro', etiket: '<5 dk', minDk: 0, maksDk: 5),
  (id: 'kisa', etiket: '5-15 dk', minDk: 5, maksDk: 15),
  (id: 'orta', etiket: '15-30 dk', minDk: 15, maksDk: 30),
  (id: 'uzun', etiket: '30+ dk', minDk: 30, maksDk: 9999),
];

/// Ruh hali / mod seçenekleri. `anahtarKelime` listesi kıssanın tema ve
/// etiketleriyle eşleştirilir; `kosul` özel durumları (çocuk, öğrenme) belirler.
class _ModSecenegi {
  final String id;
  final String ad;
  final IconData ikon;
  final List<String> anahtarKelime;

  const _ModSecenegi({
    required this.id,
    required this.ad,
    required this.ikon,
    this.anahtarKelime = const [],
  });
}

const List<_ModSecenegi> _modlar = [
  _ModSecenegi(
    id: 'huzur',
    ad: 'Huzur',
    ikon: Icons.spa_rounded,
    anahtarKelime: [
      'sabır',
      'tevekkül',
      'şükür',
      'huzur',
      'dua',
      'zühd',
      'rahatlık',
    ],
  ),
  _ModSecenegi(
    id: 'motivasyon',
    ad: 'Motivasyon',
    ikon: Icons.bolt_rounded,
    anahtarKelime: [
      'cesaret',
      'zafer',
      'azim',
      'gayret',
      'fedakarlık',
      'cihad',
      'kahramanlık',
    ],
  ),
  _ModSecenegi(
    id: 'uyku',
    ad: 'Uykudan Önce',
    ikon: Icons.nightlight_round,
    anahtarKelime: ['sabır', 'merhamet', 'huzur', 'şefkat', 'dua', 'sevgi'],
  ),
  _ModSecenegi(id: 'cocuk', ad: 'Çocuk İçin', ikon: Icons.child_care_rounded),
  _ModSecenegi(id: 'ogrenme', ad: 'Öğrenme', ikon: Icons.school_rounded),
];

/// Oynatma hızı çarpanları.
const List<double> _hizlar = [0.75, 1.0, 1.25, 1.5, 2.0];

class SesliKissalarVePodcastlerPage extends StatefulWidget {
  const SesliKissalarVePodcastlerPage({super.key});

  @override
  State<SesliKissalarVePodcastlerPage> createState() =>
      _SesliKissalarVePodcastlerPageState();
}

class _SesliKissalarVePodcastlerPageState
    extends State<SesliKissalarVePodcastlerPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tablar;

  // ---- Keşif filtreleri ----
  final TextEditingController _aramaKontrol = TextEditingController();
  String _aramaSorgusu = '';
  String? _sureFiltresi;
  String? _modSecimi;

  // ---- TTS (metin tabanlı kıssa anlatımı) ----
  final FlutterTts _tts = FlutterTts();
  String? _ttsKalanId;
  String? _ttsKalanBaslik;
  bool _ttsCalyor = false;
  String? _ttsHata;
  bool _ttsBasladi = false;

  // ---- URL ses (kıssa sesUrl + podcast/radyo) ----
  // Uygulama genelindeki tek just_audio oynatıcısı; sayfa kapansa bile ses
  // arka planda devam eder ve `audio_service` kilit ekranından kontrol sağlar.
  AudioPlayer get _oynatici => RadyoOynaticiStore.player;
  final List<StreamSubscription<dynamic>> _sesAbonelikleri = [];
  String? _calanUrl;
  String? _calanBaslik;
  bool _sesCalyor = false;
  bool _sesYukleniyor = false;
  String? _sesHata;
  int _pozisyonMs = 0;
  int _toplamMs = 0;

  @override
  void initState() {
    super.initState();
    _tablar = TabController(length: 2, vsync: this);
    // Kıssa kayıt defterini doldur (idempotent).
    peygamberlerKaydet();
    siyerKaydet();
    ibretKaydet();
    KissaStore.yukle();
    SesliOynatmaStore.yukle();
    MedyaIndirmeServisi.instance.yukle();
    _ttsKur();
    _sesPlayerKur();
  }

  void _ttsKur() {
    _tts.setLanguage('tr-TR').catchError((_) {});
    _tts.setSpeechRate(_ttsHiz()).catchError((_) {});
    _tts.awaitSpeakCompletion(false).catchError((_) {});
    // setStartHandler, Android tarafında speak.onStart olayı ile gerçek ses
    // üretimi başladığında tetiklenir. speak() çağrısının 1 dönmesi yalnızca
    // kuyruğa alındığını gösterir; ses verisi eksikse 1 döner ama onStart hiç
    // gelmez. Bu yüzden "çalıyor" durumu gerçek başlangıca bağlanır.
    _tts.setStartHandler(() {
      _ttsBasladi = true;
      if (mounted) {
        setState(() {
          _ttsCalyor = true;
          _ttsHata = null;
        });
      }
    });
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _ttsCalyor = false);
    });
    _tts.setCancelHandler(() {
      if (mounted) setState(() => _ttsCalyor = false);
    });
    _tts.setErrorHandler((message) {
      _ttsBasladi = false;
      if (mounted) {
        setState(() {
          _ttsCalyor = false;
          _ttsHata =
              '${AppLocalizations.of(context).t('sks.ttsError')} $message';
        });
      }
    });
  }

  void _sesPlayerKur() {
    _sesAbonelikleri.add(_oynatici.playerStateStream.listen((state) {
      if (!mounted) return;
      setState(() {
        _sesCalyor = state.playing;
        _sesYukleniyor =
            state.processingState == ProcessingState.loading;
      });
    }));
    _sesAbonelikleri.add(_oynatici.positionStream.listen((pozisyon) {
      if (!mounted) return;
      _pozisyonMs = pozisyon.inMilliseconds;
      if (_calanUrl != null) {
        SesliOynatmaStore.pozisyonGuncelle(pozisyon.inMilliseconds);
      }
      setState(() {});
    }));
    _sesAbonelikleri.add(_oynatici.durationStream.listen((toplam) {
      if (!mounted) return;
      _toplamMs = toplam?.inMilliseconds ?? 0;
      setState(() {});
    }));
    _sesAbonelikleri.add(_oynatici.processingStateStream.listen((durum) {
      if (!mounted) return;
      if (durum == ProcessingState.completed) {
        setState(() {
          _sesCalyor = false;
          _calanUrl = null;
          _calanBaslik = null;
        });
        SesliOynatmaStore.pozisyonGuncelle(0);
      }
    }, onError: (Object hata) {
      if (!mounted) return;
      setState(() {
        _sesCalyor = false;
        _sesYukleniyor = false;
        _sesHata =
            AppLocalizations.of(context).t('sks.sourceUnreachableRetry');
      });
    }));
  }

  @override
  void dispose() {
    for (final abone in _sesAbonelikleri) {
      abone.cancel();
    }
    _tablar.dispose();
    _aramaKontrol.dispose();
    _tts.stop();
    super.dispose();
  }

  // =========================================================================
  // YARDIMCILAR
  // =========================================================================

  double _ttsHiz() => (0.45 * SesliOynatmaStore.hiz.value).clamp(0.3, 0.9);

  void _bilgiGoster(String mesaj) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mesaj), duration: const Duration(seconds: 2)),
    );
  }

  String _saniyeFormati(int ms) {
    final toplamSn = ms ~/ 1000;
    final dk = toplamSn ~/ 60;
    final sn = toplamSn % 60;
    return '$dk:${sn.toString().padLeft(2, '0')}';
  }

  String _pozisyonMetni() {
    if (_toplamMs <= 0) return _saniyeFormati(_pozisyonMs);
    return '${_saniyeFormati(_pozisyonMs)} / ${_saniyeFormati(_toplamMs)}';
  }

  bool _sureEslesir(KissaKaydi kissa, String id) {
    final secenek = _sureFiltreleri.firstWhere(
      (s) => s.id == id,
      orElse: () => _sureFiltreleri.first,
    );
    return kissa.tahminiSureDk >= secenek.minDk &&
        kissa.tahminiSureDk < secenek.maksDk;
  }

  bool _modEslesir(KissaKaydi kissa, _ModSecenegi mod) {
    final etiketler = kissa.tumEtiketler;
    switch (mod.id) {
      case 'cocuk':
        // Kısa anlatımlar ve çocuk dostu içerikler.
        return kissa.tahminiSureDk <= 15 ||
            etiketler.any(
              (t) =>
                  t.toLowerCase().contains('çocuk') ||
                  t.toLowerCase().contains('hz.'),
            );
      case 'ogrenme':
        // Akademik notlu / tarih & siyer içerikleri.
        return kissa.akademikNotlar.isNotEmpty ||
            kissa.kategoriId == 'siyer' ||
            kissa.donem.toLowerCase().contains('tarih');
      case 'uyku':
        if (kissa.tahminiSureDk <= 20) return true;
        return etiketler.any(
          (t) => mod.anahtarKelime.contains(t.toLowerCase()),
        );
      default:
        return etiketler.any(
          (t) => mod.anahtarKelime.contains(t.toLowerCase()),
        );
    }
  }

  List<KissaKaydi> _filtrelenmisKisalar() {
    var liste = KissalarVerileri.tumKisalar;
    if (_aramaSorgusu.trim().isNotEmpty) {
      final sorgu = _aramaSorgusu.trim().toLowerCase();
      liste = liste
          .where(
            (k) =>
                k.aramaMetni.contains(sorgu) ||
                k.tumEtiketler.any((t) => t.toLowerCase().contains(sorgu)),
          )
          .toList();
    }
    if (_sureFiltresi != null) {
      liste = liste.where((k) => _sureEslesir(k, _sureFiltresi!)).toList();
    }
    if (_modSecimi != null) {
      final mod = _modlar.firstWhere((m) => m.id == _modSecimi);
      final eslesen = liste.where((k) => _modEslesir(k, mod)).toList();
      // Filtre boş dönerse mod yok sayılır (boş ekran kötü deneyim).
      if (eslesen.isNotEmpty) liste = eslesen;
    }
    return liste;
  }

  KissaKaydi? _gununKissasi() {
    final kisalar = KissalarVerileri.tumKisalar;
    if (kisalar.isEmpty) return null;
    final gunIndex = DateTime.now().difference(DateTime(2020)).inDays;
    return kisalar[gunIndex % kisalar.length];
  }

  // =========================================================================
  // OYNATICI KONTROLLERİ
  // =========================================================================

  /// Kıssayı seslendirir: sesUrl varsa akış/yerel dosya, yoksa TTS anlatımı.
  Future<void> _kissaDinle(KissaKaydi kissa) async {
    if (_ttsKalanId == kissa.id && _ttsCalyor) {
      await _tts.stop();
      if (mounted) setState(() => _ttsCalyor = false);
      return;
    }
    try {
      await _tts.stop();
      if (_calanUrl != null) await _oynatici.stop();
      SesliOynatmaStore.kissaKaydet(kissa.id, kissa.baslik);
      if (kissa.sesUrl != null && kissa.sesUrl!.isNotEmpty) {
        await _urlSesiBaslat(
          url: kissa.sesUrl!,
          baslik: kissa.baslik,
          manifestAd: kissa.baslik,
        );
        return;
      }
      await _tts.setSpeechRate(_ttsHiz());
      final metin = [kissa.ozet, ...kissa.metin, ...kissa.hikmetler].join('. ');
      // flutter_tts, Android'de motor bağlanamadığında speak() çağrısına
      // hiçbir yanıt dönmeyebilir (pending method call askıda kalır). Bu
      // yüzden sonsuz bekleme yerine zaman aşımı ile tespit edilir; aksi
      // hâlde "ne ses, ne hata" durumu oluşurdu.
      _ttsBasladi = false;
      final sonuc = await _tts
          .speak(metin)
          .timeout(const Duration(seconds: 12));
      if (sonuc == 1 && !_ttsBasladi) {
        // speak() başarılı döndü ama gerçek konuşma (onStart) gelmedi.
        // Cihazda Türkçe ses verisi/motor eksikliği veya bozuk bir TTS
        // motoru söz konusu; Android bunu sessizce geçer. Kısa bir pencere
        // verip hâlâ başlamadıysa kullanıcıya net hata gösterilir.
        await Future.delayed(const Duration(milliseconds: 1500));
      }
      if (mounted) {
        setState(() {
          _ttsKalanId = kissa.id;
          _ttsKalanBaslik = kissa.baslik;
          _ttsCalyor = _ttsBasladi;
          _ttsHata = _ttsBasladi
              ? null
              : AppLocalizations.of(context).t('sks.ttsPackageMissing');
        });
      }
    } on TimeoutException {
      if (!mounted) return;
      setState(() {
        _ttsCalyor = false;
        _ttsHata = AppLocalizations.of(context).t('sks.ttsNotStarted');
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _ttsCalyor = false;
          _ttsHata = AppLocalizations.of(context).t('sks.ttsFeedback');
        });
      }
    }
  }

  /// URL tabanlı sesi (yerel dosya varsa öncelikle) başlatır.
  Future<void> _urlSesiBaslat({
    required String url,
    required String baslik,
    String? manifestAd,
    int pozisyonMs = 0,
  }) async {
    if (!mounted) return;
    setState(() {
      _sesYukleniyor = true;
      _sesHata = null;
    });
    try {
      try {
        await _oynatici.stop();
      } catch (_) {}
      await _oynatici.setSpeed(SesliOynatmaStore.hiz.value);

      final yerelYol = MedyaIndirmeServisi.instance.yerelYolu(url);
      final kaynak = yerelYol != null
          ? AudioSource.uri(Uri.file(yerelYol))
          : AudioSource.uri(Uri.parse(url));

      await _oynatici.setAudioSource(kaynak);
      MuzikHandler.aktif?.medyaHaber(MediaItem(
        id: url,
        title: baslik,
        artist: 'Sesli Medya',
      ));
      RadyoOynaticiStore.calanKanal.value = null;
      await _oynatici.play();
      if (pozisyonMs > 0) {
        await _oynatici.seek(Duration(milliseconds: pozisyonMs));
      }
      if (mounted) {
        setState(() {
          _calanUrl = url;
          _calanBaslik = baslik;
          _sesCalyor = true;
          _sesYukleniyor = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _sesYukleniyor = false;
        _sesHata =
            AppLocalizations.of(context).t('sks.sourceUnreachableRetry');
      });
    }
  }

  Future<void> _podcastDinle(RadyoKanali kanal, {bool devamEt = false}) async {
    final ayniKanal = _calanUrl == kanal.url;
    if (ayniKanal && _sesCalyor) {
      await _oynatici.pause();
      if (mounted) setState(() => _sesCalyor = false);
      return;
    }
    if (ayniKanal && !_sesCalyor) {
      await _oynatici.play();
      if (mounted) setState(() => _sesCalyor = true);
      return;
    }
    try {
      await _tts.stop();
      if (mounted) {
        setState(() {
          _ttsKalanId = null;
          _ttsKalanBaslik = null;
          _ttsCalyor = false;
        });
      }
      final baslangicMs =
          devamEt && SesliOynatmaStore.sonKanalUrl.value == kanal.url
          ? SesliOynatmaStore.podcastPozisyonMs.value
          : 0;
      SesliOynatmaStore.kanalKaydet(kanal.url, kanal.ad);
      await _urlSesiBaslat(
        url: kanal.url,
        baslik: kanal.ad,
        manifestAd: kanal.ad,
        pozisyonMs: baslangicMs,
      );
    } catch (_) {}
  }

  /// TTS ve URL oynatıcısını tamamen durdurur (mini bar kapanır).
  Future<void> _tumuDurdur() async {
    await _tts.stop();
    await _oynatici.stop();
    SesliOynatmaStore.uykuSayaciniDurdur();
    if (mounted) {
      setState(() {
        _ttsKalanId = null;
        _ttsKalanBaslik = null;
        _ttsCalyor = false;
        _calanUrl = null;
        _calanBaslik = null;
        _sesCalyor = false;
        _sesYukleniyor = false;
      });
    }
  }

  /// Oynatma hızı seçici.
  Future<void> _hizMenusu() async {
    final l = AppLocalizations.of(context);
    final secili = await showModalBottomSheet<double>(
      context: context,
      backgroundColor: Renkler.yuzey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return ValueListenableBuilder<double>(
          valueListenable: SesliOynatmaStore.hiz,
          builder: (context, hiz, _) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.t('sks.speedTitle'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final h in _hizlar)
                    ListTile(
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: h == hiz
                          ? Renkler.vurgu.withValues(alpha: 0.18)
                          : null,
                      title: Text(
                        '${h == h.toInt() ? h.toInt() : h}×',
                        style: TextStyle(
                          color: h == hiz ? Renkler.vurgu : Colors.white70,
                          fontWeight: h == hiz
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: h == hiz
                          ? const UcdIkon(
                              ikon: Icons.check_circle_rounded,
                              renk: Colors.greenAccent,
                              boyut: 20,
                            )
                          : null,
                      onTap: () => Navigator.pop(sheetContext, h),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
    if (secili == null) return;
    SesliOynatmaStore.hizAyarla(secili);
    await _tts.setSpeechRate(_ttsHiz());
    if (_calanUrl != null) {
      await _oynatici.setSpeed(secili);
    }
    final hizGoster =
        '${secili == secili.toInt() ? secili.toInt() : secili}×';
    _bilgiGoster(l.t('sks.speedSet').replaceFirst('{hiz}', hizGoster));
  }

  /// Uyku zamanlayıcı menüsü.
  Future<void> _uykuMenusu() async {
    final l = AppLocalizations.of(context);
    final secim = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Renkler.yuzey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return ValueListenableBuilder<int?>(
          valueListenable: SesliOynatmaStore.uykuDk,
          builder: (context, seciliDk, _) {
            final secenekler = <(int, String)>[
              (0, l.t('sks.sleepOff')),
              (
                15,
                l.t('sks.sleepMinutes').replaceFirst('{dk}', '15')
              ),
              (
                30,
                l.t('sks.sleepMinutes').replaceFirst('{dk}', '30')
              ),
              (
                45,
                l.t('sks.sleepMinutes').replaceFirst('{dk}', '45')
              ),
              (
                60,
                l.t('sks.sleepMinutes').replaceFirst('{dk}', '60')
              ),
              (-1, l.t('sks.sleepEndOfSection')),
            ];
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.t('sks.sleepTitle'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l.t('sks.sleepSub'),
                    style: const TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  for (final (deger, etiket) in secenekler)
                    ListTile(
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: seciliDk == deger
                          ? Renkler.vurgu.withValues(alpha: 0.18)
                          : null,
                      title: Text(
                        etiket,
                        style: TextStyle(
                          color: seciliDk == deger
                              ? Renkler.vurgu
                              : Colors.white70,
                          fontWeight: seciliDk == deger
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: seciliDk == deger
                          ? const UcdIkon(
                              ikon: Icons.check_circle_rounded,
                              renk: Colors.greenAccent,
                              boyut: 20,
                            )
                          : null,
                      onTap: () => Navigator.pop(sheetContext, deger),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
    if (secim == null) return;
    if (secim == 0) {
      SesliOynatmaStore.uykuZamanlayici(null);
      _bilgiGoster(l.t('sks.sleepOffMsg'));
    } else if (secim == -1) {
      // Doğal tamamlanma (TTS completion / onPlayerComplete) zaten durdurur.
      SesliOynatmaStore.uykuZamanlayici(null);
      _bilgiGoster(l.t('sks.sleepEndMsg'));
    } else {
      SesliOynatmaStore.uykuZamanlayici(secim, durdugunda: _uykuBitti);
      _bilgiGoster(
        l.t('sks.sleepSetMsg').replaceFirst('{dk}', '$secim'),
      );
    }
  }

  void _uykuBitti() {
    final l = AppLocalizations.of(context);
    _tumuDurdur();
    _bilgiGoster(l.t('sks.sleepDoneMsg'));
  }

  // =========================================================================
  // ARAYÜZ
  // =========================================================================

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.seciliYuzey,
        title: Text(l.t('sks.title')),
        bottom: TabBar(
          controller: _tablar,
          indicatorColor: Renkler.vurgu,
          labelColor: Renkler.vurgu,
          unselectedLabelColor: Colors.white54,
          tabs: [
            Tab(text: l.t('sks.tabStories')),
            Tab(text: l.t('sks.tabPodcasts')),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tablar,
        children: [_sesliKissalarBolumu(), _podcastBolumu()],
      ),
      bottomNavigationBar: _miniOynaticiBar(),
    );
  }

  // =========================================================================
  // 1. SESLİ KISSALAR
  // =========================================================================

  Widget _sesliKissalarBolumu() {
    final l = AppLocalizations.of(context);
    final kisalar = _filtrelenmisKisalar();
    return Column(
      children: [
        _kisisellestirilmisKartlar(),
        _filtreSatiri(),
        if (_ttsHata != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
            child: Text(
              _ttsHata!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                '${kisalar.length} ${l.t('sks.recCount')} · ${_filtreOzeti()}',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
              const SizedBox(height: 8),
              if (kisalar.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      l.t('sks.noResults'),
                      style: const TextStyle(color: Colors.white54, fontSize: 13),
                    ),
                  ),
                ),
              for (final kissa in kisalar) _sesliKissaKarti(kissa),
            ],
          ),
        ),
      ],
    );
  }

  String _modAdi(String modId) {
    final l = AppLocalizations.of(context);
    return switch (modId) {
      'huzur' => l.t('sks.modHuzur'),
      'motivasyon' => l.t('sks.modMotivasyon'),
      'uyku' => l.t('sks.modUyku'),
      'cocuk' => l.t('sks.modCocuk'),
      'ogrenme' => l.t('sks.modOgrenme'),
      _ => modId,
    };
  }

  String _sureEtiketi(String sureId) {
    final l = AppLocalizations.of(context);
    return switch (sureId) {
      'mikro' => l.t('sks.sureMikro'),
      'kisa' => l.t('sks.sureKisa'),
      'orta' => l.t('sks.sureOrta'),
      'uzun' => l.t('sks.sureUzun'),
      _ => sureId,
    };
  }

  String _filtreOzeti() {
    final l = AppLocalizations.of(context);
    final parcalar = <String>[];
    if (_sureFiltresi != null) {
      parcalar.add(_sureEtiketi(_sureFiltresi!));
    }
    if (_modSecimi != null) {
      parcalar.add(_modAdi(_modSecimi!));
    }
    if (_aramaSorgusu.trim().isNotEmpty) parcalar.add(l.t('sks.filterSearch'));
    return parcalar.isEmpty ? l.t('sks.filterAll') : parcalar.join(' · ');
  }

  /// "Kaldığın Yerden Devam Et", "Günün Kıssası" ve bilgi notu.
  Widget _kisisellestirilmisKartlar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        children: [
          _bilgiNotu(),
          const SizedBox(height: 8),
          ValueListenableBuilder<String?>(
            valueListenable: SesliOynatmaStore.sonKissaId,
            builder: (context, sonId, _) {
              if (sonId == null) return const SizedBox.shrink();
              final kissa = KissalarVerileri.tumKisalar
                  .where((k) => k.id == sonId)
                  .firstOrNull;
              if (kissa == null) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _devamKarti(
                  ikon: Icons.play_circle_fill_rounded,
                  baslik: AppLocalizations.of(context).t('sks.continueListening'),
                  alt: '${kissa.emoji} ${kissa.baslik} · ${kissa.sureEtiketi}',
                  onTap: () => _kissaDinle(kissa),
                ),
              );
            },
          ),
          ValueListenableBuilder<String?>(
            valueListenable: SesliOynatmaStore.sonKanalUrl,
            builder: (context, sonUrl, _) {
              if (sonUrl == null) return const SizedBox.shrink();
              final kanallar = CanliYayinKonfigurasyonu.guncel.radyoKanallari;
              final kanal = kanallar.where((k) => k.url == sonUrl).firstOrNull;
              final ad = SesliOynatmaStore.sonKanalAd.value ??
                  AppLocalizations.of(context).t('sks.podcast');
              if (kanal == null) return const SizedBox.shrink();
              final pozisyon = SesliOynatmaStore.podcastPozisyonMs.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _devamKarti(
                  ikon: Icons.radio_rounded,
                  baslik:
                      AppLocalizations.of(context).t('sks.continuePodcast'),
                  alt: pozisyon > 0 ? '$ad · ${_saniyeFormati(pozisyon)}' : ad,
                  onTap: () => _podcastDinle(kanal, devamEt: true),
                ),
              );
            },
          ),
          if (_gununKissasi() case final gununKissasi?)
            _devamKarti(
              ikon: Icons.wb_twilight_rounded,
              baslik:
                  AppLocalizations.of(context).t('sks.storyOfTheDay'),
              alt:
                  '${gununKissasi.emoji} ${gununKissasi.baslik} · ${gununKissasi.sureEtiketi}',
              onTap: () => _kissaDinle(gununKissasi),
            ),
        ],
      ),
    );
  }

  Widget _bilgiNotu() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          UcdIkon(
            ikon: Icons.record_voice_over_rounded,
            renk: Renkler.vurgu,
            boyut: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              AppLocalizations.of(context).t('sks.infoNote'),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11.5,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _devamKarti({
    required IconData ikon,
    required String baslik,
    required String alt,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Renkler.bannerUst.withValues(alpha: 0.55),
              Renkler.bannerAlt.withValues(alpha: 0.55),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: UcdIkon(ikon: ikon, renk: Renkler.vurgu, boyut: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    baslik,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    alt,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white60, fontSize: 12),
                  ),
                ],
              ),
            ),
            const UcdIkon(
              ikon: Icons.play_circle_fill_rounded,
              renk: Colors.white54,
              boyut: 26,
            ),
          ],
        ),
      ),
    );
  }

  /// Arama + süre filtresi + mod seçici satırı.
  Widget _filtreSatiri() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _aramaKontrol,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).t('sks.searchHint'),
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 12.5),
              prefixIcon: const UcdIkon(
                ikon: Icons.search_rounded,
                renk: Colors.white38,
                boyut: 20,
              ),
              suffixIcon: _aramaSorgusu.isEmpty
                  ? null
                  : IconButton(
                      icon: const UcdIkon(
                        ikon: Icons.close_rounded,
                        renk: Colors.white38,
                        boyut: 18,
                      ),
                      onPressed: () {
                        _aramaKontrol.clear();
                        setState(() => _aramaSorgusu = '');
                      },
                    ),
              filled: true,
              fillColor: Renkler.kart,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (v) => setState(() => _aramaSorgusu = v),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 34,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _filtreChip(
                  etiket: '⏱ ${AppLocalizations.of(context).t('sks.all')}',
                  secili: _sureFiltresi == null,
                  onTap: () => setState(() => _sureFiltresi = null),
                ),
                for (final s in _sureFiltreleri)
                  _filtreChip(
                    etiket: _sureEtiketi(s.id),
                    secili: _sureFiltresi == s.id,
                    onTap: () => setState(() => _sureFiltresi = s.id),
                  ),
                const SizedBox(width: 6),
                Container(width: 1, color: Renkler.cerceve),
                const SizedBox(width: 6),
                _filtreChip(
                  etiket:
                      '✨ ${AppLocalizations.of(context).t('sks.allModes')}',
                  secili: _modSecimi == null,
                  onTap: () => setState(() => _modSecimi = null),
                ),
                for (final m in _modlar)
                  _filtreChip(
                    etiket: _modAdi(m.id),
                    ikon: UcdIkon(ikon: m.ikon, boyut: 12, renk: Colors.white54),
                    secili: _modSecimi == m.id,
                    onTap: () => setState(() => _modSecimi = m.id),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filtreChip({
    required String etiket,
    Widget? ikon,
    required bool secili,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: secili ? Renkler.vurgu.withValues(alpha: 0.2) : Renkler.kart,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: secili ? Renkler.vurgu : Renkler.cerceve,
              width: secili ? 1.4 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (ikon != null) ...[ikon, const SizedBox(width: 4)],
              Text(
                etiket,
                style: TextStyle(
                  color: secili ? Renkler.vurgu : Colors.white60,
                  fontSize: 11.5,
                  fontWeight: secili ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sesliKissaKarti(KissaKaydi kissa) {
    final caliyor = _ttsKalanId == kissa.id && _ttsCalyor;
    final urlCaliniyor =
        _calanUrl != null && _calanBaslik == kissa.baslik && _sesCalyor;
    final aktif = caliyor || urlCaliniyor;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: aktif ? Renkler.vurgu : Renkler.cerceve,
          width: aktif ? 1.4 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _kissaDinle(kissa),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: aktif
                    ? Renkler.vurgu.withValues(alpha: 0.25)
                    : Renkler.seciliYuzey,
                shape: BoxShape.circle,
              ),
              child: UcdIkon(
                ikon: aktif ? Icons.stop_circle_rounded : Icons.headphones_rounded,
                renk: aktif ? Colors.redAccent : Renkler.vurgu,
                boyut: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${kissa.emoji}  ${kissa.baslik}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  aktif
                      ? '🔊 '
                            '${AppLocalizations.of(context).t('sks.nowPlaying')}'
                      : kissa.ozet,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 5),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _kucukRozet(
                      ikon: Icons.schedule_rounded,
                      etiket: kissa.sureEtiketi,
                      renk: Renkler.acikVurgu,
                    ),
                    _kucukRozet(
                      ikon: Icons.record_voice_over_rounded,
                      etiket: kissa.seslendirenEtiketi,
                      renk: Renkler.vurgu,
                    ),
                    if (kissa.temalar.isNotEmpty)
                      _kucukRozet(
                        ikon: Icons.tag_rounded,
                        etiket: kissa.temalar.first,
                        renk: Renkler.vurgu,
                      ),
                    if (kissa.sesUrl == null)
                      _kucukRozet(
                        ikon: Icons.offline_pin_rounded,
                        etiket: AppLocalizations.of(context).t('sks.offline'),
                        renk: Colors.greenAccent,
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: [
                    _kucukButon(
                      ikon: aktif ? Icons.stop_rounded : Icons.play_arrow_rounded,
                      etiket: aktif
                          ? AppLocalizations.of(context).t('sks.stop')
                          : AppLocalizations.of(context).t('sks.listen'),
                      renk: aktif ? Colors.redAccent : Renkler.vurgu,
                      onTap: () => _kissaDinle(kissa),
                    ),
                    _kucukButon(
                      ikon: Icons.menu_book_rounded,
                      etiket: AppLocalizations.of(context).t('sks.read'),
                      renk: Renkler.acikVurgu,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => KissaDetayPage(kissa: kissa),
                        ),
                      ),
                    ),
                    if (kissa.sesUrl != null && kissa.sesUrl!.isNotEmpty)
                      _indirmeButonu(url: kissa.sesUrl!, ad: kissa.baslik),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kucukRozet({
    required IconData ikon,
    required String etiket,
    required Color renk,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: renk.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: renk.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          UcdIkon(ikon: ikon, renk: renk, boyut: 11),
          const SizedBox(width: 4),
          Text(
            etiket,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: renk,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kucukButon({
    required IconData ikon,
    required String etiket,
    required Color renk,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: renk.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: renk.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            UcdIkon(ikon: ikon, renk: renk, boyut: 14),
            const SizedBox(width: 4),
            Text(
              etiket,
              style: TextStyle(
                color: renk,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// İndirme / yerel oynatma durumunu gösteren buton.
  Widget _indirmeButonu({required String url, required String ad}) {
    return ValueListenableBuilder<Map<String, IndirmeKaydi>>(
      valueListenable: MedyaIndirmeServisi.instance.indirilenler,
      builder: (context, indirilenler, _) {
        final indirildi = indirilenler.containsKey(url);
        return ValueListenableBuilder<Set<String>>(
          valueListenable: MedyaIndirmeServisi.instance.calisan,
          builder: (context, calisan, _) {
            final indiriyor = calisan.contains(url);
            final l = AppLocalizations.of(context);
            return _kucukButon(
              ikon: indirildi
                  ? Icons.offline_pin_rounded
                  : indiriyor
                  ? Icons.hourglass_top_rounded
                  : Icons.download_rounded,
              etiket: indirildi
                  ? l.t('sks.downloaded')
                  : indiriyor
                  ? l.t('sks.downloading')
                  : l.t('sks.download'),
              renk: indirildi ? Colors.greenAccent : Colors.orangeAccent,
              onTap: () async {
                if (indirildi) {
                  await MedyaIndirmeServisi.instance.sil(url);
                  _bilgiGoster(l.t('sks.downloadDeleted'));
                } else if (!indiriyor) {
                  final ok = await MedyaIndirmeServisi.instance.indir(url, ad);
                  _bilgiGoster(
                    ok ? l.t('sks.downloadedOk') : l.t('sks.downloadFailed'),
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  // =========================================================================
  // 2. PODCASTLER & RADYO
  // =========================================================================

  Widget _podcastBolumu() {
    final kanallar = CanliYayinKonfigurasyonu.guncel.radyoKanallari;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: Row(
              children: [
                UcdIkon(ikon: Icons.radio_rounded, renk: Renkler.vurgu),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context).t('sks.podcastInfo'),
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_sesHata != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              _sesHata!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [for (final kanal in kanallar) _kanalKarti(kanal)],
          ),
        ),
      ],
    );
  }

  Widget _kanalKarti(RadyoKanali kanal) {
    final caliyor = _calanUrl == kanal.url;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: caliyor ? Renkler.vurgu : Renkler.cerceve,
          width: caliyor ? 1.4 : 1,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _podcastDinle(kanal),
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: caliyor
                    ? Renkler.vurgu.withValues(alpha: 0.25)
                    : Renkler.seciliYuzey,
                shape: BoxShape.circle,
              ),
              child: UcdIkon(
                ikon: caliyor && _sesCalyor ? Icons.pause_rounded : Icons.play_arrow_rounded,
                renk: caliyor ? Colors.redAccent : Renkler.vurgu,
                boyut: 26,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kanal.ad,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  caliyor
                      ? (_sesCalyor
                            ? '🔴 '
                                  '${AppLocalizations.of(context).t('sks.streaming')}'
                            : AppLocalizations.of(context)
                                  .t('sks.pausedResume'))
                      : kanal.aciklama,
                  style: const TextStyle(color: Colors.white54, fontSize: 11.5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (_sesYukleniyor && caliyor)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
    );
  }

  // =========================================================================
  // MİNİ OYNATICI ÇUBUĞU
  // =========================================================================

  Widget _miniOynaticiBar() {
    final baslik = _calanBaslik ?? _ttsKalanBaslik;
    final aktif = (_calanUrl != null || _ttsKalanId != null) && baslik != null;
    if (!aktif) return const SizedBox.shrink();
    final sesAktif = _calanUrl != null;
    final caliyor = sesAktif ? _sesCalyor : _ttsCalyor;
    return Container(
      decoration: BoxDecoration(
        color: Renkler.yuzey,
        border: Border(top: BorderSide(color: Renkler.cerceve)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (sesAktif) {
                    if (_sesCalyor) {
                      _oynatici.pause();
                      setState(() => _sesCalyor = false);
                    } else {
                      _oynatici.play();
                      setState(() => _sesCalyor = true);
                    }
                  } else {
                    if (_ttsCalyor) {
                      _tts.stop();
                      setState(() => _ttsCalyor = false);
                    } else {
                      _tts.stop();
                      final kissa = KissalarVerileri.tumKisalar
                          .where((k) => k.id == _ttsKalanId)
                          .firstOrNull;
                      if (kissa != null) _kissaDinle(kissa);
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Renkler.vurgu.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: UcdIkon(
                    ikon: caliyor ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    renk: Renkler.vurgu,
                    boyut: 26,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      baslik,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        ValueListenableBuilder<int?>(
                          valueListenable: SesliOynatmaStore.uykuKalanDk,
                          builder: (context, kalan, _) {
                            if (kalan == null) return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(
                                '🌙 $kalan dk',
                                style: const TextStyle(
                                  color: Colors.amberAccent,
                                  fontSize: 11,
                                ),
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder<double>(
                          valueListenable: SesliOynatmaStore.hiz,
                          builder: (context, hiz, _) {
                            return Text(
                              '${hiz == hiz.toInt() ? hiz.toInt() : hiz}× · '
                              '${sesAktif ? _pozisyonMetni() : 'TTS'}',
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 11,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: AppLocalizations.of(context).t('sks.speed'),
                icon: ValueListenableBuilder<double>(
                  valueListenable: SesliOynatmaStore.hiz,
                  builder: (context, hiz, _) => UcdIkon(
                    ikon: Icons.speed_rounded,
                    renk: Colors.white70,
                    boyut: 22,
                  ),
                ),
                onPressed: _hizMenusu,
              ),
              IconButton(
                tooltip: AppLocalizations.of(context).t('sks.sleepTimer'),
                icon: ValueListenableBuilder<int?>(
                  valueListenable: SesliOynatmaStore.uykuKalanDk,
                  builder: (context, kalan, _) => UcdIkon(
                    ikon: Icons.bedtime_rounded,
                    renk: kalan != null ? Colors.amberAccent : Colors.white70,
                    boyut: 22,
                  ),
                ),
                onPressed: _uykuMenusu,
              ),
              IconButton(
                tooltip: AppLocalizations.of(context).t('sks.stopClose'),
                icon: const UcdIkon(ikon: Icons.close_rounded, renk: Colors.white54, boyut: 22),
                onPressed: _tumuDurdur,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
