import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/ilham_page.dart';
import 'package:islami_uygulama/services/ilham_store.dart';
import 'package:islami_uygulama/services/ilham_verileri.dart';

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
    IlhamStore.favoriler.value = {};
    IlhamStore.hatirlatma.value = null;
  });

  test('Gömülü ilham JSON şeması çözülür ve günün akışı 5 kategori sunar', () async {
    final akis = await IlhamVerileri.instance.gununAkisi();
    expect(akis, hasLength(5));
    final kategoriler = akis.map((i) => i.kategori).toSet();
    expect(
      kategoriler,
      containsAll(IlhamKategori.values),
    );
    for (final icerik in akis) {
      expect(icerik.id, isNotEmpty);
      expect(icerik.baslik, isNotEmpty);
      expect(icerik.metin, isNotEmpty);
      expect(icerik.kaynak, isNotEmpty);
    }
  });

  test('Arşiv son 7 gün için her gün 5 içerik döndürür', () async {
    final gunler = await IlhamVerileri.instance.arsivGunleri(geriye: 7);
    expect(gunler, hasLength(7));
    for (final gun in gunler) {
      expect(gun['icerikler'] as List<IlhamIcerik>, hasLength(5));
    }
  });

  test('İlhamStore favori ekleme/çıkarma ve hatırlatıcı kalıcılığı', () async {
    await IlhamStore.favoriDegistir('ayet-1');
    expect(IlhamStore.favoriMi('ayet-1'), isTrue);

    await IlhamStore.hatirlatmaKaydet(
      const IlhamHatirlatma(saat: 8, dakika: 30),
    );
    expect(IlhamStore.hatirlatma.value?.saatYaz, '08:30');

    final akis = await IlhamVerileri.instance.gununAkisi();
    final favoriIcerik = akis.first;
    await IlhamStore.favoriDegistir(favoriIcerik.id);
    final bulunan = await IlhamVerileri.instance.idIleBul(favoriIcerik.id);
    expect(bulunan?.id, favoriIcerik.id);

    await IlhamStore.favoriDegistir(favoriIcerik.id);
    expect(IlhamStore.favoriMi(favoriIcerik.id), isFalse);

    await IlhamStore.hatirlatmaKaldir();
    expect(IlhamStore.hatirlatma.value, isNull);
  });

  testWidgets('İlham sayfası günün akışını gösterir ve favori eklenebilir', (tester) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(uygulama(const IlhamPage()));
    await tester.pumpAndSettle();

    expect(find.text('İlham & Hikmet Köşesi'), findsOneWidget);
    expect(find.text('Günün Akışı'), findsOneWidget);
    expect(find.text('Arşiv'), findsOneWidget);
    expect(find.text('Favoriler'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border_rounded).first);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_rounded), findsWidgets);

    await tester.tap(find.text('Favoriler'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Henüz favori'), findsNothing);
  });
}