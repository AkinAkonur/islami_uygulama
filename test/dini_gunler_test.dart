import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/ramazan_modu_page.dart';
import 'package:islami_uygulama/services/dini_gunler_servisi.dart';
import 'package:islami_uygulama/services/manevi_store.dart';

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
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Diyanet tablosundaki Ramazan tarihleri doğru', () {
    // 1 Ramazan 1447 = 19 Şubat 2026 (Diyanet resmî takvimi)
    expect(ManeviStore.ramazanBaslangic(2026), DateTime(2026, 2, 19));
    expect(ManeviStore.ramazanBitis(2026), DateTime(2026, 3, 19));

    // 1 Ramazan 1448 = 8 Şubat 2027
    expect(ManeviStore.ramazanBaslangic(2027), DateTime(2027, 2, 8));
    expect(ManeviStore.ramazanBitis(2027), DateTime(2027, 3, 8));

    // 1 Ramazan 1449 = 28 Ocak 2028
    expect(ManeviStore.ramazanBaslangic(2028), DateTime(2028, 1, 28));
  });

  test('ramazanIci doğru aralıkta doğru sonuç verir', () {
    expect(ManeviStore.ramazanIci(DateTime(2027, 2, 8)), isTrue); // ilk gün
    expect(ManeviStore.ramazanIci(DateTime(2027, 2, 20)), isTrue);
    expect(ManeviStore.ramazanIci(DateTime(2027, 3, 8)), isTrue); // son gün (arefe)
    expect(ManeviStore.ramazanIci(DateTime(2027, 3, 9)), isFalse); // bayram
    expect(ManeviStore.ramazanIci(DateTime(2026, 8, 13)), isFalse);
    expect(ManeviStore.ramazanIci(DateTime(2027, 1, 1)), isFalse);
  });

  test('2030 çift Ramazan (5 Oca-3 Şub ve 26 Ara-24 Oca) doğru algılanır', () {
    expect(ManeviStore.ramazanIci(DateTime(2030, 1, 20)), isTrue);
    expect(ManeviStore.ramazanIci(DateTime(2030, 2, 3)), isTrue); // 30 Ramazan
    expect(ManeviStore.ramazanIci(DateTime(2030, 3, 1)), isFalse);
    expect(ManeviStore.ramazanIci(DateTime(2030, 12, 26)), isTrue);
    expect(ManeviStore.ramazanIci(DateTime(2031, 1, 24)), isTrue);
    expect(ManeviStore.ramazanIci(DateTime(2031, 1, 25)), isFalse);

    expect(ManeviStore.ramazanAraliklari(2030), hasLength(2));
  });

  test('sonrakiRamazanBaslangic bir sonraki dönemi bulur', () {
    // Bugün: 13 Ağu 2026 → bir sonraki Ramazan: 8 Şubat 2027
    expect(
      ManeviStore.sonrakiRamazanBaslangic(DateTime(2026, 8, 13)),
      DateTime(2027, 2, 8),
    );
    // İlk 2030 Ramazan'ı bittikten sonra → ikinci dönem
    expect(
      ManeviStore.sonrakiRamazanBaslangic(DateTime(2030, 2, 10)),
      DateTime(2030, 12, 26),
    );
    // İkinci dönem içinde → tablo dışı yıl için hicri yedek (Ara 2031 civarı)
    final tahmin = ManeviStore.sonrakiRamazanBaslangic(DateTime(2030, 12, 30));
    expect(tahmin.year, 2031);
    expect(tahmin.month, 12);
  });

  test('Tablo dışı yıllarda hicri yedek algoritma çalışır (2035)', () {
    final bas = DiniGunlerServisi.ramazanBaslangic(2035);
    // 2035 Ramazan'ı gerçekte Kasım başlarındadır (±1-2 gün, tabular yaklaşık).
    expect(bas.year, 2035);
    expect(
      bas.isBefore(DateTime(2035, 12, 1)) &&
          bas.isAfter(DateTime(2035, 10, 1)),
      isTrue,
      reason: '2035 Ramazan başlangıcı Ekim-Kasım aralığında olmalı: $bas',
    );
    // Geçmişe kayma hiç durmaz: 2040 yılı da 2039'dan önce olmalı.
    final birSonraki = DiniGunlerServisi.sonrakiRamazanBaslangic(
      DiniGunlerServisi.ramazanBaslangic(2040).subtract(
        const Duration(days: 1),
      ),
    );
    expect(birSonraki.year, 2040);
  });

  test('ozelGunler Diyanet tarihlerini içerir, sıralı ve ayrıştırılabilirdir', () {
    final liste = ManeviStore.ozelGunler;
    expect(liste, isNotEmpty);

    final mevlid = liste.firstWhere((g) => g['ad'] == 'Mevlid Kandili');
    expect(mevlid['tarih'], '2026-08-24'); // Diyanet 2026
    expect(
      liste.any((g) => g['tarih'] == '2027-03-05' && g['ad'] == 'Kadir Gecesi'),
      isTrue,
    );

    var onceki = '';
    for (final g in liste) {
      expect(g['tarih'], isNotNull);
      expect(g['ad'], isNotNull);
      expect(DateTime.tryParse(g['tarih']!), isNotNull);
      expect(
        g['tarih']!.compareTo(onceki) > 0,
        isTrue,
        reason: 'Liste tarihe göre artan sıralı olmalı',
      );
      onceki = g['tarih']!;
    }
  });

  testWidgets('Ramazan Modu sayfası doğru etiketlerle açılır', (tester) async {
    tester.view.physicalSize = const Size(800, 2800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(uygulama(const RamazanModuPage()));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Ramazan Modu'), findsOneWidget);
    expect(find.text('Özel Günler'), findsOneWidget);

    // Sayfa 1 saniyelik sayaç çalıştırıyor: kapat ki timer kalmasın.
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 50));
  });
}