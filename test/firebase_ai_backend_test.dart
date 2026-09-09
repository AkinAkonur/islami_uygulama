import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:islami_uygulama/services/firebase_ai_backend.dart';
import 'package:islami_uygulama/services/gemini_servisi.dart';

void main() {
  setUp(FirebaseAiBackend.testDurumunuSifirla);
  tearDown(FirebaseAiBackend.testDurumunuSifirla);

  test('Firebase yapılandırması olmadan backend hazır sayılmaz', () async {
    expect(FirebaseAiBackend.yapilandirildi, isFalse);
    await FirebaseAiBackend.baslat();
    expect(FirebaseAiBackend.durum.value,
        FirebaseAiDurumu.yapilandirilmamis);
    expect(FirebaseAiBackend.hazir, isFalse);
  });

  test('Backend yoksa çağrı hata verir; yerel yedek devreye girebilir',
      () async {
    await expectLater(
      FirebaseAiBackend.sor(soru: 'oruç', dilKodu: 'tr', kategori: 'fikih'),
      throwsA(isA<FirebaseAiException>()),
    );
  });

  test('Yayın sürümünde cihaz anahtarı ile online mod açılmaz', () {
    final servis = GeminiServisi(apiKey: 'yerel-test-anahtari');
    expect(servis.hazir, kDebugMode);
  });

  test('Backend hazır değilken doğrudan Gemini çağrısı yapılmaz', () async {
    final servis = GeminiServisi(apiKey: '');
    await expectLater(
      servis.sor('Namaz vakitleri nedir?', dilKodu: 'tr'),
      throwsA(isA<GemiException>()),
    );
  });
}
