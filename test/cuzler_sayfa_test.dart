import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/cuz_okuma_page.dart';
import 'package:islami_uygulama/pages/cuzler_page.dart';
import 'package:islami_uygulama/pages/hatim_duasi_page.dart';
import 'package:islami_uygulama/services/cuz_hatim_store.dart';
import 'package:islami_uygulama/services/cuz_verileri.dart';

Widget _uygulama(Widget child) {
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('CuzHatimStore', () {
    test('başlangıçta tüm cüzler okunmamıştır', () async {
      final durum = await CuzHatimStore.oku();
      expect(durum, hasLength(30));
      expect(durum.every((e) => !e), isTrue);
    });

    test('cüz işaretleme kalıcıdır', () async {
      await CuzHatimStore.isaretle(5, true);
      final durum = await CuzHatimStore.oku();
      expect(durum[4], isTrue);
      expect(durum.where((e) => e).length, 1);

      await CuzHatimStore.isaretle(5, false);
      final durum2 = await CuzHatimStore.oku();
      expect(durum2[4], isFalse);
    });
  });

  group('CuzVerileri', () {
    test('cüz 1 varlıktan yüklenir', () async {
      final ayetler = await CuzVerileri.cuzuYukle(1);
      expect(ayetler, hasLength(148));
      expect(ayetler.first.sureNo, 1);
      expect(ayetler.first.metin, contains('بِسْمِ'));
    });

    test('ses URL si sure ve ayet ile üretilir', () {
      expect(CuzVerileri.ayetSesUrl(1, 1),
          'https://everyayah.com/data/Alafasy_128kbps/001001.mp3');
      expect(CuzVerileri.ayetSesUrl(36, 12),
          'https://everyayah.com/data/Alafasy_128kbps/036012.mp3');
    });
  });

  group('CuzlerPage', () {
    testWidgets('30 cüzü ve ilerlemeyi gösterir', (tester) async {
      await tester.pumpWidget(_uygulama(const CuzlerPage()));
      await tester.pumpAndSettle();

      expect(find.text('Hatim İlerlemesi'), findsOneWidget);
      expect(find.text('0 / 30'), findsOneWidget);
      expect(find.text('1. Cüz'), findsOneWidget);
      expect(find.text('Hatim Duası'), findsOneWidget);
      await tester.scrollUntilVisible(find.text('30. Cüz'), 400);
      expect(find.text('30. Cüz'), findsOneWidget);
    });

    testWidgets('cüze dokununca okuma sayfası açılır', (tester) async {
      await tester.pumpWidget(_uygulama(const CuzlerPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('1. Cüz'));
      await tester.pumpAndSettle();

      expect(find.byType(CuzOkumaPage), findsOneWidget);
      expect(find.text('1. Cüz'), findsOneWidget);
      await tester.pumpAndSettle();
      expect(find.textContaining('بِسْمِ'), findsWidgets);
      expect(find.text('Bu cüzü okudum'), findsOneWidget);
    });

    testWidgets('okunma işareti listeye yansır', (tester) async {
      await tester.pumpWidget(_uygulama(const CuzlerPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('2. Cüz'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Bu cüzü okudum'));
      await tester.pumpAndSettle();

      final prefs = await SharedPreferences.getInstance();
      final kayit = jsonDecode(prefs.getString('cuz_okundu')!) as List;
      expect(kayit[1], isTrue);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text('1 / 30'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
  });

  group('HatimDuasiPage', () {
    testWidgets('dua metinlerini içerir', (tester) async {
      await tester.pumpWidget(_uygulama(const HatimDuasiPage()));
      await tester.pumpAndSettle();

      expect(find.text('Hatim Duası'), findsOneWidget);
      expect(find.textContaining('el-Fâtiha'), findsOneWidget);
      expect(find.text('ANLAMI'), findsWidgets);
      expect(find.textContaining('أَلْحَمْدُ'), findsOneWidget);
    });
  });
}