import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/pages/paylasim_kartlari/paylasim_kartlari_studio_page.dart';

void main() {
  Future<void> buyukEkran(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  testWidgets("Paylasim kartlari studyosu ilk acilista icerik sunar", (
    tester,
  ) async {
    await buyukEkran(tester);
    await tester.pumpWidget(
      const MaterialApp(home: PaylasimKartlariStudioPage()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Paylaşım Kartları Stüdyosu'), findsOneWidget);
    expect(find.text('Tema Seçin'), findsOneWidget);
    expect(find.text('İçerik Seçin'), findsOneWidget);
    expect(find.textContaining('WhatsApp & Instagram'), findsOneWidget);
    expect(find.textContaining('İnşirâh Suresi, 6. Âyet'), findsOneWidget);
    expect(find.textContaining('ile oluşturuldu'), findsOneWidget);
  });

  testWidgets("Format kareye gecirilir ve tema degistirilebilir", (
    tester,
  ) async {
    await buyukEkran(tester);
    await tester.pumpWidget(
      const MaterialApp(home: PaylasimKartlariStudioPage()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kare (1:1)'));
    await tester.pumpAndSettle();
    expect(find.text('Kare (1:1)'), findsOneWidget);

    await tester.tap(find.text('Saf Işık'));
    await tester.pumpAndSettle();
    expect(find.text('Saf Işık'), findsOneWidget);
  });

  testWidgets("Hadis ve dua sekmeleri icerik yukler", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(
      const MaterialApp(home: PaylasimKartlariStudioPage()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('HADIS'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Niyetin Önemi'), findsWidgets);

    await tester.tap(find.text('Dua'));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
