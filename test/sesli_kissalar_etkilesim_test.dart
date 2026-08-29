import 'package:audioplayers_platform_interface/src/global_audioplayers_platform.dart';
import 'package:audioplayers_platform_interface/src/global_audioplayers_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/sesli_kissalar_ve_podcastler_page.dart';
import 'package:islami_uygulama/services/sesli_oynatma_store.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Audioplayers kanallarını sahte yanıtlarla besle; böylece plugin çağrıları
  // testte MissingPluginException ile kesilmez. create() sırasında üretilen
  // playerId üzerinden oynatıcının kendi event kanalı da taklit edilir.
  String? dinlenenPlayerId;
  const audioChannel = MethodChannel('xyz.luan/audioplayers');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(audioChannel, (call) async {
    if (call.method == 'create') {
      final args = call.arguments as Map<dynamic, dynamic>;
      dinlenenPlayerId = args['playerId'] as String;
      final playerId = dinlenenPlayerId!;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
            MethodChannel('xyz.luan/audioplayers/events/$playerId'),
            (call2) async => null,
          );
    }
    return null;
  });
  const audioGlobalChannel = MethodChannel('xyz.luan/audioplayers.global');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(audioGlobalChannel, (call) async => null);
  const audioGlobalEvents =
      MethodChannel('xyz.luan/audioplayers.global/events');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(audioGlobalEvents, (call) async => null);

  // flutter_tts: Android gerçek davranışına benzer olarak tüm metodlar 1
  // döner; speak() çağrısı gerçek motor gibi speak.onStart olayını da sıkar.
  const ttsChannel = MethodChannel('flutter_tts');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(ttsChannel, (call) async {
    if (call.method == 'speak') {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .handlePlatformMessage(
            'flutter_tts',
            const StandardMethodCodec()
                .encodeMethodCall(const MethodCall('speak.onStart', null)),
            (_) {},
          );
    }
    return 1;
  });

  setUp(() {
    // GlobalAudioScope.ensureInitialized, ilk testte tamamlanan `_initCompleter'ı
    // sonraki testte yeniden bekler ve FakeAsync zone farkı yüzünden asılı kalır;
    // bu yüzden ikinci testten itibaren AudioPlayer create edilemez. Global
    // platform örneğini her testte tazeleyerek temiz bir başlatma sağlanır.
    GlobalAudioplayersPlatformInterface.instance = GlobalAudioplayersPlatform();
    SharedPreferences.setMockInitialValues({});
    SesliOynatmaStore.uykuSayaciniDurdur();
    SesliOynatmaStore.sonKissaId.value = null;
    SesliOynatmaStore.sonKissaAd.value = null;
    SesliOynatmaStore.sonKanalUrl.value = null;
    SesliOynatmaStore.sonKanalAd.value = null;
    SesliOynatmaStore.podcastPozisyonMs.value = 0;
    SesliOynatmaStore.hiz.value = 1.0;
    SesliOynatmaStore.uykuDk.value = null;
    SesliOynatmaStore.uykuKalanDk.value = null;
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ttsChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(audioChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(audioGlobalChannel, null);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(audioGlobalEvents, null);
  });

  Future<void> yuksekEkran(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  Widget uygulama(Widget child) {
    return MaterialApp(
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('tr'), Locale('en')],
      home: child,
    );
  }

  testWidgets(
      'Dinle -> TTS calar, mini oynatici acilir, hiz/uyku degisir, uyku bitince kapanir',
      (tester) async {
    await yuksekEkran(tester);
    await tester.pumpWidget(
      uygulama(const SesliKissalarVePodcastlerPage()),
    );
    await tester.pumpAndSettle();

    // Bir kissa kartinda "Dinle" butonuna dokun.
    await tester.tap(find.text('Dinle').first);
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 50));

    // Mini oynatici çubuğu belirdi; durdur simgesi aktif.
    expect(find.byIcon(Icons.speed_rounded), findsOneWidget);
    expect(find.byIcon(Icons.pause_rounded), findsOneWidget);

    // Duraklat/oynat geçişi.
    await tester.tap(find.byIcon(Icons.pause_rounded));
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.byIcon(Icons.play_arrow_rounded).hitTestable(), findsWidgets);

    // Tekrar oynat (mini bardaki oynat simgesi; görünür olanı seç).
    await tester.tap(find.byIcon(Icons.play_arrow_rounded).hitTestable().first);
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.byIcon(Icons.pause_rounded), findsOneWidget);

    // Oynatma hızı menüsü: 1.5× seç.
    await tester.tap(find.byIcon(Icons.speed_rounded));
    await tester.pumpAndSettle();
    expect(find.text('⚡ Oynatma Hızı'), findsOneWidget);
    await tester.tap(find.text('1.5×'));
    await tester.pumpAndSettle();
    expect(find.text('1.5× · TTS'), findsOneWidget);

    // Uyku zamanlayıcı menüsü: 30 dakika seç.
    await tester.tap(find.byIcon(Icons.bedtime_rounded));
    await tester.pumpAndSettle();
    expect(find.text('🌙 Uyku Zamanlayıcısı'), findsOneWidget);
    await tester.tap(find.text('30 dakika'));
    await tester.pumpAndSettle();
    expect(find.text('🌙 30 dk'), findsOneWidget);

    // Uyku zamanlayıcısı süresinin dolması oynatmayı durdurur ve mini
    // çubuğu kaldırır (30 dakika sonra; fake saat hızlandırılır).
    await tester.pump(const Duration(minutes: 30));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.speed_rounded), findsNothing);

    // SnackBar zamanlayıcılarının süresini doldur.
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });

  testWidgets('Podcast sekmesinde radyo baslatilir, mini bar ile kapanir',
      (tester) async {
    await yuksekEkran(tester);
    await tester.pumpWidget(
      uygulama(const SesliKissalarVePodcastlerPage()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(Tab).at(1));
    await tester.pumpAndSettle();

    expect(find.textContaining('Kur\'an Radyosu'), findsOneWidget);

    // Radyo kanalının çember simgesine dokun (kartın tıklanabilir kısmı).
    // Kıssa sekmesi arka planda kaldığı için yalnızca görünür ikonlar seçilir.
    await tester.tap(find.byIcon(Icons.play_arrow_rounded).hitTestable().first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // play() yerel 'prepared' olayını bekler; platform olayını taklit et.
    final pid = dinlenenPlayerId;
    if (pid != null) {
      final bytes = const StandardMethodCodec().encodeSuccessEnvelope(
        <String, dynamic>{'event': 'audio.onPrepared', 'value': true},
      );
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .handlePlatformMessage(
            'xyz.luan/audioplayers/events/$pid',
            bytes,
            (_) {},
          );
    }
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // FramePositionUpdater her karede yeni kare talep ettiği için pumpAndSettle
    // kullanılmaz; sabit pump kullanılır.
    expect(find.textContaining('Canlı akış devam ediyor'), findsOneWidget);
    expect(find.byIcon(Icons.speed_rounded), findsOneWidget);

    // Kapat → mini bar ve canlı akış kapanır; frame üretici de durur.
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.speed_rounded), findsNothing);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });

  testWidgets('Arama sonucu bos olursa bos durum gosterilir, filtreler calisir',
      (tester) async {
    await yuksekEkran(tester);
    await tester.pumpWidget(
      uygulama(const SesliKissalarVePodcastlerPage()),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('sesli anlatım'), findsOneWidget);

    // Rastgele sorgu → boş durum.
    await tester.enterText(find.byType(TextField), 'zzzzzz');
    await tester.pump();
    expect(
      find.text('Aradığın kıssa bulunamadı. Filtreleri temizlemeyi dene.'),
      findsOneWidget,
    );

    // Temizle ikonu → liste geri gelir.
    await tester.tap(find.byIcon(Icons.close_rounded));
    await tester.pump();
    expect(
      find.text('Aradığın kıssa bulunamadı. Filtreleri temizlemeyi dene.'),
      findsNothing,
    );

    // Süre filtresi çipine dokun → özet satırı güncellenir.
    await tester.tap(find.text('<5 dk'));
    await tester.pump();
    expect(find.textContaining('sesli anlatım · <5 dk'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}