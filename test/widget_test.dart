import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/main.dart';
import 'package:islami_uygulama/pages/kuran_bolumu_page.dart';
import 'package:islami_uygulama/pages/namazlar_bolumu_page.dart';
import 'package:islami_uygulama/pages/ummet_bolumu_page.dart';
import 'package:islami_uygulama/pages/ummet/dunya_ummeti_page.dart';
import 'package:islami_uygulama/pages/ummet/islami_akis_page.dart';
import 'package:islami_uygulama/pages/ummet/manevi_halkalar_page.dart';
import 'package:islami_uygulama/pages/ummet/soru_cevap_page.dart';
import 'package:islami_uygulama/pages/ummet/yardim_kampanyalari_page.dart';
import 'package:islami_uygulama/pages/ummet/zekat_hesaplayici_page.dart';

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
    expect(find.text('🤲 Küresel Dua Ağı'), findsOneWidget);
    expect(find.text('Canlı Dua Duvarı'), findsOneWidget);
    expect(find.text('Mazlum Coğrafyalar & Bülten'), findsOneWidget);
  });

  testWidgets("Ummet merkez sayfasi tum modulleri icerir", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: UmmetBolumuPage()));
    await tester.pumpAndSettle();

    expect(find.text('💚 Yardımlaşma & İyilik'), findsOneWidget);
    expect(find.text('💬 İslami Akış & Manevi Halkalar'), findsOneWidget);
    expect(find.text('Dua Zincirleri'), findsOneWidget);
    expect(find.text('Dua Odaları'), findsOneWidget);
    expect(find.text('Küresel Yardım Kampanyaları'), findsOneWidget);
    expect(find.text('Zekât & Sadaka Hesaplayıcı'), findsOneWidget);
    expect(find.text('Günün Mesajı'), findsOneWidget);
  });

  testWidgets("Yeni Ummet modulleri acilir ve icerik gosterir", (tester) async {
    await tester.pumpWidget(const MaterialApp(home: YardimKampanyalariPage()));
    await tester.pumpAndSettle();
    expect(find.text('Su Kuyusu Aç'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Yetim Sponsoru Ol'), 200);
    expect(find.text('Yetim Sponsoru Ol'), findsOneWidget);

    await tester.pumpWidget(const MaterialApp(home: ZekatHesaplayiciPage()));
    await tester.pumpAndSettle();
    expect(find.text('Zekatımı Hesapla'), findsOneWidget);

    await tester.pumpWidget(const MaterialApp(home: SoruCevapPage()));
    await tester.pumpAndSettle();
    expect(find.text('Namaz & İbadet'), findsWidgets);

    await tester.pumpWidget(const MaterialApp(home: ManeviHalkalarPage()));
    await tester.pumpAndSettle();
    expect(find.text('Günde 1 Sayfa Kur\'an'), findsOneWidget);

    await tester.pumpWidget(const MaterialApp(home: IslamiAkisPage()));
    await tester.pumpAndSettle();
    expect(find.text('GÜNÜN MESAJI'), findsOneWidget);

    await tester.pumpWidget(const MaterialApp(home: DunyaUmmetiPage()));
    await tester.pumpAndSettle();
    expect(find.text('Müslüman Nüfus Dağılımı'), findsOneWidget);
  });
}
