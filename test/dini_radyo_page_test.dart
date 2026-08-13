import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/pages/daha_fazla_page.dart';
import 'package:islami_uygulama/services/canli_yayin_konfigurasyonu.dart';
import 'package:islami_uygulama/services/renkler.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget sarmal() => MaterialApp(
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Renkler.zemin,
    ),
    home: const DiniRadyoPage(),
  );

  setUp(() {
    CanliYayinKonfigurasyonu.aktif.value = CanliYayinKonfig.varsayilan();
  });

  testWidgets('DiniRadyoPage durayli sekilde acilir', (tester) async {
    await tester.pumpWidget(sarmal());
    await tester.pump();
    expect(find.text("Dini Radyo & İlahi Akışı"), findsOneWidget);
    expect(find.text('Dünya Radyoları'), findsOneWidget);
    expect(find.text('Diyanet Risalet Radyo'), findsWidgets);
  });

  testWidgets('Dunya radyolari dil filtresi ile filtrelenir', (tester) async {
    await tester.pumpWidget(sarmal());
    await tester.pump();

    await tester.tap(find.widgetWithText(ChoiceChip, 'Malayca'));
    await tester.pump();
    expect(find.text('IKIM.fm'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Tümü'));
    await tester.pump();
    expect(find.text('Diyanet Risalet Radyo'), findsWidgets);
  });
}