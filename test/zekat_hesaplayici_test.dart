import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/pages/ummet/zekat_hesaplayici_page.dart';
import 'package:islami_uygulama/services/ummet_verileri.dart';

void main() {
  late List<ZekatKalemi> kalemler;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    kalemler = zekatKalemleri.map((k) => k.kopya()).toList();
  });

  group('ZekatKalemi veri modeli', () {
    test('kalemler tutar ve oran tasir', () {
      expect(kalemler, isNotEmpty);
      final altin =
          kalemler.firstWhere((k) => k.ad == 'Altın / Gümüş');
      expect(altin.oran, 0.025);
      final tarim = kalemler.firstWhere((k) => k.ad == 'Tarım Ürünü');
      expect(tarim.oran, 0.10);
      final borc = kalemler.firstWhere((k) => k.ad == 'Borçlarım');
      expect(borc.dusulur, isTrue);
    });

    test('kopya orijinali degistirmez', () {
      final asil = zekatKalemleri.first;
      final kopya = asil.kopya();
      kopya.tutar = 999;
      expect(asil.tutar, 0);
    });
  });

  group('ZekatHesaplayiciPage', () {
    testWidgets('bolumler acilir ve hesaplama butonu gorunur', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ZekatHesaplayiciPage()));
      await tester.pumpAndSettle();

      expect(find.text('Nisap Ayarı'), findsOneWidget);
      expect(find.text('Altın Miktarı'), findsOneWidget);
      expect(find.text('Zekata Tabi Varlıklar (TL)'), findsOneWidget);
      expect(find.text('Fitre (Fıtır Sadakası)'), findsOneWidget);
      expect(find.text('Zekatımı Hesapla'), findsOneWidget);
      expect(find.text('Zekat & Sadaka Rehberi'), findsOneWidget);
    });

    testWidgets('altin fiyati girilince nisap ve altin zekati guncellenir',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ZekatHesaplayiciPage()));
      await tester.pumpAndSettle();

      // Gram altın fiyatını değiştir
      await tester.enterText(find.widgetWithText(TextField, 'Gram altın fiyatı (TL)'), '3000');
      await tester.pumpAndSettle();

      // 100 gram altın gir
      await tester.enterText(
          find.widgetWithText(TextField, 'Kaç gram altının var?'), '100');
      await tester.pumpAndSettle();

      // Nisap: 80 * 3000 = 240.000 TL ve 100 gram değer 300.000 TL > nisap
      expect(find.textContaining('240.000 TL'), findsWidgets);
      expect(find.textContaining('300.000 TL'), findsWidgets);
    });

    testWidgets('borc girilince matrahtan dusulur ve sonuc guncellenir',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ZekatHesaplayiciPage()));
      await tester.pumpAndSettle();

      // Nakit 300.000 TL (nisap ~192.000; 80 * 2400)
      await tester.enterText(
          find.widgetWithText(TextField, 'Nakit & Banka Bakiyesi'), '300000');
      await tester.pumpAndSettle();

      // Nisaba ulaşıldı, zekat %2,5 = 7.500
      expect(find.text('7.500 TL'), findsOneWidget);

      // Borç 200.000 gir, matrah 100.000'e düştü
      await tester.enterText(
          find.widgetWithText(TextField, 'Borçlarım'), '200000');
      await tester.pumpAndSettle();

      // Matrah 100.000 < nisap 192.000 -> zekat yok
      expect(find.textContaining('nisap sınırının'), findsOneWidget);
    });

    testWidgets('fitre hesabi kisi sayisi ile carpilir', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ZekatHesaplayiciPage()));
      await tester.pumpAndSettle();

      // Varsayılan: 1 kişi x 200 TL = 200
      expect(find.text('Toplam fitre: 200 TL'), findsOneWidget);

      await tester.enterText(find.widgetWithText(TextField, 'Kişi sayısı'), '4');
      await tester.pumpAndSettle();

      expect(find.text('Toplam fitre: 800 TL'), findsOneWidget);
    });

    testWidgets('rehber sorulari acilir', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ZekatHesaplayiciPage()));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Zekat & Sadaka Rehberi'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Nisap nedir?'));
      await tester.pumpAndSettle();

      expect(find.textContaining('asgari mal miktarı'), findsOneWidget);
    });
  });
}