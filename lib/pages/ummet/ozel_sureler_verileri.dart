class OzelSureVerisi {
  final String baslik;
  final String baslikEn;
  final String arapca;
  final String mealTr;
  final String mealEn;
  final String audioUrl;
  final bool isSure;
  final int? sureNo;
  final int? ayetBaslangic;
  final int? ayetBitis;

  const OzelSureVerisi({
    required this.baslik,
    required this.baslikEn,
    required this.arapca,
    required this.mealTr,
    required this.mealEn,
    required this.audioUrl,
    this.isSure = true,
    this.sureNo,
    this.ayetBaslangic,
    this.ayetBitis,
  });
}

const List<OzelSureVerisi> ozelSureler = [
  OzelSureVerisi(
    baslik: 'Yâsîn',
    baslikEn: 'Ya-Sin',
    sureNo: 36,
    arapca: 'يس \nوالقرآن الحكيم \nإنك لمن المرسلين \nعلى صراط مستقيم \nتنزيل العزيز الرحيم',
    mealTr: 'Yâsîn Suresi. Kur\'an-ı Kerim\'in 36. suresidir. Önemli surelerden biridir. Gece okunması önerilir. Şefaatin okunacağı gecelerden biridir. Hz. Peygamber (s.a.v.) her gece Yâsîn okumayı tavsiye etmiştir.',
    mealEn: 'Ya-Sin. One of the most important Surahs. It is recommended to recite at night. The Prophet (pbuh) advised reading it every night.',
    audioUrl: 'https://server8.mp3quran.net/afs/036.mp3',
  ),

  OzelSureVerisi(
    baslik: 'Mülk (Tebâreke)',
    baslikEn: 'Al-Mulk',
    sureNo: 67,
    arapca: 'تَبَارَكَ الَّذِي بِيَدِهِ الْمُلْكُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ \nالَّذِي خَلَقَ الْمَوْتَ وَالْحَيَاةَ لِيَبْلُوَكُمْ أَيُّكُمْ أَحْسَنُ عَمَلًا',
    mealTr: 'Mülk Suresi. Mülk, O\'nun (Allah\'ın) elindedir. O her şeye kadirdir. Ölümsüzü yaratan, diriyi yaratan O\'dur. Hanginizin daha güzel iş yaptığını denemek için. O, çok güçlü, çok bağışlayıcıdır. Yedi göğü yaratan O\'dur.',
    mealEn: 'Al-Mulk. Blessed is He in whose hand is dominion, and He is over all things competent. He who created death and life to test you [as to] which of you is best in deed.',
    audioUrl: 'https://server8.mp3quran.net/afs/067.mp3',
  ),

  OzelSureVerisi(
    baslik: 'İnşirâh',
    baslikEn: 'Ash-Sharh',
    sureNo: 94,
    arapca: 'أَلَمْ نَشْرَحْ لَكَ صَدْرَكَ \nوَوَضَعْنَا عَنكَ وِزْرَكَ \nالَّذِي أَنْقَضَ ظَهْرَكَ \nوَرَفَعْنَا لَكَ ذِكْرَكَ \nفَإِنَّ مَعَ الْعُسْرِ يُسْرًا \nإِنَّ مَعَ الْعُسْرِ يُسْرًا',
    mealTr: 'İnşirâh Suresi. Senin göğsünü açmadık mı? Yükünü senden indirmedik mi? Senin sırtını çökükleri yarmadık mı? Yüklediklerini sana yorduk. Şeritleyeste yorulunca hemen kalk ve Rabbine y\u00f6nel.',
    mealEn: 'Ash-Sharh. Did We not expand for you, [O Muhammad], your breast? And We removed from you your burden. For indeed, with hardship [will be] ease.',
    audioUrl: 'https://server8.mp3quran.net/afs/094.mp3',
  ),

  OzelSureVerisi(
    baslik: 'Kıymet',
    baslikEn: 'Al-Qiyamah',
    sureNo: 75,
    arapca: 'لَا أُقْسِمُ بِيَوْمِ الْقِيَامَةِ \nوَلَا أُقْسِمُ بِالنَّفْسِ اللَّوَّامَةِ \nأَيَحْسَبُ الْإِنْسَانُ أَلَّا نَجْمَعَ عِظَامَهُ',
    mealTr: 'Kıymet Suresi. Hayır, yemin olsun Kıymet gününe. Hayır, yemin olsun tövbekâr nefse. İnsan, kemiklerini toplayamayacağımızı mı sanıyor? Evet, biz onun parmak bileklerini bile bürüyebiliyoruz.',
    mealEn: 'Al-Qiyamah. I swear by the Day of Resurrection. And I swear by the reproaching soul. Does man think that We will not assemble his bones?',
    audioUrl: 'https://server8.mp3quran.net/afs/075.mp3',
  ),

  OzelSureVerisi(
    baslik: 'Fâtiha',
    baslikEn: 'Al-Fatiha',
    sureNo: 1,
    arapca: 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ \nالْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ \nالرَّحْمَنِ الرَّحِيمِ \nمَالِكِ يَوْمِ الدِّينِ',
    mealTr: 'Fâtiha Suresi. Rahman ve Rahim olan Allah\'ın adıyla. Hamd, alemlerin Rabbi Allah\'a mahsustur. Rahman ve Rahim\'dir. Din günü de O\'nundur. Ancak sana kulluk ederiz ve ancak senden yardım dileriz.',
    mealEn: 'Al-Fatiha. In the name of Allah, the Entirely Merciful, the Especially Merciful. All praise is due to Allah, Lord of the worlds.',
    audioUrl: 'https://server8.mp3quran.net/afs/001.mp3',
  ),

  OzelSureVerisi(
    baslik: 'Vâki\'a',
    baslikEn: 'Al-Waqiah',
    sureNo: 56,
    arapca: 'إِذَا وَقَعَتِ الْوَاقِعَةُ \nلَيْسَ لِوَقْعَتِهَا كَاذِبَةٌ \nخَافِضَةٌ رَافِعَةٌ',
    mealTr: 'Vâki\'a Suresi. O hadise (Kıymet) gerçekleştiğinde. Onun gerçekleşmesi yalanlanamaz. Alçaltıcıdır, yükselticidir. Dağlar sarışıp savrulduklarında.',
    mealEn: 'Al-Waqiah. When the Occurrence occurs, There is no denying its occurrence. Lowerring [some] and exalting [others].',
    audioUrl: 'https://server8.mp3quran.net/afs/056.mp3',
  ),

  OzelSureVerisi(
    baslik: 'Cuma',
    baslikEn: 'Al-Jumah',
    sureNo: 62,
    arapca: 'يُسَبِّحُ لِلَّهِ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ الْمَلِكِ الْقُدُّوسِ الْعَزِيزِ الْحَكِيمِ',
    mealTr: 'Cuma Suresi. Göklerde ve yerde olan her şey Allah\'ı tesbih eder. O, mülkün sahibi, çok pâk, çok izzet sahibi, çok hikmet sahibidir.',
    mealEn: 'Al-Jumah. Whatever is in the heavens and whatever is on the earth is exalting Allah, the Sovereign, the Pure, the Exalted in Might, the Wise.',
    audioUrl: 'https://server8.mp3quran.net/afs/062.mp3',
  ),

  OzelSureVerisi(
    baslik: 'Haşr Suresi (22-24)',
    baslikEn: 'Al-Hashr (22-24)',
    sureNo: 59,
    ayetBaslangic: 22,
    ayetBitis: 24,
    arapca: 'هُوَ اللَّهُ الَّذِي لَا إِلَهَ إِلَّا هُوَ عَالِمُ الْغَيْبِ وَالشَّهَادَةِ هُوَ الرَّحْمَنُ الرَّحِيمُ',
    mealTr: 'Haşr Suresi 22-24. İşte o Allah ki, O\'ndan başka ilah yoktur. Gaibi de şahidi de bilir. O Rahman ve Rahim\'dir. O Allah ki, O\'ndan başka ilah yoktur. Melik, Kuddüs, Selam, Mü\'min, Müheymin, Aziz, Cebbar, Mütekebbir\'dir.',
    mealEn: 'Al-Hashr 22-24. It is Allah - there is no deity except Him, Knower of the unseen and the witnessed. He is the Entirely Merciful, the Especially Merciful.',
    audioUrl: 'https://server8.mp3quran.net/afs/059.mp3',
  ),

  OzelSureVerisi(
    baslik: 'Duha',
    baslikEn: 'Ad-Duha',
    sureNo: 93,
    arapca: 'وَالضُّحَى \nوَاللَّيْلِ إِذَا سَجَى \nمَا وَدَعَكَ رَبُّكَ وَمَا قَلَى',
    mealTr: 'Duha Suresi. Şükr ve kuşluk vaktine yemin olsun ki, gece bastırdığı zaman da. Rahman olan Rabbin, sana ne vaaz verdi ne de bıraktı. Ahiret, senin için önkünden daha hayırlıdır.',
    mealEn: 'Ad-Duha. By the morning sunlight! And [by] the night when it covers with darkness, Your Lord [O Muhammad] has not taken leave of you, nor has He detested [you].',
    audioUrl: 'https://server8.mp3quran.net/afs/093.mp3',
  ),

  OzelSureVerisi(
    baslik: 'Neml Suresi (Seçme Kısım)',
    baslikEn: 'An-Naml (Selected)',
    sureNo: 27,
    ayetBaslangic: 15,
    ayetBitis: 30,
    arapca: 'وَوَجَدَهَا وَقَوْمَهَا يَسْجُدُونَ لِلشَّمْسِ مِن دُونِ اللَّهِ',
    mealTr: 'Neml Suresi (Seçme Kısım). Hz. Süleyman, Belkıs\'ın ve kavminin Allah\'ı bırakıp güneşe secde ettiklerini buldu. Şeytan, onlara amellerini süslemişti. Onları yoldan çıkarmıştı. Onlar doğru yola iletilememişlerdi.',
    mealEn: 'An-Naml (Selected). Solomon found her and her people prostrating to the sun instead of Allah. Satan had decorated for them their deeds and averted them from [His] way.',
    audioUrl: 'https://server8.mp3quran.net/afs/027.mp3',
  ),

  OzelSureVerisi(
    baslik: 'İsmi Azam Duaları',
    baslikEn: 'Ism-e-Azam Dua',
    isSure: false,
    arapca: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ بِأَنَّ لَكَ الْحَمْدَ لَا إِلَهَ إِلَّا أَنْتَ الْمَنَّانُ بَدِيعُ السَّمَاوَاتِ وَالْأَرْضِ',
    mealTr: 'İsmi Azam Duaları. Allah\'ım! Senden, hamdın Sana ait olduğunu, Senden başka ilah olmadığını, Senin Rahman, gökleri ve yeri yaratan, Celal ve İkram sahibi olduğunu ikrar ederek istiyorum.',
    mealEn: 'Ism-e-Azam Dua. O Allah! I ask You, for all praise belongs to You, there is no deity except You, the Bestower, the Originator of the heavens and the earth.',
    audioUrl: '',
  ),

  OzelSureVerisi(
    baslik: 'Cevşen-ül Kebîr',
    baslikEn: 'Al-Jawshan Al-Kabir',
    isSure: false,
    arapca: 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ \nاللَّهُمَّ إِنِّي أَسْأَلُكَ بِاسْمِ اللَّهِ الْعَزِيزِ الْجَبَّارِ',
    mealTr: 'Cevşen-ül Kebîr Duası. Rahman ve Rahim olan Allah\'ın adıyla. Allah\'ım! Senden, bu duanın hakkı ve yüceliğine ve göğe koyduğun ismin hakkı için, Muhammed\'e ve al-i Muhammed\'e salat etmeni istiyorum.',
    mealEn: 'Al-Jawshan Al-Kabir Dua. In the name of Allah, the Entirely Merciful, the Especially Merciful. O Allah! I ask You by the right of this supplication and by the right of Your name.',
    audioUrl: '',
  ),
];
