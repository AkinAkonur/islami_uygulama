// ===========================================================================
// DEM & FİDYE - FIKIH KARAR AĞACI VERİLERİ
// İhram yasağı ihlali durumunda mezhebe göre hüküm gösteren karar ağacı.
// NOT: Bu içerik genel bilgilendirme amaçlıdır; kesin hüküm için Diyanet
// İşleri Başkanlığı'na veya yetkili bir âlime danışınız.
// ===========================================================================

import 'hac_umre_verileri.dart';

/// Karar ağacının kök düğümü.
const FikihDugumu fikihKok = FikihDugumu(
  id: 'ihlal_turu',
  soru: 'İhramda hangi tür ihlal yapıldı?',
  aciklama:
      'Endişelenmeyin; ihram ihlalleri için belirlenmiş cezalar (dem/fidye) '
      'vardır. Doğru adımı bulmanıza yardımcı olalım.',
  secenekler: [
    FikihSecenegi(
      etiket: 'Koku / Parfüm sürüldü',
      duygu: 'Koku sürüldü',
      altDugumId: 'koku_miktar',
    ),
    FikihSecenegi(
      etiket: 'Tırnak kesildi',
      duygu: 'Tırnak kesildi',
      altDugumId: 'tirnak_sayisi',
    ),
    FikihSecenegi(
      etiket: 'Saç kesildi / tıraş olundu',
      duygu: 'Saç kesildi',
      altDugumId: 'sac_oran',
    ),
    FikihSecenegi(
      etiket: 'Dikişli giysi giyildi (erkek)',
      duygu: 'Dikişli giysi',
      altDugumId: 'dikisli_giysi',
    ),
    FikihSecenegi(
      etiket: 'Av yapıldı / bitki koparıldı',
      duygu: 'Av yapıldı',
      altDugumId: 'av_durum',
    ),
    FikihSecenegi(
      etiket: 'Eş ile ilişki / okşama',
      duygu: 'Eş ile ilişki',
      altDugumId: 'cinsel_durum',
    ),
  ],
);

/// Koku ihlali dallanması.
const FikihDugumu kokuMiktar = FikihDugumu(
  id: 'koku_miktar',
  soru: 'Koku vücudun veya giysinin ne kadar kısmına sürüldü?',
  secenekler: [
    FikihSecenegi(
      etiket: 'Büyük bölüme / tüm vücuda',
      duygu: 'Büyük bölge',
      altDugumId: 'koku_buyuk_sonuc',
    ),
    FikihSecenegi(
      etiket: 'Küçük bir bölgeye (el, yüz vb.)',
      duygu: 'Küçük bölge',
      altDugumId: 'koku_kucuk_sonuc',
    ),
    FikihSecenegi(
      etiket: 'Bir günden uzun kalıcı oldu',
      duygu: 'Kalıcı koku',
      altDugumId: 'koku_kalici_sonuc',
    ),
  ],
);

const FikihDugumu tirnakSayisi = FikihDugumu(
  id: 'tirnak_sayisi',
  soru: 'Kaç tırnak ve nasıl kesildi?',
  secenekler: [
    FikihSecenegi(
      etiket: 'Birkaç tırnak (1–4)',
      duygu: 'Az sayıda',
      altDugumId: 'tirnak_bir_sonuc',
    ),
    FikihSecenegi(
      etiket: 'Tek oturuşta el/ayak tırnaklarının tamamı',
      duygu: 'Hepsi birden',
      altDugumId: 'tirnak_hep_sonuc',
    ),
  ],
);

const FikihDugumu sacOran = FikihDugumu(
  id: 'sac_oran',
  soru: 'Saçların ne kadarı kesildi veya alındı?',
  secenekler: [
    FikihSecenegi(
      etiket: 'Başın dörtte birinden azı',
      duygu: 'Az kısmı',
      altDugumId: 'sac_kucuk_sonuc',
    ),
    FikihSecenegi(
      etiket: 'Yarısı veya tamamı',
      duygu: 'Yarısı/tamamı',
      altDugumId: 'sac_buyuk_sonuc',
    ),
  ],
);

const FikihDugumu dikisliGiysi = FikihDugumu(
  id: 'dikisli_giysi',
  soru: 'Dikişli giysi ne kadar süre giyildi?',
  secenekler: [
    FikihSecenegi(
      etiket: 'Kısa bir süre (zaruri hâl dışında)',
      duygu: 'Kısa süre',
      altDugumId: 'dikisli_giysi_sonuc',
    ),
    FikihSecenegi(
      etiket: 'Zaruretten dolayı giyildi',
      duygu: 'Zaruret',
      altDugumId: 'dikisli_zaruret_sonuc',
    ),
  ],
);

const FikihDugumu avDurum = FikihDugumu(
  id: 'av_durum',
  soru: 'Avlanan hayvan veya koparılan bitki durumu nedir?',
  secenekler: [
    FikihSecenegi(
      etiket: 'Kara avı (ceylan, tavşan vb.)',
      duygu: 'Kara avı',
      altDugumId: 'av_sonuc',
    ),
    FikihSecenegi(
      etiket: 'Haremdeki ağaç/ot koparıldı',
      duygu: 'Bitki',
      altDugumId: 'bitki_sonuc',
    ),
  ],
);

const FikihDugumu cinselDurum = FikihDugumu(
  id: 'cinsel_durum',
  soru: 'Durumun boyutu neydi?',
  secenekler: [
    FikihSecenegi(
      etiket: 'Tam ilişki',
      duygu: 'Tam ilişki',
      altDugumId: 'cinsel_tam_sonuc',
    ),
    FikihSecenegi(
      etiket: 'Öpme / okşama (ilişkisiz)',
      duygu: 'Öpme/okşama',
      altDugumId: 'cinsel_hafif_sonuc',
    ),
  ],
);

/// Karar ağacı: tüm düğümler ve sonuçlar.
const Map<String, FikihDugumu> fikihDugumler = {
  'ihlal_turu': fikihKok,
  'koku_miktar': kokuMiktar,
  'tirnak_sayisi': tirnakSayisi,
  'sac_oran': sacOran,
  'dikisli_giysi': dikisliGiysi,
  'av_durum': avDurum,
  'cinsel_durum': cinselDurum,
};

const Map<String, FikihSonuc> fikihSonuclar = {
  'koku_buyuk_sonuc': FikihSonuc(
    id: 'koku_buyuk_sonuc',
    baslik: 'Koku - Büyük Bölge',
    ozet: 'İhramda vücudun veya giysinin büyük bölümüne koku sürülmesi ceza gerektirir.',
    mezhepHukumleri: {
      'Hanefi': 'Dem gerekir: Bir koyun/keçi kurban kesilir.',
      'Şafiî': 'Fidye gerekir: Bir koyun kesilir veya sadaka verilir.',
      'Maliki': 'Dem gerekir: Bir koyun/keçi kurban kesilir.',
      'Hanbeli': 'Dem gerekir: Bir koyun/keçi kurban kesilir.',
    },
    notlar: [
      'Kurban, Harem bölgesinde kesilmeli ve eti ihtiyaç sahiplerine dağıtılmalıdır.',
    ],
  ),
  'koku_kucuk_sonuc': FikihSonuc(
    id: 'koku_kucuk_sonuc',
    baslik: 'Koku - Küçük Bölge',
    ozet: 'Küçük bir bölgeye sürülen koku için ceza, mezhebe göre sadaka veya fidye düzeyindedir.',
    mezhepHukumleri: {
      'Hanefi': 'Sadaka-i fıtır miktarı kadar sadaka verilir.',
      'Şafiî': 'Fidye gerekir (sadaka veya nafile ibadet; âlime danışılmalı).',
      'Maliki': 'Sadaka verilmesi yeterli görülür.',
      'Hanbeli': 'Sadaka verilmesi yeterli görülür.',
    },
    notlar: [
      'Bu gibi küçük ihlallerde en doğrusu o gün sadaka verip tövbe etmektir.',
    ],
  ),
  'koku_kalici_sonuc': FikihSonuc(
    id: 'koku_kalici_sonuc',
    baslik: 'Koku - Kalıcı',
    ozet: 'Kokunun bir günden uzun süre üstte kalması cezayı ağırlaştırır.',
    mezhepHukumleri: {
      'Hanefi': 'Dem (bir koyun/keçi) gerekir.',
      'Şafiî': 'Fidye gerekir; mümkünse kurban kesilir.',
      'Maliki': 'Dem gerekir.',
      'Hanbeli': 'Dem gerekir.',
    },
    notlar: [
      'Koku süren ihram elbisesini hemen çıkarıp yıkamak gerekir.',
    ],
  ),
  'tirnak_bir_sonuc': FikihSonuc(
    id: 'tirnak_bir_sonuc',
    baslik: 'Tırnak - Az Sayıda',
    ozet: 'İhramda az sayıda tırnak kesmek hafif ceza gerektirir.',
    mezhepHukumleri: {
      'Hanefi': 'Her tırnak için bir müd (avuç dolusu) yiyecek sadaka verilir.',
      'Şafiî': 'Sadaka verilmesi gerekir.',
      'Maliki': 'Sadaka verilmesi yeterlidir.',
      'Hanbeli': 'Sadaka verilmesi yeterlidir.',
    },
    notlar: [
      'Tırnakları keserken kırılmadan uzamasını beklemek ihramda daha iyidir.',
    ],
  ),
  'tirnak_hep_sonuc': FikihSonuc(
    id: 'tirnak_hep_sonuc',
    baslik: 'Tırnak - Hepsi Birden',
    ozet: 'El ve/veya ayak tırnaklarının tamamının tek oturuşta kesilmesi daha ağır ceza gerektirir.',
    mezhepHukumleri: {
      'Hanefi': 'Dem gerekir: Bir koyun/keçi kurban kesilir.',
      'Şafiî': 'Fidye gerekir; âlime danışılmalıdır.',
      'Maliki': 'Dem gerekir.',
      'Hanbeli': 'Dem gerekir.',
    },
    notlar: [
      'İhram öncesi tırnakların kesilerek temiz girilmesi en güvenli yoldur.',
    ],
  ),
  'sac_kucuk_sonuc': FikihSonuc(
    id: 'sac_kucuk_sonuc',
    baslik: 'Saç - Az Kısım',
    ozet: 'İhramda saçın dörtte birinden azının kesilmesi hafif ceza gerektirir.',
    mezhepHukumleri: {
      'Hanefi': 'Sadaka-i fıtır miktarı sadaka verilir.',
      'Şafiî': 'Sadaka verilir.',
      'Maliki': 'Sadaka verilir.',
      'Hanbeli': 'Sadaka verilir.',
    },
    notlar: [
      'Saç yapıştırıcı, tarak gibi kopmaya yol açan etkenlerden kaçınılmalıdır.',
    ],
  ),
  'sac_buyuk_sonuc': FikihSonuc(
    id: 'sac_buyuk_sonuc',
    baslik: 'Saç - Yarısı veya Tamamı',
    ozet: 'İhramda saçın yarısını veya tamamını almak dem gerektirir.',
    mezhepHukumleri: {
      'Hanefi': 'Dem gerekir: Bir koyun/keçi kurban kesilir.',
      'Şafiî': 'Fidye gerekir (kurban tavsiye edilir).',
      'Maliki': 'Dem gerekir.',
      'Hanbeli': 'Dem gerekir.',
    },
    notlar: [
      'Hac/umre bitiminde yapılan meşru tıraş ile karıştırılmamalıdır.',
    ],
  ),
  'dikisli_giysi_sonuc': FikihSonuc(
    id: 'dikisli_giysi_sonuc',
    baslik: 'Dikişli Giysi',
    ozet: 'İhramda (erkek için) dikişli/örülmüş giysi giymek ceza gerektirir.',
    mezhepHukumleri: {
      'Hanefi': 'Sadaka-i fıtır miktarı sadaka verilir.',
      'Şafiî': 'Fidye gerekir; âlime danışılmalıdır.',
      'Maliki': 'Sadaka verilir.',
      'Hanbeli': 'Sadaka verilir.',
    },
    notlar: [
      'Zaruret hâli (soğuk, sağlık) dışında dikişli giysiden kaçınılmalıdır.',
    ],
  ),
  'dikisli_zaruret_sonuc': FikihSonuc(
    id: 'dikisli_zaruret_sonuc',
    baslik: 'Dikişli Giysi - Zaruret',
    ozet: 'Zaruretten dolayı dikişli giysi giymek (aşırı soğuk, hastalık) mazur sayılır; ceza gerektirmez.',
    mezhepHukumleri: {
      'Hanefi': 'Ceza gerekmez; ihtiyaç bittiğinde çıkarılmalıdır.',
      'Şafiî': 'Ceza gerekmez (zaruret hâlinde).',
      'Maliki': 'Ceza gerekmez.',
      'Hanbeli': 'Ceza gerekmez.',
    },
    notlar: [
      'Zaruret hâlinde eldiven, baş örtüsü vb. de mazur kabul edilir.',
    ],
  ),
  'av_sonuc': FikihSonuc(
    id: 'av_sonuc',
    baslik: 'Kara Avı',
    ozet: 'İhramda kara avı yapmak dem gerektirir; hükmü maddi değer üzerinden kurbanla ödenir.',
    mezhepHukumleri: {
      'Hanefi': 'Avın değerine göre kurban (dem) kesilir veya bedeli sadaka verilir.',
      'Şafiî': 'Değeri kadar kurban veya bedeli gerekir.',
      'Maliki': 'Değerine göre dem gerekir.',
      'Hanbeli': 'Değerine göre dem gerekir.',
    },
    notlar: [
      'Avlanan hayvanın değeri, âlim veya yetkililerce belirlenir; birebir kıyas yapılmaz.',
    ],
  ),
  'bitki_sonuc': FikihSonuc(
    id: 'bitki_sonuc',
    baslik: 'Haremde Bitki Koparma',
    ozet: 'Mekke Harem bölgesinde taze ağaç ve ot koparmak ceza gerektirir.',
    mezhepHukumleri: {
      'Hanefi': 'Koparılan bitki değerinde sadaka verilir.',
      'Şafiî': 'Sadaka verilir.',
      'Maliki': 'Sadaka verilir.',
      'Hanbeli': 'Sadaka verilir.',
    },
    notlar: [
      'İzmir veya kuru otlar bu hükmün dışındadır.',
    ],
  ),
  'cinsel_tam_sonuc': FikihSonuc(
    id: 'cinsel_tam_sonuc',
    baslik: 'Tam İlişki',
    ozet: 'İhramda eşle tam ilişki haccın rüknünü bozar; ağır kefaret gerekir. Bu durumda hemen bir âlime danışılmalıdır.',
    mezhepHukumleri: {
      'Hanefi': 'Büyük kefaret: deve; bulunamazsa eşdeğeri. Hac tamamlanır, ertesi yıl yenilenir.',
      'Şafiî': 'Büyük kefaret ve haccın yenilenmesi gerekir.',
      'Maliki': 'Büyük kefaret gerekir.',
      'Hanbeli': 'Büyük kefaret gerekir.',
    },
    notlar: [
      'Bu durumda öncelik Diyanet veya yetkili âlim ile görüşmektir.',
    ],
  ),
  'cinsel_hafif_sonuc': FikihSonuc(
    id: 'cinsel_hafif_sonuc',
    baslik: 'Öpme / Okşama',
    ozet: 'İlişkiye varmayan öpme ve okşama dem gerektirir.',
    mezhepHukumleri: {
      'Hanefi': 'Dem gerekir: Bir koyun/keçi kurban kesilir.',
      'Şafiî': 'Dem gerekir.',
      'Maliki': 'Dem gerekir.',
      'Hanbeli': 'Dem gerekir.',
    },
    notlar: [
      'Meni gelirse ceza ağırlaşır; âlime danışılmalıdır.',
    ],
  ),
};

/// Genel bilgilendirme notu.
const String fikihUyari =
    'Bu karar ağacı genel bilgilendirme amaçlıdır ve ibadet hükümleriyle ilgili '
    'nihaî görüş değildir. Kesin hüküm için Diyanet İşleri Başkanlığı\'na veya '
    'yetkili bir âlime danışınız.';
