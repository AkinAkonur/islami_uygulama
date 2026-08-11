import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:islami_uygulama/services/hadis_kutuphanesi_service.dart';

class _FakePathProvider extends PathProviderPlatform {
  final String dizin;
  _FakePathProvider(this.dizin);

  @override
  Future<String?> getApplicationSupportPath() async => dizin;

  @override
  Future<String?> getTemporaryPath() async => dizin;
}

void main() {
  late Directory tmp;

  setUpAll(() {
    sqfliteFfiInit();
    tmp = Directory.systemTemp.createTempSync('hadis_test_');
    PathProviderPlatform.instance = _FakePathProvider(tmp.path);
    SharedPreferences.setMockInitialValues({});
  });

  tearDownAll(() {
    HadisKutuphanesiService.instance.dispose();
    tmp.deleteSync(recursive: true);
  });

  test('uygulama dili veritabanı dil koduna eşlenir', () {
    expect(HadisKutuphanesiService.depoDilKodu('tr'), 'tur');
    expect(HadisKutuphanesiService.depoDilKodu('en'), 'eng');
    expect(HadisKutuphanesiService.depoDilKodu('ar'), 'ara');
    expect(HadisKutuphanesiService.depoDilKodu('id'), 'ind');
    expect(HadisKutuphanesiService.depoDilKodu('ms'), 'ind');
    expect(HadisKutuphanesiService.depoDilKodu('ur'), 'urd');
    expect(HadisKutuphanesiService.depoDilKodu('bn'), 'ben');
    expect(HadisKutuphanesiService.depoDilKodu('fr'), 'fra');
    expect(HadisKutuphanesiService.depoDilKodu('ru'), 'rus');
    expect(HadisKutuphanesiService.depoDilKodu('xx'), 'eng');
  });

  test('Türkçe kitap listesi ağdan çekilir', () async {
    final kitaplar = await HadisKutuphanesiService.instance.kitaplariGetir('tr');
    expect(kitaplar, isNotEmpty);
    expect(kitaplar.every((k) => k.kod.startsWith('tur-')), isTrue);
    expect(kitaplar.any((k) => k.kod == 'tur-bukhari'), isTrue);
  });

  test('Fransızca kitap listesi kullanıcının diline uyar', () async {
    final kitaplar = await HadisKutuphanesiService.instance.kitaplariGetir('fr');
    expect(kitaplar, isNotEmpty);
    expect(kitaplar.every((k) => k.kod.startsWith('fra-')), isTrue);
  });

  test('İmam Nevevi Kırk Hadis indirilir ve sorgular çalışır', () async {
    final servis = HadisKutuphanesiService.instance;

    expect(await servis.kitapHazir('tur-nawawi'), isFalse);

    final bolumler = await servis.bolumler('tur-nawawi');
    expect(bolumler, hasLength(1));
    expect(bolumler.first.hadisSayisi, 42);

    final hadisler = await servis.bolumHadisleri(
      'tur-nawawi',
      bolumler.first.id,
      limit: 100,
    );
    expect(hadisler, hasLength(42));
    expect(hadisler.first.hadisNo, 1);
    expect(hadisler.first.metin, isNotEmpty);

    expect(await servis.kitapHazir('tur-nawawi'), isTrue);

    await servis.sil('tur-nawawi');
    expect(await servis.kitapHazir('tur-nawawi'), isFalse);
  });

  test('FTS5 arama sonuç döndürür', () async {
    final servis = HadisKutuphanesiService.instance;
    final bolumler = await servis.bolumler('tur-nawawi');
    await servis.bolumHadisleri('tur-nawawi', bolumler.first.id);

    final sonuclar = await servis.ara('tur-nawawi', 'amel');
    expect(sonuclar, isNotEmpty);

    final bos = await servis.ara('tur-nawawi', ' ');
    expect(bos, isEmpty);
  });
}
