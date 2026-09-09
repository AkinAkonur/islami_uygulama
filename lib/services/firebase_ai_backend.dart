import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Yayın APK'sının güvenli AI geçidi.
///
/// Firebase'in herkese açık uygulama kimlikleri derleme sırasında
/// `config/firebase.production.json` ile verilir. Gemini anahtarı burada veya
/// APK içinde bulunmaz; Cloud Functions Secret Manager'dan okur.
class FirebaseAiBackend {
  FirebaseAiBackend._();

  static const _apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const _appId = String.fromEnvironment('FIREBASE_APP_ID');
  static const _senderId =
      String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const _projectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const _region = String.fromEnvironment(
    'FIREBASE_FUNCTIONS_REGION',
    defaultValue: 'europe-west1',
  );

  static final ValueNotifier<FirebaseAiDurumu> durum =
      ValueNotifier<FirebaseAiDurumu>(FirebaseAiDurumu.yapilandirilmamis);

  static Object? _sonHata;
  static Future<void>? _baslatma;

  static bool get yapilandirildi =>
      _apiKey.isNotEmpty &&
      _appId.isNotEmpty &&
      _senderId.isNotEmpty &&
      _projectId.isNotEmpty;

  static bool get hazir => durum.value == FirebaseAiDurumu.hazir;
  static Object? get sonHata => _sonHata;

  static Future<void> baslat() {
    if (_baslatma != null) return _baslatma!;
    final future = _baslat();
    _baslatma = future;
    return future;
  }

  static Future<void> _baslat() async {
    if (!yapilandirildi) {
      durum.value = FirebaseAiDurumu.yapilandirilmamis;
      return;
    }
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      durum.value = FirebaseAiDurumu.desteklenmiyor;
      return;
    }

    durum.value = FirebaseAiDurumu.baslatiliyor;
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: _apiKey,
            appId: _appId,
            messagingSenderId: _senderId,
            projectId: _projectId,
          ),
        );
      }
      await FirebaseAppCheck.instance.activate(
        androidProvider:
            kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
      );
      await _oturumAc();
      _sonHata = null;
      durum.value = FirebaseAiDurumu.hazir;
    } catch (e) {
      _sonHata = e;
      durum.value = FirebaseAiDurumu.hata;
      debugPrint('[Firebase AI] Başlatılamadı: $e');
    }
  }

  static Future<void> _oturumAc() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await FirebaseAuth.instance.signInAnonymously();
    }
  }

  static Future<FirebaseAiYaniti> sor({
    required String soru,
    required String dilKodu,
    required String kategori,
  }) async {
    if (!hazir) {
      await baslat();
    }
    if (!hazir) {
      throw const FirebaseAiException('backend-unavailable');
    }
    await _oturumAc();

    try {
      final callable = FirebaseFunctions.instanceFor(region: _region)
          .httpsCallable(
        'islamiAiSor',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
      );
      final result = await callable.call(<String, dynamic>{
        'question': soru.trim(),
        'locale': dilKodu,
        'category': kategori,
      });
      final data = Map<String, dynamic>.from(result.data as Map);
      final text = (data['text'] as String? ?? '').trim();
      if (text.isEmpty) throw const FirebaseAiException('empty-response');
      return FirebaseAiYaniti(
        text: text,
        remaining: (data['remaining'] as num?)?.toInt(),
        sourceCount: (data['sourceCount'] as num?)?.toInt() ?? 0,
      );
    } on FirebaseFunctionsException catch (e) {
      throw FirebaseAiException(e.code);
    } catch (e) {
      if (e is FirebaseAiException) rethrow;
      throw const FirebaseAiException('request-failed');
    }
  }

  @visibleForTesting
  static void testDurumunuSifirla() {
    _baslatma = null;
    _sonHata = null;
    durum.value = FirebaseAiDurumu.yapilandirilmamis;
  }
}

enum FirebaseAiDurumu {
  yapilandirilmamis,
  baslatiliyor,
  hazir,
  hata,
  desteklenmiyor,
}

class FirebaseAiYaniti {
  const FirebaseAiYaniti({
    required this.text,
    required this.remaining,
    required this.sourceCount,
  });
  final String text;
  final int? remaining;
  final int sourceCount;
}

class FirebaseAiException implements Exception {
  const FirebaseAiException(this.code);
  final String code;
  @override
  String toString() => code;
}
