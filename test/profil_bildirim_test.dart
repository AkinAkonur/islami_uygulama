import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/main.dart';

String _gunKey(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> buyukEkran(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
  }

  void tohumBildirim(String baslik, String gun, {bool okundu = false}) {
    final now = DateTime.now();
    final zamansal = DateTime.parse('${_gunKey(now)}T12:00:00').add(
        gun == 'dun' ? const Duration(days: -1) : Duration.zero);
    SharedPreferences.setMockInitialValues({
      'bildirim_liste': jsonEncode([
        {
          'id': 'test_1',
          'tip': 'namaz',
          'baslik': baslik,
          'mesaj': 'İkindi 16:45 — kalan 15 dk',
          'zaman': zamansal.toIso8601String(),
          'hedef': 'namaz',
          'okundu': okundu,
          'sessiz': false,
        }
      ]),
      'bildirim_son_gun': _gunKey(now),
    });
  }

  testWidgets("Profil sayfasi avatar tiklamasiyla acilir", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.person_outline).first);
    await tester.pumpAndSettle();

    expect(find.text('Profilim'), findsOneWidget);
    expect(find.text('Fotoğraf Ekle'), findsOneWidget);
    expect(find.text('Manevi İstatistikler'), findsOneWidget);
    expect(find.text('Misafir Kardeş'), findsOneWidget);
  });

  testWidgets("Zil rozeti bildirim sayisini ve listeyi gosterir",
      (tester) async {
    await buyukEkran(tester);
    tohumBildirim('İkindi 16:45', 'bugun');

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.notifications_none));
    await tester.pumpAndSettle();

    expect(find.text('Bildirimler'), findsOneWidget);
    expect(find.text('Sessiz Yardımcı'), findsOneWidget);
    expect(find.text('İkindi 16:45'), findsOneWidget);
    expect(find.text('Bildirim Türleri'), findsOneWidget);
    expect(find.text('Kaza namaz sayım'), findsOneWidget);
    expect(find.text('Bugün'), findsOneWidget);
  });

  testWidgets("Sessiz cipi rozeti gizler", (tester) async {
    await buyukEkran(tester);
    tohumBildirim('İkindi 16:45', 'bugun');

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.volume_off));
    await tester.pumpAndSettle();

    expect(find.text('1'), findsNothing);
    expect(find.text('Sessiz'), findsOneWidget);
  });

  testWidgets("Dar ekranda ust satir tasmaz", (tester) async {
    tester.view.physicalSize = const Size(360, 740);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.byIcon(Icons.notifications_none), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
  });

  testWidgets("Isim kaydedildikten sonra ana ekrana donulur", (tester) async {
    await buyukEkran(tester);
    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.person_outline).first);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Ahmet');
    await tester.tap(find.text('Kaydet'));
    await tester.pumpAndSettle();

    expect(find.text('Profilim'), findsNothing);
    expect(find.byIcon(Icons.home_filled), findsOneWidget);
    expect(find.text('İsim kaydedildi'), findsOneWidget);
  });

  testWidgets("Bildirim tur ayarlari acilip kapatilabilir", (tester) async {
    await buyukEkran(tester);
    tohumBildirim('İkindi 16:45', 'bugun');

    await tester.pumpWidget(const MyApp());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.notifications_none));
    await tester.pumpAndSettle();

    final anahtar = find.byType(Switch).at(1);
    expect(tester.widget<Switch>(anahtar).value, isTrue);

    await tester.tap(anahtar);
    await tester.pumpAndSettle();

    expect(tester.widget<Switch>(anahtar).value, isFalse);
  });
}
