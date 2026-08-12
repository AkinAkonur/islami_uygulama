import 'package:flutter/material.dart';
import '../../services/dualar_verileri.dart';

enum KartIcerikTipi { ayet, hadis, dua }

class KartIcerik {
  final String id;
  final KartIcerikTipi tip;
  final String baslik;
  final String kaynak;
  final String metin;
  final String? arapca;

  const KartIcerik({
    required this.id,
    required this.tip,
    required this.baslik,
    required this.kaynak,
    required this.metin,
    this.arapca,
  });

  factory KartIcerik.duadan(DuaKaydi d) => KartIcerik(
        id: 'dua_${d.id}',
        tip: KartIcerikTipi.dua,
        baslik: d.baslik,
        kaynak: d.kaynak.isNotEmpty ? d.kaynak : 'Dua',
        metin: d.meal.isNotEmpty ? d.meal : d.okunus,
        arapca: d.arapca.isNotEmpty ? d.arapca : null,
      );

  String get etiket =>
      switch (tip) { KartIcerikTipi.ayet => 'Ayet', KartIcerikTipi.hadis => 'Hadis', KartIcerikTipi.dua => 'Dua' };
}

const String uygulamaAdi = 'Huzur & Manevi Yolculuk';

List<KartIcerik> kartAyetleri = [
  KartIcerik(
    id: 'ayet_insirah_6',
    tip: KartIcerikTipi.ayet,
    baslik: 'İnşirâh Suresi',
    kaynak: 'İnşirâh Suresi, 6. Âyet',
    metin: 'Şüphesiz her zorlukla beraber bir kolaylık vardır.',
    arapca: 'إِنَّ مَعَ الْعُسْرِ يُسْرًا',
  ),
  KartIcerik(
    id: 'ayet_rad_28',
    tip: KartIcerikTipi.ayet,
    baslik: 'Ra\'d Suresi',
    kaynak: 'Ra\'d Suresi, 28. Âyet',
    metin: 'Bilesiniz ki, kalpler ancak Allah\'ı anmakla huzur bulur.',
    arapca: 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
  ),
  KartIcerik(
    id: 'ayet_bakara_152',
    tip: KartIcerikTipi.ayet,
    baslik: 'Bakara Suresi',
    kaynak: 'Bakara Suresi, 152. Âyet',
    metin: 'Öyleyse beni anın ki, ben de sizi anayım. Bana şükredin, sakın nankörlük etmeyin.',
    arapca: 'فَاذْكُرُونِي أَذْكُرْكُمْ وَاشْكُرُوا لِي وَلَا تَكْفُرُونِ',
  ),
  KartIcerik(
    id: 'ayet_ibrahim_7',
    tip: KartIcerikTipi.ayet,
    baslik: 'İbrâhîm Suresi',
    kaynak: 'İbrâhîm Suresi, 7. Âyet',
    metin: 'Andolsun, eğer şükrederseniz elbette size nimetimi artırırım. Eğer nankörlük ederseniz hiç şüphesiz azabım pek şiddetlidir.',
    arapca: 'لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ ۖ وَلَئِن كَفَرْتُمْ إِنَّ عَذَابِي لَشَدِيدٌ',
  ),
  KartIcerik(
    id: 'ayet_talak_3',
    tip: KartIcerikTipi.ayet,
    baslik: 'Talâk Suresi',
    kaynak: 'Talâk Suresi, 3. Âyet',
    metin: 'Kim Allah\'a tevekkül ederse, O kendisine yeter.',
    arapca: 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ',
  ),
  KartIcerik(
    id: 'ayet_zumer_53',
    tip: KartIcerikTipi.ayet,
    baslik: 'Zümer Suresi',
    kaynak: 'Zümer Suresi, 53. Âyet',
    metin: 'De ki: Ey kendilerine karşı aşırı giderek zulmeden kullarım! Allah\'ın rahmetinden ümidinizi kesmeyin. Şüphesiz Allah, bütün günahları bağışlar.',
    arapca: 'قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَىٰ أَنفُسِهِمْ لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ ۚ إِنَّ اللَّهَ يَغْفِرُ الذُّنُوبَ جَمِيعًا',
  ),
  KartIcerik(
    id: 'ayet_bakara_286',
    tip: KartIcerikTipi.ayet,
    baslik: 'Bakara Suresi',
    kaynak: 'Bakara Suresi, 286. Âyet',
    metin: 'Allah, hiç kimseye gücünün yetmediği bir yükü yüklemez.',
    arapca: 'لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا',
  ),
  KartIcerik(
    id: 'ayet_bakara_201',
    tip: KartIcerikTipi.ayet,
    baslik: 'Bakara Suresi',
    kaynak: 'Bakara Suresi, 201. Âyet',
    metin: 'Rabbimiz! Bize dünyada da iyilik ver, âhirette de iyilik ver ve bizi ateş azabından koru.',
    arapca: 'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
  ),
  KartIcerik(
    id: 'ayet_rahman_13',
    tip: KartIcerikTipi.ayet,
    baslik: 'Rahmân Suresi',
    kaynak: 'Rahmân Suresi, 13. Âyet',
    metin: 'Öyleyse Rabbinizin hangi nimetlerini yalanlıyorsunuz?',
    arapca: 'فَبِأَيِّ آلَاءِ رَبِّكُمَا تُكَذِّبَانِ',
  ),
  KartIcerik(
    id: 'ayet_sems_9',
    tip: KartIcerikTipi.ayet,
    baslik: 'Şems Suresi',
    kaynak: 'Şems Suresi, 9. Âyet',
    metin: 'Nefsini arındıran kurtuluşa ermiştir.',
    arapca: 'قَدْ أَفْلَحَ مَن زَكَّاهَا',
  ),
  KartIcerik(
    id: 'ayet_asr',
    tip: KartIcerikTipi.ayet,
    baslik: 'Asr Suresi',
    kaynak: 'Asr Suresi, 1-3. Âyetler',
    metin: 'Andolsun zamana ki, insan gerçekten ziyan içindedir. Ancak iman edip salih ameller işleyenler, birbirlerine hakkı ve sabrı tavsiye edenler müstesna.',
    arapca: 'وَالْعَصْرِ ۝ إِنَّ الْإِنسَانَ لَفِي خُسْرٍ',
  ),
  KartIcerik(
    id: 'ayet_furkan_74',
    tip: KartIcerikTipi.ayet,
    baslik: 'Furkân Suresi',
    kaynak: 'Furkân Suresi, 74. Âyet',
    metin: 'Rabbimiz! Bize gözümüzü aydınlatacak eşler ve zürriyetler bağışla ve bizi takva sahiplerine önder kıl.',
    arapca: 'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
  ),
  KartIcerik(
    id: 'ayet_bakara_45',
    tip: KartIcerikTipi.ayet,
    baslik: 'Bakara Suresi',
    kaynak: 'Bakara Suresi, 45. Âyet',
    metin: 'Sabrederek ve namaz kılarak Allah\'tan yardım isteyin. Şüphesiz bu, huşû duyanların dışındakilere çok ağır gelir.',
    arapca: 'وَاسْتَعِينُوا بِالصَّبْرِ وَالصَّلَاةِ ۚ وَإِنَّهَا لَكَبِيرَةٌ إِلَّا عَلَى الْخَاشِعِينَ',
  ),
  KartIcerik(
    id: 'ayet_yunus_62',
    tip: KartIcerikTipi.ayet,
    baslik: 'Yûnus Suresi',
    kaynak: 'Yûnus Suresi, 62. Âyet',
    metin: 'Bilesiniz ki, Allah\'ın dostlarına korku yoktur; onlar üzülmeyeceklerdir de.',
    arapca: 'أَلَا إِنَّ أَوْلِيَاءَ اللَّهِ لَا خَوْفٌ عَلَيْهِمْ وَلَا هُمْ يَحْزَنُونَ',
  ),
  KartIcerik(
    id: 'ayet_kaf_16',
    tip: KartIcerikTipi.ayet,
    baslik: 'Kâf Suresi',
    kaynak: 'Kâf Suresi, 16. Âyet',
    metin: 'Andolsun, insanı biz yarattık ve nefsinin ona ne vesveseler verdiğini de biliriz. Biz ona şah damarından daha yakınız.',
    arapca: 'وَنَحْنُ أَقْرَبُ إِلَيْهِ مِنْ حَبْلِ الْوَرِيدِ',
  ),
  KartIcerik(
    id: 'ayet_hud_88',
    tip: KartIcerikTipi.ayet,
    baslik: 'Hûd Suresi',
    kaynak: 'Hûd Suresi, 88. Âyet',
    metin: 'Benim başarım ancak Allah\'ın yardımıyladır. Ona tevekkül ettim ve ona yöneliyorum.',
    arapca: 'وَمَا تَوْفِيقِي إِلَّا بِاللَّهِ ۚ عَلَيْهِ تَوَكَّلْتُ وَإِلَيْهِ أُنِيبُ',
  ),
  KartIcerik(
    id: 'ayet_nur_35',
    tip: KartIcerikTipi.ayet,
    baslik: 'Nûr Suresi',
    kaynak: 'Nûr Suresi, 35. Âyet',
    metin: 'Allah, göklerin ve yerin nurudur.',
    arapca: 'اللَّهُ نُورُ السَّمَاوَاتِ وَالْأَرْضِ',
  ),
  KartIcerik(
    id: 'ayet_aliimran_139',
    tip: KartIcerikTipi.ayet,
    baslik: 'Âl-i İmrân Suresi',
    kaynak: 'Âl-i İmrân Suresi, 139. Âyet',
    metin: 'Gevşemeyin, üzülmeyin. Eğer gerçekten iman etmişseniz, üstün gelecek olan sizsiniz.',
    arapca: 'وَلَا تَهِنُوا وَلَا تَحْزَنُوا وَأَنتُمُ الْأَعْلَوْنَ إِن كُنتُم مُّؤْمِنِينَ',
  ),
  KartIcerik(
    id: 'ayet_duha_5',
    tip: KartIcerikTipi.ayet,
    baslik: 'Duhâ Suresi',
    kaynak: 'Duhâ Suresi, 5. Âyet',
    metin: 'Rabbin sana verecek, sen de hoşnut olacaksın.',
    arapca: 'وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰ',
  ),
  KartIcerik(
    id: 'ayet_bakara_216',
    tip: KartIcerikTipi.ayet,
    baslik: 'Bakara Suresi',
    kaynak: 'Bakara Suresi, 216. Âyet',
    metin: 'Olur ki bir şey hoşunuza gitmez ama o sizin için hayırlıdır. Olur ki bir şey hoşunuza gider ama o sizin için kötüdür. Siz bilmezsiniz, Allah bilir.',
    arapca: 'وَعَسَىٰ أَن تَكْرَهُوا شَيْئًا وَهُوَ خَيْرٌ لَّكُمْ',
  ),
];

List<KartIcerik> kartHadisleri = [
  KartIcerik(
    id: 'hadis_niyet',
    tip: KartIcerikTipi.hadis,
    baslik: 'Niyetin Önemi',
    kaynak: 'Buhârî, Bed\'ü\'l-Vahy 1; Müslim, İmâre 155',
    metin: 'Ameller ancak niyetlere göredir. Herkese ancak niyet ettiği şey vardır.',
    arapca: 'إِنَّمَا الْأَعْمَالُ بِالنِّيَّاتِ وَإِنَّمَا لِكُلِّ امْرِئٍ مَا نَوَى',
  ),
  KartIcerik(
    id: 'hadis_musluman',
    tip: KartIcerikTipi.hadis,
    baslik: 'Müslüman Kime Denir',
    kaynak: 'Buhârî, Îmân 4; Müslim, Îmân 64-66',
    metin: 'Müslüman; elinden ve dilinden diğer Müslümanların güvende olduğu kimsedir.',
    arapca: 'الْمُسْلِمُ مَنْ سَلِمَ الْمُسْلِمُونَ مِنْ لِسَانِهِ وَيَدِهِ',
  ),
  KartIcerik(
    id: 'hadis_salavat',
    tip: KartIcerikTipi.hadis,
    baslik: 'Salavatın Fazileti',
    kaynak: 'Müslim, Salât 70',
    metin: 'Kim bana bir salavat getirirse, Allah ona on rahmet eder.',
    arapca: 'مَنْ صَلَّى عَلَيَّ صَلَاةً صَلَّى اللَّهُ عَلَيْهِ بِهَا عَشْرًا',
  ),
  KartIcerik(
    id: 'hadis_cennet_anne',
    tip: KartIcerikTipi.hadis,
    baslik: 'Anneye Hürmet',
    kaynak: 'Nesâî, Cihâd 6',
    metin: 'Cennet annelerin ayakları altındadır.',
  ),
  KartIcerik(
    id: 'hadis_selam',
    tip: KartIcerikTipi.hadis,
    baslik: 'Selâmı Yayın',
    kaynak: 'Müslim, Îmân 93',
    metin: 'Birbirinizi sevmedikçe iman etmiş olmazsınız. Aranızda selâmı yayın ki sevginiz artar.',
    arapca: 'لَا تَدْخُلُونَ الْجَنَّةَ حَتَّى تُؤْمِنُوا وَلَا تُؤْمِنُوا حَتَّى تَحَابُّوا أَفْشُوا السَّلَامَ بَيْنَكُمْ',
  ),
  KartIcerik(
    id: 'hadis_temizlik',
    tip: KartIcerikTipi.hadis,
    baslik: 'Temizlik',
    kaynak: 'Müslim, Tahâret 1',
    metin: 'Temizlik imanın yarısıdır. Elhamdülillah mizanı doldurur.',
    arapca: 'الطُّهُورُ شَطْرُ الْإِيمَانِ',
  ),
  KartIcerik(
    id: 'hadis_ilim_dua',
    tip: KartIcerikTipi.hadis,
    baslik: 'Hayırlı Dua',
    kaynak: 'Müslim, Zikir 73',
    metin: 'Allah\'ım! Faydasız ilimden, korkmayan kalpten, doymayan nefisten ve kabul olunmayan duadan sana sığınırım.',
  ),
  KartIcerik(
    id: 'hadis_ahlak',
    tip: KartIcerikTipi.hadis,
    baslik: 'Güzel Ahlâk',
    kaynak: 'Tirmizî, Rıdâ 11',
    metin: 'Sizin iman bakımından en olgununuz, ahlâkı en güzel olanınızdır.',
  ),
  KartIcerik(
    id: 'hadis_sikinti',
    tip: KartIcerikTipi.hadis,
    baslik: 'Müminin Yardımı',
    kaynak: 'Müslim, Birr 58',
    metin: 'Kim mümin bir kardeşinin dünyevî bir sıkıntısını giderirse, Allah da kıyamet günü onun sıkıntılarından birini giderir.',
    arapca: 'مَنْ نَفَّسَ عَنْ مُؤْمِنٍ كُرْبَةً مِنْ كُرَبِ الدُّنْيَا نَفَّسَ اللَّهُ عَنْهُ كُرْبَةً مِنْ كُرَبِ يَوْمِ الْقِيَامَةِ',
  ),
  KartIcerik(
    id: 'hadis_haklar',
    tip: KartIcerikTipi.hadis,
    baslik: 'Müslümanın Hakkı',
    kaynak: 'Buhârî, Cenâiz 2; Müslim, Selâm 4',
    metin: 'Müslümanın Müslüman üzerindeki hakkı beştir: Selâmı almak, hastayı ziyaret etmek, cenazenin ardından gitmek, davete icabet etmek ve aksırana "yerhamükellah" demek.',
  ),
  KartIcerik(
    id: 'hadis_hayir_elci',
    tip: KartIcerikTipi.hadis,
    baslik: 'Hayra Vesile Olan',
    kaynak: 'Müslim, İmâre 45',
    metin: 'Her kim bir hayra aracılık ederse, o hayırdan kendisine de bir pay vardır.',
  ),
  KartIcerik(
    id: 'hadis_kuran_ogren',
    tip: KartIcerikTipi.hadis,
    baslik: 'Kur\'an Öğrenen',
    kaynak: 'Buhârî, Fedâilü\'l-Kur\'ân 21',
    metin: 'Sizin hayırlınız, Kur\'an\'ı öğrenen ve öğretendir.',
    arapca: 'خَيْرُكُمْ مَنْ تَعَلَّمَ الْقُرْآنَ وَعَلَّمَهُ',
  ),
  KartIcerik(
    id: 'hadis_hayirli_soz',
    tip: KartIcerikTipi.hadis,
    baslik: 'Hayırlı Söz',
    kaynak: 'Buhârî, Edeb 31; Müslim, Îmân 74',
    metin: 'Kim Allah\'a ve âhiret gününe iman ediyorsa, ya hayır söylesin ya da sussun.',
    arapca: 'مَنْ كَانَ يُؤْمِنُ بِاللَّهِ وَالْيَوْمِ الْآخِرِ فَلْيَقُلْ خَيْرًا أَوْ لِيَصْمُتْ',
  ),
  KartIcerik(
    id: 'hadis_zikir',
    tip: KartIcerikTipi.hadis,
    baslik: 'En Faziletli Zikir',
    kaynak: 'Tirmizî, Deavât 9',
    metin: 'Zikrin en faziletlisi "Lâ ilâhe illallah"tır.',
    arapca: 'أَفْضَلُ الذِّكْرِ لَا إِلَهَ إِلَّا اللَّهُ',
  ),
  KartIcerik(
    id: 'hadis_dua_ibadet',
    tip: KartIcerikTipi.hadis,
    baslik: 'Dua İbadettir',
    kaynak: 'Tirmizî, Deavât 1',
    metin: 'Şüphesiz dua, ibadetin özüdür.',
  ),
  KartIcerik(
    id: 'hadis_sadaka',
    tip: KartIcerikTipi.hadis,
    baslik: 'Sadakanın Bereketi',
    kaynak: 'Müslim, Birr 69',
    metin: 'Sadaka, malı eksiltmez. Allah, affeden kulun ancak izzetini artırır.',
    arapca: 'مَا نَقَصَتْ صَدَقَةٌ مِنْ مَالٍ',
  ),
  KartIcerik(
    id: 'hadis_guler_yuz',
    tip: KartIcerikTipi.hadis,
    baslik: 'Güler Yüz Sadakadır',
    kaynak: 'Tirmizî, Birr 45',
    metin: 'Mümin kardeşini güler yüzle karşılaman da bir sadakadır.',
    arapca: 'تَبَسُّمُكَ فِي وَجْهِ أَخِيكَ لَكَ صَدَقَةٌ',
  ),
  KartIcerik(
    id: 'hadis_sabir',
    tip: KartIcerikTipi.hadis,
    baslik: 'Sabır Aydınlıktır',
    kaynak: 'Müslim, Tahâret 1',
    metin: 'Sabır, aydınlıktır.',
    arapca: 'وَالصَّبْرُ ضِيَاءٌ',
  ),
  KartIcerik(
    id: 'hadis_dunya_kul',
    tip: KartIcerikTipi.hadis,
    baslik: 'Kul Olmak',
    kaynak: 'Buhârî, Rikâk 15',
    metin: 'Zühd, helâli değil; dünyadan ahirete yöneliştir. Allah\'ın katında olanlar bâkîdir.',
  ),
  KartIcerik(
    id: 'hadis_komu',
    tip: KartIcerikTipi.hadis,
    baslik: 'Komşu Hakkı',
    kaynak: 'Buhârî, Edeb 28; Müslim, Îmân 74',
    metin: 'Allah\'a ve âhiret gününe iman eden, komşusuna eziyet etmesin.',
  ),
];

class PaylasimKartlariVerileri {
  PaylasimKartlariVerileri._();

  static final PaylasimKartlariVerileri instance = PaylasimKartlariVerileri._();

  List<KartIcerik>? _dualar;

  Future<List<KartIcerik>> dualariGetir() async {
    final mevcut = _dualar;
    if (mevcut != null) return mevcut;
    final dualar = await DualarVerileri.instance.tumDualar();
    final sonuc = dualar.take(60).map(KartIcerik.duadan).toList();
    _dualar = sonuc;
    return sonuc;
  }

  Future<List<KartIcerik>> listeGetir(KartIcerikTipi tip) async {
    switch (tip) {
      case KartIcerikTipi.ayet:
        return kartAyetleri;
      case KartIcerikTipi.hadis:
        return kartHadisleri;
      case KartIcerikTipi.dua:
        return dualariGetir();
    }
  }
}

class KartTema {
  final String ad;
  final IconData ikon;
  final List<Color> gradient;
  final Color metin;
  final Color arapca;
  final Color kaynak;
  final Color ornament;
  final Color filigran;
  final Color secimRenk;
  final String desen;
  final bool camEfekti;
  final bool koyu;

  const KartTema({
    required this.ad,
    required this.ikon,
    required this.gradient,
    required this.metin,
    required this.arapca,
    required this.kaynak,
    required this.ornament,
    required this.filigran,
    required this.secimRenk,
    required this.desen,
    this.camEfekti = false,
    required this.koyu,
  });
}

List<KartTema> kartTemalari = [
  const KartTema(
    ad: 'Gece Premium',
    ikon: Icons.nightlight_round,
    gradient: [Color(0xFF0B1220), Color(0xFF1A2540)],
    metin: Colors.white,
    arapca: Color(0xFFE8C877),
    kaynak: Color(0xFFE8C877),
    ornament: Color(0xFFC9A860),
    filigran: Color(0x99FFFFFF),
    secimRenk: Color(0xFF16213E),
    desen: 'yildiz',
    koyu: true,
  ),
  const KartTema(
    ad: 'Kâbe Gecesi',
    ikon: Icons.mosque_outlined,
    gradient: [Color(0xFF081226), Color(0xFF14314F)],
    metin: Colors.white,
    arapca: Color(0xFFE8C877),
    kaynak: Color(0xFF9DB8E8),
    ornament: Color(0xFF9DB8E8),
    filigran: Color(0x99FFFFFF),
    secimRenk: Color(0xFF14314F),
    desen: 'kabe',
    koyu: true,
  ),
  const KartTema(
    ad: 'Zümrüt Huzur',
    ikon: Icons.eco_outlined,
    gradient: [Color(0xFF0A2E22), Color(0xFF1B5E46)],
    metin: Colors.white,
    arapca: Color(0xFFEED485),
    kaynak: Color(0xFFC9B26B),
    ornament: Color(0xFF8FBF9F),
    filigran: Color(0x99FFFFFF),
    secimRenk: Color(0xFF1B5E46),
    desen: 'isik',
    koyu: true,
  ),
  const KartTema(
    ad: 'Saf Işık',
    ikon: Icons.wb_sunny_outlined,
    gradient: [Color(0xFFF7F1E3), Color(0xFFFBF7EE)],
    metin: Color(0xFF1F2937),
    arapca: Color(0xFF9A6B1F),
    kaynak: Color(0xFF9A7B4F),
    ornament: Color(0xFFB45309),
    filigran: Color(0x99202124),
    secimRenk: Color(0xFFF7F1E3),
    desen: 'hilal',
    koyu: false,
  ),
  const KartTema(
    ad: 'Gökyüzü',
    ikon: Icons.cloud_outlined,
    gradient: [Color(0xFFC9A7E8), Color(0xFFF3C8A8)],
    metin: Color(0xFF31224A),
    arapca: Color(0xFF5B2A5E),
    kaynak: Color(0xFF5B4A6E),
    ornament: Color(0x99FFFFFF),
    filigran: Color(0x9931224A),
    secimRenk: Color(0xFFD9B9E2),
    desen: 'gokyuzu',
    camEfekti: true,
    koyu: false,
  ),
];

enum KartFormat { hikaye, kare }

extension KartFormatUzanti on KartFormat {
  double get oran => switch (this) {
        KartFormat.hikaye => 9 / 16,
        KartFormat.kare => 1,
      };

  String get ad => switch (this) {
        KartFormat.hikaye => 'Hikaye (9:16)',
        KartFormat.kare => 'Kare (1:1)',
      };

      IconData get ikon => switch (this) {
        KartFormat.hikaye => Icons.crop_portrait,
        KartFormat.kare => Icons.crop_square,
      };
}
