import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islami_uygulama/l10n/app_localizations.dart';
import 'package:islami_uygulama/pages/namaz_bildirim_ayarlari_page.dart';
import 'package:islami_uygulama/services/gercek_bildirimler.dart';
import 'package:islami_uygulama/services/namaz_bildirim_ayarlari.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await NamazBildirimAyarlari.sifirla();
  });

  group('NamazBildirimAyarlari şema', () {
    test('varsayılanlar şemadaki sürelere uyar', () {
      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.imsak), 15);
      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.gunes), 10);
      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.ogle), 20);
      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.ikindi), 20);
      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.aksam), 15);
      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.yatsi), 30);
    });

    test('jsonSema tüm alanları ve vakitleri içerir', () {
      final sema = NamazBildirimAyarlari.jsonSema();
      final kutu = sema['namaz_bildirim_ayarlari'] as Map;

      expect(kutu['versiyon'], '1.0.0');
      expect(kutu['aciklama'], isA<String>());

      final genel = kutu['genel_durum'] as Map;
      expect(genel['bildirimler_aktif_mi'], true);
      expect(genel['titresim'], true);
      expect(genel['ozel_ses'], 'ezan_kisa.mp3');

      final tercihler = kutu['vakit_tercihleri'] as List;
      expect(tercihler.length, 6);

      final imsak = tercihler.first as Map;
      expect(imsak['vakit_kodu'], 'imsak');
      expect(imsak['vakit_adi'], 'İmsak');
      expect(imsak['hatirlatma_dakika_once'], 15);
      expect(imsak['secenekler'], [0, 5, 10, 15, 30, 45, 60]);
    });

    test('ayarlar Kayıt edilip yeniden yüklenir', () async {
      await NamazBildirimAyarlari.yukle();
      await NamazBildirimAyarlari.ayarla(NamazVakti.imsak, 45);
      await NamazBildirimAyarlari.ayarla(NamazVakti.yatsi, -1);
      await NamazBildirimAyarlari.titresimAyarla(false);

      NamazBildirimAyarlari.bellektenDusur();
      await NamazBildirimAyarlari.yukle();

      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.imsak), 45);
      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.yatsi), -1);
      expect(NamazBildirimAyarlari.kapaliMi(NamazVakti.yatsi), true);
      expect(NamazBildirimAyarlari.kapaliMi(NamazVakti.imsak), false);
      expect(NamazBildirimAyarlari.titresim.value, false);
    });

    test('tüm seçenekler "Kapalı" dahil sıralıdır', () {
      expect(NamazVakti.tumSecenekler(NamazVakti.imsak), [
        -1, 0, 5, 10, 15, 30, 45, 60,
      ]);
    });

    test('ad ve kod eşlemesi çalışır', () {
      expect(NamazVakti.adindan('İkindi'), NamazVakti.ikindi);
      expect(NamazVakti.adindan('Bilinmeyen'), isNull);
      expect(NamazVakti.kodundan('aksam'), NamazVakti.aksam);
    });

    test('bozuk kayıt varsayılanlarla devam eder', () async {
      SharedPreferences.setMockInitialValues({
        'namaz_bildirim_ayarlari': '{{{bozuk-json',
      });
      await NamazBildirimAyarlari.sifirla();
      await NamazBildirimAyarlari.yukle();
      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.imsak), 15);
    });

    test('kaydedilen JSON şema ile birebir uyumludur', () async {
      await NamazBildirimAyarlari.yukle();
      await NamazBildirimAyarlari.ayarla(NamazVakti.aksam, 60);
      final prefs = await SharedPreferences.getInstance();
      final ham = prefs.getString('namaz_bildirim_ayarlari');
      expect(ham, isNotNull);
      final kok = jsonDecode(ham!) as Map;
      expect((kok['namaz_bildirim_ayarlari'] as Map)['versiyon'], '1.0.0');
    });

    test('dakikaOnce negatifse kapalı sayılır', () {
      expect(
        GercekBildirimler.namazBildirimZamani(
          DateTime(2026, 8, 13, 13, 5),
          -1,
        ),
        DateTime(2026, 8, 13, 13, 5),
      );
    });
  });

  group('Ezan sesi kaynağı', () {
    test('raw ezan_kisa.mp3 mevcut ve geçerli MP3 imzası taşıyor', () {
      final dosya = File('android/app/src/main/res/raw/ezan_kisa.mp3');
      expect(dosya.existsSync(), isTrue,
          reason: 'Bildirim sesi eksik — Android kanalı sesisiz kalır.');
      final baytlar = dosya.readAsBytesSync();
      final imza = String.fromCharCodes(baytlar.take(3));
      expect(
        imza == 'ID3' || baytlar.take(2).join(',') == '255,251',
        isTrue,
        reason:
            'Dosya geçerli bir MP3 değil (ID3 etiketi veya çerçeve beklenir).',
      );
      expect(dosya.lengthSync(), greaterThan(50000),
          reason: 'Dosya şüpheli derecede küçük.');
    });

    test('ozelSes değeri raw kaynağa karşılık gelir', () {
      final ses = NamazBildirimAyarlari.ozelSes;
      expect(ses, 'ezan_kisa.mp3');
      final kaynak = ses.endsWith('.mp3')
          ? ses.substring(0, ses.length - 4)
          : ses;
      expect(
        File('android/app/src/main/res/raw/$kaynak.mp3').existsSync(),
        isTrue,
      );
    });
  });

  group('namazBildirimZamani', () {
    final vakit = DateTime(2026, 8, 13, 13, 5);

    test('0 (vaktinde) aynı zamanı döner', () {
      expect(GercekBildirimler.namazBildirimZamani(vakit, 0), vakit);
    });

    test('15 dk önce döner', () {
      expect(
        GercekBildirimler.namazBildirimZamani(vakit, 15),
        DateTime(2026, 8, 13, 12, 50),
      );
    });

    test('60 dk önce bir önceki saate düşer', () {
      final imsak = DateTime(2026, 8, 13, 4, 12);
      expect(
        GercekBildirimler.namazBildirimZamani(imsak, 60),
        DateTime(2026, 8, 13, 3, 12),
      );
    });
  });

  group('NamazBildirimAyarlariPage', () {
    testWidgets('sayfa açılır ve tüm vakitleri gösterir', (tester) async {
      await tester.binding.setSurfaceSize(const Size(600, 1700));
      await tester.pumpWidget(uygulama(const NamazBildirimAyarlariPage()));
      await tester.pumpAndSettle();

      expect(find.text('Namaz Vakti Hatırlatıcıları'), findsOneWidget);
      expect(find.text('Tüm namaz bildirimleri'), findsOneWidget);
      expect(find.text('Titreşim'), findsOneWidget);
      for (final v in NamazVakti.values) {
        expect(find.text(v.ad), findsOneWidget);
      }
      await tester.scrollUntilVisible(
        find.text('Pil Optimizasyonu'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Test Bildirimi Gönder'), findsOneWidget);
    });

    testWidgets('vakit seçeneği değiştirilince kaydedilir', (tester) async {
      await tester.pumpWidget(uygulama(const NamazBildirimAyarlariPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButton<int>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('45 dk önce').last);
      await tester.pumpAndSettle();

      expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.imsak), 45);
      expect(find.text('İmsak: 45 dk önce bildirilecek'), findsOneWidget);
    });

    testWidgets('titreşim anahtarı açılıp kapatılabilir', (tester) async {
      await tester.pumpWidget(uygulama(const NamazBildirimAyarlariPage()));
      await tester.pumpAndSettle();

      final anahtar = find.byType(Switch).last;
      await tester.tap(anahtar);
      await tester.pumpAndSettle();

      expect(NamazBildirimAyarlari.titresim.value, false);

      await tester.tap(anahtar);
      await tester.pumpAndSettle();
      expect(NamazBildirimAyarlari.titresim.value, true);
    });

    testWidgets('test bildirimi butonu güvenle çalışır', (tester) async {
      await tester.binding.setSurfaceSize(const Size(600, 1700));
      await tester.pumpWidget(uygulama(const NamazBildirimAyarlariPage()));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Test Bildirimi Gönder'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Test Bildirimi Gönder'));
      await tester.pumpAndSettle();

      // Test ortamında OS zamanlayıcısı yoktur → güvenli uyarı yolu çalışır.
      expect(find.textContaining('hazır değil'), findsOneWidget);
    });
  });
}