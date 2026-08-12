import 'package:flutter/material.dart';

import '../services/renkler.dart';

/// Hatim duası sayfası. Metin (Arapça, okunuş ve Türkçe anlam) Diyanet'in
/// yayımladığı hatim duası esas alınarak uygulama içine sabit kodlanmıştır;
/// internet gerektirmez.
class HatimDuasiPage extends StatelessWidget {
  const HatimDuasiPage({super.key});

  static const _giris =
      "Kur'ân-ı Kerîm'i hatmeden kimse, Nâs sûresini bitirdikten sonra "
      "Fâtiha ve Bakara sûresinin ilk beş âyetini okur. Ardından kıbleye "
      "dönüp ellerini dua için açarak hatim duası yapar. Hatim sonrası dua "
      "etmek sünnettir ve duanın kabul edildiği zamanlardan biridir. Duanın "
      "sonunda \"el-Fâtiha\" denir ve Fâtiha sûresi okunur.";

  static const List<Map<String, String>> _bolumler = [
    {
      'arapca': 'أَلْحَمْدُ لِلَّٰهِ رَبِّ الْعَالَم۪ينَ وَالْعَاقِبَةُ لِلْمُتَّق۪ينَ وَلَا عُدْوَانَ إِلَّا عَلَى الظَّالِم۪ينَ وَالصَّلٰاةُ وَالسَّلٰامُ عَلٰى رَسُولِنَا مُحَمَّدٍ وَأٰلِه۪ وَصَحْبِه۪ٓ أَجْمَع۪ينَ',
      'okunus': "El-hamdü lillâhi Rabbil-'âlemîn. Vel-'âkibetü lil-müttekîn. Velâ 'udvâne illâ 'alezzalimîn. Ves-salâtü ves-selâmü 'alâ Rasûlinâ Muhammedin ve 'âlihî ve sahbihî ecme'în.",
      'anlam': "Âlemlerin Rabbi olan Allah'a hamd olsun. İyi sonuç müttakilerindir. Düşmanlık ancak zalimler içindir. Peygamberimiz Hz. Muhammed'e (s.a.s.), onun bütün ehl-i beytine ve ashabına salât ve selâm olsun.",
    },
    {
      'arapca': 'أَللَّٰهُمَّ رَبَّنَا يَا رَبَّنَا تَقَبَّلْ مِنَّا إِنَّكَ أَنْتَ السَّم۪يعُ الْعَل۪يمُ وَتُبْ عَلَيْنَا يَا مَوْلٰنَآ إِنَّكَ أَنْتَ التَّوَّابُ الرَّح۪يمُ وَاهْدِنَا وَوَفِّقْنَآ إِلَى الْحَقِّ وَإِلٰى طَر۪يقٍ مُسْتَق۪يمٍ بِبَرَكَةِ الْقُرْأٰنِ الْعَظ۪يمِ وَبِحُرْمَةِ مَنْ أَرْسَلْتَهُ رَحْمَةً لِلْعَالَم۪ينَ وَاعْفُ عَنَّا يَا كَر۪يمُ وَاعْفُ عَنَّا يَا رَح۪يمُ وَاغْفِرْ لَنَا ذُنُوبَنَا بِفَضْلِكَ وَجُودِكَ وَكَرَمِكَ يَآأَكْرَمَ الْاَكْرَم۪ينَ',
      'okunus': "Rabbenâ takabbel minnâ inneke ente's-semî'ul-'alîm. Ve tüb 'aleynâ yâ Mevlânâ inneke ente't-tevvâbür-Rahîm. Vehdinâ ve veffiknâ ilel-hakkı ve ilâ tarîkın müstekîm. Bi beraketil-Kur'ânil-'azîm. Ve bi hürmeti men erseltehû rahmeten lil-'âlemîn. Va'fü 'annâ yâ Kerîm. Va'fü 'annâ yâ Rahîm. Vağfir lenâ zünûbenâ bi fadlike ve cûdike ve keramike yâ ekramel-ekramîn.",
      'anlam': "Ey Rabbimiz! Bizden ibadetlerimizi kabul buyur! Şüphesiz ki sen her şeyi işiten ve her şeyi bilensin. Ey Mevlamız! Bizim tövbelerimizi kabul eyle! Şüphesiz ki sen tövbeleri çok kabul eden ve merhametli olansın. Bize hidayet ver! Hak yola ve sırat-ı müstakime ulaşmayı bizi muvaffak eyle! Yüce Kur'ân'ın hürmetine, âlemlere rahmet olarak gönderdiğin Peygamber hürmetine. Kerem sahibi Allah'ım, bizi affet. Rahîm olan Allah'ım, bizi affet. Lütfun, cömertliğin ve kereminle günahlarımızı bağışla, ey ikram edenlerin en keremlisi!",
    },
    {
      'arapca': 'أَللَّٰهُمَّ زَيِّنَّا بِز۪ينَةِ الْقُرْأٰنِ وَأَكْرِمْنَا بِكَرَامَةِ الْقُرْأٰنِ وَشَرِّفْنَا بِشَرَافَةِ الْقُرْأٰنِ وَأَلْبِسْنَا بِخِلْعَةِ الْقُرْأٰنِ وَأَدْخِلْنَا الْجَنَّةَ بِشَفَاعَةِ الْقُرْأٰنِ وَعَافِنَا مِنْ كُلِّ بَلٰٓاءِ الدُّنْيَا وَعَذَابِ الْاٰخِرَةِ بِحُرْمَةِ الْقُرْأٰنِ وَارْحَمْ جَم۪يعَ أُمَّةِ مُحَمَّدٍ يَا رَح۪يمُ يَا رَحْمٰنُ',
      'okunus': "Allâhümme zeyyinnâ bi zînetil-Kur'ân. Ve ekrimnâ bi kerâmetil-Kur'ân. Ve şerrifnâ bi şerâfetil-Kur'ân. Ve elbisnâ bi hil'atil-Kur'ân. Ve edhilnel-cennete bi şefâatil-Kur'ân. Ve 'âfinâ min külli belâid-dünyâ ve 'azâbil-âhirati bi hurmetil-Kur'ân. Verham cemî'a ümmet-i Muhammedin yâ Rahîmü yâ Rahmân.",
      'anlam': "Allah'ım! Bizi Kur'ân süsü ile süsle. Kur'ân ile bize ikram et. Kur'ân ile bizi şereflendir. Kur'ân elbisesini bize giydir. Kur'ân'ın şefaatıyla bizi cennetine koy. Kur'ân'ın hürmetine bizi dünya belâlarından ve âhiret azabından koru. Ey Rahîm, ey Rahmân! Muhammed ümmetinin tamamına merhamet et.",
    },
    {
      'arapca': 'أَللَّٰهُمَّ اجْعَلِ الْقُرْأٰنَ لَنَا فِي الدُّنْيَا قَر۪ينًا وَفِي الْقَبْرِ مُونِسًا وَفِي الْقِيَامَةِ شَف۪يعًا وَعَلَى الصِّرَاطِ نُورًا وَفِي الْجَنَّةِ رَف۪يقًا وَمِنَ النَّارِ سِتْرًا وَحِجَابًا وَإِلَى الْخَيْرَاتِ كُلِّهَا دَل۪يلًا وَإِمَامًا بِفَضْلِكَ وَجُودِكَ وَكَرَمِكَ يَآ أَكْرَمَ الْاَكْرَم۪ينَ وَيَآ أَرْحَمَ الرَّاحِم۪ينَ',
      'okunus': "Allâhümec'alil-Kur'âne lenâ fid-dünyâ karînâ. Ve fil-kabri mûnisâ. Ve fil-kıyâmeti şefî'ân ve 'ales-sırâti nûrâ. Ve ilel-cenneti rafîkâ. Ve minennâri sitran ve hicâbâ. Ve ilel-hayrâti küllihâ delîlen ve imâmâ. Bi fadlike ve cûdike ve keramike yâ ekramel-ekramîn ve yâ erhamer-râhimîn.",
      'anlam': "Allah'ım! Kur'ân'ı bize dünyada yoldaş, kabirde dost eyle. Kıyamet günü onu bize şefaatçi, sırat üzerinde nur eyle. Cennette bize refik eyle, cehennem ateşine karşı bize perde ve engel kıl. İhsanın, cömertliğin ve keremin ile onu bütün hayırlara delil ve imam eyle, ey ikram edenlerin en keremlisi, ey merhametlilerin en merhametlisi!",
    },
    {
      'arapca': 'أَللَّٰهُمَّ اهْدِنَا بِهِدَايَةِ الْقُرْأٰنِ وَنَجِّنَا مِنَ النّ۪يرَانِ بِكَرَامَةِ الْقُرْأٰنِ وَارْفَعْ دَرَجَاتِنَا بِفَض۪يلَةِ الْقُرْأٰنِ وَكَفِّرْ عَنَّا سَيِّأٰتِنَا بِتِلٰاوَةِ الْقُرْأٰنِ يَا ذَا الْفَضْلِ وَالْاِحْسَانِ',
      'okunus': "Allâhümmeh-dinâ bi hidâyetil-Kur'ân. Ve neccinâ minen-nîrâni bi kerâmetil-Kur'ân. Verfa' deracâtina bi fadîletil-Kur'ân. Ve keffir 'annâ seyyiâtinâ bi tilâvetil-Kur'ân. Yâ zel-fadli vel-ihsân.",
      'anlam': "Allah'ım! Kur'ân'ın hidayetiyle bize hidayet ver. Kur'ân'ın kerametiyle bizi ateşten kurtar. Kur'ân'ın faziletiyle derecelerimizi yükselt. Kur'ân tilavetiyle günahlarımızı ört. Ey lütuf ve ihsan sahibi!",
    },
    {
      'arapca': 'أَللَّٰهُمَّ طَهِّرْ قُلوُبَنَا وَاسْتُرْ عُيوُبَنَا وَاشْفِ مَرْضَانَا وَاقْضِ دُيُونَنَا وَارْفَعْ دَرَجَاتِنَا وَارْحَمْ أٰبَاءَنَا وَاغْفِرْ أُمَّهَاتِنَا وَأَصْلِحْ د۪ينَنَا وَدُنْيَانَا وَشَتِّتْ شَمْلَ أَعْدَائِنَا وَاحْفَظْ أَهْلَنَا وَأَمْوَالَنَا وَبِلَادَنَا مِنْ جِم۪يعِ الْاٰفَاتِ وَالْاَمْرَاضِ وَالْبَلٰايَا وَثَبِّتْ أَقْدَامَنَا وَانْصُرْنَا عَلَى الْقَوْمِ الْكَافِر۪ينَ بِحُرْمَةِ الْقُرْأٰنِ الْعَظ۪يمِ',
      'okunus': "Allâhümme tahhir kulûbenâ. Vestur 'uyûbenâ. Veşfi merdânâ. Vekdi duyûnenâ. Ve beyyid vücûhenâ. Verfa' deracâtina. Verham âbâenâ. Veğfir ümmehâtinâ. Ve eslih dînenâ ve dünyânâ. Ve şeddid şemle a'dâina. Vehfaz ehlenâ ve emvâlenâ ve bilâdenâ min cemî'l-âfâti ve'l-emrâdi ve'l-belâyâ. Ve sebbit akdâmenâ, ven-surnâ 'alel-kavmil-kâfirîn. Bi hurmetil-Kur'ânil-'azîm.",
      'anlam': "Allah'ım! Kalplerimizi temizle. Kusurlarımızı ört. Hastalarımıza şifa ver. Borçlarımızı ödemeye yardım et. Yüzlerimizi aydınlat. Derecelerimizi yükselt. Babalarımıza merhamet et, annelerimizi bağışla. Dinimizi ve dünyamızı ıslah et. Düşmanlarımızın saldırısını bertaraf eyle. Ailemizi, mallarımızı ve memleketimizi bütün afetlerden, hastalıklardan ve belâlardan koru. Ayaklarımızı sabit eyle, kâfir toplumlara karşı bize yardım et. Yüce Kur'ân'ın hürmetine.",
    },
    {
      'arapca': 'أَللَّٰهُمَّ بَلِّغْ ثَوَابَ مَا قَرَأْنَاهُ، وَنُورَ مَا تَلَوْنَاهُ، إِلٰى رُوحِ سَيِّدِنَا وَنَبِيِّنَا مُحَمَّدٍ صَلَّى اللّٰهُ تَعَالٰى عَلَيْهِ وَسَلَّمَ وَإِلٰٓى أَرْوَاحِ جَم۪يعِ الْاَنْبِيَاءِ وَالْمُرْسَل۪ينَ، صَلَوَاتُ اللّٰهِ وَسَلٰامُهُ عَلَيْهِمْ أَجْمَع۪ينَ وَإِلٰٓى أَرْوَاحِ اٰلِه۪، وَأَوْلٰادِه۪، وَأَزْوَاجِه۪، وَأَصْحَابِه۪، أَتْبَاعِه۪، وَجَم۪يعِ ذُرِّيَّاتِه۪ رِضْوَانُ اللّٰهِ تَعَالٰى عَلَيْهِمْ أَجْمَع۪ينَ وَإِلٰٓى أَرْوَاحِ اٰبَائِنَا، وَأُمَّهَاتِنَا، وَإِخْوَانِنَا وَأَخَوَاتِنَا، وَأَوْلَادِنَا، وَأَقْرِبَائِنَا، وَأَحِبَّائِنَا، وَأَصْدِقَائِنَا، وَأَسَات۪يذِنَا، وَمَشَايِخِنَا، وَلِمَنْ كَانَ لَهُ حَقٌّ عَلَيْنَا وَإِلٰي أَرْوَاحِ جَم۪يعِ الْمُؤْمِن۪ينَ وَالْمُؤْمِنَاتِ، وَالْمُسْلِم۪ينَ وَالْمُسْلِمَاتِ، أَلْاَحْيَاءِ مِنْهُمْ وَالْاَمْوَاتِ يَا قَاضِيَ الْحَاجَاتِ وَيَا مُج۪يبَ الدَّعَوَاتِ رَبَّنَآ اٰتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْاٰخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ أَللَّٰهُمَّ رَبَّنَا اغْفِرْ ل۪ي وَلِوَالِدَيَّ وَلِلْمُؤْمِن۪ينَ يَوْمَ يَقُومُ الْحِسَابُ',
      'okunus': "Allâhümme belliğ sevâbe mâ kara'nâhü. Ve nevvir mâ televnâhü ilâ rûhi seyyidinâ Muhammedin sallâllahü te'âlâ 'aleyhi ve sellem. Ve ilâ ervâhi cemî'ı ihvânihî minel-enbiyâi vel-murselîn. Salevâtullâhi ve selâmühû 'aleyhim ecma'în. Ve ilâ ervâhi âlihî ve evlâdihî ve ezvâcihî ve ashâbihî ve etbâ'ıhî ve cemîı' zürriyyâtihî rıdvânullâhi te'âlâ 'aleyhim ecma'în. Ve ilâ ervâhi âbâinâ ve ümmehâtinâ ve ihvâninâ ve ehavâtinâ ve evlâdina ve akribâinâ ve ehibbâinâ ve asdikâinâ ve esâtîzinâ ve limen kâne lehû hakkun 'aleynâ ve li cemî'ıl-mü'minîne vel-mü'minâti vel-müslimîne vel-müslimâti, el-ahyâi minhüm vel-emvâti. Yâ kâdiyel-hâcâti! Yâ mücîbed-d'avâti! İstecib du'âenâ bi rahmetike yâ erhamer-râhimîn.",
      'anlam': "Allah'ım! Okuduğumuz ve tilavet ettiğimiz Kur'ân'ın sevabını ve nurunu Efendimiz Hz. Muhammed'in (s.a.s.), bütün peygamberlerin, onun ehl-i beytinin, evladının, hanımlarının, ashabının, tâbiinin ve bütün zürriyetinin ruhlarına ulaştır. Babalarımızın, annelerimizin, kardeşlerimizin, evlatlarımızın, akrabalarımızın, sevdiklerimizin, dostlarımızın, hocalarımızın, üzerimizde hakkı olanların ve bütün mümin erkeklerin, mümin kadınların, Müslüman erkeklerin ve Müslüman kadınların — hayatta olanlarının ve vefat etmişlerinin — ruhlarına ulaştır. Ey ihtiyaçları gideren! Ey dualara icabet eden! Rahmetinle duamızı kabul eyle, ey merhametlilerin en merhametlisi!",
    },
    {
      'arapca': 'سُبْحَانَ رَبِّكَ رَبِّ الْعِزَّةِ عَمَّا يَصِفُونَ وَسَلَامٌ عَلَى الْمُرْسَل۪ينَ وَالْحَمْدُ لِلّٰهِ رَبِّ الْعَالَم۪ينَ',
      'okunus': "Sübhâne Rabbike Rabbil-'ızzeti 'ammâ yasıfûn. Ve selâmün 'alel-mürselîn. Vel-hamdü lillâhi Rabbil-'âlemîn.",
      'anlam': "Senin Rabbin, onların niteledikleri şeylerden uzaktır; kudret ve şeref sahibi olan Rab'dir. Peygamberlere selâm olsun. Âlemlerin Rabbi olan Allah'a hamd olsun.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text(
          'Hatim Duası',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _girisKarti(),
          const SizedBox(height: 14),
          for (var i = 0; i < _bolumler.length; i++) ...[
            _bolumKarti(i),
            if (i < _bolumler.length - 1) const SizedBox(height: 12),
          ],
          const SizedBox(height: 14),
          _bitisKarti(),
        ],
      ),
    );
  }

  Widget _girisKarti() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: Renkler.vurgu, width: 3)),
      ),
      child: const Text(
        _giris,
        style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
      ),
    );
  }

  Widget _bolumKarti(int index) {
    final bolum = _bolumler[index];
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.cerceve2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bolum['arapca']!,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              height: 1.9,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            bolum['okunus']!,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 13,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(color: Colors.white12),
          const SizedBox(height: 8),
          Text(
            'ANLAMI',
            style: TextStyle(
              color: Renkler.vurgu,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            bolum['anlam']!,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bitisKarti() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.35)),
      ),
      child: const Row(
        children: [
          Icon(Icons.auto_stories, color: Colors.white70, size: 22),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Duadan sonra "el-Fâtiha" denir ve Fâtiha sûresi okunarak '
              'hatim duası tamamlanır.',
              style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}