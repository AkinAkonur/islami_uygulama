import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islami_uygulama/pages/namazlar_bolumu_page.dart';

/// Namazlar bölümünün (alt menü → Namazlar) görsel şablonunu üretir:
/// `flutter test test/gorsel/namazlar_bolumu_golden_test.dart --update-goldens`
/// PNG çıktısı: `test/goldens/namazlar_bolumu_page.png`
const _fontKlasoru = 'C:/src/flutter/bin/cache/artifacts/material_fonts/';

Future<void> _gercekFontlariYukle() async {
  final kayit = FontLoader('Roboto');
  for (final dosya in const [
    'roboto-regular.ttf',
    'roboto-medium.ttf',
    'roboto-bold.ttf',
    'roboto-italic.ttf',
  ]) {
    final yol = '$_fontKlasoru$dosya';
    if (!File(yol).existsSync()) continue;
    final bayt = File(yol).readAsBytesSync();
    final buffer = ByteData.view(bayt.buffer);
    kayit.addFont(Future.value(buffer));
  }
  await kayit.load();
}

void main() {
  testWidgets('Namazlar bölümü görsel şablonu', (tester) async {
    try {
      await _gercekFontlariYukle();
    } catch (_) {
      // Fontlar yoksa varsayılan test fontuyla üretilir (yalnızca şablon).
    }
    await tester.binding.setSurfaceSize(const Size(600, 1350));
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const NamazlarBolumuPage(),
      ),
    );
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(NamazlarBolumuPage),
      matchesGoldenFile('goldens/namazlar_bolumu_page.png'),
    );
  });
}