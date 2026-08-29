import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/acilis_ekrani.dart';

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
  testWidgets('Acilis ekrani marka ogelerini ve dokun-upuz ipucunu sunar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      uygulama(const AcilisEkrani(sonraki: Placeholder())),
    );
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump();

    expect(find.text('İslami Uygulama'), findsOneWidget);
    expect(find.text('Huzur & Manevi Yolculuk'), findsOneWidget);
    expect(find.text('Devam etmek için dokunun'), findsOneWidget);
  });

  testWidgets('Dokunulunca ana ekrana gecis yapar', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      uygulama(
        AcilisEkrani(sonraki: const DecoratedBox(decoration: BoxDecoration())),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('İslami Uygulama'));
    await tester.pumpAndSettle();

    expect(find.byType(AcilisEkrani), findsNothing);
  });
}