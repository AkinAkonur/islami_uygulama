// ===========================================================================
// ZİYARET REHBERİ - MEKKE & MEDİNE MEKÂNLARI
// Tarihî/kutsal mekânlar, koordinatlar ve ziyaret adabı.
// Koordinatlar yaklaşıktır; navigasyon için uygulamadaki "Haritada Aç"
// butonu kullanılabilir.
// ===========================================================================

import 'hac_umre_verileri.dart';

const List<ZiyaretMekani> ziyaretMekanlari = [
  // ------------------------- MEKKE -------------------------
  ZiyaretMekani(
    id: 'mekke_hira',
    ad: 'Hira (Nûr Dağı)',
    bolum: 'Mekke',
    kategori: 'Dağ & Mağara',
    kisaAciklama:
        'Peygamberimizin ilk vahyini (Alak Suresi\'nin ilk ayetlerini) aldığı mağara.',
    detaylar: [
      'Nur Dağı\'nın zirvesinde yer alır; Mekke merkezine yaklaşık 4 km mesafededir.',
      'Zirveye tırmanış 45–90 dakika sürer; yokuş ve basamaklardan oluşur.',
      'Mağara küçüktür; içine az kişi sığar, ibadet yerine saygıyla ziyaret edilir.',
      'Tırmanış için en uygun saatler: güneş doğmadan önce veya batarken (serin saatler).',
    ],
    ziyaretAdabi: [
      'Ziyaret sırasında saygı ve sessizlik korunmalıdır.',
      'Kalabalık ve sıcak saatlerden kaçınılmalıdır.',
      'Kadınlar mağarayı erkeklerden ayrı ziyaret eder.',
    ],
    enlem: 21.4575,
    boylam: 39.8582,
    ikon: 'terrain',
  ),
  ZiyaretMekani(
    id: 'mekke_sevr',
    ad: 'Sevr Mağarası',
    bolum: 'Mekke',
    kategori: 'Dağ & Mağara',
    kisaAciklama:
        'Hicret yolculuğunda Peygamberimiz ve Hz. Ebûbekir\'in üç gün gizlendiği mağara.',
    detaylar: [
      'Mekke\'nin güneyinde Sevr Dağı\'nın zirvesinde yer alır.',
      'Zirveye tırmanış 1,5–2 saat sürebilir; dik bir yoldur.',
      'Mağara ağzı alçaktır; içeri eğilerek girilir.',
      'Mağarada üç gün kalındığında Hz. Peygamber ile Hz. Ebûbekir\'e davet ettiği rivayet edilir.',
    ],
    ziyaretAdabi: [
      'Tırmanış fiziksel olarak zorlayıcıdır; sağlık durumuna göre karar verilmelidir.',
      'Güneş doğarken/batarken ziyaret edilmesi önerilir.',
      'İçeride sohbet ve gürültüden kaçınılmalıdır.',
    ],
    enlem: 21.3745,
    boylam: 39.8465,
    ikon: 'terrain',
  ),
  ZiyaretMekani(
    id: 'mekke_mualla',
    ad: 'Cennetü\'l-Mualla',
    bolum: 'Mekke',
    kategori: 'Kabristan',
    kisaAciklama:
        'Hz. Hatice ve birçok sahabenin kabrinin bulunduğu Mekke\'nin eski kabristanı.',
    detaylar: [
      'Hacun denilen bölgede, Mescid-i Haram\'ın kuzeyinde yer alır.',
      'Hz. Hatice (r.a.), Hz. Abdülmuttalib ve Ebu Tâlib\'in kabirleri buradadır.',
      'Hz. Hatice\'nin kabri ziyaretçiler için ayrılmış bölümde işaretlenmiştir.',
    ],
    ziyaretAdabi: [
      'Kabristanda dua edilir, yüksek sesle konuşulmaz.',
      'Mezarların üzerine oturulmaz, basılmaz.',
      'Bayram ve hafta sonları çok kalabalık olur; sabah saatleri daha uygundur.',
    ],
    enlem: 21.4368,
    boylam: 39.8321,
    ikon: 'grass',
  ),
  ZiyaretMekani(
    id: 'mekke_arafat',
    ad: 'Arafat Sahrası',
    bolum: 'Mekke',
    kategori: 'Hac Sahası',
    kisaAciklama: 'Haccın en büyük rüknü olan Arefe vakfesinin yapıldığı sahra.',
    detaylar: [
      'Mekke\'nin yaklaşık 20 km doğusunda yer alır.',
      'Cebel-i Rahme (Rahmet Tepesi) Arafat\'ın merkezindedir.',
      '9 Zilhicce günü burada vakfe yapılır; hacılar güneş batana kadar kalır.',
      'Arefe günü öğle ve ikindi birleştirilerek kısaltılıp kılınır.',
    ],
    ziyaretAdabi: [
      'Vakfe sırasında bolca dua, telbiye ve istiğfar edilir.',
      'Güneş batmadan Arafat\'tan ayrılmamalıdır.',
    ],
    enlem: 21.3547,
    boylam: 39.9833,
    ikon: 'landscape',
  ),
  ZiyaretMekani(
    id: 'mekke_muzdelife',
    ad: 'Müzdelife',
    bolum: 'Mekke',
    kategori: 'Hac Sahası',
    kisaAciklama: 'Arefe gecesi vakfe yapılan ve taşların toplandığı açık alan.',
    detaylar: [
      'Arafat ile Mina arasında yer alır.',
      'Arefe gecesi burada geçirilir; akşam ve yatsı birleştirilerek kılınır.',
      'Şeytan taşlama için nohut büyüklüğünde 49–70 taş buradan toplanır.',
    ],
    ziyaretAdabi: [
      'Açık alanda gece konaklanır; battaniye ve temel ihtiyaçlar hazırlanmalıdır.',
    ],
    enlem: 21.3843,
    boylam: 39.9339,
    ikon: 'landscape',
  ),
  ZiyaretMekani(
    id: 'mekke_mina',
    ad: 'Mina & Cemerât',
    bolum: 'Mekke',
    kategori: 'Hac Sahası',
    kisaAciklama:
        'Şeytan taşlamanın yapıldığı cemeratların bulunduğu bölge; teşrik günlerinde binlerce çadır kurulur.',
    detaylar: [
      'Mekke ile Müzdelife arasında, çadır şehri görünümündedir.',
      'Üç cemre (küçük, orta, Akabe) burada taşlanır.',
      'Terviye gecesi ve teşrik günleri burada geçirilir.',
      'Mina Mescidi (Hîf Mescidi) bölgede önemli bir noktadır.',
    ],
    ziyaretAdabi: [
      'Cemre taşlama kalabalığında güvenlik kurallarına uyulmalıdır.',
      'Teşrik günleri plana göre hareket edilmelidir.',
    ],
    enlem: 21.4136,
    boylam: 39.8932,
    ikon: 'landscape',
  ),
  ZiyaretMekani(
    id: 'mekke_cin',
    ad: 'Cin Mescidi',
    bolum: 'Mekke',
    kategori: 'Mescit',
    kisaAciklama:
        'Peygamberimizin cinlerin Kur\'an dinlemesine vesile olduğu yerde bulunan mescit.',
    detaylar: [
      'Mekke\'nin kuzeyinde, Harem\'e yaklaşık 2 km mesafededir.',
      'Ayet: "Hani cinlerden bir topluluğu Kur\'an\'ı dinlemek üzere sana yöneltmiştik" (Ahkaf 29).',
      'Mescit sade, dış görünümü beyazdır.',
    ],
    ziyaretAdabi: [
      'Namaz kılınır, dua edilir; diğer mescitlerle aynı adap geçerlidir.',
    ],
    enlem: 21.4279,
    boylam: 39.829,
    ikon: 'mosque',
  ),
  ZiyaretMekani(
    id: 'mekke_icabe',
    ad: 'İcâbe Mescidi',
    bolum: 'Mekke',
    kategori: 'Mescit',
    kisaAciklama:
        'Peygamberimizin duasının kabul edildiği yerde yapıldığı rivayet edilen mescit.',
    detaylar: [
      'Mescid-i Haram\'ın kuzeyinde, Ecyâd bölgesinde yer alır.',
      'Rivayete göre Peygamberimiz burada şu duayı yaptı: "Allah\'ım! Bu ümmete rızık, rahmet ve hidayet ver."',
    ],
    ziyaretAdabi: [
      'Namaz kılınır ve dua edilir.',
    ],
    enlem: 21.4457,
    boylam: 39.8349,
    ikon: 'mosque',
  ),
  ZiyaretMekani(
    id: 'mekke_mevlid',
    ad: 'Hz. Peygamber\'in Doğduğu Ev',
    bolum: 'Mekke',
    kategori: 'Tarihî Yer',
    kisaAciklama:
        'Peygamberimizin doğduğu evin bulunduğu alan; günümüzde kütüphane olarak hizmet vermektedir.',
    detaylar: [
      'Mescid-i Haram\'ın güneyinde, Safa kapısı yakınındadır.',
      'Yerinde günümüzde "Mekke Kütüphanesi" bulunmaktadır.',
      'Doğduğu evin kendisi günümüze ulaşmamıştır; alan ziyaret edilir.',
    ],
    ziyaretAdabi: [
      'Kütüphane ziyaretinde sessizlik ve düzen kurallarına uyulmalıdır.',
    ],
    enlem: 21.4309,
    boylam: 39.8271,
    ikon: 'book',
  ),
  // ------------------------- MEDİNE -------------------------
  ZiyaretMekani(
    id: 'medine_nebevi',
    ad: 'Mescid-i Nebevî & Ravza-i Mutahhara',
    bolum: 'Medine',
    kategori: 'Mescit',
    kisaAciklama:
        'Peygamberimizin kabri, minberi ve "cennet bahçesi" Ravza\'nın bulunduğu ikinci kutsal mescit.',
    detaylar: [
      'Medine\'nin merkezinde yer alır; Harem-i Nebevî olarak anılır.',
      'Peygamberimizin kabri Yeşil Kubbe (Kubbe-i Hadrâ) altındadır.',
      'Ravza, minber ile Peygamberimizin evi arasındaki alandır: "Evimle minberim arası cennet bahçelerindendir."',
      'Ravza ziyareti için Nusuk uygulamasından randevu alınması gerekir.',
      'Namaz vakti kadın ve erkek bölümleri ayrıdır; giriş-çıkış kapıları belirlenmiştir.',
    ],
    ziyaretAdabi: [
      'Ravza ziyareti için önceden Nusuk randevusu alınmalıdır.',
      'Peygamberimizin kabrinin önünde saygıyla durulur; yüksek sesle konuşulmaz.',
      'Kabir önünde "Es-Selâmü aleyke eyyühen-nebiy…" diye selam verilir.',
    ],
    enlem: 24.4672,
    boylam: 39.6111,
    ikon: 'mosque',
  ),
  ZiyaretMekani(
    id: 'medine_baki',
    ad: 'Cennetü\'l-Bakî\'',
    bolum: 'Medine',
    kategori: 'Kabristan',
    kisaAciklama:
        'Peygamberimizin ailesi ve binlerce sahabenin defnedildiği Medine\'nin meşhur kabristanı.',
    detaylar: [
      'Mescid-i Nebevî\'nin doğusunda yer alır.',
      'Hz. Osman, Hz. Abbas, Hz. Hamza dışındaki hanım sahabeler ve Peygamberimizin çocukları buradadır.',
      'Kadın ve erkekler için belirlenmiş ziyaret saatleri vardır.',
    ],
    ziyaretAdabi: [
      'Ziyaret saatlerine uyulmalı; kadınlar için özel bölüm/duvar ayrımı vardır.',
      'Mezarların başında durup selam verilir ve dua edilir.',
      'Gürültü ve fotoğraf çekimi uygun değildir.',
    ],
    enlem: 24.4666,
    boylam: 39.6163,
    ikon: 'grass',
  ),
  ZiyaretMekani(
    id: 'medine_kuba',
    ad: 'Kubâ Mescidi',
    bolum: 'Medine',
    kategori: 'Mescit',
    kisaAciklama:
        'İslam tarihinin ilk mescidi; içinde iki rekât namaz kılmanın umre sevabına denk olduğu bildirilmiştir.',
    detaylar: [
      'Medine\'nin güneydoğusunda, yaklaşık 4–5 km mesafededir.',
      'Peygamberimiz hicrette ilk olarak burada konaklamış ve mescidin temelini atmıştır.',
      'Hadis: "Kim evinde temizlenip Kubâ Mescidi\'ne gelir ve orada namaz kılarsa, bir umre sevabı kazanır."',
      'Genellikle Cumartesi günleri ziyaret edilir; giriş kapıları ve çevresi büyük ölçüde yenilenmiştir.',
    ],
    ziyaretAdabi: [
      'İki rekât namaz kılınır; mescit erkek ve kadın bölümlerine ayrılmıştır.',
      'Öğle ve ikindi saatleri en uygun zamanlardır.',
    ],
    enlem: 24.4396,
    boylam: 39.6179,
    ikon: 'mosque',
  ),
  ZiyaretMekani(
    id: 'medine_uhud',
    ad: 'Uhud Şehitliği & Okçular Tepesi',
    bolum: 'Medine',
    kategori: 'Şehitlik',
    kisaAciklama:
        'Uhud Savaşı\'nın yapıldığı alan; Hz. Hamza ve şehit sahabelerin kabirleri buradadır.',
    detaylar: [
      'Medine\'nin kuzeyinde, yaklaşık 5 km mesafededir.',
      'Hz. Hamza (r.a.) "Seyyidü\'ş-Şühedâ" olarak anılır; kabri burada işaretlidir.',
      'Okçular Tepesi, savaşın kaderini belirleyen stratejik noktadır.',
      'Şehitler tepesinde dua etmek için topluca gidilir.',
    ],
    ziyaretAdabi: [
      'Şehitlikte sessizce gezilir, başlarında dua edilir.',
      'Sıcak saatlerde ziyaret önerilmez; sabah veya akşam uygundur.',
    ],
    enlem: 24.5066,
    boylam: 39.6099,
    ikon: 'landscape',
  ),
  ZiyaretMekani(
    id: 'medine_kibleteyn',
    ad: 'Mescid-i Kıbleteyn',
    bolum: 'Medine',
    kategori: 'Mescit',
    kisaAciklama:
        'Kıblenin Kudüs\'ten Kâbe\'ye çevrildiği rivayet edilen mescit.',
    detaylar: [
      'Medine\'nin kuzeybatısında, yaklaşık 4 km mesafededir.',
      'Namaz sırasında kıble emrinin (Bakara 144) geldiği yer olduğu rivayet edilir.',
      'İçinde iki mihrap bulunur (birisi Kâbe, diğeri Kudüs yönüne bakar).',
    ],
    ziyaretAdabi: [
      'Namaz kılınır; iki mihrap ilgiyle incelenir.',
    ],
    enlem: 24.4743,
    boylam: 39.5829,
    ikon: 'mosque',
  ),
  ZiyaretMekani(
    id: 'medine_yedi_mescit',
    ad: 'Yedi Mescitler (Hendek Bölgesi)',
    bolum: 'Medine',
    kategori: 'Mescit',
    kisaAciklama:
        'Hendek Savaşı sırasında Peygamberimizin ve sahabenin ibadet ettiği mescitler.',
    detaylar: [
      'Medine\'nin batısında, Sel\' (vadi) bölgesinde yer alır.',
      'Küçük mescitler Hendek Savaşı\'nda komuta merkezi olarak kullanıldı.',
      'Fatıma, Ali, Selman-ı Fârisî gibi isimlerle anılan mescitler bulunur.',
    ],
    ziyaretAdabi: [
      'Küçük ve tarihî mescitlerde namaz kılınır; toplulukla ziyaret edilir.',
    ],
    enlem: 24.4883,
    boylam: 39.5799,
    ikon: 'mosque',
  ),
];

/// Ziyaret rehberi için bölüm adları (sıralı).
const List<String> ziyaretBolumleri = ['Mekke', 'Medine'];

/// Ziyaret mekânı kategorileri (ikon eşleştirme için).
const Map<String, String> ziyaretKategoriIkonlari = {
  'Mescit': 'mosque',
  'Kabristan': 'grass',
  'Dağ & Mağara': 'terrain',
  'Hac Sahası': 'landscape',
  'Tarihî Yer': 'book',
  'Şehitlik': 'landscape',
};
