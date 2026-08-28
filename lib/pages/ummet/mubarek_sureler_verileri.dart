/// Mübarek sureler ve dualar verisi.
///
/// Her öğe Arapça metni, okunuşu (latin/transliterasyon, TTS ile sesli
/// okunur) ve Türkçe manasını taşır. Metinler Diyanet İşleri Başkanlığı
/// meal/transkripsiyon esas alınarak hazırlanmıştır; internet gerektirmez.
class MubarekSureVerisi {
  final String baslik;
  final String baslikEn;
  final String arapca;
  final String okunus;
  final String mana;
  final String meal;
  final String reciter;
  final String audioUrl;

  const MubarekSureVerisi({
    required this.baslik,
    required this.baslikEn,
    required this.arapca,
    required this.okunus,
    required this.mana,
    required this.meal,
    this.reciter = 'Kâbe İmamı Mâhir el-Muaykılî',
    this.audioUrl = '',
  });
}

const List<MubarekSureVerisi> mubarekSureler = [
  MubarekSureVerisi(
    baslik: 'Yâsîn Suresi',
    baslikEn: 'Surah Ya-Sin',
    audioUrl: 'https://server12.mp3quran.net/maher/036.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
يس
وَالْقُرْآنِ الْحَكِيمِ
إِنَّكَ لَمِنَ الْمُرْسَلِينَ
عَلَىٰ صِرَاطٍ مُسْتَقِيمٍ
تَنْزِيلَ الْعَزِيزِ الرَّحِيمِ
لِتُنْذِرَ قَوْمًا مَا أُنْذِرَ آبَاؤُهُمْ فَهُمْ غَافِلُونَ
لَقَدْ حَقَّ الْقَوْلُ عَلَىٰ أَكْثَرِهِمْ فَهُمْ لَا يُؤْمِنُونَ
إِنَّا جَعَلْنَا فِي أَعْنَاقِهِمْ أَغْلَالًا فَهِيَ إِلَى الْأَذْقَانِ فَهُمْ مُقْمَحُونَ
وَجَعَلْنَا مِنْ بَيْنِ أَيْدِيهِمْ سَدًّا وَمِنْ خَلْفِهِمْ سَدًّا فَأَغْشَيْنَاهُمْ فَهُمْ لَا يُبْصِرُونَ
وَسَوَاءٌ عَلَيْهِمْ أَأَنْذَرْتَهُمْ أَمْ لَمْ تُنْذِرْهُمْ لَا يُؤْمِنُونَ
إِنَّمَا تُنْذِرُ مَنِ اتَّبَعَ الذِّكْرَ وَخَشِيَ الرَّحْمَٰنَ بِالْغَيْبِ ۖ فَبَشِّرْهُ بِمَغْفِرَةٍ وَأَجْرٍ كَرِيمٍ
إِنَّا نَحْنُ نُحْيِي الْمَوْتَىٰ وَنَكْتُبُ مَا قَدَّمُوا وَآثَارَهُمْ ۚ وَكُلَّ شَيْءٍ أَحْصَيْنَاهُ فِي إِمَامٍ مُبِينٍ
وَاضْرِبْ لَهُمْ مَثَلًا أَصْحَابَ الْقَرْيَةِ إِذْ جَاءَهَا الْمُرْسَلُونَ
إِذْ أَرْسَلْنَا إِلَيْهِمُ اثْنَيْنِ فَكَذَّبُوهُمَا فَعَزَّزْنَا بِثَالِثٍ فَقَالُوا إِنَّا إِلَيْكُمْ مُرْسَلُونَ
قَالُوا مَا أَنْتُمْ إِلَّا بَشَرٌ مِثْلُنَا وَمَا أَنْزَلَ الرَّحْمَٰنُ مِنْ شَيْءٍ إِنْ أَنْتُمْ إِلَّا تَكْذِبُونَ
قَالُوا رَبُّنَا يَعْلَمُ إِنَّا إِلَيْكُمْ لَمُرْسَلُونَ
وَمَا عَلَيْنَا إِلَّا الْبَلَاغُ الْمُبِينُ
قَالُوا إِنَّا تَطَيَّرْنَا بِكُمْ ۖ لَئِنْ لَمْ تَنْتَهُوا لَنَرْجُمَنَّكُمْ وَلَيَمَسَّنَّكُمْ مِنَّا عَذَابٌ أَلِيمٌ
قَالُوا طَائِرُكُمْ مَعَكُمْ ۚ أَئِنْ ذُكِّرْتُمْ ۚ بَلْ أَنْتُمْ قَوْمٌ مُسْرِفُونَ
وَجَاءَ مِنْ أَقْصَى الْمَدِينَةِ رَجُلٌ يَسْعَىٰ قَالَ يَا قَوْمِ اتَّبِعُوا الْمُرْسَلِينَ
اتَّبِعُوا مَنْ لَا يَسْأَلُكُمْ أَجْرًا وَهُمْ مُهْتَدُونَ
وَمَا لِيَ لَا أَعْبُدُ الَّذِي فَطَرَنِي وَإِلَيْهِ تُرْجَعُونَ
أَأَتَّخِذُ مِنْ دُونِهِ آلِهَةً إِنْ يُرِدْنِ الرَّحْمَٰنُ بِضُرٍّ لَا تُغْنِ عَنِّي شَفَاعَتُهُمْ شَيْئًا وَلَا يُنْقِذُونِ
إِنِّي إِذًا لَفِي ضَلَالٍ مُبِينٍ
إِنِّي آمَنْتُ بِرَبِّكُمْ فَاسْمَعُونِ
قِيلَ ادْخُلِ الْجَنَّةَ ۖ قَالَ يَا لَيْتَ قَوْمِي يَعْلَمُونَ
بِمَا غَفَرَ لِي رَبِّي وَجَعَلَنِي مِنَ الْمُكْرَمِينَ
وَمَا أَنْزَلْنَا عَلَىٰ قَوْمِهِ مِنْ بَعْدِهِ مِنْ جُنْدٍ مِنَ السَّمَاءِ وَمَا كُنَّا مُنْزِلِينَ
إِنْ كَانَتْ إِلَّا صَيْحَةً وَاحِدَةً فَإِذَا هُمْ خَامِدُونَ
يَا حَسْرَةً عَلَى الْعِبَادِ ۚ مَا يَأْتِيهِمْ مِنْ رَسُولٍ إِلَّا كَانُوا بِهِ يَسْتَهْزِئُونَ
أَلَمْ يَرَوْا كَمْ أَهْلَكْنَا قَبْلَهُمْ مِنَ الْقُرُونِ أَنَّهُمْ إِلَيْهِمْ لَا يَرْجِعُونَ
وَإِنْ كُلٌّ لَمَّا جَمِيعٌ لَدَيْنَا مُحْضَرُونَ
وَآيَةٌ لَهُمُ الْأَرْضُ الْمَيْتَةُ أَحْيَيْنَاهَا وَأَخْرَجْنَا مِنْهَا حَبًّا فَمِنْهُ يَأْكُلُونَ
وَجَعَلْنَا فِيهَا جَنَّاتٍ مِنْ نَخِيلٍ وَأَعْنَابٍ وَفَجَّرْنَا فِيهَا مِنَ الْعُيُونِ
لِيَأْكُلُوا مِنْ ثَمَرِهِ وَمَا عَمِلَتْهُ أَيْدِيهِمْ ۖ أَفَلَا يَشْكُرُونَ
سُبْحَانَ الَّذِي خَلَقَ الْأَزْوَاجَ كُلَّهَا مِمَّا تُنْبِتُ الْأَرْضُ وَمِنْ أَنْفُسِهِمْ وَمِمَّا لَا يَعْلَمُونَ
وَآيَةٌ لَهُمُ اللَّيْلُ نَسْلَخُ مِنْهُ النَّهَارَ فَإِذَا هُمْ مُظْلِمُونَ
وَالشَّمْسُ تَجْرِي لِمُسْتَقَرٍّ لَهَا ۚ ذَٰلِكَ تَقْدِيرُ الْعَزِيزِ الْعَلِيمِ
وَالْقَمَرَ قَدَّرْنَاهُ مَنَازِلَ حَتَّىٰ عَادَ كَالْعُرْجُونِ الْقَدِيمِ
لَا الشَّمْسُ يَنْبَغِي لَهَا أَنْ تُدْرِكَ الْقَمَرَ وَلَا اللَّيْلُ سَابِقُ النَّهَارِ ۚ وَكُلٌّ فِي فَلَكٍ يَسْبَحُونَ
وَآيَةٌ لَهُمْ أَنَّا حَمَلْنَا ذُرِّيَّتَهُمْ فِي الْفُلْكِ الْمَشْحُونِ
وَخَلَقْنَا لَهُمْ مِنْ مِثْلِهِ مَا يَرْكَبُونَ
وَإِنْ نَشَأْ نُغْرِقْهُمْ فَلَا صَرِيخَ لَهُمْ وَلَا هُمْ يُنْقَذُونَ
إِلَّا رَحْمَةً مِنَّا وَمَتَاعًا إِلَىٰ حِينٍ
وَإِذَا قِيلَ لَهُمُ اتَّقُوا مَا بَيْنَ أَيْدِيكُمْ وَمَا خَلْفَكُمْ لَعَلَّكُمْ تُرْحَمُونَ
وَمَا تَأْتِيهِمْ مِنْ آيَةٍ مِنْ آيَاتِ رَبِّهِمْ إِلَّا كَانُوا عَنْهَا مُعْرِضِينَ
وَإِذَا قِيلَ لَهُمْ أَنْفِقُوا مِمَّا رَزَقَكُمُ اللَّهُ قَالَ الَّذِينَ كَفَرُوا لِلَّذِينَ آمَنُوا أَنُطْعِمُ مَنْ لَوْ يَشَاءُ اللَّهُ أَطْعَمَهُ إِنْ أَنْتُمْ إِلَّا فِي ضَلَالٍ مُبِينٍ
وَيَقُولُونَ مَتَىٰ هَٰذَا الْوَعْدُ إِنْ كُنْتُمْ صَادِقِينَ
مَا يَنْظُرُونَ إِلَّا صَيْحَةً وَاحِدَةً تَأْخُذُهُمْ وَهُمْ يَخِصِّمُونَ
فَلَا يَسْتَطِيعُونَ تَوْصِيَةً وَلَا إِلَىٰ أَهْلِهِمْ يَرْجِعُونَ
وَنُفِخَ فِي الصُّورِ فَإِذَا هُمْ مِنَ الْأَجْدَاثِ إِلَىٰ رَبِّهِمْ يَنْسِلُونَ
قَالُوا يَا وَيْلَنَا مَنْ بَعَثَنَا مِنْ مَرْقَدِنَا ۜ ۗ هَٰذَا مَا وَعَدَ الرَّحْمَٰنُ وَصَدَقَ الْمُرْسَلُونَ
إِنْ كَانَتْ إِلَّا صَيْحَةً وَاحِدَةً فَإِذَا هُمْ جَمِيعٌ لَدَيْنَا مُحْضَرُونَ
فَالْيَوْمَ لَا تُظْلَمُ نَفْسٌ شَيْئًا وَلَا تُجْزَوْنَ إِلَّا مَا كُنْتُمْ تَعْمَلُونَ
إِنَّ أَصْحَابَ الْجَنَّةِ الْيَوْمَ فِي شُغُلٍ فَاكِهُونَ
هُمْ وَأَزْوَاجُهُمْ فِي ظِلَالٍ عَلَى الْأَرَائِكِ مُتَّكِئُونَ
لَهُمْ فِيهَا فَاكِهَةٌ وَلَهُمْ مَا يَدَّعُونَ
سَلَامٌ قَوْلًا مِنْ رَبٍّ رَحِيمٍ
وَامْتَازُوا الْيَوْمَ أَيُّهَا الْمُجْرِمُونَ
أَلَمْ أَعْهَدْ إِلَيْكُمْ يَا بَنِي آدَمَ أَنْ لَا تَعْبُدُوا الشَّيْطَانَ ۖ إِنَّهُ لَكُمْ عَدُوٌّ مُبِينٌ
وَأَنِ اعْبُدُونِي ۚ هَٰذَا صِرَاطٌ مُسْتَقِيمٌ
وَلَقَدْ أَضَلَّ مِنْكُمْ جِبِلًّا كَثِيرًا ۖ أَفَلَمْ تَكُونُوا تَعْقِلُونَ
هَٰذِهِ جَهَنَّمُ الَّتِي كُنْتُمْ تُوعَدُونَ
اصْلَوْهَا الْيَوْمَ بِمَا كُنْتُمْ تَكْفُرُونَ
الْيَوْمَ نَخْتِمُ عَلَىٰ أَفْوَاهِهِمْ وَتُكَلِّمُنَا أَيْدِيهِمْ وَتَشْهَدُ أَرْجُلُهُمْ بِمَا كَانُوا يَكْسِبُونَ
وَلَوْ نَشَاءُ لَطَمَسْنَا عَلَىٰ أَعْيُنِهِمْ فَاسْتَبَقُوا الصِّرَاطَ فَأَنَّىٰ يُبْصِرُونَ
وَلَوْ نَشَاءُ لَمَسَخْنَاهُمْ عَلَىٰ مَكَانَتِهِمْ فَمَا اسْتَطَاعُوا مُضِيًّا وَلَا يَرْجِعُونَ
وَمَنْ نُعَمِّرْهُ نُنَكِّسْهُ فِي الْخَلْقِ ۖ أَفَلَا يَعْقِلُونَ
وَمَا عَلَّمْنَاهُ الشِّعْرَ وَمَا يَنْبَغِي لَهُ ۚ إِنْ هُوَ إِلَّا ذِكْرٌ وَقُرْآنٌ مُبِينٌ
لِيُنْذِرَ مَنْ كَانَ حَيًّا وَيَحِقَّ الْقَوْلُ عَلَى الْكَافِرِينَ
أَوَلَمْ يَرَوْا أَنَّا خَلَقْنَا لَهُمْ مِمَّا عَمِلَتْ أَيْدِينَا أَنْعَامًا فَهُمْ لَهَا مَالِكُونَ
وَذَلَّلْنَاهَا لَهُمْ فَمِنْهَا رَكُوبُهُمْ وَمِنْهَا يَأْكُلُونَ
وَلَهُمْ فِيهَا مَنَافِعُ وَمَشَارِبُ ۖ أَفَلَا يَشْكُرُونَ
وَاتَّخَذُوا مِنْ دُونِ اللَّهِ آلِهَةً لَعَلَّهُمْ يُنْصَرُونَ
لَا يَسْتَطِيعُونَ نَصْرَهُمْ وَهُمْ لَهُمْ جُنْدٌ مُحْضَرُونَ
فَلَا يَحْزُنْكَ قَوْلُهُمْ ۘ إِنَّا نَعْلَمُ مَا يُسِرُّونَ وَمَا يُعْلِنُونَ
أَوَلَمْ يَرَ الْإِنْسَانُ أَنَّا خَلَقْنَاهُ مِنْ نُطْفَةٍ فَإِذَا هُوَ خَصِيمٌ مُبِينٌ
وَضَرَبَ لَنَا مَثَلًا وَنَسِيَ خَلْقَهُ ۖ قَالَ مَنْ يُحْيِي الْعِظَامَ وَهِيَ رَمِيمٌ
قُلْ يُحْيِيهَا الَّذِي أَنْشَأَهَا أَوَّلَ مَرَّةٍ ۖ وَهُوَ بِكُلِّ خَلْقٍ عَلِيمٌ
الَّذِي جَعَلَ لَكُمْ مِنَ الشَّجَرِ الْأَخْضَرِ نَارًا فَإِذَا أَنْتُمْ مِنْهُ تُوقِدُونَ
أَوَلَيْسَ الَّذِي خَلَقَ السَّمَاوَاتِ وَالْأَرْضَ بِقَادِرٍ عَلَىٰ أَنْ يَخْلُقَ مِثْلَهُمْ ۚ بَلَىٰ وَهُوَ الْخَلَّاقُ الْعَلِيمُ
إِنَّمَا أَمْرُهُ إِذَا أَرَادَ شَيْئًا أَنْ يَقُولَ لَهُ كُنْ فَيَكُونُ
فَسُبْحَانَ الَّذِي بِيَدِهِ مَلَكُوتُ كُلِّ شَيْءٍ وَإِلَيْهِ تُرْجَعُونَ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Yâsîn.
Vel-Kur'ânil-hakîm.
İnneke leminel-mürselîn.
Alâ sırâtın müstekîm.
Tenzîlel-azîzir-rahîm.
Li-tünzira kavmen mâ ünzira âbâühüm fehüm gâfilûn.
Lekad hakkal-kavlü alâ ekserihim fehüm lâ yü'minûn.
İnnâ cealnâ fî a'nâkihim aglâlen fehiye ilel-ezkâni fehüm mukmehûn.
Ve cealnâ min beyni eydîhim sedden ve min halfihim sedden fe ağşeynâhüm fehüm lâ yübsirûn.
Ve sevâün aleyhim e enzertehüm em lem tünzirhüm lâ yü'minûn.
İnnemâ tünziru menittebeaz-zikra ve haşiyer-rahmâne bil-ğayb, fe beşşirhü bi-mağfiretin ve ecrin kerîm.
İnnâ nahnü nuhyil-mevtâ ve nektübü mâ kaddemû ve âsârahüm, ve külle şey'in ahsaynâhü fî imâmin mübîn.
Vadrib lehüm meselen ashâbel-karyeh, iz câehel-mürselûn.
İz erselnâ ileyhimüsneyni fe kezzebûhümâ, fe azzeznâ bi-sâlisin fe kâlû innâ ileyküm mürselûn.
Kâlû mâ entüm illâ beşerun mislünâ, ve mâ enzeler-rahmânü min şey', in entüm illâ tekzibûn.
Kâlû rabbünâ ya'lemü innâ ileyküm le-mürselûn.
Ve mâ aleynâ illel-belâğul-mübîn.
Kâlû innâ tetayyernâ biküm, lein lem tentehû le nercümenneküm ve le yemessenneküm minnâ azâbün elîm.
Kâlû tâirüküm meaküm, e-in zükkirtüm, bel entüm kavmün müsfirûn.
Ve câe min aksal-medîneti racülün yes'â, kâle yâ kavmittebiül-mürselîn.
İttebiû men lâ yes'elüküm ecran ve hüm mühtedûn.
Ve mâ liye lâ a'büdül-lezî fataranî ve ileyhi türceûn.
E etehizü min dûnihî âliheten, in yüridnir-rahmânü bi-durrin lâ tuğni annî şefâatühüm şey'en ve lâ yünkızûn.
İnnî izen le-fî dalâlin mübîn.
İnnî âmentü bi-rabbiküm fesmeûn.
Kîled-hulil-cenneh, kâle yâ leyte kavmî ya'lemûn.
Bimâ ğafera lî rabbî ve cealenî minel-mükramîn.
Ve mâ enzelnâ alâ kavmihî min ba'dihî min cündin mines-semâi ve mâ künnâ münzilîn.
İn kânet illâ sayhaten vâhıdeten fe izâ hüm hâmidûn.
Yâ hasreten alel-ibâd, mâ ye'tîhim min rasûlin illâ kânû bihî yestehziûn.
E lem yerev kem ehleknâ kablehüm minel-kurûni ennehüm ileyhim lâ yerciûn.
Ve in küllün lemmâ cemî'un ledeynâ muhdarûn.
Ve âyetün lehümül-ardul-meytetü ahyeynâhâ ve ahracnâ minhâ habben fe minhü ye'külûn.
Ve cealnâ fîhâ cennâtin min nahîlin ve a'nâb, ve feccernâ fîhâ minel-uyûn.
Li-ye'kulû min semerihî ve mâ amilet-hü eydîhim, e fe lâ yeşkürûn.
Sübhânel-lezî halekal-ezvâce küllehâ mimmâ tünbitül-ardu ve min enfüsihim ve mimmâ lâ ya'lemûn.
Ve âyetün lehümül-leylü neslehu minhün-nehâra fe izâ hüm muzlimûn.
Veş-şemsü tecrî li-müstekarrin lehâ, zâlike takdîrul-azîzil-alîm.
Vel-kamera kaddernâhü menâzile hattâ âde kel-urcûnil-kadîm.
Leş-şemsü yenbeğî lehâ en tüdrikel-kamere ve lel-leylü sâbikun-nehâr, ve küllün fî felekin yesbehûn.
Ve âyetün lehüm ennâ hamelnâ zürriyyetehüm fil-fülkil-meşhûn.
Ve halaknâ lehüm min mislihî mâ yerkebûn.
Ve in neşe' nuğrıkhüm fe lâ sarîha lehüm ve lâ hüm yünkazûn.
İllâ rahmeten minnâ ve metâan ilâ hîn.
Ve izâ kîle lehümüttekû mâ beyne eydîküm ve mâ halfeküm lealleküm türhamûn.
Ve mâ te'tîhim min âyetin min âyâti rabbihim illâ kânû anhâ mu'ridîn.
Ve izâ kîle lehüm enfikû mimmâ razakakümullâh, kâlel-lezîne keferû lillezîne âmenû e nut'ımü men lev yeşâüllâhü et'ameh, in entüm illâ fî dalâlin mübîn.
Ve yekûlûne metâ hâzel-va'dü in küntüm sâdikîn.
Mâ yenzurûne illâ sayhaten vâhıdeten te'huzühüm ve hüm yehissimûn.
Fe lâ yestatîûne tavsiyeten ve lâ ilâ ehlihim yerciûn.
Ve nüfiha fis-sûri fe izâ hüm minel-ecdâsi ilâ rabbihim yensilûn.
Kâlû yâ veylenâ men beasena min merkadinâ, hâzâ mâ veader-rahmânü ve sadakal-mürselûn.
İn kânet illâ sayhaten vâhıdeten fe izâ hüm cemî'un ledeynâ muhdarûn.
Fel-yevme lâ tuzlemü nefsün şey'en ve lâ tüczevne illâ mâ küntüm ta'melûn.
İnne ashâbel-cennetil-yevme fî şüğulin fâkihûn.
Hüm ve ezvâcühüm fî zılâlin alel-erâiki müttekiûn.
Lehüm fîhâ fâkihetün ve lehüm mâ yeddeûn.
Selâmün kavlen min rabbin rahîm.
Vemtezûl-yevme eyyühel-mücrimûn.
E lem a'hed ileyküm yâ benî âdeme en lâ ta'büdüş-şeytân, innehû leküm adüvvün mübîn.
Ve enı'büdûnî, hâzâ sırâtun müstekîm.
Ve lekad edalle minküm cibillen kesîrâ, e fe lem tekûnû ta'kılûn.
Hâzihî cehennemülletî küntüm tûadûn.
Islevhel-yevme bimâ küntüm tekfürûn.
El-yevme nahtimü alâ efvâhihim ve tükellimünâ eydîhim ve teşhedü ercülühüm bimâ kânû yeksibûn.
Ve lev neşâü le-tamesnâ alâ a'yünihim festebekus-sırâta fe ennâ yübsirûn.
Ve lev neşâü le-mesahnâhüm alâ mekânetihim fe mestetâû mudiyyen ve lâ yerciûn.
Ve men nüammirhü nünekkishü fil-halk, e fe lâ ya'kılûn.
Ve mâ allemnâhüş-şi'ra ve mâ yenbeğî leh, in hüve illâ zikrun ve Kur'ânün mübîn.
Li-yünzira men kâne hayyen ve yehikkal-kavlü alel-kâfirîn.
E ve lem yerev ennâ halaknâ lehüm mimmâ amilet eydînâ en'âmen fehüm lehâ mâlikûn.
Ve zellelnâhâ lehüm fe minhâ rekûbühüm ve minhâ ye'külûn.
Ve lehüm fîhâ menâfiu ve meşârib, e fe lâ yeşkürûn.
Vettehazû min dûnillâhi âliheten leallehüm yünsarûn.
Lâ yestetîûne nasrahüm ve hüm lehüm cündün muhdarûn.
Fe lâ yahzünke kavlühüm, innâ na'lemü mâ yüsirrûne ve mâ yu'linûn.
E ve lem yerel-insânü ennâ halaknâhü min nutfetin fe izâ hüve hasîmun mübîn.
Ve darebe lenâ meselen ve nesiye halkah, kâle men yuhyil-izâme ve hiye ramîm.
Kul yuhyîhel-lezî enşeehâ evvele merreh, ve hüve bi-külli halkın alîm.
El-lezî ceale leküm mineş-şeceril-ahdari nâran fe izâ entüm minhü tûkıdûn.
E ve leysel-lezî halekas-semâvâti vel-arda bi-kâdirin alâ en yahlüka mislehüm, belâ ve hüvel-hallâkul-alîm.
İnnemâ emruhû izâ erâde şey'en en yekûle lehû kün fe yekûn.
Fe sübhânel-lezî bi-yedihî melekûtü külli şey'in ve ileyhi türceûn.''',
    mana:
        '''Mekke döneminde inmiştir. Seksen üç âyettir. Resmî nüshada 36. sırada olup Kuran'ın yedinci büyük sûresidir. Hz. Peygamber (s.a.s.) "Her şeyin bir kalbi vardır; Kur'ân'ın kalbi de Yâsîn'dir" buyurmuştur. Sûrede; Kur'ân'ın vahiy olduğu, Hz. Peygamber'in hak peygamber olduğu, öldükten sonra dirilme ve hesap için herkesin Allah'ın huzurunda toplanacağı, müminlerle kâfirlerin âkıbetleri ve Allah'ın kudretinin delilleri anlatılır.''',
    meal:
        '''(1) Yâsîn. (2) Hikmet dolu Kur'ân'a andolsun ki, (3) Sen elbette gönderilmiş peygamberlerdensin. (4) Dosdoğru bir yol üzerindesin. (5) Bu Kur'ân, çok güçlü ve çok merhametli olan Allah'ın indirdiği bir kitaptır. (6) Ataları uyarılmamış, bu yüzden kendileri gaflet içinde kalmış bir toplumu uyarman için indirilmiştir. (7) Andolsun, onların çoğu hakkında o azap sözü gerçekleşmiştir; artık onlar iman etmezler. (8) Biz onların boyunlarına, çenelerine kadar varan halkalar geçirmişizdir; bu yüzden kafaları yukarı kalkık tutulmuştur. (9) Onların önlerine de arkalarına da set çektik ve gözlerini perdeledik; artık onlar görmezler. (10) Onları uyarsan da uyarmasan da onlar için birdir; iman etmezler. (11) Sen ancak zikre (Kur'ân'a) uyan ve görmeden Rahman'a saygı duyan kimseyi uyarabilirsin. İşte böylesini bir mağfiret ve güzel bir mükâfatla müjdele! (12) Şüphesiz biz ölüleri diriltiriz. Onların yaptıklarını ve bıraktıkları eserleri yazarız. Biz her şeyi apaçık bir kitapta (Levh-i Mahfuz'da) bir bir kaydetmişizdir. (13) Sen, onlara, o şehir halkını örnek ver; hani oraya elçiler gelmişti. (14) Biz onlara iki elçi göndermiştik; onları yalanladılar. Üçüncüsüyle de onları destekledik. Elçiler: "Biz size gönderilmiş elçileriz" dediler. (15) Onlar: "Siz de ancak bizim gibi birer insansınız. Rahman hiçbir şey indirmedi. Siz sadece yalan söylüyorsunuz" dediler. (16) Elçiler: "Rabbimiz bilir ki, biz gerçekten size gönderilmiş elçileriz. (17) Bizim üzerimize düşen, sadece apaçık olan tebliğdir" dediler. (18) Şehir halkı: "Doğrusu biz sizin yüzünüzden uğursuzluğa uğradık. Eğer bu işten vazgeçmezseniz sizi mutlaka taşlarız ve bizden size acı bir azap dokunur" dediler. (19) Elçiler: "Sizin uğursuzluğunuz kendinizdendir. Size öğüt verildiği için mi (uğursuzluğa uğradınız)? Hayır, siz aşırı giden bir kavimsiniz" dediler. (20) Şehrin en uzak yerinden bir adam koşarak geldi: "Ey kavmim! Size gönderilen elçilere uyun! (21) Sizden hiçbir ücret istemeyen bu elçilere uyun. Onlar doğru yoldadırlar. (22) Bana ne olmuş ki, beni yaratana ibadet etmeyeyim? O'na döndürüleceksiniz. (23) O'nu bırakıp da birtakım ilâhlar mı edineyim? Eğer Rahman bana bir zarar dilerse, onların şefaati bana hiçbir fayda sağlamaz ve beni kurtaramazlar. (24) O takdirde ben apaçık bir sapıklık içinde olurum. (25) Şüphesiz ben, sizin Rabbinize iman ettim. Artık beni dinleyin! (26) (Onu öldürdüler.) Kendisine: "Cennete gir!" denildi. O da: "Keşke kavmim bilseydi; (27) Rabbimin beni bağışladığını ve beni şerefli kimselerden kıldığını" dedi. (28) Biz onun arkasından kavmi üzerine gökten (azap için) bir ordu indirmedik; indirecek de değildik. (29) Sadece korkunç bir ses oldu; hepsi de sönüp gittiler. (30) Ey kullar üzerine olan yazıklar olsun! Onlara hiçbir peygamber gelmiyor ki, onunla alay etmesinler. (31) Kendilerinden önce nice nesilleri helâk ettiğimizi görmediler mi? Onlar artık kendilerine dönmeyeceklerdir. (32) Onların hepsi, şüphesiz, huzurumuza toplanacaklardır. (33) Ölü toprak onlar için bir delildir. Biz ona hayat verdik ve ondan taneler çıkardık; böylece ondan yiyorlar. (34) Orada hurmalıklardan ve üzüm bağlarından bahçeler var ettik; içlerinde pınarlar fışkırttık. (35) (Bunları,) onun ürününden ve kendi elleriyle yaptıklarından yesinler diye (yarattık). Hâlâ şükretmeyecekler mi? (36) Yerin bitirdiği şeylerden, kendilerinden ve daha bilmedikleri nice şeylerden bütün çiftleri yaratan Allah (her türlü eksiklikten) münezzehtir. (37) Gece de onlar için bir delildir. Biz ondan gündüzü sıyırıp çekeriz; bir de bakarsın karanlık içinde kalmışlardır. (38) Güneş de kendi yörüngesinde akıp gitmektedir. Bu, mutlak güç sahibi, hakkıyla bilen Allah'ın takdiridir. (39) Ay için de birtakım menziller takdir ettik. Nihayet o, eğrilmiş kuru hurma dalı gibi olur. (40) Ne güneş aya yetişebilir ne de gece gündüzü geçebilir. Her biri bir yörüngede yüzmektedir. (41) Onların zürriyetlerini dolu gemide taşımamız da onlar için bir delildir. (42) Onlar için buna benzer binecek şeyler de yarattık. (43) Eğer dilersek onları suda boğarız; kimse onların imdadına yetişemez ve onlar da kurtarılamazlar. (44) Ancak bizden bir rahmet olarak ve bir süreye kadar faydalanmaları için (kurtulurlar). (45) Onlara: "Önünüzdeki ve arkanızdaki şeylerden sakının ki size merhamet edilsin" denildiğinde (yüz çevirirler). (46) Onlara Rablerinin âyetlerinden bir âyet gelmeyiversin, mutlaka ondan yüz çevirmişlerdir. (47) Onlara: "Allah'ın size verdiği rızıktan hayra harcayın" denildiğinde, inkâr edenler iman edenlere: "Allah'ın dileseydi doyurabileceği kimseyi biz mi doyuracağız? Siz ancak apaçık bir sapıklık içindesiniz" derler. (48) Onlar: "Sözünüzde doğru iseniz, bu tehdit ne zaman gelecek?" diyorlar. (49) Onlar ancak, çekişip dururlarken kendilerini yakalayacak korkunç bir ses bekliyorlar. (50) (O zaman) ne bir vasiyet edebilirler ne de ailelerine dönebilirler. (51) Sûra üflenir; bir de bakarsın kabirlerden çıkıp Rablerine doğru akın ederler. (52) Onlar: "Eyvah bize! Bizi diriltip kaldıran kimdir? Bu, Rahman'ın vadettiği şeydir. Peygamberler doğru söylemişler" derler. (53) Sadece korkunç bir ses olur; bir de bakarsın hepsi huzurumuzda toplanmışlardır. (54) O gün hiçbir kimseye zerre kadar zulmedilmez. Size ancak yaptıklarınızın karşılığı verilir. (55) Şüphesiz cennetlikler, o gün nimetlerle meşgul olup sevinç içindedirler. (56) Onlar ve eşleri, gölgelerde koltuklara kurularak yaslanırlar. (57) Cennette onlar için meyveler ve arzu ettikleri her şey vardır. (58) Çok merhametli olan Rab'den bir de "selâm" vardır. (59) Ey suçlular! Bugün siz ayrılın! (60) Ey Âdemoğulları! Ben size: "Şeytana kulluk etmeyin. Çünkü o sizin apaçık bir düşmanınızdır. (61) Bana kulluk edin. Doğru yol budur" diye emretmedim mi? (62) Andolsun, o, sizden pek çok nesli saptırmıştı. Hiç düşünmüyor muydunuz? (63) İşte bu, size vaat edilen cehennemdir. (64) İnkâr ettiğiniz için bugün oraya girin. (65) O gün onların ağızlarını mühürleriz; elleri bize konuşur, ayakları da kazandıklarına şahitlik eder. (66) Eğer dileseydik onların gözlerini büsbütün kör ederdik. O zaman yola düşmek için didinirlerdi de nasıl göreceklerdi? (67) Eğer dileseydik onları oldukları yerde şekillerine çevirirdik de ne ileri gidebilir ne de geri dönebilirlerdi. (68) Kime uzun ömür verirsek, onun yaratılışını tersine çeviririz (gücünü azaltırız). Hiç düşünmüyorlar mı? (69) Biz ona şiir öğretmedik; ona yaraşmaz da. O, sadece bir öğüt ve apaçık bir Kur'ân'dır. (70) Diri olanları uyarması ve kâfirler hakkındaki o sözün gerçekleşmesi için (indirilmiştir). (71) Ellerimizin yaptığı (yarattığı) şeylerden kendileri için birçok hayvan yarattığımızı görmediler mi? Onlar bu hayvanlara sahip olmuşlardır. (72) Onları, hayvanlara boyun eğdirdik. Binek olarak bindikleri ve yedikleri de vardır. (73) Onlarda kendileri için daha nice faydalar ve içecekler vardır. Hâlâ şükretmiyorlar mı? (74) Yardım göreceklerini umarak Allah'ı bırakıp başka ilâhlar edindiler. (75) O ilâhlar, onlara yardım edemezler. Aksine onlar, bunların askerleridir (bunlar için hazırlanmışlardır). (76) O hâlde onların sözleri seni üzmesin. Şüphesiz biz, onların gizlediklerini de açığa vurduklarını da biliyoruz. (77) İnsan, kendisini bir nutfeden yarattığımızı görmedi mi ki, şimdi o apaçık bir düşman kesilmiştir. (78) O, kendi yaratılışını unutup bize karşı misal getirmektedir: "Çürümüş kemikleri kim diriltecek?" diyor. (79) De ki: "Onları ilk defa yaratan diriltecektir. O, her yaratmayı hakkıyla bilendir. (80) O, sizin için yeşil ağaçtan ateş var etmiştir; şimdi siz ondan yakıp duruyorsunuz. (81) Gökleri ve yeri yaratan, onların benzerlerini yaratmaya kadir değil midir? Evet, elbette kadirdir. O, hakkıyla yaratandır, hakkıyla bilendir. (82) Bir şeyi dilediği zaman O'nun emri yalnızca: "Ol!" demesidir; o da hemen oluverir. (83) Her şeyin mülkü (hükümranlığı) elinde olan Allah, her türlü noksanlıktan münezzehtir. Siz yalnız O'na döndürüleceksiniz.''',
  ),
  MubarekSureVerisi(
    baslik: 'Mülk Suresi',
    baslikEn: 'Surah Al-Mulk',
    audioUrl: 'https://server12.mp3quran.net/maher/067.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
تَبَارَكَ الَّذِي بِيَدِهِ الْمُلْكُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ
الَّذِي خَلَقَ الْمَوْتَ وَالْحَيَاةَ لِيَبْلُوَكُمْ أَيُّكُمْ أَحْسَنُ عَمَلًا ۚ وَهُوَ الْعَزِيزُ الْغَفُورُ
الَّذِي خَلَقَ سَبْعَ سَمَاوَاتٍ طِبَاقًا ۖ مَا تَرَىٰ فِي خَلْقِ الرَّحْمَٰنِ مِنْ تَفَاوُتٍ ۖ فَارْجِعِ الْبَصَرَ هَلْ تَرَىٰ مِنْ فُطُورٍ
ثُمَّ ارْجِعِ الْبَصَرَ كَرَّتَيْنِ يَنْقَلِبْ إِلَيْكَ الْبَصَرُ خَاسِئًا وَهُوَ حَسِيرٌ
وَلَقَدْ زَيَّنَّا السَّمَاءَ الدُّنْيَا بِمَصَابِيحَ وَجَعَلْنَاهَا رُجُومًا لِلشَّيَاطِينِ ۖ وَأَعْتَدْنَا لَهُمْ عَذَابَ السَّعِيرِ
وَلِلَّذِينَ كَفَرُوا بِرَبِّهِمْ عَذَابُ جَهَنَّمَ ۖ وَبِئْسَ الْمَصِيرُ
إِذَا أُلْقُوا فِيهَا سَمِعُوا لَهَا شَهِيقًا وَهِيَ تَفُورُ
تَكَادُ تَمَيَّزُ مِنَ الْغَيْظِ ۖ كُلَّمَا أُلْقِيَ فِيهَا فَوْجٌ سَأَلَهُمْ خَزَنَتُهَا أَلَمْ يَأْتِكُمْ نَذِيرٌ
قَالُوا بَلَىٰ قَدْ جَاءَنَا نَذِيرٌ فَكَذَّبْنَا وَقُلْنَا مَا نَزَّلَ اللَّهُ مِنْ شَيْءٍ إِنْ أَنْتُمْ إِلَّا فِي ضَلَالٍ كَبِيرٍ
وَقَالُوا لَوْ كُنَّا نَسْمَعُ أَوْ نَعْقِلُ مَا كُنَّا فِي أَصْحَابِ السَّعِيرِ
فَاعْتَرَفُوا بِذَنْبِهِمْ فَسُحْقًا لِأَصْحَابِ السَّعِيرِ
إِنَّ الَّذِينَ يَخْشَوْنَ رَبَّهُمْ بِالْغَيْبِ لَهُمْ مَغْفِرَةٌ وَأَجْرٌ كَبِيرٌ
وَأَسِرُّوا قَوْلَكُمْ أَوِ اجْهَرُوا بِهِ ۖ إِنَّهُ عَلِيمٌ بِذَاتِ الصُّدُورِ
أَلَا يَعْلَمُ مَنْ خَلَقَ وَهُوَ اللَّطِيفُ الْخَبِيرُ
هُوَ الَّذِي جَعَلَ لَكُمُ الْأَرْضَ ذَلُولًا فَامْشُوا فِي مَنَاكِبِهَا وَكُلُوا مِنْ رِزْقِهِ ۖ وَإِلَيْهِ النُّشُورُ
أَأَمِنْتُمْ مَنْ فِي السَّمَاءِ أَنْ يَخْسِفَ بِكُمُ الْأَرْضَ فَإِذَا هِيَ تَمُورُ
أَمْ أَمِنْتُمْ مَنْ فِي السَّمَاءِ أَنْ يُرْسِلَ عَلَيْكُمْ حَاصِبًا ۖ فَسَتَعْلَمُونَ كَيْفَ نَذِيرِ
وَلَقَدْ كَذَّبَ الَّذِينَ مِنْ قَبْلِهِمْ فَكَيْفَ كَانَ نَكِيرِ
أَوَلَمْ يَرَوْا إِلَى الطَّيْرِ فَوْقَهُمْ صَافَّاتٍ وَيَقْبِضْنَ ۚ مَا يُمْسِكُهُنَّ إِلَّا الرَّحْمَٰنُ ۚ إِنَّهُ بِكُلِّ شَيْءٍ بَصِيرٌ
أَمَّنْ هَٰذَا الَّذِي هُوَ جُنْدٌ لَكُمْ يَنْصُرُكُمْ مِنْ دُونِ الرَّحْمَٰنِ ۚ إِنِ الْكَافِرُونَ إِلَّا فِي غُرُورٍ
أَمَّنْ هَٰذَا الَّذِي يَرْزُقُكُمْ إِنْ أَمْسَكَ رِزْقَهُ ۚ بَلْ لَجُّوا فِي عُتُوٍّ وَنُفُورٍ
أَفَمَنْ يَمْشِي مُكِبًّا عَلَىٰ وَجْهِهِ أَهْدَىٰ أَمَّنْ يَمْشِي سَوِيًّا عَلَىٰ صِرَاطٍ مُسْتَقِيمٍ
قُلْ هُوَ الَّذِي أَنْشَأَكُمْ وَجَعَلَ لَكُمُ السَّمْعَ وَالْأَبْصَارَ وَالْأَفْئِدَةَ ۖ قَلِيلًا مَا تَشْكُرُونَ
قُلْ هُوَ الَّذِي ذَرَأَكُمْ فِي الْأَرْضِ وَإِلَيْهِ تُحْشَرُونَ
وَيَقُولُونَ مَتَىٰ هَٰذَا الْوَعْدُ إِنْ كُنْتُمْ صَادِقِينَ
قُلْ إِنَّمَا الْعِلْمُ عِنْدَ اللَّهِ وَإِنَّمَا أَنَا نَذِيرٌ مُبِينٌ
فَلَمَّا رَأَوْهُ زُلْفَةً سِيئَتْ وُجُوهُ الَّذِينَ كَفَرُوا وَقِيلَ هَٰذَا الَّذِي كُنْتُمْ بِهِ تَدَّعُونَ
قُلْ أَرَأَيْتُمْ إِنْ أَهْلَكَنِيَ اللَّهُ وَمَنْ مَعِيَ أَوْ رَحِمَنَا فَمَنْ يُجِيرُ الْكَافِرِينَ مِنْ عَذَابٍ أَلِيمٍ
قُلْ هُوَ الرَّحْمَٰنُ آمَنَّا بِهِ وَعَلَيْهِ تَوَكَّلْنَا ۖ فَسَتَعْلَمُونَ مَنْ هُوَ فِي ضَلَالٍ مُبِينٍ
قُلْ أَرَأَيْتُمْ إِنْ أَصْبَحَ مَاؤُكُمْ غَوْرًا فَمَنْ يَأْتِيكُمْ بِمَاءٍ مَعِينٍ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Tebârakel-lezî bi-yedihil-mülkü ve hüve alâ külli şey'in kadîr.
El-lezî halekal-mevte vel-hayâte li-yeblüveküm eyyüküm ahsenü amelâ, ve hüvel-azîzül-ğafûr.
El-lezî haleka seb'a semâvâtin tıbâkâ, mâ terâ fî halkır-rahmâni min tefâvüt, ferciıl-basara hel terâ min futûr.
Sümmerciıl-basara kerrateyni yenkalib ileykel-basaru hâsien ve hüve hasîr.
Ve lekad zeyyennäs-semâed-dünyâ bi-mesâbîha ve cealnâhâ rücûmen liş-şeyâtîn, ve a'tednâ lehüm azâbes-seîr.
Ve lillezîne keferû bi-rabbihim azâbü cehennem, ve bi'sel-masîr.
İzâ ulkû fîhâ semiû lehâ şehîkan ve hiye tefûr.
Tekâdü temeyyezü mine'l-ğayz, küllemâ ulkıye fîhâ fevcün seelehüm hazenetühâ e lem ye'tiküm nezîr.
Kâlû belâ kad câenâ nezîrun fe kezzebnâ ve kulnâ mâ nezzelel-lâhü min şey', in entüm illâ fî dalâlin kebîr.
Ve kâlû lev künnâ nesmeu ev na'kılü mâ künnâ fî ashâbis-seîr.
Fa'terefû bi-zenbihim fe suhkan li-ashâbis-seîr.
İnnel-lezîne yahşevne rabbehüm bil-ğaybi lehüm mağfiretün ve ecrun kebîr.
Ve esirrû kavleküm evicherû bih, innehû alîmün bi-zâtis-sudûr.
E lâ ya'lemü men haleka ve hüvel-latîfül-habîr.
Hüvel-lezî ceale lekümül-arda zelûlen femşû fî menâkibihâ ve külû min rizkih, ve ileyhin-nüşûr.
E emintüm men fis-semâi en yahsife bikümül-arda fe izâ hiye temûr.
Em emintüm men fis-semâi en yürsile aleyküm hâsıbâ, fe seta'lemûne keyfe nezîr.
Ve lekad kezzebel-lezîne min kabblihim fe keyfe kâne nekîr.
E ve lem yerev ilât-tayri fevkahüm sâffâtin ve yakbızn, mâ yümsikühünne iller-rahmân, innehû bi-külli şey'in basîr.
Emmen hâzel-lezî hüve cündün leküm yensuruküm min dûnir-rahmân, inil-kâfirûne illâ fî ğurûr.
Emmen hâzel-lezî yerzükuküm in emseke rizkah, bel leccû fî utüvvin ve nüfûr.
E fe men yemşî mü kibben alâ vechihî ehdâ emmen yemşî seviyyen alâ sırâtın müstekîm.
Kul hüvel-lezî enşeeküm ve ceale lekümüs-sem'a vel-ebsâra vel-ef'ideh, kalîlen mâ teşkürûn.
Kul hüvel-lezî zeraeküm fil-ardi ve ileyhi tuhşerûn.
Ve yekûlûne metâ hâzel-va'dü in küntüm sâdikîn.
Kul innemel-ilmü indallâhi ve innemâ ene nezîrun mübîn.
Fe lemmâ raevhü zülfeten sîet vücûhül-lezîne keferû ve kîle hâzel-lezî küntüm bihî teddeûn.
Kul e raeytüm in ehlekeniyallâhü ve men meıye ev rahimanâ fe men yücîrul-kâfirîne min azâbin elîm.
Kul hüver-rahmânü âmennâ bihî ve aleyhi tevekkelnâ, fe seta'lemûne men hüve fî dalâlin mübîn.
Kul e raeytüm in asbeha mâüküm ğavren fe men ye'tîküm bi-mâin meîn.''',
    mana:
        '''Mekke döneminde inmiştir. Otuz âyettir. İlk kelimesi "Tebâreke" olduğu için "Tebâreke Suresi" diye de anılır. Hz. Peygamber (s.a.s.), her gece Mülk Suresi'ni okuyanı kabir azabından koruduğunu, kıyamet günü onun için şefaatçi olacağını haber vermiştir. Yirmi beş ve yirmi yedi. âyetlerinde, ölümden sonra diriliş ve hesap günü inkârcıların sorguya çekileceği ifade edilir. Sûre, Allah'ın mülkünün kudretini, ölüm ve hayatın yaratılış hikmetini, yaratılıştaki düzeni ve inkârcıların âkıbetini anlatır.''',
    meal:
        '''(1) Mutlak hükümranlık elinde olan Allah, yücedir (her türlü noksanlıktan münezzehtir). O, her şeye hakkıyla gücü yetendir. (2) O, hanginizin daha güzel amel yapacağını sınamak için ölümü ve hayatı yaratandır. O, mutlak güç sahibidir, çok bağışlayandır. (3) O, yedi göğü tabaka tabaka yaratandır. Rahman'ın yaratışında hiçbir uyumsuzluk göremezsin. Gözünü çevir de bak: (gökte) bir çatlaklık görüyor musun? (4) Sonra gözünü tekrar tekrar çevir bak. Göz (aradığı kusuru bulamayıp) âciz ve bitkin olarak sana döner. (5) Andolsun, biz dünya göğünü ışık veren yıldızlarla (kandillerle) donattık; bunları şeytanlara atılan taşlar yaptık ve onlar için alevli ateş azabını hazırladık. (6) Rablerini inkâr edenler için cehennem azabı vardır. O, ne kötü bir dönüştür. (7) Oraya atıldıklarında, onun kaynarken çıkardığı boğuk bir ses işitirler. (8) Neredeyse öfkesinden çatlayacak! İçine her bir topluluk atıldıkça, onun bekçileri onlara: "Size bir uyarıcı gelmemiş miydi?" diye sorarlar. (9) Onlar: "Evet, bize bir uyarıcı gelmişti; fakat biz onu yalanlamış ve: 'Allah hiçbir şey indirmemiştir. Siz ancak büyük bir sapıklık içindesiniz' demiştik" derler. (10) Ayrıca şöyle dediler: "Eğer biz kulak vermiş veya düşünmüş olsaydık, şu alevli ateşin içinde (cehennemlikler arasında) bulunmazdık." (11) Böylece günahlarını itiraf ederler. Artık (Allah'ın rahmetinden uzaklaşmak,) alevli ateş halkına yaraşır. (12) Görmedikleri hâlde Rablerinden saygıyla korkanlar için elbette bir bağışlanma ve büyük bir mükâfat vardır. (13) Sözünüzü ister gizleyin, ister açığa vurun; şüphesiz Allah, kalplerin içindekini bilendir. (14) Yaratan bilmez mi? O, en ince işleri görüp bilmektedir ve her şeyden haberdardır. (15) Yeryüzünü size boyun eğdiren O'dur. Haydi onun üzerinde yürüyün ve Allah'ın rızkından yiyin. Dönüş yalnızca O'nadır. (16) Gökte olanın, sizi yere batırmasından güvende misiniz? O zaman yer çalkalanıyor (sizi batırıyor) olacaktır. (17) Ya da gökte olanın, üzerinize taş yağdıran bir fırtına göndermeyeceğinden güvende misiniz? O zaman (O'nun) uyarmanın ne demek olduğunu bileceksiniz. (18) Andolsun, onlardan öncekiler de (bu uyarıları) yalanlamışlardı; beni inkâr edişleri nasıl oldu da cezasını buldu! (19) Üstlerinde kanatlarını açıp kapayarak uçan kuşları görmediler mi? Onları (havada) ancak Rahman tutuyor. Şüphesiz O, her şeyi hakkıyla görendir. (20) Rahmân olan Allah'a karşı size yardım edecek şu ordularınız kimlerdir? İnkârcılar ancak bir aldanış içindedirler. (21) Allah, rızkını tutarsa, size rızık verecek olan kimdir? Hayır, onlar azgınlık ve nefret içinde direnip durmaktadırlar. (22) Şimdi yüzükoyun kapanarak yürüyen mi daha doğru yoldadır, yoksa dosdoğru yolda düzgün yürüyen mi? (23) De ki: "Sizi yaratan; size kulak, gözler ve kalpler veren O'dur. Ne az şükrediyorsunuz!" (24) De ki: "Sizi yeryüzünde yaratıp çoğaltan O'dur. Siz ancak O'nun huzurunda toplanacaksınız." (25) "Eğer doğru söyleyenlerseniz, bu tehdit ne zaman gerçekleşir?" derler. (26) De ki: "O bilgi ancak Allah'ın katındadır. Ben ancak apaçık bir uyarıcıyım." (27) Onu yakından gördüklerinde, inkâr edenlerin yüzleri kötüleşir (kararır). Onlara: "İşte isteyip durduğunuz şey budur!" denir. (28) De ki: "Haber verin bakalım: Eğer Allah, beni ve beraberimdekileri helâk ederse ya da bize merhamet ederse, inkârcıları acı azaptan kurtaracak kim vardır?" (29) De ki: "O, Rahmân'dır; O'na iman ettik ve yalnızca O'na güvendik. Kimin apaçık sapıklık içinde olduğunu yakında öğreneceksiniz." (30) De ki: "Haber verin bakalım: Suyunuz yerin dibine batıverse, size apaçık bir kaynak su getirebilecek olan kimdir?"''',
  ),
  MubarekSureVerisi(
    baslik: 'Mülk (Tebâreke) - Kısa',
    baslikEn: 'Al-Mulk (Key Verses)',
    audioUrl: 'https://server12.mp3quran.net/maher/067.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
تَبَارَكَ الَّذِي بِيَدِهِ الْمُلْكُ وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ
الَّذِي خَلَقَ الْمَوْتَ وَالْحَيَاةَ لِيَبْلُوَكُمْ أَيُّكُمْ أَحْسَنُ عَمَلًا ۚ وَهُوَ الْعَزِيزُ الْغَفُورُ
الَّذِي خَلَقَ سَبْعَ سَمَاوَاتٍ طِبَاقًا ۖ مَا تَرَىٰ فِي خَلْقِ الرَّحْمَٰنِ مِنْ تَفَاوُتٍ ۖ فَارْجِعِ الْبَصَرَ هَلْ تَرَىٰ مِنْ فُطُورٍ
فَارْجِعِ الْبَصَرَ هَلْ تَرَىٰ مِنْ فُطُورٍ
تَكَادُ تَمَيَّزُ مِنَ الْغَيْظِ ۖ كُلَّمَا أُلْقِيَ فِيهَا فَوْجٌ سَأَلَهُمْ خَزَنَتُهَا أَلَمْ يَأْتِكُمْ نَذِيرٌ
قَالُوا بَلَىٰ قَدْ جَاءَنَا نَذِيرٌ فَكَذَّبْنَا وَقُلْنَا مَا نَزَّلَ اللَّهُ مِنْ شَيْءٍ إِنْ أَنْتُمْ إِلَّا فِي ضَلَالٍ كَبِيرٍ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Tebârakel-lezî bi-yedihil-mülkü ve hüve alâ külli şey'in kadîr.
El-lezî halekal-mevte vel-hayâte li-yeblüveküm eyyüküm ahsenü amelâ, ve hüvel-azîzül-ğafûr.
El-lezî haleka seb'a semâvâtin tıbâkâ, mâ terâ fî halkır-rahmâni min tefâvüt, ferciıl-basara hel terâ min futûr.
Ferciıl-basara hel terâ min futûr.
Tekâdü temeyyezü minel-ğayz, küllemâ ulkıye fîhâ fevcün seelehüm hazenetühâ e lem ye'tiküm nezîr.
Kâlû belâ kad câenâ nezîrün fe kezzebnâ ve kulnâ mâ nezzelel-lâhü min şey', in entüm illâ fî dalâlin kebîr.''',
    mana:
        '''Mülk (Tebâreke) Suresi'nin ilk âyetlerinin özeti. Bu sûre Allah'ın mülkünün elinde olduğunu, O'nun her şeye gücü yettiğini, ölümü ve hayatı imtihan için yarattığını anlatır. Yedi kat gökleri kusursuz ve kat kat yaratan O'dur; göz, onlarda bir çatlaklık görmez. Kıyamet günü cehennemi inkâr edenleri koruyacak biri yoktur; onlar peygamberler geldiğinde yalanlayanlardandır.''',
    meal:
        '''(1) Mutlak hükümranlık elinde olan Allah, yücedir (her türlü noksanlıktan münezzehtir). O, her şeye hakkıyla gücü yetendir. (2) O, hanginizin daha güzel amel yapacağını sınamak için ölümü ve hayatı yaratandır. O, mutlak güç sahibidir, çok bağışlayandır. (3) O, yedi göğü tabaka tabaka yaratandır. Rahman'ın yaratışında hiçbir uyumsuzluk göremezsin. Gözünü çevir de bak: (gökte) bir çatlaklık görüyor musun? (7) Oraya atıldıklarında, onun kaynarken çıkardığı boğuk bir ses işitirler. (8) Neredeyse öfkesinden çatlayacak! İçine her bir topluluk atıldıkça, onun bekçileri onlara: "Size bir uyarıcı gelmemiş miydi?" diye sorarlar. (9) Onlar: "Evet, bize bir uyarıcı gelmişti; fakat biz onu yalanlamış ve: 'Allah hiçbir şey indirmemiştir. Siz ancak büyük bir sapıklık içindesiniz' demiştik" derler.''',
  ),
  MubarekSureVerisi(
    baslik: 'İnşirâh Suresi',
    baslikEn: 'Surah Ash-Sharh',
    audioUrl: 'https://server12.mp3quran.net/maher/094.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
أَلَمْ نَشْرَحْ لَكَ صَدْرَكَ
وَوَضَعْنَا عَنْكَ وِزْرَكَ
الَّذِي أَنْقَضَ ظَهْرَكَ
وَرَفَعْنَا لَكَ ذِكْرَكَ
فَإِنَّ مَعَ الْعُسْرِ يُسْرًا
إِنَّ مَعَ الْعُسْرِ يُسْرًا
فَإِذَا فَرَغْتَ فَانْصَبْ
وَإِلَىٰ رَبِّكَ فَارْغَبْ''',
    okunus: '''Bismillâhirrahmânirrahîm.
E lem neşrah leke sadrak.
Ve vada'nâ anke vizrak.
El-lezî enkada zahrak.
Ve refa'nâ leke zikrak.
Fe inne meal-usri yüsrâ.
İnne meal-usri yüsrâ.
Fe izâ feragte fensab.
Ve ilâ rabbike ferğab.''',
    mana:
        '''Mekke döneminde inmiştir. Sekiz âyettir. "İnşirah" açılmak, genişlemek demektir. Sûrede, Hz. Peygamber'in gönlünün ferahlatıldığı, yükünün hafifletildiği ve adının yüceltildiği bildirilir. "Muhakkak ki her zorlukla birlikte bir kolaylık vardır" âyeti, güçlüklerin ardından kolaylığın geleceğini müjdeler. Sıkıntı anlarında teselli kaynağı olan bir sûredir.''',
    meal:
        '''(1) Senin kalbini (göğsünü) genişletip açmadık mı? (2) Senden yükünü kaldırıp atmadık mı? (3) O senin belini büken yükü. (4) Senin namını yükseltmedik mi? (5) Şüphesiz güçlükle beraber bir kolaylık vardır. (6) Gerçekten, güçlükle beraber bir kolaylık vardır. (7) O hâlde, bir işi bitirince (diğerine) koyul. (8) Ancak Rabbine yönel ve yalvar.''',
  ),
  MubarekSureVerisi(
    baslik: 'Kıyâmet Suresi',
    baslikEn: 'Surah Al-Qiyamah',
    audioUrl: 'https://server12.mp3quran.net/maher/075.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
لَا أُقْسِمُ بِيَوْمِ الْقِيَامَةِ
وَلَا أُقْسِمُ بِالنَّفْسِ اللَّوَّامَةِ
أَيَحْسَبُ الْإِنْسَانُ أَلَّنْ نَجْمَعَ عِظَامَهُ
بَلَىٰ قَادِرِينَ عَلَىٰ أَنْ نُسَوِّيَ بَنَانَهُ
بَلْ يُرِيدُ الْإِنْسَانُ لِيَفْجُرَ أَمَامَهُ
يَسْأَلُ أَيَّانَ يَوْمُ الْقِيَامَةِ
فَإِذَا بَرِقَ الْبَصَرُ
وَخَسَفَ الْقَمَرُ
وَجُمِعَ الشَّمْسُ وَالْقَمَرُ
يَقُولُ الْإِنْسَانُ يَوْمَئِذٍ أَيْنَ الْمَفَرُّ
كَلَّا لَا وَزَرَ
إِلَىٰ رَبِّكَ يَوْمَئِذٍ الْمُسْتَقَرُّ
يُنَبَّأُ الْإِنْسَانُ يَوْمَئِذٍ بِمَا قَدَّمَ وَأَخَّرَ
بَلِ الْإِنْسَانُ عَلَىٰ نَفْسِهِ بَصِيرَةٌ
وَلَوْ أَلْقَىٰ مَعَاذِيرَهُ
لَا تُحَرِّكْ بِهِ لِسَانَكَ لِتَعْجَلَ بِهِ
إِنَّ عَلَيْنَا جَمْعَهُ وَقُرْآنَهُ
فَإِذَا قَرَأْنَاهُ فَاتَّبِعْ قُرْآنَهُ
ثُمَّ إِنَّ عَلَيْنَا بَيَانَهُ
كَلَّا بَلْ تُحِبُّونَ الْعَاجِلَةَ
وَتَذَرُونَ الْآخِرَةَ
وُجُوهٌ يَوْمَئِذٍ نَاضِرَةٌ
إِلَىٰ رَبِّهَا نَاظِرَةٌ
وَوُجُوهٌ يَوْمَئِذٍ بَاسِرَةٌ
تَظُنُّ أَنْ يُفْعَلَ بِهَا فَاقِرَةٌ
كَلَّا إِذَا بَلَغَتِ التَّرَاقِيَ
وَقِيلَ مَنْ رَاقٍ
وَظَنَّ أَنَّهُ الْفِرَاقُ
وَالْتَفَّتِ السَّاقُ بِالسَّاقِ
إِلَىٰ رَبِّكَ يَوْمَئِذٍ الْمَسَاقُ
فَلَا صَدَّقَ وَلَا صَلَّىٰ
وَلَٰكِنْ كَذَّبَ وَتَوَلَّىٰ
ثُمَّ ذَهَبَ إِلَىٰ أَهْلِهِ يَتَمَطَّىٰ
أَوْلَىٰ لَكَ فَأَوْلَىٰ
ثُمَّ أَوْلَىٰ لَكَ فَأَوْلَىٰ
أَيَحْسَبُ الْإِنْسَانُ أَنْ يُتْرَكَ سُدًى
أَلَمْ يَكُ نُطْفَةً مِنْ مَنِيٍّ يُمْنَىٰ
ثُمَّ كَانَ عَلَقَةً فَخَلَقَ فَسَوَّىٰ
فَجَعَلَ مِنْهُ الزَّوْجَيْنِ الذَّكَرَ وَالْأُنْثَىٰ
أَلَيْسَ ذَٰلِكَ بِقَادِرٍ عَلَىٰ أَنْ يُحْيِيَ الْمَوْتَىٰ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Lâ uksimü bi-yevmil-kıyâmeh.
Ve lâ uksimü bin-nefsil-levvâmeh.
E yahsebül-insânü el len necmea izâmeh.
Belâ kâdirîne alâ en nüsevvîye benâneh.
Bel yürîdül-insânü li-yefcüra emâmeh.
Yes'elü eyyâne yevmül-kıyâmeh.
Fe izâ berikal-basar.
Ve hasefel-kamer.
Ve cümi'aş-şemsü vel-kamer.
Yekûlül-insânü yevme-izin eynel-meferr.
Kellâ lâ vezer.
İlâ rabbike yevme-izinil-müstekarr.
Yünebbeül-insânü yevme-izin bimâ kaddeme ve ahhar.
Belil-insânü alâ nefsihî basîrah.
Ve lev elkâ meâzîrah.
Lâ tüharrik bihî lisâneke li-te'cele bih.
İnne aleynâ cem'ahû ve Kur'âneh.
Fe izâ kara'nâhü fettebi' Kur'âneh.
Sümme inne aleynâ beyâneh.
Kellâ bel tühibbûnel-âcileh.
Ve tezerûnel-âhirah.
Vücûhün yevme-izin nâdırah.
İlâ rabbihâ nâzırah.
Ve vücûhün yevme-izin bâsirah.
Tezunnü en yüf'ale bihâ fâkırah.
Kellâ izâ belağatit-terâkî.
Ve kîle men râk.
Ve zanne ennehül-firâk.
Velteffetis-sâku bis-sâk.
İlâ rabbike yevme-izinil-mesâk.
Fe lâ saddeka ve lâ sallâ.
Ve lâkin kezzebe ve tevellâ.
Sümme zehebe ilâ ehlihî yetemettâ.
Evlâ leke fe-evlâ.
Sümme evlâ leke fe-evlâ.
E yahsebül-insânü en yütrake süden.
E lem yekü nutfeten min meniyyin yümnâ.
Sümme kâne alakaten fe haleka fe sevvâ.
Fe ceale minhüz-zevceyniz-zekera vel-ünsâ.
E leyse zâlike bi-kâdirin alâ en yuhyiyel-mevtâ.''',
    mana:
        '''Mekke döneminde inmiştir. Kırk âyettir. "Kıyâmet" kalkış, diriliş demektir. Sûrede kıyamet gününün dehşeti, ölüm ânı, hesap ve diriliş anlatılır. Ayrıca insanın boşuna yaratılmadığı, nutfeden yaratılıp en güzel biçimde şekillendirildiği ve Allah'ın ölüleri diriltmeye kadir olduğu bildirilir. Âhirete inanmayanlar uyarılır.''',
    meal:
        '''(1) Kıyamet gününe yemin ederim. (2) Kendini kınayan (pişmanlık duyan) nefse de yemin ederim. (3) İnsan, kendisinin kemiklerini bir araya toplayamayacağımızı mı sanır? (4) Evet, bizim, onun parmak uçlarını bile yeniden yapmaya gücümüz yeter. (5) Fakat insan, önündekini (kıyameti) yalanlamak ister. (6) "Kıyamet günü ne zaman?" diye sorar. (7) Göz kamaştığı, (8) ay tutulduğu, (9) güneş ve ay bir araya toplandığı zaman, (10) işte o gün insan: "Kaçacak yer neresi?" der. (11) Hayır, hiçbir sığınak yoktur. (12) O gün varılıp durulacak tek yer, Rabbinin huzurudur. (13) O gün insana, ileri götürdüğü ve geri bıraktığı ne varsa haber verilir. (14) İnsan, kendi kendisinin şahididir. (15) Birtakım bahaneler ileri sürse bile. (16) Onu çarçabuk almak için dilini ona (vahye) oynatma. (17) Şüphesiz onu toplamak ve okutmak bize aittir. (18) O hâlde, biz onu okuduğumuz zaman, sen onun okunuşunu takip et. (19) Sonra şüphesiz onu açıklamak da bize aittir. (20) Hayır! Siz, çarçabuk geçen dünyayı seviyorsunuz. (21) Âhireti ise ihmal ediyorsunuz. (22) O gün birtakım yüzler parlaklık içindedir. (23) Rabbine bakar. (24) O gün birtakım yüzler de asıktır. (25) Kendilerine bel kemiklerini kıracak bir felâket gelecegini sezdirirler. (26) Hayır, ne zaman ki can boğaza gelir, (27) "Bir kurtarıcı var mı?" denir. (28) (İnsan) bunun, artık bir ayrılış olduğunu anlar. (29) Bacaklar birbirine dolaşır. (30) İşte o gün (herkes) Rabbine sevk edilir. (31) İşte o (peygamber) ne doğruladı ne de namaz kıldı. (32) Fakat yalanladı ve yüz çevirdi. (33) Sonra da çalım sata sata yürüyerek ailesine gitti. (34) Sana lâyık olan (tevbe etmendir) lâyık olan! (35) Evet, sana lâyık olan (tevbe etmendir) lâyık olan! (36) İnsan, başıboş bırakılacağını mı sanır? (37) O, (anne rahmine) atılan meniden bir damla/ su damlası değil miydi? (38) Sonra bir asılıp tutunan şey (alaka) olmuş, yaratmış ve şekillendirmiştir. (39) Ondan da iki eşi, erkeği ve dişiyi yaratmıştır. (40) Bunları yapanın, ölüleri diriltmeye gücü yetmez mi?''',
  ),
  MubarekSureVerisi(
    baslik: 'Fetih Suresi',
    baslikEn: 'Surah Al-Fath',
    audioUrl: 'https://server12.mp3quran.net/maher/048.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca:
        '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ إِنَّا فَتَحْنَا لَكَ فَتْحًۭا مُّبِينًۭا
لِّيَغْفِرَ لَكَ ٱللَّهُ مَا تَقَدَّمَ مِن ذَنۢبِكَ وَمَا تَأَخَّرَ وَيُتِمَّ نِعْمَتَهُۥ عَلَيْكَ وَيَهْدِيَكَ صِرَٰطًۭا مُّسْتَقِيمًۭا
وَيَنصُرَكَ ٱللَّهُ نَصْرًا عَزِيزًا
هُوَ ٱلَّذِىٓ أَنزَلَ ٱلسَّكِينَةَ فِى قُلُوبِ ٱلْمُؤْمِنِينَ لِيَزْدَادُوٓا۟ إِيمَٰنًۭا مَّعَ إِيمَٰنِهِمْ ۗ وَلِلَّهِ جُنُودُ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ ۚ وَكَانَ ٱللَّهُ عَلِيمًا حَكِيمًۭا
لِّيُدْخِلَ ٱلْمُؤْمِنِينَ وَٱلْمُؤْمِنَٰتِ جَنَّٰتٍۢ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَٰرُ خَٰلِدِينَ فِيهَا وَيُكَفِّرَ عَنْهُمْ سَيِّـَٔاتِهِمْ ۚ وَكَانَ ذَٰلِكَ عِندَ ٱللَّهِ فَوْزًا عَظِيمًۭا
وَيُعَذِّبَ ٱلْمُنَٰفِقِينَ وَٱلْمُنَٰفِقَٰتِ وَٱلْمُشْرِكِينَ وَٱلْمُشْرِكَٰتِ ٱلظَّآنِّينَ بِٱللَّهِ ظَنَّ ٱلسَّوْءِ ۚ عَلَيْهِمْ دَآئِرَةُ ٱلسَّوْءِ ۖ وَغَضِبَ ٱللَّهُ عَلَيْهِمْ وَلَعَنَهُمْ وَأَعَدَّ لَهُمْ جَهَنَّمَ ۖ وَسَآءَتْ مَصِيرًۭا
وَلِلَّهِ جُنُودُ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ ۚ وَكَانَ ٱللَّهُ عَزِيزًا حَكِيمًا
إِنَّآ أَرْسَلْنَٰكَ شَٰهِدًۭا وَمُبَشِّرًۭا وَنَذِيرًۭا
لِّتُؤْمِنُوا۟ بِٱللَّهِ وَرَسُولِهِۦ وَتُعَزِّرُوهُ وَتُوَقِّرُوهُ وَتُسَبِّحُوهُ بُكْرَةًۭ وَأَصِيلًا
إِنَّ ٱلَّذِينَ يُبَايِعُونَكَ إِنَّمَا يُبَايِعُونَ ٱللَّهَ يَدُ ٱللَّهِ فَوْقَ أَيْدِيهِمْ ۚ فَمَن نَّكَثَ فَإِنَّمَا يَنكُثُ عَلَىٰ نَفْسِهِۦ ۖ وَمَنْ أَوْفَىٰ بِمَا عَٰهَدَ عَلَيْهُ ٱللَّهَ فَسَيُؤْتِيهِ أَجْرًا عَظِيمًۭا
سَيَقُولُ لَكَ ٱلْمُخَلَّفُونَ مِنَ ٱلْأَعْرَابِ شَغَلَتْنَآ أَمْوَٰلُنَا وَأَهْلُونَا فَٱسْتَغْفِرْ لَنَا ۚ يَقُولُونَ بِأَلْسِنَتِهِم مَّا لَيْسَ فِى قُلُوبِهِمْ ۚ قُلْ فَمَن يَمْلِكُ لَكُم مِّنَ ٱللَّهِ شَيْـًٔا إِنْ أَرَادَ بِكُمْ ضَرًّا أَوْ أَرَادَ بِكُمْ نَفْعًۢا ۚ بَلْ كَانَ ٱللَّهُ بِمَا تَعْمَلُونَ خَبِيرًۢا
بَلْ ظَنَنتُمْ أَن لَّن يَنقَلِبَ ٱلرَّسُولُ وَٱلْمُؤْمِنُونَ إِلَىٰٓ أَهْلِيهِمْ أَبَدًۭا وَزُيِّنَ ذَٰلِكَ فِى قُلُوبِكُمْ وَظَنَنتُمْ ظَنَّ ٱلسَّوْءِ وَكُنتُمْ قَوْمًۢا بُورًۭا
وَمَن لَّمْ يُؤْمِنۢ بِٱللَّهِ وَرَسُولِهِۦ فَإِنَّآ أَعْتَدْنَا لِلْكَٰفِرِينَ سَعِيرًۭا
وَلِلَّهِ مُلْكُ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ ۚ يَغْفِرُ لِمَن يَشَآءُ وَيُعَذِّبُ مَن يَشَآءُ ۚ وَكَانَ ٱللَّهُ غَفُورًۭا رَّحِيمًۭا
سَيَقُولُ ٱلْمُخَلَّفُونَ إِذَا ٱنطَلَقْتُمْ إِلَىٰ مَغَانِمَ لِتَأْخُذُوهَا ذَرُونَا نَتَّبِعْكُمْ ۖ يُرِيدُونَ أَن يُبَدِّلُوا۟ كَلَٰمَ ٱللَّهِ ۚ قُل لَّن تَتَّبِعُونَا كَذَٰلِكُمْ قَالَ ٱللَّهُ مِن قَبْلُ ۖ فَسَيَقُولُونَ بَلْ تَحْسُدُونَنَا ۚ بَلْ كَانُوا۟ لَا يَفْقَهُونَ إِلَّا قَلِيلًۭا
قُل لِّلْمُخَلَّفِينَ مِنَ ٱلْأَعْرَابِ سَتُدْعَوْنَ إِلَىٰ قَوْمٍ أُو۟لِى بَأْسٍۢ شَدِيدٍۢ تُقَٰتِلُونَهُمْ أَوْ يُسْلِمُونَ ۖ فَإِن تُطِيعُوا۟ يُؤْتِكُمُ ٱللَّهُ أَجْرًا حَسَنًۭا ۖ وَإِن تَتَوَلَّوْا۟ كَمَا تَوَلَّيْتُم مِّن قَبْلُ يُعَذِّبْكُمْ عَذَابًا أَلِيمًۭا
لَّيْسَ عَلَى ٱلْأَعْمَىٰ حَرَجٌۭ وَلَا عَلَى ٱلْأَعْرَجِ حَرَجٌۭ وَلَا عَلَى ٱلْمَرِيضِ حَرَجٌۭ ۗ وَمَن يُطِعِ ٱللَّهَ وَرَسُولَهُۥ يُدْخِلْهُ جَنَّٰتٍۢ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَٰرُ ۖ وَمَن يَتَوَلَّ يُعَذِّبْهُ عَذَابًا أَلِيمًۭا
۞ لَّقَدْ رَضِىَ ٱللَّهُ عَنِ ٱلْمُؤْمِنِينَ إِذْ يُبَايِعُونَكَ تَحْتَ ٱلشَّجَرَةِ فَعَلِمَ مَا فِى قُلُوبِهِمْ فَأَنزَلَ ٱلسَّكِينَةَ عَلَيْهِمْ وَأَثَٰبَهُمْ فَتْحًۭا قَرِيبًۭا
وَمَغَانِمَ كَثِيرَةًۭ يَأْخُذُونَهَا ۗ وَكَانَ ٱللَّهُ عَزِيزًا حَكِيمًۭا
وَعَدَكُمُ ٱللَّهُ مَغَانِمَ كَثِيرَةًۭ تَأْخُذُونَهَا فَعَجَّلَ لَكُمْ هَٰذِهِۦ وَكَفَّ أَيْدِىَ ٱلنَّاسِ عَنكُمْ وَلِتَكُونَ ءَايَةًۭ لِّلْمُؤْمِنِينَ وَيَهْدِيَكُمْ صِرَٰطًۭا مُّسْتَقِيمًۭا
وَأُخْرَىٰ لَمْ تَقْدِرُوا۟ عَلَيْهَا قَدْ أَحَاطَ ٱللَّهُ بِهَا ۚ وَكَانَ ٱللَّهُ عَلَىٰ كُلِّ شَىْءٍۢ قَدِيرًۭا
وَلَوْ قَٰتَلَكُمُ ٱلَّذِينَ كَفَرُوا۟ لَوَلَّوُا۟ ٱلْأَدْبَٰرَ ثُمَّ لَا يَجِدُونَ وَلِيًّۭا وَلَا نَصِيرًۭا
سُنَّةَ ٱللَّهِ ٱلَّتِى قَدْ خَلَتْ مِن قَبْلُ ۖ وَلَن تَجِدَ لِسُنَّةِ ٱللَّهِ تَبْدِيلًۭا
وَهُوَ ٱلَّذِى كَفَّ أَيْدِيَهُمْ عَنكُمْ وَأَيْدِيَكُمْ عَنْهُم بِبَطْنِ مَكَّةَ مِنۢ بَعْدِ أَنْ أَظْفَرَكُمْ عَلَيْهِمْ ۚ وَكَانَ ٱللَّهُ بِمَا تَعْمَلُونَ بَصِيرًا
هُمُ ٱلَّذِينَ كَفَرُوا۟ وَصَدُّوكُمْ عَنِ ٱلْمَسْجِدِ ٱلْحَرَامِ وَٱلْهَدْىَ مَعْكُوفًا أَن يَبْلُغَ مَحِلَّهُۥ ۚ وَلَوْلَا رِجَالٌۭ مُّؤْمِنُونَ وَنِسَآءٌۭ مُّؤْمِنَٰتٌۭ لَّمْ تَعْلَمُوهُمْ أَن تَطَـُٔوهُمْ فَتُصِيبَكُم مِّنْهُم مَّعَرَّةٌۢ بِغَيْرِ عِلْمٍۢ ۖ لِّيُدْخِلَ ٱللَّهُ فِى رَحْمَتِهِۦ مَن يَشَآءُ ۚ لَوْ تَزَيَّلُوا۟ لَعَذَّبْنَا ٱلَّذِينَ كَفَرُوا۟ مِنْهُمْ عَذَابًا أَلِيمًا
إِذْ جَعَلَ ٱلَّذِينَ كَفَرُوا۟ فِى قُلُوبِهِمُ ٱلْحَمِيَّةَ حَمِيَّةَ ٱلْجَٰهِلِيَّةِ فَأَنزَلَ ٱللَّهُ سَكِينَتَهُۥ عَلَىٰ رَسُولِهِۦ وَعَلَى ٱلْمُؤْمِنِينَ وَأَلْزَمَهُمْ كَلِمَةَ ٱلتَّقْوَىٰ وَكَانُوٓا۟ أَحَقَّ بِهَا وَأَهْلَهَا ۚ وَكَانَ ٱللَّهُ بِكُلِّ شَىْءٍ عَلِيمًۭا
لَّقَدْ صَدَقَ ٱللَّهُ رَسُولَهُ ٱلرُّءْيَا بِٱلْحَقِّ ۖ لَتَدْخُلُنَّ ٱلْمَسْجِدَ ٱلْحَرَامَ إِن شَآءَ ٱللَّهُ ءَامِنِينَ مُحَلِّقِينَ رُءُوسَكُمْ وَمُقَصِّرِينَ لَا تَخَافُونَ ۖ فَعَلِمَ مَا لَمْ تَعْلَمُوا۟ فَجَعَلَ مِن دُونِ ذَٰلِكَ فَتْحًۭا قَرِيبًا
هُوَ ٱلَّذِىٓ أَرْسَلَ رَسُولَهُۥ بِٱلْهُدَىٰ وَدِينِ ٱلْحَقِّ لِيُظْهِرَهُۥ عَلَى ٱلدِّينِ كُلِّهِۦ ۚ وَكَفَىٰ بِٱللَّهِ شَهِيدًۭا
مُّحَمَّدٌۭ رَّسُولُ ٱللَّهِ ۚ وَٱلَّذِينَ مَعَهُۥٓ أَشِدَّآءُ عَلَى ٱلْكُفَّارِ رُحَمَآءُ بَيْنَهُمْ ۖ تَرَىٰهُمْ رُكَّعًۭا سُجَّدًۭا يَبْتَغُونَ فَضْلًۭا مِّنَ ٱللَّهِ وَرِضْوَٰنًۭا ۖ سِيمَاهُمْ فِى وُجُوهِهِم مِّنْ أَثَرِ ٱلسُّجُودِ ۚ ذَٰلِكَ مَثَلُهُمْ فِى ٱلتَّوْرَىٰةِ ۚ وَمَثَلُهُمْ فِى ٱلْإِنجِيلِ كَزَرْعٍ أَخْرَجَ شَطْـَٔهُۥ فَـَٔازَرَهُۥ فَٱسْتَغْلَظَ فَٱسْتَوَىٰ عَلَىٰ سُوقِهِۦ يُعْجِبُ ٱلزُّرَّاعَ لِيَغِيظَ بِهِمُ ٱلْكُفَّارَ ۗ وَعَدَ ٱللَّهُ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّٰلِحَٰتِ مِنْهُم مَّغْفِرَةًۭ وَأَجْرًا عَظِيمًۢا''',
    okunus:
        '''Bismillâhirrahmânirrahîm.
Innaa fatahnaa laka Fatham Mubeenaa
Liyaghfira lakal laahu maa taqaddama min zambika wa maa ta akhkhara wa yutimma ni'matahoo 'alaika wa yahdiyaka siraatam mustaqeema
Wa yansurakal laahu nasran 'azeezaa
Huwal lazeee anzalas sakeenata fee quloobil mu'mineena liyazdaadooo eemaanamma'a eemaanihim; wa lillaahi junoodus samawaati wal ard; wa kaanal laahu 'Aleeman Hakeemaa
Liyudkhilal mu'mineena walmu'minaati jannaatin tajree min tahtihal anhaaru khaalideena feehaa wa yukaffira 'anhum saiyi aatihim; wa kaana zaalika 'indal laahi fawzan 'azeemaa
Wa yu'azzibal munaafiqeena walmunaafiqaati wal mushrikeena walmushrikaatiz zaaanneena billaahi zannas saw'; 'alaihim daaa'iratus saw'i wa ghadibal laahu 'alaihim wa la'anahum wa a'adda lahum jahannama wa saaa' at maseeraa
Wa lillaahi junoodus samaawaati wal ard; wa kaanal laahu 'azeezan hakeema
Innaaa arsalnaaka shaahi danw wa mubashshiranw wa nazeera
Litu minoo billaahi wa Rasoolihee wa tu'azziroohu watuwaqqiroohu watusabbi hoohu bukratanw wa aseelaa
Innal lazeena yubaayi'oonaka innamaa yubaayi'oonal laaha yadul laahi fawqa aydehim; faman nakasa fainnamaa yuankusu 'alaa nafsihee wa man awfaa bimaa 'aahada 'alihul laaha fasa yu'teehi ajran 'azeemaa
Sa yaqoolu lakal mukhal lafoona minal-A'raabi shaighalatnaaa amwaalunaa wa ahloonaa fastaghfir lanaa; yaqooloona bi alsinatihim maa laisa fee quloobihim; qul famany yamliku lakum minal laahi shai'an in araada bikum darran aw araada bikum naf'aa; bal kaanal laahu bimaa ta'maloona Khabeeraa
Bal zanantum al lany yanqalibar Rasoolu walmu'minoona ilaaa ahleehim abadanw wa zuyyina zaalika fee quloobikum wa zanantum zannnas saw'i wa kuntum qawmam booraa
Wa mal lam yu'mim billaahi wa Rasoolihee fainnaaa a'tadnaa lilkaafireena sa'eeraa
Wa lillaahii mulkus samaawaati wal ard; yaghfiru limany yashaaa'u wa yu'azzibu many yashaaa'; wa kaanal laahu Ghafoorar Raheemaa
Sa yaqoolul mukhalla foona izan talaqtum ilaa maghaanima litaakhuzoohaa zaroonaa nattabi'kum yureedoona any yubaddiloo Kalaamallaah; qul lan tattabi'oonaa kazaalikum qaalal laahu min qablu fasa yaqooloona bal tahsudoonanna; bal kaanoo laa yafqahoona illaa qaleela
Qul lilmukhallafeena minal A'raabi satud'awna ilaa qawmin ulee baasin shadeedin tuqaati loonahum aw yuslimoona fa in tutee'oo yu'tikumul laahu ajran hasananw wa in tatawallaw kamaa tawallaitum min qablu yu'azzibkum 'azaaban aleemaa
Laisa 'alal a'maa harajunw wa laa 'alal a'raji harajunw wa laa 'alal mareedi haraj' wa many yutil'il laaha wa Rasoolahoo yudkhilhu jannaatin tajree min tahtihal anhaaru wa many yatawalla yu'azzibhu 'azaaban aleemaa
Laqad radiyal laahu 'anil mu'mineena iz yubaayi 'oonaka tahtash shajarati fa'alima maa fee quloobihim fa anzalas sakeenata 'alaihim wa asaa bahum fat han qareebaa
Wa maghaanima kaseera tany yaakhuzoonahaa; wa kaanal laahu 'Azeezan Hakeemaa
Wa'adakumul laahu ma ghaanima kaseeratan taakhuzoo nahaa fa'ajjala lakum haazihee wa kaffa aydiyan naasi 'ankum wa litakoona aayatal lilmu'mineena wa yahdiyakum siraatam mustaqeema
Wa ukhraa lam taqdiroo 'alaihaa qad ahaatal laahu bihaa; wa kaanal laahu 'alaa kulli shai'in qadeera
Wa law qaatalakumul lazeena kafaroo la wallawul adbaara summa laa yajidoona waliyanw-wa laa naseeraa
Sunnatal laahil latee qad khalat min qablu wa lan tajida lisunnatil laahi tabdeelaa
Wa Huwal lazee kaffa aydiyahum 'ankum wa aydiyakum 'anhum bibatni Makkata mim ba'di an azfarakum 'alaihim; wa kaanal laahu bimaa ta'maloona Baseera
Humul lazeena kafaroo wa saddookum 'anil-Masjidil-Haraami walhadya ma'koofan any yablugha mahillah; wa law laa rijaalum mu'minoona wa nisaaa'um mu'minaatul lam ta'lamoohum an tata'oohum fatuseebakum minhum ma'arratum bighairi 'ilmin liyud khilal laahu fee rahmatihee many yashaaa'; law tazayyaloo la'azzabnal lazeena kafaroo minhum 'azaaban aleema
Iz ja'alal lazeena kafaroo fee quloobihimul hamiyyata hamiyyatal jaahiliyyati fa anzalal laahu sakeenatahoo 'alaa Rasoolihee wa 'alal mu mineena wa alzamahum kalimatat taqwaa wa kaanooo ahaqqa bihaa wa ahlahaa; wa kaanal laahu bikulli shai'in Aleema
Laqad sadaqal laahu Rasoolahur ru'yaa bilhaqq, latadkhulunnal Masjidal-Haraama in shaaa'al laahu aamineena muhalliqeena ru'oosakum wa muqassireena laa takhaafoona fa'alima maa lam ta'lamoo faja'ala min dooni zaalika fathan qareebaa
Huwal lazeee arsala Rasoolahoo bilhudaa wa deenil haqqi liyuzhirahoo 'alad deeni kullih; wa kafaa billaahi Shaheeda
Muhammadur Rasoolul laah; wallazeena ma'ahooo ashiddaaa'u 'alal kuffaaari ruhamaaa'u bainahum taraahum rukka'an sujjadany yabtaghoona fadlam minal laahi wa ridwaanan seemaahum fee wujoohihim min asaris sujood; zaalika masaluhum fit tawraah; wa masaluhum fil Injeeli kazar'in akhraja shat 'ahoo fa 'aazarahoo fastaghlaza fastawaa 'alaa sooqihee yu'jibuz zurraa'a liyagheeza bihimul kuffaar; wa'adal laahul lazeena aamanoo wa 'amilus saalihaati minhum maghfiratanw wa ajran 'azeemaa''',
    mana:
        '''Medine döneminde, Hudeybiye antlaşmasından sonra inmiştir. Yirmi dokuz âyettir. "Fetih" zafer, fetih demektir. Sûre, Hz. Peygamber'e verilen apaçık fetih müjdesiyle başlar; zafere giden yolda Allah'ın yardımını, sabrı, hoşgörüyü ve Hudeybiye antlaşmasının önemini anlatır. Müminlere cennet müjdesi verilir, münafıklarla müşrikler uyarılır. Bir âyetinde Allah'a biat edenlerin gerçekte Allah'a biat ettiği bildirilir.''',
    meal:
        '''(1) Doğrusu Biz sana apaçık bir zafer sağlamışızdır.
(2) Allah böylece, senin geçmiş ve gelecek günahlarını bağışlar, sana olan nimetini tamamlar, seni doğru yola eriştirir.
(3) Böylece sana, kimsenin güç yetiremeyeceği bir şekilde yardım eder.
(4) İnananların, imanlarını kat kat artırmaları için, kalblerine güven indiren O'dur. Göklerdeki ve yerdeki ordular Allah'ındır. Allah bilendir, Hakim olandır.
(5) İnanan erkek ve kadınları, içinde temelli kalacakları, içlerinden ırmaklar akan cennetlere koyar, onların kötülüklerini örter. Allah katında büyük kurtuluş işte budur.
(6) İnananlara yardım etmez diye Allah'a kötü sanıda bulunan ikiyüzlü erkek ve kadınlara, puta tapan erek ve kadınlara Allah azabetsin; kötü sanıları kendi baslarına gelsin! Allah onlara gazabetmiş, onları lanetlemiş ve cehennemi kendilerine hazırlamıştır. Ne kötü dönüş yeridir!
(7) Göklerdeki ve yerdeki ordular Allah'ındır. Allah güçlü olandır. Hakim olandır.
(8) Doğrusu seni şahit, müjdeci ve uyarıcı olarak gönderdik. Ey insanlar, siz de Allah'a ve Peygamberine inanasınız, ona yardım edesiniz, O'na saygı gösteresiniz ve O'nu sabah akşam tesbih edesiniz.
(9) Doğrusu seni şahit, müjdeci ve uyarıcı olarak gönderdik. Ey insanlar, siz de Allah'a ve Peygamberine inanasınız, ona yardım edesiniz, O'na saygı gösteresiniz ve O'nu sabah akşam tesbih edesiniz.
(10) Şüphesiz sana baş eğerek ellerini verenler (biat edenler), Allah'a baş eğip el vermiş sayılırlar. Allah'ın eli onların ellerinin üstündedir. Verdiği bu sözden dönen, ancak kendi aleyhine dönmüş olur. Allah'a verdiği sözü yerine getirene, Allah büyük ecir verecektir.
(11) Bedevilerin savaştan geri kalmış olanları, sana: "Bizi mallarımız ve ailelerimiz alıkoydu. Allah'tan bizim bağışlanmamızı dile" diyecekler. Dilleriyle, gönüllerinde bulunmayanı söylerler; de ki: "Allah size bir zarar gelmesini dilerse, yahut bir fayda elde etmenizi dilerse, O'na karşı kimin gücü bir şeye yeter? Kaldı ki, Allah yaptıklarınızdan haberdardır."
(12) Aslında siz, Peygamberin ve inananların, ailelerine bir daha dönmeyeceklerini sanmıştınız. Bu, gönüllerinize güzel görünmüştü de kötü sanıda bulunmuştunuz. Hayırsız bir topluluk oldunuz.
(13) Allah'a ve Peygamberine kim inanmamışsa bilsin ki, şüphesiz Biz, inkarcılar için çılgın alevli cehennemi hazırlamışızdır.
(14) Göklerin ve yerin hükümranlığı Allah'ındır. O, dilediğini bağışlar, dilediğine azabeder. Allah bağışlayandır, merhamet edendir.
(15) Savaştan geri kalmış olanlar, siz ganimetleri almaya giderken: "Bırakın, biz de sizinle gelelim" diyeceklerdir. Onlar Allah'ın sözünü değiştirmek isterler. De ki: "Bize uymayacaksınız; Allah sizin için önceden böyle buyurmuştur." Size: "Hayır, bizi çekemiyorsunuz" diyecekler. Aksine, kendileri ancak pek az söz anlayan kimselerdir.
(16) Bedevilerden geri kalmış olanlara de ki: "güçlü kuvvetli bir millete karşı, onlar müslüman olana kadar savaşmaya çağrılacaksanız; eğer itaat ederseniz Allah size güzel ecir verir, ama daha önce döndüğünüz gibi yine dönecek olursanız sizi can yakan bir azaba uğratır."
(17) Ama, gözleri görmeyen kimse savaşa gelmezse ona bir sorumluluk yoktur; topala ve hastaya da sorumluluk yoktur. Kim Allah'a ve peygamberine itaat ederse, Allah onu, içlerinden ırmaklar akan cennetlere koyar. Kim yüz çevirirse, onu can yakıcı azaba uğratır.
(18) Allah inananlardan, ağaç altında sana baş eğerek el verirlerken, and olsun ki hoşnut olmuştur. Gönüllerinde olanı da bilmiş, onlara güvenlik vermiş, onlara yakın bir zafer ve ele geçirecekleri bol ganimetler bahşetmiştir. Allah, güçlü olandır, Hakim olandır.
(19) Allah inananlardan, ağaç altında sana baş eğerek el verirlerken, and olsun ki hoşnut olmuştur. Gönüllerinde olanı da bilmiş, onlara güvenlik vermiş, onlara yakın bir zafer ve ele geçirecekleri bol ganimetler bahşetmiştir. Allah, güçlü olandır, Hakim olandır.
(20) Allah size, ele geçireceğiniz bol bol ganimetler vadetmiştir. İnananlar için bir belge olması, sizi doğru yola eriştirmesi için bunları size hemen vermiş ve insanların size uzanan ellerini önlemiştir.
(21) Bundan başka, sizin gücünüzün yetmediği fakat Allah'ın sizin için sakladığı ganimetler de vardır. Allah her şeye Kadir olandır.
(22) İnkar edenler sizinle savaşsalardı yüzgeri döneceklerdi. Sonra bir dost ve yardımcı da bulamayacaklardı.
(23) Allah'ın önceden gelip geçmişlere uyguladığı yasası budur. Allah'ın yasasında değişme bulamazsın.
(24) Sizi onlara üstün kıldıktan sonra, Mekke bölgesinde, onların ellerini sizden, sizin ellerinizi onlardan geri tutan, savaşı önleyen O'dur. Allah yaptıklarınızı görendir.
(25) Onlar inkar edenlerdir, sizi Mescidi Haram'ı ziyaretten ve bağlı kurbanları yerlerine gitmekten alıkoyanlardır. Eğer, oradaki henüz tanımadığınız inanmış erkeklerle inanmış kadınları bilmeyerek ezmek suretiyle üzüntüye kapılmanız ihtimali olmasaydı Allah savaşı önlemezdi. Allah, dilediklerine rahmet etmek için böyle yapmıştır. Eğer inananlarla inkarcılar birbirinden ayrılmış olsalardı, inkar edenleri can yakıcı bir azaba uğratırdık.
(26) İnkar edenler, gönüllerindeki cahiliyye çağının asabiyet ateşini ateşlendirdiklerinde, Allah, Peygamberine ve inananlara huzur indirdi; onların takva sözünü tutmalarını sağladı. Onlar, bu söze layık ve ehil kimselerdi. Allah her şeyi bilmektedir.
(27) And olsun ki Allah, Peygamberinin rüyasının gerçek olduğunu tasdik eder. Ey inananlar! Siz, Allah dilerse, güven içinde, başlarınızı tıraş etmiş veya saçlarınızı kısaltmış olarak, korkmadan Mescidi Haram'a gireceksiniz. Allah, sizin bilmediğinizi bilir. Size, bundan başka, yakın zamanda bir zafer verecektir.
(28) Bütün dinlerden üstün kılmak üzere, Peygamberini, doğruluk rehberi Kuran ve hak din ile gönderen O'dur. Şahit olarak Allah yeter.
(29) Muhammed Allah'ın elçisidir. Onun beraberinde bulunanlar, inkarcılara karşı sert, birbirlerine merhametlidirler. Onları rükua varırken, secde ederken, Allah'tan lütuf ve hoşnudluk dilerken görürsün. Onlar, yüzlerindeki secde izi ile tanınırlar. İşte bu, onların Tevrat'ta anlatılan vasıflarıdır. İncil'de de şöyle vasıflandırılmışlardı: Filizini çıkarmış, onu kuvvetlendirmiş, kalınlaşmış, gövdesi üzerine dikilmiş, ekincilerin hoşuna giden ekin gibidirler. Allah böylece bunları çoğaltıp kuvvetlendirmekle inkarcıları öfkelendirir. Allah, inanıp yararlı işler işleyenlere, bağışlama ve büyük ecir vadetmiştir.''',
  ),
  MubarekSureVerisi(
    baslik: 'Vâkı\'a Suresi',
    baslikEn: 'Surah Al-Waqiah',
    audioUrl: 'https://server12.mp3quran.net/maher/056.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
إِذَا وَقَعَتِ الْوَاقِعَةُ
لَيْسَ لِوَقْعَتِهَا كَاذِبَةٌ
خَافِضَةٌ رَافِعَةٌ
إِذَا رُجَّتِ الْأَرْضُ رَجًّا
وَبُسَّتِ الْجِبَالُ بَسًّا
فَكَانَتْ هَبَاءً مُنْبَثًّا
وَكُنْتُمْ أَزْوَاجًا ثَلَاثَةً
فَأَصْحَابُ الْمَيْمَنَةِ مَا أَصْحَابُ الْمَيْمَنَةِ
وَأَصْحَابُ الْمَشْأَمَةِ مَا أَصْحَابُ الْمَشْأَمَةِ
وَالسَّابِقُونَ السَّابِقُونَ
أُولَٰئِكَ الْمُقَرَّبُونَ
فِي جَنَّاتِ النَّعِيمِ
ثُلَّةٌ مِنَ الْأَوَّلِينَ
وَقَلِيلٌ مِنَ الْآخِرِينَ
عَلَىٰ سُرُرٍ مَوْضُونَةٍ
مُتَّكِئِينَ عَلَيْهَا مُتَقَابِلِينَ
يَطُوفُ عَلَيْهِمْ وِلْدَانٌ مُخَلَّدُونَ
بِأَكْوَابٍ وَأَبَارِيقَ وَكَأْسٍ مِنْ مَعِينٍ
لَا يُصَدَّعُونَ عَنْهَا وَلَا يُنْزِفُونَ
وَفَاكِهَةٍ مِمَّا يَتَخَيَّرُونَ
وَلَحْمِ طَيْرٍ مِمَّا يَشْتَهُونَ
وَحُورٌ عِينٌ
كَأَمْثَالِ اللُّؤْلُؤِ الْمَكْنُونِ
جَزَاءً بِمَا كَانُوا يَعْمَلُونَ
لَا يَسْمَعُونَ فِيهَا لَغْوًا وَلَا تَأْثِيمًا
إِلَّا قِيلًا سَلَامًا سَلَامًا
وَأَصْحَابُ الْيَمِينِ مَا أَصْحَابُ الْيَمِينِ
فِي سِدْرٍ مَخْضُودٍ
وَطَلْحٍ مَنْضُودٍ
وَظِلٍّ مَمْدُودٍ
وَمَاءٍ مَسْكُوبٍ
وَفَاكِهَةٍ كَثِيرَةٍ
لَا مَقْطُوعَةٍ وَلَا مَمْنُوعَةٍ
وَفُرُشٍ مَرْفُوعَةٍ
إِنَّا أَنْشَأْنَاهُنَّ إِنْشَاءً
فَجَعَلْنَاهُنَّ أَبْكَارًا
عُرُبًا أَتْرَابًا
لِأَصْحَابِ الْيَمِينِ
ثُلَّةٌ مِنَ الْأَوَّلِينَ
وَثُلَّةٌ مِنَ الْآخِرِينَ
وَأَصْحَابُ الشِّمَالِ مَا أَصْحَابُ الشِّمَالِ
فِي سَمُومٍ وَحَمِيمٍ
وَظِلٍّ مِنْ يَحْمُومٍ
لَا بَارِدٍ وَلَا كَرِيمٍ
إِنَّهُمْ كَانُوا قَبْلَ ذَٰلِكَ مُتْرَفِينَ
وَكَانُوا يُصِرُّونَ عَلَى الْحِنْثِ الْعَظِيمِ
وَكَانُوا يَقُولُونَ أَئِذَا مِتْنَا وَكُنَّا تُرَابًا وَعِظَامًا أَإِنَّا لَمَبْعُوثُونَ
أَوَآبَاؤُنَا الْأَوَّلُونَ
قُلْ إِنَّ الْأَوَّلِينَ وَالْآخِرِينَ
لَمَجْمُوعُونَ إِلَىٰ مِيقَاتِ يَوْمٍ مَعْلُومٍ
ثُمَّ إِنَّكُمْ أَيُّهَا الضَّالُّونَ الْمُكَذِّبُونَ
لَآكِلُونَ مِنْ شَجَرٍ مِنْ زَقُّومٍ
فَمَالِئُونَ مِنْهَا الْبُطُونَ
فَشَارِبُونَ عَلَيْهِ مِنَ الْحَمِيمِ
فَشَارِبُونَ شُرْبَ الْهِيمِ
هَٰذَا نُزُلُهُمْ يَوْمَ الدِّينِ
نَحْنُ خَلَقْنَاكُمْ فَلَوْلَا تُصَدِّقُونَ
أَفَرَأَيْتُمْ مَا تُمْنُونَ
أَأَنْتُمْ تَخْلُقُونَهُ أَمْ نَحْنُ الْخَالِقُونَ
نَحْنُ قَدَّرْنَا بَيْنَكُمُ الْمَوْتَ وَمَا نَحْنُ بِمَسْبُوقِينَ
عَلَىٰ أَنْ نُبَدِّلَ أَمْثَالَكُمْ وَنُنْشِئَكُمْ فِي مَا لَا تَعْلَمُونَ
وَلَقَدْ عَلِمْتُمُ النَّشْأَةَ الْأُولَىٰ فَلَوْلَا تَذَكَّرُونَ
أَفَرَأَيْتُمْ مَا تَحْرُثُونَ
أَأَنْتُمْ تَزْرَعُونَهُ أَمْ نَحْنُ الزَّارِعُونَ
لَوْ نَشَاءُ لَجَعَلْنَاهُ حُطَامًا فَظَلْتُمْ تَفَكَّهُونَ
إِنَّا لَمُغْرَمُونَ
بَلْ نَحْنُ مَحْرُومُونَ
أَفَرَأَيْتُمُ الْمَاءَ الَّذِي تَشْرَبُونَ
أَأَنْتُمْ أَنْزَلْتُمُوهُ مِنَ الْمُزْنِ أَمْ نَحْنُ الْمُنْزِلُونَ
لَوْ نَشَاءُ جَعَلْنَاهُ أُجَاجًا فَلَوْلَا تَشْكُرُونَ
أَفَرَأَيْتُمُ النَّارَ الَّتِي تُورُونَ
أَأَنْتُمْ أَنْشَأْتُمْ شَجَرَتَهَا أَمْ نَحْنُ الْمُنْشِئُونَ
نَحْنُ جَعَلْنَاهَا تَذْكِرَةً وَمَتَاعًا لِلْمُقْوِينَ
فَسَبِّحْ بِاسْمِ رَبِّكَ الْعَظِيمِ
فَلَا أُقْسِمُ بِمَوَاقِعِ النُّجُومِ
وَإِنَّهُ لَقَسَمٌ لَوْ تَعْلَمُونَ عَظِيمٌ
إِنَّهُ لَقُرْآنٌ كَرِيمٌ
فِي كِتَابٍ مَكْنُونٍ
لَا يَمَسُّهُ إِلَّا الْمُطَهَّرُونَ
تَنْزِيلٌ مِنْ رَبِّ الْعَالَمِينَ
أَفَبِهَٰذَا الْحَدِيثِ أَنْتُمْ مُدْهِنُونَ
وَتَجْعَلُونَ رِزْقَكُمْ أَنَّكُمْ تُكَذِّبُونَ
فَلَوْلَا إِذَا بَلَغَتِ الْحُلْقُومَ
وَأَنْتُمْ حِينَئِذٍ تَنْظُرُونَ
وَنَحْنُ أَقْرَبُ إِلَيْهِ مِنْكُمْ وَلَٰكِنْ لَا تُبْصِرُونَ
فَلَوْلَا إِنْ كُنْتُمْ غَيْرَ مَدِينِينَ
تَرْجِعُونَهَا إِنْ كُنْتُمْ صَادِقِينَ
فَأَمَّا إِنْ كَانَ مِنَ الْمُقَرَّبِينَ
فَرَوْحٌ وَرَيْحَانٌ وَجَنَّتُ نَعِيمٍ
وَأَمَّا إِنْ كَانَ مِنْ أَصْحَابِ الْيَمِينِ
فَسَلَامٌ لَكَ مِنْ أَصْحَابِ الْيَمِينِ
وَأَمَّا إِنْ كَانَ مِنَ الْمُكَذِّبِينَ الضَّالِّينَ
فَنُزُلٌ مِنْ حَمِيمٍ
وَتَصْلِيَةُ جَحِيمٍ
إِنَّ هَٰذَا لَهُوَ حَقُّ الْيَقِينِ
فَسَبِّحْ بِاسْمِ رَبِّكَ الْعَظِيمِ''',
    okunus: '''Bismillâhirrahmânirrahîm.
İzâ veka'atil-vâkı'ah.
Leyse li-vak'atihâ kâzibeh.
Hâfidatün râfi'ah.
İzâ rüccetil-ardu reccâ.
Ve büssetil-cibâlü bessâ.
Fe kânet hebâen münbessâ.
Ve küntüm ezvâcen selâseh.
Fe ashâbül-meymeneti mâ ashâbül-meymeneh.
Ve ashâbül-meş'emeti mâ ashâbül-meş'emeh.
Ves-sâbikûnes-sâbikûn.
Ülâikel-mükarrabûn.
Fî cennâtin-naîm.
Sülletün minel-evvelîn.
Ve kalîlün minel-âhirîn.
Alâ sürurin mevdûneh.
Müttekiîne aleyhâ mütekâbilîn.
Yetûfü aleyhim vildânün muhalledûn.
Bi-ekvâbin ve ebârîka ve ke'sin min meîn.
Lâ yüsaddeûne anhâ ve lâ yünzifûn.
Ve fâkihetin mimmâ yetehayyerûn.
Ve lahmi tayrin mimmâ yeştehûn.
Ve hûrun ıyn.
Ke-emsâlil-lü'lüil-meknûn.
Cezâen bimâ kânû ya'melûn.
Lâ yesmeûne fîhâ lağven ve lâ te'sîmâ.
İllâ kîlen selâmen selâmâ.
Ve ashâbül-yemîni mâ ashâbül-yemîn.
Fî sidrin mahdûd.
Ve talhın mendûd.
Ve zıllin memdûd.
Ve mâin meskûb.
Ve fâkihetin kesîrah.
Lâ maktûatin ve lâ memnûah.
Ve fürüşin merfûah.
İnnâ enşe'nâhünne inşââ.
Fe cealnâhünne ebkârâ.
Uruben etrâbâ.
Li-ashâbil-yemîn.
Sülletün minel-evvelîn.
Ve sülletün minel-âhirîn.
Ve ashâbüş-şimâli mâ ashâbüş-şimâl.
Fî semûmin ve hamîm.
Ve zıllin min yahmûm.
Lâ bâridin ve lâ kerîm.
İnnehüm kânû kable zâlike mütrefîn.
Ve kânû yüsirrûne alel-hinsil-azîm.
Ve kânû yekûlûne e izâ mitnâ ve künnâ türâben ve ızâmen e innâ le-meb'ûsûn.
E ve âbâünel-evvelûn.
Kul innel-evvelîne vel-âhirîn.
Le-mecmûûne ilâ mîkāti yevmin ma'lûm.
Sümme inneküm eyyühed-dâllûnel-mükezzibûn.
Le-âkilûne min şecerin min zakkûm.
Fe mâliûne minhâl-butûn.
Fe şâribûne aleyhi minel-hamîm.
Fe şâribûne şürbel-hîm.
Hâzâ nüzülühüm yevmed-dîn.
Nahnü halaknâküm fe levlâ tüsaddikûn.
E feraeytüm mâ tümnûn.
E entüm tahlükûnehû em nahnül-hâlikûn.
Nahnü kaddernâ beynekümül-mevte ve mâ nahnü bi-mesbûkîn.
Alâ en nübeddile emsâleküm ve nünşieküm fî mâ lâ ta'lemûn.
Ve lekad alimtümün-neş'etel-ûlâ fe levlâ tezekkerûn.
E feraeytüm mâ tahrüsûn.
E entüm tezraûnehû em nahnüz-zâriûn.
Lev neşâü le-cealnâhü hutâmen fe zaltüm tefekkehûn.
İnnâ le-muğramûn.
Bel nahnü mahrûmûn.
E feraeytümül-mâellezî teşrabûn.
E entüm enzeltümûhü minel-müzni em nahnül-münzilûn.
Lev neşâü cealnâhü ücâcen fe levlâ teşkürûn.
E feraeytümün-nârelletî tûrûn.
E entüm enşe'tüm şeceretehâ em nahnül-münşiûn.
Nahnü cealnâhâ tezkiraten ve metâan lil-mukvîn.
Fe sebbih bismi rabbikel-azîm.
Fe lâ uksimü bi-mevâkıin-nücûm.
Ve innehû le-kasemün lev ta'lemûne azîm.
İnnehû le-Kur'ânün kerîm.
Fî kitâbin meknûn.
Lâ yemessühû illel-mütahherûn.
Tenzîlün min rabbil-âlemîn.
E fe bi-hâzel-hadîsi entüm müdhınûn.
Ve tec'alûne rizkaküm enneküm tükezzibûn.
Fe levlâ izâ belağatil-hulkûm.
Ve entüm hîneizin tenzurûn.
Ve nahnü akrabü ileyhi minküm ve lâkin lâ tübsirûn.
Fe levlâ in küntüm ğayra medînîn.
Tercîûnehâ in küntüm sâdikîn.
Fe emmâ in kâne minel-mukarrabîn.
Fe ravhun ve reyhânün ve cennetü neîm.
Ve emmâ in kâne min ashâbil-yemîn.
Fe selâmün leke min ashâbil-yemîn.
Ve emmâ in kâne minel-mükezzibîned-dâllîn.
Fe nüzülün min hamîm.
Ve tasliyetü cahîm.
İnne hâzâ le-hüve hakkul-yakîn.
Fe sebbih bismi rabbikel-azîm.''',
    mana:
        '''Mekke döneminde inmiştir. Doksan altı âyettir. "Vâkı'a" olacak, vuku bulacak şey demektir; kıyametin adlarından biridir. Sûrede kıyametin kopacağı, insanların üç gruba ayrılacağı anlatılır: Öne geçenler, sağdakiler ve soldakiler. Bunların âkıbetleriyle birlikte, Allah'ın varlığının ve kudretinin delilleri, öldükten sonra dirilme ve hesap günü tasvir edilir. Her cuma okunması tavsiye edilir.''',
    meal:
        '''(1) Vâkıa (kıyamet) olayı meydana geldiğinde, (2) onun oluşunu yalanlayacak hiç kimse yoktur. (3) O, alçaltıcıdır, yükselticidir. (4) Yer şiddetle sarsıldığı, (5) dağlar parça parça ufalanıp (6) toz duman haline geldiği zaman, (7) sizler (kıyamette) üç sınıf olursunuz. (8) Sağdakiler, ne mutlu o sağdakilere! (9) Soldakiler, ne yazık o soldakilere! (10) Öne geçenler (var ya), öne geçenlerdir. (11) Onlar (Tevbe edip itaat edenlerdir). (12) Onlar nimetlerle dolu cennetlerdedirler. (13) (Onların) bir kısmı önceki ümmetlerden, (14) bir kısmı da sonrakilerdendir. (15) (Onlar) mücevherlerle işlenmiş tahtlara (kurulmuşlardır). (16) Onların üzerinde karşılıklı oturup yaslanırlar. (17) Onların etrafında, ölümsüzlüğe erişmiş gençler dolaşır. (18) Kaynaktan doldurulmuş testiler, ibrikler ve kadehlerle (dolaşırlar). (19) Bu içecekten başları ağrımaz, akılları da gitmez. (20) Beğendikleri meyvelerden, (21) canlarının çektiği kuş etlerinden (alırlar). (22) Onlar için iri ve güzel gözlü huriler vardır. (23) Onlar, sedef içinde saklanmış inciler gibidirler. (24) Yapmakta oldukları iyi işlere karşılık (bu nimetler) onlara verilir. (25) Orada ne boş bir söz ne de günaha sokan bir söz işitirler. (26) Yalnızca birbirlerine: "Selâm, selâm!" (sözünü işitirler). (27) Sağdakiler, ne mutlu o sağdakilere! (28) Dikensiz sedir ağaçları, (29) salkımları sarkmış muz ağaçları, (30) uzamış gölgeler, (31) çağlayıp akan sular, (32) bitip tükenmeyen, yasaklanmayan meyveler, (33) yüksek döşekler arasındadırlar. (34) Doğrusu biz, onları (yeni bir yaratılışla) yarattık. (35) Onları bakireler kıldık. (36) Onları eşlerine düşkün, yaşıt kıldık. (37) (Bütün bunları) sağdakiler için yaptık. (38) Onların bir kısmı öncekilerden, (39) bir kısmı da sonrakilerdendir. (40) Soldakiler, ne yazık o soldakilere! (41) Onlar, ıskıcak bir rüzgâr ve kaynar su içindedirler. (42) Kapkara dumandan bir gölge altındadırlar. (43) (Bu gölge) ne serindir, ne de güzel. (44) Çünkü onlar, bundan önce (dünyada) refah içindeydi. (45) Ve (Allah'a isyan etmekle) devamlı olarak büyüklük taslıyorlardı. (46) Ve onlar, "Ölüp toprağın içine girip kemiklerimiz bozulunca, biz gerçekten diriltilecek miyiz? (47) Baba dedelerimiz de mi?" diye sorarlardı. (48) De ki: "Evet, evvelkiler de, ahırkılar da, (49) muhakkak, belli bir günün saati için toplanacaklar. (50) Sonra sizler, ey sapık yalanlayanlar! (51) Muhtemelen zakkum ağacından yiyeceksiniz. (52) Karnınızı ondan dolduracaksınız. (53) Sonra da onun üzerine kaynar sudan içeceksiniz. (54) İçeceksiniz de, tüketenlerin içişi gibi içeceksiniz. (55) İşte bu, kıyamet günü onların yemeği olacaktır. (56) Biz sizi yarattık, o halde tasdik etmez misiniz? (57) Sizin boşaltıp doldurduğunuz (mani)yı gördünüz mü? (58) Siz mi yaratırsınız, yoksa biz mi yaratıcılarız? (59) Biz, aranızda ölümü takdir ettik ve biz, (sizi başkasıyla değiştirmekten) hiç geri kalmadık. (60) Sizin (şekillerinizi) değiştirip, bilmediğiniz bir yaratılışta sizi yaratıp (başkası yapabiliriz). (61) Andolsun, siz ilk yaratılışı biliyorsunuz. O halde, öğüt almaz mısınız? (62) Ekimip yetiştirdiğiniz şeyi gördünüz mü? (63) Siz mi eklersiniz, yoksa biz mi ekinin sahibiyiz? (64) Eğer istersek onu, sizi hayrete düşüren kuru yapraklar haline getiririz. (65) O zaman sizler: (66) "Biz muhtaç edilendir (veya) biz mah룸uz" diyerek şikayet edersiniz. (67) İçtiğiniz suyu gördünüz mü? (68) Siz mi bulutlardan indirirsiniz, yoksa biz mi indiricileriz? (69) Eğer istersek onu tuzlu (bitmez) yaparız. O halde şükretmez misiniz? (70) Yakmak için yakıp tutturduğunuz ateşi gördünüz mü? (71) Siz mi onun ağacını yetiştirdiniz, yoksa biz mi yetiştirenleriz? (72) Biz onu bir öğüt (hatırlatma) ve çöllüklerin faydası için kıldık. (73) O halde, yüce Rabbinin ismiyle tespih et! (74) Yıldızların batış yerlerine yemin ederim ki, (75) eğer biliyor olsaydınız, bu muazzam bir yemindir. (76) Şüphesiz bu, bir kerim Kur'ândır. (77) Korunmuş bir kitaptır. (78) Onu yalnız mütehherler (melekler) dokunur. (79) Âlemlerin Rabbinin bir indirmesiştir. (80) Bu sözden (Kur'ândan) mi hoşlanmıyorsunuz? (81) Ve rızıklarınızı, yalanlamak için mi ediyorsunuz? (82) Neden, can (boğazınıza) gelip durduğu zaman, (83) siz de o zaman bakıyor durumdasınız? (84) Halbuki biz, o andan sizden daha yakınız; fakat siz görmezsiniz. (85) Eğer siz (Allah'a) borçlu olmadığınızı (müstağni olduğunuzu) söylüyorsanız, (86) o halde canınızı geri getirin, eğer doğru iseniz! (87) Eğer (ölen) yakinlerden (mükerrerin) ise, (88) o, ferah, reyhan ve nimetli bir cennettedir. (89) Ve eğer sağdakilerden ise, "Sağdakilerden olman için selâm olsun sana." (90) Ve eğer yalanlayan sapıklardan ise, (91) onlar için kaynar su bir menudur, (92) ve cehennem ateşinde yakan bir yerdir. (93) Şüphesiz bu, kesin bir hakikat (gerçektir). (94) O halde, yüce Rabbinin ismiyle tespih et!''',
  ),
  MubarekSureVerisi(
    baslik: 'Cuma Suresi',
    baslikEn: 'Surah Al-Jumuah',
    audioUrl: 'https://server12.mp3quran.net/maher/062.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
يُسَبِّحُ لِلَّهِ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ الْمَلِكِ الْقُدُّوسِ الْعَزِيزِ الْحَكِيمِ
هُوَ الَّذِي بَعَثَ فِي الْأُمِّيِّينَ رَسُولًا مِنْهُمْ يَتْلُو عَلَيْهِمْ آيَاتِهِ وَيُزَكِّيهِمْ وَيُعَلِّمُهُمُ الْكِتَابَ وَالْحِكْمَةَ وَإِنْ كَانُوا مِنْ قَبْلُ لَفِي ضَلَالٍ مُبِينٍ
وَآخَرِينَ مِنْهُمْ لَمَّا يَلْحَقُوا بِهِمْ ۚ وَهُوَ الْعَزِيزُ الْحَكِيمُ
ذَٰلِكَ فَضْلُ اللَّهِ يُؤْتِيهِ مَنْ يَشَاءُ ۚ وَاللَّهُ ذُو الْفَضْلِ الْعَظِيمِ
مَثَلُ الَّذِينَ حُمِّلُوا التَّوْرَاةَ ثُمَّ لَمْ يَحْمِلُوهَا كَمَثَلِ الْحِمَارِ يَحْمِلُ أَسْفَارًا ۚ بِئْسَ مَثَلُ الْقَوْمِ الَّذِينَ كَذَّبُوا بِآيَاتِ اللَّهِ ۚ وَاللَّهُ لَا يَهْدِي الْقَوْمَ الظَّالِمِينَ
قُلْ يَا أَيُّهَا الَّذِينَ هَادُوا إِنْ زَعَمْتُمْ أَنَّكُمْ أَوْلِيَاءُ لِلَّهِ مِنْ دُونِ النَّاسِ فَتَمَنَّوُا الْمَوْتَ إِنْ كُنْتُمْ صَادِقِينَ
وَلَا يَتَمَنَّوْنَهُ أَبَدًا بِمَا قَدَّمَتْ أَيْدِيهِمْ ۚ وَاللَّهُ عَلِيمٌ بِالظَّالِمِينَ
قُلْ إِنَّ الْمَوْتَ الَّذِي تَفِرُّونَ مِنْهُ فَإِنَّهُ مُلَاقِيكُمْ ۖ ثُمَّ تُرَدُّونَ إِلَىٰ عَالِمِ الْغَيْبِ وَالشَّهَادَةِ فَيُنَبِّئُكُمْ بِمَا كُنْتُمْ تَعْمَلُونَ
يَا أَيُّهَا الَّذِينَ آمَنُوا إِذَا نُودِيَ لِلصَّلَاةِ مِنْ يَوْمِ الْجُمُعَةِ فَاسْعَوْا إِلَىٰ ذِكْرِ اللَّهِ وَذَرُوا الْبَيْعَ ۚ ذَٰلِكُمْ خَيْرٌ لَكُمْ إِنْ كُنْتُمْ تَعْلَمُونَ
فَإِذَا قُضِيَتِ الصَّلَاةُ فَانْتَشِرُوا فِي الْأَرْضِ وَابْتَغُوا مِنْ فَضْلِ اللَّهِ وَاذْكُرُوا اللَّهَ كَثِيرًا لَعَلَّكُمْ تُفْلِحُونَ
وَإِذَا رَأَوْا تِجَارَةً أَوْ لَهْوًا انْفَضُّوا إِلَيْهَا وَتَرَكُوكَ قَائِمًا ۚ قُلْ مَا عِنْدَ اللَّهِ خَيْرٌ مِنَ اللَّهْوِ وَمِنَ التِّجَارَةِ ۚ وَاللَّهُ خَيْرُ الرَّازِقِينَ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Yüsebbihu lillâhi mâ fis-semâvâti ve mâ fil-ardi, el-melikil-kuddûsil-azîzil-hakîm.
Hüvel-lezî bease fil-ümmiyyîne rasûlen minhüm yetlû aleyhim âyâtihî ve yüzekkîhim ve yüallimühümül-kitâbe vel-hikmeh, ve in kânû min kablü le-fî dalâlin mübîn.
Ve âharîne minhüm lemmâ yelhakû bihim, ve hüvel-azîzül-hakîm.
Zâlike fadlullâhi yü'tîhi men yeşâ, vallâhü zül-fadlil-azîm.
Meselül-lezîne hümmilüt-tevrâte sümme lem yahmilûhâ ke-meselil-hımâri yahmilü esfârâ, bi'se meselül-kavmil-lezîne kezzebû bi-âyâtillâh, vallâhü lâ yehdil-kavmez-zâlimîn.
Kul yâ eyyühel-lezîne hâdû in zeam tüm enneküm evliyâü lillâhi min dûnin-nâsi fe temennevül-mevte in küntüm sâdikîn.
Ve lâ yetemennevnehû ebeden bimâ kaddemet eydîhim, vallâhü alîmün biz-zâlimîn.
Kul innel-mevtellezî tefirrûne minhü feinnehû mülâkîküm, sümme türeddûne ilâ âlimil-ğaybi veş-şehâdeti fe yünebbiüküm bimâ küntüm ta'melûn.
Yâ eyyühel-lezîne âmenû izâ nûdiye lis-salâti min yevmil-cümüati fes'av ilâ zikrillâhi ve zerül-bey', zâliküm hayrun leküm in küntüm ta'lemûn.
Fe izâ kudiyetis-salâtü fenteşirû fil-ardi vebteğû min fadlillâhi vezkürullâhe kesîran lealleküm tüflihûn.
Ve izâ raev ticâreten ev lehveninfaddû ileyhâ ve terakûke kâimâ, kul mâ indallâhi hayrun minel-lehvi ve minet-ticâreh, vallâhü hayrur-râzikîn.''',
    mana:
        '''Medine döneminde inmiştir. On bir âyettir. "Cuma" günü, Cumartesi'dir. Sûrede Allah'ın kudreti, peygamber göndermenin hikmeti ve ümmî topluma peygamber gönderilmesi anlatılır. Dokuz ve onuncu âyetlerinde, Cuma günü namaza çağrıldığında alışverişin bırakılıp namaz için acele edilmesi, namaz bitince de yeryüzüne dağılıp Allah'ın lütfundan istenmesi emredilir. Cuma günü bu sûreyi okumak faziletlidir.''',
    meal:
        '''(1) Göklerde ve yerde olan her şey, mülkün sahibi, eksiklikten münezzeh, azîz ve hakîm olan Allah'ı tespih eder. (2) Çünkü O, ümmîlere, kendilerinden, onlara âyetlerini okuyan, onları temizleyen, onlara Kitab'ı ve hikmeti öğreten bir peygamber gönderendir. Kuşkusuz onlar, bundan önce apaçık bir sapıklık içinde idiler. (3) Henüz kendilerine ulaşmamış bulunan başka kimselere de (bu peygamberi) gönderdi. O, azîzdir, hakîmdir. (4) Bu, Allah'ın lütfudur; onu dilediğine verir. Allah, büyük lütuf sahibidir. (5) Kendilerine Tevrat yükletilip de sonra onu (gereğiyle) taşımayanların durumu, kitaplar taşıyan eşeğin durumu gibidir. Allah'ın âyetlerini yalanlayan bir toplumun hâli ne kötüdür! Allah, zâlimler topluluğunu doğru yola iletmez. (6) De ki: "Ey Yahudiler! Bütün insanlar değil de, yalnız, kendinizin Allah'ın dostları olduğunu iddia ediyorsanız, bunda samimi iseniz, haydi ölümü temenni edin (bakalım)!" (7) Onlar, dünyada işledikleri günahlar yüzünden ölümü hiçbir zaman temenni edemezler. Allah, zâlimleri çok iyi bilir. (8) De ki: "Sizin kendisinden kaçtığınız ölüm, muhakkak sizi karşılayacaktır. Sonra gaybı ve görünen âlemi bilen (Allah)'a döndürüleceksiniz de O, size bütün yaptıklarınızı haber verecektir." (9) Ey iman edenler! Cuma günü namaza çağrıldığı (ezan okunduğu) zaman, hemen Allah'ı anmaya koşun ve alışverişi bırakın. Eğer bilirseniz, bu sizin için daha hayırlıdır. (10) Namaz kılınınca artık yeryüzüne dağılın ve Allah'ın lütfundan isteyin. Allah'ı çok zikredin; umulur ki kurtuluşa erersiniz. (11) Onlar bir ticaret ve eğlence gördükleri zaman hemen dağılıp oraya gittiler ve seni ayakta (hutbe okurken) bıraktılar. De ki: "Allah'ın yanında bulunan (sevap), eğlenceden ve ticaretten daha hayırlıdır. Allah, rızık verenlerin en hayırlısıdır."''',
  ),
  MubarekSureVerisi(
    baslik: 'Haşr Suresi (22-24. Âyetler)',
    baslikEn: 'Surah Al-Hashr (Verses 22-24)',
    audioUrl: 'https://server12.mp3quran.net/maher/059.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
هُوَ اللَّهُ الَّذِي لَا إِلَٰهَ إِلَّا هُوَ ۖ عَالِمُ الْغَيْبِ وَالشَّهَادَةِ ۖ هُوَ الرَّحْمَٰنُ الرَّحِيمُ
هُوَ اللَّهُ الَّذِي لَا إِلَٰهَ إِلَّا هُوَ الْمَلِكُ الْقُدُّوسُ السَّلَامُ الْمُؤْمِنُ الْمُهَيْمِنُ الْعَزِيزُ الْجَبَّارُ الْمُتَكَبِّرُ ۚ سُبْحَانَ اللَّهِ عَمَّا يُشْرِكُونَ
هُوَ اللَّهُ الْخَالِقُ الْبَارِئُ الْمُصَوِّرُ ۖ لَهُ الْأَسْمَاءُ الْحُسْنَىٰ ۚ يُسَبِّحُ لَهُ مَا فِي السَّمَاوَاتِ وَالْأَرْضِ ۖ وَهُوَ الْعَزِيزُ الْحَكِيمُ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Hüvallâhül-lezî lâ ilâhe illâ hüv, âlimül-ğaybi veş-şehâdeh, hüver-rahmânür-rahîm.
Hüvallâhül-lezî lâ ilâhe illâ hüvel-melikül-kuddûsüs-selâmül-mü'minül-müheyminül-azîzül-cebbârul-mütekebbir, sübhânallâhi ammâ yüşrikûn.
Hüvallâhül-hâlikul-bâriül-musavvir, lehül-esmâül-hüsnâ, yüsebbihu lehû mâ fis-semâvâti vel-ard, ve hüvel-azîzül-hakîm.''',
    mana:
        '''Haşr Suresi'nin yirmi ikiden yirmi dörde kadar olan üç âyeti. Bu âyetler, Allah'ın isimlerini ve sıfatlarını en güzel şekilde öğreten âyetlerdir: O, kendisinden başka ilâh olmayan, gaybı ve şahidi bilen, Rahmân ve Rahîm olan Allah'tır. Melik, Kuddûs, Selâm, Mü'min, Müheymin, Azîz, Cebbâr, Mütekebbir'dir. O, yaratan, yoktan var eden, şekil veren Allah'tır; en güzel isimler O'nundur. Sabah ve akşam bu âyetleri okumak faziletlidir; içlerinde Allah'ın Esmâ-i Hüsnâ'sı (en güzel isimleri) toplanmıştır.''',
    meal:
        '''(22) O, öyle Allah'tır ki, O'ndan başka hiçbir ilâh yoktur. Gaybı da, görünen âlemi de bilendir. O, Rahmân'dır, Rahîm'dir. (23) O, öyle Allah'tır ki, O'ndan başka hiçbir ilâh yoktur. O, mülkün gerçek sahibi, her türlü eksiklikten uzak, esenlik veren, güvenlik veren, koruyup gözeten, mutlak galip, iradesini zorla kabul ettiren, büyüklükte eşi olmayandır. Allah, onların ortak koştukları şeylerden çok yücedir. (24) O, yaratan, yoktan var eden, şekil veren Allah'tır. Güzel isimler O'nundur. Göklerdeki ve yerdeki her şey O'nu tespih eder. O, mutlak galip, hikmet sahibidir.''',
  ),
  MubarekSureVerisi(
    baslik: 'Duha Suresi',
    baslikEn: 'Surah Ad-Duha',
    audioUrl: 'https://server12.mp3quran.net/maher/093.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
وَالضُّحَىٰ
وَاللَّيْلِ إِذَا سَجَىٰ
مَا وَدَّعَكَ رَبُّكَ وَمَا قَلَىٰ
وَلَلْآخِرَةُ خَيْرٌ لَكَ مِنَ الْأُولَىٰ
وَلَسَوْفَ يُعْطِيكَ رَبُّكَ فَتَرْضَىٰ
أَلَمْ يَجِدْكَ يَتِيمًا فَآوَىٰ
وَوَجَدَكَ ضَالًّا فَهَدَىٰ
وَوَجَدَكَ عَائِلًا فَأَغْنَىٰ
فَأَمَّا الْيَتِيمَ فَلَا تَقْهَرْ
وَأَمَّا السَّائِلَ فَلَا تَنْهَرْ
وَأَمَّا بِنِعْمَةِ رَبِّكَ فَحَدِّثْ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Ved-duhâ.
Vel-leyli izâ secâ.
Mâ veddeake rabbüke ve mâ kalâ.
Ve lel-âhıratü hayrun leke minel-ûlâ.
Ve le-sevfe yu'tîke rabbüke fe terdâ.
E lem yecidke yetîmen fe âvâ.
Ve vecedeke dâllen fe hedâ.
Ve vecedeke âilen fe ağnâ.
Fe emmel-yetîme fe lâ takher.
Ve emmes-sâile fe lâ tenher.
Ve emmâ bi-ni'meti rabbike fe haddis.''',
    mana:
        '''Mekke döneminde inmiştir. On bir âyettir. "Duha" kuşluk vaktidir. Sûre, Hz. Peygamber'in vahiy gecikince üzülmesi üzerine inmiştir; Allah'ın onu terk etmediğini, darılmadığını bildirir. Âhiretin dünyadan daha hayırlı olduğu, Allah'ın onu yetimken barındırdığı, şaşkınken hidayet verdiği, yoksulken zengin ettiği hatırlatılır. Buna göre yetimi horlamamak, isteyeni azarlamamak ve Rabbin nimetini anlatmak emredilir. Üzüntü ve keder anlarında teselli kaynağıdır.''',
    meal:
        '''(1) Andolsun kuşluk vaktine, (2) ve (insanların sükûnete büründüğü) geceye ki, (3) Rabbin seni bırakmadı ve sana darılmadı. (4) Muhakkak ki âhiret, senin için dünyadan daha hayırlıdır. (5) İleride Rabbin sana verecek de hoşnut olacaksın. (6) O, seni yetim olarak bulup barındırmadı mı? (7) Seni yolunu şaşırmış bir hâlde bulup da yola iletmedi mi? (8) Seni yoksul bulup zengin etmedi mi? (9) Öyleyse sakın yetimi ezme! (10) İsteyeni (yoksulu) azarlama! (11) Rabbinin nimetine gelince, işte onu anlat.''',
  ),
  MubarekSureVerisi(
    baslik: 'İsmi Azam Duası',
    baslikEn: 'Dua of the Greatest Name',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
اللَّهُمَّ إِنِّي أَسْأَلُكَ بِأَنَّ لَكَ الْحَمْدَ، لَا إِلَٰهَ إِلَّا أَنْتَ الْمَنَّانُ، بَدِيعُ السَّمَاوَاتِ وَالْأَرْضِ، يَا ذَا الْجَلَالِ وَالْإِكْرَامِ، يَا حَيُّ يَا قَيُّومُ، إِنِّي أَسْأَلُكَ بِأَنَّكَ أَنْتَ اللَّهُ الَّذِي لَا إِلَٰهَ إِلَّا أَنْتَ، الْوَاحِدُ الْأَحَدُ، الصَّمَدُ، الَّذِي لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Allâhümme innî es'elüke bi-enne lekel-hamd, lâ ilâhe illâ entel-mennân, bedîus-semâvâti vel-ard, yâ zel-celâli vel-ikrâm, yâ Hayyü yâ Kayyûm, innî es'elüke bi-enneke entellâhül-lezî lâ ilâhe illâ ent, el-vâhidül-ehad, es-samed, el-lezî lem yelid ve lem yûled, ve lem yekün lehû küfüven ehad.''',
    mana:
        '''İsmi Azam Duası, Allah'ın en büyük ismiyle yapılan duadır. Bu duada; hamd'in yalnız Allah'a ait olduğu, O'ndan başka ilâh olmadığı, O'nun Mennân (lütufkâr), göklerin ve yerin yaratıcısı, Celâl ve İkram sahibi, Hayy (diri) ve Kayyûm (her şeyi ayakta tutan) olduğu, tek ve bir olan, Samed olan, doğurmayan ve doğurulmayan Allah olduğu dile getirilerek O'ndan bağışlanma ve ihtiyaçların giderilmesi istenir. Bu duanın, Allah'ın en büyük ismiyle edilen dualardan olduğu rivayet edilir.''',
    meal:
        '''"Allah'ım! Hamd yalnız sana aittir. Senden başka hiçbir ilâh yoktur. Ey çok lütufkâr olan (Mennân), ey göklerin ve yerin yaratıcısı, ey celâl ve ikram sahibi, ey diri ve her şeyi ayakta tutan! Senden, senin o en büyük isminin hakkı için istiyorum ki, sen kendisinden başka ilâh olmayan Allah'sın; tek olan, bir olan, her şeyden müstağni olup herkesin kendisine muhtaç olduğu (Samed), doğurmamış ve doğurulmamış, hiçbir şey kendisine denk olmayan Allah'sın. Beni bağışla, günahlarımı ört, rızkımı bereketlendir, dünya ve âhiret işlerimi kolaylaştır ve beni razı olduğun kullarından eyle!"''',
  ),
  MubarekSureVerisi(
    baslik: 'Neml Suresi (30. Âyet)',
    baslikEn: 'Surah An-Naml (Verse 30)',
    audioUrl: 'https://server12.mp3quran.net/maher/027.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
إِنَّهُ مِنْ سُلَيْمَانَ وَإِنَّهُ بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
أَلَّا تَعْلُوا عَلَيَّ وَأْتُونِي مُسْلِمِينَ
قَالَتْ يَا أَيُّهَا الْمَلَأُ إِنِّي أُلْقِيَ إِلَيَّ كِتَابٌ كَرِيمٌ
إِنَّهُ مِنْ سُلَيْمَانَ وَإِنَّهُ بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
أَلَّا تَعْلُوا عَلَيَّ وَأْتُونِي مُسْلِمِينَ''',
    okunus: '''Bismillâhirrahmânirrahîm.
İnnehû min Süleymâne ve innehû bismillâhirrahmânirrahîm.
Ellâ ta'lû aleyye ve'tûnî müslimîn.
Kâlet yâ eyyühel-meleü innî ulkıye ileyye kitâbün kerîm.
İnnehû min Süleymâne ve innehû bismillâhirrahmânirrahîm.
Ellâ ta'lû aleyye ve'tûnî müslimîn.''',
    mana:
        '''Neml Suresi'nin 30. âyeti. Hz. Süleyman, hüdhüt kuşu aracılığıyla Sebe Melikesi Belkıs'a bir mektup göndermiştir. Bu mektubun başı "Bismillâhirrahmânirrahîm" ile başlamakta ve "Bana karşı büyüklük taslamayın, teslim olmuş olarak bana gelin" diye devam etmektedir. Bu âyet, Bismillah'ın ve tevazuyla Allah'a teslim olmanın önemini öğretir; Hz. Süleyman'ın üstünlük taslamadan Allah'ın ismiyle davet etmesini gösterir.''',
    meal:
        '''(29) (Belkıs) dedi ki: "Ey ileri gelenler! Bana çok önemli bir mektup bırakıldı. (30) Mektup, Süleyman'dandır ve 'Rahmân ve Rahîm olan Allah'ın adıyla' başlamaktadır. (31) 'Bana karşı büyüklük taslamayın; teslim olarak bana gelin.'"''',
  ),
  MubarekSureVerisi(
    baslik: 'Neml Suresi',
    baslikEn: 'Surah An-Naml',
    audioUrl: 'https://server12.mp3quran.net/maher/027.mp3',
    reciter: 'Kâbe İmamı Mâhir el-Muaykılî',
    arapca:
        '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ طسٓ ۚ تِلْكَ ءَايَٰتُ ٱلْقُرْءَانِ وَكِتَابٍۢ مُّبِينٍ
هُدًۭى وَبُشْرَىٰ لِلْمُؤْمِنِينَ
ٱلَّذِينَ يُقِيمُونَ ٱلصَّلَوٰةَ وَيُؤْتُونَ ٱلزَّكَوٰةَ وَهُم بِٱلْءَاخِرَةِ هُمْ يُوقِنُونَ
إِنَّ ٱلَّذِينَ لَا يُؤْمِنُونَ بِٱلْءَاخِرَةِ زَيَّنَّا لَهُمْ أَعْمَٰلَهُمْ فَهُمْ يَعْمَهُونَ
أُو۟لَٰٓئِكَ ٱلَّذِينَ لَهُمْ سُوٓءُ ٱلْعَذَابِ وَهُمْ فِى ٱلْءَاخِرَةِ هُمُ ٱلْأَخْسَرُونَ
وَإِنَّكَ لَتُلَقَّى ٱلْقُرْءَانَ مِن لَّدُنْ حَكِيمٍ عَلِيمٍ
إِذْ قَالَ مُوسَىٰ لِأَهْلِهِۦٓ إِنِّىٓ ءَانَسْتُ نَارًۭا سَـَٔاتِيكُم مِّنْهَا بِخَبَرٍ أَوْ ءَاتِيكُم بِشِهَابٍۢ قَبَسٍۢ لَّعَلَّكُمْ تَصْطَلُونَ
فَلَمَّا جَآءَهَا نُودِىَ أَنۢ بُورِكَ مَن فِى ٱلنَّارِ وَمَنْ حَوْلَهَا وَسُبْحَٰنَ ٱللَّهِ رَبِّ ٱلْعَٰلَمِينَ
يَٰمُوسَىٰٓ إِنَّهُۥٓ أَنَا ٱللَّهُ ٱلْعَزِيزُ ٱلْحَكِيمُ
وَأَلْقِ عَصَاكَ ۚ فَلَمَّا رَءَاهَا تَهْتَزُّ كَأَنَّهَا جَآنٌّۭ وَلَّىٰ مُدْبِرًۭا وَلَمْ يُعَقِّبْ ۚ يَٰمُوسَىٰ لَا تَخَفْ إِنِّى لَا يَخَافُ لَدَىَّ ٱلْمُرْسَلُونَ
إِلَّا مَن ظَلَمَ ثُمَّ بَدَّلَ حُسْنًۢا بَعْدَ سُوٓءٍۢ فَإِنِّى غَفُورٌۭ رَّحِيمٌۭ
وَأَدْخِلْ يَدَكَ فِى جَيْبِكَ تَخْرُجْ بَيْضَآءَ مِنْ غَيْرِ سُوٓءٍۢ ۖ فِى تِسْعِ ءَايَٰتٍ إِلَىٰ فِرْعَوْنَ وَقَوْمِهِۦٓ ۚ إِنَّهُمْ كَانُوا۟ قَوْمًۭا فَٰسِقِينَ
فَلَمَّا جَآءَتْهُمْ ءَايَٰتُنَا مُبْصِرَةًۭ قَالُوا۟ هَٰذَا سِحْرٌۭ مُّبِينٌۭ
وَجَحَدُوا۟ بِهَا وَٱسْتَيْقَنَتْهَآ أَنفُسُهُمْ ظُلْمًۭا وَعُلُوًّۭا ۚ فَٱنظُرْ كَيْفَ كَانَ عَٰقِبَةُ ٱلْمُفْسِدِينَ
وَلَقَدْ ءَاتَيْنَا دَاوُۥدَ وَسُلَيْمَٰنَ عِلْمًۭا ۖ وَقَالَا ٱلْحَمْدُ لِلَّهِ ٱلَّذِى فَضَّلَنَا عَلَىٰ كَثِيرٍۢ مِّنْ عِبَادِهِ ٱلْمُؤْمِنِينَ
وَوَرِثَ سُلَيْمَٰنُ دَاوُۥدَ ۖ وَقَالَ يَٰٓأَيُّهَا ٱلنَّاسُ عُلِّمْنَا مَنطِقَ ٱلطَّيْرِ وَأُوتِينَا مِن كُلِّ شَىْءٍ ۖ إِنَّ هَٰذَا لَهُوَ ٱلْفَضْلُ ٱلْمُبِينُ
وَحُشِرَ لِسُلَيْمَٰنَ جُنُودُهُۥ مِنَ ٱلْجِنِّ وَٱلْإِنسِ وَٱلطَّيْرِ فَهُمْ يُوزَعُونَ
حَتَّىٰٓ إِذَآ أَتَوْا۟ عَلَىٰ وَادِ ٱلنَّمْلِ قَالَتْ نَمْلَةٌۭ يَٰٓأَيُّهَا ٱلنَّمْلُ ٱدْخُلُوا۟ مَسَٰكِنَكُمْ لَا يَحْطِمَنَّكُمْ سُلَيْمَٰنُ وَجُنُودُهُۥ وَهُمْ لَا يَشْعُرُونَ
فَتَبَسَّمَ ضَاحِكًۭا مِّن قَوْلِهَا وَقَالَ رَبِّ أَوْزِعْنِىٓ أَنْ أَشْكُرَ نِعْمَتَكَ ٱلَّتِىٓ أَنْعَمْتَ عَلَىَّ وَعَلَىٰ وَٰلِدَىَّ وَأَنْ أَعْمَلَ صَٰلِحًۭا تَرْضَىٰهُ وَأَدْخِلْنِى بِرَحْمَتِكَ فِى عِبَادِكَ ٱلصَّٰلِحِينَ
وَتَفَقَّدَ ٱلطَّيْرَ فَقَالَ مَا لِىَ لَآ أَرَى ٱلْهُدْهُدَ أَمْ كَانَ مِنَ ٱلْغَآئِبِينَ
لَأُعَذِّبَنَّهُۥ عَذَابًۭا شَدِيدًا أَوْ لَأَا۟ذْبَحَنَّهُۥٓ أَوْ لَيَأْتِيَنِّى بِسُلْطَٰنٍۢ مُّبِينٍۢ
فَمَكَثَ غَيْرَ بَعِيدٍۢ فَقَالَ أَحَطتُ بِمَا لَمْ تُحِطْ بِهِۦ وَجِئْتُكَ مِن سَبَإٍۭ بِنَبَإٍۢ يَقِينٍ
إِنِّى وَجَدتُّ ٱمْرَأَةًۭ تَمْلِكُهُمْ وَأُوتِيَتْ مِن كُلِّ شَىْءٍۢ وَلَهَا عَرْشٌ عَظِيمٌۭ
وَجَدتُّهَا وَقَوْمَهَا يَسْجُدُونَ لِلشَّمْسِ مِن دُونِ ٱللَّهِ وَزَيَّنَ لَهُمُ ٱلشَّيْطَٰنُ أَعْمَٰلَهُمْ فَصَدَّهُمْ عَنِ ٱلسَّبِيلِ فَهُمْ لَا يَهْتَدُونَ
أَلَّا يَسْجُدُوا۟ لِلَّهِ ٱلَّذِى يُخْرِجُ ٱلْخَبْءَ فِى ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ وَيَعْلَمُ مَا تُخْفُونَ وَمَا تُعْلِنُونَ
ٱللَّهُ لَآ إِلَٰهَ إِلَّا هُوَ رَبُّ ٱلْعَرْشِ ٱلْعَظِيمِ ۩
۞ قَالَ سَنَنظُرُ أَصَدَقْتَ أَمْ كُنتَ مِنَ ٱلْكَٰذِبِينَ
ٱذْهَب بِّكِتَٰبِى هَٰذَا فَأَلْقِهْ إِلَيْهِمْ ثُمَّ تَوَلَّ عَنْهُمْ فَٱنظُرْ مَاذَا يَرْجِعُونَ
قَالَتْ يَٰٓأَيُّهَا ٱلْمَلَؤُا۟ إِنِّىٓ أُلْقِىَ إِلَىَّ كِتَٰبٌۭ كَرِيمٌ
إِنَّهُۥ مِن سُلَيْمَٰنَ وَإِنَّهُۥ بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ
أَلَّا تَعْلُوا۟ عَلَىَّ وَأْتُونِى مُسْلِمِينَ
قَالَتْ يَٰٓأَيُّهَا ٱلْمَلَؤُا۟ أَفْتُونِى فِىٓ أَمْرِى مَا كُنتُ قَاطِعَةً أَمْرًا حَتَّىٰ تَشْهَدُونِ
قَالُوا۟ نَحْنُ أُو۟لُوا۟ قُوَّةٍۢ وَأُو۟لُوا۟ بَأْسٍۢ شَدِيدٍۢ وَٱلْأَمْرُ إِلَيْكِ فَٱنظُرِى مَاذَا تَأْمُرِينَ
قَالَتْ إِنَّ ٱلْمُلُوكَ إِذَا دَخَلُوا۟ قَرْيَةً أَفْسَدُوهَا وَجَعَلُوٓا۟ أَعِزَّةَ أَهْلِهَآ أَذِلَّةًۭ ۖ وَكَذَٰلِكَ يَفْعَلُونَ
وَإِنِّى مُرْسِلَةٌ إِلَيْهِم بِهَدِيَّةٍۢ فَنَاظِرَةٌۢ بِمَ يَرْجِعُ ٱلْمُرْسَلُونَ
فَلَمَّا جَآءَ سُلَيْمَٰنَ قَالَ أَتُمِدُّونَنِ بِمَالٍۢ فَمَآ ءَاتَىٰنِۦَ ٱللَّهُ خَيْرٌۭ مِّمَّآ ءَاتَىٰكُم بَلْ أَنتُم بِهَدِيَّتِكُمْ تَفْرَحُونَ
ٱرْجِعْ إِلَيْهِمْ فَلَنَأْتِيَنَّهُم بِجُنُودٍۢ لَّا قِبَلَ لَهُم بِهَا وَلَنُخْرِجَنَّهُم مِّنْهَآ أَذِلَّةًۭ وَهُمْ صَٰغِرُونَ
قَالَ يَٰٓأَيُّهَا ٱلْمَلَؤُا۟ أَيُّكُمْ يَأْتِينِى بِعَرْشِهَا قَبْلَ أَن يَأْتُونِى مُسْلِمِينَ
قَالَ عِفْرِيتٌۭ مِّنَ ٱلْجِنِّ أَنَا۠ ءَاتِيكَ بِهِۦ قَبْلَ أَن تَقُومَ مِن مَّقَامِكَ ۖ وَإِنِّى عَلَيْهِ لَقَوِىٌّ أَمِينٌۭ
قَالَ ٱلَّذِى عِندَهُۥ عِلْمٌۭ مِّنَ ٱلْكِتَٰبِ أَنَا۠ ءَاتِيكَ بِهِۦ قَبْلَ أَن يَرْتَدَّ إِلَيْكَ طَرْفُكَ ۚ فَلَمَّا رَءَاهُ مُسْتَقِرًّا عِندَهُۥ قَالَ هَٰذَا مِن فَضْلِ رَبِّى لِيَبْلُوَنِىٓ ءَأَشْكُرُ أَمْ أَكْفُرُ ۖ وَمَن شَكَرَ فَإِنَّمَا يَشْكُرُ لِنَفْسِهِۦ ۖ وَمَن كَفَرَ فَإِنَّ رَبِّى غَنِىٌّۭ كَرِيمٌۭ
قَالَ نَكِّرُوا۟ لَهَا عَرْشَهَا نَنظُرْ أَتَهْتَدِىٓ أَمْ تَكُونُ مِنَ ٱلَّذِينَ لَا يَهْتَدُونَ
فَلَمَّا جَآءَتْ قِيلَ أَهَٰكَذَا عَرْشُكِ ۖ قَالَتْ كَأَنَّهُۥ هُوَ ۚ وَأُوتِينَا ٱلْعِلْمَ مِن قَبْلِهَا وَكُنَّا مُسْلِمِينَ
وَصَدَّهَا مَا كَانَت تَّعْبُدُ مِن دُونِ ٱللَّهِ ۖ إِنَّهَا كَانَتْ مِن قَوْمٍۢ كَٰفِرِينَ
قِيلَ لَهَا ٱدْخُلِى ٱلصَّرْحَ ۖ فَلَمَّا رَأَتْهُ حَسِبَتْهُ لُجَّةًۭ وَكَشَفَتْ عَن سَاقَيْهَا ۚ قَالَ إِنَّهُۥ صَرْحٌۭ مُّمَرَّدٌۭ مِّن قَوَارِيرَ ۗ قَالَتْ رَبِّ إِنِّى ظَلَمْتُ نَفْسِى وَأَسْلَمْتُ مَعَ سُلَيْمَٰنَ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ
وَلَقَدْ أَرْسَلْنَآ إِلَىٰ ثَمُودَ أَخَاهُمْ صَٰلِحًا أَنِ ٱعْبُدُوا۟ ٱللَّهَ فَإِذَا هُمْ فَرِيقَانِ يَخْتَصِمُونَ
قَالَ يَٰقَوْمِ لِمَ تَسْتَعْجِلُونَ بِٱلسَّيِّئَةِ قَبْلَ ٱلْحَسَنَةِ ۖ لَوْلَا تَسْتَغْفِرُونَ ٱللَّهَ لَعَلَّكُمْ تُرْحَمُونَ
قَالُوا۟ ٱطَّيَّرْنَا بِكَ وَبِمَن مَّعَكَ ۚ قَالَ طَٰٓئِرُكُمْ عِندَ ٱللَّهِ ۖ بَلْ أَنتُمْ قَوْمٌۭ تُفْتَنُونَ
وَكَانَ فِى ٱلْمَدِينَةِ تِسْعَةُ رَهْطٍۢ يُفْسِدُونَ فِى ٱلْأَرْضِ وَلَا يُصْلِحُونَ
قَالُوا۟ تَقَاسَمُوا۟ بِٱللَّهِ لَنُبَيِّتَنَّهُۥ وَأَهْلَهُۥ ثُمَّ لَنَقُولَنَّ لِوَلِيِّهِۦ مَا شَهِدْنَا مَهْلِكَ أَهْلِهِۦ وَإِنَّا لَصَٰدِقُونَ
وَمَكَرُوا۟ مَكْرًۭا وَمَكَرْنَا مَكْرًۭا وَهُمْ لَا يَشْعُرُونَ
فَٱنظُرْ كَيْفَ كَانَ عَٰقِبَةُ مَكْرِهِمْ أَنَّا دَمَّرْنَٰهُمْ وَقَوْمَهُمْ أَجْمَعِينَ
فَتِلْكَ بُيُوتُهُمْ خَاوِيَةًۢ بِمَا ظَلَمُوٓا۟ ۗ إِنَّ فِى ذَٰلِكَ لَءَايَةًۭ لِّقَوْمٍۢ يَعْلَمُونَ
وَأَنجَيْنَا ٱلَّذِينَ ءَامَنُوا۟ وَكَانُوا۟ يَتَّقُونَ
وَلُوطًا إِذْ قَالَ لِقَوْمِهِۦٓ أَتَأْتُونَ ٱلْفَٰحِشَةَ وَأَنتُمْ تُبْصِرُونَ
أَئِنَّكُمْ لَتَأْتُونَ ٱلرِّجَالَ شَهْوَةًۭ مِّن دُونِ ٱلنِّسَآءِ ۚ بَلْ أَنتُمْ قَوْمٌۭ تَجْهَلُونَ
۞ فَمَا كَانَ جَوَابَ قَوْمِهِۦٓ إِلَّآ أَن قَالُوٓا۟ أَخْرِجُوٓا۟ ءَالَ لُوطٍۢ مِّن قَرْيَتِكُمْ ۖ إِنَّهُمْ أُنَاسٌۭ يَتَطَهَّرُونَ
فَأَنجَيْنَٰهُ وَأَهْلَهُۥٓ إِلَّا ٱمْرَأَتَهُۥ قَدَّرْنَٰهَا مِنَ ٱلْغَٰبِرِينَ
وَأَمْطَرْنَا عَلَيْهِم مَّطَرًۭا ۖ فَسَآءَ مَطَرُ ٱلْمُنذَرِينَ
قُلِ ٱلْحَمْدُ لِلَّهِ وَسَلَٰمٌ عَلَىٰ عِبَادِهِ ٱلَّذِينَ ٱصْطَفَىٰٓ ۗ ءَآللَّهُ خَيْرٌ أَمَّا يُشْرِكُونَ
أَمَّنْ خَلَقَ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضَ وَأَنزَلَ لَكُم مِّنَ ٱلسَّمَآءِ مَآءًۭ فَأَنۢبَتْنَا بِهِۦ حَدَآئِقَ ذَاتَ بَهْجَةٍۢ مَّا كَانَ لَكُمْ أَن تُنۢبِتُوا۟ شَجَرَهَآ ۗ أَءِلَٰهٌۭ مَّعَ ٱللَّهِ ۚ بَلْ هُمْ قَوْمٌۭ يَعْدِلُونَ
أَمَّن جَعَلَ ٱلْأَرْضَ قَرَارًۭا وَجَعَلَ خِلَٰلَهَآ أَنْهَٰرًۭا وَجَعَلَ لَهَا رَوَٰسِىَ وَجَعَلَ بَيْنَ ٱلْبَحْرَيْنِ حَاجِزًا ۗ أَءِلَٰهٌۭ مَّعَ ٱللَّهِ ۚ بَلْ أَكْثَرُهُمْ لَا يَعْلَمُونَ
أَمَّن يُجِيبُ ٱلْمُضْطَرَّ إِذَا دَعَاهُ وَيَكْشِفُ ٱلسُّوٓءَ وَيَجْعَلُكُمْ خُلَفَآءَ ٱلْأَرْضِ ۗ أَءِلَٰهٌۭ مَّعَ ٱللَّهِ ۚ قَلِيلًۭا مَّا تَذَكَّرُونَ
أَمَّن يَهْدِيكُمْ فِى ظُلُمَٰتِ ٱلْبَرِّ وَٱلْبَحْرِ وَمَن يُرْسِلُ ٱلرِّيَٰحَ بُشْرًۢا بَيْنَ يَدَىْ رَحْمَتِهِۦٓ ۗ أَءِلَٰهٌۭ مَّعَ ٱللَّهِ ۚ تَعَٰلَى ٱللَّهُ عَمَّا يُشْرِكُونَ
أَمَّن يَبْدَؤُا۟ ٱلْخَلْقَ ثُمَّ يُعِيدُهُۥ وَمَن يَرْزُقُكُم مِّنَ ٱلسَّمَآءِ وَٱلْأَرْضِ ۗ أَءِلَٰهٌۭ مَّعَ ٱللَّهِ ۚ قُلْ هَاتُوا۟ بُرْهَٰنَكُمْ إِن كُنتُمْ صَٰدِقِينَ
قُل لَّا يَعْلَمُ مَن فِى ٱلسَّمَٰوَٰتِ وَٱلْأَرْضِ ٱلْغَيْبَ إِلَّا ٱللَّهُ ۚ وَمَا يَشْعُرُونَ أَيَّانَ يُبْعَثُونَ
بَلِ ٱدَّٰرَكَ عِلْمُهُمْ فِى ٱلْءَاخِرَةِ ۚ بَلْ هُمْ فِى شَكٍّۢ مِّنْهَا ۖ بَلْ هُم مِّنْهَا عَمُونَ
وَقَالَ ٱلَّذِينَ كَفَرُوٓا۟ أَءِذَا كُنَّا تُرَٰبًۭا وَءَابَآؤُنَآ أَئِنَّا لَمُخْرَجُونَ
لَقَدْ وُعِدْنَا هَٰذَا نَحْنُ وَءَابَآؤُنَا مِن قَبْلُ إِنْ هَٰذَآ إِلَّآ أَسَٰطِيرُ ٱلْأَوَّلِينَ
قُلْ سِيرُوا۟ فِى ٱلْأَرْضِ فَٱنظُرُوا۟ كَيْفَ كَانَ عَٰقِبَةُ ٱلْمُجْرِمِينَ
وَلَا تَحْزَنْ عَلَيْهِمْ وَلَا تَكُن فِى ضَيْقٍۢ مِّمَّا يَمْكُرُونَ
وَيَقُولُونَ مَتَىٰ هَٰذَا ٱلْوَعْدُ إِن كُنتُمْ صَٰدِقِينَ
قُلْ عَسَىٰٓ أَن يَكُونَ رَدِفَ لَكُم بَعْضُ ٱلَّذِى تَسْتَعْجِلُونَ
وَإِنَّ رَبَّكَ لَذُو فَضْلٍ عَلَى ٱلنَّاسِ وَلَٰكِنَّ أَكْثَرَهُمْ لَا يَشْكُرُونَ
وَإِنَّ رَبَّكَ لَيَعْلَمُ مَا تُكِنُّ صُدُورُهُمْ وَمَا يُعْلِنُونَ
وَمَا مِنْ غَآئِبَةٍۢ فِى ٱلسَّمَآءِ وَٱلْأَرْضِ إِلَّا فِى كِتَٰبٍۢ مُّبِينٍ
إِنَّ هَٰذَا ٱلْقُرْءَانَ يَقُصُّ عَلَىٰ بَنِىٓ إِسْرَٰٓءِيلَ أَكْثَرَ ٱلَّذِى هُمْ فِيهِ يَخْتَلِفُونَ
وَإِنَّهُۥ لَهُدًۭى وَرَحْمَةٌۭ لِّلْمُؤْمِنِينَ
إِنَّ رَبَّكَ يَقْضِى بَيْنَهُم بِحُكْمِهِۦ ۚ وَهُوَ ٱلْعَزِيزُ ٱلْعَلِيمُ
فَتَوَكَّلْ عَلَى ٱللَّهِ ۖ إِنَّكَ عَلَى ٱلْحَقِّ ٱلْمُبِينِ
إِنَّكَ لَا تُسْمِعُ ٱلْمَوْتَىٰ وَلَا تُسْمِعُ ٱلصُّمَّ ٱلدُّعَآءَ إِذَا وَلَّوْا۟ مُدْبِرِينَ
وَمَآ أَنتَ بِهَٰدِى ٱلْعُمْىِ عَن ضَلَٰلَتِهِمْ ۖ إِن تُسْمِعُ إِلَّا مَن يُؤْمِنُ بِـَٔايَٰتِنَا فَهُم مُّسْلِمُونَ
۞ وَإِذَا وَقَعَ ٱلْقَوْلُ عَلَيْهِمْ أَخْرَجْنَا لَهُمْ دَآبَّةًۭ مِّنَ ٱلْأَرْضِ تُكَلِّمُهُمْ أَنَّ ٱلنَّاسَ كَانُوا۟ بِـَٔايَٰتِنَا لَا يُوقِنُونَ
وَيَوْمَ نَحْشُرُ مِن كُلِّ أُمَّةٍۢ فَوْجًۭا مِّمَّن يُكَذِّبُ بِـَٔايَٰتِنَا فَهُمْ يُوزَعُونَ
حَتَّىٰٓ إِذَا جَآءُو قَالَ أَكَذَّبْتُم بِـَٔايَٰتِى وَلَمْ تُحِيطُوا۟ بِهَا عِلْمًا أَمَّاذَا كُنتُمْ تَعْمَلُونَ
وَوَقَعَ ٱلْقَوْلُ عَلَيْهِم بِمَا ظَلَمُوا۟ فَهُمْ لَا يَنطِقُونَ
أَلَمْ يَرَوْا۟ أَنَّا جَعَلْنَا ٱلَّيْلَ لِيَسْكُنُوا۟ فِيهِ وَٱلنَّهَارَ مُبْصِرًا ۚ إِنَّ فِى ذَٰلِكَ لَءَايَٰتٍۢ لِّقَوْمٍۢ يُؤْمِنُونَ
وَيَوْمَ يُنفَخُ فِى ٱلصُّورِ فَفَزِعَ مَن فِى ٱلسَّمَٰوَٰتِ وَمَن فِى ٱلْأَرْضِ إِلَّا مَن شَآءَ ٱللَّهُ ۚ وَكُلٌّ أَتَوْهُ دَٰخِرِينَ
وَتَرَى ٱلْجِبَالَ تَحْسَبُهَا جَامِدَةًۭ وَهِىَ تَمُرُّ مَرَّ ٱلسَّحَابِ ۚ صُنْعَ ٱللَّهِ ٱلَّذِىٓ أَتْقَنَ كُلَّ شَىْءٍ ۚ إِنَّهُۥ خَبِيرٌۢ بِمَا تَفْعَلُونَ
مَن جَآءَ بِٱلْحَسَنَةِ فَلَهُۥ خَيْرٌۭ مِّنْهَا وَهُم مِّن فَزَعٍۢ يَوْمَئِذٍ ءَامِنُونَ
وَمَن جَآءَ بِٱلسَّيِّئَةِ فَكُبَّتْ وُجُوهُهُمْ فِى ٱلنَّارِ هَلْ تُجْزَوْنَ إِلَّا مَا كُنتُمْ تَعْمَلُونَ
إِنَّمَآ أُمِرْتُ أَنْ أَعْبُدَ رَبَّ هَٰذِهِ ٱلْبَلْدَةِ ٱلَّذِى حَرَّمَهَا وَلَهُۥ كُلُّ شَىْءٍۢ ۖ وَأُمِرْتُ أَنْ أَكُونَ مِنَ ٱلْمُسْلِمِينَ
وَأَنْ أَتْلُوَا۟ ٱلْقُرْءَانَ ۖ فَمَنِ ٱهْتَدَىٰ فَإِنَّمَا يَهْتَدِى لِنَفْسِهِۦ ۖ وَمَن ضَلَّ فَقُلْ إِنَّمَآ أَنَا۠ مِنَ ٱلْمُنذِرِينَ
وَقُلِ ٱلْحَمْدُ لِلَّهِ سَيُرِيكُمْ ءَايَٰتِهِۦ فَتَعْرِفُونَهَا ۚ وَمَا رَبُّكَ بِغَٰفِلٍ عَمَّا تَعْمَلُونَ''',
    okunus:
        '''Bismillâhirrahmânirrahîm.
Taa-Seeen; tilka Aayaatul Qur-aani wa Kitaabim Mubeen
Hudanw wa bushraa lil mu'mineen
Allazeena yuqeemoonas Salaata wa yu'toonaz Zakaata wa hum bil Aakhirati hum yooqinoon
Innal lazeena laa yu'mimoona bil Aakhirati zaiyannaa lahum a'maalahum fahum ya'mahoon
Ulaaa'ikal lazeena lahum sooo'ul 'azaabi wa hum fil Aakhirati humul akhsaroon
Wa innaka latulaqqal Qur-aana mil ladun Hakeemin 'Aleem
Iz qaala Moosaa li ahliheee inneee aanastu naaran saaateekum minhaa bikhabarin aw aateekum bishihaabin qabasil la'allakum tastaloon
Falammaa jaaa'ahaa noodiya am boorika man finnnnaari wa man hawlahaa wa Subhaanal laahi Rabbil 'aalameen
Yaa Moosaaa innahooo Anal laahul 'Azeezul Hakeem
Wa alqi 'asaak; falammmaa ra aahaa tahtazzu ka annahaa jaaannunw wallaa mudbiranw wa lam yu'aqqib; yaa Moosaa laa takhaf innee laa yakhaafu ladaiyal mursaloon
Illaa man zalama summa baddala husnam ba'da sooo'in fa innee Ghafoorur Raheem
Wa adkhil yadaka fee jaibika takhruj baidaaa'a min ghairisooo'in feetis'i Aayaatin ilaa Fir'awna wa qawmih; innahum kaanoo qawman faasiqeen
Falammaa jaaa'at hum Aayaatunaa mubsiratan qaaloo haazaa sihrum mubeen
Wa jahadoo bihaa wastaiqanat haaa anfusuhum zulmanw-wa 'uluwwaa; fanzur kaifa kaana 'aaqibatul mufsideen
Wa laqad aatainaa Daawooda wa sulaimaana 'ilmaa; wa qaalal hamdu lil laahil lazee faddalanaa 'alaa kaseerim min 'ibaadihil mu'mineen
Wa warisa Sulaimaanu Daawooda wa qaala yaaa aiyuhan naasu 'ullimnaa mantiqat tairi wa ooteenaa min kulli shai'in inna haazaa lahuwal fadlul mubeen
Wa hushira Sulaimaana junooduhoo minal jinni wal insi wattairi fahum yooza'oon
hattaaa izaaa ataw 'alaa waadin namli qaalat namlatuny yaaa aiyuhan namlud khuloo masaakinakum laa yahtimannakum Sulaimaanu wa junooduhoo wa hum laa yash'uroon
Fatabassama daahikam min qawlihaa wa qaala Rabbi awzi'nee an ashkura ni'mata kal lateee an'amta 'alaiya wa 'alaa waalidaiya wa an a'mala saalihan tardaahu wa adkhilnee birahmatika fee 'ibaadikas saaliheen
Wa tafaqqadat taira faqaala maa liya laaa aral hud hud, am kaana minal ghaaa'ibeen
La-u'azzibanahoo 'azaaban shadeedan aw la azbahannahoo aw layaatiyannee bisultaanim mubeen
Famakasa ghaira ba'eedin faqaala ahattu bimaa lam tuhit bihee wa ji'tuka min Sabaim binaba iny-yaqeen
Innee wajattum ra atan tamlikuhum wa ootiyat min kulli shai'inw wa lahaa 'arshun 'azeem
Wajattuhaa wa qawmahaa yasjudoona lishshamsi min doonil laahi wa zaiyana lahumush Shaitaanu a'maalahum fasaddahum 'anis sabeeli fahum laa yahtadoon
Allaa yasjudoo lillaahil lazee yukhrijul khab'a fis samaawaati wal ardi wa ya'lamu maa tukhfoona wa maa tu'linoon
Allaahu laaa ilaaha illaa Huwa Rabbul 'Arshil Azeem
Qaala sananzuru asadaqta am kunta minal kaazibeen
Izhab bikitaabee haaza fa alqih ilaihim summma tawalla 'anhum fanzur maazaa yarji'oon
Qaalat yaaa aiyuhal mala'u innee ulqiya ilaiya kitaabun kareem
Innahoo min Sulaimaana wa innahoo bismil laahir Rahmaanir Raheem
Allaa ta'loo 'alaiya waa toonee muslimeen
Qaalat yaaa aiyuhal mala'u aftoonee fee amree maa kuntu qaati'atan amran hattaa tashhhaddon
Qaaloo nahnu uloo quwwatinw wa uloo baasin shadeed; wal amru ilaiki fanzuree maazaa taamureen
Qaalat innal mulooka izaa dakhaloo qaryatan afsadoohaa wa ja'alooo a'izzata ahlihaaa azillah; wa kazaalika yaf'aloon
Wa innee mursilatun ilaihim bihadiyyatin fanaaziratum bima yarji'ul mursaloon
Falammaa jaaa'a Sulaimaana qaala atumiddoonani bimaalin famaaa aataakum bal antum bihadiy yatikum tafrahoon
Irji' ilaihim falanaatiyan nahum bijunoodil laa qibala lahum bihaa wa lanukhri jannahum minhaaa azillatanw wa hum saaghiroon
Qaala yaaa aiyuhal mala'u aiyukum yaateenee bi'arshihaa qabla ai yaatoonee muslimeen
Qaala 'ifreetum minal jinni ana aateeka bihee qabla an taqooma mim maqaamika wa innee 'alaihi laqawiyyun ameen
Qaalal lazee indahoo 'ilmum minal Kitaabi ana aateeka bihee qabla ai yartadda ilaika tarfuk; falammaa ra aahu mustaqirran 'indahoo qaala haazaa min fadli Rabbee li yabluwaneee 'a-ashkuru am akfuru wa man shakara fa innamaa yashkuru linafsihee wa man kafara fa inna Rabbee Ghaniyyun Kareem
Qaala nakkiroo lahaa 'arshahaa nanzur atahtadeee am takoonu minal lazeena laa yahtadoon
Falammaa jaaa'at qeela ahaakaza 'arshuki qaalat kaanna hoo; wa ooteenal 'ilma min qablihaa wa kunnaa muslimeen
Wa saddahaa maa kaanat ta'budu min doonil laahi innahaa kaanat min qawmin kaafireen
Qeela lahad khulis sarha falammaa ra at hu hasibat hu lujjatanw wa khashafat 'an saaqaihaa; qaala innahoo sarhum mumarradum min qawaareer; qaalat Rabbi innee zalamtu nafsee wa aslamtu ma'a Sulaimaana lillaahi Rabbil 'aalameen
Wa laqad arsalnaaa ilaa Samoda akhaahum Saalihan ani'budul lahha fa izaa hum fareeqaani yakhtasimoon
Qaala yaa qawmi lima tasta'jiloona bissaiyi'ati qablal hasanati law laa tas taghfiroonal laaha la'allakum turhamoon
Qaalut taiyarnaa bika wa bimam ma'ak; qaala taaa'irukum 'indal laahi bal antum qawmun tuftanoon
Wa kaana fil madeenati tis'atu rahtiny yufsidoona fil ardi wa laa yuslihoon
Qaaloo taqaasamoo billaahi lanubaiyitannahoo wa ahlahoo summaa lanaqoolana liwaliy yihee maa shahidnaa mahlika ahliee wa innaa lasaadiqoon
Wa makaroo makranw wa makarnaa makranw wa hum laa yash'uroon
Fanzur kaifa kaana 'aaqibatu makrihim annaa dammar naahum wa qawmahum ajma'een
Fatilka buyootuhum khaa wiyatam bimaa zalamoo; inna fee zaalika la Aayatal liqaw miny-ya'lamoon
Wa anjainal lazeena aamanoo wa kaanoo yattaqoon
Wa lootan iz qaala liqawmiheee ataatoonal faa hishata wa antum qawmun tajjhaloon
A'innakum lataatoonar rijaala shahwatam min doonin nisaaa'; bal antum qawmun tajhaloon
Fammaa kaana jawaaba qawmiheee illaaa an qaalooo akrijoon aalaa Lootim min qaryatikum innahum unaasuny yatatahharoon
Fa anjainaahu wa ahlahooo illam ra atahoo qaddarnaahaa minal ghaabireen
Wa amtarnaa 'alaihimm mataran fasaaa'a matarul munzareen
Qulil hamdu lillaahi wa salaamun 'alaa 'ibaadihil lazeenas tafaa; aaallaahu khairun ammmaa yushrikoon
Amman khalaqas samaawaati wal arda wa anzala lakum minas samaaa'i maaa'an fa ambatnaa bihee hadaaa'iqa zaata bahjjah; maa kanna lakum an tumbitoo shajarahaa; 'a-ilaahum ma'al laah; bal hum qawmuny ya'diloon
Ammann ja'alal arda qaraaranw wa ja'ala khilaalahaaa anhaaranw wa ja'ala lahaa rawaasiya wa ja'ala bainal bahraini haajizaa; 'a-ilaahumma'allah; bal aksaruhum la ya'lamoon
Ammany-yujeebul mud tarra izaa da'aahu wa yakshifussooo'a wa yaj'alukum khula faaa'al ardi 'a-ilaahum ma'al laahi qaleelam maa tazak karoon
Ammany-yahdeekum fee zulumaatil barri wal bahri wa many yursilu riyaaha bushram baina yadai rahmatih; 'a-ilaahum ma'al laah; Ta'aalal laahu 'ammaa yushrikoon
Ammmany-yabda'ul khalqa summa yu'eeduhoo wa many-yarzuqukum minas sammaaa'i wal ard; 'a-ilaahum ma'allah; qul haatoo burhaanakum in kuntum saadiqeen
Qul laa ya'lamu mman fis sammaawaati wal ardil ghaiba illal laah; wa maa yash'uroona aiyaana yub'asoon
Balid daaraka 'ilmuhum fil Aakhirah; bal hum fee shakkim minhaa bal hum minhaa 'amoon
Wa qaalal lazeena kafarooo 'a-izaa kunnaa turaabanw wa aabaaa'unaaa a'innaa lamukhrajoon
Laqad wu'idnaa haazaa nahnu wa aabaaa'unaa min qablu in haazaaa illaaa asaateerul awwaleen
Qul seeroo fil ardi fanzuroo kaifa kaana 'aaqibatul mujremeen
Wa laa tahzan 'alaihim wa laa takun fee daiqim mimmaa yamkuroon
Wa yaqooloona mataa haazal wa'du in kuntum saadiqeen
Qul 'asaaa any-yakoona radifa lakum ba'dul lazee tasta'jiloon
Wa innna Rabbaka lazoo fadlin 'alan naasi wa laakina aksarahum laa yashkuroon
Wa inna Rabbaka la ya'lamu maa tukinnu sudooruhum wa maa yu'linoon
Wa maa min ghaaa'ibatin fis samaaa'i wal ardi illaa fee kitaabimm mubeen
Inna haazal Qur-aana yaqussu 'alaa Baneee israaa'eela aksaral lazee hum feehi yakhtalifoon
Wa innahoo lahudanw wa rahmatul lilmu'mineen
Inna Rabbaka yaqdee bainahum bihukmih; wa Huwal 'Azeezul 'Aleem
Fatawakkal 'alal laahi innaka 'alal haqqil mubeen
Innaka laa tusmi'ul mawtaa wa laa tusmi'us summad du'aaa izaa wallaw mudbireen
Wa maaa anta bihaadil 'umyi 'an dalaalatihim in tusmi'u illaa mai yu'minu bi aayaatinaa fahum muslimoon
Wa izaa waqa'al qawhu 'alaihim akhrajnaa lahum daabbatam minal ardi tukal limuhum annan naasa kaanoo bi aayaatinaa laa yooqinoon
Wa Yawma nahshuru min kulli ummmatin fawjam mim many-yukazzibu bi Aayaatinaa fahum yooza'oon
Hattaaa izaa jaaa'oo qaala akazzabtum bi Aayaatee wa lam tuheetoo bihaa 'ilman ammaazaa kuntum ta'maloon
Wa waqa'al qawlu 'alaihim bimaa zalamoo fahum laa yantiqoon
Alam yaraw annaa ja'alnal laila li yaskunoo feehi wannahaara mubsiraa; inna fee zaalika la Aayaatil liqaw miny-yu'minoon
Wa Yawma yunfakhu fis Soori fafazi'a man fis samaawaati wa man fil ardi illaa man shaaa'al laah; wa kullun atawhu daakhireen
Wa taral jibaala tahsabuhaa jaamidatanw wa hiya tamurru marras sahaab; sun'al laahil lazeee atqana kulla shai'; innahoo khabeerum bimaa taf'aloon
Man jaaa'a bilhasanati falahoo khairum minhaa wa hum min faza'iny Yawma'izin aaminoon
Wa man jaaa'a bissai yi'ati fakubbat wujoohuhum fin Naari hal tujzawna illaa maa kuntum ta'maloon
Innamaaa umirtu an a'buda Rabba haazihil baldatil lazee harramahaa wa lahoo kullu shai'inw wa umirtu an akoona minal muslimeen
Wa an atluwal Qur-aana famanih tadaa fa innnamaa yahtadee linafsihee wa man dalla faqul innamaaa ana minal munzireen
Wa qulil hamdu lillaahi sa yureekum Aayaatihee fata'ri foonahaa; wa maa Rabbuka bighaaflin 'ammaa ta'maloon''',
    mana:
        '''Mekke döneminde inmiştir. Doksan üç âyettir. "Neml" karınca demektir. Sûrenin başında Kitab'ın (Kur'ân'ın) müminlere hidayet ve müjde olduğu, namazı kılıp zekâtı veren ve âhirete kesin inananların kurtulacağı belirtilir. Ardından Hz. Musa'nın Tur dağındaki mücadelesi, Hz. Süleyman'ın kuşlarla konuşması, Belkıs'ın İslam'a daveti anlatılır. Karıncanın Hz. Süleyman'a hitabı, Allah'a şükür ve teslimiyet örneğidir. Allah'ın kudretinin delilleri ve peygamberlerin daveti anlatılır.''',
    meal:
        '''(1) Ta, Sin, Bunlar Kuran'ın, Kitab-ı Mübin'in ayetleridir.
(2) Bunlar, namaz kılan, zekat veren ve ahirete de kesin olarak inanan müminlere doğruluk rehberi ve müjdedir.
(3) Bunlar, namaz kılan, zekat veren ve ahirete de kesin olarak inanan müminlere doğruluk rehberi ve müjdedir.
(4) Ahirete inanmayanların yaptıkları işleri kendilerine güzel göstermişizdir; bu yüzden körü körüne bocalarlar.
(5) Kötü azap işte bunlaradır. Ahirette en çok kayba uğrayacaklar da bunlardır.
(6) Şüphesiz, Kuran'ı, Hakim ve Alim olan Allah katından almaktasın.
(7) Musa, ailesine: "Ben bir ateş gördüm; size oradan ya bir haber getireceğim, yahut ısınasınız diye tutuşmuş bir odun getireceğim" demişti.
(8) Oraya geldiğinde, kendisine şöyle nida olunmuştu: "Ateşin yanında olan ve çevresinde bulunanlar mübarek kılınmıştır. Alemlerin Rabbi olan Allah münezzehtir"
(9) "Ey Musa! Gerçek şu ki, Ben, güçlü ve hakim olan Allah'ım"
(10) "Değneğini at!" Musa, değneğinin yılan gibi hareketler yaptığını görünce, arkasına bakmadan dönüp kaçtı. "Ey Musa! Korkma; Benim katımda peygamberler korkmaz; yalnız haksızlık eden bunun dışındadır. Kötü hali iyiliğe çeviren kimse bilsin ki Ben şüphesiz bağışlarım, merhamet ederim. Elini koynuna sok, Firavun ve milletine gönderilen dokuz mucizeden biri olarak kusursuz, bembeyaz çıksın. Gerçekten onlar yoldan çıkmış bir millettir."
(11) "Değneğini at!" Musa, değneğinin yılan gibi hareketler yaptığını görünce, arkasına bakmadan dönüp kaçtı. "Ey Musa! Korkma; Benim katımda peygamberler korkmaz; yalnız haksızlık eden bunun dışındadır. Kötü hali iyiliğe çeviren kimse bilsin ki Ben şüphesiz bağışlarım, merhamet ederim. Elini koynuna sok, Firavun ve milletine gönderilen dokuz mucizeden biri olarak kusursuz, bembeyaz çıksın. Gerçekten onlar yoldan çıkmış bir millettir."
(12) "Değneğini at!" Musa, değneğinin yılan gibi hareketler yaptığını görünce, arkasına bakmadan dönüp kaçtı. "Ey Musa! Korkma; Benim katımda peygamberler korkmaz; yalnız haksızlık eden bunun dışındadır. Kötü hali iyiliğe çeviren kimse bilsin ki Ben şüphesiz bağışlarım, merhamet ederim. Elini koynuna sok, Firavun ve milletine gönderilen dokuz mucizeden biri olarak kusursuz, bembeyaz çıksın. Gerçekten onlar yoldan çıkmış bir millettir."
(13) Ayetlerimiz gözlerinin önüne serilince: "Bu apaçık bir sihirdir" dediler.
(14) Gönülleri kesin olarak kabul ettiği halde, haksızlık ve büyüklenmelerinden ötürü onları bile bile inkar ettiler. Bozguncuların sonunun nasıl olduğuna bir bak!
(15) And olsun ki, Davud'a ve Süleyman'a ilim verdik. İkisi "Bizi mümin kullarının çoğundan üstün kılan Allah'a hamdolsun" dediler.
(16) Süleyman Davud'a varis oldu: "Ey insanlar! Bize kuş dili öğretildi ve bize herşeyden bolca verildi. Doğrusu bu apaçık bir lütuftur" dedi.
(17) Süleyman'ın cinlerden, insanlardan ve kuşlardan müteşekkil olan ordusu toplandı. Hepsi toplu olarak gidiyorlardı.
(18) Sonunda, karıncaların bulunduğu vadiye geldiklerinde bir dişi (kraliçe) karınca: "Ey karıncalar! Yuvalarınıza girin, Süleyman'ın ordusu farkına varmadan sizi ezmesin" dedi.
(19) Süleyman, onun sözüne hafifçe güldü ve: "Rabbim! Bana ve ana babama verdiğin nimete şükürde, hoşnut olacağın işi yapmakta beni muvaffak kıl. Rahmetinle, beni iyi kullarının arasına koy" dedi.
(20) Süleyman, kuşları araştırarak: "Hüdhüd'ü niçin göremiyorum? Yoksa kayıplarda mı? Bana apaçık bir delil getirmelidir; yoksa onu ya şiddetli bir azaba uğratırım yahut keserim" dedi.
(21) Süleyman, kuşları araştırarak: "Hüdhüd'ü niçin göremiyorum? Yoksa kayıplarda mı? Bana apaçık bir delil getirmelidir; yoksa onu ya şiddetli bir azaba uğratırım yahut keserim" dedi.
(22) Çok geçmeden Hüdhüd gelip Süleyman'a: "Senin bilmediğin bir şeyi öğrendim. Sana Sebe'den doğru bir haber getirdim. Ora halkına hükmeden, herşeyden kendisine bolca verilen ve büyük bir tahta sahip olan bir kadın buldum; onun ve milletinin Allah'ı bırakıp güneşe secde ettiklerini gördüm. Göklerde ve yerde gizli olanları ortaya koyan, gizlediğiniz ve açıkladığınız şeyleri bilen Allah'a secde etmemeleri için şeytan, kendilerine, yaptıklarını güzel göstermiş, onları doğru yoldan alıkoymuştur. Bunun için, doğru yolu bulamazlar. O çok büyük arşın sahibi olan Allah'tan başka tanrı yoktur" dedi.
(23) Çok geçmeden Hüdhüd gelip Süleyman'a: "Senin bilmediğin bir şeyi öğrendim. Sana Sebe'den doğru bir haber getirdim. Ora halkına hükmeden, herşeyden kendisine bolca verilen ve büyük bir tahta sahip olan bir kadın buldum; onun ve milletinin Allah'ı bırakıp güneşe secde ettiklerini gördüm. Göklerde ve yerde gizli olanları ortaya koyan, gizlediğiniz ve açıkladığınız şeyleri bilen Allah'a secde etmemeleri için şeytan, kendilerine, yaptıklarını güzel göstermiş, onları doğru yoldan alıkoymuştur. Bunun için, doğru yolu bulamazlar. O çok büyük arşın sahibi olan Allah'tan başka tanrı yoktur" dedi.
(24) Çok geçmeden Hüdhüd gelip Süleyman'a: "Senin bilmediğin bir şeyi öğrendim. Sana Sebe'den doğru bir haber getirdim. Ora halkına hükmeden, herşeyden kendisine bolca verilen ve büyük bir tahta sahip olan bir kadın buldum; onun ve milletinin Allah'ı bırakıp güneşe secde ettiklerini gördüm. Göklerde ve yerde gizli olanları ortaya koyan, gizlediğiniz ve açıkladığınız şeyleri bilen Allah'a secde etmemeleri için şeytan, kendilerine, yaptıklarını güzel göstermiş, onları doğru yoldan alıkoymuştur. Bunun için, doğru yolu bulamazlar. O çok büyük arşın sahibi olan Allah'tan başka tanrı yoktur" dedi.
(25) Çok geçmeden Hüdhüd gelip Süleyman'a: "Senin bilmediğin bir şeyi öğrendim. Sana Sebe'den doğru bir haber getirdim. Ora halkına hükmeden, herşeyden kendisine bolca verilen ve büyük bir tahta sahip olan bir kadın buldum; onun ve milletinin Allah'ı bırakıp güneşe secde ettiklerini gördüm. Göklerde ve yerde gizli olanları ortaya koyan, gizlediğiniz ve açıkladığınız şeyleri bilen Allah'a secde etmemeleri için şeytan, kendilerine, yaptıklarını güzel göstermiş, onları doğru yoldan alıkoymuştur. Bunun için, doğru yolu bulamazlar. O çok büyük arşın sahibi olan Allah'tan başka tanrı yoktur" dedi.
(26) Çok geçmeden Hüdhüd gelip Süleyman'a: "Senin bilmediğin bir şeyi öğrendim. Sana Sebe'den doğru bir haber getirdim. Ora halkına hükmeden, herşeyden kendisine bolca verilen ve büyük bir tahta sahip olan bir kadın buldum; onun ve milletinin Allah'ı bırakıp güneşe secde ettiklerini gördüm. Göklerde ve yerde gizli olanları ortaya koyan, gizlediğiniz ve açıkladığınız şeyleri bilen Allah'a secde etmemeleri için şeytan, kendilerine, yaptıklarını güzel göstermiş, onları doğru yoldan alıkoymuştur. Bunun için, doğru yolu bulamazlar. O çok büyük arşın sahibi olan Allah'tan başka tanrı yoktur" dedi.
(27) Süleyman şöyle söyledi: "Doğru mu söylüyorsun, yoksa yalancılardan mısın, bakacağız."
(28) "Şu yazımı götür, onlara at, sonra bir yana çekil, varacakları sonuca bak."
(29) Sebe melikesi: "Ey ileri gelenler! Bana, Bismillahirrahmanirrahim diye başlayan ve 'sakın bana karşı baş kaldırmayın ve teslim olarak gelin' diyen Süleyman'dan gönderilen önemli bir mektup bırakıldı" dedi.
(30) Sebe melikesi: "Ey ileri gelenler! Bana, Bismillahirrahmanirrahim diye başlayan ve 'sakın bana karşı baş kaldırmayın ve teslim olarak gelin' diyen Süleyman'dan gönderilen önemli bir mektup bırakıldı" dedi.
(31) Sebe melikesi: "Ey ileri gelenler! Bana, Bismillahirrahmanirrahim diye başlayan ve 'sakın bana karşı baş kaldırmayın ve teslim olarak gelin' diyen Süleyman'dan gönderilen önemli bir mektup bırakıldı" dedi.
(32) "Ey ileri gelenler! Vereceğim emir hakkında bana fikrinizi söyleyin; siz benim yanımda bulunmadıkça, bir iş hakkında kesin bir hüküm vermem" dedi.
(33) "Biz güçlü kimseler ve zorlu savaş adamlarıyız, emir senindir, sen emretmene bak."
(34) Melike: "Doğrusu hükümdarlar bir şehre girdikleri zaman orasını bozarlar, onurlu kimselerini aşağılık yaparlar. İşte böyle davranırlar. Ben onlara bir hediye göndereyim de, elçilerin ne ile döneceklerine bakayım" dedi.
(35) Melike: "Doğrusu hükümdarlar bir şehre girdikleri zaman orasını bozarlar, onurlu kimselerini aşağılık yaparlar. İşte böyle davranırlar. Ben onlara bir hediye göndereyim de, elçilerin ne ile döneceklerine bakayım" dedi.
(36) Süleyman'a geldiklerinde: "Bana mal ile yardım etmek mi istiyorsunuz? Allah'ın bana verdiği size verdiğinden daha iyidir. Ama belki de siz hediyenizle sevinirsiniz. Onlara dön! And olsun ki, güç yetiremeyecekleri bir ordu ile gelir onları oradan alçalmış ve küçük düşmüş olarak çıkarırız" dedi.
(37) Süleyman'a geldiklerinde: "Bana mal ile yardım etmek mi istiyorsunuz? Allah'ın bana verdiği size verdiğinden daha iyidir. Ama belki de siz hediyenizle sevinirsiniz. Onlara dön! And olsun ki, güç yetiremeyecekleri bir ordu ile gelir onları oradan alçalmış ve küçük düşmüş olarak çıkarırız" dedi.
(38) Süleyman: "Ey cemaat! Bana teslim olmalarından önce, hanginiz o kraliçenin tahtını yanıma getirebilir?" dedi.
(39) Cinlerden bir ifrit: "Sen yerinden kalkmadan önce sana onu getiririm, buna karşı güvenilir bir güce sahibim" dedi.
(40) Kitabın bilgisine sahip olan biri: "Gözünü açıp kapamadan ben onu sana getiririm" dedi. Süleyman, tahtı yanına yerleşivermiş görünce: "Bu, şükür mü edeceğim yoksa nankörlük mü edeceğim diye beni sınayan Rabbimin lütfundandır. Şükreden ancak kendisi için şükretmiş olur; fakat nankörlük eden bilsin ki Rabbim müstağnidir, kerem sahibidir" dedi.
(41) Süleyman "Onun tahtını tanınmaz hale getirin, bakalım tanıyabilecek mi yoksa tanıyamayacak mı?" (yola gelecek mi, yoksa yola gelmeyenlerden mi olacak?) dedi.
(42) Melike geldiğinde "Senin tahtın böyle miydi?" denildi. O da "Sanki odur, daha önce bize bilgi verilmişti ve teslim olmuştuk" dedi.
(43) Melikeyi o zamana kadar alıkoyan, Allah'tan başka taptığı şeylerdi; çünkü kendisi inkarcı bir millettendi.
(44) Ona: "Köşke gir" dendi; salonu görünce, onu derin bir su zannetti, eteğini çekti. Süleyman: "Doğrusu bu camdan yapılmış mücella bir salondur" dedi. Melike: "Rabbim! Şüphesiz ben kendime yazık etmişim. Süleyman'la beraber, Alemlerin Rabbi olan Allah'a teslim oldum" dedi.
(45) And olsun ki, Semud milletine kardeşleri Salih'i "Allah'a kulluk ediniz" desin diye gönderdik. Hemen birbiriyle çekişen iki zümreye ayrıldılar.
(46) Salih: "Ey milletim! Niye iyilikten önce, acele kötülük istiyorsunuz? Merhamet olunasınız diye Allah'tan mağfiret dileseniz olmaz mı?" dedi.
(47) "Sen ve beraberindekiler yüzünden uğursuzluğa uğradık" dediler. Salih: "Uğursuzluğunuz Allah katındandır; belki imtihana çekilen bir milletsiniz" dedi.
(48) O şehirde, yeryüzünde bozgunculuk yapan, düzeltmeye uğraşmayan dokuz kişi (çete) vardı.
(49) "Biz gece ona ve ailesine baskın verelim, sonra da onun dostuna, ailesinin yok edilişinde bulunmadık, şüphesiz biz doğru söylüyoruz, diyelim" diye aralarında Allah'a yemin ettiler.
(50) Onlar bir düzen kurdular. Biz farkettirmeden düzenlerini bozduk.
(51) Hilelerinin sonunun nasıl olduğuna bir bak! Biz onları ve milletlerini, hepsini, yerle bir ettik.
(52) İşte, haksızlıklarına karşılık çökmüş bulunan evleri! Bunda, bilen bir millet için şüphesiz, ders vardır.
(53) İnanıp Allah'a karşı gelmekten sakınanları kurtardık.
(54) Lut'u da gönderdik; milletine şöyle dedi: "Göz göre göre bir hayasızlık mı yapıyorsunuz?"
(55) "Kadınları bırakıp, erkeklere mi yaklaşıyorsunuz; evet, siz cahil bir milletsiniz."
(56) Milletinin cevabı sadece: "Lut'un ailesini kasabanızdan çıkarın, güya onlar temiz kalmaya çalışan insanlarmış" demek oldu.
(57) Bunun üzerine onu ve ailesini kurtardık, yalnız karısının geride kalanlardan olmasını gerekli bulduk.
(58) Geride kalanların üzerlerine bir yağmur yağdırdık. Uyarılan fakat yola gelmeyenlerin yağmuru ne kötü idi!
(59) De ki: "Hamd Allah'a mahsustur, seçtiği kullarına selam olsun. Allah mı daha iyidir, yoksa O'na koştukları ortaklar mı?"
(60) Yoksa gökleri ve yeri yaratan, gökten size su indirip onunla, bir ağacını bile bitirmeye gücünüzün yetmediği, güzel güzel bahçeler meydana getiren mi? Allah'ın yanında başka bir tanrı mı? Hayır; onlar taptıklarını Allah'a eşit tutan bir millettir.
(61) Yoksa yeri, yaratıklarının oturmasına elverişli kılan ve aralarında ırmaklar meydana getiren, yeryüzüne sabit dağlar yerleştiren, iki deniz arasına engel koyan mı? Allah'ın yanında başka bir tanrı mı? Hayır; çoğu bilmezler.
(62) Yoksa, darda kalana, kendisine yakardığı zaman karşılık veren, başındaki sıkıntıyı gideren ve sizi yeryüzünün sahipleri yapan mı? Allah'ın yanında başka bir tanrı mi? Pek kıt düşünüyorsunuz.
(63) Yoksa, karanın ve denizin karanlıklarında size yol bulduran, rüzgarları rahmetinin önünde müjdeci gönderen mi? Allah'ın yanında başka bir tanrı mı? Allah, koştukları eşlerden yücedir.
(64) Yoksa, önce yaratan, sonra da yaratmayı tekrar edecek olan; size gökten ve yerden rızık veren mi? Allah'ın yanında başka bir tanrı mı? De ki: "Eğer doğru sözlülerden iseniz, açık delilinizi getirin."
(65) De ki: "Göklerde ve yerde gaybı Allah'tan başka bilen yoktur." Ne zaman diriltileceklerini de bilmezler.
(66) Ahirete dair bilgileri yeterli midir? Hayır; ondan şüphe etmektedirler. Hayır; ona karşı kördürler.
(67) İnkar edenler: "Biz ve babalarımız toprak olduğumuzda mı, doğrusu bizler mi tekrar çıkarılacağız? Bununla biz de, daha önce babalarımız da, and olsun ki, tehdit edilmiştik. Bu, öncekilerin masallarından başka bir şey değildir" dediler.
(68) İnkar edenler: "Biz ve babalarımız toprak olduğumuzda mı, doğrusu bizler mi tekrar çıkarılacağız? Bununla biz de, daha önce babalarımız da, and olsun ki, tehdit edilmiştik. Bu, öncekilerin masallarından başka bir şey değildir" dediler.
(69) De ki: "Yeryüzünde gezin, suçluların sonunun nasıl olduğuna bir bakın."
(70) Onlara üzülme. Hilelerine karşı da sıkılma.
(71) Onlar: "Eğer doğru söylüyorsanız, bildirin, bu sözünüz ne zaman yerine gelecektir?" derler.
(72) De ki: "Acele ettiğiniz şeyin bir kısmı belki hemen başınıza gelir."
(73) Doğrusu Rabbin, insanlara karşı lütuf sahibidir. Fakat onların çoğu şükretmezler.
(74) Şüphesiz Rabbin onların gönüllerinin gizlediklerini de, açığa vurduklarını da bilir.
(75) Gökte ve yerde gizli hiçbir şey yoktur ki apaçık bir kitapta olmasın.
(76) Doğrusu bu Kuran, İsrailoğullarına, ayrılığa düştükleri şeyin çoğunu anlatmaktadır.
(77) Doğrusu Kuran, inananlara doğruluk rehberi ve rahmettir.
(78) Rabbin şüphesiz, aralarında, kendi hükmünü verecektir. O güçlüdür, bilendir.
(79) Allah'a güven, şüphesiz sen apaçık gerçek üzerindesin.
(80) Sen, ölülere şüphesiz ki işittiremezsin; dönüp giden sağırlara da çağrıyı duyuramazsın.
(81) Körleri sapıklıklarından vazgeçirip doğru yola döndüremezsin; ancak ayetlerimize inananlara sen duyurabilirsin; işte onlar Müslümanlardır.
(82) Kendilerine söylenmiş olan başlarına geldiği zaman, yerden bir çeşit hayvan çıkarırız ki o, onlara, insanların ayetlerimize kesin olarak inanmadıkların söyler.
(83) O gün her ümmetin ayetlerimizi yalanlayanlarını toplarız. Onlar bir arada tutulup, hesap yerine sevkedilirler.
(84) Geldikleri zaman Allah: "Ayetlerimi anlamadığınız halde yalanladınız mı? Yoksa yaptığınız neydi?" der.
(85) Haksızlıklarından ötürü, söylenilen söz başlarına gelir. Artık konuşamaz olurlar.
(86) Size geceyi dinlenesiniz diye karanlık ve gündüzü çalışasınız diye aydınlık olarak yarattığımızı görmediler mi? Doğrusu bunda, inanan millet için dersler vardır.
(87) Sura üfürüldüğü gün, Allah'ın diledikleri bir yana, göklerde olanlar da yerde olanlar da, korku içinde kalırlar. Hepsi Allah'a boyunları bükülmüş olarak gelirler.
(88) Dağları yerinde donmuş gibi durur görürsün, oysa onlar bulutlar gibi geçerler. Bu her şeyi sağlam tutan Allah'ın işidir. Doğrusu O, yaptıklarınızdan haberdardır.
(89) Kim bir iyilik getirirse, ona daha iyisi verilir. Onlar o günün korkusundan güvendedirler.
(90) Kötülük getiren kimseler, yüzükoyun ateşe atılırlar. "Yaptıklarınızdan başka bir şeyle mi cezalandırılacaksınız?" denir.
(91) De ki: "Ben, yalnız her şeyin sahibi olan ve bu kutlu kılınmış şehrin Rabbine kulluk etmekle emrolundum. Müslümanlardan olmakla ve Kuran okumakla emrolundum." Kim doğru yolu bulmuşsa, yalnız kendisi için bulmuş olur, kim sapıtmışsa kendine etmiş olur. De ki: "Ben sadece, uyaranlardan biriyim."
(92) De ki: "Ben, yalnız her şeyin sahibi olan ve bu kutlu kılınmış şehrin Rabbine kulluk etmekle emrolundum. Müslümanlardan olmakla ve Kuran okumakla emrolundum." Kim doğru yolu bulmuşsa, yalnız kendisi için bulmuş olur, kim sapıtmışsa kendine etmiş olur. De ki: "Ben sadece, uyaranlardan biriyim."
(93) De ki: "Hamd Allah'a mahsustur. O, ayetlerini size gösterecek, siz de onları bileceksiniz." Rabbin yaptıklarınızdan habersiz değildir.''',
  ),
];
