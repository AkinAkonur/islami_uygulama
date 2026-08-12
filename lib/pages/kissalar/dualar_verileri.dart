// ===========================================================================
// PEYGAMBER DUALARI KATALOĞU
// Kur'an'da geçen peygamber duaları: Arapça metin, okunuş, meal, kime ait
// olduğu ve hangi durumda okunabileceği. Çevrimdışı çalışır.
// Kaynak esasları: Diyanet Kur'an Yolu Tefsiri, İbn Kesir Tefsiri.
// ===========================================================================

class PeygamberDuasi {
  final String id;
  final String peygamber; // Örn: Hz. Yûnus
  final String baslik; // Örn: Balığın Karnındaki Dua
  final String arapca;
  final String okunus;
  final String meal;
  final String durum; // Hangi durumda okunur
  final String kaynak; // Sure/ayet bilgisi

  const PeygamberDuasi({
    required this.id,
    required this.peygamber,
    required this.baslik,
    required this.arapca,
    required this.okunus,
    required this.meal,
    required this.durum,
    required this.kaynak,
  });

  String get aramaMetni => [
        peygamber,
        baslik,
        okunus,
        meal,
        durum,
        kaynak,
      ].join(' ').toLowerCase();
}

const List<PeygamberDuasi> peygamberDualari = [
  PeygamberDuasi(
    id: 'dua-adem',
    peygamber: 'Hz. Âdem (a.s.)',
    baslik: 'İlk Tevbe Duası',
    arapca:
        'رَبَّنَا ظَلَمْنَا أَنفُسَنَا وَإِن لَّمْ تَغْفِرْ لَنَا وَتَرْحَمْنَا لَنَكُونَنَّ مِنَ الْخَاسِرِينَ',
    okunus:
        'Rabbenâ zalemnâ enfüsenâ ve in lem tağfir lenâ ve terhamnâ le nekûnenne mine\'l-hâsirîn.',
    meal:
        'Rabbimiz! Biz kendimize zulmettik. Eğer bizi bağışlamaz ve bize merhamet etmezsen, mutlaka hüsrana uğrayanlardan oluruz.',
    durum: 'Bir hatadan sonra tevbe ederken okunur.',
    kaynak: 'A\'râf Suresi, 23. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-nuh-inis',
    peygamber: 'Hz. Nûh (a.s.)',
    baslik: 'Mübarek İniş Duası',
    arapca:
        'رَبِّ أَنزِلْنِي مُنزَلًا مُّبَارَكًا وَأَنتَ خَيْرُ الْمُنزِلِينَ',
    okunus: 'Rabbi enzilnî münzelen mübâreken ve ente hayru\'l-münzilîn.',
    meal:
        'Rabbim! Beni mübarek bir yere indir. Sen indirenlerin en hayırlısısın.',
    durum: 'Bir yolculuğun veya imtihanın sonunda emniyete ulaşmak için okunur.',
    kaynak: 'Mü\'minûn Suresi, 29. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-nuh-magfiret',
    peygamber: 'Hz. Nûh (a.s.)',
    baslik: 'Aile ve Müminler İçin Bağışlanma',
    arapca:
        'رَبِّ اغْفِرْ لِي وَلِوَالِدَيَّ وَلِمَن دَخَلَ بَيْتِيَ مُؤْمِنًا وَلِلْمُؤْمِنِينَ وَالْمُؤْمِنَاتِ',
    okunus:
        'Rabbığfir lî ve li-vâlideyye ve li-men dehale beytiye mü\'minen ve lil-mü\'minîne vel-mü\'minât.',
    meal:
        'Rabbim! Beni, anne-babamı, evime mümin olarak girenleri ve bütün mümin erkek ve kadınları bağışla.',
    durum: 'Aile fertleri ve tüm müminler için mağfiret dilerken okunur.',
    kaynak: 'Nûh Suresi, 28. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-ibrahim-namaz',
    peygamber: 'Hz. İbrâhîm (a.s.)',
    baslik: 'Namazda Devamlılık Duası',
    arapca:
        'رَبِّ اجْعَلْنِي مُقِيمَ الصَّلَاةِ وَمِن ذُرِّيَّتِي ۚ رَبَّنَا وَتَقَبَّلْ دُعَاءِ',
    okunus:
        'Rabbic\'alnî mukîmes-salâti ve min zürriyyetî, rabbenâ ve tekabbel duâ\'.',
    meal:
        'Rabbim! Beni ve soyumdan bir kısmını namazı devamlı kılanlardan eyle; Rabbimiz, duamı kabul buyur!',
    durum: 'Namazda sebat ve hayırlı evlat niyetiyle okunur.',
    kaynak: 'İbrâhîm Suresi, 40. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-ibrahim-kabe',
    peygamber: 'Hz. İbrâhîm & Hz. İsmâil (a.s.)',
    baslik: 'Kâbe İnşası Kabul Duası',
    arapca:
        'رَبَّنَا تَقَبَّلْ مِنَّا ۖ إِنَّكَ أَنتَ السَّمِيعُ الْعَلِيمُ',
    okunus: 'Rabbenâ tekabbel minnâ, inneke ente\'s-semî\'u\'l-alîm.',
    meal:
        'Rabbimiz! Bizden (bu hayırlı ameli) kabul buyur; şüphesiz Sen hakkıyla işitensin, hakkıyla bilensin.',
    durum: 'Bir hayırlı işe başlarken kabulü için okunur.',
    kaynak: 'Bakara Suresi, 127. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-ibrahim-teslimiyet',
    peygamber: 'Hz. İbrâhîm & Hz. İsmâil (a.s.)',
    baslik: 'Teslimiyet Duası',
    arapca:
        'رَبَّنَا وَاجْعَلْنَا مُسْلِمَيْنِ لَكَ وَمِن ذُرِّيَّتِنَا أُمَّةً مُّسْلِمَةً لَّكَ',
    okunus:
        'Rabbenâ vec\'alnâ müslimayni leke ve min zürriyyetinâ ümmeten müslimeten lek.',
    meal:
        'Rabbimiz! İkimizi de sana teslim olmuş kullar kıl; soyumuzdan da sana teslim olan bir ümmet çıkar.',
    durum: 'Allah\'a teslimiyet ve ümmet için hayır dilerken okunur.',
    kaynak: 'Bakara Suresi, 128. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-lut',
    peygamber: 'Hz. Lût (a.s.)',
    baslik: 'Kötü Ortamdan Kurtuluş Duası',
    arapca: 'رَبِّ نَجِّنِي وَأَهْلِي مِمَّا يَعْمَلُونَ',
    okunus: 'Rabbi neccinî ve ehlî mimmâ ya\'melûn.',
    meal:
        'Rabbim! Beni ve ailemi, onların işlediği (çirkin) işlerden kurtar.',
    durum: 'Ahlaki çöküntü içindeki bir ortamdan ailesiyle birlikte korunmak için okunur.',
    kaynak: 'Şuarâ Suresi, 169. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-musa-sadr',
    peygamber: 'Hz. Mûsâ (a.s.)',
    baslik: 'Göğüs Genişletme ve Kolaylık Duası',
    arapca:
        'رَبِّ اشْرَحْ لِي صَدْرِي وَيَسِّرْ لِي أَمْرِي وَاحْلُلْ عُقْدَةً مِّن لِّسَانِي يَفْقَهُوا قَوْلِي',
    okunus:
        'Rabbi\'şrah lî sadrî ve yessir lî emrî vehlül ukdeten min lisânî yefkahû kavlî.',
    meal:
        'Rabbim! Göğsümü genişlet, işimi kolaylaştır, dilimdeki düğümü çöz ki sözümü anlasınlar.',
    durum: 'Sınav, sunum, hitabet ve önemli bir görev öncesi okunur.',
    kaynak: 'Tâhâ Suresi, 25-28. Ayetler',
  ),
  PeygamberDuasi(
    id: 'dua-musa-medyen',
    peygamber: 'Hz. Mûsâ (a.s.)',
    baslik: 'İhtiyaç ve Rızık Duası',
    arapca: 'رَبِّ إِنِّي لِمَا أَنزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ',
    okunus: 'Rabbi innî limâ enzelte ileyye min hayrin fakîr.',
    meal:
        'Rabbim! Doğrusu bana indireceğin her hayra muhtacım.',
    durum: 'Darlık ve ihtiyaç anında rızık, yardım ve hayır dilemek için okunur.',
    kaynak: 'Kasas Suresi, 24. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-musa-magfiret',
    peygamber: 'Hz. Mûsâ (a.s.)',
    baslik: 'Pişmanlık ve Bağışlanma Duası',
    arapca: 'رَبِّ إِنِّي ظَلَمْتُ نَفْسِي فَاغْفِرْ لِي',
    okunus: 'Rabbi innî zalemtü nefsî fağfir lî.',
    meal: 'Rabbim! Doğrusu ben kendime zulmettim; beni bağışla.',
    durum: 'Bir hata sonrası pişmanlık duyarak bağışlanma istemek için okunur.',
    kaynak: 'Kasas Suresi, 16. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-sualb',
    peygamber: 'Hz. Şuayb (a.s.)',
    baslik: 'Hakem Duası',
    arapca:
        'رَبَّنَا افْتَحْ بَيْنَنَا وَبَيْنَ قَوْمِنَا بِالْحَقِّ وَأَنتَ خَيْرُ الْفَاتِحِينَ',
    okunus:
        'Rabbenâftah beynenâ ve beyne kavminâ bi\'l-hakki ve ente hayru\'l-fâtihîn.',
    meal:
        'Rabbimiz! Bizimle kavmimiz arasında hak ile hükmet; Sen hükmedenlerin en hayırlısısın.',
    durum: 'Anlaşmazlık ve haksızlık karşısında adalet için okunur.',
    kaynak: 'A\'râf Suresi, 89. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-eyyub',
    peygamber: 'Hz. Eyyûb (a.s.)',
    baslik: 'Şifa Duası',
    arapca:
        'رَبِّ إِنِّي مَسَّنِيَ الضُّرُّ وَأَنتَ أَرْحَمُ الرَّاحِمِينَ',
    okunus:
        'Rabbi innî messeniyed-durru ve ente erhamu\'r-râhimîn.',
    meal:
        'Rabbim! Şüphesiz bana bir darlık (hastalık) dokundu; Sen merhametlilerin en merhametlisisin.',
    durum: 'Hastalık ve sıkıntı anlarında şifa niyetiyle okunur.',
    kaynak: 'Enbiyâ Suresi, 83. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-yunus',
    peygamber: 'Hz. Yûnus (a.s.)',
    baslik: 'Balığın Karnındaki Dua',
    arapca:
        'لَا إِلَٰهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ',
    okunus:
        'Lâ ilâhe illâ ente sübhâneke innî küntü mine\'z-zâlimîn.',
    meal:
        'Senden başka hiçbir ilah yoktur; Seni tenzih ederim; doğrusu ben zalimlerden oldum.',
    durum: 'Darlık, sıkıntı ve umutsuzlukta kurtuluş için okunan meşhur duadır.',
    kaynak: 'Enbiyâ Suresi, 87. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-suleyman',
    peygamber: 'Hz. Süleymân (a.s.)',
    baslik: 'Şükür Duası',
    arapca:
        'رَبِّ أَوْزِعْنِي أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِي أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ',
    okunus:
        'Rabbi evzı\'nî en eşküra ni\'metekelletî en\'amte aleyye ve alâ vâlideyye.',
    meal:
        'Rabbim! Bana ve anne-babama verdiğin nimetlere şükretmeyi bana ilham et.',
    durum: 'Nimetin kıymetini bilmek ve şükretmek için okunur.',
    kaynak: 'Neml Suresi, 19. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-zekeriyya',
    peygamber: 'Hz. Zekeriyyâ (a.s.)',
    baslik: 'Hayırlı Evlat Duası',
    arapca:
        'رَبِّ هَبْ لِي مِن لَّدُنكَ ذُرِّيَّةً طَيِّبَةً ۖ إِنَّكَ سَمِيعُ الدُّعَاءِ',
    okunus:
        'Rabbi heb lî min ledünke zürriyyeten tayyibeh, inneke semî\'u\'d-duâ\'.',
    meal:
        'Rabbim! Bana katından temiz bir nesil ihsan et; şüphesiz Sen duayı işitensin.',
    durum: 'Hayırlı, salih bir evlat sahibi olmak için okunur.',
    kaynak: 'Âl-i İmrân Suresi, 38. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-zekeriyya-yasli',
    peygamber: 'Hz. Zekeriyyâ (a.s.)',
    baslik: 'Yaşlılıkta Ümit Duası',
    arapca:
        'رَبِّ إِنِّي وَهَنَ الْعَظْمُ مِنِّي وَاشْتَعَلَ الرَّأْسُ شَيْبًا وَلَمْ أَكُن بِدُعَائِكَ رَبِّ شَقِيًّا',
    okunus:
        'Rabbi innî vehenel\'azmü minnî veştea\'le\'r-re\'sü şeyben ve lem ekun bi-duâike rabbi şakıyyâ.',
    meal:
        'Rabbim! Şüphesiz kemiklerim gevşedi, başım ağardı; Sana dua etmekle de bedbaht olmadım.',
    durum: 'Yaş ilerlese de Allah\'tan umut kesmemek için okunur.',
    kaynak: 'Meryem Suresi, 4. Ayet',
  ),
  PeygamberDuasi(
    id: 'dua-isa',
    peygamber: 'Hz. Îsâ (a.s.)',
    baslik: 'Sofra (Rızık) Duası',
    arapca:
        'اللَّهُمَّ رَبَّنَا أَنزِلْ عَلَيْنَا مَائِدَةً مِّنَ السَّمَاءِ تَكُونُ لَنَا عِيدًا لِّأَوَّلِنَا وَآخِرِنَا وَآيَةً مِّنكَ وَارْزُقْنَا وَأَنتَ خَيْرُ الرَّازِقِينَ',
    okunus:
        'Allâhümme rabbenâ enzil aleynâ mâideten mine\'s-semâi tekûnü lenâ îden li-evvelinâ ve âhirinâ ve âyeten minke, verzuknâ ve ente hayru\'r-râzikîn.',
    meal:
        'Ey Rabbimiz! Bize gökten bir sofra indir ki, bizim hem öncekilerimize hem sonrakilerimize bayram ve Sen\'den bir mucize olsun; bizi rızıklandır, Sen rızık verenlerin en hayırlısısın.',
    durum: 'Rızık, bereket ve toplu hayırlı yemekler için okunur.',
    kaynak: 'Mâide Suresi, 114. Ayet',
  ),
];

/// Katalog için arama yardımcısı: peygamber, başlık, meal ve okunuşta arar.
class PeygamberDualariVerileri {
  PeygamberDualariVerileri._();

  static List<PeygamberDuasi> get tumu => peygamberDualari;

  static List<PeygamberDuasi> ara(String sorgu) {
    final q = sorgu.trim().toLowerCase();
    if (q.isEmpty) return const [];
    final kelimeler = q
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 1)
        .toList();
    if (kelimeler.isEmpty) return const [];
    return peygamberDualari.where((d) {
      final metin = d.aramaMetni;
      return kelimeler.every((w) => metin.contains(w));
    }).toList();
  }

  static List<String> get peygamberler {
    final set = <String>{};
    for (final d in peygamberDualari) {
      set.add(d.peygamber);
    }
    return set.toList();
  }
}
