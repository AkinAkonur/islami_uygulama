import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/pages/kible_pusula_page.dart';

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
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: KiblePusulaPage(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 600));
    await expectLater(
      find.byType(KiblePusulaPage),
      matchesGoldenFile('gorsel/goldens/kible_pusula_kaaba_preview.png'),
    );
  });
}
