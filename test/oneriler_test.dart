import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/oneriler_page.dart';

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

void main() {
  testWidgets('Oneriler sayfasi hedef adres, turlar ve formu sunar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(uygulama(const OnerilerPage()));
    await tester.pump();

    expect(find.text('Öneri & Hata Bildir'), findsOneWidget);
    expect(find.text('islamiuygulama@outlook.com'), findsOneWidget);
    expect(find.text('Öneri'), findsOneWidget);
    expect(find.text('Hata Bildir'), findsOneWidget);
    expect(find.text('E-posta ile Gönder'), findsOneWidget);
  });

  testWidgets('Bos mesajla gonder denendiginde uyari gosterir', (tester) async {
    tester.view.physicalSize = const Size(800, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(uygulama(const OnerilerPage()));
    await tester.pump();

    await tester.tap(find.text('E-posta ile Gönder'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Lütfen önce bir mesaj yazın.'), findsOneWidget);
  });
}