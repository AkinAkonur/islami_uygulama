import 'dart:async';
import 'dart:math' as math;

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:workmanager/workmanager.dart';
import 'l10n/app_localizations.dart';
import 'l10n/dil_hizmetleri.dart';
import 'services/renkler.dart';
import 'services/ayarlar_store.dart';
import 'services/bildirim_merkezi.dart';
import 'services/vakit_servisi.dart';
import 'services/gercek_bildirimler.dart';
import 'services/firebase_ai_backend.dart';
import 'tema.dart';
import 'pages/huzurlu_page.dart';
import 'pages/sukur_page.dart';
import 'pages/yorgun_page.dart';
import 'pages/umutlu_page.dart';
import 'pages/kaygili_page.dart';
import 'pages/daha_fazla_page.dart';
import 'pages/uc_boyutlu_medya_oynatici_page.dart';
import 'pages/dualar_page.dart';

import 'pages/tesbih_page.dart';
import 'pages/cuzler_page.dart';
import 'pages/ilham_page.dart';
import 'pages/kible_pusula_page.dart';
import 'pages/ai_tefsir_page.dart';
import 'pages/kuran_bolumu_page.dart';
import 'pages/ummet_bolumu_page.dart';
import 'pages/namazlar_bolumu_page.dart';
import 'pages/ramazan_modu_page.dart';
import 'pages/devam_et_page.dart';
import 'pages/gunluk_hedefler/gunluk_hedefler_page.dart';
import 'pages/konum_page.dart';
import 'pages/hedef_carki_page.dart';
import 'pages/widget_rehberi_page.dart';
import 'pages/bildirimler_sayfasi.dart';
import 'pages/profil_sayfasi.dart';
import 'services/canli_yayin_konfigurasyonu.dart';
import 'services/dini_gunler_servisi.dart';
import 'services/radyo_oynatici_store.dart';
import 'services/muzik_handler.dart';
import 'services/medya_kapak.dart';
import 'widgets/radyo_mini_oynatici.dart';
import 'widgets/kart_sekilleri.dart';
import 'widgets/tactile_kart.dart';
import 'widgets/hizli_erisim_karti.dart';
import 'screens/namaz_screen.dart';
import 'screens/gorsel_kilinis_screen.dart';
import 'pages/kuran/sure_listesi_page.dart';
import 'pages/soru_cevap/gunun_sorusu_karti.dart';
import 'pages/dua_kardesligi/dua_kardesligi_store.dart';
import 'screens/settings_screen.dart';

// ── 3D Zümrüt & Altın Varak paleti (ana sayfa) ──
const _zemin = Color(0xFF021711);
const _goldPrimary = Color(0xFFFFD54F);
const _goldAccent = Color(0xFFFFC107);
const _zumrut = Color(0xFF10B981);
const _zumrutAcik = Color(0xFF34D399);
const _zumrutKoyu = Color(0xFF047857);
const _metinBirincil = Colors.white;
const _metinIkincil = Color(0xFF94A3B8);
const _metinAltin = Color(0xFFFDE68A);

// Workmanager arka plan görevi: uygulama kapalıyken bile namaz vakitleri
// bildirimlerinin güncel kalması için günde bir kez zamanlamayı tazeler.
@pragma('vm:entry-point')
void bildirimleriTazele() {
  Workmanager().executeTask((task, inputData) async {
    try {
      await GercekBildirimler.kurulum(izinIste: false);
      await GercekBildirimler.planla();
    } catch (_) {
      return false;
    }
    return true;
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Uygulama ilk karesini OLDUĞUNCA ERKEN çizsin: beyaz ekran bekletmesini
  // kaldırmak için `runApp`’ı beklemeden hemen çağırırız. Ağ, bildirim ve veri
  // başlatmaları arka planda tamamlanır; sonuçlar `ValueNotifier`/stream’lerle
  // gelince UI zaten otomatik yeniden çizilir (saydam splash buna izin verir).
  runApp(const MyApp());
  unawaited(_oncekilerBaslat());
}

/// Uygulamanın ilk açılışında gereken başlatmaları arka planda (bloklamadan)
/// çalıştırır. Beyaz/splash ekranı bekletmemek için hiçbir adım `runApp`’ı
/// bekletmez.
Future<void> _baslatGuvenli(String ad, Future<void> Function() islem) async {
  try {
    await islem();
  } catch (e) {
    debugPrint('[Baslatma] $ad tamamlanamadı: $e');
  }
}

Future<void> _oncekilerBaslat() async {
  await Future.wait([
    _baslatGuvenli('Ayarlar', AyarlarStore.baslat),
    _baslatGuvenli('Dil', () async { await DilHizmetleri.baslat(); }),
  ]);
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    unawaited(_bildirimOnInit());
    unawaited(_arkaPlanInit());
  }
  unawaited(_baslatGuvenli('Firebase AI', FirebaseAiBackend.baslat));
  await Future.wait([
    _baslatGuvenli('Dua kardeşliği', DuaKardesligiStore.yukle),
    _baslatGuvenli('Yayın yapılandırması', CanliYayinKonfigurasyonu.baslat),
    _baslatGuvenli('Dini günler', () async { DiniGunlerServisi.baslat(); }),
    _baslatGuvenli('Medya', () async {
      await _baslatGuvenli('Medya kapağı', MedyaKapak.hazirla);
      await RadyoOynaticiStore.baslat();
      await _medyaServisBaslat();
    }),
  ]);
}

/// Arka plan medya servisini (audio_service) hazırlar: kilit ekranı kontrolü,
/// medya bildirimi ve arka planda kalma. İlk kareyi beklemez.
Future<void> _medyaServisBaslat() async {
  try {
    // Ses oturumunu "müzik" olarak aktif et: bildirim/kilit ekranı ile
    // çakışmaları, telefon aramalarında otomatik duraklamayı yönetir.
    final oturum = await AudioSession.instance;
    await oturum.configure(AudioSessionConfiguration.music());
    final handler = await AudioService.init(
      builder: () => MuzikHandler(
        RadyoOynaticiStore.player,
        onStop: RadyoOynaticiStore.durdur,
        onNext: RadyoOynaticiStore.sonraki,
        onPrevious: RadyoOynaticiStore.onceki,
      ),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.akinakonur.islamiuygulama.audio',
        androidNotificationChannelName: 'Medya oynatıcı',
        // Duraklatınca bildirim kalsın (kilit ekranından devam edebilmek için);
        // `ongoing` ile birlikte kullanılamaz (audio_service assert'ü).
        androidNotificationOngoing: false,
        androidStopForegroundOnPause: false,
        // Bildirim kartının vurgu (accent) rengi: tasarımdaki altın tonu.
        notificationColor: const Color(0xFFEAB308),
        // İleri/geri sar aralığı: kilit ekranı ve çekmece butonlarında kullanılır.
        fastForwardInterval: const Duration(seconds: 15),
        rewindInterval: const Duration(seconds: 15),
      ),
    );
    MuzikHandler.aktif = handler;
  } catch (e) {
    debugPrint('[Medya] audio_service başlatma hatası: $e');
  }
}

/// Ön plandaki OS bildirimlerini hazırlar ve zamanlar (runApp öncesi).
Future<void> _bildirimOnInit() async {
  try {
    await GercekBildirimler.kurulum();
    await GercekBildirimler.planla();
  } catch (e) {
    debugPrint('[Bildirim] _bildirimOnInit hatası: $e');
  }
}

/// Arka plan görevi (Workmanager): uygulama kapalıyken de bildirimleri güncel
/// tutar. Kaydı ilk kareyi beklemez; async sürer, sonucu beklemeden işlemi bırakır.
Future<void> _arkaPlanInit() async {
  if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
  try {
    await Workmanager().initialize(bildirimleriTazele);
    await Workmanager().registerPeriodicTask(
      'namaz-bildirim-tazeleme',
      'bildirimleriTazele',
      frequency: const Duration(hours: 24),
      initialDelay: const Duration(minutes: 10),
    );
  } catch (_) {
    // Arka plan gorevi kaydedilemezse bildirim tazelemesi atlanir;
    // uygulama acilisini engellememesi esasdir.
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: DilHizmetleri.aktifDil,
      builder: (context, dil, _) => ValueListenableBuilder<String?>(
        valueListenable: AyarlarStore.vurguKod,
        builder: (context, _, _) => ValueListenableBuilder<bool>(
          valueListenable: AyarlarStore.karanlikMod,
          builder: (context, karanlik, _) => MaterialApp(
            title: 'Huzur & Manevi Yolculuk',
            debugShowCheckedModeBanner: false,
            locale: dil,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              // Kullanıcının seçtiği dil `locale` ile zaten önceliklidir.
              // Bu callback yalnızca sistem dilinin desteklenmediği durumda
              // güvenli bir yedek seçer; sayfa yığını yeniden oluşturulmaz.
              if (deviceLocale == null) return const Locale('tr');
              for (final supported in supportedLocales) {
                if (supported.languageCode == deviceLocale.languageCode) {
                  return supported;
                }
              }
              return const Locale('tr');
            },
            supportedLocales: DilHizmetleri.desteklenenler,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              Tema.sistemCubuklari(karanlik: karanlik);
              return Stack(
                children: [
                  Positioned.fill(
                    child: Tema.zeminKatmani(karanlik: karanlik),
                  ),
                  child!,
                ],
              );
            },
            theme: Tema.kur(karanlik: false),
            darkTheme: Tema.kur(karanlik: true),
            themeMode: karanlik ? ThemeMode.dark : ThemeMode.light,
            home: const AcilisYuklemeEkrani(),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// 5 SANİYELİK MODERN AÇILIŞ EKRANI
// ===========================================================================
/// Kullanıcı uygulama ikonuna dokunduğunda ana sayfaya geçmeden önce gösterilir.
/// Görseller asset olarak eklenmediği için APK boyutunu büyütmez; bütün efektler
/// Flutter'ın vektörel çizimleriyle oluşturulur.
class AcilisYuklemeEkrani extends StatefulWidget {
  const AcilisYuklemeEkrani({super.key});

  @override
  State<AcilisYuklemeEkrani> createState() => _AcilisYuklemeEkraniState();
}

class _AcilisYuklemeEkraniState extends State<AcilisYuklemeEkrani>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animasyon;
  late final Animation<double> _gir;
  late final Animation<double> _parlama;
  Timer? _gecisZamani;

  @override
  void initState() {
    super.initState();
    _animasyon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..forward();
    _gir = CurvedAnimation(
      parent: _animasyon,
      curve: const Interval(0.0, 0.28, curve: Curves.easeOutCubic),
    );
    _parlama = CurvedAnimation(
      parent: _animasyon,
      curve: const Interval(0.12, 0.72, curve: Curves.easeInOut),
    );
    _gecisZamani = Timer(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => const AnaSayfa(),
          transitionDuration: const Duration(milliseconds: 420),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _gecisZamani?.cancel();
    _animasyon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final karanlik = Theme.of(context).brightness == Brightness.dark;
    final zemin = karanlik ? const Color(0xFF06120C) : const Color(0xFFF4F8F2);
    final yazi = karanlik ? Colors.white : const Color(0xFF14281B);
    final l = AppLocalizations.of(context);
    final ipuclari = <String>[
      l.t('splash.tip1'),
      l.t('splash.tip2'),
      l.t('splash.tip3'),
    ];
    return Scaffold(
      backgroundColor: zemin,
      body: AnimatedBuilder(
        animation: _animasyon,
        builder: (context, _) {
          final t = _animasyon.value;
          final ipucu = ipuclari[(t * ipuclari.length)
              .floor()
              .clamp(0, ipuclari.length - 1)];
          final kalan = (5 - (t * 5)).ceil().clamp(1, 5);
          return Stack(
            fit: StackFit.expand,
            children: [
              Tema.zeminKatmani(karanlik: karanlik),
              // Derinlik katmani: parallax yildizlar + perspektif zemin izgarasi.
              Positioned.fill(
                child: CustomPaint(
                  painter: _AcilisDerinlikBoyaci(
                    ilerleme: t,
                    karanlik: karanlik,
                  ),
                ),
              ),
              Center(
                child: FadeTransition(
                  opacity: _gir,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 3D amblem: perspektif matrisiyle donen kubbe + yorunge.
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0014)
                          ..rotateX(-0.28 + math.sin(t * math.pi) * 0.06)
                          ..rotateY(math.sin(t * math.pi * 2) * 0.42)
                          ..scale(0.86 + _gir.value * 0.14),
                        child: _AcilisAmblem3D(
                          parlama: _parlama.value,
                          donus: t * math.pi * 2,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Basligin da hafif derinligi var (yukaridan bakis).
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0016)
                          ..rotateX(-0.18),
                        child: Column(
                          children: [
                            Text(
                              l.t('splash.title'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: yazi,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 3.4,
                                shadows: const [
                                  Shadow(
                                    color: Color(0xAA000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 8,
                                  ),
                                  Shadow(
                                    color: Color(0x66EAB308),
                                    offset: Offset(0, -1),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l.t('splash.subtitle'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Renkler.acikVurgu.withValues(alpha: 0.9),
                                fontSize: 12,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 34),
                      // 3D kabartmali ilerleme cubugu (5 saniye).
                      Container(
                        width: 208,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0x33000000),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x55000000),
                              offset: Offset(0, 3),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: t.clamp(0.02, 1.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFFFFE9A8),
                                    Color(0xFFEAB308),
                                    Color(0xFF9A7208),
                                  ],
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x88EAB308),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Donen ipuclari: 5 saniye sikici gelmesin.
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 420),
                        child: Text(
                          ipucu,
                          key: ValueKey<String>(ipucu),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: yazi.withValues(alpha: 0.72),
                            fontSize: 12.5,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${l.t('splash.loading')}  $kalan',
                        style: TextStyle(
                          color: yazi.withValues(alpha: 0.5),
                          fontSize: 11,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Acilis ekraninin arka plan derinligi: perspektif zemin izgarasi ve
/// paralaks yildizlar. Asset kullanmaz; tamamen vektorel cizilir.
class _AcilisDerinlikBoyaci extends CustomPainter {
  _AcilisDerinlikBoyaci({required this.ilerleme, required this.karanlik});

  final double ilerleme;
  final bool karanlik;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Ufuk cizgisinden asagi acilan perspektif izgara (3D zemin hissi).
    final ufuk = h * 0.66;
    final cizgi = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..color = (karanlik ? const Color(0xFF7FE3B0) : const Color(0xFF2A7A55))
          .withValues(alpha: 0.16);

    for (var i = 1; i <= 9; i++) {
      final p = i / 9;
      final y = ufuk + (h - ufuk) * math.pow(p, 1.8).toDouble();
      canvas.drawLine(Offset(0, y), Offset(w, y), cizgi);
    }
    for (var i = -6; i <= 6; i++) {
      final x = w / 2 + i * (w / 8);
      canvas.drawLine(Offset(w / 2 + i * 12.0, ufuk), Offset(x, h), cizgi);
    }

    // Paralaks yildizlar: iki katman farkli hizda kayar.
    for (var katman = 0; katman < 2; katman++) {
      final hiz = katman == 0 ? 8.0 : 20.0;
      final yaricap = katman == 0 ? 1.1 : 1.9;
      final boya = Paint()
        ..color = const Color(0xFFFFF3CF)
            .withValues(alpha: katman == 0 ? 0.35 : 0.6);
      for (var i = 0; i < 34; i++) {
        final x = ((i * 137 + katman * 53) % w.toInt()).toDouble();
        final y = ((i * 89 + katman * 31) % ufuk.toInt()).toDouble() +
            math.sin(ilerleme * math.pi * 2 + i) * hiz * 0.25;
        final parlak = 0.5 + 0.5 * math.sin(ilerleme * math.pi * 4 + i);
        canvas.drawCircle(
          Offset(x, y),
          yaricap * (0.6 + parlak * 0.6),
          boya,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AcilisDerinlikBoyaci oldDelegate) =>
      oldDelegate.ilerleme != ilerleme || oldDelegate.karanlik != karanlik;
}

/// 3D amblem: katmanli golge/isik ile hacim kazanan kubbe ve etrafinda
/// perspektifle donen altin yorunge halkasi.
class _AcilisAmblem3D extends StatelessWidget {
  const _AcilisAmblem3D({required this.parlama, required this.donus});

  final double parlama;
  final double donus;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 156,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Yorunge halkasi (yatik elips = 3D yorunge hissi).
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0022)
              ..rotateX(1.15)
              ..rotateZ(donus),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Renkler.vurgu.withValues(alpha: 0.35 + parlama * 0.45),
                  width: 2.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Renkler.vurgu.withValues(alpha: 0.16 + parlama * 0.2),
                    blurRadius: 26,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          // Yorungede donen isik noktasi.
          Transform.translate(
            offset: Offset(
              math.cos(donus) * 68,
              math.sin(donus) * 26,
            ),
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFE9A8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEAB308).withValues(alpha: 0.9),
                    blurRadius: 14,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          // Kure govde: radyal gradyan + coklu golge ile 3D hacim.
          Container(
            width: 104,
            height: 104,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                center: Alignment(-0.42, -0.52),
                radius: 1.05,
                colors: [
                  Color(0xFF3FA277),
                  Color(0xFF1B6247),
                  Color(0xFF06140D),
                ],
                stops: [0.0, 0.48, 1.0],
              ),
              border: Border.all(color: Renkler.vurgu, width: 2.2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xAA000000),
                  offset: Offset(0, 10),
                  blurRadius: 18,
                ),
                BoxShadow(
                  color: Color(0x33FFFFFF),
                  offset: Offset(-4, -6),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Ust kenardaki keskin isik yansimasi (cam/metal hissi).
                Positioned(
                  top: 12,
                  left: 22,
                  child: Container(
                    width: 40,
                    height: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.42),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.mosque_rounded,
                  size: 52,
                  color: const Color(0xFFF4D77D),
                  shadows: const [
                    Shadow(
                      color: Color(0xCC000000),
                      offset: Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Zemine dusen elips golge (nesneyi yuzeye oturtur).
          Positioned(
            bottom: 2,
            child: Container(
              width: 96,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                gradient: RadialGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.45),
                    Colors.black.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // Parlayan yildiz aksani.
          Positioned(
            top: 6,
            right: 16,
            child: Opacity(
              opacity: 0.35 + parlama * 0.65,
              child: const Icon(
                Icons.auto_awesome,
                color: Color(0xFFFFE9A8),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// ANA SAYFA
// ===========================================================================
class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> with WidgetsBindingObserver {
  Timer? _bildirimDebounce;
  Uint8List? _profilResim;
  String _profilIsim = '';
  static final _testChannel = MethodChannel('com.akinakonur.islamiuygulama/test');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    VakitServisi.vakitGuncellendi.addListener(_bildirimleriYenile);
    _profiliYukle();
    _testChannel.setMethodCallHandler((call) async {
      if (call.method == 'testNotification') {
        debugPrint('[Test] MethodChannel tetiklendi');
        await GercekBildirimler.anlikTest();
      }
    });
  }

  void _bildirimleriYenile() {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    _bildirimDebounce?.cancel();
    _bildirimDebounce = Timer(const Duration(milliseconds: 800), () async {
      try {
        await GercekBildirimler.kurulum(izinIste: false);
        await GercekBildirimler.planla();
      } catch (e) {
        debugPrint('[Bildirim] Yenileme başarısız: $e');
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _bildirimleriYenile();
  }

  @override
  void dispose() {
    _bildirimDebounce?.cancel();
    VakitServisi.vakitGuncellendi.removeListener(_bildirimleriYenile);
    WidgetsBinding.instance.removeObserver(this);
    _testChannel.setMethodCallHandler(null);
    super.dispose();
  }

  Future<void> _profiliYukle() async {
    final resim = await ProfilStore.resimOku();
    final isim = await ProfilStore.isimOku();
    if (mounted) {
      setState(() {
        _profilResim = resim;
        _profilIsim = isim;
      });
    }
  }

  Future<void> _profilAc() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfilSayfasi()),
    );
    if (mounted) await _profiliYukle();
  }

  Future<void> _ayarlarAc() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AyarlarSayfasi()),
    );
    if (mounted) await _profiliYukle();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final isim = _profilIsim.trim().isEmpty ? l.t('h.friend') : _profilIsim.trim();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ═══ 1. ÜST BANT: HOŞGELDİN + BİLDİRİM + AYARLAR ═══
              _buildTopBar(context, l, isim),
              const SizedBox(height: 18),

              // ═══ 2. HERO VAKİT KARTI ═══
              _HeroVakitKarti(),
              const SizedBox(height: 18),

              // ═══ 3. HIZLI ERİŞİM (4'lü) ═══
              _buildQuickActions(context, l),
              const SizedBox(height: 24),

              // ═══ 4. DUYGU MODLARI ═══
              _buildSectionHeader(l.t('h.how'), fontSize: 14),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildMoodChip(context, "😊", l.t('m.huzurlu'), HuzurluPage()),
                    _buildMoodChip(context, "🙏", l.t('m.sukurlu'), SukurPage()),
                    _buildMoodChip(context, "😴", l.t('m.yorgun'), YorgunPage()),
                    _buildMoodChip(context, "🤲", l.t('m.umutlu'), UmutluPage()),
                    _buildMoodChip(context, "😟", l.t('m.kaygili'), KaygiliPage()),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ═══ 5. GÜNLÜK MANEVİYAT (ızgara 2 sütun) ═══
              _buildSectionHeader(l.t('h.daily')),
              const SizedBox(height: 12),
              _buildManeviyatGrid(context, l),
              const SizedBox(height: 24),

              // ═══ 6. RAMAZAN BANNER ═══
              TactileKart(
                kose: BorderRadius.circular(18),
                dolgu: const EdgeInsets.all(8),
                genislik: double.infinity,
                child: RamazanBanner(),
              ),
              const SizedBox(height: 24),

              // ═══ 7. KEŞFET & MODÜLLER ═══
              _buildSectionHeader(l.t('h.discover')),
              const SizedBox(height: 12),
              _buildHorizontalDiscover(context, l),
              const SizedBox(height: 24),

              // ═══ 8. GÜNÜN İÇERİĞİ (Tek kart, iç geçişli) ═══
              _GununIcerigiKarti(l: l),
              const SizedBox(height: 24),

              // ═══ 9. KIBLE BÖLÜMÜ ═══
              _buildSectionHeader(l.t('h.qiblaTitle')),
              const SizedBox(height: 12),
              _buildKibleCard(context, l),
              const SizedBox(height: 24),

              // ═══ 10. ALT İKONLU MENÜ ═══
              _buildBottomIconRow(context, l),
              const SizedBox(height: 24),

              // ═��═ 11. DAHA FAZLA ═══
              _buildDahaFazlaButton(context, l),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadyoMiniOynatici(
            onTamAc: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const UcBoyutluMedyaOynaticiPage(),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF01140E),
              border: const Border(
                top: BorderSide(color: _zumrut, width: 0.2),
              ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: _goldPrimary,
              unselectedItemColor: _metinIkincil.withValues(alpha: 0.6),
              selectedFontSize: 10,
              unselectedFontSize: 10,
              currentIndex: 0,
              onTap: (index) {
                if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NamazlarBolumuPage()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => AiTefsirPage()),
                  );
                } else if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => KuranBolumuPage()),
                  );
                } else if (index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => UmmetBolumuPage()),
                  );
                }
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: l.t('h.navHome')),
                BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: l.t('h.navNamaz')),
                BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: l.t('h.navAi')),
                BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: l.t('h.navKuran')),
                BottomNavigationBarItem(icon: Icon(Icons.groups_outlined), label: l.t('h.navUmmet')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // ÜST BANT
  // ────────────────────────────────────────────────────────────
  Widget _buildTopBar(BuildContext context, AppLocalizations l, String isim) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: _profilAc,
            child: Row(
              children: [
                // 48x48 profil: zümrüt gradyan + altın kenar + ışıma
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0D3D2E), Color(0xFF031C13)],
                    ),
                    border: Border.all(color: _goldAccent, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: _goldAccent.withValues(alpha: 0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _profilResim != null
                        ? Image.memory(
                            _profilResim!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.person, color: _goldPrimary, size: 26),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.t('h.welcome').replaceAll('{name}', isim),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _metinBirincil,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: _zumrutKoyu,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              l.t('h.hijriYear').replaceAll('{year}', '${ProfilStore.hicriYil()}'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _goldPrimary,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // Bildirim (42x42 zümrüt daire + gerçek rozet mekanizması)
        _BildirimZili(),
        const SizedBox(width: 8),
        // Ayarlar (aynı daire stili)
        GestureDetector(
          onTap: _ayarlarAc,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF072B20),
              border: Border.all(color: _zumrut.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  offset: const Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const UcdIkon(
              ikon: Icons.settings_outlined,
              renk: _goldPrimary,
              boyut: 20,
            ),
          ),
        ),
      ],
    );
  }

  // ────────────────────────────────────────────────────────────
  // HIZLI ERİŞİM (4'lü Dokunsal Kartlar)
  // ────────────────────────────────────────────────────────────
  Widget _buildQuickActions(BuildContext context, AppLocalizations l) {
    final actions = <Widget>[
      HizliErisimKarti(ikon: Icons.menu_book_outlined, label: l.t('h.navKuran'),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KuranBolumuPage()))),
      HizliErisimKarti(ikon: Icons.explore_outlined, label: l.t('mod.pusula'),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KiblePusulaPage()))),
      HizliErisimKarti(ikon: Icons.radio_button_checked, label: l.t('mod.hizli'),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TesbihPage()))),
      HizliErisimKarti(ikon: Icons.pan_tool_alt_outlined, label: l.t('h.duas'),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DualarPage()))),
    ];
    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth < 340 || MediaQuery.textScalerOf(context).scale(10) > 13 ? 2 : 4;
      final width = (constraints.maxWidth - 12 * (columns - 1)) / columns;
      return Wrap(spacing: 12, runSpacing: 12, children: [
        for (final action in actions) SizedBox(width: width, child: action),
      ]);
    });
  }

  // ────────────────────────────────────────────────────────────
  // YATAY MODÜL LİSTESİ (Günlük Maneviyat)
  // ────────────────────────────────────────────────────────────
  Widget _buildManeviyatGrid(BuildContext context, AppLocalizations l) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.2,
      children: [
        _ManeviyatKutusu(
          ikon: Icons.play_circle_fill_outlined,
          renk: Renkler.acikZumrutSabit,
          baslik: l.t('mod.devam'),
          altMetin: '',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DevamEtPage())),
        ),
        _ManeviyatKutusu(
          ikon: Icons.local_fire_department_outlined,
          renk: _goldAccent,
          baslik: l.t('mod.gorev'),
          altMetin: '',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GunlukHedeflerPage())),
        ),
        _ManeviyatKutusu(
          ikon: Icons.mosque_outlined,
          renk: Renkler.acikVurgu,
          baslik: l.t('mod.cami'),
          altMetin: l.t('mod.camiAlt'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KonumPage())),
        ),
        _ManeviyatKutusu(
          ikon: Icons.donut_large_outlined,
          renk: _zumrutAcik,
          baslik: l.t('mod.carki'),
          altMetin: l.t('mod.carkiAlt'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HedefCarkiPage())),
        ),
        _ManeviyatKutusu(
          ikon: Icons.radio_button_checked,
          renk: _goldAccent,
          baslik: l.t('mod.hizli'),
          altMetin: '',
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TesbihPage())),
        ),
        _ManeviyatKutusu(
          ikon: Icons.headphones_outlined,
          renk: _zumrutAcik,
          baslik: l.t('mod.dinle'),
          altMetin: l.t('mod.dinleAlt'),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SureListesiPage())),
        ),
      ],
    );
  }

  // ────────────────────────────────────────────────────────────
  // YATAY KEŞFET LİSTESİ
  // ────────────────────────────────────────────────────────────
  Widget _buildHorizontalDiscover(BuildContext context, AppLocalizations l) {
    return SizedBox(
      height: 72,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ModuleCard(
              ikon: Icons.widgets_outlined,
              renk: Renkler.vurgu,
              baslik: l.t('mod.widget'),
              altMetin: l.t('mod.widgetAlt'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WidgetRehberiPage())),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ModuleCard(
              ikon: Icons.explore_outlined,
              renk: Renkler.acikVurgu,
              baslik: l.t('mod.pusula'),
              altMetin: l.t('mod.pusulaAlt'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KiblePusulaPage())),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _ModuleCard(
              ikon: Icons.self_improvement_outlined,
              renk: Renkler.zumrutSabit,
              baslik: l.t('mod.gorsel'),
              altMetin: l.t('mod.gorselAlt'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GorselKilinisScreen())),
            ),
          ),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // BÖLÜM BAŞLIĞI
  // ────────────────────────────────────────────────────────────
  Widget _buildSectionHeader(String title, {double fontSize = 15}) {
    return Text(
      title,
      style: TextStyle(
        color: _metinAltin,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // KIBLE KARTI
  // ────────────────────────────────────────────────────────────
  Widget _buildKibleCard(BuildContext context, AppLocalizations l) {
    return TactileKart(
      genislik: double.infinity,
      kose: BorderRadius.circular(16),
      dolgu: const EdgeInsets.all(14),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KiblePusulaPage())),
      child: Row(
        children: [
          const UcdIkon(
            ikon: Icons.explore_outlined,
            renk: _goldAccent,
            boyut: 34,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('h.qiblaDir'),
                  style: const TextStyle(
                    color: _goldAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l.t('h.kaaba'),
                  style: const TextStyle(
                    color: _metinBirincil,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                const _KibleOzeti(),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.white38, size: 18),
        ],
      ),
    );
  }

  // ────────────────────────────────────────────────────────────
  // ALT İKON SIRASI
  // ──────────��─────────────────────────────────────────────────
  Widget _buildBottomIconRow(BuildContext context, AppLocalizations l) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconMenu(context, Icons.pan_tool_alt_outlined, l.t('h.duas'), _goldPrimary, DualarPage()),
        _buildIconMenu(context, Icons.filter_frames, l.t('h.cuzler'), _zumrutAcik, CuzlerPage()),
        _buildIconMenu(context, Icons.menu_book_outlined, l.t('h.ilham'), _goldPrimary, IlhamPage()),
      ],
    );
  }

  // ────────────────────────────────────────────────────────────
  // DAHA FAZLA BUTONU
  // ────────────────────────────────────────────────────────────
  Widget _buildDahaFazlaButton(BuildContext context, AppLocalizations l) {
    return TactileKart(
      altinCerceve: true,
      kose: BorderRadius.circular(20),
      dolgu: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DahaFazlaPage())),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l.t('h.more'),
            style: const TextStyle(
              color: _goldAccent,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: Colors.white54, size: 16),
        ],
      ),
    );
  }

  Widget _buildMoodChip(
    BuildContext context,
    String emoji,
    String text,
    Widget targetPage,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => targetPage)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF041F16),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: _zumrut.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 6),
              Text(
                text,
                style: const TextStyle(
                  color: _metinBirincil,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconMenu(
    BuildContext context,
    IconData icon,
    String label,
    Color iconColor,
    Widget targetPage,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UcdIkon(ikon: icon, renk: iconColor, boyut: 56),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: _metinIkincil, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// HERO VAKİT KARTI (Tam Genişlik, Gradient Arka Plan + Geri Sayım)
// ===========================================================================
class _HeroVakitKarti extends StatefulWidget {
  const _HeroVakitKarti();

  @override
  State<_HeroVakitKarti> createState() => _HeroVakitKartiState();
}

class _HeroVakitKartiState extends State<_HeroVakitKarti> {
  Timer? _sureci;
  List<_VakitBilgisi> _vakitler = const [];
  String _metotKod = '13';

  List<_VakitBilgisi> get _liste =>
      _vakitler.isNotEmpty ? _vakitler : _gunVakitleri;

  @override
  void initState() {
    super.initState();
    _bastaBaslat();
    _sureci = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
    VakitServisi.vakitGuncellendi.addListener(_vakitleriYukle);
  }

  Future<void> _bastaBaslat() async {
    await VakitServisi.ilkkonum();
    await _vakitleriYukle();
  }

  Future<void> _vakitleriYukle() async {
    final guncel = await VakitServisi.gunlukVakitler();
    final metotKod = await VakitServisi.aktifMetotKodu();
    if (!mounted) return;
    setState(() {
      _vakitler = guncel.map(_servisVaktiniCevir).toList();
      _metotKod = metotKod;
    });
  }

  @override
  void dispose() {
    _sureci?.cancel();
    VakitServisi.vakitGuncellendi.removeListener(_vakitleriYukle);
    super.dispose();
  }

  String _sureYaz(int sn) {
    String iki(int n) => n.toString().padLeft(2, '0');
    final s = sn % 60;
    final dk = (sn ~/ 60) % 60;
    final sa = sn ~/ 3600;
    return '${iki(sa)}:${iki(dk)}:${iki(s)}';
  }

  (int kalan, String vakitAdi, String vakitSaat, IconData vakitIkon, int index)
  _vakitHesapla(DateTime simdi) {
    final dakika = simdi.hour * 60 + simdi.minute;
    final saniye = dakika * 60 + simdi.second;
    int sonrakiIndex = _liste.indexWhere((v) => v.dakika > dakika);
    final bool geceGecisi = sonrakiIndex == -1;
    if (geceGecisi) sonrakiIndex = 0;
    final siradaki = _liste[sonrakiIndex];
    final int bitisSn = geceGecisi
        ? (_liste.first.dakika + 1440) * 60
        : siradaki.dakika * 60;
    final int kalan = bitisSn - saniye;
    return (kalan, siradaki.ad, siradaki.saat, siradaki.ikon, sonrakiIndex);
  }

  @override
  Widget build(BuildContext context) {
    final (kalan, vakitAdi, vakitSaat, _, aktifIndex) = _vakitHesapla(
      DateTime.now(),
    );
    final l = AppLocalizations.of(context);

    return TactileKart(
      altinCerceve: true,
      genislik: double.infinity,
      dolgu: const EdgeInsets.all(20),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const NamazScreen()),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: VakitServisi.guncelVeriVar,
            builder: (_, guncel, __) => guncel
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(l.t('v.unverified'),
                      style: const TextStyle(color: _goldPrimary, fontSize: 12)),
                  ),
          ),
          // Üst satır: yaklaşan vakit çipi + metot etiketi
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _goldAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _goldAccent.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: _goldAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        l.t('v.yaklasan'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _goldAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  l.hesapMetodu(_metotKod),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: _metinIkincil, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Orta satır: vakit adı + geri sayım + 3D Altın Güneş
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.vakitAdi(vakitAdi),
                      style: const TextStyle(
                        color: _metinBirincil,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _sureYaz(kalan),
                            style: const TextStyle(
                              color: _goldPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                          const TextSpan(
                            text: ' ',
                            style: TextStyle(color: _metinIkincil),
                          ),
                          TextSpan(
                            text: l.t('v.kaldi'),
                            style: const TextStyle(
                              color: _metinIkincil,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l.t('v.clock').replaceAll('{time}', vakitSaat),
                      style: const TextStyle(color: _zumrutAcik, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // 3D Altın Güneş: ışıma + beyaz merkez
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(
                    colors: [Color(0xFFFFEE58), Color(0xFFF57F17)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _goldAccent.withValues(alpha: 0.45),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _metinBirincil,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Alt satır: 6 vakit kutusu (aktif / pasif)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_liste.length, (i) {
              final v = _liste[i];
              final aktif = i == aktifIndex;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: aktif
                          ? _goldAccent.withValues(alpha: 0.18)
                          : const Color(0xFF042017),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: aktif
                            ? _goldAccent
                            : _zumrut.withValues(alpha: 0.15),
                        width: aktif ? 1.5 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          v.ikon,
                          size: 16,
                          color: aktif ? _goldPrimary : _metinIkincil,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l.kisaVakitAdi(v.ad),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: aktif ? _goldPrimary : _metinIkincil,
                            fontSize: 9,
                            fontWeight:
                                aktif ? FontWeight.bold : FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            v.saat,
                            maxLines: 1,
                            style: TextStyle(
                              color: aktif ? _goldPrimary : _metinIkincil,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// HIZLI EYLEM BUTONU (Dairesel, Glassmorphic)
// ===========================================================================
// ===========================================================================
// YATAY MODÜL KARTI (Tek satır, yatay kaydırmalı)
// ===========================================================================
class _ModuleCard extends StatelessWidget {
  final IconData ikon;
  final Color renk;
  final String baslik;
  final String altMetin;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.ikon,
    required this.renk,
    required this.baslik,
    required this.altMetin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TactileKart(
        onTap: onTap,
        kose: BorderRadius.circular(16),
        dolgu: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SizedBox(
          width: 150,
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: renk.withValues(alpha: 0.12),
                ),
                child: Icon(ikon, color: renk, size: 18),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      baslik,
                      style: const TextStyle(
                        color: _metinBirincil,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (altMetin.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        altMetin,
                        style: const TextStyle(
                          color: _metinIkincil,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// GÜNLÜK MANEVİYAT KUTUSU (ızgara hücresi)
// ===========================================================================
class _ManeviyatKutusu extends StatelessWidget {
  final IconData ikon;
  final Color renk;
  final String baslik;
  final String altMetin;
  final VoidCallback onTap;

  const _ManeviyatKutusu({
    required this.ikon,
    required this.renk,
    required this.baslik,
    required this.altMetin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TactileKart(
      onTap: onTap,
      kose: BorderRadius.circular(16),
      dolgu: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: renk.withValues(alpha: 0.12),
            ),
            child: Icon(ikon, color: renk, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: const TextStyle(
                    color: _metinBirincil,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (altMetin.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    altMetin,
                    style: const TextStyle(color: _metinIkincil, fontSize: 10),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// GÜNÜN İÇERİĞİ KARTI (Tab geçişli: Ayeti / Sorusu / Hadisi)
// ===========================================================================
class _GununIcerigiKarti extends StatefulWidget {
  final AppLocalizations l;
  const _GununIcerigiKarti({required this.l});

  @override
  State<_GununIcerigiKarti> createState() => _GununIcerigiKartiState();
}

class _GununIcerigiKartiState extends State<_GununIcerigiKarti> {
  int _aktif = 0;

  static const _verses = [
    {
      "arabic": "إِنَّ مَعَ الْعُسْرِ يُسْرًا",
      "translation": "Şüphesiz her zorlukla beraber bir kolaylık vardır.",
      "reference": "İnşirah Suresi, 6. Ayet",
    },
    {
      "arabic": "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
      "translation": "Bilesiniz ki, kalpler ancak Allah'ı anmakla huzur bulur.",
      "reference": "Ra'd Suresi, 28. Ayet",
    },
    {
      "arabic": "فَاذْكُرُونِي أَذْكُرْكُمْ",
      "translation": "Öyleyse beni anın ki ben de sizi anayım.",
      "reference": "Bakara Suresi, 152. Ayet",
    },
    {
      "arabic": "لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ",
      "translation": "Andolsun, eğer şükrederseniz elbette size nimetimi artırırım.",
      "reference": "İbrahim Suresi, 7. Ayet",
    },
    {
      "arabic": "وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ",
      "translation": "Kim Allah'a tevekkül ederse, O, kendisine yeter.",
      "reference": "Talak Suresi, 3. Ayet",
    },
    {
      "arabic": "لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ",
      "translation": "Allah'ın rahmetinden ümidinizi kesmeyin.",
      "reference": "Zümer Suresi, 53. Ayet",
    },
    {
      "arabic": "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا",
      "translation": "Allah, hiç kimseye gücünün üstünde bir yük yüklemez.",
      "reference": "Bakara Suresi, 286. Ayet",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l = widget.l;
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;

    return Column(
      children: [
        // Tab çubuğu
        Row(
          children: [
            _tabButonu(l.t('h.ayet'), 0, Icons.menu_book_outlined),
            _tabButonu(l.t('h.soru'), 1, Icons.help_outline),
            _tabButonu(l.t('h.ilham'), 2, Icons.auto_awesome),
          ],
        ),
        // İçerik
        AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _aktif == 0
                  ? GestureDetector(
                      key: const ValueKey<int>(0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const KuranBolumuPage(),
                          ),
                        );
                      },
                      child: _ayetIcerigi(dayOfYear, l),
                    )
                  : _aktif == 1
                      ? const GununSorusuKarti()
                      : GestureDetector(
                          key: const ValueKey<int>(2),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const IlhamPage(),
                              ),
                            );
                          },
                          child: _ilhamIcerigi(),
                        ),
            ),
            const SizedBox(height: 14),
          ],
    );
  }

  Widget _tabButonu(String text, int index, IconData ikon) {
    final aktif = _aktif == index;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _aktif = index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(ikon, size: 14, color: aktif ? _goldPrimary : _metinIkincil),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: aktif ? _goldPrimary : _metinIkincil,
                    fontSize: aktif ? 12 : 11,
                    fontWeight: aktif ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ayetIcerigi(int dayOfYear, AppLocalizations l) {
    final ayetIndex = dayOfYear % _verses.length;
    final v = _verses[ayetIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            v["arabic"]!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _metinAltin,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '"${l.t('ay.${ayetIndex + 1}')}"',
            style: const TextStyle(
              color: _metinBirincil,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l.t('ref.${ayetIndex + 1}'),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: _metinAltin,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${l.t('kn.viewAll')} →',
            textAlign: TextAlign.center,
            style: const TextStyle(color: _metinAltin, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _ilhamIcerigi() {
    final l = widget.l;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const UcdIkon(ikon: Icons.auto_awesome, renk: _goldAccent, boyut: 28),
          const SizedBox(height: 10),
          Text(
            l.t('h.ilhamDesc'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _metinBirincil,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l.t('h.ilhamExplore'),
            style: const TextStyle(
              color: _metinAltin,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// VAKİT KARTLARI (Canlı Yaklaşan Vakit + Sıradaki Vakit)
// ===========================================================================
class _KibleOzeti extends StatefulWidget {
  const _KibleOzeti();

  @override
  State<_KibleOzeti> createState() => _KibleOzetiState();
}

class _KibleOzetiState extends State<_KibleOzeti> {
  String _metin = '—';

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final k = await VakitServisi.koordinatOku();
    if (!mounted) return;
    setState(() {
      if (k == null) {
        _metin = AppLocalizations.of(context).t('h.locate');
      } else {
        final aci = VakitServisi.kibleAcisi(k.$1, k.$2);
        _metin = '${aci.round()}° ${VakitServisi.yonEtiketi(aci)}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _metin,
      style: const TextStyle(
        color: _metinIkincil,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _VakitBilgisi {
  final String ad;
  final String saat;
  final IconData ikon;
  final int dakika;

  const _VakitBilgisi(this.ad, this.saat, this.ikon, this.dakika);
}

IconData _vakitIkonu(String ad) {
  switch (ad) {
    case 'Güneş':
    case 'Öğle':
      return Icons.wb_sunny;
    case 'İkindi':
      return Icons.brightness_5;
    case 'Akşam':
      return Icons.wb_twilight;
    case 'Yatsı':
      return Icons.nights_stay;
    default:
      return Icons.wb_twilight;
  }
}

_VakitBilgisi _servisVaktiniCevir(VakitBilgisi v) =>
    _VakitBilgisi(v.ad, v.saatYaz, _vakitIkonu(v.ad), v.dakikaToplam);

const List<_VakitBilgisi> _gunVakitleri = [
  _VakitBilgisi("İmsak", "04:12", Icons.wb_twilight, 4 * 60 + 12),
  _VakitBilgisi("Güneş", "05:48", Icons.wb_sunny, 5 * 60 + 48),
  _VakitBilgisi("Öğle", "13:05", Icons.wb_sunny, 13 * 60 + 5),
  _VakitBilgisi("İkindi", "16:45", Icons.brightness_5, 16 * 60 + 45),
  _VakitBilgisi("Akşam", "20:17", Icons.wb_twilight, 20 * 60 + 17),
  _VakitBilgisi("Yatsı", "21:50", Icons.nights_stay, 21 * 60 + 50),
];

// ===========================================================================
// BİLDİRİM ZİLİ VE SESSİZ VAKİT ÇİPİ
// ===========================================================================
class _BildirimZili extends StatefulWidget {
  @override
  State<_BildirimZili> createState() => _BildirimZiliState();
}

class _BildirimZiliState extends State<_BildirimZili> {
  int _sayi = 0;

  @override
  void initState() {
    super.initState();
    BildirimMerkezi.rozet.addListener(_rozetDegisti);
    _yukle();
  }

  @override
  void dispose() {
    BildirimMerkezi.rozet.removeListener(_rozetDegisti);
    super.dispose();
  }

  void _rozetDegisti() {
    if (mounted) setState(() => _sayi = BildirimMerkezi.rozet.value);
  }

  Future<void> _yukle() async {
    await BildirimMerkezi.guncelle();
    await BildirimMerkezi.rozetGuncelle();
    if (mounted) setState(() => _sayi = BildirimMerkezi.rozet.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BildirimlerSayfasi()),
        ).then((_) => _yukle());
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF072B20),
          border: Border.all(color: _zumrut.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.45),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            const UcdIkon(
              ikon: Icons.notifications_none,
              renk: _metinBirincil,
              boyut: 22,
            ),
            if (_sayi > 0)
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF021711),
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: _goldAccent.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    '$_sayi',
                    style: const TextStyle(
                      color: _goldPrimary,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// GÜNLÜK MANEVİYAT MODÜL KARTLARI
// ===========================================================================
