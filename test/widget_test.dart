import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/main.dart';
import 'package:islami_uygulama/pages/kuran_bolumu_page.dart';
import 'package:islami_uygulama/pages/namazlar_bolumu_page.dart';
import 'package:islami_uygulama/pages/ummet_bolumu_page.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets("Ana sayfa yuklenir ve Kuran bolumu acilir", (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Bugün nasıl hissediyorsun?'), findsOneWidget);
    expect(find.text("Kur'an"), findsOneWidget);

    await tester.tap(find.text("Kur'an"));
    await tester.pumpAndSettle();

    expect(find.byType(KuranBolumuPage), findsOneWidget);
    expect(find.text('Sure Listesi (114)'), findsOneWidget);
    expect(find.text('Hatim Takibi'), findsOneWidget);
  });

  testWidgets("Namazlar sekmesi NamazlarBolumuPage acar", (tester) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.text('Namazlar'));
    await tester.pumpAndSettle();

    expect(find.byType(NamazlarBolumuPage), findsOneWidget);
    expect(find.text('Mezhep: Hanefî (Görsel Adım Rehberi)'), findsOneWidget);
    expect(find.text('📂 Namaz Modülleri (Hızlı Erişim)'), findsOneWidget);
    expect(find.text('Abdest & Gusül'), findsOneWidget);
  });

  testWidgets("Kuran merkez sayfasi bolumler icerir", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: KuranBolumuPage()));
    await tester.pumpAndSettle();

    expect(find.text('📖 Okuma'), findsOneWidget);
    expect(find.text('🎧 Dinleme'), findsOneWidget);
    expect(find.text('📈 Ezber & Takip'), findsOneWidget);
    expect(find.text('Sure Listesi (114)'), findsOneWidget);
    expect(find.text('Amme Cüzü & Kısa Sureler'), findsOneWidget);
  });

  testWidgets("Ummet sekmesi UmmetBolumuPage acar", (tester) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.text('Ümmet'));
    await tester.pumpAndSettle();

    expect(find.byType(UmmetBolumuPage), findsOneWidget);
    expect(find.text('🤲 Dua Kardeşliği'), findsOneWidget);
    expect(find.text('Canlı Dua Duvarı'), findsOneWidget);
    expect(find.text('Mazlum Coğrafyalar & Bülten'), findsOneWidget);
  });

  testWidgets("Ummet merkez sayfasi tum modulleri icerir", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: UmmetBolumuPage()));
    await tester.pumpAndSettle();

    expect(find.text('🌍 Küresel Ümmet & Dayanışma'), findsOneWidget);
    expect(find.text('📿 Ortak İbadet & Hedefler'), findsOneWidget);
    expect(find.text('Dua Zincirleri'), findsOneWidget);
    expect(find.text('Dua Odaları'), findsOneWidget);
    expect(find.text('Hatim Halkaları'), findsOneWidget);
    expect(find.text('Milyonluk Zikir Kampanyaları'), findsOneWidget);
    expect(find.text('Günlük İyilik Görevleri'), findsOneWidget);
  });
}
