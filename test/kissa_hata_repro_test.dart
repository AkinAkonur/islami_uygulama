import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/kissalar_ve_peygamberler_page.dart';
import 'package:islami_uygulama/pages/sesli_kissalar_ve_podcastler_page.dart';

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
  testWidgets('KissalarVePeygamberlerPage acilir', (tester) async {
    await tester.pumpWidget(
      uygulama(const KissalarVePeygamberlerPage()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Kıssalar ve Peygamberler'), findsOneWidget);
  });

  testWidgets('SesliKissalarVePodcastlerPage acilir', (tester) async {
    await tester.pumpWidget(
      uygulama(const SesliKissalarVePodcastlerPage()),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Sesli Kıssalar ve Podcastler'), findsOneWidget);
  });
}
