// ===========================================================================
// HAC & UMRE REHBERİ - VERİ MODELLERİ
// Tüm içerik tek bir veri katmanında tanımlanır; sayfalar yalnızca bu
// modelleri kullanır. Böylece içerik genişletilirken UI değişmez, uygulama
// boyutu da sade metin verisiyle sınırlı kalır.
// ===========================================================================

/// İbadet türleri (İbadet Modu seçimi).
enum IbadetTuru {
  umre,
  hacIfrad,
  hacKirran,
  hacTemettu;

  String get ad => switch (this) {
        IbadetTuru.umre => 'Umre',
        IbadetTuru.hacIfrad => 'Hac-ı İfrâd',
        IbadetTuru.hacKirran => 'Hac-ı Kırân',
        IbadetTuru.hacTemettu => 'Hac-ı Temettu',
      };

  String get kisaAciklama => switch (this) {
        IbadetTuru.umre => 'Sene boyunca her zaman yapılabilir. İhram, tavaf, sa\'y ve tıraştan oluşur.',
        IbadetTuru.hacIfrad => 'Sadece hac niyetiyle ihrama girilir. Umre için ayrı ihrama girilmez.',
        IbadetTuru.hacKirran => 'Umre ve hac, tek ihramla birlikte niyet edilir. Tıraş hacca kadar bekletilir.',
        IbadetTuru.hacTemettu => 'En yaygın yöntem: Önce umre yapılıp ihramdan çıkılır, 8 Zilhicce\'de tekrar ihrama girilir.',
      };

  String get vakit => switch (this) {
        IbadetTuru.umre => 'Yılın her günü',
        IbadetTuru.hacIfrad => 'Hac mevsimi (Şevval–Zilhicce)',
        IbadetTuru.hacKirran => 'Hac mevsimi (Şevval–Zilhicce)',
        IbadetTuru.hacTemettu => 'Hac mevsimi (Şevval–Zilhicce)',
      };
}

/// Arapça dua metni: Arapça + okunuş + meal.
class DuaMetni {
  final String arapca;
  final String okunus;
  final String meal;
  final String kaynak;

  const DuaMetni({
    required this.arapca,
    required this.okunus,
    required this.meal,
    this.kaynak = '',
  });
}

/// Bir ibadet adımı (checklist kartı).
class IbadetAdimi {
  final String id;
  final String baslik;
  final String kisaAciklama;
  final List<String> neYapilir;
  final DuaMetni? dua;
  final List<String> sikHatalar;

  const IbadetAdimi({
    required this.id,
    required this.baslik,
    required this.kisaAciklama,
    required this.neYapilir,
    this.dua,
    this.sikHatalar = const [],
  });
}

/// İbadet akışı: bir türe ait sıralı adımlar + ek notlar.
class IbadetAkisi {
  final IbadetTuru tur;
  final String baslik;
  final String girisNotu;
  final List<IbadetAdimi> adimlar;

  const IbadetAkisi({
    required this.tur,
    required this.baslik,
    required this.girisNotu,
    required this.adimlar,
  });
}

/// Tavaf şavtı başına dua (1–7) ve Sa'y için dua.
class SayaDuasi {
  final int sira;
  final String etiket;
  final DuaMetni dua;

  const SayaDuasi({
    required this.sira,
    required this.etiket,
    required this.dua,
  });
}

/// Fıkıh karar ağacı düğümü.
/// `sonuc` doluysa ağaç bu düğümde sona erer (Dem/Fidye cevabı),
/// değilse `secenekler` ile alt düğümlere dallanılır.
class FikihDugumu {
  final String id;
  final String soru;
  final String? aciklama;
  final List<FikihSecenegi> secenekler;
  final FikihSonuc? sonuc;

  const FikihDugumu({
    required this.id,
    required this.soru,
    this.aciklama,
    this.secenekler = const [],
    this.sonuc,
  });
}

class FikihSecenegi {
  final String etiket;
  final String duygu; // cevabın gösterileceği düğüm veya sonuç id'si
  final String? altDugumId;

  const FikihSecenegi({
    required this.etiket,
    required this.duygu,
    this.altDugumId,
  });
}

/// Karar ağacı sonucu: Mezhebe göre hükümler.
class FikihSonuc {
  final String id;
  final String baslik;
  final String ozet;
  final Map<String, String> mezhepHukumleri; // mezhep adı -> hüküm
  final List<String> notlar;

  const FikihSonuc({
    required this.id,
    required this.baslik,
    required this.ozet,
    required this.mezhepHukumleri,
    this.notlar = const [],
  });
}

/// Ziyaret mekânı (Mekke / Medine).
class ZiyaretMekani {
  final String id;
  final String ad;
  final String bolum; // Mekke / Medine
  final String kategori;
  final String kisaAciklama;
  final List<String> detaylar;
  final List<String> ziyaretAdabi;
  final double? enlem;
  final double? boylam;
  final String ikon; // Icons adı (dinamik)

  const ZiyaretMekani({
    required this.id,
    required this.ad,
    required this.bolum,
    required this.kategori,
    required this.kisaAciklama,
    this.detaylar = const [],
    this.ziyaretAdabi = const [],
    this.enlem,
    this.boylam,
    this.ikon = 'mosque',
  });
}

/// Mikat sınırı (GPS uyarı motoru için).
class MikatNoktasi {
  final String ad;
  final String yon;
  final double enlem;
  final double boylam;
  final String aciklama;

  const MikatNoktasi({
    required this.ad,
    required this.yon,
    required this.enlem,
    required this.boylam,
    required this.aciklama,
  });
}

/// Acil durum sözlüğü cümlesi.
class AcilCumle {
  final String id;
  final String kategori;
  final String turkce;
  final String arapca;
  final String okunus;
  final String not;

  const AcilCumle({
    required this.id,
    required this.kategori,
    required this.turkce,
    required this.arapca,
    required this.okunus,
    this.not = '',
  });
}

/// Mezhep adları (Dem/Fidya filtresi).
const List<String> mezhepler = ['Hanefi', 'Şafiî', 'Maliki', 'Hanbeli'];

/// Sayaç türleri.
enum SayacTuru {
  tavaf,
  say;

  String get ad => switch (this) {
        SayacTuru.tavaf => 'Tavaf',
        SayacTuru.say => 'Sa\'y',
      };

  int get hedef => switch (this) {
        SayacTuru.tavaf => 7,
        SayacTuru.say => 7,
      };
}
