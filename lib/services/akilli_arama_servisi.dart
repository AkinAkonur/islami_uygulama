// lib/services/akilli_arama_servisi.dart

import '../models/kissalar_model.dart';

class AkilliAramaServisi {
  static List<PeygamberModel> aramaYap(
    String sorgu,
    List<PeygamberModel> liste,
  ) {
    if (sorgu.trim().isEmpty) return liste;

    final temizSorgu = _normalize(sorgu);

    return liste.where((p) {
      final islami = _normalize(p.isim.islamiIsim);
      final evrensel = _normalize(p.isim.evrenselIsim);
      final kavim = _normalize(p.gonderildigiKavim);

      bool alternatifEslesti = p.isim.alternatifAramaKeyleri.any(
        (key) => _normalize(key).contains(temizSorgu),
      );

      return islami.contains(temizSorgu) ||
          evrensel.contains(temizSorgu) ||
          kavim.contains(temizSorgu) ||
          alternatifEslesti;
    }).toList();
  }

  // Türkçe/Arapça karakterleri ve aksanları arama için normalize etme
  static String _normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll('î', 'i')
        .replaceAll('û', 'u')
        .replaceAll('â', 'a')
        .replaceAll('ş', 's')
        .replaceAll('ç', 'c')
        .replaceAll('ğ', 'g')
        .replaceAll('ı', 'i')
        .replaceAll('ö', 'o')
        .replaceAll('ü', 'u')
        .replaceAll('hz.', '')
        .trim();
  }
}
