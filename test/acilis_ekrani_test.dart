import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/pages/acilis_ekrani.dart';

Widget uygulama(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  testWidgets('Acilis ekrani video kapanisini ve ipucunu gosterir', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      uygulama(const AcilisEkrani(sonraki: Placeholder())),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(AcilisEkrani), findsOneWidget);
    expect(find.text('Devam etmek için dokunun'), findsOneWidget);
  });

  testWidgets('Dokununca ana ekrana gecis yapar', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      uygulama(
        AcilisEkrani(sonraki: const DecoratedBox(decoration: BoxDecoration())),
      ),
    );
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.byType(AcilisEkrani));
    await tester.pumpAndSettle();

    expect(find.byType(AcilisEkrani), findsNothing);
    expect(
      find.byWidgetPredicate(
        (w) => w is DecoratedBox && w.decoration is BoxDecoration,
      ),
      findsOneWidget,
    );
  });

  testWidgets('3 saniye sonunda ana ekrana gecis yapar', (tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      uygulama(
        AcilisEkrani(sonraki: const DecoratedBox(decoration: BoxDecoration())),
      ),
    );
    await tester.pump();

    expect(find.byType(AcilisEkrani), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(AcilisEkrani), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    expect(find.byType(AcilisEkrani), findsNothing);
    expect(
      find.byWidgetPredicate(
        (w) => w is DecoratedBox && w.decoration is BoxDecoration,
      ),
      findsOneWidget,
    );
  });
}