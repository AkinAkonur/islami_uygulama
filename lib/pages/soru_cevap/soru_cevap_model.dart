// lib/pages/soru_cevap/soru_cevap_model.dart
// Hibrit Soru-Cevap modeli: Aynı kayıt hem "Bilgi Bankası" (FAQ/akordeon)
// hem "Bilgi Testleri" (şıklı quiz) hem de "Günün Sorusu" (flashcard)
// deneyimini besler. Tüm içerik çevrimdışı gömülüdür (gizlilik ilkesi).

enum SoruSeviyesi { kolay, orta, zor }

/// Tek bir soru kaydı. [secenekler] ve [dogruIndex] doluysa quiz'de şıklı
/// olarak sunulur; değilse yalnızca Bilgi Bankası cevabı olarak gösterilir.
class SoruCevapSorusu {
  final String id;
  final String kategori;
  final String soru;
  final String cevap;
  final String kaynak; // Kaynak gösterimi (tıklanabilir: sure/ayet veya eser)
  final String? ilgiliAyet; // Flashcard'ın arka yüzünde ilgili ayet metni
  final SoruSeviyesi seviye;

  /// Quiz şıkları (Bilgi Testleri ve Günün Sorusu'nda kullanılır).
  final List<String>? secenekler;
  final int? dogruIndex;

  const SoruCevapSorusu({
    required this.id,
    required this.kategori,
    required this.soru,
    required this.cevap,
    required this.kaynak,
    this.ilgiliAyet,
    this.seviye = SoruSeviyesi.kolay,
    this.secenekler,
    this.dogruIndex,
  });

  bool get quizVar => secenekler != null && dogruIndex != null;

  String get seviyeAdi => switch (seviye) {
        SoruSeviyesi.kolay => 'Başlangıç',
        SoruSeviyesi.orta => 'Orta',
        SoruSeviyesi.zor => 'İleri',
      };

  String get seviyeEmoji => switch (seviye) {
        SoruSeviyesi.kolay => '🌱',
        SoruSeviyesi.orta => '⭐',
        SoruSeviyesi.zor => '🔥',
      };

  /// Arama ve filtreleme için düz metin.
  String get aramaMetni =>
      '$soru $cevap $kaynak ${ilgiliAyet ?? ''} ${secenekler?.join(' ') ?? ''}'
          .toLowerCase();
}

/// Kategori başlığı: emoji + ad + açıklama + sorular.
class SoruKategorisi {
  final String id;
  final String ad;
  final String emoji;
  final String aciklama;
  final List<SoruCevapSorusu> sorular;

  const SoruKategorisi({
    required this.id,
    required this.ad,
    required this.emoji,
    required this.aciklama,
    required this.sorular,
  });
}

/// Kazanılabilir rozet: isim + eşik (toplam doğru sayısı) + açıklama.
class Rozet {
  final String id;
  final String ad;
  final String emoji;
  final int esik; // Bu doğru sayısına ulaşınca kazanılır
  final String aciklama;

  const Rozet({
    required this.id,
    required this.ad,
    required this.emoji,
    required this.esik,
    required this.aciklama,
  });
}
