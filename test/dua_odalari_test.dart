import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/ummet/dua_odalari_page.dart';
import 'package:islami_uygulama/services/ummet_verileri.dart';

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

  group('UmmetStore dua odalari', () {
    test('duaAra arama yapar ve sonuclari oda bilgisiyle dondurur', () {
      final sonuc = UmmetStore.duaAra('sınav');
      expect(sonuc, isNotEmpty);
      expect(sonuc.first['odaId'], 'sinav');
      expect(sonuc.first['baslik'], isNotEmpty);
    });

    test('duaAra etiket ile filtreler', () {
      final sonuc =
          UmmetStore.duaAra('', odaId: 'sifa', etiket: 'Ağrılar');
      expect(sonuc, isNotEmpty);
      for (final d in sonuc) {
        expect(d['etiket'], 'Ağrılar');
      }
    });

    test('duaAra sayfalama onSayfa kadar sonuc doner', () {
      final tam = UmmetStore.duaAra('');
      final ilkSayfa = UmmetStore.duaAra('', onSayfa: 5);
      expect(tam.length, greaterThan(5));
      expect(ilkSayfa.length, 5);
    });

    test('amin sayaci artar ve okunur', () async {
      final baslik = 'Şifa Duası (Hz. Peygamber\'den)';
      final once = await UmmetStore.duaAminSayisi('sifa', baslik);
      await UmmetStore.duaAminVer('sifa', baslik);
      final sonra = await UmmetStore.duaAminSayisi('sifa', baslik);
      expect(sonra, once + 1);
    });

    test('favori ekle/kaldir ve dualari cozumle', () async {
      final anahtar = 'sifa|Şifa Duası (Hz. Peygamber\'den)';
      expect(await UmmetStore.duaFavoriMi(anahtar), isFalse);
      await UmmetStore.duaFavoriDegistir(anahtar);
      expect(await UmmetStore.duaFavoriMi(anahtar), isTrue);

      final liste = await UmmetStore.duaFavoriDualari();
      expect(liste, hasLength(1));
      expect(liste.first['odaId'], 'sifa');
      expect(liste.first['baslik'], 'Şifa Duası (Hz. Peygamber\'den)');

      await UmmetStore.duaFavoriDegistir(anahtar);
      expect(await UmmetStore.duaFavoriMi(anahtar), isFalse);
    });

    test('kullanici dua ekleme okunur ve odalara gore ayrilir', () async {
      await UmmetStore.odaDuaEkle(
        odaId: 'sifa',
        baslik: 'Sabah Duam',
        arapca: 'اللهم افتح لي أبواب الخير',
        secimi: 'Allahım bana hayır kapılarını aç',
      );

      final hepsi = await UmmetStore.kullaniciOdaDualari();
      expect(hepsi, hasLength(1));
      expect(hepsi.first['baslik'], 'Sabah Duam');
      expect(hepsi.first['kullanicidan'], 'true');
      expect(hepsi.first['odaId'], 'sifa');
      expect(hepsi.first['id'], isNotEmpty);

      await UmmetStore.odaDuaEkle(
        odaId: 'borc',
        baslik: 'Rızık Duam',
        arapca: 'اللهم اوسع لي في رزقي',
        secimi: 'Allahım rızkımı genişlet',
      );

      final sifaDualari = await UmmetStore.kullaniciOdaDualari('sifa');
      expect(sifaDualari, hasLength(1));
      final borcDualari = await UmmetStore.kullaniciOdaDualari('borc');
      expect(borcDualari, hasLength(1));
      expect((await UmmetStore.kullaniciOdaDualari()), hasLength(2));
    });

    test('odaDualariHepsi sabit ve kullanici dualarini birlestirir', () async {
      final ilk = await UmmetStore.odaDualariHepsi('sifa');
      expect(ilk, isNotEmpty);

      await UmmetStore.odaDuaEkle(
        odaId: 'sifa',
        baslik: 'Ek duam',
        arapca: 'اللهم عافني',
        secimi: 'Allahım bana afiyet ver',
      );

      final birlestirilmis = await UmmetStore.odaDualariHepsi('sifa');
      expect(birlestirilmis.length, ilk.length + 1);
      expect(birlestirilmis.last['baslik'], 'Ek duam');
      expect(birlestirilmis.last['kullanicidan'], 'true');
    });

    test('kullanici duası silinir', () async {
      final eklenen = await UmmetStore.odaDuaEkle(
        odaId: 'sifa',
        baslik: 'Silinecek Duam',
        arapca: 'اللهم اغفر لي',
        secimi: 'Allahım beni bağışla',
      );

      await UmmetStore.odaDuaSil(eklenen['id']!);
      final kalanlar = await UmmetStore.kullaniciOdaDualari('sifa');
      expect(kalanlar.where((d) => d['baslik'] == 'Silinecek Duam'), isEmpty);
    });

    test('kullanici duası favori listesinde cozulur', () async {
      await UmmetStore.odaDuaEkle(
        odaId: 'sinav',
        baslik: 'Sınav Duam',
        arapca: 'اللهم وفقني في امتحاني',
        secimi: 'Allahım sınavımda başarı ver',
      );
      final anahtar = 'sinav|Sınav Duam';
      expect(await UmmetStore.duaFavoriMi(anahtar), isFalse);
      await UmmetStore.duaFavoriDegistir(anahtar);
      expect(await UmmetStore.duaFavoriMi(anahtar), isTrue);

      final favoriler = await UmmetStore.duaFavoriDualari();
      final eslesen = favoriler.where((d) => d['baslik'] == 'Sınav Duam').toList();
      expect(eslesen, isNotEmpty);
      expect(eslesen.first['odaId'], 'sinav');
      expect(eslesen.first['kullanicidan'], 'true');

      await UmmetStore.duaFavoriDegistir(anahtar);
      expect(await UmmetStore.duaFavoriMi(anahtar), isFalse);
    });
  });

  group('DuaOdalariPage', () {
    testWidgets('kategorileri ve etiketleri gosterir', (tester) async {
      await tester.pumpWidget(uygulama(const DuaOdalariPage()));
      await tester.pumpAndSettle();

      expect(find.text('Dua Odaları'), findsOneWidget);
      expect(find.text('Şifa'), findsWidgets);
      expect(find.text('Borç / Rızık'), findsOneWidget);
      expect(find.text('Genel Afiyet'), findsOneWidget);
      await tester.drag(find.byType(ListView).first, const Offset(0, -400));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView).first, const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(find.text('Sınav / Başarı'), findsOneWidget);
    });

    testWidgets('arama cubugu filtreli sonuclari gosterir', (tester) async {
      await tester.pumpWidget(uygulama(const DuaOdalariPage()));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'borç');
      await tester.pumpAndSettle();

      expect(find.textContaining('dua bulundu'), findsOneWidget);
      await tester.drag(find.byType(ListView).first, const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(find.text('Borçtan Kurtuluş Duası'), findsOneWidget);
    });

    testWidgets('odaya girince detay ve hizli filtre sekmeleri acilir',
        (tester) async {
      await tester.pumpWidget(uygulama(const DuaOdalariPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Odaya Katıl').first);
      await tester.pumpAndSettle();

      expect(find.text('🩺 Şifa Odası'), findsOneWidget);
      expect(find.text('Tümü'), findsOneWidget);
      expect(find.text('Genel Afiyet'), findsWidgets);
      expect(find.text('Âmin'), findsWidgets);
      await tester.dragUntilVisible(
        find.text('Bu Odada Dua Ettim'),
        find.byType(ListView).last,
        const Offset(0, -300),
        duration: const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();
      expect(find.text('Bu Odada Dua Ettim'), findsOneWidget);
    });

    testWidgets('amin butonu tiklaninca bilgi mesaji gosterir', (tester) async {
      await tester.pumpWidget(uygulama(const DuaOdalariPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Odaya Katıl').first);
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.widgetWithText(FilledButton, 'Âmin').first,
        find.byType(ListView).last,
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Âmin').first);
      await tester.pump();

      expect(find.textContaining('Âmin dediniz'), findsOneWidget);
    });

    testWidgets('Dua Ekle butonu kullanici duasini listeye ekler', (tester) async {
      await tester.pumpWidget(uygulama(const DuaOdalariPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Odaya Katıl').first);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Dua Ekle'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextField, 'Duanın adı'),
          'Test Duan');
      await tester.enterText(find.widgetWithText(TextField, 'Arapça metin'),
          'اللهم اهدني');
      await tester.enterText(
          find.widgetWithText(TextField, 'Türkçe anlamı'), 'Allahım beni doğru yola ilet');
      await tester.tap(find.text('Kaydet'));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.text('Test Duan'),
        find.byType(ListView).last,
        const Offset(0, -300),
        duration: const Duration(milliseconds: 300),
      );
      await tester.pumpAndSettle();
      expect(find.text('Test Duan'), findsOneWidget);
      expect(find.text('Senin duan'), findsOneWidget);
    });
  });
}
