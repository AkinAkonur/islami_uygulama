import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/pages/hatim_duasi_page.dart';

void main() {
  const ttsChannel = MethodChannel('flutter_tts');

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    // flutter_tts çağrılarını sahte yanıtlarla besle; testlerde
    // MissingPluginException üretilmesin.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ttsChannel, (call) async => 1);
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ttsChannel, null);
  });

  testWidgets('Hatim Duası sayfası render edilir ve okuma butonu mevcuttur',
      (tester) async {
    final hatalar = <Object>[];
    final eski = FlutterError.onError;
    FlutterError.onError = (d) => hatalar.add(d.exception);
    try {
      await tester.pumpWidget(const MaterialApp(home: HatimDuasiPage()));
      await tester.pump();

      expect(find.text('Hatim Duası'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Hatim Duasını Oku'),
          findsOneWidget);
      expect(find.text('Okunuşla'), findsOneWidget);
      expect(find.text('Arapça'), findsOneWidget);
      // Görünür bölümlerden en az biri anlam bölümünü içerir.
      expect(find.text('ANLAMI'), findsWidgets);
    } finally {
      FlutterError.onError = eski;
    }
    expect(hatalar, isEmpty);
  });

  testWidgets('Okuma başlatılır, bölüm vurgulanır ve kontroller çalışır',
      (tester) async {
    final hatalar = <Object>[];
    final eski = FlutterError.onError;
    FlutterError.onError = (d) => hatalar.add(d.exception);
    try {
      await tester.pumpWidget(const MaterialApp(home: HatimDuasiPage()));
      await tester.pump();

      await tester
          .tap(find.widgetWithText(FilledButton, 'Hatim Duasını Oku'));
      await tester.pump();

      // Okuma sürerken kontroller, ilerleme ve aktif bölüm vurgusu görünür.
      expect(find.text('Duraklat'), findsOneWidget);
      expect(find.text('Durdur'), findsOneWidget);
      expect(find.text('Şu an okunuyor'), findsOneWidget);
      // "1 / 8": hem ilerleme çubuğunda hem aktif bölüm başlığında.
      expect(find.text('1 / 8'), findsNWidgets(2));

      // Duraklat -> kaldığı bölümden devam etme durumuna dönülür.
      await tester.tap(find.text('Duraklat'));
      await tester.pump();
      expect(find.text('Devam Et'), findsOneWidget);
      expect(find.text('Baştan'), findsOneWidget);

      // Baştan -> başlangıç durumuna dönülür.
      await tester.tap(find.text('Baştan'));
      await tester.pump();
      expect(find.widgetWithText(FilledButton, 'Hatim Duasını Oku'),
          findsOneWidget);
    } finally {
      FlutterError.onError = eski;
    }
    expect(hatalar, isEmpty);
  });

  testWidgets('Cihazda ses dili yoksa açıklayıcı hata gösterilir',
      (tester) async {
    // setLanguage/getLanguages dahil tüm TTS çağrıları başarısız döner.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(ttsChannel, (call) async => -1);

    final hatalar = <Object>[];
    final eski = FlutterError.onError;
    FlutterError.onError = (d) => hatalar.add(d.exception);
    try {
      await tester.pumpWidget(const MaterialApp(home: HatimDuasiPage()));
      await tester.pump();

      await tester
          .tap(find.widgetWithText(FilledButton, 'Hatim Duasını Oku'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.textContaining('ses yok'), findsOneWidget);
      expect(find.text('Hatim Duası'), findsOneWidget);
    } finally {
      FlutterError.onError = eski;
    }
    expect(hatalar, isEmpty);
  });
}