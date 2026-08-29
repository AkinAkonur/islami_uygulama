import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/ummet/yardim_kampanya_detay_page.dart';
import 'package:islami_uygulama/pages/ummet/yardim_kampanyalari_page.dart';
import 'package:islami_uygulama/services/ummet_verileri.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

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

  group('UmmetStore yardim kampanyalari', () {
    test('seed kampanyalar tutarlidir', () {
      expect(yardimKampanyalari, isNotEmpty);
      expect(yardimKampanyalari.length, 6);
      for (final k in yardimKampanyalari) {
        expect(k.id, isNotEmpty);
        expect(k.ad, isNotEmpty);
        expect(k.detay, isNotNull, reason: '${k.ad} detayı boş');
      }
    });

    test('kampanya destek sayaci artar ve okunur', () async {
      final once = await UmmetStore.kampanyaPayi('su_kuyusu');
      await UmmetStore.kampanyaDestekle('su_kuyusu');
      final sonra = await UmmetStore.kampanyaPayi('su_kuyusu');
      expect(sonra, once + 1);
    });
  });

  group('YardimKampanyalariPage', () {
    testWidgets('kartlari listeler ve detaya gider', (tester) async {
      await tester.pumpWidget(uygulama(const YardimKampanyalariPage()));
      await tester.pumpAndSettle();

      expect(find.text('Su Kuyusu Aç'), findsOneWidget);

      await tester.tap(find.text('Su Kuyusu Aç'));
      await tester.pumpAndSettle();

      expect(find.text('Kampanya Hakkında'), findsOneWidget);
      expect(find.text('Niyet Ettim'), findsOneWidget);
      expect(find.textContaining('Nasıl bağış yapılır'), findsOneWidget);
    });
  });

  group('YardimKampanyaDetayPage', () {
    testWidgets('detayda niyet etmek sayaci artirir', (tester) async {
      await tester.pumpWidget(
        uygulama(YardimKampanyaDetayPage(kampanya: yardimKampanyalari.first)),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('12.480 kardeş'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Niyet Ettim'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Niyet Ettim'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.textContaining('12.481 kardeş'),
        -300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.textContaining('12.481 kardeş'), findsOneWidget);
    });

    testWidgets('detay sayfasi tum alanlari gosterir', (tester) async {
      await tester.pumpWidget(
        uygulama(YardimKampanyaDetayPage(kampanya: yardimKampanyalari.first)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Su Kuyusu Aç'), findsOneWidget);
      expect(find.text('Kampanya Hakkında'), findsOneWidget);
      expect(find.text('Niyet Ettim'), findsOneWidget);
      expect(find.textContaining('İHH'), findsOneWidget);
    });
  });
}