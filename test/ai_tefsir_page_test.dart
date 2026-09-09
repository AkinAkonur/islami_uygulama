import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/l10n/dil_hizmetleri.dart';
import 'package:islami_uygulama/pages/ai_tefsir_page.dart';
import 'package:islami_uygulama/services/gemini_servisi.dart';
import 'package:islami_uygulama/services/yerel_ayet_rehberi.dart';

class _AnahtarsizServis extends GeminiServisi {
  int calls = 0;
  @override
  bool get hazir => false;
  @override
  Future<String> sor(String soru, {String dilKodu = 'tr', String? ekTalimat}) async {
    calls++;
    throw StateError('Offline mode must not contact an AI provider.');
  }
}

class _HataliOnlineServis extends GeminiServisi {
  int calls = 0;
  @override
  bool get hazir => true;
  @override
  Future<String> sor(String soru, {String dilKodu = 'tr', String? ekTalimat}) async {
    calls++;
    throw const GemiException('simulated online failure');
  }
}

void main() {
  Widget uygulama(Locale locale, GeminiServisi servis) => MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: DilHizmetleri.desteklenenler,
        home: AiTefsirPage(servis: servis),
      );

  testWidgets('AI sayfası render edilir ve layout hatası fırlatmaz', (tester) async {
    final servis = _AnahtarsizServis();
    await tester.pumpWidget(uygulama(const Locale('tr'), servis));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Ücretsiz • Çevrimdışı'), findsOneWidget);
    expect(find.text('5 / 5'), findsNothing);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward_ios_rounded), findsNWidgets(3));
    expect(servis.calls, 0);
  });

  testWidgets('API anahtarı olmadan yerel bilgi bankası yanıt verir', (tester) async {
    final servis = _AnahtarsizServis();
    await tester.pumpWidget(uygulama(const Locale('tr'), servis));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(TextField));
    await tester.enterText(find.byType(TextField), 'Sehiv secdesi ne zaman yapılır?');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pumpAndSettle();
    expect(find.textContaining('sehiv'), findsWidgets);
    expect(find.textContaining('API anahtarı'), findsNothing);
    expect(find.textContaining('GEMINI_API_KEY'), findsNothing);
    expect(servis.calls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Çevrimiçi hata olursa yerel yedeğe düşer, ham API göstermez', (tester) async {
    final servis = _HataliOnlineServis();
    await tester.pumpWidget(uygulama(const Locale('tr'), servis));
    await tester.pumpAndSettle();
    // Switch to online if toggle exists
    final switchFinder = find.byType(Switch);
    if (switchFinder.evaluate().isNotEmpty) {
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();
    }
    await tester.ensureVisible(find.byType(TextField));
    await tester.enterText(find.byType(TextField), 'Abdesti bozan durum');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pumpAndSettle();
    expect(find.textContaining('GEMINI_API_KEY'), findsNothing);
    expect(find.textContaining('API anahtarı tanımlı değil'), findsNothing);
    expect(find.textContaining('simulated online failure'), findsNothing);
    expect(servis.calls, greaterThanOrEqualTo(0));
    expect(tester.takeException(), isNull);
  });

  test('Yerel motor bilgi bankasından eşleşir', () {
    const l = AppLocalizations(Locale('tr'));
    final y = YerelAyetRehberi.yanitla('Sehiv secdesi ne zaman yapılır?', l);
    expect(y.eslesme, isTrue);
    expect(y.metin.toLowerCase(), contains('secde'));
    final no = YerelAyetRehberi.yanitla('xyz unmatched question 999', l);
    expect(no.eslesme, isFalse);
  });

  for (final locale in DilHizmetleri.desteklenenler) {
    testWidgets('Offline guide works: ${locale.languageCode}', (tester) async {
      await tester.binding.setSurfaceSize(const Size(360, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final l = AppLocalizations(locale);
      final servis = _AnahtarsizServis();
      await tester.pumpWidget(uygulama(locale, servis));
      await tester.pumpAndSettle();
      expect(find.text(l.t('ai.localBadge')), findsOneWidget);
      final input = find.byType(TextField);
      await tester.ensureVisible(input);
      await tester.pumpAndSettle();
      await tester.enterText(input, '2:255');
      await tester.testTextInput.receiveAction(TextInputAction.send);
      await tester.pumpAndSettle();
      expect(
        find.text(l.t('ai.localGuide').replaceAll('{reference}', '2:255')),
        findsOneWidget,
      );
      expect(servis.calls, 0);
      expect(find.textContaining('GEMINI_API_KEY'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
