import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/l10n/dil_hizmetleri.dart';
import 'package:islami_uygulama/services/yerel_ayet_rehberi.dart';
import 'package:islami_uygulama/widgets/hizli_erisim_karti.dart';
import 'helpers/app_test_harness.dart';

void main() {
  test('Each locale has prayer labels and deterministic local references', () {
    for (final locale in DilHizmetleri.desteklenenler) {
      final l = AppLocalizations(locale);
      for (final name in ['İmsak', 'Güneş', 'Öğle', 'İkindi', 'Akşam', 'Yatsı']) {
        expect(l.kisaVakitAdi(name), isNotEmpty);
        expect(l.kisaVakitAdi(name), isNot(startsWith('v.short.')));
      }
      expect(l.hesapMetodu('3'), 'MWL');
      expect(l.hesapMetodu('unknown'), l.t('set.methodAuto'));
      expect(YerelAyetRehberi.referans(l.t('ai.cs.tefsir.1'), l), '112:1–4');
      expect(YerelAyetRehberi.referans(l.t('ai.cs.tefsir.2'), l), '2:255');
      expect(YerelAyetRehberi.referans(l.t('ai.cs.tefsir.3'), l), '55:13');
      expect(YerelAyetRehberi.referans('unmatched xyz', l), isNull);
    }
  });

  testWidgets('Four quick access tiles center their icons and labels', (tester) async {
    var taps = 0;
    final labels = ['Quran', 'Qibla Compass', 'Quick Tasbih', 'Duas'];
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Center(
      child: SizedBox(width: 400, child: Row(children: [
        for (final label in labels) Expanded(child: HizliErisimKarti(
          ikon: Icons.menu_book_outlined, label: label, onTap: () => taps++)),
      ])),
    ))));
    for (var i = 0; i < 4; i++) {
      final tile = find.byType(HizliErisimKarti).at(i);
      final icon = find.descendant(of: tile, matching: find.byType(Icon));
      expect(tester.getCenter(icon).dx, closeTo(tester.getCenter(tile).dx, 0.1));
      expect(tester.getCenter(find.text(labels[i])).dx, closeTo(tester.getCenter(tile).dx, 0.1));
      expect(tester.widget<Text>(find.text(labels[i])).textAlign, TextAlign.center);
      await tester.tap(tile);
      await tester.pumpAndSettle();
    }
    expect(taps, 4);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Home language changes update prayer names and greeting in place', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await uygulamayiAc(tester);
    DilHizmetleri.aktifDil.value = const Locale('en');
    addTearDown(() => DilHizmetleri.aktifDil.value = const Locale('tr'));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('Welcome, friend'), findsOneWidget);
    for (final name in ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Maghrib', 'Isha']) {
      expect(find.text(name), findsWidgets);
    }
    expect(find.textContaining('Prayer time:'), findsOneWidget);
    expect(find.textContaining('Vakit Saati:'), findsNothing);
    DilHizmetleri.aktifDil.value = const Locale('ms');
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('Subuh'), findsWidgets);
    expect(find.textContaining('Waktu solat:'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
