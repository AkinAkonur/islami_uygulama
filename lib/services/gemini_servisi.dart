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

  /// Yaygın dil kodlarını Gemini'nin anlayacağı yanıt dili etiketine çevirir.
  /// Desteklenmeyen kodlarda İngilizce varsayılır; böylece yanıt her zaman
  /// kullanıcının uygulama diliyle uyumlu bir dille döner.
  static String yanitDili(String kod) {
    return switch (kod) {
      'tr' => 'Türkçe',
      'en' => 'English',
      'ar' => 'العربية',
      'id' => 'Bahasa Indonesia',
      'ms' => 'Bahasa Melayu',
      'ur' => 'اردو',
      'bn' => 'বাংলা',
      'fr' => 'Français',
      'ru' => 'Русский',
      _ => 'English',
    };
  }

  /// Kullanıcı sorusunu Gemini'ye gönderir ve metin yanıtını döndürür.
  ///
  /// [dilKodu] ile AI'ın yanıt dilini kullanıcının uygulama diline sabitler
  /// (global kullanıcılar için). [ekTalimat] kategoriye özel yönergeleri
  /// (ör. tefsir, fıkıh, karşılaştırma) ekler.
  Future<String> sor(
    String soru, {
    String dilKodu = 'tr',
    String? ekTalimat,
  }) async {
    if (_anahtar.isEmpty) {
      throw const GemiException('API anahtarı tanımlı değil');
    }

    final dilEtiketi = yanitDili(dilKodu);

    final uri = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/$_model'
      ':generateContent?key=$_anahtar',
    );

    final talimat = [
      "Sen İslam dinine, Kur'an tefsirine ve fıkha hâkim, bilgili ve "
          "ihtiyatlı bir İslam bilgini asistanısın.",
      "Soruya kesinlikle $dilEtiketi dilinde yanıt ver.",
      "Doğru, net ve kaynak güvenilirliğini gözeterek yanıtla.",
      "Mümkün olduğunca delil göster (sure-adı + ayet numarası, hadis kaynağı "
          "ve numarası); kesin dini hüküm konusunda ihtiyatlı ol ve fetva "
          "gerektiren konularda bir âlime danışılmasını hatırlat.",
      "Yanıtı kısa, düzenli paragraflar hâlinde ve madde madde ver.",
      if (ekTalimat != null && ekTalimat.isNotEmpty) ekTalimat,
    ].join(' ');

    final payload = {
      "contents": [
        {"parts": [{"text": "$talimat\n\nSoru: $soru"}]}
      ],
      "generationConfig": {"temperature": 0.5, "maxOutputTokens": 1100},
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

    final json = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
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