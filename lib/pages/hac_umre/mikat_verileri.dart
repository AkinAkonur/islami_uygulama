// ===========================================================================
// MİKAT SINIRLARI - GPS UYARI MOTORU VERİLERİ
// Koordinatlar yaklaşıktır; navigasyon ve mesafe hesabı için kullanılır.
// ===========================================================================

import 'hac_umre_verileri.dart';

/// Beş ana mikat sınırı (yön bilgisiyle).
const List<MikatNoktasi> mikatNoktalari = [
  MikatNoktasi(
    ad: 'Zülhuleyfe (Âbâr-ı Ali)',
    yon: 'Medine / Kuzey',
    enlem: 24.4100,
    boylam: 39.5390,
    aciklama:
        'Medine yönünden gelenlerin mikatıdır. Peygamberimizin ihrama girdiği noktadır; günümüzde Abyar Ali (Bîr-i Ali) olarak anılır. Medine otellerinden yaklaşık 7–8 km mesafededir.',
  ),
  MikatNoktasi(
    ad: 'Cuhfe',
    yon: 'Suriye / Mısır / Batı',
    enlem: 22.8833,
    boylam: 39.2000,
    aciklama:
        'Şam, Mısır ve Batı ülkelerinden gelenlerin mikatıdır. Günümüzde Rabiğ yakınlarında, Kızıldeniz kıyısının doğusundadır.',
  ),
  MikatNoktasi(
    ad: 'Karnu\'l-Menâzil',
    yon: 'Necid / Doğu',
    enlem: 21.6300,
    boylam: 40.4200,
    aciklama:
        'Necid bölgesi (Riyad vb.) ve doğudan gelenlerin mikatıdır. Günümüzde Sayl el-Kebîr adıyla bilinir.',
  ),
  MikatNoktasi(
    ad: 'Zât-ı Irk',
    yon: 'Irak / Kuzeydoğu',
    enlem: 21.9167,
    boylam: 40.1000,
    aciklama:
        'Irak yönünden gelenlerin mikatıdır. Günümüzde Madarac denilen bölgededir.',
  ),
  MikatNoktasi(
    ad: 'Yelâmlem',
    yon: 'Yemen / Güney',
    enlem: 20.4667,
    boylam: 39.8000,
    aciklama:
        'Yemen ve güney ülkelerinden gelenlerin mikatıdır. Günümüzde Sa\'diyye olarak bilinir; Cidde havalimanı güneyinden geçilir.',
  ),
];

/// Uçakla gelirken (havada mikat geçildiği için) uyarı mesajı.
const String mikatUcakUyari =
    'Uçakla geliyorsanız, ihrama girmek için mikat sınırına ulaşmadan önce '
    'hazırlıklı olun. Uçak içinde ihram elbisesi giyilebilir; sınır geçilirken '
    'telbiye ile niyet edilir. Havayolu şirketleri genellikle mikat geçişini '
    'anons eder.';

/// Uyarı eşikleri (km).
const int mikatYakinlik1 = 50;
const int mikatYakinlik2 = 10;
