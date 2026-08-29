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

  testWidgets("Ana sayfa gunluk maneviyat modullerini gosterir", (
    tester,
  ) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    expect(find.text('Günlük Maneviyat'), findsOneWidget);
    expect(find.text('Devam Et'), findsOneWidget);
    expect(find.text('Günlük Görevler'), findsOneWidget);
    expect(find.text('Cami & Konum'), findsOneWidget);
    expect(find.text('Hedef Çarkı'), findsOneWidget);
    expect(find.text('Hızlı Tesbih'), findsWidgets);
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
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
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
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
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
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    await tester.tap(find.text('Hedef Çarkı'));
    await tester.pumpAndSettle();

    expect(find.text('Manevi Hedef Çarkı'), findsOneWidget);
    expect(find.text('0 / 5 · hedef: 5 sayfa'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle_outline_rounded).first);
    await tester.pumpAndSettle();
    expect(find.text('1 / 5 · hedef: 5 sayfa'), findsOneWidget);
  });

  testWidgets("Hedef carkina kullanici hedef ekler ve kaldirir", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    await tester.tap(find.text('Hedef Çarkı'));
    await tester.pumpAndSettle();

    expect(find.text('Yeni Hedef Ekle'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'İlmihal');
    await tester.enterText(find.byType(TextField).at(1), '3');
    await tester.tap(find.text('Ekle'));
    await tester.pumpAndSettle();

    expect(find.text('İlmihal'), findsOneWidget);
    expect(find.text('0 / 3 · hedef: 3 adet'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('İlmihal'), findsNothing);
    expect(find.text('Kur\'an'), findsOneWidget);
  });

  testWidgets("Tesbih sayfasi zikir ekler ve kaldirir", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    await tester.tap(find.text('Hızlı Tesbih').first);
    await tester.pumpAndSettle();

    expect(find.text('Dijital Akıllı Tesbih (Zikirmatik)'), findsOneWidget);
    expect(find.text('Sübhanallah (33)'), findsWidgets);

    await tester.tap(find.byIcon(Icons.add_circle_outline_rounded));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'Ya Rahman (33)');
    await tester.tap(find.text('Ekle'));
    await tester.pumpAndSettle();

    expect(find.text('Ya Rahman (33)'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Ya Rahman (33)'), findsNothing);
  });

  testWidgets("Ramazan Modu sayfasi geri sayim ve ozel gunler icerir", (
    tester,
  ) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    await tester.tap(find.textContaining('Ramazan Modu').first);
    await tester.pumpAndSettle();

    expect(find.text('Günlük Hatim Hedefi'), findsOneWidget);
    expect(find.text('Özel Günler'), findsOneWidget);
    expect(find.text('Ramazan\'a kalan'), findsOneWidget);
    expect(find.textContaining('İftar'), findsWidgets);

    await tester.tap(find.text('Hatim sayfasına git'));
    await tester.pumpAndSettle();

    expect(find.text('Hatimlerim'), findsOneWidget);
    expect(find.text('Bugün Kaç Sayfa Okudun?'), findsOneWidget);
    expect(find.text('Cüz İlerlemesi'), findsOneWidget);
  });

  testWidgets("Bugunun iyiliklerine kullanici iyilik ekler ve kaldirir", (
    tester,
  ) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    await tester.tap(find.text('Günlük Görevler'));
    await tester.pumpAndSettle();

    expect(find.text('Kendi iyiliğini ekle…'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField).last,
      'Bir komşuyu ziyaret et',
    );
    await tester.tap(find.byIcon(Icons.add_circle_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Bir komşuyu ziyaret et'), findsOneWidget);
    expect(find.text('1 Ayet Oku'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete_outline_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Bir komşuyu ziyaret et'), findsNothing);
    expect(find.text('1 Ayet Oku'), findsOneWidget);
  });

  testWidgets("Konum ve Widget Rehberi sayfalari acilir", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump();

    await tester.tap(find.text('Cami & Konum'));
    await tester.pumpAndSettle();

    expect(find.text('Bulunduğun Yer'), findsOneWidget);
    expect(find.text('Yakındaki Camiler'), findsOneWidget);
    expect(find.text('Bugünün Namaz Vakitleri'), findsOneWidget);
    expect(find.text('İmsak'), findsOneWidget);
    expect(find.text('Akşam'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_ios_new));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Widget Rehberi'));
    await tester.pumpAndSettle();

    expect(find.text('Widget Önizleme'), findsOneWidget);
    expect(find.text('Kurulum Adımları'), findsOneWidget);
  });
}
