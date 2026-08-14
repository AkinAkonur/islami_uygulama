import 'dart:convert';

import 'package:http/http.dart' as http;

import 'gizli_anahtar.dart';

/// Google Gemini API'ye gerçek istek atan servis.
///
/// API anahtarı öncelikle `--dart-define=GEMINI_API_KEY=...` ile, yoksa
/// git'e dahil olmayan [gizliAnahtarı] (lib/services/gizli_anahtar.dart)
/// üzerinden okunur.
/// Ücretsiz anahtar: https://aistudio.google.com/apikey
class GeminiServisi {
  GeminiServisi({this.apiKey});

  final String? apiKey;

  static const _model = "gemini-3.5-flash-lite";

  String get _anahtar {
    final ortamdan = const String.fromEnvironment('GEMINI_API_KEY');
    if (ortamdan.isNotEmpty) return ortamdan;
    if (apiKey != null && apiKey!.isNotEmpty) return apiKey!;
    return gizliApiAnahtari;
  }

  bool get hazir => _anahtar.isNotEmpty;

  /// Kullanıcı sorusunu Gemini'ye gönderir ve metin yanıtını döndürür.
  Future<String> sor(String soru) async {
    if (_anahtar.isEmpty) {
      throw const GemiException('API anahtarı tanımlı değil');
    }

    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$_model'
      ':generateContent?key=$_anahtar',
    );

    final payload = {
      "contents": [
        {
          "parts": [
            {
              "text":
                  "Sen İslam dinine, Kur'an tefsirine ve fıkha hâkim, bilgili ve "
                  "ihtiyatlı bir İslam bilgini asistanısın. Kullanıcının sorusunu "
                  "Türkçe, doğru, net ve kaynak güvenilirliğini gözeterek yanıtla. "
                  "Kesin dini hüküm konusunda ihtiyatlı ol, temel bilgiler için "
                  "delil (ayet/hadis) göster. Yanıtı kısa ve düzenli paragraflarla ver.\n\n"
                  "Soru: $soru"
            }
          ]
        }
      ],
      "generationConfig": {"temperature": 0.7, "maxOutputTokens": 900},
    };

    final response = await http
        .post(
          uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        )
        .timeout(const Duration(seconds: 60));

    if (response.statusCode != 200) {
      throw GemiException(
        'API hatası (${response.statusCode}): ${response.body}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = json["candidates"] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw const GemiException('Yanıt alınamadı (yedek doğrulama).');
    }
    final parts =
        ((candidates.first as Map)["content"] as Map)["parts"] as List?;
    if (parts == null || parts.isEmpty) {
      throw const GemiException('Boş yanıt alındı.');
    }
    final text = (parts.first as Map)["text"] as String? ?? '';
    if (text.trim().isEmpty) {
      throw const GemiException('Boş yanıt alındı.');
    }
    return text.trim();
  }
}

class GemiException implements Exception {
  const GemiException(this.message);
  final String message;

  @override
  String toString() => message;
}