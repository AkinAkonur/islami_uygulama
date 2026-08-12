import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/dua_detay_page.dart';
import 'package:islami_uygulama/pages/dualar_page.dart';
import 'package:islami_uygulama/services/dua_store.dart';
import 'package:islami_uygulama/services/dualar_verileri.dart';

Widget _uygulama(Widget child) {
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
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('DualarVerileri', () {
    test('kategoriler ve gruplar varlıktan yüklenir', () async {
      final kategoriler = await DualarVerileri.instance.kategorileriYukle();
      expect(kategoriler, hasLength(5));

      var toplam = 0;
      for (final k in kategoriler) {
        expect(k.ad, isNotEmpty);
        expect(k.gruplar, isNotEmpty);
        for (final g in k.gruplar) {
          expect(g.dualar, isNotEmpty);
          toplam += g.dualar.length;
        }
      }
      expect(toplam, greaterThan(50));
    });

    test('her dua Arapça, okunuş ve meali eksiksizdir', () async {
      final dualar = await DualarVerileri.instance.tumDualar();
      for (final d in dualar) {
        expect(d.id, isNotEmpty, reason: d.baslik);
        expect(d.baslik, isNotEmpty);
        expect(d.arapca, isNotEmpty, reason: d.baslik);
        expect(d.okunus, isNotEmpty, reason: d.baslik);
        expect(d.meal, isNotEmpty, reason: d.baslik);
        expect(d.kaynak, isNotEmpty, reason: d.baslik);
      }
    });

    test('ayet bazlı dualar için ses URL üretilir', () async {
      final rabbena = await DualarVerileri.instance.idIleBul('kuran-rabbena-atina');
      expect(rabbena, isNotNull);
      expect(rabbena!.sesUrl,
          'https://everyayah.com/data/Alafasy_128kbps/002201.mp3');

      final seyyid = await DualarVerileri.instance.idIleBul('duygu-tevbe-seyyid');
      expect(seyyid!.sesUrl, isNull);
    });

    test('etiket ve meal üzerinden arama yapılır', () async {
      final borc = await DualarVerileri.instance.ara('borç');
      expect(borc, isNotEmpty);

      final korunma = await DualarVerileri.instance.ara('nazar');
      expect(korunma, isNotEmpty);
    });
  });

  group('DuaStore', () {
    test('favori ekleme ve çıkarma kalıcıdır', () async {
      await DuaStore.yukle();
      expect(DuaStore.favoriMi('kuran-rabbena-atina'), isFalse);

      await DuaStore.favoriDegistir('kuran-rabbena-atina');
      expect(DuaStore.favoriMi('kuran-rabbena-atina'), isTrue);

      await DuaStore.favoriDegistir('kuran-rabbena-atina');
      expect(DuaStore.favoriMi('kuran-rabbena-atina'), isFalse);
    });

    test('özel dua eklenip silinebilir', () async {
      await DuaStore.yukle();
      await DuaStore.ozDuaEkle('Ailem için', 'Allah ailemi korusun');
      expect(DuaStore.ozDualar.value, hasLength(1));
      expect(DuaStore.ozDualar.value.first.baslik, 'Ailem için');

      await DuaStore.ozDuaSil(DuaStore.ozDualar.value.first.id);
      expect(DuaStore.ozDualar.value, isEmpty);
    });

    test('zikirmatik sayacı artar ve sıfırlanır', () async {
      await DuaStore.yukle();
      final ilk = await DuaStore.sayacArttir('gunluk-sabah-bismillah-3');
      expect(ilk, 1);
      await DuaStore.sayacArttir('gunluk-sabah-bismillah-3');
      expect(DuaStore.sayacOku('gunluk-sabah-bismillah-3'), 2);

      await DuaStore.sayacSifirla('gunluk-sabah-bismillah-3');
      expect(DuaStore.sayacOku('gunluk-sabah-bismillah-3'), 0);
    });
  });

  group('DualarPage', () {
    testWidgets('beş kategori ve sekmeleri gösterir', (tester) async {
      await tester.pumpWidget(_uygulama(const DualarPage()));
      await tester.pumpAndSettle();

      expect(find.text('Manevi Dualar Hazinesi'), findsOneWidget);
      expect(find.text('Günlük Yaşam Duaları'), findsOneWidget);
      expect(find.text('Büyük ve Meşhur Dualar / Cevşen'), findsOneWidget);
      expect(find.text('Favoriler'), findsOneWidget);
      expect(find.text('Kendi Dualarım'), findsOneWidget);
    });

    testWidgets('kategoriye girince dua listesi görünür', (tester) async {
      await tester.pumpWidget(_uygulama(const DualarPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Kur'an-ı Kerim ve Peygamber Duaları"));
      await tester.pumpAndSettle();

      expect(find.text("Kur'an'da Geçen Rabbena Duaları"), findsOneWidget);
      expect(find.text('Rabbena Atina Duası'), findsOneWidget);
    });

    testWidgets('duaya girince detay sayfası açılır', (tester) async {
      await tester.pumpWidget(_uygulama(const DualarPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Kur'an-ı Kerim ve Peygamber Duaları"));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rabbena Atina Duası'));
      await tester.pumpAndSettle();

      expect(find.byType(DuaDetayPage), findsOneWidget);
      expect(find.textContaining('رَبَّنَا آتِنَا'), findsWidgets);
      expect(find.text('Kaynak: Bakara Suresi, 201. Ayet'), findsOneWidget);
      expect(find.textContaining('Zikirmatik'), findsNothing);
    });

    testWidgets('tekrar adedi olan duada zikirmatik gösterilir',
        (tester) async {
      await tester.pumpWidget(_uygulama(const DualarPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Günlük Yaşam Duaları'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sabah & Akşam Korunma Duası'));
      await tester.pumpAndSettle();

      expect(find.byType(DuaDetayPage), findsOneWidget);
      expect(find.textContaining('hedef: 3 tekrar'), findsOneWidget);

      await tester.ensureVisible(find.text('0'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('0'));
      await tester.pumpAndSettle();
      expect(DuaStore.sayacOku('gunluk-sabah-bismillah-3'), 1);
      expect(find.text('1'), findsOneWidget);
    });
  });
}