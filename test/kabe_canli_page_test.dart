import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/kabe_canli_page.dart';

Widget uygulama(Widget child) {
  return MaterialApp(
    locale: const Locale('tr'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [Locale('tr'), Locale('en')],
    home: child,
  );
}

void main() {
  testWidgets('KabeCanliPage guvenli sekilde yuklenir ve bilgileri gosterir', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(uygulama(const KabeCanliPage()));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Kâbe-i Muazzama Canlı Yayın'), findsOneWidget);
    expect(find.text('Mescid-i Haram 7/24 Canlı'), findsOneWidget);
    expect(find.text('Otomatik Yedek Kaynak'), findsOneWidget);
    expect(find.text('Veri Tasarrufu'), findsOneWidget);
    expect(find.text('Mini Oynatıcı (PiP)'), findsOneWidget);
    expect(find.textContaining('Yayın kaynağı:'), findsOneWidget);
    expect(find.text('Tekrar Dene'), findsWidgets);
  });

  testWidgets('KabeCanliPage mod secici ve veri uyarisi metinlerini icerir', (
    tester,
  ) async {
    await tester.pumpWidget(uygulama(const KabeCanliPage()));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('🎧 Ses Modu (Arkaplanda Çal)'), findsOneWidget);
    expect(find.text('📺 Video'), findsOneWidget);
  });

  testWidgets('KabeCanliPage ses modunda ses kutusunu gosterir', (
    tester,
  ) async {
    await tester.pumpWidget(
      uygulama(const KabeCanliPage(baslangicModu: YayinModu.ses)),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('🎧 Kâbe Ses Modu'), findsOneWidget);
    expect(find.text('CANLI SES'), findsOneWidget);
    // Mod seçici görünür ve ses modu seçili durumdadır.
    expect(find.text('📺 Video'), findsOneWidget);
  });

  testWidgets('Medine modu Mescid-i Nebevi basligini gosterir', (tester) async {
    tester.view.physicalSize = const Size(800, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      uygulama(const KabeCanliPage(medineYayini: true)),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Mescid-i Nebevî Canlı Yayın'), findsOneWidget);
    expect(find.text('Mescid-i Nebevî 7/24 Canlı'), findsOneWidget);
    // Medine modunda Sünnet kanalı (Mescid-i Nebevî) akışı öncelenir.
    expect(find.textContaining('Sünnet TV'), findsOneWidget);
  });
}