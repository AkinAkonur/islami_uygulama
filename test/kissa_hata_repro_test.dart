import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/pages/kissalar_ve_peygamberler_page.dart';
import 'package:islami_uygulama/pages/sesli_kissalar_ve_podcastler_page.dart';

void main() {
  testWidgets('KissalarVePeygamberlerPage acilir', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: KissalarVePeygamberlerPage()),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Kıssalar ve Peygamberler'), findsOneWidget);
  });

  testWidgets('SesliKissalarVePodcastlerPage acilir', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SesliKissalarVePodcastlerPage()),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Sesli Kıssalar ve Podcastler'), findsOneWidget);
  });
}
