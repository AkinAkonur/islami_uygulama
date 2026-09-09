import 'dart:convert';
import 'dart:ui';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:islami_uygulama/l10n/dil_hizmetleri.dart';
import 'package:islami_uygulama/services/kuran_api.dart';
import 'package:islami_uygulama/services/namaz_bildirim_ayarlari.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    DilHizmetleri.aktifDil.value = const Locale('tr');
    await NamazBildirimAyarlari.sifirla();
  });

  test('Secde verisi boolean veya nesne olabilir', () {
    expect(KuranApi.secdeVarMi(false), isFalse);
    expect(KuranApi.secdeVarMi(null), isFalse);
    expect(KuranApi.secdeVarMi(true), isTrue);
    expect(KuranApi.secdeVarMi({'id': 1, 'recommended': true}), isTrue);
  });

  test('Eski ses dosyası adları ve yeni kodlar okunur', () {
    for (final ses in BildirimSesi.values) {
      expect(BildirimSesi.koddan(ses.kod), ses);
      expect(BildirimSesi.koddan(ses.dosyaAdi), ses);
    }
    expect(BildirimSesi.koddan('bozuk'), BildirimSesi.ezanKisa);
  });

  test('Sessiz ve titreşim tercihleri kalıcıdır', () async {
    await NamazBildirimAyarlari.sesAyarla(BildirimSesi.sessiz);
    await NamazBildirimAyarlari.titresimAyarla(true);
    NamazBildirimAyarlari.ses.value = BildirimSesi.ezanKisa;
    NamazBildirimAyarlari.bellektenDusur();
    await NamazBildirimAyarlari.yukle();
    expect(NamazBildirimAyarlari.ses.value, BildirimSesi.sessiz);
    expect(NamazBildirimAyarlari.titresim.value, isTrue);
  });

  test('Geçersiz hatırlatma süresi reddedilir', () async {
    await expectLater(
      NamazBildirimAyarlari.ayarla(NamazVakti.imsak, 999),
      throwsArgumentError,
    );
    expect(NamazBildirimAyarlari.dakikaOnce(NamazVakti.imsak), 15);
  });

  test('Kayıtlı bölgesel dil kodu normalize edilir', () async {
    SharedPreferences.setMockInitialValues({'ayar_dil': ' MS-my '});
    expect((await DilHizmetleri.baslat()).languageCode, 'ms');
  });

  test('Desteklenmeyen kayıtlı dil güvenli varsayılana döner', () async {
    SharedPreferences.setMockInitialValues({'ayar_dil': 'xx'});
    expect((await DilHizmetleri.baslat()).languageCode, 'tr');
  });

  test('Kur’an araması seçilen dili kullanır', () async {
    DilHizmetleri.aktifDil.value = const Locale('ms');
    final api = KuranApi.forTesting(MockClient((request) async {
      expect(request.url.path, contains('/all/ms.basmeih'));
      return http.Response(jsonEncode({'data': {'matches': []}}), 200);
    }));
    addTearDown(api.dispose);
    expect(await api.ayetAra('sabar'), isEmpty);
  });

  test('Meal seçimi istek yoluna uygulanır; secde nesnesi çökermez', () async {
    Map<String, dynamic> ayet(String metin) => {
      'number': 1, 'numberInSurah': 1, 'text': metin,
      'juz': 1, 'page': 1, 'sajda': {'id': 1},
    };
    final api = KuranApi.forTesting(MockClient((request) async {
      expect(request.url.path, contains('tr.vakfi'));
      return http.Response(jsonEncode({'data': [
        {'ayahs': [ayet('arapca-test')]},
        {'ayahs': [ayet('meal-test')]},
        {'ayahs': [ayet('okunus-test')]},
      ]}), 200);
    }));
    addTearDown(api.dispose);
    final sonuc = await api.ayetleriGetir(sureNo: 1, mealEdisyonu: 'tr.vakfi');
    expect(sonuc.single.meal, 'meal-test');
    expect(sonuc.single.secdeAyeti, isTrue);
  });

  test('Cüz yüklenirken dil değişse de istek edisyonu sabit kalır', () async {
    final yollar = <String>[];
    final api = KuranApi.forTesting(MockClient((request) async {
      yollar.add(request.url.path);
      DilHizmetleri.aktifDil.value = const Locale('ms');
      return http.Response(jsonEncode({'data': {'ayahs': [{
        'number': 1, 'numberInSurah': 1, 'text': request.url.path,
        'surah': {'number': 1}, 'juz': 1, 'page': 1, 'sajda': false,
      }]}}), 200);
    }));
    addTearDown(api.dispose);
    final sonuc = await api.ayetleriGetir(cuzNo: 1);
    expect(yollar.any((yol) => yol.endsWith('/tr.diyanet')), isTrue);
    expect(sonuc.single.meal, endsWith('/tr.diyanet'));
  });

  test('Sure ve cüz sınırları ağ çağrısından önce denetlenir', () async {
    final api = KuranApi.forTesting(MockClient((_) async {
      fail('Geçersiz giriş için ağ çağrılmamalı');
    }));
    addTearDown(api.dispose);
    await expectLater(api.ayetleriGetir(sureNo: 115), throwsRangeError);
    await expectLater(api.ayetleriGetir(cuzNo: 0), throwsRangeError);
    await expectLater(api.ayetleriGetir(), throwsArgumentError);
    await expectLater(api.ayetleriGetir(sureNo: 1, cuzNo: 1), throwsArgumentError);
  });
}
