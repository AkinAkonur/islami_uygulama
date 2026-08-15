import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/pages/ummet/dua_zincirleri_page.dart';
import 'package:islami_uygulama/services/ummet_verileri.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('UmmetStore dua zincirleri', () {
    test('tumZincirler seed + bos kullanici listesi doner', () async {
      final liste = await UmmetStore.tumZincirler();
      expect(liste.length, greaterThanOrEqualTo(duaZincirleriSeed.length));
      expect(duaZincirleriSeed.length, greaterThanOrEqualTo(12));
    });

    test('zincirEkle kullanici zincirini ekler ve kalici saklar', () async {
      final zincir = await UmmetStore.zincirEkle(
        ad: 'Test Zinciri',
        detay: 'Küresel hedef: 1.000 • deneme',
        duaMetni: 'Allah\'ım test duası.',
        hedef: 1000,
      );
      expect(zincir.kullanicidan, isTrue);

      final liste = await UmmetStore.tumZincirler();
      expect(liste.where((z) => z.id == zincir.id), hasLength(1));

      final payOnce = await UmmetStore.zincirPayi(zincir.id);
      await UmmetStore.zincirKatil(zincir.id, 5);
      final paySonra = await UmmetStore.zincirPayi(zincir.id);
      expect(paySonra, payOnce + 5);
    });

    test('zincirSil kullanici zincirini kaldirir', () async {
      final zincir = await UmmetStore.zincirEkle(
        ad: 'Silinecek',
        detay: 'detay',
        duaMetni: 'dua',
        hedef: 100,
      );
      await UmmetStore.zincirSil(zincir.id);
      final liste = await UmmetStore.tumZincirler();
      expect(liste.where((z) => z.id == zincir.id), isEmpty);
    });
  });

  group('DuaZincirleriPage', () {
    testWidgets('seed zincirleri ve arama cubugu gosterir', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: DuaZincirleriPage()));
      await tester.pumpAndSettle();

      expect(find.text('Dua Zincirleri'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Zincire Katıl, Sevaba Ortak Ol'), findsOneWidget);
      expect(find.textContaining('zincir •'), findsOneWidget);
    });

    testWidgets('arama zincirleri filtreler', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: DuaZincirleriPage()));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'Gazze');
      await tester.pumpAndSettle();

      expect(find.text('Gazze için Fetih Suresi'), findsOneWidget);
      expect(find.text('Ümmetin Hidayeti için Dua'), findsNothing);
    });

    testWidgets('zincir olustur kisayolu acilir', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: DuaZincirleriPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Zincir Oluştur'));
      await tester.pumpAndSettle();

      expect(find.text('Dua Zinciri Oluştur'), findsOneWidget);
      expect(find.text('Oluştur'), findsOneWidget);
    });
  });
}