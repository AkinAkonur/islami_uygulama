import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../services/renkler.dart';

/// Hatim duası sayfası. Metin (Arapça, okunuş ve Türkçe anlam) Diyanet'in
/// yayımladığı hatim duası esas alınarak uygulama içine sabit kodlanmıştır;
/// internet gerektirmez. "Hatim Duasını Oku" butonu cihazın TTS motoruyla
/// duayı bölüm bölüm seslendirir; okunan bölüm ekranda vurgulanır ve
/// otomatik olarak ekrana kaydırılır (takip ederek okuma).
class HatimDuasiPage extends StatefulWidget {
  const HatimDuasiPage({super.key});

  @override
  State<HatimDuasiPage> createState() => _HatimDuasiPageState();
}

class _HatimDuasiPageState extends State<HatimDuasiPage> {
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

  static const _bitis =
      'Duadan sonra "el-Fâtiha" denir ve Fâtiha sûresi okunarak '
      'hatim duası tamamlanır.';

  final FlutterTts _tts = FlutterTts();
  final ScrollController _kaydirici = ScrollController();
  final List<GlobalKey> _bolumAnahtarlari =
      List.generate(_bolumler.length, (_) => GlobalKey());

  bool _okuyor = false;
  int? _aktifBolum;
  bool _arapca = false;
  String? _ttsHata;

  @override
  void initState() {
    super.initState();
    _ttsKur();
  }

  @override
  void dispose() {
    _tts.stop();
    _kaydirici.dispose();
    super.dispose();
  }

  /// TTS olaylarını bağlar. Bölüm bitince [setCompletionHandler] sayesinde
  /// sıradaki bölüme geçilir; böylece bölüm bölüm okuma cihazın motorunun
  /// gerçek "okuma bitti" olayına dayanır ve her platformda kararlıdır.
  void _ttsKur() {
    _tts.awaitSpeakCompletion(false);
    _tts.setCompletionHandler(() async {
      if (!mounted || !_okuyor) return;
      _ilerle();
    });
    _tts.setCancelHandler(() {
      if (mounted && _okuyor) setState(() => _okuyor = false);
    });
    _tts.setErrorHandler((dynamic msg) {
      if (!mounted) return;
      setState(() {
        _okuyor = false;
        _ttsHata = 'Ses okunamadı: $msg';
      });
    });
  }

  /// Okunan bölüm bittikten sonra sıradaki bölüme geçer (ya da tamamlar).
  void _ilerle() {
    final sira = (_aktifBolum ?? 0) + 1;
    if (sira >= _bolumler.length) {
      setState(() {
        _okuyor = false;
        _aktifBolum = null;
        _ttsHata = null;
      });
      return;
    }
    setState(() {
      _aktifBolum = sira;
      _ttsHata = null;
    });
    _kaydir(sira);
    _sesOku(sira);
  }

  /// Dua seslendirmesini [_baslangic] numaralı bölümden başlatır (null ise
  /// kaldığı yerden ya da baştan).
  Future<void> _baslat(int? baslangic) async {
    if (_okuyor) return;
    final sira = baslangic ?? _aktifBolum ?? 0;
    setState(() {
      _okuyor = true;
      _aktifBolum = sira;
      _ttsHata = null;
    });
    _kaydir(sira);
    await _sesOku(sira);
  }

  /// Tek bir bölümü seslendirir. İstenen dil yoksa cihazdaki mevcut bir dile
  /// düşer; hiç ses yoksa kullanıcıya açıklayıcı hata gösterilir.
  Future<void> _sesOku(int index) async {
    if (!mounted) return;
    final bolum = _bolumler[index];
    final metin = _arapca ? bolum['arapca']! : bolum['okunus']!;
    try {
      var dil = _arapca ? 'ar' : 'tr-TR';
      final durum = await _tts.setLanguage(dil);
      if (_sonucYok(durum)) {
        dil = await _yedekDil();
        if (dil.isEmpty) {
          if (mounted) {
            setState(() => _ttsHata =
                'Cihazınızda okuma ses yok. '
                'Cihaz Ayarları > Giriş > Metin okuma alanından bir ses kurun.');
          }
          return;
        }
        await _tts.setLanguage(dil);
      }
      await _tts.setSpeechRate(0.5);
      final sonuc = await _tts.speak(metin);
      if (_sonucYok(sonuc)) {
        if (mounted) {
          setState(() => _ttsHata = 'Ses okunamadı: cihazda ses bulunamadı.');
        }
      }
    } catch (e) {
      if (mounted) setState(() => _ttsHata = 'Ses okunamadı: $e');
    }
  }

  /// TTS yöntemlerinden gelen hata değerlerini esnek biçimde tanır.
  /// Dikkat: `speak` Android'de "kuyruğa alındı" anlamında 0, iOS'te başarı
  /// anlamında 1 döner; ikisi de hata DEĞİLDİR. Hata yalnızca Android'de
  /// `setLanguage`'in döndürdüğü `false` ve bazı platformlardaki -1'dir.
  bool _sonucYok(dynamic sonuc) =>
      sonuc == -1 ||
      sonuc == false ||
      sonuc == 'false' ||
      sonuc == '-1';

  /// Cihazda tercih edilen dil için bir eşleşme bulur; hiç uygun ses yoksa
  /// son çare olarak İngilizce sesle okutur, o da yoksa boş döner.
  Future<String> _yedekDil() async {
    var diller = const <String>[];
    try {
      final ham = await _tts.getLanguages;
      if (ham is List) {
        diller = ham.map((e) => e.toString()).toList();
      } else if (ham != null && ham.toString().isNotEmpty) {
        diller = ham.toString().split(',');
      }
    } catch (_) {}
    final hedefler = _arapca ? ['ar', 'arab'] : ['tr', 'turk'];
    for (final h in hedefler) {
      for (final d in diller) {
        if (d.toLowerCase().contains(h)) return d;
      }
    }
    // İstenen dilde ses yoksa İngilizce sesle okut (çoğu cihazda kurulu).
    for (final d in diller) {
      final k = d.toLowerCase();
      if (k.contains('en') && (k.contains('us') || k.contains('gb'))) return d;
    }
    for (final d in diller) {
      if (d.toLowerCase() == 'en') return d;
    }
    return '';
  }

  /// Okumayı duraklatır (kaldığı bölümden "Devam Et" ile sürdürülebilir).
  void _duraklat() {
    _tts.stop();
    setState(() => _okuyor = false);
  }

  /// Okumayı tamamen durdurur ve başlangıca döner.
  void _durdur() {
    _tts.stop();
    setState(() {
      _okuyor = false;
      _aktifBolum = null;
      _ttsHata = null;
    });
  }

  void _kaydir(int index) {
    final ctx = _bolumAnahtarlari[index].currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      alignment: 0.2,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

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
        actions: [
          IconButton(
            tooltip: _okuyor ? 'Durdur' : 'Hatim Duasını Oku',
            onPressed: _okuyor ? _duraklat : () => _baslat(null),
            icon: Icon(
              _okuyor ? Icons.stop_circle_outlined : Icons.play_circle_outline,
              color: Renkler.vurgu,
              size: 26,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: _kontrolKarti(),
          ),
          Expanded(
            child: ListView(
              controller: _kaydirici,
              padding: const EdgeInsets.all(16),
              children: [
                _girisKarti(),
                const SizedBox(height: 14),
                for (var i = 0; i < _bolumler.length; i++) ...[
                  _bolumKarti(i, _okuyor && _aktifBolum == i),
                  if (i < _bolumler.length - 1) const SizedBox(height: 12),
                ],
                const SizedBox(height: 14),
                _bitisKarti(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Başlat/durdur kontrolleri ve okuma ilerlemesi kartı.
  Widget _kontrolKarti() {
    final aktif = _aktifBolum;
    final toplam = _bolumler.length;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _okuyor ? Icons.graphic_eq : Icons.play_circle_outline,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Hatim Duasını Oku',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Okunuşla'),
                selected: !_arapca,
                onSelected:
                    _okuyor ? null : (_) => setState(() => _arapca = false),
              ),
              ChoiceChip(
                label: const Text('Arapça'),
                selected: _arapca,
                onSelected:
                    _okuyor ? null : (_) => setState(() => _arapca = true),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_okuyor) ...[
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: ((aktif ?? 0) + 1) / toplam,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${(aktif ?? 0) + 1} / $toplam',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
          if (_ttsHata != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                _ttsHata!,
                style: const TextStyle(color: Colors.orangeAccent, fontSize: 12),
              ),
            ),
          if (_okuyor)
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _duraklat,
                    icon: const Icon(Icons.pause),
                    label: const Text('Duraklat'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54),
                    ),
                    onPressed: _durdur,
                    icon: const Icon(Icons.stop),
                    label: const Text('Durdur'),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _baslat(null),
                    icon: Icon(
                      aktif == null ? Icons.play_arrow : Icons.play_circle_outline,
                    ),
                    label: Text(aktif == null ? 'Hatim Duasını Oku' : 'Devam Et'),
                  ),
                ),
                if (aktif != null) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white54),
                      ),
                      onPressed: _durdur,
                      icon: const Icon(Icons.replay),
                      label: const Text('Baştan'),
                    ),
                  ),
                ],
              ],
            ),
          const SizedBox(height: 10),
          const Text(
            'Okuma başladığında okunan bölüm vurgulanır ve ekran otomatik '
            'olarak takip eder. Dilediğin bölüme dokunup oradan da '
            'dinleyebilirsin.',
            style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.4),
          ),
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

  Widget _bolumKarti(int index, bool aktif) {
    final bolum = _bolumler[index];
    return GestureDetector(
      onTap: _okuyor ? null : () => _baslat(index),
      child: AnimatedContainer(
        key: _bolumAnahtarlari[index],
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: aktif ? Renkler.seciliYuzey : Renkler.kart,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: aktif ? Renkler.vurgu : Renkler.cerceve2,
            width: aktif ? 1.6 : 1,
          ),
          boxShadow: aktif
              ? [
                  BoxShadow(
                    color: Renkler.vurgu.withValues(alpha: 0.25),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (aktif) ...[
              Row(
                children: [
                  const Icon(Icons.graphic_eq,
                      color: Colors.greenAccent, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    'Şu an okunuyor',
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${index + 1} / ${_bolumler.length}',
                    style: TextStyle(color: Renkler.acikVurgu, fontSize: 11),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
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
            if (!_okuyor) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Buradan dinle',
                    style: TextStyle(
                      color: Renkler.vurgu.withValues(alpha: 0.85),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.play_circle_outline,
                    color: Renkler.vurgu.withValues(alpha: 0.85),
                    size: 16,
                  ),
                ],
              ),
            ],
          ],
        ),
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
              _bitis,
              style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}