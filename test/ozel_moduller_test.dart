import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/main.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> buyukEkran(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  testWidgets("Ana sayfa gunluk maneviyat modullerini gosterir",
      (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('Günlük Maneviyat'), findsOneWidget);
    expect(find.text('Devam Et'), findsOneWidget);
    expect(find.text('Günlük Görevler'), findsOneWidget);
    expect(find.text('Cami & Konum'), findsOneWidget);
    expect(find.text('Hedef Çarkı'), findsOneWidget);
    expect(find.text('Hızlı Tesbih'), findsOneWidget);
    expect(find.textContaining('Ramazan Modu'), findsWidgets);
    expect(find.text('Keşfet'), findsOneWidget);
    expect(find.text('Widget Rehberi'), findsOneWidget);
    expect(find.text('Kıble Pusulası'), findsOneWidget);
    expect(find.text('Görsel Kılınış'), findsOneWidget);
  });

  testWidgets("Devam Et karti ozet sayfasini acar", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.text('Devam Et'));
    await tester.pumpAndSettle();

    expect(find.text("Kur'an'da kaldığın yer"), findsOneWidget);
    expect(find.text('Tesbih sayacın'), findsOneWidget);
    expect(find.text('Yarım kalan hatim'), findsOneWidget);
  });

  testWidgets("Gunluk Gorev sayfasi gorev ve seriyi isler", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.text('Günlük Görevler'));
    await tester.pumpAndSettle();

    expect(find.text('Namaz · 5 Vakit'), findsOneWidget);
    expect(find.text('Bugünün İyilikleri'), findsOneWidget);
    expect(find.text('0 günlük seri'), findsOneWidget);

    await tester.tap(find.text('Sabah Namazı'));
    await tester.pumpAndSettle();
    expect(find.text('1/5'), findsOneWidget);

    await tester.tap(find.text('1 Ayet Oku'));
    await tester.pumpAndSettle();
    expect(find.text('1/4'), findsOneWidget);
  });

  testWidgets("Hedef Carki sayfasi ilerlemeyi isler", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.text('Hedef Çarkı'));
    await tester.pumpAndSettle();

    expect(find.text('Manevi Hedef Çarkı'), findsOneWidget);
    expect(find.text('0 / 5 · hedef: 5 sayfa'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle_outline).first);
    await tester.pumpAndSettle();
    expect(find.text('1 / 5 · hedef: 5 sayfa'), findsOneWidget);
  });

  testWidgets("Ramazan Modu sayfasi geri sayim ve ozel gunler icerir",
      (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.textContaining('Ramazan Modu').first);
    await tester.pumpAndSettle();

    expect(find.text('Günlük Hatim Hedefi'), findsOneWidget);
    expect(find.text('Özel Günler'), findsOneWidget);
    expect(find.text('Ramazan\'a kalan'), findsOneWidget);
    expect(find.textContaining('İftar'), findsWidgets);
  });

  testWidgets("Konum ve Widget Rehberi sayfalari acilir", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.text('Cami & Konum'));
    await tester.pumpAndSettle();

    expect(find.text('Kıble yönün: 154° Güneydoğu'), findsOneWidget);
    expect(find.text('Yakınındaki Camiler'), findsOneWidget);
    expect(find.text('Süleymaniye Camii'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Widget Rehberi'));
    await tester.pumpAndSettle();

    expect(find.text('Widget Önizleme'), findsOneWidget);
    expect(find.text('Kurulum Adımları'), findsOneWidget);
  });
}
