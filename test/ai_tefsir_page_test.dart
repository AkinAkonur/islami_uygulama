import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/l10n/dil_hizmetleri.dart';
import 'package:islami_uygulama/pages/ai_tefsir_page.dart';

void main() {
  testWidgets('AI sayfası render edilir ve layout hatası fırlatmaz',
      (tester) async {
    final hatalar = <FlutterError>[];
    final eskiHandler = FlutterError.onError;
    FlutterError.onError = (details) {
      hatalar.add(details.exception as FlutterError);
    };

    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
        ],
        supportedLocales: DilHizmetleri.desteklenenler,
        home: AiTefsirPage(),
      ),
    );
    // İlk kare: layout + parlak yansıma animasyonu başlar.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.pump(const Duration(milliseconds: 600));

    FlutterError.onError = eskiHandler;

    expect(hatalar, isEmpty,
        reason:
            'AI sayfası render hatası fırlattı: ${hatalar.map((e) => e.toString()).join("; ")}');

    // Hak rozeti (dilden bağımsız) ve soru girişi görünür olmalı.
    expect(
      find.byWidgetPredicate(
        (w) => w is Text && w.data != null && w.data!.endsWith(': 5/5'),
      ),
      findsOneWidget,
    );
    expect(find.byType(TextField), findsOneWidget);
    // Kategori çipleri (horizontal liste) ve hızlı örnek çipleri mevcut.
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ActionChip), findsNWidgets(3));
  });
}