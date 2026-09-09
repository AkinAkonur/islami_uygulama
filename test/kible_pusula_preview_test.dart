import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/kible_pusula_page.dart';

void main() {
  testWidgets('Kible pusulasi 3D kasa render', (tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('hemanthraj/flutter_compass'),
      (call) async => null,
    );
    SharedPreferences.setMockInitialValues({
      'vakit_lat': 41.0,
      'vakit_lng': 28.9,
    });
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('tr'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('tr'), Locale('en')],
        debugShowCheckedModeBanner: false,
        home: const KiblePusulaPage(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 600));
    await expectLater(
      find.byType(KiblePusulaPage),
      matchesGoldenFile('gorsel/goldens/kible_pusula_kaaba_preview.png'),
    );
  });
}
