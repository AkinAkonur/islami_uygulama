import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
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
  TestWidgetsFlutterBinding.ensureInitialized();

  test('gömülü varlık yüklenebiliyor', () async {
    final veri = await rootBundle.load('assets/hadis/tur-nawawi.sqlite.zip');
    expect(veri.lengthInBytes, greaterThan(1000));
  });

  test('gömülü kitap otomatik kurulur', () async {
    sqfliteFfiInit();
    final tmp = Directory.systemTemp.createTempSync('hadis_asset_test_');
    PathProviderPlatform.instance = _FakePathProvider(tmp.path);
    addTearDown(() {
      HadisKutuphanesiService.instance.dispose();
      tmp.deleteSync(recursive: true);
    });

    expect(await HadisKutuphanesiService.instance.kitapHazir('tur-nawawi'),
        isTrue);

    final bolumler =
        await HadisKutuphanesiService.instance.bolumler('tur-nawawi');
    expect(bolumler, hasLength(1));
    expect(bolumler.first.hadisSayisi, 42);
  });
}
