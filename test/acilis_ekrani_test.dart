import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/pages/acilis_ekrani.dart';

Widget uygulama(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  testWidgets('Acilis ekrani marka ogelerini ve logoyu gosterir', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      uygulama(const AcilisEkrani(sonraki: Placeholder())),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('İslami Uygulama'), findsOneWidget);
    expect(find.text('Huzur & Manevi Yolculuk'), findsOneWidget);
    expect(
      find.byWidgetPredicate((w) {
        if (w is! Container) return false;
        final dek = w.decoration;
        return dek is BoxDecoration &&
            dek.image is DecorationImage;
      }),
      findsOneWidget,
    );
  });

  testWidgets('3 saniye sonra ana ekrana gecis yapar', (tester) async {
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

    await tester.pump(const Duration(milliseconds: 3000));
    await tester.pump(const Duration(milliseconds: 600));
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