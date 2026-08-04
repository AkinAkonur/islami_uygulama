import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/screens/gorsel_kilinis_screen.dart';

void main() {
  testWidgets("Gorsel kilinis ekrani 5 vakit ve abdest sekmesi icerir", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: GorselKilinisScreen()));
    await tester.pumpAndSettle();

    expect(find.text("5 Vakit Kılınış"), findsOneWidget);
    expect(find.text("Görsel Abdest"), findsOneWidget);
    expect(find.text("Namazın Temel Duruşları"), findsOneWidget);
    expect(find.text("Sabah"), findsOneWidget);
    expect(find.text("Yatsı"), findsOneWidget);

    final anaKaydir = find.byType(ListView).first;
    await tester.dragUntilVisible(
        find.text("1. Rekat (Sünnet)"), anaKaydir, const Offset(0, -250));
    expect(find.text("1. Rekat (Sünnet)"), findsOneWidget);
    await tester.dragUntilVisible(
        find.text("3. Rekat (Farz)"), anaKaydir, const Offset(0, -250));
    expect(find.text("3. Rekat (Farz)"), findsOneWidget);

    await tester.tap(find.text("Görsel Abdest"));
    await tester.pumpAndSettle();

    expect(find.text("Abdestin Farzları (4)"), findsOneWidget);
    expect(find.text("Abdestin Sünnetleri (6)"), findsOneWidget);
    expect(find.text("Yüzü yıkamak"), findsWidgets);
    final abdestKaydir = find.byType(ListView).first;
    await tester.dragUntilVisible(
        find.text("Başı mesh etmek"), abdestKaydir, const Offset(0, -250));
    expect(find.text("Başı mesh etmek"), findsOneWidget);
  });

  testWidgets("5 vakit secimi rekat planini degistirir", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: GorselKilinisScreen()));
    await tester.pumpAndSettle();

    final anaKaydir = find.byType(ListView).first;

    await tester.tap(find.text("Öğle"));
    await tester.pumpAndSettle();

    expect(find.text("Öğle Namazı: 10 rekat: 4 Sünnet + 4 Farz + 2 Son Sünnet"), findsOneWidget);
    await tester.dragUntilVisible(
        find.text("5. Rekat (Farz)"), anaKaydir, const Offset(0, -250));
    expect(find.text("5. Rekat (Farz)"), findsOneWidget);
    await tester.dragUntilVisible(
        find.text("9. Rekat (Son Sünnet)"), anaKaydir, const Offset(0, -250));
    expect(find.text("9. Rekat (Son Sünnet)"), findsOneWidget);

    await tester.dragUntilVisible(
        find.text("Akşam"), anaKaydir, const Offset(0, 250));
    await tester.tap(find.text("Akşam"));
    await tester.pumpAndSettle();

    expect(find.text("Akşam Namazı: 5 rekat: 3 Farz + 2 Sünnet"), findsOneWidget);
    await tester.dragUntilVisible(
        find.text("1. Rekat (Farz)"), anaKaydir, const Offset(0, -250));
    expect(find.text("1. Rekat (Farz)"), findsOneWidget);

    await tester.dragUntilVisible(
        find.text("Yatsı"), anaKaydir, const Offset(0, 250));
    await tester.tap(find.text("Yatsı"));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
        find.text("11. Rekat (Vitir)"), anaKaydir, const Offset(0, -250));
    expect(find.text("11. Rekat (Vitir)"), findsOneWidget);
    await tester.dragUntilVisible(
        find.text("13. Rekat (Vitir)"), anaKaydir, const Offset(0, -250));
    expect(find.text("13. Rekat (Vitir)"), findsOneWidget);
  });
}
