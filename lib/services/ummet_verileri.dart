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
    this.kullanicidan = false,
  });

  final String id;
  final String ad;
  final String detay;
  final String duaMetni;
  final int hedef;
  final int taban;

  /// Kullanıcı tarafından oluşturulan zincirlerde true; sabit içerikte false.
  final bool kullanicidan;

  factory DuaZinciri.fromJson(Map<String, dynamic> j) => DuaZinciri(
        id: j['id'] as String,
        ad: j['ad'] as String,
        detay: j['detay'] as String,
        duaMetni: j['duaMetni'] as String,
        hedef: (j['hedef'] as num).toInt(),
        taban: (j['taban'] as num).toInt(),
        kullanicidan: (j['kullanicidan'] as bool?) ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ad': ad,
        'detay': detay,
        'duaMetni': duaMetni,
        'hedef': hedef,
        'taban': taban,
        'kullanicidan': kullanicidan,
      };
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
    this.detay,
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
  final String? detay;
}

/// Zekât hesabı giriş kalemi.
class ZekatKalemi {
  ZekatKalemi(
    this.ad, {
    this.tutar = 0,
    this.oran = 0.025,
    this.aciklama = '',
    this.dusulur = false,
  });

  final String ad;
  double tutar;

  /// Bu kalem için zekât oranı (%2,5 = 0.025, tarım ürünü %10 vb.).
  final double oran;

  /// Kaleme ilişkin kısa açıklama (kutuda görünür).
  final String aciklama;

  /// Borçlar gibi matrahtan çıkarılan kalemler için true.
  final bool dusulur;

  ZekatKalemi kopya() => ZekatKalemi(
        ad,
        tutar: tutar,
        oran: oran,
        aciklama: aciklama,
        dusulur: dusulur,
      );
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
    'etiketler':
        'Ağrılar,Kronik Hastalıklar,Ameliyat,Ruhsal Sıkıntı,Genel Afiyet',
  },
  {
    'id': 'borc',
    'ad': 'Borç / Rızık',
    'ikon': '💼',
    'aciklama': 'Borçtan kurtuluş ve helal rızık',
    'etiketler':
        'Borçtan Kurtulma,Rızık Genişliği,İş Bulma,Ticarette Bereket,Umulmadık Rızık',
  },
  {
    'id': 'sinav',
    'ad': 'Sınav / Başarı',
    'ikon': '📚',
    'aciklama': 'Sınavlar ve önemli işler için başarı',
    'etiketler':
        'Sınav Heyecanı,Hafıza Güçlendirme,Zorluk Kolaylaştırma,Mülakat/İş Görüşmesi,Çalışma Azmi',
  },
  {
    'id': 'aile',
    'ad': 'Aile Huzuru',
    'ikon': '🏡',
    'aciklama': 'Aile içi huzur, evlilik ve çocuklar',
    'etiketler':
        'Eşler Arası Sevgi,Kayınvalide İlişkisi,Hayırlı Evlat,Kötü Alışkanlıklardan Korunma,Hayırlı Kısmet',
  },
  {
    'id': 'hidayet',
    'ad': 'Hidayet',
    'ikon': '🕊️',
    'aciklama': 'Doğru yol için hidayet dilekleri',
    'etiketler':
        'Tövbe,Kalp Katılığı,İstikamet,Nefis Terbiyesi,Vesveseden Kurtulma',
  },
];

final kategoriDualari = <String, List<Map<String, String>>>{
  'sifa': [
    {
      'baslik': 'Şifa Duası (Hz. Peygamber\'den)',
      'arapca':
          'اللَّهُمَّ رَبَّ النَّاسِ أَذْهِبِ الْبَأْسَ، اشْفِ أَنْتَ الشَّافِي، لَا شِفَاءَ إِلَّا شِفَاؤُكَ، شِفَاءً لَا يُغَادِرُ سَقَمًا',
      'okunus':
          "Allâhümme Rabbe'n-nâs, ezhibil-be's, eşfi ente'ş-şâfî, lâ şifâe illâ şifâüke, şifâen lâ yuğâdiru sekamen.",
      'turkce':
          'Allah\'ım! Ey insanların Rabbi! Sıkıntıyı gider, şifa ver. Şifa veren yalnız Sensin. Senin şifandan başka şifa yoktur. Öyle bir şifa ver ki hiçbir hastalık bırakmasın.',
      'kaynak': 'Buhârî, Merdâ 20; Müslim, Selâm 46',
      'etiket': 'Genel Afiyet',
      'amin': '14250',
      'fazilet':
          'Peygamberimiz (s.a.v.) hastayı ziyaret ettiğinde bu duayı yedi defa okurdu.',
    },
    {
      'baslik': 'Hz. Eyyub Duası',
      'arapca':
          'أَنِّي مَسَّنِيَ الضُّرُّ وَأَنْتَ أَرْحَمُ الرَّاحِمِينَ',
      'okunus': "Ennî messeniyed-durru ve ente erhamü'r-râhimîn.",
      'turkce':
          'Bana gerçekten bir zarar dokundu; Sen ise merhametlilerin en merhametlisisin.',
      'kaynak': 'Enbiyâ Suresi, 83. Ayet',
      'etiket': 'Genel Afiyet',
      'amin': '13080',
      'fazilet':
          'Uzun süren hastalık ve sabır imtihanlarında Hz. Eyyub\'un (a.s.) bu duası, teslimiyetin en güzel örneğidir.',
    },
    {
      'baslik': 'Hastaya Nefes (Ruqyah) Duası',
      'arapca':
          'بِسْمِ اللهِ أَعُوذُ بِعِزَّةِ اللهِ وَقُدْرَتِهِ مِنْ شَرِّ مَا أَجِدُ وَأُحَاذِرُ',
      'okunus':
          "Bismillâh, eûzü bi-izzetillâhi ve kudretihî min şerri mâ ecidü ve uhâzir.",
      'turkce':
          'Allah\'ın adıyla. Hissettiğim ve sakındığım şerrin tamamından Allah\'ın izzetine ve kudretine sığınırım.',
      'kaynak': 'Müslim, Selâm 56',
      'etiket': 'Ağrılar',
      'amin': '9840',
      'fazilet':
          'Peygamberimiz (s.a.v.) elini hastanın üzerine koyup üç kez Bismillâh, yedi kez de bu sığınmayı okurdu.',
    },
    {
      'baslik': 'Ağrılı Yer İçin Şifa Duası',
      'arapca':
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي',
      'okunus':
          "Allâhümme innî es'elüke'l-âfiyete fid-dünyâ vel-âhirah. Allâhümme innî es'elüke'l-afve vel-âfiyete fî dînî ve dünyâye ve ehlî ve mâlî.",
      'turkce':
          'Allah\'ım! Dünya ve ahirette senden afiyet isterim. Allah\'ım! Dinim, dünyam, ailem ve malım hususunda senden af ve afiyet dilerim.',
      'kaynak': 'Ebû Dâvûd, Edeb 101',
      'etiket': 'Kronik Hastalıklar',
      'amin': '11240',
      'fazilet':
          'Sabah ve akşam üç defa okunduğunda her türlü hastalık ve beladan korunma vesilesidir.',
    },
    {
      'baslik': 'Ruhsal Sıkıntı ve Vesvese Duası',
      'arapca':
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
      'okunus':
          "Allâhümme innî eûzü bike minel-hemmi vel-hazen, vel-aczi vel-kesel, vel-buhli vel-cübn, ve dala'id-deyni ve galebetir-ricâl.",
      'turkce':
          'Allah\'ım! Üzüntü ve tasadan, acizlik ve tembellikten, cimrilik ve korkaklıktan, borç altında ezilmekten ve insanların baskısından sana sığınırım.',
      'kaynak': 'Buhârî, Deavât 43',
      'etiket': 'Ruhsal Sıkıntı',
      'amin': '15620',
      'fazilet':
          'Kaygı, vesvese ve sıkıntıya düştüğünde okunması tavsiye edilen kapsamlı bir sığınmadır.',
    },
    {
      'baslik': 'Ameliyat Öncesi Teslimiyet Duası',
      'arapca':
          'حَسْبُنَا اللهُ وَنِعْمَ الْوَكِيلُ',
      'okunus': 'Hasbünallâhü ve ni\'mel-vekîl.',
      'turkce':
          'Allah bize yeter, O ne güzel vekildir.',
      'kaynak': 'Âl-i İmrân Suresi, 173. Ayet',
      'etiket': 'Ameliyat',
      'amin': '8730',
      'fazilet':
          'Önemli karar ve girişimlerden önce gönül rahatlığı için okunur.',
    },
    {
      'baslik': 'Cebrail\'in (a.s.) Şifa Duası',
      'arapca':
          'بِسْمِ اللهِ أَرْقِيكَ، مِنْ كُلِّ شَيْءٍ يُؤْذِيكَ، مِنْ شَرِّ كُلِّ نَفْسٍ أَوْ عَيْنٍ حَاسِدٍ، اللهُ يَشْفِيكَ',
      'okunus':
          "Bismillâhi erkîke, min külli şey'in yü'zîke, min şerri külli nefsin ev aynin hâsidin, Allâhu yeşfîke.",
      'turkce':
          'Allah\'ın adıyla sana okurum. Sana eziyet veren her şeyden, haset eden her nefis ve gözün şerrinden şifa dilerim; Allah seni iyileştirsin.',
      'kaynak': 'Müslim, Selâm 44',
      'etiket': 'Ağrılar',
      'amin': '10240',
      'fazilet':
          'Cebrail (a.s.) tarafından Rasûlullah\'a (s.a.v.) okunan, hastalara karşı yapılan meşhur ruqyah duasıdır.',
    },
    {
      'baslik': 'Genel Afiyet ve Sıhhat Duası',
      'arapca':
          'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ',
      'okunus':
          "Allâhümme âfinî fî bedenî, Allâhümme âfinî fî sem'î, Allâhümme âfinî fî basarî, lâ ilâhe illâ ente.",
      'turkce':
          'Allah\'ım! Bedenime afiyet ver. Allah\'ım! Kulağıma afiyet ver. Allah\'ım! Gözüme afiyet ver. Senden başka ilah yoktur.',
      'kaynak': 'Ebû Dâvûd, Edeb 101',
      'etiket': 'Genel Afiyet',
      'amin': '13360',
      'fazilet':
          'Peygamberimiz (s.a.v.) her sabah akşam üç defa okuduğu kapsamlı afiyet duasıdır.',
    },
    {
      'baslik': 'Kronik Hastalıkta Sabır Duası',
      'arapca':
          'اللَّهُمَّ اجْعَلْ مَا بِي مِنَ الْبَلَاءِ طَهُورًا وَكَفَّارَةً لِذُنُوبِي',
      'okunus':
          "Allâhümmec'al mâ bî minel-belâi tahûren ve keffâraten li-zünûbî.",
      'turkce':
          'Allah\'ım! İçinde bulunduğum bu hastalığı ve belayı günahlarıma keffaret ve benim için bir temizlik vesilesi eyle.',
      'kaynak': 'Sabır edebi duası',
      'etiket': 'Kronik Hastalıklar',
      'amin': '9120',
      'fazilet':
          'Uzun süreli hastalıklarda sabrı artırmak ve hastalığın sevaba dönüşmesi için okunur.',
    },
    {
      'baslik': 'Şifa Halkaları İçin Dua',
      'arapca':
          'اللَّهُمَّ اشْفِ مَرْضَى الْمُسْلِمِينَ',
      'okunus': "Allâhümişfi merdâ'l-müslimîn.",
      'turkce':
          'Allah\'ım! Müslüman hastalarına şifa ver.',
      'kaynak': 'Şifa halkası duası',
      'etiket': 'Genel Afiyet',
      'amin': '8450',
      'fazilet':
          'Bir hasta adına ya da tüm ümmetin hastaları için edilen kısa ve güçlü duadır.',
    },
  ],
  'borc': [
    {
      'baslik': 'Borçtan Kurtuluş Duası',
      'arapca':
          'اللَّهُمَّ اكْفِنِي بِحَلَالِكَ عَنْ حَرَامِكَ، وَأَغْنِنِي بِفَضْلِكَ عَمَّنْ سِوَاكَ',
      'okunus':
          "Allâhümmekfinî bi-halâlike an harâmik, ve ağninî bi-fadlike ammen sivâk.",
      'turkce':
          'Allah\'ım! Bana haramdan kaçınmayı helal rızıkla nasip et; beni Senden başkasına muhtaç etmeyecek şekilde lutfunla zengin kıl.',
      'kaynak': 'Tirmizî, Deavât 109',
      'etiket': 'Borçtan Kurtulma',
      'amin': '15230',
      'fazilet':
          'Hz. Ali\'ye (r.a.) borçtan kurtulması için öğretilen dua; sabah akşam okunması tavsiye edilir.',
    },
    {
      'baslik': 'Rızık Duası (Hz. Musa)',
      'arapca':
          'رَبِّ إِنِّي لِمَا أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ',
      'okunus': "Rabbi innî limâ enzelte ileyye min hayrin fakîr.",
      'turkce':
          'Rabbim! Bana indireceğin her hayra muhtacım.',
      'kaynak': 'Kasas Suresi, 24. Ayet',
      'etiket': 'Rızık Genişliği',
      'amin': '12410',
      'fazilet':
          'Hz. Musa\'nın (a.s.) Medyen\'de yaptığı bu dua, ihtiyaç anında rızkın kapısını açar.',
    },
    {
      'baslik': 'Umulmadık Yerden Rızık (Rızık Ayeti)',
      'arapca':
          'وَمَنْ يَتَّقِ اللهَ يَجْعَلْ لَهُ مَخْرَجًا ۝ وَيَرْزُقْهُ مِنْ حَيْثُ لَا يَحْتَسِبُ',
      'okunus':
          "Ve men yetteki'llâhe yec'al lehû mahracâ. Ve yerzukhu min haysü lâ yahtesib.",
      'turkce':
          'Kim Allah\'tan sakınırsa, Allah ona bir çıkış yolu açar ve onu ummadığı yerden rızıklandırır.',
      'kaynak': 'Talâk Suresi, 2-3. Ayetler',
      'etiket': 'Umulmadık Rızık',
      'amin': '18750',
      'fazilet':
          'İstiğfar ve takva ile birlikte okunduğunda umulmadık kapılardan rızık vesilesi olduğu nakledilir.',
    },
    {
      'baslik': 'Ticarette Bereket Duası',
      'arapca':
          'اللَّهُمَّ بَارِكْ لَنَا فِي رِزْقِنَا، وَاجْعَلْنَا مِنَ الشَّاكِرِينَ',
      'okunus':
          "Allâhümme bârik lenâ fî rızkınâ vec-alnâ mine'ş-şâkirîn.",
      'turkce':
          'Allah\'ım! Rızkımızda bize bereket ver ve bizi şükredenlerden eyle.',
      'kaynak': 'Yerleşik edeb duası (âdâb-ı rızk)',
      'etiket': 'Ticarette Bereket',
      'amin': '9860',
      'fazilet':
          'Sabah ticaretine başlarken okunduğunda bereket ve helal kazanç duasıdır.',
    },
    {
      'baslik': 'İş ve Kariyer Kolaylığı Duası',
      'arapca':
          'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي',
      'okunus': "Rabbişrah lî sadrî ve yessir lî emrî.",
      'turkce':
          'Rabbim! Gönlüme ferahlık ver ve işimi kolaylaştır.',
      'kaynak': 'Tâhâ Suresi, 25-26. Ayetler',
      'etiket': 'İş Bulma',
      'amin': '11050',
      'fazilet':
          'Yeni bir işe, görüşmeye veya girişime başlarken okunur.',
    },
    {
      'baslik': 'Borç Öderken Okunacak Dua',
      'arapca':
          'اللَّهُمَّ اكْفِنِي كُلَّ بَارِّ الْبَخِيلِ، وَمَلِّكْنِي جَمِيعَ الْجُزُرِ، وَانْصُرْنِي عَلَى الظَّالِمِينَ، وَاكْفِنِي هَمَّ الدَّيْنِ',
      'okunus':
          "Allâhümkfinî külle bârril-bahîl, ve melliknî cemîal-cüzer, vensurnî alez-zâlimîn, vekfinî hemmed-deyn.",
      'turkce':
          'Allah\'ım! Her cimriyi bana yeterli kıl, bana bütün hayırları ihsan et, zalimlere karşı bana yardım et ve beni borç derdinden koru.',
      'kaynak': 'Tergib ve Terhib (deyn duası)',
      'etiket': 'Borçtan Kurtulma',
      'amin': '9870',
      'fazilet':
          'Borç altındayken sabah akşam okunması tavsiye edilen, borcun ödenmesi için güçlü bir vesile sayılır.',
    },
    {
      'baslik': 'Rızık Kapısını Açma Duası',
      'arapca':
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ وَرَحْمَتِكَ، فَإِنَّهُ لَا يَمْلِكُهَا إِلَّا أَنْتَ',
      'okunus':
          "Allâhümme innî es'elüke min fadlike ve rahmetik, fe-innehû lâ yemlikühâ illâ ente.",
      'turkce':
          'Allah\'ım! Senden lutfunu ve rahmetini dilerim; çünkü onları senden başka kimse veremez.',
      'kaynak': 'Ebû Dâvûd, Salât 186',
      'etiket': 'Rızık Genişliği',
      'amin': '11840',
      'fazilet':
          'Bolluk ve bereket istendiğinde edilen, duası kabul edilen sahâbîlerden aktarılan bir duadır.',
    },
    {
      'baslik': 'Umulmadık Kapılar İçin Dua',
      'arapca':
          'وَمَنْ يَتَوَكَّلْ عَلَى اللهِ فَهُوَ حَسْبُهُ',
      'okunus': "Ve men yetevekkel alallâhi fe-hüve hasbüh.",
      'turkce':
          'Kim Allah\'a tevekkül ederse, O ona yeter.',
      'kaynak': 'Talâk Suresi, 3. Ayet',
      'etiket': 'Umulmadık Rızık',
      'amin': '13210',
      'fazilet':
          'Rızkın umulmadık yerden gelmesi için tevekkülle birlikte okunan ayettir.',
    },
  ],
  'sinav': [
    {
      'baslik': 'Başarı Duası (Hz. Musa)',
      'arapca':
          'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِنْ لِسَانِي',
      'okunus':
          "Rabbişrah lî sadrî ve yessir lî emrî, vahlül ukdeten min lisânî.",
      'turkce':
          'Rabbim! Gönlüme ferahlık ver, işimi kolaylaştır ve dilimdeki düğümü çöz ki sözümü iyi anlasınlar.',
      'kaynak': 'Tâhâ Suresi, 25-28. Ayetler',
      'etiket': 'Sınav Heyecanı',
      'amin': '19320',
      'fazilet':
          'Sınav öncesi ve sınav esnasında okunduğunda heyecanı dindirir, zihni açar.',
    },
    {
      'baslik': 'İlim Duası',
      'arapca':
          'اللَّهُمَّ انْفَعْنِي بِمَا عَلَّمْتَنِي وَعَلِّمْنِي مَا يَنْفَعُنِي وَزِدْنِي عِلْمًا',
      'okunus':
          "Allâhümmenfa'nî bimâ allemtenî, ve allimnî mâ yenfaunî, ve zidnî ilmâ.",
      'turkce':
          'Allah\'ım! Bana öğrettiklerinle faydalandır, bana faydalı ilmi öğret ve ilmimi artır.',
      'kaynak': 'Tirmizî, Deavât 128',
      'etiket': 'Hafıza Güçlendirme',
      'amin': '17280',
      'fazilet':
          'Ders çalışmaya başlamadan önce okunduğunda ilmin hayra dönüşmesi için vesile olur.',
    },
    {
      'baslik': 'Zihin Açıklığı Esmaları',
      'arapca':
          'يَا حَسِيبُ يَا عَلِيمُ يَا مُفَتِّحُ الْعَلِيمُ، افْتَحْ عَلَيْنَا أَبْوَابَ فَهْمِكَ',
      'okunus':
          "Yâ Hasîb, Yâ Alîm, Yâ Müfettihu'l-alîm, iftah aleynâ ebvâbe fehmik.",
      'turkce':
          'Ey hesaba çeken, ey her şeyi bilen, ey ilim kapılarını açan! Bize anlayış kapılarını aç.',
      'kaynak': 'Esmâ-i Hüsnâ duâsı',
      'etiket': 'Zihni Açıklık',
      'amin': '14110',
      'fazilet':
          'Unutkanlık ve zihin bulanıklığı için Yâ Hasîb, Yâ Alîm esmalarıyla yapılan yakarıştır.',
    },
    {
      'baslik': 'Zorlukları Kolaylaştırma Duası',
      'arapca':
          'اللَّهُمَّ لَا سَهْلَ إِلَّا مَا جَعَلْتَهُ سَهْلًا، وَأَنْتَ تَجْعَلُ الْحَزْنَ إِذَا شِئْتَ سَهْلًا',
      'okunus':
          "Allâhümme lâ sehle illâ mâ cealtehû sehlâ, ve ente tec'alü'l-hazne izâ şi'te sehlâ.",
      'turkce':
          'Allah\'ım! Senin kolaylaştırdığından başka kolay yoktur. Sen dilediğinde zor olanı kolaylaştırırsın.',
      'kaynak': 'İbn Hibbân, Sahih',
      'etiket': 'Zorluk Kolaylaştırma',
      'amin': '13540',
      'fazilet':
          'Sınav kâğıdını açarken ve mülakata girerken okunması tavsiye edilir.',
    },
    {
      'baslik': 'Çalışma Azmi Duası',
      'arapca':
          'اللَّهُمَّ وَفِّقْنِي لِمَا تُحِبُّ وَتَرْضَى، وَاجْعَلْ اجْتِهَادِي فِي مَرْضَاتِكَ',
      'okunus':
          "Allâhümme vaffıknî limâ tuhibbü ve terdâ, vec'al ictihâdî fî merzâtik.",
      'turkce':
          'Allah\'ım! Beni sevdiğin ve razı olduğun şeye muvaffak kıl; çalışmamı rızana uygun eyle.',
      'kaynak': 'İslamî edeb duası',
      'etiket': 'Çalışma Azmi',
      'amin': '10270',
      'fazilet':
          'Ders programına başlarken azim ve sebat için okunur.',
    },
    {
      'baslik': 'Sınav Sabahı Duası',
      'arapca':
          'اللَّهُمَّ أَصْلِحْ لِي شَأْنِي كُلَّهُ، وَلَا تَكِلْنِي إِلَى نَفْسِي طَرْفَةَ عَيْنٍ',
      'okunus':
          "Allâhümme aslih lî şe'nî küllehû, ve lâ tekilnî ilâ nefsî tarfete ayn.",
      'turkce':
          'Allah\'ım! Bütün işimi düzene koy; beni bir göz kırpışı kadar bile olsa kendi nefsime bırakma.',
      'kaynak': 'Sahih deyn ve iş duası',
      'etiket': 'Sınav Heyecanı',
      'amin': '12130',
      'fazilet':
          'Önemli bir güne başlarken okunduğunda güven ve sükûnet verir.',
    },
    {
      'baslik': 'Hafıza ve Anlayış Duası',
      'arapca':
          'اللَّهُمَّ ارْزُقْنِي فَهْمَ النَّبِيِّينَ وَحِفْظَ الْمُرْسَلِينَ وَإِلْهَامَ الْمَلَائِكَةِ الْمُقَرَّبِينَ',
      'okunus':
          "Allâhümmerzuknî fehmel-ümmiyyîn, ve hıfzal-mürselîn, ve ilhâmel-melâiketil-mukarrabîn.",
      'turkce':
          'Allah\'ım! Bana peygamberlerin anlayışını, elçilerin ezberini ve meleklerin ilhamını nasip eyle.',
      'kaynak': 'İlim talebesi duası',
      'etiket': 'Hafıza Güçlendirme',
      'amin': '14670',
      'fazilet':
          'Ders çalışmaya başlarken ve sınavdan önce okunan, hafıza ve kavrama gücü duasıdır.',
    },
    {
      'baslik': 'Mülakat İçin Kolaylık Duası',
      'arapca':
          'رَبِّ زِدْنِي عِلْمًا وَارْزُقْنِي فَهْمًا',
      'okunus': "Rabbi zidnî ilmâ, verzuknî fehmâ.",
      'turkce':
          'Rabbim! İlmimi artır ve bana anlayış ver.',
      'kaynak': 'Tâhâ Suresi, 114. Ayet (meâlen)',
      'etiket': 'Mülakat/İş Görüşmesi',
      'amin': '10940',
      'fazilet':
          'İş görüşmesi ve mülakat öncesi okunduğunda zihin berraklığı sağlar.',
    },
  ],
  'aile': [
    {
      'baslik': 'Aile Huzuru Duası',
      'arapca':
          'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
      'okunus':
          "Rabbenâ heb lenâ min ezvâcinâ ve zürriyyâtinâ kurrate a'yünin vec'alnâ lil-müttekîne imâmâ.",
      'turkce':
          'Rabbimiz! Bize eşlerimizden ve çocuklarımızdan göz aydınlığı ver ve bizi takva sahiplerine önder kıl.',
      'kaynak': 'Furkân Suresi, 74. Ayet',
      'etiket': 'Eşler Arası Sevgi',
      'amin': '16420',
      'fazilet':
          'Ev halkı huzur bulsun diye sabah ve akşam okunması tavsiye edilir.',
    },
    {
      'baslik': 'Evlilik Hayır Duası',
      'arapca':
          'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
      'okunus':
          "Rabbenâ âtinâ fid-dünyâ haseneten ve fil-âhirati haseneten ve kınâ azâben-nâr.",
      'turkce':
          'Rabbimiz! Bize dünyada iyilik ver, ahirette de iyilik ver ve bizi ateş azabından koru.',
      'kaynak': 'Bakara Suresi, 201. Ayet',
      'etiket': 'Hayırlı Kısmet',
      'amin': '12890',
      'fazilet':
          'Evlilik öncesi hayırlı kısmet ve yuva kurmak isteyenlerin çokça okuduğu dualardandır.',
    },
    {
      'baslik': 'Nazar ve Huzursuzluktan Korunma',
      'arapca':
          'أَعُوذُ بِكَلِمَاتِ اللهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
      'okunus':
          "Eûzü bi-kelimâti'llâhi't-tâmmâti min şerri mâ halaka.",
      'turkce':
          'Yarattıklarının şerrinden Allah\'ın eksiksiz kelimelerine sığınırım.',
      'kaynak': 'Müslim, Zikir 57',
      'etiket': 'Kötü Alışkanlıklardan Korunma',
      'amin': '14560',
      'fazilet':
          'Akşam olduğunda üç defa okunması, nazar ve evdeki huzursuzluktan korunma vesilesidir.',
    },
    {
      'baslik': 'Hayırlı Evlat İçin Dua',
      'arapca':
          'رَبِّ هَبْ لِي مِنَ الصَّالِحِينَ',
      'okunus': "Rabbi heb lî mine's-sâlihîn.",
      'turkce':
          'Rabbim! Bana salihlerden bir evlat lütfeyle.',
      'kaynak': 'Sâffât Suresi, 100. Ayet',
      'etiket': 'Hayırlı Evlat',
      'amin': '11730',
      'fazilet':
          'Hz. İbrahim\'in (a.s.) duası; çocuk sahibi olmak isteyenlerin ve evladının salahı için okunur.',
    },
    {
      'baslik': 'Aile İlişkileri İçin Birleştirme Duası',
      'arapca':
          'اللَّهُمَّ أَلِّفْ بَيْنَ قُلُوبِنَا، وَأَصْلِحْ ذَاتَ بَيْنِنَا، وَاهْدِنَا سُبُلَ السَّلَامِ',
      'okunus':
          "Allâhümme ellif beyne kulûbinâ, ve aslih zâte beyninâ, vehdinâ sübüle's-selâm.",
      'turkce':
          'Allah\'ım! Kalplerimizi birleştir, aramızdaki anlaşmazlıkları düzelt ve bizi esenlik yollarına ilet.',
      'kaynak': 'Ebû Dâvûd, Edeb 74',
      'etiket': 'Kayınvalide İlişkisi',
      'amin': '10980',
      'fazilet':
          'Aile içi küslük ve geçimsizlik yaşandığında birlik ve muhabbet için okunur.',
    },
    {
      'baslik': 'Eşler Arası Sevgi Duası',
      'arapca':
          'اللَّهُمَّ اجْعَلْ بَيْنَنَا مَوَدَّةً وَرَحْمَةً وَأَلْقِ بَيْنَنَا مَحَبَّةً، وَاجْعَلْنَا هَادِينَ مُهْتَدِينَ',
      'okunus':
          "Allâhümc'al beynenâ meveddeten ve rahmeten, ve elkı beynenâ mehabbeten, vec'alnâ hâdîne mühtedîn.",
      'turkce':
          'Allah\'ım! Aramızda sevgi ve merhamet kıl, kalplerimize birbirine karşı muhabbet at, bizi hidayete erenlerden eyle.',
      'kaynak': 'Aile muhabbeti duası',
      'etiket': 'Eşler Arası Sevgi',
      'amin': '12470',
      'fazilet':
          'Eşler arasındaki soğukluğu gidermek ve muhabbeti artırmak için okunur.',
    },
    {
      'baslik': 'Hayırlı Kısmet İçin Dua',
      'arapca':
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ الزَّوْجَ الصَّالِحَ وَالْبَيْتِ السَّالِمِ',
      'okunus':
          "Allâhümme innî es'elüke'z-zevces-sâliha vel-beytis-sâlim.",
      'turkce':
          'Allah\'ım! Senden salih bir eş ve sıhhatli bir yuva isterim.',
      'kaynak': 'Kısmet duası',
      'etiket': 'Hayırlı Kısmet',
      'amin': '13190',
      'fazilet':
          'Evlilik düşünenlerin hayırlı kısmet için okudukları samimi bir yakarıştır.',
    },
    {
      'baslik': 'Evlatların Gönlü için Dua',
      'arapca':
          'رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِنْ ذُرِّيَّتِي رَبَّنَا وَتَقَبَّلْ دُعَاءِ',
      'okunus':
          "Rabbic'alnî mukîmes-salâti ve min zürriyyetî Rabbenâ ve tekabbel duâî.",
      'turkce':
          'Rabbim! Beni namaza devam eden bir kul eyle; neslimden de namaz kılanlar kıl. Rabbimiz, duamı kabul buyur.',
      'kaynak': 'İbrâhîm Suresi, 40. Ayet',
      'etiket': 'Hayırlı Evlat',
      'amin': '14630',
      'fazilet':
          'Hz. İbrahim\'in (a.s.) duası; evlatların ibadet ehli ve salih olması için okunur.',
    },
  ],
  'hidayet': [
    {
      'baslik': 'Hidayet Duası (Fâtiha)',
      'arapca':
          'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
      'okunus': "İhdina's-sırâtal-müstekîm.",
      'turkce': 'Bizi dosdoğru yola ilet.',
      'kaynak': 'Fâtiha Suresi, 6. Ayet',
      'etiket': 'İstikamet',
      'amin': '18260',
      'fazilet':
          'Her namazda tekrarlanan bu ayet, istikamet üzere olmanın özüdür.',
    },
    {
      'baslik': 'Sevgi ve Hidayet Duası',
      'arapca':
          'اللَّهُمَّ أَلِّفْ بَيْنَ قُلُوبِنَا، وَأَصْلِحْ ذَاتَ بَيْنِنَا، وَاهْدِنَا سُبُلَ السَّلَامِ',
      'okunus':
          "Allâhümme ellif beyne kulûbinâ, ve aslih zâte beyninâ, vehdinâ sübüle's-selâm.",
      'turkce':
          'Allah\'ım! Kalplerimizi birleştir, aramızı düzelt ve bizi esenlik yollarına ilet.',
      'kaynak': 'Ebû Dâvûd, Edeb 74',
      'etiket': 'Kalp Katılığı',
      'amin': '13820',
      'fazilet':
          'Kalplerin birbirine ısınması ve aradaki soğukluğun giderilmesi için okunur.',
    },
    {
      'baslik': 'Kalbi Sabit Kılma Duası',
      'arapca':
          'يَا مُقَلِّبَ الْقُلُوبِ ثَبِّتْ قَلْبِي عَلَى دِينِكَ',
      'okunus':
          "Yâ mukallibel-kulûb, sebbit kalbî alâ dînik.",
      'turkce':
          'Ey kalpleri evirip çeviren Allah\'ım! Kalbimi dinin üzerine sabit kıl.',
      'kaynak': 'Tirmizî, Deavât 98',
      'etiket': 'İstikamet',
      'amin': '17540',
      'fazilet':
          'Peygamberimiz (s.a.v.) bu duayı çokça yapardı; imanda sebat için okunur.',
    },
    {
      'baslik': 'Seyyidü\'l-İstiğfar (Tövbenin En Üstünü)',
      'arapca':
          'اللَّهُمَّ أَنْتَ رَبِّي لَا إِلَهَ إِلَّا أَنْتَ، خَلَقْتَنِي وَأَنَا عَبْدُكَ، وَأَنَا عَلَى عَهْدِكَ وَوَعْدِكَ مَا اسْتَطَعْتُ، أَعُوذُ بِكَ مِنْ شَرِّ مَا صَنَعْتُ، أَبُوءُ لَكَ بِنِعْمَتِكَ عَلَيَّ، وَأَبُوءُ بِذَنْبِي فَاغْفِرْ لِي فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      'okunus':
          "Allâhümme ente Rabbî lâ ilâhe illâ ente, halaktenî ve ene abduk, ve ene alâ ahdike ve va'dike mesteta'tü, eûzü bike min şerri mâ sana'tü, ebûü leke bi-ni'metike aleyye, ve ebûü bi-zenbî, fağfir lî fe-innehû lâ yağfiruz-zünûbe illâ ente.",
      'turkce':
          'Allah\'ım! Sen benim Rabbimsin, senden başka ilah yoktur. Beni sen yarattın, ben senin kulunum. Gücüm yettiğince sana verdiğim söz ve ahde vefalıyım. Yaptıklarımın şerrinden sana sığınırım. Üzerimdeki nimetini ikrar eder, günahımı itiraf ederim. Beni bağışla; zira günahları ancak Sen bağışlarsın.',
      'kaynak': 'Buhârî, Deavât 2',
      'etiket': 'Tövbe',
      'amin': '20310',
      'fazilet':
          'Peygamberimiz (s.a.v.) bunu tövbenin en üstünü olarak nitelendirmiş; güne onunla başlayanın akşama kadar cennet ehlinden yazılacağını müjdelemiştir.',
    },
    {
      'baslik': 'Nefsin Şerrinden Sığınma',
      'arapca':
          'اللَّهُمَّ آتِ نَفْسِي تَقْوَاهَا، وَزَكِّهَا أَنْتَ خَيْرُ مَنْ زَكَّاهَا، أَنْتَ وَلِيُّهَا وَمَوْلَاهَا',
      'okunus':
          "Allâhümme âti nefsî takvâhâ, ve zekkihâ ente hayru men zekkâhâ, ente veliyyühâ ve mevlâhâ.",
      'turkce':
          'Allah\'ım! Nefsime takvasını ver, onu arındır; onu en iyi arındıran Sensin. Onun velisi ve sahibi de Sensin.',
      'kaynak': 'Müslim, Zikir 72',
      'etiket': 'Nefis Terbiyesi',
      'amin': '12460',
      'fazilet':
          'Nefis terbiyesi ve kötü arzulardan arınmak isteyenlerin günlük duasıdır.',
    },
    {
      'baslik': 'Vesveseden Kurtulma Duası',
      'arapca':
          'آمَنْتُ بِاللهِ وَرُسُلِهِ',
      'okunus': "Âmentü billâhi ve rusulihî.",
      'turkce': 'Allah\'a ve elçilerine iman ettim.',
      'kaynak': 'Müslim, Salât 107',
      'etiket': 'Vesveseden Kurtulma',
      'amin': '9130',
      'fazilet':
          'Şeytanın vesvesesi geldiğinde söylenmesi tavsiye edilen dua; vesvese anında okunur.',
    },
    {
      'baslik': 'Tövbe Kapısı Duası',
      'arapca':
          'اللَّهُمَّ تَوَبْ عَلَيَّ وَارْحَمْنِي وَاهْدِنِي',
      'okunus': "Allâhümme tüb aleyye verhamnî vehdinî.",
      'turkce':
          'Allah\'ım! Tövbemi kabul et, bana merhamet et ve bana hidayet ver.',
      'kaynak': 'Buhârî, Deavât 88',
      'etiket': 'Tövbe',
      'amin': '11870',
      'fazilet':
          'Peygamberimiz (s.a.v.) günde yetmişten fazla istiğfar eder; kısa ve öz tövbe yakarışıdır.',
    },
    {
      'baslik': 'Kalbin Yumuşaması için Dua',
      'arapca':
          'اللَّهُمَّ ارْزُقْنِي لِينَةَ الْقَلْبِ وَحَلَاوَةَ الْإِيمَانِ',
      'okunus':
          "Allâhümmerzuknî lînetel-kalb ve halâvetel-îmân.",
      'turkce':
          'Allah\'ım! Bana kalp yumuşaklığı ve imanın tadını nasip eyle.',
      'kaynak': 'Kalp yumuşaklığı duası',
      'etiket': 'Kalp Katılığı',
      'amin': '10420',
      'fazilet':
          'Kalp katılaşması yaşandığında, kalbin yumuşaması ve iman tatlılığı için okunur.',
    },
    {
      'baslik': 'Nefis ve Vesveseden Sığınma',
      'arapca':
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ شَرِّ نَفْسِي وَشَرِّ الشَّيْطَانِ وَشِرْكِهِ',
      'okunus':
          "Allâhümme innî eûzü bike min şerri nefsî ve şerri'ş-şeytâni ve şirkihî.",
      'turkce':
          'Allah\'ım! Nefsimin şerrinden, şeytanın şerrinden ve onun şirkinden sana sığınırım.',
      'kaynak': 'Ebû Dâvûd, Edeb 101',
      'etiket': 'Vesveseden Kurtulma',
      'amin': '9920',
      'fazilet':
          'Namazdan çıkışta ve gün içinde okunan, nefis ve vesveseye karşı koruma duasıdır.',
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
  DuaZinciri(
    id: 'salavat_peygamber',
    ad: 'Hz. Peygamber\'e (s.a.v.) Salavat',
    detay: 'Küresel hedef: 100.000 salavat',
    duaMetni:
        'Allah\'ım! Efendimiz Muhammed\'e (s.a.v.) salat ü selam eyle. Salavat, sevgimizin en güzel ifadesidir.',
    hedef: 100000,
    taban: 35120,
  ),
  DuaZinciri(
    id: 'anne_baba',
    ad: 'Ana-Babamız için İstiğfar',
    detay: 'Küresel hedef: 200.000 istiğfar',
    duaMetni:
        'Rabbimiz! Bizi ve anne-babamızı bağışla. Onların hayatları boyunca yaptığı dualar bizim nasibimizdir.',
    hedef: 200000,
    taban: 84230,
  ),
  DuaZinciri(
    id: 'sifa_ummet',
    ad: 'Hastalar için Şifa Okulu (Zemzem)',
    detay: 'Küresel hedef: 300.000 dua',
    duaMetni:
        'Allah\'ım! Hastalarımıza şifa ver. Her hastalık için vesile ol, dertlere deva eyle.',
    hedef: 300000,
    taban: 45120,
  ),
  DuaZinciri(
    id: 'ilim_talebesi',
    ad: 'İlim Talebeleri için Dua',
    detay: 'Küresel hedef: 150.000 dua',
    duaMetni:
        'Rabbim! İlim öğrenen kardeşlerimize anlayış, zihin açıklığı ve azim ver. İlmini hayra vesile eyle.',
    hedef: 150000,
    taban: 22450,
  ),
  DuaZinciri(
    id: 'yetim',
    ad: 'Yetimler için Dua Halkası',
    detay: 'Küresel hedef: 250.000 dua',
    duaMetni:
        'Rabbimiz! Yetimlerin kalbini sevginle doldur. Onlara koruyan, kollayan, sevgi veren gönüller nasip eyle.',
    hedef: 250000,
    taban: 38970,
  ),
  DuaZinciri(
    id: 'kalp_yumusama',
    ad: 'Kalpleri Yumuşayanlar için',
    detay: 'Küresel hedef: 100.000 istiğfar',
    duaMetni:
        'Allah\'ım! Taşlaşmış kalplerimizi yumuşat, kalplerimize huzur ve huşu ver.',
    hedef: 100000,
    taban: 19840,
  ),
  DuaZinciri(
    id: 'evlilik',
    ad: 'Hayırlı Eş ve Yuva için',
    detay: 'Küresel hedef: 120.000 dua',
    duaMetni:
        'Rabbimiz! Evlenip yuva kuran kardeşlerimize hayırlı, huzurlu ve bereketli bir evlilik nasip eyle.',
    hedef: 120000,
    taban: 15210,
  ),
  DuaZinciri(
    id: 'cocuk',
    ad: 'Salih Evlat için Dua',
    detay: 'Küresel hedef: 180.000 dua',
    duaMetni:
        'Rabbim! Bize salihlerden evlatlar nasip et. Evlatlarımızı sana hayırlı kul, ümmete faydalı insan eyle.',
    hedef: 180000,
    taban: 24760,
  ),
  DuaZinciri(
    id: 'vatan_millet',
    ad: 'Vatan ve Millet için Dua',
    detay: 'Küresel hedef: 400.000 dua',
    duaMetni:
        'Allah\'ım! Vatanımızı ve milletimizi her türlü felaketten koru. Birlik ve beraberliğimizi daim eyle.',
    hedef: 400000,
    taban: 66130,
  ),
  DuaZinciri(
    id: 'ramazan',
    ad: 'Ramazan Ayı için Dua',
    detay: 'Küresel hedef: 200.000 dua',
    duaMetni:
        'Rabbimiz! Bizi Ramazan\'a ulaştır, günahlarımızı bağışla ve Kadir Gecesi\'nin faziletine erdir.',
    hedef: 200000,
    taban: 31280,
  ),
  DuaZinciri(
    id: 'kuraklik',
    ad: 'Yağmur ve Bereket için Dua',
    detay: 'Küresel hedef: 150.000 dua',
    duaMetni:
        'Rabbim! Üzerimize rahmet yağmurlarını indir, topraklarımıza bereket ver, bizi kuraklıkla imtihan etme.',
    hedef: 150000,
    taban: 18730,
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
    detay: 'Kuraklık ve susuzluk yaşayan bölgelerde açılan bir su kuyusu, '
        'yüzlerce ailenin temiz su ihtiyacını karşılar. Sadaka-i câriye '
        'niyetiyle verilen su kuyusu bağışları, uzun yıllar boyunca sevap '
        'kazandırmaya devam eder.\n\nNasıl bağış yapılır: Tercih ettiğiniz '
        'kurumun bağış sayfasından "Su Kuyusu" veya "Su Vakfı" kampanyasını '
        'seçip miktarı belirleyebilirsiniz.',
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
    detay: 'Bir gıda kolisi; un, bakliyat, yağ ve şeker gibi temel ürünlerle '
        'bir ailenin en az bir ay geçimine katkı sağlar. Ramazan ayında ve '
        'yıl boyunca ihtiyaç sahibi ailelere ulaştırılır.\n\nNasıl bağış '
        'yapılır: Kurumun bağış sayfasından "Gıda Kolisi" ya da "Aileye '
        'Destek Paketi" kampanyasını seçerek destek olabilirsiniz.',
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
    detay: 'Yetim sponsorluğu; bir çocuğun eğitim, barınma, sağlık ve temel '
        'ihtiyaçlarının aylık düzenli destekle karşılanmasıdır. Düzenli '
        'destekle bir çocuğun geleceğine ortak olabilirsiniz.\n\nNasıl bağış '
        'yapılır: Kurumun "Yetim Sponsorluğu" sayfasından şehir veya ülke '
        'seçerek aylık sponsor başvurusu yapabilirsiniz.',
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
    detay: 'Vekâletle kurban; kurban ibadetini yerine getirirken, kurban '
        'etlerinin ihtiyaç sahibi ailelere ulaştırılmasını sağlar. Hisseli '
        'veya tam kurban olarak seçilebilir.\n\nNasıl bağış yapılır: Kurban '
        'bayramında tercih ettiğiniz vakfın "Vekâletle Kurban Bağışı" '
        'sayfasından hissenizi alın. Yurt içi veya yurt dışı seçimi yapabilirsiniz.',
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
    detay: 'Afet sonrası ilk 72 saat hayat kurtarır. Acil gıda, barınma, '
        'ısınma ve sağlık desteği; afetten etkilenen insanların en temel '
        'ihtiyaçlarını karşılar.\n\nNasıl bağış yapılır: AFAD, Kızılay veya '
        'gönüllü ağların afet bölgesine yönelik acil yardım kampanyalarından '
        'birini seçerek destek olabilirsiniz.',
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
    detay: 'Bir öğrencinin yıllık eğitim, kitap, kırtasiye ve ulaşım '
        'masraflarını üstlenerek onun okula devam etmesini sağlayabilirsiniz. '
        'Burs desteği, ilim yolundaki bir çocuğun geleceğini değiştirir.\n\n'
        'Nasıl bağış yapılır: "Bir Öğrenci Okut" veya "Burs Desteği" '
        'kampanyasından bir öğrenci seçerek yıllık destek başvurusu '
        'yapabilirsiniz.',
  ),
];

// ---------------- ZEKÂT & SADAKA ----------------

/// Zekâta tabi varlık kalemleri (hesaplama girişi).
/// Zekât hesaplayıcıda sunulan varlık kalemleri. Oranlar bilgilendirme
/// amaçlıdır; fitre/varlıklar kullanıcı tercihine göre değerlendirilir.
final zekatKalemleri = <ZekatKalemi>[
  ZekatKalemi(
    'Nakit & Banka Bakiyesi',
    oran: 0.025,
    aciklama: 'Kasa ve bankadaki para, üzerinden bir yıl geçtiyse %2,5.',
  ),
  ZekatKalemi(
    'Altın / Gümüş',
    oran: 0.025,
    aciklama:
        'Biriktirme amaçlı altın ve gümüş değeri nisaba ulaşırsa %2,5. '
        'Zinet eşyası için mezhepler arasında farklı görüşler vardır.',
  ),
  ZekatKalemi(
    'Ticaret Malı',
    oran: 0.025,
    aciklama:
        'Satılmak üzere eldeki malın değeri (alış veya satış fiyatına göre) '
        '%2,5 ile zekâta tabidir.',
  ),
  ZekatKalemi(
    'Hisse Senetleri',
    oran: 0.025,
    aciklama:
        'Uzun vadeli yatırım hisselerinde kâr payı zekâtı; borsada kısa '
        'vadeli ticaret hisseleri ticaret malı gibi değerlendirilir.',
  ),
  ZekatKalemi(
    'Alacaklar',
    oran: 0.025,
    aciklama:
        'Güçlü ve tahsil edilebilir alacaklar zekâta tabidir; riskli '
        'alacaklar tahsil edilince zekâtı verilir.',
  ),
  ZekatKalemi(
    'Tarım Ürünü',
    oran: 0.10,
    aciklama:
        'Mahsulün zekâtı: yağmur/sulama masrafsız ise %10 (öşür), '
        'sulama masraflı ise %5.',
  ),
  ZekatKalemi(
    'Borçlarım',
    oran: 0.0,
    aciklama:
        'Vadesi gelmiş borçlarınız varsa zekât matrahından düşülebilir. '
        'Pozitif girin, toplamdan çıkarılır.',
    dusulur: true,
  ),
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

  static const _zincirUserKey = 'ummet_zincirlerim';

  /// Kullanıcının eklediği dua zincirlerinin tamamı (sabit seed'ler hariç).
  static Future<List<DuaZinciri>> kullaniciZincirleri() async {
    final prefs = await _p;
    final raw = prefs.getString(_zincirUserKey);
    if (raw == null) return [];
    try {
      final liste = (jsonDecode(raw) as List<dynamic>)
          .map((e) => DuaZinciri.fromJson(e as Map<String, dynamic>))
          .toList();
      return liste;
    } catch (_) {
      return [];
    }
  }

  /// Sayfada görünen tüm zincirler: sabit içerik + kullanıcı zincirleri.
  static Future<List<DuaZinciri>> tumZincirler() async {
    final kullanici = await kullaniciZincirleri();
    return [...duaZincirleriSeed, ...kullanici];
  }

  static Future<DuaZinciri> zincirEkle({
    required String ad,
    required String detay,
    required String duaMetni,
    required int hedef,
    String? baslangicId,
  }) async {
    final prefs = await _p;
    final liste = await kullaniciZincirleri();
    final id = baslangicId ?? 'kullanici_${DateTime.now().millisecondsSinceEpoch}';
    final zincir = DuaZinciri(
      id: id,
      ad: ad,
      detay: detay,
      duaMetni: duaMetni,
      hedef: hedef,
      taban: 0,
      kullanicidan: true,
    );
    liste.insert(0, zincir);
    await prefs.setString(
      _zincirUserKey,
      jsonEncode(liste.map((e) => e.toJson()).toList()),
    );
    return zincir;
  }

  static Future<void> zincirSil(String id) async {
    final prefs = await _p;
    final liste = await kullaniciZincirleri();
    liste.removeWhere((z) => z.id == id);
    await prefs.setString(
      _zincirUserKey,
      jsonEncode(liste.map((e) => e.toJson()).toList()),
    );
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

  /// Oda genelinde her iki duanın Âmin sayacı. Anahtar "odaId|duaBaşlık".
  static Future<int> duaAminSayisi(String odaId, String duaBaslik) async {
    final prefs = await _p;
    return prefs.getInt('ummet_oda_amin_${odaId}_$duaBaslik') ?? 0;
  }

  static Future<int> duaAminVer(String odaId, String duaBaslik) async {
    final prefs = await _p;
    final anahtar = 'ummet_oda_amin_${odaId}_$duaBaslik';
    final yeni = (prefs.getInt(anahtar) ?? 0) + 1;
    await prefs.setInt(anahtar, yeni);
    return yeni;
  }

  /// Kullanıcının favori/takipte tuttuğu dua anahtarları: "odaId|duaBaşlık".
  static const _duaFavoriKey = 'ummet_oda_favorilerim';

  static Future<Set<String>> duaFavorilerim() async {
    final prefs = await _p;
    return (prefs.getStringList(_duaFavoriKey) ?? []).toSet();
  }

  static Future<bool> duaFavoriDegistir(String anahtar) async {
    final prefs = await _p;
    final set = await duaFavorilerim();
    final eklendi = !set.contains(anahtar);
    if (eklendi) {
      set.add(anahtar);
    } else {
      set.remove(anahtar);
    }
    await prefs.setStringList(_duaFavoriKey, set.toList());
    return eklendi;
  }

  static Future<bool> duaFavoriMi(String anahtar) async {
    final set = await duaFavorilerim();
    return set.contains(anahtar);
  }

  /// Favorilerdeki anahtarların (odaId|duaBaşlık) çözümlenmiş dua kayıtları.
  static Future<List<Map<String, String>>> duaFavoriDualari() async {
    final set = await duaFavorilerim();
    final kullaniciDualari = await kullaniciOdaDualari();
    final sonuc = <Map<String, String>>[];
    for (final k in set) {
      final ayrik = k.split('|');
      if (ayrik.length != 2) continue;
      final odaId = ayrik[0];
      final baslik = ayrik[1];
      final dualar = kategoriDualari[odaId];
      Map<String, dynamic>? eslesen;
      if (dualar != null) {
        final sabit = dualar.where((d) => d['baslik'] == baslik).toList();
        if (sabit.isNotEmpty) eslesen = sabit.first;
      }
      if (eslesen == null) {
        final kullanici =
            kullaniciDualari.where((d) => d['baslik'] == baslik).toList();
        if (kullanici.isNotEmpty) eslesen = kullanici.first;
      }
      if (eslesen == null) continue;
      final dua = Map<String, String>.from(
        eslesen.map((key, value) => MapEntry(key.toString(), value.toString())),
      );
      dua['odaId'] = odaId;
      dua['odaAd'] = duaKategorileri
          .firstWhere((k) => k['id'] == odaId, orElse: () => const {})['ad'] ??
          '';
      dua['odaIkon'] = duaKategorileri
          .firstWhere((k) => k['id'] == odaId, orElse: () => const {})['ikon'] ??
          '';
      sonuc.add(dua);
    }
    return sonuc;
  }

  /// Bulut tabanlı arama simülasyonu: tüm odalarda başlık, etiket, Türkçe
  /// ve okunuş üzerinden filtre yapar. İlk açılışta tam liste sunulur;
  /// arama yapılmadığında [onSayfa] kadar kayıt sayfalanır (lazy loading).
  static List<Map<String, dynamic>> duaAra(
    String sorgu, {
    int? onSayfa,
    String? odaId,
    String? etiket,
  }) {
    final s = sorgu.trim().toLowerCase();
    final sonuc = <Map<String, dynamic>>[];
    for (final k in duaKategorileri) {
      if (odaId != null && k['id'] != odaId) continue;
      final dualar = kategoriDualari[k['id']] ?? [];
      for (final d in dualar) {
        if (etiket != null && (d['etiket'] ?? '') != etiket) continue;
        if (s.isNotEmpty) {
          final metin = [
            d['baslik'],
            d['etiket'],
            d['turkce'],
            d['okunus'],
          ].join(' ').toLowerCase();
          if (!metin.contains(s)) continue;
        }
        sonuc.add({
          'odaId': k['id'],
          'odaAd': k['ad'],
          'odaIkon': k['ikon'],
          ...d,
        });
      }
    }
    if (onSayfa != null && s.isEmpty && etiket == null && odaId == null) {
      return sonuc.take(onSayfa).toList();
    }
    return sonuc;
  }

  /// Kullanıcının eklediği dualar için kalıcı depo anahtarı.
  static const _odaDuaUserKey = 'ummet_oda_dualarim';

  /// Kullanıcının eklediği tüm dualar. [odaId] verilirse yalnızca o odaya
  /// ait dualar döndürülür.
  static Future<List<Map<String, String>>> kullaniciOdaDualari([String? odaId]) async {
    final prefs = await _p;
    final raw = prefs.getString(_odaDuaUserKey);
    if (raw == null) return [];
    try {
      final liste = (jsonDecode(raw) as List<dynamic>)
          .map((e) => Map<String, String>.from(e as Map))
          .toList();
      if (odaId != null) {
        return liste.where((d) => d['odaId'] == odaId).toList();
      }
      return liste;
    } catch (_) {
      return [];
    }
  }

  static Future<void> _odaDualariKaydet(List<Map<String, String>> liste) async {
    final prefs = await _p;
    await prefs.setString(_odaDuaUserKey, jsonEncode(liste));
  }

  /// Kullanıcının odaya yeni dua eklemesi. Eklenen dua başa sıralanır.
  static Future<Map<String, String>> odaDuaEkle({
    required String odaId,
    required String baslik,
    required String arapca,
    required String secimi, // okunus ya da turkce (kaynak girilmeyebilir)
    String? kaynak,
  }) async {
    final liste = await kullaniciOdaDualari();
    final dua = <String, String>{
      'id': 'kullanici_${DateTime.now().millisecondsSinceEpoch}',
      'odaId': odaId,
      'baslik': baslik,
      'arapca': arapca,
      'okunus': secimi,
      'turkce': secimi,
      'kaynak': kaynak ?? 'Kullanıcı duası',
      'etiket': 'Genel',
      'amin': '0',
      'kullanicidan': 'true',
    };
    liste.insert(0, dua);
    await _odaDualariKaydet(liste);
    return dua;
  }

  static Future<void> odaDuaSil(String duaId) async {
    final liste = await kullaniciOdaDualari();
    liste.removeWhere((d) => d['id'] == duaId);
    await _odaDualariKaydet(liste);
  }

  /// Duvardaki/odaya ait tüm duaları döndürür: sabit + kullanıcı eklemeleri.
  static Future<List<Map<String, dynamic>>> odaDualariHepsi(String odaId) async {
    final kategori = duaKategorileri
        .firstWhere((k) => k['id'] == odaId, orElse: () => const {});
    final sabit = kategoriDualari[odaId] ?? [];
    final kullanici = await kullaniciOdaDualari(odaId);
    return [
      ...sabit.map((d) => <String, dynamic>{
            'odaId': odaId,
            'odaAd': kategori['ad'],
            'odaIkon': kategori['ikon'],
            ...d,
          }),
      ...kullanici.map((d) => <String, dynamic>{
            'odaId': odaId,
            'odaAd': kategori['ad'],
            'odaIkon': kategori['ikon'],
            ...d,
          }),
    ];
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
