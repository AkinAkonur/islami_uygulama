import '../l10n/app_localizations.dart';
import '../pages/soru_cevap/soru_cevap_model.dart';
import '../pages/soru_cevap/soru_cevap_verileri.dart';

/// Ücretsiz çevrimdışı yanıt motoru.
/// İnternet, API anahtarı, kota veya sunucu maliyeti yoktur.
/// AI değildir: yalnızca uygulama içi bilgi bankası ve sabit ayet yönlendirmeleri.
class YerelAyetRehberi {
  YerelAyetRehberi._();

  static const _ayetler = <String, String>{
    '112:1–4': '112:1–4',
    '112:1-4': '112:1–4',
    '112': '112:1–4',
    '2:255': '2:255',
    '55:13': '55:13',
  };

  /// Eski arayüz uyumu: yalnız ayet referansı döner.
  static String? referans(String soru, AppLocalizations l) {
    final q = _normalize(soru);
    for (var i = 1; i <= 3; i++) {
      if (q == _normalize(l.t('ai.cs.tefsir.$i'))) {
        return const ['112:1–4', '2:255', '55:13'][i - 1];
      }
    }
    return _ayetler[q];
  }

  /// Kullanıcı sorusuna yerel, ücretsiz yanıt üretir.
  static YerelRehberYaniti yanitla(String soru, AppLocalizations l) {
    final q = _normalize(soru);
    if (q.isEmpty) {
      return YerelRehberYaniti(
        metin: l.t('ai.localNoMatch'),
        kaynak: null,
        eslesme: false,
      );
    }

    // 1) Bilgi bankasında en iyi eşleşme
    final eslesen = _enIyiEslesme(q);
    if (eslesen != null) {
      final govde = StringBuffer()
        ..writeln(eslesen.cevap.trim())
        ..writeln()
        ..writeln('${l.t('ai.kaynak')}: ${eslesen.kaynak}');
      if (eslesen.ilgiliAyet != null && eslesen.ilgiliAyet!.trim().isNotEmpty) {
        govde
          ..writeln()
          ..writeln(eslesen.ilgiliAyet!.trim());
      }
      govde
        ..writeln()
        ..writeln(l.t('ai.kaynakNot'));
      return YerelRehberYaniti(
        metin: govde.toString().trim(),
        kaynak: eslesen.kaynak,
        eslesme: true,
      );
    }

    // 2) Sabit tefsir örnekleri → ayet yönlendirmesi
    final ref = referans(soru, l);
    if (ref != null) {
      return YerelRehberYaniti(
        metin: l.t('ai.localGuide').replaceAll('{reference}', ref),
        kaynak: ref,
        eslesme: true,
      );
    }

    // 3) Kısmi anahtar kelime araması (en az 4 karakterlik token)
    final kismi = _kismiEslesme(q);
    if (kismi != null) {
      final govde = StringBuffer()
        ..writeln(kismi.cevap.trim())
        ..writeln()
        ..writeln('${l.t('ai.kaynak')}: ${kismi.kaynak}')
        ..writeln()
        ..writeln(l.t('ai.kaynakNot'));
      return YerelRehberYaniti(
        metin: govde.toString().trim(),
        kaynak: kismi.kaynak,
        eslesme: true,
      );
    }

    return YerelRehberYaniti(
      metin: l.t('ai.localNoMatch'),
      kaynak: null,
      eslesme: false,
    );
  }

  static String _normalize(String s) => s
      .trim()
      .toLowerCase()
      .replaceAll(RegExp(r'[İIı]'), 'i')
      .replaceAll('ş', 's')
      .replaceAll('ğ', 'g')
      .replaceAll('ü', 'u')
      .replaceAll('ö', 'o')
      .replaceAll('ç', 'c')
      .replaceAll(RegExp(r'\s+'), ' ');

  static SoruCevapSorusu? _enIyiEslesme(String q) {
    SoruCevapSorusu? best;
    var bestScore = 0;
    for (final s in SoruCevapVerileri.tumSorular) {
      final soru = _normalize(s.soru);
      if (soru == q) return s;
      if (soru.contains(q) || q.contains(soru)) {
        final score = 1000 + (soru.length < q.length ? soru.length : q.length);
        if (score > bestScore) {
          bestScore = score;
          best = s;
        }
        continue;
      }
      final tokens = q.split(' ').where((t) => t.length >= 4).toList();
      if (tokens.isEmpty) continue;
      var hit = 0;
      for (final t in tokens) {
        if (s.aramaMetni.contains(t)) hit++;
      }
      if (hit >= 2 || (tokens.length == 1 && hit == 1)) {
        final score = hit * 10 + (s.cevap.length > 40 ? 2 : 0);
        if (score > bestScore) {
          bestScore = score;
          best = s;
        }
      }
    }
    return bestScore >= 10 ? best : null;
  }

  static SoruCevapSorusu? _kismiEslesme(String q) {
    final tokens = q.split(' ').where((t) => t.length >= 5).toList();
    if (tokens.isEmpty) return null;
    for (final s in SoruCevapVerileri.tumSorular) {
      var hit = 0;
      for (final t in tokens) {
        if (s.aramaMetni.contains(t)) hit++;
      }
      if (hit >= (tokens.length >= 3 ? 2 : 1)) return s;
    }
    return null;
  }
}

class YerelRehberYaniti {
  const YerelRehberYaniti({
    required this.metin,
    required this.kaynak,
    required this.eslesme,
  });
  final String metin;
  final String? kaynak;
  final bool eslesme;
}
