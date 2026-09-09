import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:islami_uygulama/main.dart';
import 'package:islami_uygulama/l10n/dil_hizmetleri.dart';
import 'package:islami_uygulama/services/gercek_bildirimler.dart';
import 'package:islami_uygulama/services/vakit_servisi.dart';

/// Kullanıcının tohumladığı bildirim/profil verisini silmeden test verisi ekler.
Future<void> vakitOnbellegiHazirla() async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now();
  final gun = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  await prefs.setBool('ayar_konum_otomatik', false);
  await prefs.setString('vakit_sehir', 'İstanbul');
  await prefs.setString('vakit_ulke', 'Türkiye');
  await prefs.setString('vakitler_gun', gun);
  await prefs.setBool('vakitler_dogrulanmis_v2', true);
  await prefs.setString('vakitler_saat_dilimi', 'Europe/Istanbul');
  // Bu veriler yalnızca UI test fikstürüdür; gerçek vakit doğrulaması değildir.
  await prefs.setString('vakitler_gunluk', jsonEncode(
    VakitServisi.varsayilan.map((v) => v.toJson()).toList()));
}

Future<void> uygulamayiAc(WidgetTester tester) async {
  DilHizmetleri.aktifDil.value = const Locale('tr');
  GercekBildirimler.testDurumunuSifirla();
  await vakitOnbellegiHazirla();
  addTearDown(() async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
  await tester.pumpWidget(const MyApp());
  // MyApp önce asenkron Localizations yükler. Timer ancak splash mount olunca başlar.
  for (var i = 0; i < 20 && find.byType(AcilisYuklemeEkrani).evaluate().isEmpty; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
  expect(find.byType(AcilisYuklemeEkrani), findsOneWidget,
      reason: 'Açılış ekranı yüklenmeli; test ana sayfaya kestirmeden gitmez.');
  expect(find.byType(AnaSayfa), findsNothing);
  await tester.pump(const Duration(seconds: 5));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 500));
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
  expect(find.byType(AnaSayfa), findsOneWidget,
      reason: '5 saniyelik açılış ve geçiş sonrası ana sayfa oluşmalı.');
}
