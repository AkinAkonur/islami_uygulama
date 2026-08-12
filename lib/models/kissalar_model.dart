// lib/models/kissalar_model.dart

enum IcerikModu { kesif, derinOkuma }

enum HonorificType { pbuh, saw, aleyhisselam, radiallahuanh }

class CiftIsim {
  final String islamiIsim; // Örn: Hz. Musa
  final String evrenselIsim; // Örn: Prophet Moses
  final List<String>
  alternatifAramaKeyleri; // ["Moses", "Moïse", "Nabi Musa", "Musa"]

  CiftIsim({
    required this.islamiIsim,
    required this.evrenselIsim,
    required this.alternatifAramaKeyleri,
  });

  String getGosterimIsmi(String dilKodu) {
    if (dilKodu == 'en' || dilKodu == 'fr') {
      return '$islamiIsim ($evrenselIsim)';
    }
    return islamiIsim;
  }
}

class KaynakAtfi {
  final String eserAdi; // Örn: Sahih-i Buhari
  final String yazar; // Örn: İmam Buhari
  final String ciltSayfa; // Cilt 3, s. 142 / Hadis No: 1823
  final String? baglantiliAyet; // Örn: 2:156

  KaynakAtfi({
    required this.eserAdi,
    required this.yazar,
    required this.ciltSayfa,
    this.baglantiliAyet,
  });
}

class HaritaNoktasi {
  final String konumAdi;
  final String bugunkuKarsiligi; // Örn: "Irak / Hille Bölgesi"
  final double enlem;
  final double boylam;

  HaritaNoktasi({
    required this.konumAdi,
    required this.bugunkuKarsiligi,
    required this.enlem,
    required this.boylam,
  });
}

class PeygamberModel {
  final String id;
  final CiftIsim isim;
  final int kronolojikSira; // 1: Hz. Adem, 2: Hz. Şit ...
  final String donem; // Örn: M.Ö. 2000
  final String gonderildigiKavim;
  final List<HaritaNoktasi> cografiHarita;
  final Map<String, String> kesifIcerigi; // Dil kodu -> Özet İçerik
  final Map<String, String> derinIcerigi; // Dil kodu -> Akademik Detaylar
  final List<KaynakAtfi> kaynaklar;
  final List<Map<String, String>> farkliGorusler; // Accordion metinleri
  final String? sesDosyasiUrl;

  PeygamberModel({
    required this.id,
    required this.isim,
    required this.kronolojikSira,
    required this.donem,
    required this.gonderildigiKavim,
    required this.cografiHarita,
    required this.kesifIcerigi,
    required this.derinIcerigi,
    required this.kaynaklar,
    required this.farkliGorusler,
    this.sesDosyasiUrl,
  });
}
