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

    test('her duada fazilet (hikmet) metni vardır', () async {
      final dualar = await DualarVerileri.instance.tumDualar();
      for (final d in dualar) {
        expect(d.fazilet, isNotEmpty, reason: 'Fazilet eksik: ${d.id}');
      }
    });

    test('amiral dualarda çok dilli (İngilizce) meal bulunur', () async {
      final rabbena = await DualarVerileri.instance.idIleBul('kuran-rabbena-atina');
      expect(rabbena, isNotNull);
      expect(rabbena!.mealler['en'], isNotEmpty);
      expect(rabbena.mealDil('en'), rabbena.mealler['en']);
      expect(rabbena.mealDil('fr'), rabbena.meal);
    });

    test('uzak JSON yenileme adresi boş değil; şema tutarlıdır', () {
      expect(DualarVerileri.uzakJsonUrl, isNotEmpty);
      expect(DualarVerileri.yenilemePeriyodu, isNotNull);
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

    test('dua hatırlatıcısı kaydedilir, okunur ve silinir', () async {
      await DuaStore.yukle();
      const kayit = DuaHatirlatma(
        duaId: 'kuran-rabbena-atina',
        saat: 21,
        dakika: 30,
        gunler: [5, 6],
      );
      expect(DuaStore.hatirlatmaOku('kuran-rabbena-atina'), isNull);

      await DuaStore.hatirlatmaKaydet(kayit);
      final okunan = DuaStore.hatirlatmaOku('kuran-rabbena-atina');
      expect(okunan, isNotNull);
      expect(okunan!.saat, 21);
      expect(okunan.dakika, 30);
      expect(okunan.gunler, containsAll([5, 6]));
      expect(okunan.gunlerYaz, isNotEmpty);

      // Her gün kaydı + yeniden yükleme (kalıcılık).
      await DuaStore.hatirlatmaKaydet(
        const DuaHatirlatma(duaId: 'gunluk-sabah-bismillah-3', saat: 7, dakika: 0),
      );
      final yeniStore = DuaStore.yukle();
      await yeniStore;
      expect(
        DuaStore.hatirlatmaOku('gunluk-sabah-bismillah-3')?.gunler,
        isEmpty,
      );

      await DuaStore.hatirlatmaSil('kuran-rabbena-atina');
      expect(DuaStore.hatirlatmaOku('kuran-rabbena-atina'), isNull);
    });
  });

  group('DualarPage', () {
    testWidgets('beş kategori ve sekmeleri gösterir', (tester) async {
      await tester.pumpWidget(_uygulama(const DualarPage()));
      await tester.pumpAndSettle();

      expect(find.text('Manevi Dualar Hazinesi'), findsOneWidget);
      expect(find.text('Günlük Yaşam Duaları'), findsOneWidget);
      expect(find.text('Büyük ve Meşhur Dualar'), findsOneWidget);
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
      expect(find.text('Fazileti & Hikmeti'), findsOneWidget);
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

    testWidgets('duaya hatırlatıcı kurulur ve bannerda görünür', (tester) async {
      await tester.pumpWidget(_uygulama(const DualarPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text("Kur'an-ı Kerim ve Peygamber Duaları"));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Rabbena Atina Duası'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.alarm_add));
      await tester.pumpAndSettle();
      expect(find.text('Dua Hatırlatıcısı Kur'), findsOneWidget);
      expect(find.text('Her gün'), findsOneWidget);

      await tester.tap(find.text('Hatırlatıcıyı Kaydet'));
      await tester.pumpAndSettle();

      expect(DuaStore.hatirlatmaOku('kuran-rabbena-atina'), isNotNull);
      expect(find.byIcon(Icons.alarm_on), findsOneWidget);
      expect(find.text('Hatırlatıcı kuruldu 🤲'), findsOneWidget);
    });
  });
}