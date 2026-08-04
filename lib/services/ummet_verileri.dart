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
}
