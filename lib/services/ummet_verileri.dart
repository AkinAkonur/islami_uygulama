import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// ===========================================================================
// ÜMMET BÖLÜMÜ - YEREL VERİLER & KALICI DEPO
// ===========================================================================

String binlikSayi(int n) {
  final s = n.abs().toString();
  final b = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) {
      b.write('.');
    }
    b.write(s[i]);
  }
  return (n < 0 ? '-' : '') + b.toString();
}

// ---------------- MODELLER ----------------

class DuaIstek {
  DuaIstek({
    required this.id,
    required this.rumuz,
    required this.metin,
    required this.kategori,
    this.duaSayisi = 0,
    this.anonim = false,
  });

  final String id;
  final String rumuz;
  final String metin;
  final String kategori;
  int duaSayisi;
  final bool anonim;

  Map<String, dynamic> toJson() => {
        'id': id,
        'rumuz': rumuz,
        'metin': metin,
        'kategori': kategori,
        'duaSayisi': duaSayisi,
        'anonim': anonim,
      };

  factory DuaIstek.fromJson(Map<String, dynamic> j) => DuaIstek(
        id: j['id'] as String,
        rumuz: j['rumuz'] as String,
        metin: j['metin'] as String,
        kategori: j['kategori'] as String,
        duaSayisi: (j['duaSayisi'] as num?)?.toInt() ?? 0,
        anonim: (j['anonim'] as bool?) ?? false,
      );
}

class DuaZinciri {
  DuaZinciri({
    required this.id,
    required this.ad,
    required this.detay,
    required this.duaMetni,
    required this.hedef,
    required this.taban,
  });

  final String id;
  final String ad;
  final String detay;
  final String duaMetni;
  final int hedef;
  final int taban;
}

class ZikirKampanyasi {
  ZikirKampanyasi({
    required this.id,
    required this.ad,
    required this.arapca,
    required this.hedef,
    required this.taban,
    this.birim = 'zikir',
  });

  final String id;
  final String ad;
  final String arapca;
  final int hedef;
  final int taban;
  final String birim;
}

/// Küresel yardım kampanyası: güvenilir kurumların bağış köprüleri.
class YardimKampanyasi {
  YardimKampanyasi({
    required this.id,
    required this.ad,
    required this.aciklama,
    required this.kurum,
    required this.ikon,
    required this.birim,
    this.katilan = 0,
    this.delil,
    this.kaynak,
  });

  final String id;
  final String ad;
  final String aciklama;
  final String kurum;
  final String ikon;
  final String birim;
  int katilan;
  final String? delil;
  final String? kaynak;
}

/// Zekât hesabı giriş kalemi.
class ZekatKalemi {
  ZekatKalemi(this.ad, {this.tutar = 0});
  final String ad;
  double tutar;
}

/// Soru-cevap / fetva arşiv maddesi.
class FetvaKaydi {
  FetvaKaydi({
    required this.id,
    required this.soru,
    required this.cevap,
    required this.kategori,
    this.kaynak = 'Diyanet İşleri Başkanlığı',
  });

  final String id;
  final String soru;
  final String cevap;
  final String kategori;
  final String kaynak;
}

/// Küresel etkinlik / program kaydı.
class UmmetEtkinligi {
  UmmetEtkinligi({
    required this.id,
    required this.ad,
    required this.aciklama,
    required this.tarih, // 'MM-DD' veya '' sürekli
    required this.ikon,
    this.canli = false,
    this.url,
  });

  final String id;
  final String ad;
  final String aciklama;
  final String tarih;
  final String ikon;
  final bool canli;
  final String? url;
}

/// Manevi gelişim halkası (okuma/ibadet grubu).
class ManeviHalka {
  ManeviHalka({
    required this.id,
    required this.ad,
    required this.aciklama,
    required this.ikon,
    this.uyeTabani = 0,
  });

  final String id;
  final String ad;
  final String aciklama;
  final String ikon;
  final int uyeTabani;
}

// ---------------- DUA KATEGORİLERİ ----------------

final duaKategorileri = [
  {
    'id': 'sifa',
    'ad': 'Şifa',
    'ikon': '🩺',
    'aciklama': 'Hasta kardeşlerimize şifa dilekleri',
  },
  {
    'id': 'borc',
    'ad': 'Borç / Rızık',
    'ikon': '💼',
    'aciklama': 'Borçtan kurtuluş ve helal rızık',
  },
  {
    'id': 'sinav',
    'ad': 'Sınav / Başarı',
    'ikon': '📚',
    'aciklama': 'Sınavlar ve önemli işler için başarı',
  },
  {
    'id': 'aile',
    'ad': 'Aile Huzuru',
    'ikon': '🏡',
    'aciklama': 'Aile içi huzur, evlilik ve çocuklar',
  },
  {
    'id': 'hidayet',
    'ad': 'Hidayet',
    'ikon': '🕊️',
    'aciklama': 'Doğru yol için hidayet dilekleri',
  },
];

final kategoriDualari = <String, List<Map<String, String>>>{
  'sifa': [
    {
      'baslik': 'Şifa Duası (Hz. Peygamber\'den)',
      'arapca':
          'اللَّهُمَّ رَبَّ النَّاسِ أَذْهِبِ الْبَأْسَ، اشْفِ أَنْتَ الشَّافِي، لَا شِفَاءَ إِلَّا شِفَاؤُكَ، شِفَاءً لَا يُغَادِرُ سَقَمًا',
      'turkce':
          'Allah\'ım! Ey insanların Rabbi! Sıkıntıyı gider, şifa ver. Şifa veren yalnız Sensin. Senin şifandan başka şifa yoktur. Öyle bir şifa ver ki hiçbir hastalık bırakmasın.',
      'kaynak': 'Buhârî, Merdâ 20; Müslim, Selâm 46',
    },
    {
      'baslik': 'Hz. Eyyub Duası',
      'arapca':
          'أَنِّي مَسَّنِيَ الضُّرُّ وَأَنْتَ أَرْحَمُ الرَّاحِمِينَ',
      'turkce':
          'Bana gerçekten bir zarar dokundu; Sen ise merhametlilerin en merhametlisisin.',
      'kaynak': 'Enbiyâ Suresi, 83. Ayet',
    },
  ],
  'borc': [
    {
      'baslik': 'Borçtan Kurtuluş Duası',
      'arapca':
          'اللَّهُمَّ اكْفِنِي بِحَلَالِكَ عَنْ حَرَامِكَ، وَأَغْنِنِي بِفَضْلِكَ عَمَّنْ سِوَاكَ',
      'turkce':
          'Allah\'ım! Bana haramdan kaçınmayı helal rızıkla nasip et; beni Senden başkasına muhtaç etmeyecek şekilde lutfunla zengin kıl.',
      'kaynak': 'Tirmizî, Deavât 109',
    },
    {
      'baslik': 'Rızık Duası (Hz. Musa)',
      'arapca':
          'رَبِّ إِنِّي لِمَا أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ',
      'turkce':
          'Rabbim! Bana indireceğin her hayra muhtacım.',
      'kaynak': 'Kasas Suresi, 24. Ayet',
    },
  ],
  'sinav': [
    {
      'baslik': 'Başarı Duası (Hz. Musa)',
      'arapca':
          'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِنْ لِسَانِي',
      'turkce':
          'Rabbim! Gönlüme ferahlık ver, işimi kolaylaştır ve dilimdeki düğümü çöz ki sözümü iyi anlasınlar.',
      'kaynak': 'Tâhâ Suresi, 25-28. Ayetler',
    },
    {
      'baslik': 'İlim Duası',
      'arapca':
          'اللَّهُمَّ انْفَعْنِي بِمَا عَلَّمْتَنِي وَعَلِّمْنِي مَا يَنْفَعُنِي وَزِدْنِي عِلْمًا',
      'turkce':
          'Allah\'ım! Bana öğrettiklerinle faydalandır, bana faydalı ilmi öğret ve ilmimi artır.',
      'kaynak': 'Tirmizî, Deavât 128',
    },
  ],
  'aile': [
    {
      'baslik': 'Aile Huzuru Duası',
      'arapca':
          'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
      'turkce':
          'Rabbimiz! Bize eşlerimizden ve çocuklarımızdan göz aydınlığı ver ve bizi takva sahiplerine önder kıl.',
      'kaynak': 'Furkân Suresi, 74. Ayet',
    },
    {
      'baslik': 'Evlilik Hayır Duası',
      'arapca':
          'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
      'turkce':
          'Rabbimiz! Bize dünyada iyilik ver, ahirette de iyilik ver ve bizi ateş azabından koru.',
      'kaynak': 'Bakara Suresi, 201. Ayet',
    },
  ],
  'hidayet': [
    {
      'baslik': 'Hidayet Duası (Fâtiha)',
      'arapca':
          'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
      'turkce': 'Bizi dosdoğru yola ilet.',
      'kaynak': 'Fâtiha Suresi, 6. Ayet',
    },
    {
      'baslik': 'Sevgi ve Hidayet Duası',
      'arapca':
          'اللَّهُمَّ أَلِّفْ بَيْنَ قُلُوبِنَا، وَأَصْلِحْ ذَاتَ بَيْنِنَا، وَاهْدِنَا سُبُلَ السَّلَامِ',
      'turkce':
          'Allah\'ım! Kalplerimizi birleştir, aramızı düzelt ve bizi esenlik yollarına ilet.',
      'kaynak': 'Ebû Dâvûd, Edeb 74',
    },
  ],
};

// ---------------- DUA DUVARI SEED VERİLERİ ----------------

final seedDuaIstekleri = [
  DuaIstek(
    id: 'seed1',
    rumuz: 'Karanlık Yolcu',
    metin:
        'Hasta annem için şifa istiyorum. Dualarınıza muhtacım, çok zor günler geçiriyoruz.',
    kategori: 'Şifa',
    duaSayisi: 1420,
  ),
  DuaIstek(
    id: 'seed2',
    rumuz: 'Sabır Gemisi',
    metin:
        'Borç yükümüz giderek artıyor. Helal bir rızık kapısı açılması için dua edin kardeşlerim.',
    kategori: 'Borç / Rızık',
    duaSayisi: 860,
  ),
  DuaIstek(
    id: 'seed3',
    rumuz: 'Anonim Kardeş',
    metin:
        'YKS\'ye hazırlanıyorum, sınavıma çok az kaldı. Rabbim zihin açıklığı versin diye dua eder misiniz?',
    kategori: 'Sınav / Başarı',
    duaSayisi: 1940,
  ),
  DuaIstek(
    id: 'seed4',
    rumuz: 'Dua Kardeşin',
    metin:
        'Evimizde huzur kalmadı. Ailemizin tekrar bir olması, kalplerimizin yumuşaması için dua edin.',
    kategori: 'Aile Huzuru',
    duaSayisi: 2350,
  ),
  DuaIstek(
    id: 'seed5',
    rumuz: 'Yolcu',
    metin:
        'Yıllardır namaza başlayamıyorum, kalbim taş gibi. Rabbimin hidayeti için dua edin bana.',
    kategori: 'Hidayet',
    duaSayisi: 3105,
  ),
  DuaIstek(
    id: 'seed6',
    rumuz: 'Umut Perisi',
    metin:
        'Kardeşim 3 yaşında, kanser tedavisi görüyor. Gözyaşlarımıza ortak olun, şifa için dua edin.',
    kategori: 'Şifa',
    duaSayisi: 4780,
  ),
];

// ---------------- DUA ZİNCİRLERİ ----------------

final duaZincirleriSeed = [
  DuaZinciri(
    id: 'fetih',
    ad: 'Gazze için Fetih Suresi',
    detay: 'Küresel hedef: 100.000 Fetih Suresi',
    duaMetni:
        'Fetih Suresi, zafer ve kurtuluş müjdesidir. Herkes üzerine düşeni yapsın.',
    hedef: 100000,
    taban: 41350,
  ),
  DuaZinciri(
    id: 'yasin',
    ad: 'Kudüs ve Mescid-i Aksa için Yâsîn',
    detay: 'Küresel hedef: 50.000 Yâsîn',
    duaMetni:
        'Kalbi ölüleri dirilten sure. Mescid-i Aksa\'nın hürriyeti için Yâsîn okuyalım.',
    hedef: 50000,
    taban: 18720,
  ),
  DuaZinciri(
    id: 'kunut',
    ad: 'Mazlumlar için Kunut Duası',
    detay: 'Küresel hedef: 1.000.000 dua',
    duaMetni:
        'Rasulullah\'ın (s.a.v.) beddua değil, zulme uğrayanlar için yaptığı Kunut duası.',
    hedef: 1000000,
    taban: 612400,
  ),
  DuaZinciri(
    id: 'sifa',
    ad: 'Hastalar için Şifa Salavatı',
    detay: 'Küresel hedef: 500.000 salavat',
    duaMetni:
        'Her hastaya şifa niyetiyle salavat getirelim; şifa kapısı açılsın.',
    hedef: 500000,
    taban: 203150,
  ),
  DuaZinciri(
    id: 'hidayet',
    ad: 'Ümmetin Hidayeti için Dua',
    detay: 'Küresel hedef: 1.000.000 dua',
    duaMetni:
        'Rabbimiz, ümmetin kalbine merhametinle dokun; hidayete erdir.',
    hedef: 1000000,
    taban: 487900,
  ),
];

// ---------------- ZİKİR KAMPANYALARI ----------------

final zikirKampanyalariSeed = [
  ZikirKampanyasi(
    id: 'salavat',
    ad: 'Salavat-ı Şerife',
    arapca: 'اَللّٰهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ',
    hedef: 10000000,
    taban: 3240550,
    birim: 'salavat',
  ),
  ZikirKampanyasi(
    id: 'tevhid',
    ad: 'Kelime-i Tevhid',
    arapca: 'لَا إِلٰهَ إِلَّا اللهُ',
    hedef: 10000000,
    taban: 2815320,
    birim: 'tevhid',
  ),
  ZikirKampanyasi(
    id: 'istigfar',
    ad: 'İstiğfar',
    arapca: 'أَسْتَغْفِرُ اللهَ',
    hedef: 10000000,
    taban: 4120875,
    birim: 'istiğfar',
  ),
  ZikirKampanyasi(
    id: 'esma',
    ad: 'Esma-i Hüsna (Ya Allah)',
    arapca: 'يَا اَللهُ',
    hedef: 5000000,
    taban: 1934600,
    birim: 'zikir',
  ),
  ZikirKampanyasi(
    id: 'havkale',
    ad: 'Lâ Havle ve Lâ Kuvvete',
    arapca: 'لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ',
    hedef: 5000000,
    taban: 1587245,
    birim: 'zikir',
  ),
];

// ---------------- MAZLUM COĞRAFYALAR ----------------

final mazlumBolgeler = [
  {
    'bayrak': '🇵🇸',
    'ad': 'Filistin',
    'durum':
        'Gazze\'de insani durum her geçen gün ağırlaşıyor. Açlık, göç ve çocukların geleceği tehdit altında. Dualarımız ve sadakalarımız onlarla.',
    'kurumlar': 'Kızılay • İHH • AFAD • UNRWA',
    'delil':
        'Müminler birbirlerini sevmede, birbirlerine merhamette tek bir beden gibidir.',
    'kaynak': 'Buhârî, Edeb 27',
  },
  {
    'bayrak': '🕌',
    'ad': 'Doğu Türkistan',
    'durum':
        'Doğu Türkistan\'da kardeşlerimiz inançlarından dolayı baskı görüyor. Camiler kapatılıyor, Kur\'an eğitimi engelleniyor.',
    'kurumlar': 'STK\'ların raporları ve insan hakları örgütleri',
    'delil': 'Müslüman, Müslümanın kardeşidir; ona zulmetmez ve onu yalnız bırakmaz.',
    'kaynak': 'Buhârî, Mezâlim 3',
  },
  {
    'bayrak': '🇾🇪',
    'ad': 'Yemen',
    'durum':
        'Yemen dünyanın en büyük insani krizlerinden birini yaşıyor. Milyonlarca insan gıda ve temiz suya erişemiyor.',
    'kurumlar': 'Kızılay • İHH • UNICEF',
    'delil': 'Komşusu açken tok yatan bizden değildir.',
    'kaynak': 'Hâkim, Müstedrek 4/351',
  },
  {
    'bayrak': '🇲🇲',
    'ad': 'Arakan',
    'durum':
        'Arakanlı kardeşlerimiz yıllardır evlerinden edilmiş durumda; kamplarda zor şartlarda yaşıyorlar.',
    'kurumlar': 'Kızılay • İHH • IOM',
    'delil': 'Bir kimse, Müslüman kardeşinin ihtiyacını giderirse Allah da onun ihtiyacını giderir.',
    'kaynak': 'Buhârî, Mezâlim 3',
  },
  {
    'bayrak': '🇮🇳',
    'ad': 'Keşmir',
    'durum':
        'Keşmir\'de kardeşlerimiz on yıllardır zulüm altında; hakları ve kimlikleri için mücadele ediyorlar.',
    'kurumlar': 'İnsan hakları örgütleri ve vakıflar',
    'delil': 'Kardeşin zulmeden de olsa mazlum da olsa yardım et.',
    'kaynak': 'Buhârî, Mezâlim 4',
  },
  {
    'bayrak': '🇸🇾',
    'ad': 'Suriye',
    'durum':
        'Suriye\'de savaşın yaraları hâlâ taze; milyonlarca mülteci evine dönemiyor.',
    'kurumlar': 'Kızılay • İHH • AFAD',
    'delil': 'Sadaka, belayı defeder.',
    'kaynak': 'Tirmizî, Zekât 28',
  },
];

// ---------------- İYİLİK HİKAYELERİ ----------------

final iyilikHikayeleri = [
  {
    'tema': 'İyilik Hikayesi',
    'baslik': 'Çorbada Tuzu Olan',
    'hikaye':
        'Bir mahallede her akşam farklı bir ev, komşusuna çorba pişirirdi. Kimse kimseye söylemezdi. Yıllar sonra öğrendiler ki bu gelenek, mahalleyi bir aile yapmış; tek bir yetim ve yaşlı aç kalmamıştı. Küçük sadakalar, büyük kardeşlikler kurar.',
  },
  {
    'tema': 'Yeni Müslüman',
    'baslik': 'Ahmed\'in Yolu',
    'hikaye':
        'Amerikalı bir genç, İslam\'ı araştırırken tesadüfen bir caminin kapısını çaldı. Cami cemaati onu bir akşam yemeğine davet etti; orada kendini hiç yabancı hissetmedi. "Beni İslam\'a çeken ayetler değil, müminlerin birbirine olan sevgisiydi" diyor bugün Ahmed.',
  },
  {
    'tema': 'İyilik Hikayesi',
    'baslik': 'İlk Seccade',
    'hikaye':
        'Bir fabrika işçisi, aylarca biriktirdiği para yerine komşusunun çocuğu için okul kıyafeti aldı. "Çocuk okula gidecekse, benim seccadem yerde de namazım olur" dedi. Gönlü zengin olanın seccadesi her yerdir.',
  },
  {
    'tema': 'Yeni Müslüman',
    'baslik': 'Meryem\'in Huzuru',
    'hikaye':
        'Almanya\'da büyüyen Meryem, arkadaşının ailesiyle geçirdiği bir Ramazan ayında orucun hikmetini öğrendi. İlk iftarını paylaştığı o sofrada Müslüman oldu. "Hayatımda ilk kez bir topluluğun parçası oldum" diyor.',
  },
  {
    'tema': 'İyilik Hikayesi',
    'baslik': 'Küçük Eller, Büyük İyilik',
    'hikaye':
        '7 yaşındaki bir kız çocuğu, harçlığından biriktirdiği parayla bir yetim çocuğa kışlık bot aldı. Babası ona "Bu parayla oyuncak da alabilirdin" dedi. Kızının cevabı unutulmazdı: "Baba, onun ayakları üşümesin; benim oyuncağım bol."',
  },
  {
    'tema': 'İyilik Hikayesi',
    'baslik': 'Kardeşlik Köprüsü',
    'hikaye':
        'Bir deprem sonrası, ülkenin dört bir yanından gönüllüler enkaz kentine koştu. Aralarında yıllardır küs olan iki komşu da vardı. Çadır kuran elleri yan yana gelince, küsler barıştı. "Felaketler ayırır değil, birleştirir" dediler.',
  },
];

// ---------------- GÜNLÜK İYİLİK GÖREVLERİ ----------------

final gunlukGorevler = [
  {
    'id': 'yetim',
    'ikon': '🧸',
    'ad': 'Bir yetimi sevindir',
    'detay': 'Bir yetime hediye al, harçlık ver ya da en azından başını okşa.',
    'delil': '"Yetimin başını okşayanın, kıyamet günü göklerde komşum olmasını isterim."',
  },
  {
    'id': 'akraba',
    'ikon': '📞',
    'ad': 'Bir akrabanı ara',
    'detay': 'Halini hatırını sor, sıla-i rahmi ihmal etme.',
    'delil': '"Kim rızkının genişlemesini ve ecelinin gecikmesini isterse akrabasını ziyaret etsin."',
  },
  {
    'id': 'sadaka',
    'ikon': '🤲',
    'ad': 'Bir sadaka ver',
    'detay': 'Ne kadar küçük olursa olsun; bir ekmek, bir su bile.',
    'delil': '"Sadaka, belayı defeder; ömrü uzatır."',
  },
  {
    'id': 'doyur',
    'ikon': '🍲',
    'ad': 'Bir ihtiyaç sahibini doyur',
    'detay': 'Komşundan, camideki fakirden ya da bir kurumdan birinin karnını doyur.',
    'delil': '"Bir kişiyi doyuran, kıyamet günü hesaba çekilmeden cennete girer."',
  },
  {
    'id': 'komsu',
    'ikon': '🍵',
    'ad': 'Bir komşuna ikramda bulun',
    'detay': 'Bir çay, bir tabak yemek; gönül alan her ikram iyiliktir.',
    'delil': '"Komşusu açken tok yatan bizden değildir."',
  },
  {
    'id': 'hasta',
    'ikon': '🏥',
    'ad': 'Bir hastayı ziyaret et veya ara',
    'detay': 'Hasta birini telefonla arayıp geçmiş olsun dile ya da ziyaret et.',
    'delil': '"Kim bir hastayı ziyaret ederse, cennet bahçelerinden birinde dolaşmış olur."',
  },
  {
    'id': 'gulumset',
    'ikon': '😊',
    'ad': 'Bir yabancıyı gülümset',
    'detay': 'Selam ver, küçük bir iltifat et; güzel söz sadakadır.',
    'delil': '"Güzel söz sadakadır. Kardeşini güler yüzle karşılaman da bir iyiliktir."',
  },
];

// ---------------- HATİM HALKALARI ----------------

final hatimOnKatilim = {
  1: 'Ahmet K.',
  5: 'Fatma S.',
  9: 'Yusuf E.',
  14: 'Zeynep A.',
  20: 'Burak T.',
  27: 'Meryem Y.',
  30: 'Hasan D.',
};

const hatimTabaniTamamlanan = 128940;

// ---------------- KÜRESEL YARDIM KAMPANYALARI ----------------

final yardimKampanyalari = [
  YardimKampanyasi(
    id: 'su_kuyusu',
    ad: 'Su Kuyusu Aç',
    aciklama: 'Kuraklık ve susuzluk bölgelerinde temiz su kaynağı. Bir kuyu yüzlerce ailenin hayatını değiştirir.',
    kurum: 'İHH • Yeryüzü Doktorları • AFAD',
    ikon: '🚰',
    birim: 'kuyu',
    katilan: 12480,
    delil: '"Bir kişinin su ihtiyacını giderenin mükâfatı sadakadır."',
    kaynak: 'Müslim, Zekât 67',
  ),
  YardimKampanyasi(
    id: 'gida_paketi',
    ad: 'Gıda Kolisi Paylaş',
    aciklama: 'Ramazan ve yıl boyunca ihtiyaç sahibi ailelere temel gıda paketleri: un, bakliyat, yağ ve şeker.',
    kurum: 'Kızılay • İHH • Deniz Feneri',
    ikon: '🍲',
    birim: 'koli',
    katilan: 23140,
    delil: '"Aç bir kimseyi doyurana, Allah kıyamet günü cennet meyvelerinden yedirir."',
    kaynak: 'Taberânî, Evsat 5/232',
  ),
  YardimKampanyasi(
    id: 'yetim_sponsorlugu',
    ad: 'Yetim Sponsoru Ol',
    aciklama: 'Yetim çocukların eğitim, barınma ve sağlık giderlerini üstlen. Aylık düzenli destek mumkündür.',
    kurum: 'Yetim Vakfı • İHH • YEDEV',
    ikon: '🧸',
    birim: 'sponsorluk',
    katilan: 8640,
    delil: '"Ben ve yetime bakan kimse cennette böyle yan yanayız." (İşaret parmağı ve ortasıyla gösterdi.)',
    kaynak: 'Buhârî, Talâk 25',
  ),
  YardimKampanyasi(
    id: 'kurban_bagisi',
    ad: 'Vekâletle Kurban',
    aciklama: 'Kurban bayramında vekâletinle kestirilen kurbanların etleri, ihtiyaç sahibi ailelere ulaştırılır.',
    kurum: 'Diyanet Vakfı • Kızılay • İHH',
    ikon: '🐑',
    birim: 'hisse',
    katilan: 15730,
    delil: '"Kurbanınızı güzelce kesin; o gün ihtiyaç sahibine ulaşan et, sadakadır."',
    kaynak: 'İbn Mâce, Edâhî 13',
  ),
  YardimKampanyasi(
    id: 'afet_acele',
    ad: 'Deprem & Afet Acil Yardım',
    aciklama: 'Afet bölgelerine acil gıda, barınma ve sağlık desteği. İlk 72 saat hayat kurtarır.',
    kurum: 'AFAD • Kızılay • AHBAP',
    ikon: '🆘',
    birim: 'yardım',
    katilan: 39210,
    delil: '"Müminler birbirlerine merhamette tek bir beden gibidir."',
    kaynak: 'Buhârî, Edeb 27',
  ),
  YardimKampanyasi(
    id: 'ilkokul_egitim',
    ad: 'Bir Öğrenci Okut',
    aciklama: 'Az gelişmiş bölgelerde bir öğrencinin yıllık eğitim, kırtasiye ve ulaşım masraflarını üstlen.',
    kurum: 'Yeryüzü Öğretmenleri • Ensar Vakfı',
    ikon: '🎒',
    birim: 'öğrenci',
    katilan: 6120,
    delil: '"İlmi öğrenmek her Müslümana farzdır."',
    kaynak: 'İbn Mâce, Mukaddime 17',
  ),
];

// ---------------- ZEKÂT & SADAKA ----------------

/// Zekâta tabi varlık kalemleri (hesaplama girişi).
const zekatKalemAdlari = [
  'Nakit & Banka Bakiyesi',
  'Altın / Gümüş',
  'Ticaret Malı',
  'Hisse Senetleri',
  'Alacaklar',
];

/// Nisap miktarı için örnek altın gram fiyatı (kullanıcı değiştirebilir).
const nisapAltinGram = 80;

// ---------------- SORU-CEVAP / FETVA ARŞİVİ ----------------

final fetvaKategorileri = [
  'Namaz & İbadet',
  'Oruç & Ramazan',
  'Zekât & Sadaka',
  'Temizlik & Tahâret',
  'Aile & Evlilik',
  'Günlük Hayat',
];

final fetvaArsivi = [
  FetvaKaydi(
    id: 'f1',
    kategori: 'Namaz & İbadet',
    soru: 'Vakit namazlarına başlamak için ezan okunması şart mıdır?',
    cevap: 'Ezan farz değildir; vaktin girmesi yeterlidir. Ezan, cemaate duyuru ve sünnettir. Tek başına namaz kılan kimse ezansız da namazını kılabilir; ancak ezanı işitip de okunmasını beklemek faziletlidir.',
  ),
  FetvaKaydi(
    id: 'f2',
    kategori: 'Namaz & İbadet',
    soru: 'Kılınan namazdan sonra tesbihat yapmak zorunlu mudur?',
    cevap: 'Tesbihat farz değil, müstehaptır. Hz. Peygamber (s.a.v.) namaz sonrası tesbih, tahmid ve tekbir getirmeyi tavsiye etmiştir. Unutulursa günah olmaz; ihmal etmemek güzeldir.',
    kaynak: 'Müslim, Mesâcid 145',
  ),
  FetvaKaydi(
    id: 'f3',
    kategori: 'Oruç & Ramazan',
    soru: 'Oruçluyken yanlışlıkla bir şey yenirse oruç bozulur mu?',
    cevap: 'Unutarak yemek-içmek orucu bozmaz. Ayette "Rabbinin ikramıdır" buyurulmuştur (Bakara, 2/187). Unutulduğu anda bırakıp oruca devam edilir; kaza gerekmez, günah yoktur.',
  ),
  FetvaKaydi(
    id: 'f4',
    kategori: 'Oruç & Ramazan',
    soru: 'Kazası olan kişi nâfile oruç tutabilir mi?',
    cevap: 'Evla olan önce kaza oruçlarını bitirmektir. Ancak kazası varken nâfile oruç tutmak da caizdir; atılmaması gerekir. Ramazana kalmadan kazaların tamamlanması tavsiye edilir.',
  ),
  FetvaKaydi(
    id: 'f5',
    kategori: 'Zekât & Sadaka',
    soru: 'Zekât nisabı ne kadardır?',
    cevap: 'Nisap, 80.18 gram altın veya bu değerde paraya sahip olmaktır. Bu miktar kişinin üzerinden bir kamerî yıl geçerse o varlığın %2,5\'u zekât olarak verilir. Borçlar ve asli ihtiyaçlar çıkarılır.',
    kaynak: 'Mevsılî, el-İhtiyâr 1/113',
  ),
  FetvaKaydi(
    id: 'f6',
    kategori: 'Zekât & Sadaka',
    soru: 'Zekât kardeşe veya babaya verilebilir mi?',
    cevap: 'Zekât, nafakası üzerine kendisine vacip olmayan kişilere verilir. Bakmakla yükümlü olunan kişilere (çoğunluğun görüşüne göre ana-baba ve çocuklara) zekât verilmez; ancak kardeşlere verilebilir.',
  ),
  FetvaKaydi(
    id: 'f7',
    kategori: 'Temizlik & Tahâret',
    soru: 'Abdest alırken az bir su kullanmak sünnet midir?',
    cevap: 'Evet. Hz. Peygamber (s.a.v.) abdestte ve gusülde az su kullanmayı öğütlemiş, israfı yasaklamıştır. Abdest için küçük bir avuç hacminde su ölçüleri rivayet edilmiştir.',
    kaynak: 'Buhârî, Vudû 47',
  ),
  FetvaKaydi(
    id: 'f8',
    kategori: 'Aile & Evlilik',
    soru: 'Nikâhta şahit şart mıdır?',
    cevap: 'Evet. Nikâhın geçerli olması için iki Müslüman erkek veya bir erkek ile iki kadın şahidin bulunması şarttır. Şahitsiz nikâh, cumhur ulemasına göre geçersizdir.',
    kaynak: 'Müslim, Nikâh 16',
  ),
  FetvaKaydi(
    id: 'f9',
    kategori: 'Günlük Hayat',
    soru: 'İş hayatında komisyon almak caiz midir?',
    cevap: 'Komisyon, yapılan bir hizmet veya aracılık karşılığında alınıyorsa caizdir; faizli işlemlere aracılık ve aldatma içermemelidir. Şartların şeffaf ve helal olması esastır.',
  ),
  FetvaKaydi(
    id: 'f10',
    kategori: 'Günlük Hayat',
    soru: 'Selamlaşmada "Esselâmü aleyküm" yerine kısaltma kullanmak uygun mudur?',
    cevap: 'Selam bir ibadet ve sünnettir; kısaltmalar selamın anlamını taşımaz. Tek başına "ms" veya "sa" demek selam yerine geçmez. Tam selam vermek sünnet, selamı yaymak ise emredilmiştir.',
    kaynak: 'Buhârî, İsti\'zân 9',
  ),
];

// ---------------- KÜRESEL ETKİNLİKLER & CANLI YAYINLAR ----------------

final ummetEtkinlikleri = [
  UmmetEtkinligi(
    id: 'mekke',
    ad: 'Mescid-i Haram Canlı Yayını',
    aciklama: 'Kâbe ve Mescid-i Haram çevresinin 7/24 kesintisiz canlı yayını.',
    tarih: '',
    ikon: '🕋',
    canli: true,
  ),
  UmmetEtkinligi(
    id: 'medine',
    ad: 'Mescid-i Nebevî Canlı Yayını',
    aciklama: 'Peygamber (s.a.v.) mescidinin canlı yayını; ezan ve namaz saatlerini takip edin.',
    tarih: '',
    ikon: '🕌',
    canli: true,
  ),
  UmmetEtkinligi(
    id: 'cuma_hutbesi',
    ad: 'Haftalık Cuma Hutbesi',
    aciklama: 'Diyanet tarafından her hafta yayımlanan cuma hutbesi; camilerde okunur ve takip edilebilir.',
    tarih: '',
    ikon: '📜',
    canli: false,
  ),
  UmmetEtkinligi(
    id: 'kadir',
    ad: 'Kadir Gecesi Özel Programı',
    aciklama: 'Kadir gecesinde camilerde düzenlenen özel programlar, mukabeleler ve dua geceleri.',
    tarih: '03-16',
    ikon: '🌙',
    canli: false,
  ),
  UmmetEtkinligi(
    id: 'regaib',
    ad: 'Regaib Kandili Programı',
    aciklama: 'Üç ayların başlangıcı olan Regaib gecesinde camilerde düzenlenen programlar.',
    tarih: '12-10',
    ikon: '🌙',
    canli: false,
  ),
  UmmetEtkinligi(
    id: 'mevlid',
    ad: 'Mevlid Kandili Programı',
    aciklama: 'Hz. Peygamber\'in (s.a.v.) dünyaya teşrifi vesilesiyle camilerde düzenlenen Mevlid-i Şerif programları.',
    tarih: '08-24',
    ikon: '🕌',
    canli: false,
  ),
  UmmetEtkinligi(
    id: 'ramazan',
    ad: 'Ramazan Teravih & Mukabele',
    aciklama: 'Ramazan ayı boyunca camilerde teravih namazı, mukabele ve iftar programları.',
    tarih: '',
    ikon: '🌙',
    canli: false,
  ),
  UmmetEtkinligi(
    id: 'kurs',
    ad: 'Kur\'an Kursları & Yaz Dönemi',
    aciklama: 'Diyanet\'e bağlı Kur\'an kurslarının kayıt dönemleri ve yaz kursları başvuruları.',
    tarih: '',
    ikon: '📖',
    canli: false,
  ),
];

// ---------------- MANEVİ GELİŞİM HALKALARI ----------------

final maneviHalkalar = [
  ManeviHalka(
    id: '1_sayfa',
    ad: 'Günde 1 Sayfa Kur\'an',
    aciklama: 'Her gün en az bir sayfa Kur\'an oku; bir yılda bir hatim edinme imkânı.',
    ikon: '📖',
    uyeTabani: 48200,
  ),
  ManeviHalka(
    id: '40_hadis',
    ad: '40 Hadis Ezberleme Grubu',
    aciklama: 'Haftada bir hadis ezberle, 40 hadisi tamamla; anlamlarıyla birlikte öğren.',
    ikon: '🗂️',
    uyeTabani: 12700,
  ),
  ManeviHalka(
    id: 'sabah_aksam',
    ad: 'Sabah-Akşam Zikirleri',
    aciklama: 'Peygamber (s.a.v.) efendimizin sabah-akşam okuduğu derlenmiş zikirleri günde iki kez uygula.',
    ikon: '📿',
    uyeTabani: 31600,
  ),
  ManeviHalka(
    id: 'tesbihat',
    ad: 'Namaz Sonrası Tesbihat',
    aciklama: 'Her farz namazdan sonra tesbihâtı bırakma; 33\'er tesbih itiyadını kazan.',
    ikon: '🤲',
    uyeTabani: 52900,
  ),
  ManeviHalka(
    id: 'duha',
    ad: 'Kuşluk (Duha) Namazı',
    aciklama: 'Her gün kuşluk namazı kılanlarla birlikte ol; sevabı sadaka hanesine yazılır.',
    ikon: '☀️',
    uyeTabani: 8900,
  ),
  ManeviHalka(
    id: 'isim_ogren',
    ad: 'Esma-i Hüsna Öğrenme',
    aciklama: 'Günde iki isim öğren; 99 ismi anlamı ve zikriyle birlikte tamamla.',
    ikon: '💠',
    uyeTabani: 15400,
  ),
  ManeviHalka(
    id: 'kisa_sure',
    ad: 'Kısa Sureleri Ezberle',
    aciklama: 'Namazda okunan kısa sureleri (Amme cüzü) anlamıyla ezberleme grubu.',
    ikon: '📕',
    uyeTabani: 23800,
  ),
  ManeviHalka(
    id: 'sadaka_gunluk',
    ad: 'Her Güne Bir Sadaka',
    aciklama: 'Her gün küçük de olsa bir sadaka ver; iktisatlı sadaka alışkanlığı kazan.',
    ikon: '💚',
    uyeTabani: 19800,
  ),
];

// ---------------- GÜNÜN MESAJLARI (NİYET & HADİS) ----------------

final gununMesajlari = [
  {
    'tip': 'Hadis',
    'metin': 'Müslüman, elinden ve dilinden Müslümanların selamet bulduğu kimsedir.',
    'kaynak': 'Buhârî, Îmân 4',
  },
  {
    'tip': 'Söz',
    'metin': 'Kim ahireti amaçlarsa Allah ona kalbine rahmet, işine bereket, dünyasını da kendisine yeterli kılar.',
    'kaynak': 'Hadis meali, İbn Mâce, Zühd 5',
  },
  {
    'tip': 'Ayet',
    'metin': 'Şüphesiz Allah, adaletli olanları sever.',
    'kaynak': 'Mâide, 5/42',
  },
  {
    'tip': 'Hadis',
    'metin': 'Sadaka malı eksiltmez. Allah, affeden kulun ancak izzetini artırır.',
    'kaynak': 'Müslim, Birr 69',
  },
  {
    'tip': 'Hadis',
    'metin': 'Sizin en hayırlınız, Kur\'an\'ı öğrenen ve öğreteninizdir.',
    'kaynak': 'Buhârî, Fezâilü\'l-Kur\'ân 21',
  },
  {
    'tip': 'Ayet',
    'metin': 'Kim bir canı kurtarırsa bütün insanları kurtarmış gibi olur.',
    'kaynak': 'Mâide, 5/32',
  },
];

// ---------------- ÜMMET BİLİNCİ: NÜFUS & TOPLULUKLAR ----------------

final dunyaMuslumanNufusu = [
  {'ulke': 'Endonezya', 'nufus': '237 milyon', 'oran': '86%', 'bayrak': '🇮🇩'},
  {'ulke': 'Pakistan', 'nufus': '231 milyon', 'oran': '96%', 'bayrak': '🇵🇰'},
  {'ulke': 'Hindistan', 'nufus': '211 milyon', 'oran': '15%', 'bayrak': '🇮🇳'},
  {'ulke': 'Bangladeş', 'nufus': '153 milyon', 'oran': '91%', 'bayrak': '🇧🇩'},
  {'ulke': 'Nijerya', 'nufus': '104 milyon', 'oran': '50%', 'bayrak': '🇳🇬'},
  {'ulke': 'Mısır', 'nufus': '93 milyon', 'oran': '91%', 'bayrak': '🇪🇬'},
  {'ulke': 'Türkiye', 'nufus': '84 milyon', 'oran': '99%', 'bayrak': '🇹🇷'},
  {'ulke': 'İran', 'nufus': '83 milyon', 'oran': '99%', 'bayrak': '🇮🇷'},
  {'ulke': 'Şu anda dünyada 1.9 milyardan fazla Müslüman yaşamaktadır.', 'nufus': '', 'oran': '', 'bayrak': '🌍'},
];

final kardesTopluluklar = [
  {
    'bayrak': '🇹🇷',
    'ad': 'Anadolu',
    'detay': 'Bayramlaşma, mevlit okutma, kırk mevlit ve taziyelerle zengin bir gelenek. Selatin camilerde cemaat, mahalle kültürünün merkezi.',
  },
  {
    'bayrak': '🇮🇩',
    'ad': 'Endonezya',
    'detay': 'Dünyanın en kalabalık Müslüman ülkesi. Ramazan ve bayramlarda mudik (memlekete dönüş) geleneği, evlere iaşe hediye etme adeti yaygındır.',
  },
  {
    'bayrak': '🇲🇦',
    'ad': 'Fas',
    'detay': 'Taravihlerde hatm-i şerif, Ramazan\'da harira çorbası geleneği. Endülüs\'ten taşınan mimari ve ilim mirasına sahiptir.',
  },
  {
    'bayrak': '🇮🇷',
    'ad': 'İran',
    'detay': 'Muharrem ayında matem merasimleri, Nevruz esintili bahar kutlamaları ve büyük mukabele geleneği.',
  },
  {
    'bayrak': '🇳🇬',
    'ad': 'Nijerya',
    'detay': 'Kuzeyde Şeri hukuku ve tarikat gelenekleri, batıda ise... halk arasında bayram namazları açık meydanlarda kılınır.',
  },
  {
    'bayrak': '🇧🇦',
    'ad': 'Bosna-Hersek',
    'detay': 'Avrupa\'nın kalbinde İslam kimliği. Cuma vakti ezan okununca iş yerleri durur; Ramazan\'da sokaklarda sahur iftarları kurulur.',
  },
];

// ---------------- KALICI DEPO (shared_preferences) ----------------

class UmmetStore {
  static const _duaDuvarKey = 'ummet_dua_duvari';
  static const _hatimCuzKey = 'ummet_hatim_cuzlerim';
  static const _hatimTamamKey = 'ummet_hatim_tamamlanan';
  static const _gorevToplamKey = 'ummet_gorev_tamam_toplam';
  static const _gorevGunKey = 'ummet_gorev_gunu_';

  static Future<SharedPreferences> get _p => SharedPreferences.getInstance();

  // ---------- DUA DUVARI ----------

  static Future<List<DuaIstek>> duaIstekleriYukle() async {
    final prefs = await _p;
    final raw = prefs.getString(_duaDuvarKey);
    if (raw == null) {
      return List.of(seedDuaIstekleri);
    }
    try {
      final liste = (jsonDecode(raw) as List<dynamic>)
          .map((e) => DuaIstek.fromJson(e as Map<String, dynamic>))
          .toList();
      return liste.isEmpty ? List.of(seedDuaIstekleri) : liste;
    } catch (_) {
      return List.of(seedDuaIstekleri);
    }
  }

  static Future<void> _duaIstekleriKaydet(List<DuaIstek> liste) async {
    final prefs = await _p;
    await prefs.setString(
      _duaDuvarKey,
      jsonEncode(liste.map((e) => e.toJson()).toList()),
    );
  }

  static Future<void> duaIstekEkle(DuaIstek istek) async {
    final liste = await duaIstekleriYukle();
    liste.insert(0, istek);
    await _duaIstekleriKaydet(liste);
  }

  static Future<void> duaEt(String id) async {
    final liste = await duaIstekleriYukle();
    for (final i in liste) {
      if (i.id == id) {
        i.duaSayisi += 1;
      }
    }
    await _duaIstekleriKaydet(liste);
  }

  static Future<int> bugunYapilanDua() async {
    final liste = await duaIstekleriYukle();
    final toplam = liste.fold<int>(0, (a, i) => a + i.duaSayisi);
    return 48200 + toplam;
  }

  // ---------- DUA ZİNCİRLERİ ----------

  static Future<int> zincirPayi(String id) async {
    final prefs = await _p;
    return prefs.getInt('ummet_zincir_$id') ?? 0;
  }

  static Future<void> zincirKatil(String id, int adet) async {
    final prefs = await _p;
    final yeni = (prefs.getInt('ummet_zincir_$id') ?? 0) + adet;
    await prefs.setInt('ummet_zincir_$id', yeni);
  }

  // ---------- ZİKİR KAMPANYALARI ----------

  static Future<int> zikirPayi(String id) async {
    final prefs = await _p;
    return prefs.getInt('ummet_zikir_$id') ?? 0;
  }

  static Future<void> zikirKatil(String id, int adet) async {
    final prefs = await _p;
    final yeni = (prefs.getInt('ummet_zikir_$id') ?? 0) + adet;
    await prefs.setInt('ummet_zikir_$id', yeni);
  }

  // ---------- DUA ODALARI ----------

  static Future<int> odaKatilim(String id) async {
    final prefs = await _p;
    return prefs.getInt('ummet_oda_$id') ?? 0;
  }

  static Future<void> odaKatil(String id) async {
    final prefs = await _p;
    final yeni = (prefs.getInt('ummet_oda_$id') ?? 0) + 1;
    await prefs.setInt('ummet_oda_$id', yeni);
  }

  // ---------- HATİM HALKALARI ----------

  static Future<Set<int>> hatimCuzlerim() async {
    final prefs = await _p;
    final raw = prefs.getStringList(_hatimCuzKey) ?? [];
    return raw.map(int.parse).toSet();
  }

  static Future<bool> hatimCuzTikla(int cuzNo) async {
    final prefs = await _p;
    final set = await hatimCuzlerim();
    final eklendi = set.add(cuzNo);
    if (!eklendi) {
      set.remove(cuzNo);
    }
    await prefs.setStringList(_hatimCuzKey, set.map((e) => e.toString()).toList());
    if (eklendi) {
      await prefs.setInt(
        _hatimTamamKey,
        (prefs.getInt(_hatimTamamKey) ?? hatimTabaniTamamlanan) + 1,
      );
    }
    return eklendi;
  }

  static Future<int> hatimTamamlanan() async {
    final prefs = await _p;
    return prefs.getInt(_hatimTamamKey) ?? hatimTabaniTamamlanan;
  }

  // ---------- GÜNLÜK İYİLİK GÖREVLERİ ----------

  static String _gorevGunAnahtari(DateTime d) =>
      '$_gorevGunKey${d.year}${d.month.toString().padLeft(2, '0')}${d.day.toString().padLeft(2, '0')}';

  static Future<Set<String>> gorevlerBugun() async {
    final prefs = await _p;
    return (prefs.getStringList(_gorevGunAnahtari(DateTime.now())) ?? [])
        .toSet();
  }

  static Future<void> gorevTikla(String id, bool tamam) async {
    final prefs = await _p;
    final anahtar = _gorevGunAnahtari(DateTime.now());
    final set = (prefs.getStringList(anahtar) ?? []).toSet();
    if (tamam) {
      set.add(id);
      await prefs.setInt(_gorevToplamKey, (prefs.getInt(_gorevToplamKey) ?? 0) + 1);
    } else {
      set.remove(id);
    }
    await prefs.setStringList(anahtar, set.toList());
  }

  static Future<int> gorevToplamTamamlanan() async {
    final prefs = await _p;
    return prefs.getInt(_gorevToplamKey) ?? 0;
  }

  // ---------- KÜRESEL YARDIM KAMPANYALARI ----------

  static Future<int> kampanyaPayi(String id) async {
    final prefs = await _p;
    return prefs.getInt('ummet_kampanya_$id') ?? 0;
  }

  /// Kampanyaya destek eklendikçe sayacı artırır.
  static Future<void> kampanyaDestekle(String id) async {
    final prefs = await _p;
    final yeni = (prefs.getInt('ummet_kampanya_$id') ?? 0) + 1;
    await prefs.setInt('ummet_kampanya_$id', yeni);
  }

  // ---------- MANEVİ HALKALAR ----------

  static Future<bool> halkadaMis(String id) async {
    final prefs = await _p;
    return prefs.getBool('ummet_halka_$id') ?? false;
  }

  static Future<void> halkayaKatil(String id) async {
    final prefs = await _p;
    await prefs.setBool('ummet_halka_$id', true);
  }

  static Future<void> halkadanAyril(String id) async {
    final prefs = await _p;
    await prefs.setBool('ummet_halka_$id', false);
  }

  // ---------- GÜNÜN MESAJI ----------

  /// Günün sayısına göre mesajı seçer; her gün farklı mesaj döner.
  static int gununMesajIndexi([DateTime? tarih]) {
    final d = tarih ?? DateTime.now();
    return d.year + d.month * 31 + d.day;
  }
}
