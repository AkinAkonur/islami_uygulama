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
  MubarekSureVerisi(
    baslik: 'Cevşen-ül Kebîr Duası',
    baslikEn: 'Al-Jawshan Al-Kabir Dua',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ

--- 1. BAB ---
اَللّٰهُمَّ اِنّٖى اَسْئَلُكَ بِاسْمِكَ يَا اَللّٰهُ يَا رَحْمٰنُ يَا رَحٖيمُ يَا كَرٖيمُ يَا مُقٖيمُ يَا عَظٖيمُ يَا قَدٖيمُ يَا عَلٖيمُ يَا حَلٖيمُ يَا حَكٖيمُ
سُبْحَانَكَ يَا لَا اِلٰهَ اِلَّا اَنْتَ الْاَمَانُ الْاَمَانُ خَلِّصْنَا مِنَ النَّارِ

--- 2. BAB ---
يَا سَيِّدَ السَّادَاتِ يَا مُجيبَ الدَّعَوَاتِ يَا رَافِعَ الدَّرَجَاتِ يَا وَلِىَّ الْحَسَنَاتِ يَا غَافِرَ الْخَطٖيئَاتِ يَا مُعْطِىَ الْمَسْئَلَاتِ يَا قَابِلَ التَّوْبَاتِ يَا سَامِعَ الْاَصْوَاتِ يَا عَالِمَ الْخَفِيَّاتِ يَا دَافِعَ الْبَلِيَّاتِ

--- 3. BAB ---
يَا خَيْرَ الْغَافِرٖينَ يَا خَيْرَ الْفَاتِحٖينَ يَا خَيْرَ النَّاصِرٖينَ يَا خَيْرَ الْحَاكِمٖينَ يَا خَيْرَ الرَّازِقٖينَ يَا خَيْرَ الْوَارِثٖينَ يَا خَيْرَ الْحَامِدٖينَ يَا خَيْرَ الذَّاكِرٖينَ يَا خَيْرَ الْمُنْزِلٖينَ يَا خَيْرَ الْمُحْسِنٖينَ

--- 4. BAB ---
يَا مَنْ لَهُ الْعِزَّةُ وَالْجَمَالُ يَا مَنْ لَهُ الْمُلْكُ وَالْجَلَالُ يَا مَنْ لَهُ الْقُدْرَةُ وَالْكَمَالُ يَا مَنْ هُوَ الْكَبٖيرُ الْمُتَعَالُ يَا مُنْشِئَ السَّحَابِ الثِّقَالِ يَا مَنْ هُوَ شَدٖيدُ الْمِحَالِ يَا مَنْ هُوَ سَرٖيعُ الْحِسَابِ يَا مَنْ هُوَ شَدٖيدُ الْعِقَابِ يَا مَنْ عِنْدَهُ حُسْنُ الثَّوَابِ يَا مَنْ عِنْدَهُ اُمُّ الْكِتَابِ

--- 5. BAB ---
اَللّٰهُمَّ اِنّٖى اَسْئَلُكَ بِاسْمِكَ يَا حَنَّانُ يَا مَنَّانُ يَا دَيَّانُ يَا بُرْهَانُ يَا سُلْطَانُ يَا رِضْوَانُ يَا غُفْرَانُ يَا سُبْحَانُ يَا مُسْتَعَانُ يَا ذَا الْمَنِّ وَالْبَيَانِ

--- 6. BAB ---
يَا مَنْ تَوَاضَعَ كُلُّ شَىْءٍ لِعَظَمَتِهٖ يَا مَنِ اسْتَسْلَمَ كُلُّ شَىْءٍ لِقُدْرَتِهٖ يَا مَنْ ذَلَّ كُلُّ شَىْءٍ لِعِزَّتِهٖ يَا مَنْ خَضَعَ كُلُّ شَىْءٍ لِهَيْبَتِهٖ يَا مَنِ انْقَادَ كُلُّ شَىْءٍ لِمُلْكِهٖ يَا مَنْ دَانَ كُلُّ شَىْءٍ مِنْ مَخَافَتِهٖ يَا مَنِ انْشَقَّتِ الْجِبَالُ مِنْ خَشْيَتِهٖ يَا مَنْ قَامَتِ السَّمٰوَاتُ بِاَمْرِهٖ يَا مَنِ اسْتَقَرَّتِ الْاَرَضُونَ بِاِذْنِهٖ يَا مَنْ لَا يَعْتَدٖى عَلٰى اَهْلِ مَمْلَكَتِهٖ

--- 7. BAB ---
يَا غَافِرَ الْخَطَايَا يَا كَاشِفَ الْبَلَايَا يَا مُنْتَهَى الرَّجَايَا يَا مُجْزِلَ الْعَطَايَا يَا وَاهِبَ الْهَدَايَا يَا رَازِقَ الْبَرَايَا يَا قَاضِىَ الْمَنَايَا يَا سَامِعَ الشَّكَايَا يَا بَاعِثَ الْبَرَايَا يَا مُطْلِقَ الْاُسَارٰى

--- 8. BAB ---
يَا ذَا الْحَمْدِ وَالثَّنَاءِ يَا ذَا الْفَخْرِ وَالْبَهَاءِ يَا ذَا الْمَجْدِ وَالسَّنَاءِ يَا ذَا الْعَهْدِ وَالْوَفَاءِ يَا ذَا الْعَفْوِ وَالرِّضَاءِ يَا ذَا الْمَنِّ وَالْعَطَاءِ يَا ذَا الْفَصْلِ وَالْقَضَاءِ يَا ذَا الْعِزِّ وَالْبَقَاءِ يَا ذَا الْجُودِ وَالسَّخَاءِ يَا ذَا الْاٰلَاءِ وَالنَّعْمَاءِ

--- 9. BAB ---
اَللّٰهُمَّ اِنّٖى اَسْئَلُكَ بِاسْمِكَ يَا مَانِعُ يَا دَافِعُ يَا رَافِعُ يَا صَانِعُ يَا نَافِعُ يَا سَامِعُ يَا جَامِعُ يَا شَافِعُ يَا وَاسِعُ يَا مُوسِعُ

--- 10. BAB ---
يَا صَانِعَ كُلِّ مَصْنُوعٍ يَا خَالِقَ كُلِّ مَخْلُوقٍ يَا رَازِقَ كُلِّ مَرْزُوقٍ يَا مَالِكَ كُلِّ مَمْلُوكٍ يَا كَاشِفَ كُلِّ مَكْرُوبٍ يَا فَارِجَ كُلِّ مَهْمُومٍ يَا رَاحِمَ كُلِّ مَرْحُومٍ يَا نَاصِرَ كُلِّ مَخْذُولٍ يَا سَاتِرَ كُلِّ مَعْيُوبٍ يَا مَلْجَاَ كُلِّ مَظْلُومٍ

--- 11. BAB ---
يَا عُدَّتٖى عِنْدَ شِدَّتٖى يَا رَجَائٖى عِنْدَ مُصٖيبَتٖى يَا مُونِسٖى عِنْدَ وَحْشَتٖى يَا صَاحِبٖى عِنْدَ غُرْبَتٖى يَا وَلِيّٖى عِنْدَ نِعْمَتٖى يَا غِيَاثٖى عِنْدَ كُرْبَتٖى يَا دَلٖيلٖى عِنْدَ حَيْرَتٖى يَا غَنَائٖى عِنْدَ افْتِقَارٖى يَا مَلْجَاٖى عِنْدَ اضْطِرَارٖى يَا مُعٖينٖى عِنْدَ مَفْزَعٖى

--- 12. BAB ---
يَا عَلَّامَ الْغُيُوبِ يَا غَفَّارَ الذُّنُوبِ يَا سَتَّارَ الْعُيُوبِ يَا كَشَّافَ الْكُرُوبِ يَا مُقَلِّبَ الْقُلُوبِ يَا طَبٖيبَ الْقُلُوبِ يَا مُنَوِّرَ الْقُلُوبِ يَا اَنٖيسَ الْقُلُوبِ يَا مُفَرِّجَ الْهُمُومِ يَا مُنَفِّسَ الْغُمُومِ

--- 13. BAB ---
اَللّٰهُمَّ اِنّٖى اَسْئَلُكَ بِاسْمِكَ يَا جَلٖيلُ يَا جَمٖيلُ يَا وَكٖيلُ يَا كَفٖيلُ يَا دَلٖيلُ يَا قَبٖيلُ يَا مُدٖيلُ يَا مُنٖيلُ يَا مُقٖيلُ يَا مُحٖيلُ

--- 14. BAB ---
يَا دَلٖيلَ الْمُتَحَيِّرٖينَ يَا غِيَاثَ الْمُسْتَغٖيثٖينَ يَا صَرٖيخَ الْمُسْتَصْرِخٖينَ يَا جَارَ الْمُسْتَجٖيرٖينَ يَا اَمَانَ الْخَائِفٖينَ يَا عَوْنَ الْمُؤْمِنٖينَ يَا رَاحِمَ الْمَسَاكٖينَ يَا مَلْجَاَ الْعَاصٖينَ يَا غَافِرَ الْمُذْنِبٖينَ يَا مُجٖيبَ دَعْوَةِ الْمُضْطَرّٖينَ

--- 15. BAB ---
يَا ذَا الْجُودِ وَالْاِحْسَانِ يَا ذَا الْفَضْلِ وَالْاِمْتِنَانِ يَا ذَا الْاَمْنِ وَالْاَمَانِ يَا ذَا الْقُدْسِ وَالسُّبْحَانِ يَا ذَا الْحِكْمَةِ وَالْبَيَانِ يَا ذَا الرَّحْمَةِ وَالرِّضْوَانِ يَا ذَا الْحُجَّةِ وَالْبُرْهَانِ يَا ذَا الْعَظَمَةِ وَالسُّلْطَانِ يَا ذَا الرَّاْفَةِ وَالْمُسْتَعَانِ يَا ذَا الْعَفْوِ وَالْغُفْرَانِ

--- 16. BAB ---
يَا مَنْ هُوَ رَبُّ كُلِّ شَىْءٍ يَا مَنْ هُوَ اِلٰهُ كُلِّ شَىْءٍ يَا مَنْ هُوَ خَالِقُ كُلِّ شَىْءٍ يَا مَنْ هُوَ صَانِعُ كُلِّ شَىْءٍ يَا مَنْ هُوَ قَبْلَ كُلِّ شَىْءٍ يَا مَنْ هُوَ بَعْدَ كُلِّ شَىْءٍ يَا مَنْ هُوَ فَوْقَ كُلِّ شَىْءٍ يَا مَنْ هُوَ عَالِمٌ بِكُلِّ شَىْءٍ يَا مَنْ هُوَ قَادِرٌ عَلٰى كُلِّ شَىْءٍ يَا مَنْ هُوَ يَبْقٰى وَيَفْنٰى كُلُّ شَىْءٍ

--- 17. BAB ---
اَللّٰهُمَّ اِنّٖى اَسْئَلُكَ بِاسْمِكَ يَا مُؤْمِنُ يَا مُهَيْمِنُ يَا مُكَوِّنُ يَا مُلَقِّنُ يَا مُبَيِّنُ يَا مُهَوِّنُ يَا مُمَكِّنُ يَا مُزَيِّنُ يَا مُعْلِنُ يَا مُقَسِّمُ

--- 18. BAB ---
يَا مَنْ هُوَ فٖى مُلْكِهٖ مُقٖيمٌ يَا مَنْ هُوَ فٖى سُلْطَانِهٖ قَدٖيمٌ يَا مَنْ هُوَ فٖى جَلَالِهٖ عَظٖيمٌ يَا مَنْ هُوَ عَلٰى عِبَادِهٖ رَحٖيمٌ يَا مَنْ هُوَ بِكُلِّ شَىْءٍ عَلٖيمٌ يَا مَنْ هُوَ بِمَنْ عَصَاهُ حَلٖيمٌ يَا مَنْ هُوَ بِمَنْ رَجَاهُ كَرٖيمٌ يَا مَنْ هُوَ فٖى صُنْعِهٖ حَكٖيمٌ يَا مَنْ هُوَ فٖى حِكْمَتِهٖ لَطٖيفٌ يَا مَنْ هُوَ فٖى لُطْفِهٖ قَدٖيمٌ

--- 19. BAB ---
يَا مَنْ لَا يُرْجٰى اِلَّا فَضْلُهُ يَا مَنْ لَا يُسْئَلُ اِلَّا عَفْوُهُ يَا مَنْ لَا يُنْظَرُ اِلَّا بِرُّهُ يَا مَنْ لَا يُخَافُ اِلَّا عَدْلُهُ يَا مَنْ لَا يَدُومُ اِلَّا مُلْكُهُ يَا مَنْ لَا سُلْطَانَ اِلَّا سُلْطَانُهُ يَا مَنْ وَسِعَتْ كُلَّ شَىْءٍ رَحْمَتُهُ يَا مَنْ سَبَقَتْ رَحْمَتُهُ غَضَبَهُ يَا مَنْ اَحَاطَ بِكُلِّ شَىْءٍ عِلْمُهُ يَا مَنْ لَيْسَ اَحَدٌ مِثْلَهُ

--- 20. BAB ---
يَا فَارِجَ الْهَمِّ يَا كَاشِفَ الْغَمِّ يَا غَافِرَ الذَّنْبِ يَا قَابِلَ التَّوْبِ يَا خَالِقَ الْخَلْقِ يَا صَادِقَ الْوَعْدِ يَا مُوفِىَ الْعَهْدِ يَا عَالِمَ السِّرِّ يَا فَالِقَ الْحَبِّ يَا رَازِقَ الْاَنَامِ

--- 21. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 22. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 23. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 24. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 25. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 26. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 27. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 28. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 29. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 30. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 31. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 32. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 33. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 34. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 35. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 36. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 37. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 38. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 39. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 40. BAB ---
(Bu bölümün Arapça metni sağlanan kaynak dosyalarında bulunmamaktadır; okunuşu ve Türkçe manası bu sayfanın ilgili bölümlerinde tam olarak verilmiştir.)

--- 41. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا غَافِرُ ٭ يَا سَاتِرُ ٭ يَا قَاهِرُ ٭ يَا قَادِرُ ٭ يَا نَاظِرُ ٭ يَا فَاطِرُ ٭ يَا شَاكِرُ ٭ يَا ذَاكِرُ ٭ يَا نَاصِرُ ٭ يَا جَابِرُ

--- 42. BAB ---
يَا مَنْ هُوَ فِى الْبَرِّ وَ الْبَحْرِ سَبِيلُهُ ٭ يَا مَنْ هُوَ فِى اْلاٰفَاقِ اٰيَاتُهُ ٭ يَا مَنْ هُوَ فِى اْلاٰيَاتِ بُرْهَانُهُ ٭ يَا مَنْ هُوَ فِى الْمَمَاتِ قُدْرَتُهُ ٭ يَا مَنْ هُوَ فِى الْقُبُورِ عِزَّتُهُ ٭ يَا مَنْ هُوَ فِى الْقِيَامَةِ مِلْكَتُهُ ٭ يَا مَنْ هُوَ فِى الْحِسَابِ هَيْبَتُهُ ٭ يَا مَنْ هُوَ فِى الْمِيزَانِ قَضَٓائُهُ ٭ يَا مَنْ هُوَ فِى الْجَنَّةِ رَحْمَتُهُ ٭ يَا مَنْ هُوَ فِى النَّارِ عَذَابُهُ

--- 43. BAB ---
يَا مَنْ هُوَ اِلَيْهِ يَهْرَبُ الْخَٓائِفُونَ ٭ يَا مَنْ هُوَ اِلَيْهِ يَفْزَعُ الْمُذْنِبُونَ ٭ يَا مَنْ هُوَ اِلَيْهِ يَقْصِدُ الْمُنِيبُونَ ٭ يَا مَنْ هُوَ اِلَيْهِ يَلْجَأُ الْعَاصُونَ ٭ يَا مَنْ هُوَ اِلَيْهِ يَرْغَبُ الزَّاهِدُونَ ٭ يَا مَنْ هُوَ فِيهِ يَطْمَعُ الْخَاطِؤُنَ ٭ يَا مَنْ هُوَ يَسْتَاْنِسُ بِهِ الْمُرِيدُونَ ٭ يَا مَنْ هُوَ يَفْتَخِرُ بِهِ الْمُحْسِنُونَ ٭ يَا مَنْ هُوَ عَلَيْهِ يَتَوَكَّلُ الْمُتَوَكِّلُونَ ٭ يَا مَنْ هُوَ يَسْكُنُ بِهِ الْمُوقِنُونَ

--- 44. BAB ---
يَا رَأُوفًا بِمَنْ رَجَاهُ ٭ يَا عَطُوفًا عَلَى مَنْ تَوَسَّلَ بِهِ ٭ يَا lلْطِفًا بِعِبَادِهِ ٭ يَا خَبِيرًا بِخَلْقِهِ ٭ يَا بَصِيرًا بِاُمُورِهِ ٭ يَا مَنْ هُوَ فِى عُلُوِّهِ دَانٍ ٭ يَا مَنْ هُوَ فِى دُنُوِّهِ عَالٍ ٭ يَا مَنْ هُوَ فِى إِشْرَاقِهِ مُنِيرٌ ٭ يَا مَنْ هُوَ فِى سُلْطَانِهِ قَوِيٌّ ٭ يَا مَنْ هُوَ فِى مُلْكِهِ دَائِمٌ

--- 45. BAB ---
يَا مَنْ يَحْكُمُ وَ لَا يُحْكَمُ عَلَيْهِ ٭ يَا مَنْ لَمْ يَلِدْ وَ لَمْ يُولَدْ ٭ وَ لَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ ٭ يَا مَحْمُودَ الْفِعَالِ ٭ يَا مَاجِدَ الْمَقَالِ ٭ يَا جَمِيلَ الشِّعَارِ ٭ يَا قَدِيمَ الْوِعَارِ ٭ يَا مُبْدِئَ الْكَائِنَاتِ ٭ يَا مُعِيدَ الْأَمْوَاتِ ٭ يَا مَنْ تَجَلَّى فِى الصِّفَاتِ

--- 46. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا حَنَّانُ ٭ يَا مَنَّانُ ٭ يَا دَيَّانُ ٭ يَا بُرْهَانُ ٭ يَا سُلْطَانُ ٭ يَا رِضْوَانُ ٭ يَا غُفْرَانُ ٭ يَا سُبْحَانُ ٭ يَا مُسْتَعَانُ ٭ يَا ذَا الْمَنِّ وَ الْبَيَانِ

--- 47. BAB ---
يَا مَنْ تَوَاضَعَ كُلُّ شَيْءٍ لِعَظَمَتِهِ ٭ يَا مَنْ اسْتَسْلَمَ كُلُّ شَيْءٍ لِقُدْرَتِهِ ٭ يَا مَنْ ذَلَّ كُلُّ شَيْءٍ لِعِزَّتِهِ ٭ يَا مَنْ خَضَعَ كُلُّ شَيْءٍ لِهَيْبَتِهِ ٭ يَا مَنْ انْقَادَ كُلُّ شَيْءٍ مِنْ خَشْيَتِهِ ٭ يَا مَنْ تَشَقَّقَتِ الْجِبَالُ مِنْ مَخَافَتِهِ ٭ يَا مَنْ قَامَتِ السَّمَاوَاتُ بِأَمْرِهِ ٭ يَا مَنْ اسْتَقَرَّتِ الْأَرَضُونَ بِإِذْنِهِ ٭ يَا مَنْ يُسَبِّحُ الرَّعْدُ بِحَمْدِهِ ٭ يَا مَنْ لَا يَعْتَدِى عَلَى أَهْلِ مَمْلَكَتِهِ

--- 48. BAB ---
يَا غَافِرَ الْخَطَايَا ٭ يَا كَاشِفَ الْبَلَايَا ٭ يَا مُنْتَهَى الرَّجَايَا ٭ يَا مُجْزِلَ الْعَطَايَا ٭ يَا وَاهِبَ الْهَدَايَا ٭ يَا رَازِقَ الْبَرَايَا ٭ يَا قَاضِيَ الْمَنَايَا ٭ يَا سَامِعَ الشَّكَايَا ٭ يَا بَاعِثَ الْبَرَايَا ٭ يَا مُطْلِقَ الْأُسَارَى

--- 49. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا مُنَوِّلُ ٭ يَا مُفَصِّلُ ٭ يَا مُبَدِّلُ ٭ يَا مُسَهِّلُ ٭ يَا مُذَلِّلُ ٭ يَا مُنَزِّلُ ٭ يَا مُحَوِّلُ ٭ يَا مُجَمِّلُ ٭ يَا مُكَمِّلُ ٭ يَا مُفَضِّلُ

--- 50. BAB ---
يَا مَنْ هُوَ يَرَى وَ لَا يُرَى ٭ يَا مَنْ هُوَ يَخْلُقُ وَ لَا يُخْلَقُ ٭ يَا مَنْ هُوَ يَهْدِي وَ لَا يُهْدَى ٭ يَا مَنْ هُوَ يُحْيِي وَ لَا يُحْيَى ٭ يَا مَنْ هُوَ يُطْعِمُ وَ لَا يُطْعَمُ ٭ يَا مَنْ هُوَ يُجِيرُ وَ لَا يُجَارُ عَلَيْهِ ٭ يَا مَنْ هُوَ يَقْضِي وَ لَا يُقْضَى عَلَيْهِ ٭ يَا مَنْ هُوَ يَحْكُمُ وَ لَا يُحْكَمُ عَلَيْهِ ٭ يَا مَنْ هُوَ لَمْ يَلِدْ وَ لَمْ يُولَدْ ٭ وَ لَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ

--- 51. BAB ---
يَا نِعْمَ الْحَبِيبُ ٭ يَا نِعْمَ الطَّبِيبُ ٭ يَا نِعْمَ الْحَسِيبُ ٭ يَا نِعْمَ الْقَرِيبُ ٭ يَا نِعْمَ الرَّقِيبُ ٭ يَا نِعْمَ الْمُجِيبُ ٭ يَا نِعْمَ الْأَنِيسُ ٭ يَا نِعْمَ الْوَكِيلُ ٭ يَا نِعْمَ الْمَوْلَى ٭ يَا نِعْمَ النَّصِيرُ

--- 52. BAB ---
يَا سُرُورَ الْعَارِفِينَ ٭ يَٓا اَنِيسَ الْمُرِيدِينَ ٭ يَا مُغِيثَ الْمُشْتَاقِينَ ٭ يَا حَبِيبَ التَّوَّابِينَ ٭ يَا رَازِقَ الْمُقِلِّينَ ٭ يَا رَجَٓاءَ الْمُذْنِبِينَ ٭ يَا كَاشِفَ الْمَكْرُوبِينَ ٭ يَا مُنَفِّسًا عَنِ الْمَغْمُومِينَ ٭ يَا مُفَرِّجًا عَنِ الْمَحْزُونِينَ ٭ يَٓا اِلٰهَ الْاَوَّلِينَ وَ اْلاٰخِرِينَ

--- 53. BAB ---
يَا رَبَّ الْجَنَّةِ وَ النَّارِ ٭ يَا رَبَّ النَّبِيِّينَ وَ الْاَخْيَارِ ٭ يَا رَبَّ الصِّدّ۪يقِينَ وَ الْاَبْرَارِ ٭ يَا رَبَّ الصِّغَارِ وَ الْكِبَارِ ٭ يَا رَبَّ الْحُبُوبِ وَ الْاَثْمَارِ ٭ يَا رَبَّ الْاَنْهَارِ وَ الْاَشْجَارِ ٭ يَا رَبَّ الصَّحَارٰى وَ الْقِفَارِ ٭ يَا رَبَّ الْعَبِيدِ وَ الْاَحْرَارِ ٭ يَا رَبَّ اْلاِعْلَانِ وَ اْلاِسْرَارِ ٭ يَا رَبَّ الَّيْلِ وَ النَّهَارِ

--- 54. BAB ---
يَا مَنْ لَحِقَ فِى كُلِّ شَيْءٍ عِلْمُهُ ٭ يَا مَنْ نَفَذَ بِكُلِّ شَيْءٍ بَصَرُهُ ٭ يَا مَنْ بَلَغَ إِلَى كُلِّ شَيْءٍ قُدْرَتُهُ ٭ يَا مَنْ لَا يُحْصِي الْعِبَادُ نَعْمَاءَهُ ٭ يَا مَنْ لَا تَبْلُغُ الْخَلَائِقُ شُكْرَهُ ٭ يَا مَنْ لَا تُدْرِكُ الْأَفْهَامُ جَلَالَهُ ٭ يَا مَنْ لَا تَنَالُ الْأَوْهَامُ كُنْهَهُ ٭ يَا مَنْ الْعَظَمَةُ وَ الْكِبْرِيَاءُ رِدَاؤُهُ ٭ يَا مَنْ الْهَيْبَةُ وَ السُّلْطَانُ بَهَاؤُهُ ٭ يَا مَنْ تَعَزَّزَ بِالْعِزِّ بَقَاؤُهُ

--- 55. BAB ---
يَا مَنْ لَهُ الْأَمْثَالُ الْعُلْيَا ٭ يَا مَنْ لَهُ الصِّفَاتُ الْوُعْيَا ٭ يَا مَنْ لَهُ الْآخِرَةُ وَ الْأُولَى ٭ يَا مَنْ لَهُ جَنَّةُ الْمَأْوَى ٭ يَا مَنْ لَهُ الْآيَاتُ الْكُبْرَى ٭ يَا مَنْ لَهُ الْأَسْمَاءُ الْحُسْنَى ٭ يَا مَنْ لَهُ الْحُكْمُ وَ الْقَضَاءُ ٭ يَا مَنْ لَهُ الْهَوَاءُ وَ الْفَضَاءُ ٭ يَا مَنْ لَهُ الْعَرْشُ وَ الثَّرَى ٭ يَا مَنْ لَهُ السَّمَاوَاتُ الْعُلَى

--- 56. BAB ---
يَا عَفُوًّا قَبْلَ أَنْ يَأْخُذَ ٭ يَا غَفُورًا بَعْدَ أَنْ يَأْخُذَ ٭ يَا وَدُودُ ٭ يَا شَكُورُ ٭ يَا صَبُورُ ٭ يَا رَؤُوفُ ٭ يَا عَطُوفُ ٭ يَا قُدُّوسُ ٭ يَا لَطِيفُ ٭ يَا عَظِيمُ

--- 57. BAB ---
يَا مَنْ فِى السَّمَاءِ عَزَمَاتُهُ ٭ يَا مَنْ فِى الْأَرْضِ آيَاتُهُ ٭ يَا مَنْ فِى كُلِّ شَيْءٍ دَلَائِلُهُ ٭ يَا مَنْ فِى الْبِحَارِ عَجَائِبُهُ ٭ يَا مَنْ يَبْدَأُ الْخَلْقَ ثُمَّ يُعِيدُهُ ٭ يَا مَنْ فِى الْجِبَالِ خَزَائِنُهُ ٭ يَا مَنْ أَحْسَنَ كُلَّ شَيْءٍ خَلَقَهُ ٭ يَا مَنْ إِلَيْهِ يُرْجَعُ الْأَمْرُ كُلُّهُ ٭ يَا مَنْ ظَهَرَ فِى كُلِّ شَيْءٍ لُطْفُهُ ٭ يَا مَنْ يُعَرِّفُ الْخَلَائِقَ قُدْرَتَهُ

--- 58. BAB ---
يَا حَبِيبَ مَنْ لَا حَبِيبَ لَهُ ٭ يَا طَبِيبَ مَنْ لَا طَبِيبَ لَهُ ٭ يَا مُجِيبَ مَنْ لَا مُجِيبَ لَهُ ٭ يَا شَفِيقَ مَنْ لَا شَفِيقَ لَهُ ٭ يَا رَفِيقَ مَنْ لَا رَفِيقَ لَهُ ٭ يَا شَفِيعَ مَنْ لَا شَفِيعَ لَهُ ٭ يَا مُغِيثَ مَنْ لَا مُغِيثَ لَهُ ٭ يَا دَلِيلَ مَنْ لَا دَلِيلَ لَهُ ٭ يَا أَنِيسَ مَنْ لَا أَنِيسَ لَهُ ٭ يَا رَاحِمَ مَنْ لَا رَاحِمَ لَهُ

--- 59. BAB ---
يَا كَافِيَ مَنِ اسْتَكْفَاهُ ٭ يَا هَادِيَ مَنِ اسْتَهْدَاهُ ٭ يَا كَافِلَ مَنِ اسْتَكْفَلَهُ ٭ يَا دَاعِيَ مَنِ اسْتَدْعَاهُ ٭ يَا شَافِيَ مَنِ اسْتَشْفَاهُ ٭ يَا قَاضِيَ مَنِ اسْتَقْضَاهُ ٭ يَا مُغْنِيَ مَنِ اسْتَغْنَاهُ ٭ يَا مُوفِيَ مَنِ اسْتَوْفَاهُ ٭ يَا مُقَوِّيَ مَنِ اسْتَقْوَاهُ ٭ يَا وَلِيَّ مَنِ تَوَلَّاهُ

--- 60. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا أَوَّلُ ٭ يَا آخِرُ ٭ يَا ظَاهِرُ ٭ يَا بَاطِنُ ٭ يَا خَالِقُ ٭ يَا رَازِقُ ٭ يَا صَادِقُ ٭ يَا سَابِقُ ٭ يَا سَائِقُ ٭ يَا فَالِقُ

--- 61. BAB ---
Ey her şeye şahit ve ha حاضر olan,

--- 62. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا عَاصِمُ ٭ يَا قَائِمُ ٭ يَا دَائِمُ ٭ يَا رَاحِمُ ٭ يَا سَالِمُ ٭ يَا حَاكِمُ ٭ يَا عَالِمُ ٭ يَا قَاسِمُ ٭ يَا قَابِضُ ٭ يَا بَاسِطُ

--- 63. BAB ---
يَا مَنْ لَمْ يَتَّخِذْ صَاحِبَةً وَ لَا وَلَدًا ٭ يَا مَنْ لَمْ يَكُنْ لَهُ شَرِيكٌ فِى الْمُلْكِ ٭ يَا مَنْ لَمْ يَكُنْ لَهُ وَلِيٌّ مِنَ الذُّلِّ ٭ يَا مَنْ خَلَقَ كُلَّ شَيْءٍ فَقَدَّرَهُ تَقْدِيرًا ٭ يَا مَنْ يُدَبِّرُ الْأُمْرَ فَلَا شَرِيكَ لَهُ ٭ يَا مَنْ لَا يُشْرِكُ فِى حُكْمِهِ أَحَدًا ٭ يَا مَنْ لَا يُظْلِمُ فِى قَضَائِهِ أَحَدًا ٭ يَا مَنْ لَا يُؤَاخِذُ بِالْخَطَايَا سَرِيعًا ٭ يَا مَنْ لَا يُعَاجِلُ بِالْعُقُوبَةِ مَنْ عَصَاهُ ٭ يَا مَنْ يُحِبُّ التَّوَّابِينَ وَ يُحِبُّ الْمُتَطَهِّرِينَ

--- 64. BAB ---
يَا خَيْرَ الْغَافِرِينَ ٭ يَا خَيْرَ الْفَاتِحِينَ ٭ يَا خَيْرَ النَّاصِرِينَ ٭ يَا خَيْرَ الْحَاكِمِينَ ٭ يَا خَيْرَ الرَّازِقِينَ ٭ يَا خَيْرَ الْوَارِثِينَ ٭ يَا خَيْرَ الْحَامِدِينَ ٭ يَا خَيْرَ الذَّاكِرِينَ ٭ يَا خَيْرَ الْمُنْزِلِينَ ٭ يَا خَيْرَ الْمُحْسِنِينَ

--- 65. BAB ---
يَا مَنْ لَهُ الْعِزَّةُ وَ الْجَمَالُ ٭ يَا مَنْ لَهُ الْقُدْرَةُ وَ الْكَمَالُ ٭ يَا مَنْ لَهُ الْمُلْكُ وَ الْجَلَالُ ٭ يَا مَنْ لَهُ النُّرُ وَ الْبَهَاءُ ٭ يَا مَنْ لَهُ الرَّحْمَةُ وَ الْعَطَاءُ ٭ يَا مَنْ هُوَ كَبِيرٌ مُتَعَالٍ ٭ يَا مَنْ هُوَ شَدِيدُ الْمِحَالِ ٭ يَا مَنْ هُوَ سَرِيعُ الْحِسَابِ ٭ يَا مَنْ هُوَ شَدِيدُ الْعِقَابِ ٭ يَا مَنْ عِنْدَهُ حُسْنُ الثَّوَابِ

--- 66. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا مُصَوِّرُ ٭ يَا مُقَدِّرُ ٭ يَا مُدَبِّرُ ٭ يَا مُطَهِّرُ ٭ يَا مُنَوِّرُ ٭ يَا مُيَسِّرُ ٭ يَا مُبَشِّرُ ٭ يَا مُنْذِرُ ٭ يَا مُقَدِّمُ ٭ يَا مُؤَخِّرُ

--- 67. BAB ---
يَا رَبَّ الْبَيْتِ الْحَرَامِ ٭ يَا رَبَّ الشَّهْرِ الْحَرَامِ ٭ يَا رَبَّ الْبَلَدِ الْحَرَامِ ٭ يَا رَبَّ الرُّكْنِ وَ الْمَقَامِ ٭ يَا رَبَّ الْمَشْعَرِ الْحَرَامِ ٭ يَا رَبَّ الْمَسْجِدِ الْحَرَامِ ٭ يَا رَبَّ الْحِلِّ وَ الْحَرَامِ ٭ يَا رَبَّ النُّورِ وَ الظَّلَامِ ٭ يَا رَبَّ التَّحِيَّةِ وَ السَّلَامِ ٭ يَا رَبَّ الْقُدْرَةِ فِى الْأَنَامِ

--- 68. BAB ---
يَا مَنْ أَحَاطَ كُلَّ شَيْءٍ عِلْمُهُ ٭ يَا مَنْ أَحْصَى كُلَّ شَيْءٍ عَدَدُهُ ٭ يَا مَنْ أَحَاطَ بِالْبَرِّ وَ الْبَحْرِ عِلْمُهُ ٭ يَا مَنْ لَا يَخْفَى عَلَيْهِ خَافِيَةٌ ٭ يَا مَنْ لَا يَعْزُبُ عَنْهُ مِثْقَالُ ذَرَّةٍ ٭ يَا مَنْ يَعْلَمُ مَا فِى الْقُلُوبِ ٭ يَا مَنْ يَعْلَمُ خَائِنَةَ الْأَعْيُنِ وَ مَا تُخْفِي الصُّدُورُ ٭ يَا مَنْ يَعْلَمُ مَا تَحْتَ الثَّرَى ٭ يَا مَنْ يَعْلَمُ أَبْنَاءَ السِّرِّ ٭ يَا مَنْ يَعْلَمُ أَعْمَالَ الْعِبَادِ

--- 69. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا ذَا الْجَلَالِ وَ الْإِكْرَامِ ٭ يَا ذَا الْفَضْلِ وَ الْإِنْعَامِ ٭ يَا ذَا الْعِزَّةِ وَ الْإِقْدَامِ ٭ يَا ذَا الْقُوَّةِ وَ السُّلْطَانِ ٭ يَا ذَا الْمَنِّ وَ الْبَيَانِ ٭ يَا ذَا الرَّحْمَةِ وَ الرِّضْوَانِ ٭ يَا ذَا الْبُرْهَانِ وَ السُّلْطَانِ ٭ يَا ذَا الْآلَاءِ وَ النَّعْمَاءِ ٭ يَا ذَا الْكِبْرِيَاءِ وَ الْعَظَمَةِ ٭ يَا ذَا الْجُودِ وَ الْإِحْسَانِ

--- 70. BAB ---
يَا مَنْ هُوَ الْأَوَّلُ بِلَا بِدَايَةٍ ٭ يَا مَنْ هُوَ الْآخِرُ بِلَا نِهَايَةٍ ٭ يَا مَنْ هُوَ الظَّاهِرُ بِلَا حِجَابٍ ٭ يَا مَنْ هُوَ الْبَاطِنُ بِلَا خَفَاءٍ ٭ يَا مَنْ هُوَ الْمَحْبُوبُ فِى كُلِّ قَلْبٍ ٭ يَا مَنْ هُوَ الْمَعْبُودُ فِى كُلِّ مَكَانٍ ٭ يَا مَنْ هُوَ الْمَطْلُوبُ فِى كُلِّ زَمَانٍ ٭ يَا مَنْ هُوَ الْمَحْمُودُ عَلَى كُلِّ لِسَانٍ ٭ يَا مَنْ هُوَ الْمَشْكُورُ فِى كُلِّ إِحْسَانٍ ٭ يَا مَنْ هُوَ الْمُطَاعُ فِى كُلِّ أَمْرٍ

--- 71. BAB ---
يَا مَنْ لَا تُدْرِكُهُ الأَبْصَارُ ٭ يَا مَنْ لَا تُحْصِيهِ الْعُقُولُ ٭ يَا مَنْ لَا تَعْرِفُهُ القُلُوبُ كَيْفَ هُوَ ٭ يَا مَنْ لَا يَجْرِي عَلَيْهِ زَمَانٌ ٭ يَا مَنْ لَا يَتَغَيَّرُ بِزَمَانٍ ٭ يَا مَنْ لَا يَتَحَوَّلُ عَنْ حَالٍ ٭ يَا مَنْ لَا يُؤْذِيهِ سَمْعٌ ٭ يَا مَنْ لَا يَشْغَلُهُ شَأْنٌ عَنْ شَأْنٍ ٭ يَا مَنْ لَا يُغَيِّرُهُ دَهْرٌ ٭ يَا مَنْ هُوَ فِى عُلُوِّهِ كَمَا هُوَ

--- 72. BAB ---
يَا نُورَ النُّورِ ٭ يَا مُنَوِّرَ النُّورِ ٭ يَا خَالِقَ النُّورِ ٭ يَا مُدَبِّرَ النُّورِ ٭ يَا قَدِرَ النُّورِ ٭ يَا مُقَدِّرَ النُّورِ ٭ يَا نُورًا كُلَّ نُورٍ ٭ يَا نُورًا قَبْلَ كُلِّ نُورٍ ٭ يَا نُورًا بَعْدَ كُلِّ نُورٍ ٭ يَا نُورًا فَوْقَ كُلِّ نُورٍ

--- 73. BAB ---
يَا مَنْ حِقْبَتُهُ دَائِمَةٌ ٭ يَا مَنْ قُدْرَتُهُ نَافِذَةٌ ٭ يَا مَنْ عِزَّتُهُ شَامِخَةٌ ٭ يَا مَنْ حِكْمَتُهُ بَالِغَةٌ ٭ يَا مَنْ مَشِيَّتُهُ كَامِلَةٌ ٭ يَا مَنْ حُكْمُهُ عَادِلٌ ٭ يَا مَنْ قَضَاؤُهُ حَقٌّ ٭ يَا مَنْ وَعْدُهُ صَادِقٌ ٭ يَا مَنْ قَوْلُهُ عَدْلٌ ٭ يَا مَنْ آيَاتُهُ كُبْرَى

--- 74. BAB ---
يَا مَنْ لَا يُرَدُّ قَضَاؤُهُ ٭ يَا مَنْ لَا يُخْلَفُ وَعْدُهُ ٭ يَا مَنْ لَا يُبَدَّلُ حُكْمُهُ ٭ يَا مَنْ لَا يَجْرِي مَعَهُ حِكَايَةٌ ٭ يَا مَنْ لَا يُعَاقِبُ بِعَجَلَةٍ ٭ يَا مَنْ لَا يَمْتَنِعُ عَلَيْهِ شَيْءٌ ٭ يَا مَنْ لَا يُعْجِزُهُ شَيْءٌ ٭ يَا مَنْ لَا يَخْفَى عَلَيْهِ شَيْءٌ ٭ يَا مَنْ لَا يَغْرُهُ خِدَاعٌ ٭ يَا مَنْ لَا يَضُرُّهُ شَيْءٌ

--- 75. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا خَالِقُ ٭ يَا رَازِقُ ٭ يَا نَاطِقُ ٭ يَا صَادِقُ ٭ يَا فَالِقُ ٭ يَا شَافِقُ ٭ يَا مُوَفِّقُ ٭ يَا مُحَقِّقُ ٭ يَا مُدَقِّقُ ٭ يَا مُمْحِقُ

--- 76. BAB ---
يَا مَنْ هُوَ فِى عُلُوِّهِ قَرِيبٌ ٭ يَا مَنْ هُوَ فِى قُرْبِهِ لَطِيفٌ ٭ يَا مَنْ هُوَ فِى لُطْفِهِ شَرِيفٌ ٭ يَا مَنْ هُوَ فِى شَرَفِهِ عَزِيزٌ ٭ يَا مَنْ هُوَ فِى عِزَّتِهِ عَظِيمٌ ٭ يَا مَنْ هُوَ فِى عَظَمَتِهِ مَجِيدٌ ٭ يَا مَنْ هُوَ فِى مَجْدِهِ حَمِيدٌ ٭ يَا مَنْ هُوَ فِى حَمْدِهِ قَدِيمٌ ٭ يَا مَنْ هُوَ فِى قِدَمِهِ دَائِمٌ ٭ يَا مَنْ هُوَ فِى دَيْمُومَتِهِ عَلِيمٌ

--- 77. BAB ---
يَا مَنْ لَا يَخْرُجُ عَنْ سُلْطَانِهِ شَيْءٌ ٭ يَا مَنْ لَا يَدْخُلُ فِى مُلْكِهِ مَا لَا يُرِيدُ ٭ يَا مَنْ لَا تَنْفَدُ خَزَائِنُهُ ٭ يَا مَنْ لَا تَنْقُصُ سَعَادَتُهُ ٭ يَا مَنْ لَا تُغَيِّرُهُ الْأَيَّامُ ٭ يَا مَنْ لَا تُبَدِّلُهُ الشُّهُورُ ٭ يَا مَنْ لَا تُبْلِيهِ الأَعْوَامُ ٭ يَا مَنْ لَا تَخْفَى عَلَيْهِ الأَزْمَانُ ٭ يَا مَنْ لَا تَحْتَاجُ خَزَائِنُهُ إِلَى مِفْتَاحٍ ٭ يَا مَنْ لَا يُحَاسِبُ عِبَادَهُ عَلَى مَا لَمْ يُرِدْ

--- 78. BAB ---
يَا مَنْ عِلْمُهُ نَافِذٌ ٭ يَا مَنْ قُدْرَتُهُ كَامِلَةٌ ٭ يَا مَنْ رَحْمَتُهُ وَاسِعَةٌ ٭ يَا مَنْ حِكْمَتُهُ بَالِغَةٌ ٭ يَا مَنْ آيَاتُهُ ظَاهِرَةٌ ٭ يَا مَنْ أَمْرُهُ حَاقٌّ ٭ يَا مَنْ هَدْيُهُ قَوِيمٌ ٭ يَا مَنْ حُكْمُهُ عَدْلٌ ٭ يَا مَنْ نِعْمَتُهُ سَابِغَةٌ ٭ يَا مَنْ فَضْلُهُ عَظِيمٌ

--- 79. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا مَالِكُ ٭ يَا مَلِيكُ ٭ يَا مُسْتَعِينُ ٭ يَا مُسْتَعِيدُ ٭ يَا مُسْتَفْتِحُ ٭ يَا مُسْتَنْقِذُ ٭ يَا مُسْتَرْحِمُ ٭ يَا مُسْتَرْزِقُ ٭ يَا مُسْتَنْصِرُ ٭ يَا مُسْتَغْفِرُ

--- 80. BAB ---
يَا مَنْ هُوَ اِلَيْهِ يَرْجِعُ كُلُّ شَيْءٍ ٭ يَا مَنْ هُوَ بَدَأَ كُلَّ شَيْءٍ ثُمَّ يُعِيدُهُ ٭ يَا مَنْ هُوَ خَلَقَ كُلَّ شَيْءٍ فَقَدَّرَهُ ٭ يَا مَنْ هُوَ دَبَّرَ كُلَّ شَيْءٍ فَقَضَاهُ ٭ يَا مَنْ هُوَ مَلَكَ كُلَّ شَيْءٍ فَسَوَّاهُ ٭ يَا مَنْ هُوَ رَزَقَ كُلَّ شَيْءٍ فَأَحْسَنَهُ ٭ يَا مَنْ هُوَ أَحْصَى كُلَّ شَيْءٍ فَعَدَّهُ ٭ يَا مَنْ هُوَ خَزَنَ كُلَّ شَيْءٍ فَحَفِظَهُ ٭ يَا مَنْ هُوَ أَبْدَأَ كُلَّ شَيْءٍ فَأَنْشَأَهُ ٭ يَا مَنْ هُوَ أَعَادَ كُلَّ شَيْءٍ فَسَطَاعَهُ

--- 81. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا حَبِيبُ ٭ يَا طَبِيبُ ٭ يَا قَرِيبُ ٭ يَا رَقِيبُ ٭ يَا حَسِيبُ ٭ يَا مُبِيبُ ٭ يَا خَبِيبُ ٭ يَا مَخِيبُ ٭ يَا مُصِيبُ ٭ يَا مُمِيتُ

--- 82. BAB ---
يَا مَنْ هُوَ فِى عِلْمِهِ كَبِيرٌ ٭ يَا مَنْ هُوَ فِى عِزَّتِهِ ضَرِيرٌ (جَلِيلٌ) ٭ يَا مَنْ هُوَ فِى قُدْرَتِهِ قَدِيرٌ ٭ يَا مَنْ هُوَ فِى خَلْقِهِ بَصِيرٌ ٭ يَا مَنْ هُوَ فِى لُطْفِهِ خَبِيرٌ ٭ يَا مَنْ هُوَ فِى مَجْدِهِ كَبِيرٌ ٭ يَا مَنْ هُوَ فِى عُلُوِّهِ مُنِيرٌ ٭ يَا مَنْ هُوَ فِى بَهَائِهِ جَمِيلٌ ٭ يَا مَنْ هُوَ فِى وَعْدِهِ صَادِقٌ ٭ يَا مَنْ هُوَ فِى حُكْمِهِ عَادِلٌ

--- 83. BAB ---
يَا مَنْ هُوَ مَنِيعٌ غَيْرُ مُضَامٍ ٭ يَا مَنْ هُوَ حَفِيظٌ غَيْرُ غَافِلٍ ٭ يَا مَنْ هُوَ قَوِيٌّ غَيْرُ ضَعِيفٍ ٭ يَا مَنْ هُوَ غَنِيٌّ غَيْرُ فَقِيرٍ ٭ يَا مَنْ هُوَ عَزِيزٌ غَيْرُ ذَلِيلٍ ٭ يَا مَنْ هُوَ بَصِيرٌ غَيْرُ أَعْمَى ٭ يَا مَنْ هُوَ سَمِيعٌ غَيْرُ أَصَمَّ ٭ يَا مَنْ هُوَ حَلِيمٌ غَيْرُ عَجُولٍ ٭ يَا مَنْ هُوَ عَلِيمٌ غَيْرُ جَهُولٍ ٭ يَا مَنْ هُوَ جَوَادٌ غَيْرُ بَخِيلٍ

--- 84. BAB ---
يَا مَنْ هُوَ فِى التَّوْرَاةِ كَلِيمٌ ٭ يَا مَنْ هُوَ فِى الْإِنْجِيلِ عِيسَى ٭ يَا مَنْ هُوَ فِى الزَّبُورِ دَاوُدُ ٭ يَا مَنْ هُوَ فِى الْفُرْقَانِ مُحَمَّدٌ ٭ يَا مَنْ هُوَ فِى الْقُدُوسِ سُبْحَانٌ ٭ يَا مَنْ هُوَ فِى الْعَظَمَةِ إِلَهٌ ٭ يَا مَنْ هُوَ فِى كُلِّ شَيْءٍ مَوْجُودٌ ٭ يَا مَنْ هُوَ فِى الْآخِرَةِ وَ الدُّنْيَا مَعْبُودٌ ٭ يَا مَنْ هُوَ فِى الْقُلُوبِ مَحْبُوبٌ ٭ يَا مَنْ هُوَ عَلَى الْعَرْشِ اسْتَوَى

--- 85. BAB ---
Ey kullarına yardım edip destekleyen Mü'ضıd,

--- 86. BAB ---
يَا مَنْ يَعْلَمُ السِّرَّ وَ أَخْفَى ٭ يَا مَنْ يَعْلَمُ الْوِزْرَ وَ الْخَطَايَا ٭ يَا مَنْ لَا يَفُوتُهُ هَرَبٌ ٭ يَا مَنْ لَا يَشْغَلُهُ شَأْنٌ عَنْ شَأْنٍ ٭ يَا مَنْ لَا يُعْجِزُهُ شَيْءٌ ٭ يَا مَنْ يَعْلَمُ مَا فِى الْبَرِّ وَ الْبَحْرِ ٭ يَا مَنْ يَعْلَمُ مَا يَسْقُطُ مِنْ وَرَقَةٍ إِلَّا يَعْلَمُهَا ٭ يَا مَنْ لَا حَبَّةٍ فِى ظُلُمَاتِ الْأَرْضِ إِلَّا يَعْلَمُهَا ٭ يَا مَنْ لَا رَطْبٍ وَ لَا يَابِسٍ إِلَّا فِى كِتَابٍ مُبِينٍ ٭ يَا مَنْ يَعْلَمُ حَدِيثَ النُّفُوسِ

--- 87. BAB ---
يَا ذَا الْجُودِ وَ الْإِحْسَانِ ٭ يَا ذَا الْفَضْلِ وَ الـْمِنَّةِ ٭ يَا ذَا الْعَطَاءِ وَ الرَّحْمَةِ ٭ يَا ذَا الْعِزَّةِ وَ الْقُدْرَةِ ٭ يَا ذَا الْمَنِّ وَ الْبَيَانِ ٭ يَا ذَا الْكِبْرِيَاءِ وَ الْعَظَمَةِ ٭ يَا ذَا الْبُرْهَانِ وَ السُّلْطَانِ ٭ يَا ذَا الْآلَاءِ وَ النَّعْمَاءِ ٭ يَا ذَا الرِّضْوَانِ وَ الْغُفْرَانِ ٭ يَا ذَا الْجَلَالِ وَ الْإِكْرَامِ

--- 88. BAB ---
يَا مَنْ هُوَ اللَّهُ الَّذِي لَا إِلَهَ إِلَّا هُوَ ٭ يَا مَنْ هُوَ الرَّحْمَنُ الرَّحِيمُ ٭ يَا مَنْ هُوَ الْمَلِكُ الْقُدُّوسُ ٭ يَا مَنْ هُوَ السَّلَامُ الْمُؤْمِنُ ٭ يَا مَنْ هُوَ الْمُهَيْمِنُ الْعَزِيزُ ٭ يَا مَنْ هُوَ الْجَبَّارُ الْمُتَكَبِّرُ ٭ يَا مَنْ هُوَ الْخَالِقُ الْبَارِئُ ٭ يَا مَنْ هُوَ الْمُصَوِّرُ الْغَفَّارُ ٭ يَا مَنْ هُوَ الْقَهَّارُ الْوَهَّابُ ٭ يَا مَنْ هُوَ الرَّزَّاقُ الْفَتَّاحُ

--- 89. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا عَلِيمُ ٭ يَا حَكِيمُ ٭ يَا سَمِيعُ ٭ يَا بَصِيرُ ٭ يَا قَرِيبُ ٭ يَا مُجِيبُ ٭ يَا حَسِيبُ ٭ يَا خَبِيرُ ٭ يَا كَرِيمُ ٭ يَا مَجِيدُ

--- 90. BAB ---
يَا مَنْ هُوَ فِى السَّمَاءِ عَظِيمٌ ٭ يَا مَنْ هُوَ فِى الْأَرْضِ آيَاتُهُ ٭ يَا مَنْ هُوَ فِى كُلِّ شَيْءٍ دَلَائِلُهُ ٭ يَا مَنْ هُوَ فِى الْبِحَارِ عَجَائِبُهُ ٭ يَا مَنْ هُوَ فِى الْجِبَالِ خَزَائِنُهُ ٭ يَا مَنْ هُوَ يَبْدَأُ الْخَلْقَ ثُمَّ يُعِيدُهُ ٭ يَا مَنْ هُوَ إِلَيْهِ يَرْجِعُ الْأَمْرُ كُلُّهُ ٭ يَا مَنْ هُوَ أَظْهَرَ فِى كُلِّ شَيْءٍ لُطْفَهُ ٭ يَا مَنْ هُوَ أَحْسَنَ كُلَّ شَيْءٍ خَلَقَهُ ٭ يَا مَنْ هُوَ قَسَمَ الْأَرْضَ بَيْنَ خَلْقِهِ

--- 91. BAB ---
يَا صَاحِبَ كُلِّ فَرِيدٍ ٭ يَا وَلِيُّ كُلِّ شَرِيدٍ ٭ يَا قَايِمُ عَلَى كُلِّ عَبْدٍ بِمَا كَسَبَ ٭ يَا مُحِيطًا بِكُلِّ مَخْلُوقٍ ٭ يَا كَافِيَ مَنْ اسْتَكْفَاهُ ٭ يَا دَاعِيَ مَنِ اسْتَدْعَاهُ ٭ يَا رَاحِمَ مَنِ اسْتَرْحَمَهُ ٭ يَا غَافِرَ مَنِ اسْتَغْفَرَهُ ٭ يَا صَاحِبَ كُلِّ غَرِيبٍ ٭ يَا اُنْسَ كُلِّ وَحِيدٍ

--- 92. BAB ---
يَا حَفِيظًا لَا يَغْفُلُ ٭ يَا مُحِيطًا لَا يُفْوَتُ ٭ يَا قَائِمًا لَا يَزُولُ ٭ يَا دَائِمًا لَا يَبِيدُ ٭ يَا حَيًّا لَا يَمُوتُ ٭ يَا قَيُّومًا لَا يَسْنُو (يَسْنُو/يَنَامُ) ٭ يَا عَظِيمًا لَا يُرَامُ ٭ يَا كَبِيرًا لَا يُضَامُ ٭ يَا قَوِيًّ لَا يُقْهَرُ ٭ يَا مَنِيعًا لَا يُضَامُ

--- 93. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا بَدِيعُ ٭ يَا مُنِيعُ ٭ يَا سَمِيعُ ٭ يَا مُسْتَمِيعُ ٭ يَا بَدِيعُ ٭ يَا رَفِيعُ ٭ يَا مَنِيعُ ٭ يَا سَمِيعُ ٭ يَا بَصِيرُ ٭ يَا عَلِيمُ

--- 94. BAB ---
يَا مَنْ هُوَ فِى عِزَّتِهِ شَامِخٌ ٭ يَا مَنْ هُوَ فِى جَلَالِهِ عَظِيمٌ ٭ يَا مَنْ هُوَ فِى كِبْرِيَائِهِ جَمِيلٌ ٭ يَا مَنْ هُوَ فِى مُلْكِهِ دَائِمٌ ٭ يَا مَنْ هُوَ فِى مَجْدِهِ حَمِيدٌ ٭ يَا مَنْ هُوَ فِى قُدْرَتِهِ قَوِيٌّ ٭ يَا مَنْ هُوَ فِى عُلُوِّهِ كَبِيرٌ ٭ يَا مَنْ هُوَ فِى حِكْمَتِهِ بَالِغٌ ٭ يَا مَنْ هُوَ فِى خَلْقِهِ حَكِيمٌ ٭ يَا مَنْ هُوَ فِى لُطْفِهِ خَبِيرٌ

--- 95. BAB ---
يَا مَنْ لَا يُشْرِكُ فِى حُكْمِهِ أَحَدًا ٭ يَا مَنْ لَا يُعَاضِدُ فِى قَضَائِهِ أَحَدًا ٭ يَا مَنْ لَا يُؤَازِرُ فِى أَمْرِهِ أَحَدًا ٭ يَا مَنْ لَا يُشَارِكُ فِى خَلْقِهِ أَحَدًا ٭ يَا مَنْ لَا يَهْتَدِي فِى فِعْلِهِ أَحَدًا ٭ يَا مَنْ لَا يُخَالِفُ فِى سُلْطَانِهِ أَحَدًا ٭ يَا مَنْ لَا يَجْرِي فِى عَدْلِهِ أَمْرٌ يُخَالِفُهُ ٭ يَا مَنْ لَا يُحَاسِبُ غَيْرَهُ فِى مُلْكِهِ ٭ يَا مَنْ لَا يَخْرُجُ عَنْ قَبْضَتِهِ أَحَدٌ ٭ يَا مَنْ لَا يُعْجِزُهُ كُلُّ شَيْءٍ

--- 96. BAB ---
يَا مَنْ هُوَ لَمْ يَلِدْ وَ لَمْ يُولَدْ ٭ وَ لَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ ٭ يَا مَنْ هُوَ سَمِيعٌ بَصِيرٌ ٭ يَا مَنْ هُوَ عَلِيمٌ خَبِيرٌ ٭ يَا مَنْ هُوَ قَدِيرٌ قَاهِرٌ ٭ يَا مَنْ هُوَ حَلِيمٌ غَفُورٌ ٭ يَا مَنْ هُوَ رَؤُوفٌ رَحِيمٌ ٭ يَا مَنْ هُوَ خَالِقٌ رَازِقٌ ٭ يَا مَنْ هُوَ بَاعِثٌ وَارِثٌ ٭ يَا مَنْ هُوَ أَوَّلُ وَ آخِرُ

--- 97. BAB ---
Ey darda kalanların (muzطرların) dualarına icabet eden Mücîbü Da'veti’l-Mudtarrîn,

--- 98. BAB ---
يَا ذَا الْجُودِ وَ الْإِحْسَانِ ٭ يَا ذَا الْفَضْلِ وَ الـْمِنَّةِ ٭ يَا ذَا الْأَمْنِ وَ الْأَمَانِ ٭ يَا ذَا الْقُدْسِ وَ السَّلَامِ ٭ يَا ذَا الْحِكْمَةِ وَ الْبَيَانِ ٭ يَا ذَا الرَّحْمَةِ وَ الرِّضْوَانِ ٭ يَا ذَا الْحُجَّةِ وَ الْبُرْهَانِ ٭ يَا ذَا الْعَظَمَةِ وَ السُّلْطَانِ ٭ يَا ذَا الرَّأْفَةِ وَ الْمُسْتَعَانِ ٭ يَا ذَا الْعَفْوِ وَ الْغُفْرَانِ

--- 99. BAB ---
يَا مَنْ هُوَ رَبُّ كُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ إِلَهُ كُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ خَالِقُ كُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ صَانِعُ كُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ قَبْلَ كُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ بَعْدَ كُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ فَوْقَ كُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ عَالِمٌ بِكُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ قَادِرٌ عَلَى كُلِّ شَيْءٍ ٭ يَا مَنْ هُوَ يَبْقَى وَ يَفْنَى كُلُّ شَيْءٍ

--- 100. BAB ---
وَ اَسْئَلُكَ بِاَسْمَٓائِكَ يَا خَيْرَ غَافِرٍ ٭ يَا خَيْرَ فَاتِحٍ ٭ يَا خَيْرَ نَاصِرٍ ٭ يَا خَيْرَ حَاكِمٍ ٭ يَا خَيْرَ رَازِقٍ ٭ يَا خَيْرَ وَارِثٍ ٭ يَا خَيْرَ حَامِدٍ ٭ يَا خَيْرَ ذَاكِرٍ ٭ يَا خَيْرَ مُنْزِلٍ ٭ يَا خَيْرَ مُحْسِنٍ''',
    okunus: '''--- 1. BAB ---
Bismillâhirrahmânirrahîm
Allâhümme innî es’elüke biesmâike
Yâ Allah
Yâ Rahman
YâRahîm
Yâ’Alîm
Yâ Halîm
Yâ Azîm
Yâ Hakîm
Yâ Kadîm
Yâ Mukîm
Yâ Kerîm
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 2. BAB ---
Yâ Seyyide’s-sâdât
Yâ Mucîbe’d-de’avât
Yâ Veliyye’l-hasenât
Yâ Refıa’d-deracât
Yâ Azîme’l-berakât
Yâ Ğafıra’l-hatîât
Yâ Dâfî’a’l-beliyyât
Yâ Sâmi’a’l-esvât
Yâ Mu’tıye’l-mesûlât
Yâ ‘Alime’s-sirri ve’l-hafiyyât
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nar.

--- 3. BAB ---
Ya Hayra’l-ğâfirîn
Ya Hayra’n-nâsırîn
Ya Hayra’l-hâkimîn
Ya Hayra’l-fatihîn
Yâ Hayra’z-zâkirîn
Yâ Hayra’l-vârişîn
Yâ Hayra’l-hâmidîn
Yâ Hayra’r-râzikîn
Yâ Hayra’l-fâsilîn
Yâ Hayra’l-muhsinîn
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 4. BAB ---
Yâ Men lehü’l-‘izzü ve’l-cemâl
Yâ Men lehü’l-mülkü ve’l-celâl
Yâ Men lehü’l-kudretü ve’l-kemâl
Yâ Men hüve’l-kebîru’l-müte’âl
Yâ Men hüve şedîdü’l-mihâl
Yâ Men hüve şedîdü’l-‘ikâb
Yâ Men hüve serî’u’l-hisâb
Yâ Men hüve ‘indehû hüsnü’s-şevâb
Yâ Men hüve ‘indehû ümmü’l-kitâb
Yâ Men hüve yünşiü’s-sehâbe’s-sikâl
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 5. BAB ---
Ve es’elüke biesmâike
Yâ Hannân
Yâ Mennân
Yâ Deyyân
Yâ Gufran
Yâ Burhan
Yâ Sultân
Yâ Sübhân
Yâ Müste’ân
Yâ Ze’l-menni ve’l-beyân
Yâ Ze’l-emân
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 6. BAB ---
Yâ Men tevâda’a küllü şey’in li’azametih
Yâ Meni’stesleme küllü şey’in likudratih
Yâ Men zelle küllü şey’in li’izzetih
Yâ Men hada’a küllü şey’in liheybetih
Yâ Meni’nkâde küllü şey’in limülketih
Yâ Men dâne küllü şey’in min mehâfetih
Yâ Meni’nşakkati’l-cibâlü min haşyetin
Yâ Men kâmeti’s-semâvâtü bi emrih
Yâ Meni’stekarrati’l-ardu bi iznih
Yâ Men lâ yâ’tedî ‘alâ ehli memleketih
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 7. BAB ---
Yâ Ğâfıra’l-hatâyâ
Yâ Kâşife’l-belâyâ
Yâ Müntehe’r-racâyâ
Yâ Müczile’l-‘atâyâ
Yâ Vâsi’a’l-hedâyâ
Yâ Râzika’l-berâyâ
Yâ Kâdiya’l-münâyâ
Yâ Sâmi’a’ş-şekâyâ
Yâ Bâ’ise’s-serâyâ
Yâ Mutlika’l-üsârâ
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 8. BAB ---
Yâ Ze’l-hamdi ve’s-senâ
Yâ Ze’l-mecdi ve’s-senâ
Yâ Ze’l-fahri ve’l-behâ
Yâ Ze’l-‘ahdi ve’l-vefâ
Yâ Ze’l-‘afvi ve’r-ridâ
Yâ Ze’l-menni ve’l-‘atâ
Yâ Ze’l-fasli ve’l-kadâ
Yâ Ze’l-‘izzeti ve’l-bekâ
Yâ Ze’l-cûdi ve’n-na’mâ
Yâ Ze’l-fadli ve’l-‘âlâ
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 9. BAB ---
Ve es’elüke biesmâike
Yâ Mâni’
Yâ Dâfi’
Yâ Nâfi’
Yâ Sami’
Yâ Râfi’
Yâ Sâni’
Yâ Şâfi’
Yâ Cami’
Yâ Vâsi’
Yâ Mûsi’
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 10. BAB ---
Yâ Sâni’a külli masnû’
Yâ Halika külli mahlûk
Yâ Râzika külli merzûk
Yâ Mâlike külli memlûk
Yâ Kâşife külli mekrûb
Yâ Fârice külli mağmum
Yâ Râhime külli merhum
Yâ Nasıra külli mahzûl
Yâ Sâtira külli mâ’yûb
Yâ Melcee külli mazlum
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 11. BAB ---
Yâ ‘Uddetî ‘inde şiddeti
Yâ Recâî ‘inde müsîbeti
Yâ Mûnisî ‘inde vahşeti
Yâ Sâhibî ‘inde gurbeti
Yâ Veliyyî ‘inde ni’metî
Yâ Kâşifi ‘inde kürbetî
Yâ Ğıyâşî ‘inde’f-tikârî
Yâ Melceî ‘inde’d-dırârî
Yâ Mu’înî ‘inde feze’î
Yâ Delîlî ‘inde hayrati
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 12. BAB ---
Yâ ‘Allâme’l-ğuyûb
Yâ Ğaffara’z-zünûb
Yâ Settâra’l-‘uyûb
Yâ Keşşâfe’l-kürûb
Yâ Mukallibe’l-kulûb
Yâ Müzeyyine’l-kulûb
Yâ Münevvira’l-kulûb
Yâ Tabîbe’l-kulûb
Yâ Habîbe’l-kulûb
Yâ Enîse’l-kulûb
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 13. BAB ---
Ve es’elüke biesmâike
Yâ Celîl
Yâ Cemîl
Yâ Vekîl
Yâ Kefil
Yâ Delîl
Yâ Mükîl
Yâ Habîr
Yâ Latîf
Yâ ‘Azîz
Yâ Melîk
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 14. BAB ---
Yâ Delîle’l-mütehayyirîn
Yâ Gıyâşe’l-müsteğîşîn
Yâ Sarîha’l-müstesrihîn
Yâ Câra’l-müstecîrîn
Yâ Melcee’l-‘âsîn
Yâ Ğâfıra’l-müznibîn
Yâ Emâne’l-hâifîn
Yâ Râhime’l-mesâkîn
Yâ Enîse’l-müstevhişîn
Yâ Mücîbe da’veti’l-müdtarrîn
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 15. BAB ---
Yâ Ze’l-cûdi ve’l-ihsân
Yâ Ze’l-fadli ve’l-imtinân
Yâ Ze’l-emni ve’l-emân
Yâ Ze’l-kudsi ve’s-sübhân
Yâ Ze’l-hikmeti ve’l-beyân
Yâ Ze’r-rahmeti ve’r-rıdvân
Yâ Ze’l-hucceti ve’l-bürhân
Yâ Ze’l-‘azameti ve’s-sultân
Yâ Ze’l-‘afvi ve’l-ğvıfrân
Yâ Ze’r-ra’feti ve’l-müste’ân
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 16. BAB ---
Yâ Men hüve Rabbü külli şey’
Yâ Men hüve ilâhü külli şey’
Yâ Men hüve Hâliku külli şey’
Yâ Men hüve fevka külli şey’
Yâ Men hüve kable külli şey’
Yâ Men hüve ba’de külli şey’
Yâ Men hüve ‘Alimü külli şey’
Yâ Men hüve Kâdiru külli şey’
Yâ Men hüve Sâni’u külli şey’
Yâ Men hüve yebkâ veyefnâ küllü şey’
Sübhâneke lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 17. BAB ---
Ve es’elüke biesmâike
Yâ Mü’min
Yâ Müheymin
Yâ Mükevvin
Yâ Mülakkin
Yâ Mübeyyin
Yâ Mühevvin
Yâ Müzeyyin
Yâ Mu’azzim
Yâ Mu’avvin
Yâ Mülevvin
Sübhâneke lâ ilahe illâ ente’l-emâ ne’l-emâne hallisnâ mine’n-nâr.

--- 18. BAB ---
Yâ men hüve fî mülkihî mükîm
Yâ men hüve fî celâlihî ‘azîm
Yâ men hüve fî sültânihî kadîm
Yâ men hüve ‘alâ ‘abdihî rahîm
Yâ men hüve bikülli şey’in ‘alîm
Yâ men hüve limen cefâhu halîm
Yâ men hüve limen teraccâhü kerîm
Yâ men hüve fî mekâdîrihî hakim
Yâ men hüve fi hükmihî latîf
Yâ men hüve fı lütfihî kadîr
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 19. BAB ---
Yâ men la yürcâ illâ fadlüh
Yâ men lâ yühâfü illâ ‘adlüh
Yâ men lâ yüntezaru illa birruh
Yâ men lâ yüs’elü illâ ‘afvüh
Yâ men lâ yedûmü illâ mülküh
Yâ men lâ sültâne illâ sültânüh
Yâ men lâ bürhâne illâ bürhânüh
Yâ men vesiat külle şey’in rahmetüh
Yâ men sebekat rahmetühû ‘alâ ğadabih
Yâ men ehâta bi külli şey’in ‘ilmüh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 20. BAB ---
Yâ Fârice’l-hemm
Yâ Kâşife’l-ğamm
Yâ Gâfire’z-zenb
Yâ Kâbile’t-tevb
Yâ Hâlika’l-halk
Yâ Sâdika’l-va’d
Yâ Râzika’t-tıfl
Yâ Mûfiye’l-‘ahd
Yâ ‘Alime’s-sirr
Yâ Fâlika’l-habb
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 21. BAB ---
Ve es’elüke biesmâike
Yâ ‘Aliyy
Yâ Vefiyy
Yâ Veliyy
Yâ Ganiyy
Yâ Meliyy
Yâ Zekiyy
Yâ Radiyy
Yâ Bediyy
Yâ HafIyy
Yâ Kaviyy
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 22. BAB ---
Yâ Men azhera’l-cemîl
Yâ Men setera ‘ale’l-kabîh
Yâ Men lâ yüâhizü bi’l-cerîmeh
Yâ Men lâ yehtikü’s-sitr
Yâ ‘Azîme’l-‘afv
Yâ Hasene’t-tecâvüz
Yâ Vâsi’a’l-mağfireh
Yâ Bâsita’l-yedeyni bi’r-rahmeh
Yâ Sahibe külli necvâ
Yâ Müntehâ külli şekva
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 23. BAB ---
Yâ Ze’n-ni’meti’s-sâbiğah
Yâ Ze’r-rahmeti’l-vâsi’ah
Yâ Ze’l-hikmeti’l-bâliğah
Yâ Ze’l-kudreti’l-kâmileh
Yâ Ze’l-hucceti’l-kâtı’ah
Yâ Ze’l-kerâmeti’z-zâhirah
YâZe’s-sıfati’l-‘âliyeh
YâZe’l-‘izzeti’d-dâimeh
Yâ Ze’l-kuvveti’l-metîneh
Yâ Ze’l-minneti’s-sâbikah
Sübhâneke yâ lâ ilahe illâ entei-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 24. BAB ---
Yâ Ahkeme’l-hâkimîn
Yâ ‘Adele’l-‘âdilîn
Yâ Asdeka’s-sâdikîn
Yâ Azhera’z-zâhirîn
Yâ Athera’t-tâhirîn
Yâ Ahsene’l-hâlikîn
Yâ Esra’a’l-hâsibîn
Yâ Esme’a’s-sâmi’în
Yâ Ekrame’l-ekramîn
Yâ Erhame’r-râhimîn
11 Yâ Eşfe’a’ş-şâfi’în
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 25. BAB ---
Yâ Bedi’a’s-semâvât
Yâ Câ’ile’z-zulümât
Yâ ‘A’lime’l-hafıyyât
Yâ Râhîme’l-‘aberât
Yâ Sâtira’l-‘averât
Yâ Kâşife’l-beliyyât
Yâ Muhyiye’l-emvât
Yâ Dâ’ife’l-hasenât
Yâ Münzile’l-berakât
Yâ Şedîde’n-nekamât
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 26. BAB ---
Ve es’elüke biesmâike
Yâ Müsavvir
YâMükaddir
Yâ Mütahhir
Yâ Münevvir
Yâ Mükaddim
Yâ Müahhir
Yâ Müyessir
Yâ Münzir
Yâ Mübeşşir
Yâ Müdebbir
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 27. BAB ---
Yâ Rabbe’l-beyti’l-harâm
Yâ Rabbe’ş-şehri’l-harâm
Yâ Rabbe’l-mescidi’l-harâm
Yâ Rabbe’l-beledi’l-harâm
Yâ Rabbe’r-rukni ve’l-mekâm
Yâ Rabbe’l-meş’ari’l-harâm
Yâ Rabbe’l-hılli ve’l-haram
Yâ Rabbe’n-nûri.ve’z-zalâm
Yâ Rabbe’t-tahiyyeti ve’s-selâm
Yâ Rabbe’l-celâli ve’l-ikrâm
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 28. BAB ---
Yâ ‘İmâde men lâ ‘imâde leh
Yâ Senede men lâ senede leh
Yâ Zühra men lâ zühra leh
Yâ Giyâşe men lâ ğiyâşe leh
Yâ Hırze men lâ hırze leh
Yâ Fahra men lâ fahra leh
Yâ ‘İzze men lâ ‘izze leh
Yâ Mu’îne men lâ mu’îne leh
Yâ Enîse men lâ enîse leh
Yâ Gunyete men lâ gunyete leh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 29. BAB ---
Ve es’elüke biesmâike
Yâ Kâim
Yâ Dâim
Yâ Rahim
Yâ Hâkim
Yâ ‘Âlim
Yâ ‘Âsim
Yâ Kâsim
Yâ Salim
Yâ Kâbid
Yâ Basit
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 30. BAB ---
Yâ ‘Âsıme-meni’sta’sameh
Yâ Râhime meni’sterhameh
Yâ Nasıra meni’stensarah
Yâ Hafıza meni’stahfezah
Yâ Mükrime meni’stekrameh
Yâ Mürşide meni’sterşedeh
Yâ Mu’îne meni’ste’âneh
Yâ Muğîşe meni’steğâşeh
Yâ Sarîha meni’stesrahah
Yâ Ğâfıra meni’stağferah
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’rı-nâr.

--- 31. BAB ---
Yâ Kerîme’s-saftı
Yâ ‘Azîme’l-menn
Yâ Keşîra’l-hayr
Yâ Kadîme’l-fadl
Yâ Latîfe’s-sun’
Yâ Dâime’l-lütf
Yâ Nâfise’l-kerb
Yâ Kâşife’d-durr
Yâ Mâlike’l-mülk
Yâ Kâdiyen bi’l-hakk
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 32. BAB ---
Yâ ‘Azîzen lâ yüdâm
Yâ Latîfen lâ yürâm
Yâ Rakîben lâ yenâm
Yâ Kaimen lâ yefût
Yâ Hayyen lâ yemût
Yâ Meliken lâyezûl
Yâ Bakiyen lâ yefnâ
Yâ ‘Alimen lâ yechel
Yâ Sameden lâ yüt’âm
Yâ Kaviyyen lâ yüd’af
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 33. BAB ---
Ve es’elüke biesmâike
Yâ Vâhid
Yâ Vâcid
Yâ Şâhid
Yâ Mâcid
Yâ Râşid
Yâ Bâiş
Yâ Vâris
Yâ Dârr
Yâ Nâfi’
Yâ Hâdî
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 34. BAB ---
Yâ A’zamü min külli ‘azîm
Yâ Ekramü min külli kerîm
Yâ Erhamü min külli rahîm
Yâ Ahkemü min külli hakîm
Yâ Aİemü min külli ‘alîm
Yâ Akdemü min külli kadîm
Yâ Ekberu min külli kebîr
Yâ Ecellü min külli celîl
Yâ E’azzü min külli ‘azîz
Yâ Eltafü min külli latîf
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 35. BAB ---
Yâ Men hüve fî ‘ahdihî vefiyy
Yâ Men hüve fî vefaihî kaviyy
Yâ Men hüve fî kuvvetihi ‘aliyy
Yâ Men hüve fî ‘ulüvvihî karîb
Yâ Men hüve fî kurbihî latîf
Yâ Men hüve fî lütfıhî şerîf
Yâ Men hüve fî şerefîhî ‘azîz
Yâ Men hüve fî ‘izzetihî ‘azîm
Yâ Men hüve fî ‘azametihî mecîd
Yâ Men hüve fî mecdihî hamîd
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 36. BAB ---
Yâ Men hüve küllü şey’in hâdiun leh
Yâ Men hüve küllü şey’in kâinün leh
Yâ Men hüve küllü şey’in mevcudun leh
Yâ Men hüve küllü şey’in münîbün leh
Yâ Men hüve küllü şey’in hâifün minh
Yâ Men hüve küllü şey’in müsebbihun leh
Yâ Men hüve küllü şey’in kâimün bih
Yâ Men hüve küllü şey’in hâşiün leh
Yâ Men hüve küllü şey’in sâirun ileyh
Yâ men hüve küllü şey’in hâlikün illâ vecheh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 37. BAB ---
Ve es’elüke biesmâike
Yâ Kâfi
Yâ Şâfî
Yâ Vâfî
Yâ Mu’âfî
Yâ ‘Âlî
Yâ Dâ’î
Yâ Râdî
Yâ Kâdî
Yâ Bakî
Yâ Hâdî
Sübhâneke yâ îâ ilahe illâ ente’l-emâ-ne’I-emâne ecirnâ mine’n-nâr.

--- 38. BAB ---
Yâ Men lâ meferra illâ ileyh
Yâ Men lâ mefze’a illâ ileyh
Yâ Men lâ melcee illâ ileyh
Yâ Men lâ yütevekkelü illâ ‘aleyh
Yâ Men lâ maksade illâ ileyh
Yâ Men lâ mencee illâ ileyh
Yâ Men lâ yürğabü illâ ileyh
Yâ Men lâ yü’bedü illâ iyyâh
Yâ Men lâ yüste’ânü illâ minh
Yâ Men lâ havle velâ kuvvete illâ bih
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 39. BAB ---
Yâ Hayra’l-merhûbîn
Yâ Hayra’l-matlûbîn
Yâ Hayra’l-merğûbîn
Yâ Hayra’l-mes’ûlîn
Yâ Hayra’l-maksûdîn
Yâ Hayra’l-mezkûrîn
Yâ Hayra’l-meşkûrîn
Yâ Hayra’l-mahbûbîn
Yâ Hayra’l-münzilîn
Yâ Hayra’l-müste’nisîn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 40. BAB ---
Yâ Men hüve halaka fesevvâ
Yâ Men hüve kaddera fehedâ
Yâ Men hüve yekşifü’l-belvâ
Yâ Men hüve yesme’u’n-necvâ
Yâ Men hüve yünkizü’l-garkâ
Yâ Men hüve yünci’l-helkâ
Yâ Men hüve yeşfi’l-merdâ
Yâ Men hüve emâte ve ahyâ
Yâ Men hüve edhake ve ebkâ
Yâ Men hüve edalle ve ehdâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 41. BAB ---
Ve es’elüke biesmâike
Yâ Ğâfır
Yâ Sâtir
Yâ Kahir
Yâ Kadir
Yâ Nazır
Yâ Fâtır
Yâ Şâkir
Yâ Zâkir
Yâ Nâsır
Yâ Câbir
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne`l-emâne ecirnâ mine’n-nâr.

--- 42. BAB ---
Yâ Men hüve fi’l-berri ve’l-bahri sebîlüh
Yâ Men hüve fi’l-âfaki âyâtüh
Yâ Men hüve fi’l-âyâti bürhânüh
Yâ Men hüve fı’l-memâti kudratüh
Yâ Men hüve fı’l-kubûri ‘izzetüh
Yâ Men hüve fı’l-kıyâmeti milketüh
Yâ Men hüve fı’l-hisâbi heybetüh
Yâ Men hüve fı’l-mîzâni kadâüh
Yâ Men hüve fi’l-cenneti rahmetüh
Yâ Men hüve fı’n-nâri ‘azâbüh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 43. BAB ---
Yâ Men hüve ileyhi yehrabü’l-hâifûn
Yâ Men hüve ileyhi yefze’u’l-müznibûn
Yâ Men hüve ileyhi yaksıdü’l-münîbûn
Yâ Men hüve ileyhi yelceü’l-‘âsûn
Yâ Men hüve ileyhi yerğabü’z-zâhidûn
Yâ Men hüve fîhi yatme’u’l-hâtıûn
Yâ Men hüve yeste’nisü bihi’l-mürîdûn
Yâ Men hüve yeftehiru bihi’l-muhsinûn
Yâ men hüve ‘aleyhi yetevekkelü’l-mütevekkilun
Yâ men hüve yeskünü bihi’l-mûkınûn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 44. BAB ---
Yâ Ekrabe min külli karîb
Yâ Ehabbe miri külli habîb
Yâ A’zame min külli ‘azîm
Yâ E’azze min külli ‘azîz
Yâ Ekvâ min külli kaviyy
Yâ Ağnâ min külli ğaniyy
Yâ Ecvede min külli cevâd
Yâ Er’efe min külli raûf
Yâ Erhame min külli rahîm
Yâ Ecelle min külli celîl
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 45. BAB ---
Ve es’elüke biesmâike
Karîb
Yâ Rakîb
Yâ Habîb
Yâ Mücîb
Yâ Hasîb
Yâ Tabîb
Yâ Basîr
Yâ Habîr
Yâ Münîr
Yâ Mübîn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 46. BAB ---
Yâ Ğâliben gayra mağlûb
Yâ Sâni’an gayra masnu’
Yâ Hâlikan gayra mahlûk
Yâ Mâliken gayra memlûk
Yâ Kâhiran gayra makhûr
Yâ Râfı’an gayra merfu’
Yâ Hafızan gayra mahfuz
Yâ Nâsiran gayra mensur
Yâ Sahiden gayra gâib
Yâ Karîben gayra ba’îd
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 47. BAB ---
Yâ Nûra’n-nûr
Yâ Münevvira’n-nûr
Yâ Müsavvira’n-nûr
Yâ Hâlika’n-nûr
Yâ Mükaddira’n-nûr
Yâ Müdebbira’n-nûr
Yâ Nûran kable külli nûr
Yâ Nûran ba’de külli nûr
Yâ Nûran fevka külli nûr
Yâ Nûran leyse mişlehû nûr
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 48. BAB ---
Yâ Men ‘atâuhû şerîf
Yâ Men fı’lühû latîf
Yâ Men lütfühû mükim
Yâ Men ihsânühû kadîm
Yâ Men kavlühü hakk
Yâ Men va’dühû sıdk
Yâ Men ‘afVühû fadl
Yâ Men ‘azabühû ‘adl
Yâ Men zikrühû hulv
Yâ men ünsühû leziz
Sübhâneke yâ lâ ilahe illâ ente’l-ne’l-emâne ecirnâ mine’n-nâr.

--- 49. BAB ---
Ve es’elüke biesmâike
Yâ Münevvil
Yâ Müfassü
YâMübeddil
Yâ Müsehhil
Yâ Müzellil
Yâ Münezzil
Yâ Muhavvil
Yâ Mücemmil
Yâ Mükemmil
Yâ Müfaddil
Sübhâneke yâ lâ ilahe illâ ente ne’l-emâne ecirnâ mine’n-nâr.

--- 50. BAB ---
Yâ Men yerâ velâ yürâ
Yâ Men yahlüku velâ yühlâk
Yâ Men yehdî velâ yühda
Yâ Men yühyî velâ yühyâ
Yâ Men yüt’imü velâ yüt’am
Yâ Men yücîru velâ yücâr
Yâ Men yakdî velâ yükdâ ‘aleyh
Yâ Men yahkümü velâ yuhkemü ‘aleyh
Yâ Men lem yelid velem yûled
Ve lem yekûn lehû küfüven ehad
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 51. BAB ---
Yâ Ni’me’l-habîb
Yâ Ni’me’t-tabîb
Yâ Ni’me’l-hasîb
Yâ Ni’me’l-karîb
Yâ Ni’me’r-rakîb
Yâ Ni’me’l-mucîb
Yâ Ni’me’l-enîs
Yâ Ni’me’l-vekîl
Yâ Ni’me’l-mevlâ
Yâ Ni’me’n-nasîr
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 52. BAB ---
Yâ Sürûra’l-‘ârifîn
Yâ Enîse’l-mürîdîn
Yâ Muğîşe’l-müştâkîn
Yâ Habîbe’t-tevvâbîn
Yâ Râzika’l-mükillîn
Yâ Recâe’l-müznibîn
Yâ Kâşife’l-mekrûbîn
Yâ Müneffisen ‘ani’l-mağmûmîn
Yâ Müferricen ‘ani’l-mahzûnîn
Yâ İlâhe’l-evvelîne ve’l-âhirîn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 53. BAB ---
Yâ Rabbe’l-cenneti ve’n-nâr
Yâ Rabbe’n-nebiyyîne ve’l-ahyâr
Yâ Rabbe’s-sıddîkîne ve’l-ebrâr
Yâ Rabbe’s-siğâri ve’l-kibâr
Yâ Rabbe’l-hubûbi ve’l-eşmâr
Yâ Rabbe’l-enhâri ve’l-eşcâr
Yâ Rabbe’s-sahârâ ve’l-kıfâr
Yâ Rabbe’l-‘abîdi ve’l-ahrâr
Yâ Rabbe’l-i’lâni ve’l-isrâr
Yâ Rabbe’l-leyli ve’n-nehâr
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 54. BAB ---
Yâ Men lahika fî külli şey’in ‘ilmüh
Yâ Men nefeze bi külli şey’in besaruh
Yâ Men beleğat ilâ külli şey’in kudratüh
Yâ Men lâ yuhsı’l-‘ibâdü na’mâeh
Yâ Men lâ teblüğu’l-halâiku şükrah
Yâ Men lâ tüdrikü’l-efhâmü celâleh
Yâ Men lâ tenâlü’l-evhâmü künheh
Yâ Meni’l-‘azâmetü ve’l-kibriyâü ridâüh
Yâ Meni’l-heybetü ve’s-sültânü behâüh
Yâ Men te’azzeze bi’l-‘izzi bekâüh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 55. BAB ---
Yâ Men lehü’l-meşelü’l-a’lâ
Yâ Men lehü’l-sıfâtü’l-‘ulâ
Yâ Men lehü’l-âhiratü ve’l-ûlâ
Yâ Men lehü’l-cennetü’l-me’vâ
Yâ Men lehü’n-nâru ve’l-lezâ
Yâ Men lehü’l-âyâtü’l-kübrâ
Yâ Men lehü’l-esmâü’l-hüsnâ
Yâ Men lehü’l-hükmü ve’l-kadâ
Yâ Men lehü’s-semâvâtü’l-‘ulâ
Yâ Men lehü’l-‘arşü ve’s-serâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 56. BAB ---
Ve es’elüke biesmâike
Yâ’Afüvv
Yâ Ğafûr
Yâ Vedûd
Yâ Şekûr
Yâ Sabûr
Yâ Rauf
Yâ’Atûf
Yâ Kuddûs
Yâ Hayy
Yâ Kayyûm
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 57. BAB ---
Yâ Men hüve fı’s-semâi ‘azametüh
Yâ Men hüve fi’l-ardi âyâtüh
Yâ Men hüve fî külli şey’in delâilüh
Yâ Men hüve fi’l-bihâri ‘acâibüh
Yâ Men yebdeü’l-halka şürame yü’îdüh
Yâ Men hüve fi’l-cibâli hazâinüh
Yâ Men ahsene külle şey’in halekah
Yâ Men ileyhi yürce’u’l-emrü küllüh
Yâ Men zahera fî külli şey’in lütfülı
Yâ Men yü’arrifü’l-halâika kudrateh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 58. BAB ---
Yâ Habîbe men lâ habîbe leh
Yâ Tabîbe men lâ tabîbe leh
Yâ Mücîbe men lâ mücîbe leh
Yâ Şefîka men lâ şefîka leh
Yâ Rafîka men lâ rafîka leh
Yâ Şefî’a men lâ §efî’a leh
Yâ Müğîşe men lâ müğîşe leh
Yâ Delîle men lâ delîle leh
Yâ Kaide men lâ kaide leh
Yâ Râhıme men lâ râhıme leh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 59. BAB ---
Yâ Kâfiye meni’stekfâh
Yâ Hâdiye meni’stehdâh
Yâ Kâliye meni’steklâh
Yâ Dâ’iye meni’sted’âh
Yâ Şâfıye meni’steşfâh
Yâ Kâdiye meni’stakdâh
Yâ Muğniye meni’steğnâh
Yâ Mûfîye meni’stevfâh
Yâ Mükavviye meni’stakvâh
Yâ Veliyye meni’stevlâh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 60. BAB ---
Ve es’elüke biesmâike
Yâ Evvel
Yâ Âhir
Yâ Zahir
Yâ Bâtın
Yâ Halik
Yâ Râzik
Yâ Sâdık
Yâ Sabık
Yâ Saik
Yâ Fâlik
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne ecirnâ mine’n-nâr.

--- 61. BAB ---
Yâ Men yükallibü’l-leyle ve’n-nehâr
Yâ Men Halaka’z-zulümâti ve’n-nûr
Yâ Men ce’ale’z-zılle ve’l-harur
Yâ Men sehhara’s-semse ve’l-kamer
Yâ Men haleka’l-mevte ve’l-hayah
Yâ Men lehü’l-halku ve’l-emr
Yâ Men lem yettehiz sâhibeten velâ veledâ
Yâ Men lem yekûn lehû şerikim fi’l-mülk
Yâ Men lem yekûn lehû veliyyün mine’z-züll
Yâ men lehü’l-havlü ve’l-kuvveh
Sübhâneke yâ lâ ilahe illâ enteİ-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 62. BAB ---
Yâ Men ya’lemü mürâde’l-mürîdîn
Yâ Men yemlikü havaice’s-sâilîn
Yâ Men yesme’u enîne’l-valihîn
Yâ Men yerâ bükâe’l-hâifîn
Yâ Men ya’lemu damîra’s-sâmitîn
Yâ Men yerâ nedeme’n-nâdimîn
Yâ Men yakbelü ‘uzre’t-tâibîn
Yâ Men lâ yüslihu ‘amele’l-müfsidîn
Yâ Men lâ yüdî’u ecra’l-muhsinîn
Yâ Men lâ yeb’udü an kulûbi’l-‘arifîn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 63. BAB ---
Yâ Dâime’l-bekâ
Yâ Ğafira’l-hatâ
Yâ Sâmi’e’d-düâ
Yâ Vâsi’a’l-‘atâ
Yâ Râfı’a’s-semâ
Yâ Kâşife’l-belâ
Yâ ‘Azîme’s-senâ
Yâ Kadîme’s-senâ
Yâ Keşira’l-vefa
Yâ Şerîfe’l-cezâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 64. BAB ---
Ve es’elüke biesmâike
Yâ Ğaffâr
Yâ Settâr
Yâ Kahhâr
Yâ Cebbar
Yâ Sabbâr
Yâ Razzâk
Yâ Fettâh
Yâ ‘Allâm
Yâ Vehhâb
Yâ Tevvâb
Sübhâneke yâ lâ ilahe illâ ente’l ne’l-emâne neccinâ mine’n-nâr.

--- 65. BAB ---
Yâ Men halekanî ve sevvânî
Yâ Men razekanî ve rabbânî
Yâ Men et’amenî ve sekânî
Yâ Men karrabenî ve ednânî
Yâ Men ‘asamenî ve kefânî
Yâ Men hafızanî ve kelânî
Yâ Men veffekanî ve hedânî
Yâ Men e’azzenî ve ağnânî
Yâ Men emâtenî ve ahyânî
Yâ Men ânesenî ve âvânî
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 66. BAB ---
Yâ Men yühikku’l-hakka bikelimâtih
Yâ Men lâ mü’akkibe lihukmih
Yâ Men lâ radde likadâih
Yâ Men yehûlü beyne’l-mer’i ve kalbih
Yâ Men yakbelü’t-tevbete an ‘ibâdih
Yâ Men lâ tenfe’u’ş-şefa’atü illâ biiznih
Yâ Meni’s-semâvâtü matviyyâtün biyemînih
Yâ Men hüve a’lemü bi men dalle ‘an sebîlih
Yâ Men yüsebbihu’r-ra’dü bihâmdi-hi ve’l-melâiketü min hîfetih
Yâ Men yürsilü’r-riyâha büşran beyne yedey rahmetih
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 67. BAB ---
Yâ Men ce’ale’l-arda mihâdâ
Yâ Men ce’ale’l-cibâle evtâdâ
Yâ Men ce’ale’l-şemse sirâcâ
Yâ Men ce’ale’l-kamera nûrâ
Yâ Men ce’ale’l-leyle libâsa
Yâ Men ce’ale’n-nehâra me’âşâ
Yâ Men ce’ale’n-nevme sübâtâ
Yâ Men ce’ale’s-semâe binâa
Yâ Men ce’ale’l-eşyâe ezvâcâ
Yâ Men ce’ale’n-nâra mirsâdâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 68. BAB ---
Ve es’elüke biesmâike
Yâ Şefî’
Yâ Semî’
Yâ Rafı’
Yâ Meni`
Yâ Bedi`
Yâ Serî’
Yâ Beşîr
Yâ Nezîr
Yâ Kadîr
Yâ Muktedir
Sübhâneke yâ lâ ilahe illâ ente’l-em ne’l-emâne neccinâ mine’n-nâr.

--- 69. BAB ---
Yâ Hayyü kable külli hayy
Yâ Hayyü ba’de külli hayy
Yâ Hayyü’llezî lâ yüşbihühû şey’
Yâ Hayyü’llezî leyse kemişlihî hayy ‘ Yâ Hayyü’llezî lâ yüşârikühû hayy
Yâ Hayyü’llezî lâ yahtâcü ilâ hayy
Yâ Hayyü’llezî yümîtü külle hayy
Yâ Hayyü’llezî yerzüku külle hayy
Yâ Hayyü’llezî yühyi’l-mevtâ
Yâ Hayyü’llezî lâ yemût
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 70. BAB ---
Yâ Men lehû zikrun lâ yünsâ
Yâ Men lehû nurun lâ yutfâ
Yâ Men lehû şenâün lâ yuhsâ
Yâ Men lehû nü’ûtün lâ tüğayyer
Yâ Men lehû ni’amün lâ tü’add
Yâ Men lehû mülkün lâ yezûl
Yâ Men lehû celâlün lâ yükeyyef
Yâ Men lehû kadâün lâ yüradd
Yâ Men lehû sıfâtün lâ tübeddel
Yâ Men lehû kemâlün lâ yüdrak
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 71. BAB ---
YâRabbe’I-‘âlemîn
Yâ Mâlike yevmi’d-dîn
Yâ Men yühibbü’s-sâbirîn
Yâ Men yuhibbü’t-tevvâbîn
Yâ Men yuhibbü’l-mütetahhirîn
Yâ Men yuhibbü’l-muhsinîn
Yâ Men hüve hayru’n-nâsirîn
Yâ Men hüve hayru’l-fasilîn
Yâ Men hüve hayru’ş-şâkirîn
Yâ men hüve a’lemü bi’l-müfsidîn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 72. BAB ---
Ve es’elüke biesmâike
Yâ Mübdi
Yâ Mu’îd
Yâ Hafız
Yâ Mühît
Yâ Hamîd
Yâ Mecîd
Yâ Mükît
Yâ Müğîs
Yâ Mü’îzz
Yâ Müzill
Sübhâneke yâ lâ ilahe illâ ente’l-e: ne’l-emâne neccinâ mine’n-nâr.

--- 73. BAB ---
Yâ Men hüve Ehadün bilâ didd
Yâ Men hüve Ferdün bilâ nidd
Yâ Men hüve Samedün bilâ ‘ayb
Yâ Men hüve Vitrun bilâ şef
Yâ Men hüve Rabbün bilâ vezîr
Yâ Men hüve Ğaniyyün bilâ fakr
Yâ Men hüve Sültânün bilâ ‘azl
Yâ Men hüve Melîkün bilâ ‘acz
Yâ Men hüve Mevcudun bilâ mişl
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 74. BAB ---
Yâ Men hüve zikruhû şerafün li’z-zâkirîn
Yâ Men hüve şükruhû fevzün li’ş-şâkirîn
Yâ Men hüve hamdühû fahrun li’l-hâmidîn
Yâ Men hüve tâ’atühû necâtün li’l-mütî’în
Yâ Men hüve bâbühü meftûhun li’t-tâlibîn
Yâ Men hüve sebilühû vâdihun li’l-mü’minîn
Yâ men hüve âyâtühû bürhânün Ii’n-nâzirîn
Yâ men hüve kitâbühû tezkiratün li’l-mûkınîn
Yâ men hüve ‘afvühü melceün li’l-müznibîn
Yâ men hüve rahmetühû karîbûn li’l-muhsinîn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 75. BAB ---
Yâ Men tebâreke’smüh
Yâ Men te’âlâ ceddüh
Yâ Men celle şenâüh
Yâ Men lâ ilahe ğayruh
Yâ Men tekaddeset esmâüh
Yâ Men yedûmü bekâüh
Yâ Meni’l-‘azametü behâüh
Yâ Meni’l-kibriyâü ndâüh
Yâ Men lâ yühsâ âlâüh
Yâ Men lâ yü’addü na’mâüh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 76. BAB ---
Ve es’elüke biesmâike
Yâ Mü’în
Yâ Mübîn
Yâ Emîn
Yâ Mekîn
Yâ Metîn
Yâ Şedîd
Yâ Şehîd
Yâ Raşîd
Yâ Hamîd
Yâ Mecîd
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-neİ-emâne neccinâ mine’n-nâr.

--- 77. BAB ---
Yâ Ze’l-arşi’l-mecîd
Yâ Ze’l-kavli’s-sedîd
Yâ Ze’l-fadli’r-raşîd
Yâ Ze’l-batşi’ş-şedîd
Yâ Ze’l-va’di ve’l-va’îd
Yâ Karîben gayra ba’îd
Yâ Men hüve’l-veliyyü’l-hamîd
Yâ Men hüve ‘alâ külli şey’in şehîd
Yâ Men hüve leyse bizallâmîn li’l-‘abîd
Yâ men hüve akrabü ileyhi min habli’l-verîd
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 78. BAB ---
Yâ Men lâ şerîke lehû velâ vezîr
Yâ Men lâ şebîhe lehû velâ nezîr
Yâ Hâlika’ş-şemsi ve’l-kameri’l-münîr
Yâ Müğniye’l-bâisi’l-fakîr   Yâ Râzika’t-tıfli’s-sağîr
Yâ Râhime’ş-şeyhi’l-kebir
Yâ ‘Ismete’l-hâifi’l-müstecîr
Yâ Men hüve bi’ibâdihî basîr
Yâ Men hüve bihavâyici’l-‘ibâdi habîr
Yâ Men hüve ‘alâ külli şey’in kadîr
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 79. BAB ---
Yâ Ze’l-cûdi ve’n-ni’âm
Yâ Ze’l-fadli ve’l-keram
Yâ Ze’l-be’si ve’n-nikam
Yâ Hâlika’l-levhi ve’l-kalem ‘ Yâ Bârie’z-zerri ve’n-nesem
Yâ Mülhime’l-‘arabi ve’l-‘acem   Yâ Kâşife’drdurri ve’l-elem
Yâ ‘Alime’s-sirri ve’l-himem
Yâ Men lehü’l-beytü ve’l-haram
Yâ Men yahlüku’l-eşyâe mine’l-‘adem
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 80. BAB ---
Ve es’elüke biesmâike
Yâ ‘Adil
Yâ Kabil
Yâ Fâdil
YâFâ’il
Yâ Kâfıl
Yâ Câ’il
Yâ Kâmil
Yâ Fâtır
Yâ Tâlib
Yâ Matlûb
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 81. BAB ---
Yâ Men en’ame bihavlih
Yâ Men ekrame bitavlih
Yâ Men ‘âde bilütfıh
Yâ Men te’azzeze bikudratih   Yâ Men kaddera bihikmetih
Yâ Men hakeme bitedbîrih
Yâ Men debbera bi’ilmih
Yâ Men tecâveze bihılmih
Yâ Men denâ fî ‘ulüvvih
Yâ Men ‘alâ fî dünüvvih
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 82. BAB ---
Yâ Men yahlüku ma yeşâ 2Yâ Men yef’alü ma yeşâ
Yâ Men yehdi men yeşâ
Yâ Men yudillü men yeşâ
Yâ Men yağfiru limen yeşâ
Yâ Men yü’azzibü men yeşâ
Ya Men yetûbü alâ men yeşâ
Yâ Men yüsavviru fı’l-erhâmi keyfe yeşâ
Yâ Men yezîdü fi’l-halki mâ yeşâ
Yâ Men yahtassu bi rahmetihî men yeşâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 83. BAB ---
Yâ Men lem yettehiz sahibeten velâ veledâ
Yâ Men la yüşrikü fî hukmihî ehadâ
Yâ Men ce’ale li külli şey’in kadrâ
Yâ Men lem yezel rahîmâ
Yâ Câ’ile’l-melâiketi rusülâ
Yâ Men ce’ale fı’s-semâi bürûcâ
Yâ Men ce’ale’l-arda karâra
Yâ Men ce’ale mine’l-mâi beşerâ
Yâ Men ahsa külle şey’in ‘adedâ
Yâ Men ehâta bi külli şey’in ‘ilmâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 84. BAB ---
Ve es’elüke biesmâike
Yâ Ferd
Yâ Vitr
Yâ Ehad
Yâ Samed
Yâ Emced
Yâ E’azz
Yâ Eceli
Yâ Ehakk
Yâ Eberr
Yâ Ebed
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-nel-emâne neccinâ mine’n-nâr.

--- 85. BAB ---
Yâ Ma’rûfe men ‘arafeh
Yâ Ma’bûde men ‘abedeh
Yâ Meşkûre men şekerah
Yâ Mezkûre men zekerah
Yâ Mahmude men hamideh
Yâ Mevcûde men talebeh
Yâ Mevsûfe men vahhadeh
Yâ Mahbûbe men ehabbeh
Yâ Merğûbe men erâdeh
Yâ Maksûde men enâbe ileyh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 86. BAB ---
Yâ Men lâ mülke illâ mülküh
Yâ Men lâ yuhsi’l-‘ibadü şenaeh
Yâ Men lâ tesıfü’l-halâiku celâleh
Yâ Men lâ yüdrikü’l-ebsâru kemâleh
Yâ Men lâ yeblüğu’l-efhâmü sıfâtih
Yâ Men lâ yenâlü’l-efkâru kibriyâeh
Yâ Men lâ yuhsinü’l-insânü nü’ûteh
Yâ Men lâ yeruddü’l-‘ibâdü kadâeh
Yâ Men zahera fî külli şey’in âyâtüh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 87. BAB ---
Yâ Habîbe’l-bekkâîn
Yâ Senede’l-mütevekkilîn
Yâ Hâdiye’l-mudillîn
Yâ Veliyye’l-mü’minîn
Yâ Enîse’s-zâkirîn
Yâ Akdera’l-kâdirîn
Yâ Ebsara’n-nâzırîn
Yâ Aleme’l-‘âlimîn
Yâ Mefze’a’l-melhûfîn
Yâ Ensara’n-nâsirîn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr

--- 88. BAB ---
Ve es’elüke biesmâike
Yâ Mükrim
Yâ Mü’azzim
Yâ Müna’im
Ya Mü’tî
Yâ Müğnî
Yâ Mühyî
Yâ Mübdî
Yâ Mürdî
YâMüncî
Yâ Muhsin
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr

--- 89. BAB ---
Yâ Kâfiye külli şey
Yâ Kaimen ‘alâ külli şey
Yâ Men lâ yüşbihühû şey
Yâ Men lâ yezîdü fî mülkihî şey
Yâ Men lâ yenkusu min hazainihî şey
Yâ Men lâ yahfâ ‘aleyhi şey
Yâ Men leyse kemişlihî şey
Yâ Men biyedihî mekâlîdü külli şey
Yâ Men vesi’at rahmetühû külle şey
Yâ Men yebkâ ve yefnâ küllü şey
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 90. BAB ---
Yâ Men lâ ya’lemü’l-ğaybe illâ hû
Yâ Men lâ yasrifü’s-sûe illâ hû
Yâ Men lâ yüdebbiru’l-emra illâ hû
Yâ Men lâ yağfiru’z-zünûbe illâ hû
Yâ Men lâ yükallibü’l-kalbe illâ hû
Yâ Men lâ yahlüku’l-halka illâ hû
Yâ Men lâ yütimmü’n-ni’mete illâ hû
Yâ Men lâ yünezzilü’l-ğayşe illâ hû
Yâ Men lâ yuhyi’l-mevtâ illâ hû
Yâ Men lâ yuğni ‘ale’t-tahkîki illâ hû
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne neccinâ mine’n-nâr.

--- 91. BAB ---
Ve es’elüke biesmâike
Yâ Kâşif
Yâ Fâric
Yâ Fâtih
Yâ Nâsir
Yâ Dâmin
Yâ Âmir
Yâ Nâhi
Yâ Raca
Yâ Mürtecâ
Yâ ‘Azîme’r-racâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 92. BAB ---
Yâ Mü’îne’d-du’afâ
Yâ Kenze’l-fükarâ
Yâ Sâhibe’l-ğurabâ
Yâ Nâsira’l-evliyâ
Yâ Kâhira’l-a’dâ
Yâ Râfia’s-semâ
Yâ Kâşife’l-belâ
Yâ Enîse’l-evliyâ
Yâ Habîbe’l-etkıyâ
Yâ İlâhe’l-ağniyâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 93. BAB ---
Yâ Evvele külli şey’in ve âhirah
Yâ İlahe külli şey’in ve sâni’ah
Yâ Râzika külli şey’in ve hâlikah
Yâ Fâtira külli şey’in ve melîkeh
Yâ Kâbida külli şey’in ve bâsiteh
Yâ Mübdie külli şey’in ve nıü’îdeh
Yâ Müsebbibe külli şey’in ve mükaddirah s Yâ Mürabbiye külli şey’in ve müdebbirah
Yâ Mükevvira külli şey’in ve muhavvileh
Yâ Muhyiye külli şey’in ve mümîteh
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 94. BAB ---
Yâ Hayra zâkirîn ve mezkûr
Yâ Hayra şâkirîn ve meşkûr
Yâ Hayra hâmidin ve mahmûd
Yâ Hayra şahidin ve meşhûd
Yâ Hayra dâ’in ve med’uvv
Yâ Hayra mücîbin ve mücâb
Yâ Hayra munisin ve enîs
Yâ Hayra sahibin ve celîs
Yâ Hayra maksûdin ve matlûb
Yâ Hayra habîbin ve mahbûb
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 95. BAB ---
Yâ Men hüve limen de’âhü mücîb
Yâ Men hüve limen etâ’ahû habîb
Yâ Men hüve limen ehabbehû karîb
Yâ Men hüve bimen erâdehû ‘alîm
Yâ Men hüve limen recâhü kerîm
Yâ Men hüve bimen ‘asâhü halîm
Yâ Men hüve fî hilmihî hakîm
Yâ Men hüve fî hükmihî ‘azîm
Yâ Men hüve fî ‘azametihî rahîm
Yâ Men hüve fî ihsânihî kadîm
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 96. BAB ---
Ve es’elüke biesmâike
Yâ Müsebbib
Yâ Mukarrib
Yâ Mü’akkib
Yâ Mukallib
Yâ Mukaddir
Yâ Mürattib
Yâ Mürağğib
Yâ Müzekkir
Yâ Mükevvîn
Yâ Mütekebbir
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 97. BAB ---
Yâ Men lâ yüşğilühû sem’un an sem’
Yâ Men lâ yemne’uhû fı’lün an fi’l
Yâ Men lâ yülhîhi kavlün an kavi
Yâ Men lâ yüğallituhû süâlün ‘an suâl
Yâ Men lâ yübrimühû ilhâhu’Umulihhîn
Yâ Men şeraha bi’l-islâmi sudûra’l-mü’minîn
Yâ Men etâbe bi zikrihî kulûbe’l-muhbitîn
Yâ Men la yeğibü ‘an kulûbi’l-müştâkın
Yâ Men hüve gâyetü mürâdi’l-mürîdîn
Yâ Men la yahfâ ‘aleyhi şey’ün fı’l-‘âlemîn
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 98. BAB ---
Yâ Men hüve ‘ilmühû sabık
Yâ Men hüve va’dühû sâdık
Yâ Men hüve lütfühû zahir
Yâ Men hüve emruhû ğâlib
Yâ Men hüve kitâbühû muhkem
Yâ Men hüve kadâühû kâin
Yâ Men hüve kur’anühû mecîd
Yâ Men hüve mülkühû kadîm
Yâ Men hüve fadlühû mukîm
Yâ Men hüve ‘arşühû ‘azîm
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 99. BAB ---
Yâ Rabbe’l-erbâb
Yâ Müfettiha’l-ebvâb
Yâ Müsebbibe’l-esbâb
Yâ Mu’tiye’s sevâb
Yâ Mülhime’s-savâb
Yâ Münşie’s-sehâb
Yâ Şedîde’l-‘ikâb
Yâ Seri’a’l-hisâb
Yâ Men lehü’l-iyâb
Yâ Gafuru yâ Tevvâb
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- 100. BAB ---
Ve es’elüke biesmâike
Yâ Rabbena
Yâ İlâhenâ
Yâ Seyyidenâ
Yâ Mevlânâ
Yâ Nâsıranâ
Yâ Hafızana
Yâ Kâdiranâ
Yâ Râzikanâ
Yâ Delîlenâ
Yâ Muğisenâ
Sübhâneke yâ lâ ilahe illâ ente’l-emâ-ne’l-emâne hallisnâ mine’n-nâr.

--- MÜNACAT (Dua Sonu) ---
Allahümme Rabbena hallisna ve ecirna ve neccina minen-nar.Ve afina va’fu anna ve edhil-nel Cennete dare kudsike meal-ebrar.Bi-afvike ya Mücir, bi-fadlike ya Gaffar.Ve es’elüke bi-hakkı hazihil-esmail-kerimetiş-şerifeti ves-sıfatil-celiletil-latifeti en-tusalli ala-seyyidina Muhammedin ve ala-alihi ve sahbihi bi-adedi hasenati Muhammedin.bismillah, hasbiyallah, la ilahe illallah, şehidallah, kul-hüvallah, maşaallah, Rabbiyallah, tebarekallah, tealallah, tevekkeltü alallah, fese-yekfikehümullah, ve hüves-semiul-alim.Sübhaneke ya la ilahe illa entel-emanül-eman la uhsi senaen aleyke ente kema esneyte ala nefsik ya Allah, ya Rahman, ya Rahim, ya Gafur, ya Şekur.es’elüke bima ahsaytehu aleyke min-esmaikel-hüsna ve sıfatikel-ulya ve kelimatiket-tammeti en tağfire li ve li-valideyye ve li-cemiil-mü’minine vel mü’minati vel-müslimine vel-müslimati el-ahyai minhüm vel-emvat.Ve terhamena rahmeten tuğnina biha an rahmeti men sivake min-halkike.ve en takdiye havayicena ve tu’tiyena sualena fid-dünya vel ahireti ve tahtime lena bis-seadeti veş-şehadeti vel-kerameti vel-büşra inde firakid-dünya.ve tecziye Muhammeden sallallahü aleyhi ve sellem anna ma hüve ehlühü ve müstahakkuh. Ve en la tekilena ala-enfüsina tarfete aynin vela ila-ehadin-min-halkik.Ve tusliha lena şe’nena ve en tahrusena bi-aynikelleti la tenamu ve tahfezana bi-rüknikellezi la yüramu ya zelcelali vel-ikram. Ve en tasrife anna ve ammen ullika aleyhi hazihil-esmau afetel-cinni vel-insi veş-şeyatin ve zelzeletel ardi ve dekdeketel-cibali min-haşyetih. Ve afetettauni vel-vebai ve aynes-sui ve veceal-cevarihi ve sairel-afat.Ve tahfezana min-külli şerrin ve suin.Ve terzukanas-selamete vel-afiyete vel hayra fid-dünya vel-ahireti bi-rahmetike ya erhamer-rahimin.Ve sallallahü ala-seyyidina Muhammedin ve alihi ve sahbihi ecmain.Velhamdü lillahi rabbil-alemin.''',
    mana:
        '''Cevşen-ül Kebîr, Hz. Peygamber (s.a.s.)'in: "Allah'ım! Senden, Cevşen hakkına ve yüceliğine ve göğe koyduğun isminin hakkı için Muhammed'e ve âl-i Muhammed'e salât etmeni istiyorum" diyerek başladığı ve savaşta zırh gibi koruyucu olduğu rivayet edilen büyük bir duadır. Yüz bölümden oluşur; her bölümde Allah'ın isim ve sıfatlarıyla niyaz edilir. Aşağıda duanın tamamı (yüz bölüm) Arapça metni, okunuşu ve Türkçe manasıyla birlikte sunulmaktadır. Sıkıntı, darlık ve musibet anlarında okunması tavsiye edilir.''',
    meal:
        '''--- 1. BAB ---
Rahman ve Rahîm olan Allah’ın adıyla
Allah’ım Senden şu isimlerinin hakkı için istiyor ve yalvarıyorum:
Ey her şeyin Gerçek Mâbudu olan Allah
Ey dünyada dost ve düşman ayırt etmeden bütün mahlûkatını rızıklandıran Rahman
Ey âhirette sadece dostlarına rahmet edecek olan Rahim
Ey herşeyi hakkıyla bilen Alîm
Ey yarattıklarına son derece yumuşak muamele eden Halîm
Ey sonsuz büyüklük ve yücelik sahibi olan Azîm
Ey herşeyi yerli yerinde yapan Hakîm
Ey varlığının başlangıcı olmayan Kadîm
Ey herşeyi ayakta tutan Mukîm
Ey iyilik ve ikramı bol olan Kerîm
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 2. BAB ---
Ey efendilerin efendisi
Ey dualara cevap veren
Ey iyiliklerin sahibi
Ey dereceleri yükselten
Ey bereketleri büyük olan
Ey hataları bağışlayan
Ey belaları def eden
Ey sesleri işiten
Ey dilekleri veren
Ey sır ve gizlilikleri bilen
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 3. BAB ---
Ey Bağışlayanların en hayırlısı
Ey yardım edenlerin en hayırlısı
Ey hükmedenlerin en hayırlısı
Ey herşeyi hikmetle açanların en hayırlısı
Ey kendisini zikredenlerin en hayırlısı
Ey varislerin en hayırlısı
Ey övenlerin en hayırlısı
Ey rızık verenlerin en hayırlısı
Ey müşkil meseleleri hal ve fasl edenlerin en hayırlısı
Ey ihsan edenlerin en hayırlısı
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 4. BAB ---
Ey izzet ve güzelliğin gerçek sahibi
Ey saltanat ve celalin gerçek sahibi
Ey kudret ve kemalin gerçek sahibi
Ey büyük ve yüce olan
Ey kudret ve azabı şiddetli olan
Ey ikâbı, cezası şiddetli olan
Ey hesabı süratli gören
Ey katında güzel ve mükâfatı bulunan
Ey katında Ümmü’l-Kitap(Ana kitap) bulunan
Ey yüklü bulutları yoktan var eden
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 5. BAB ---
Ey sonsuz merhamet sahibi olan Hannân
Ey hakiki iyilik ve ihsan sahibi Mennân
Ey kullarının hiçbir amelini zayi etmeden karşılığı veren Deyyân
Ey bağışlaması bol olan Gufran
Ey kullarına yol gösteren Burhân
Ey gerçek saltanat sahibi Sultân
Ey bütün kusur ve noksan sıfatlardan münezzeh olan Subhân
Ey kendisinden yardım istenen Müsteân
Ey nimet ve beyan sahibi
Ey emnü eman sahibi
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 6. BAB ---
Ey azametine herşeyin boyun eğdiği
Ey kudretine her şeyin teslim olduğu
Ey izzetine karşı her şeyin zelîl olduğu
Ey heybetine her şeyin itaat ettiği
Ey Saltanatına karşı her şeyin inkıyad ettiği
Ey korkusundan her şeyin kendisine boyun eğdiği
Ey korkusundan dağların yarıldığı ve parçalandığı
Ey emriyle göklerin ayakta durduğu
Ey izniyle yerin karar kıldığı
Ey memleketinin ahalisine zulmetmeyen
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 7. BAB ---
Ey hataları mağfiret eden
Ey belaları kaldıran
Ey ümitler Kendisinde son bulan
Ey ihsanı bol veren
Ey hediyeleri geniş olan
Ey mahlûkata rızık veren
Ey ölümlere karar veren
Ey şikâyetleri işiten
Ey askerleri gönderen
Ey esirleri salıveren
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 8. BAB ---
Ey hamd ve senâ sahibi
Ey şeref ve yücelik sahibi
Ey iftihar ve güzellik sahibi
Ey ahd ve vefâ sahibi
Ey af ve rızâ sahibi
Ey iyilik ve bağış sahibi
Ey kesin söz ve hüküm sahibi
Ey izzet ve sonsuzluk sahibi
Ey cömertlik ve nimetler sahibi
Ey karşılıksız iyilik ve nimetler sahibi
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 9. BAB ---
Ey olmamasını istediği meydana gelmesine engel olan Mânî
Ey zararlı şeyleri ve manileri defeden Dâfi
Ey faydalı şeyleri yapan Nâfî
Ey bütün sesleri işiten Sâmi’
Ey dilediklerinin mertebesini yükselten Râfî
Ey herşeyi san’atla yapan Sânî
Ey kullarına şefaat eden Şâfî
Ey istediğini istediği şekilde toplayan Câmî
Ey ilim ve ihsanı herşeyi içine alan Vâsî
Ey istediği şeyi istediği şekilde genişletip bollaştıran Mûsî
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 10. BAB ---
Ey bütün sanatların sanatkârı
Ey bütün mahsulâtların yaratıcısı
Ey bütün rızıklananların rızık vericisi
Ey bütün sahip olunanların sahibi
Ey bütün sıkıntıya düşenlerin ferahlatıcısı
Ey bütün üzüntüye düşenlerin sevindiricisi
Ey bütün merhamet olunanların merhamet edicisi
Ey bütün yardımcısız kalanların yardımcısı
Ey bütün ayıplıların ayıbını örten
Ey bütün zulme uğrayanların sığınağı
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 11. BAB ---
Ey sıkıntım anında hazırlığım
Ey musibetim anında ümidim
Ey yalnızlığım anında arkadaşım
Ey gurbetliğimde dostum
Ey nimetlendiğim anda sahibim,
Ey kederim anında ferahlatıcım
Ey ihtiyacım anında yardımıma koşan,
Ey zor durumumda sığınağım,
Ey korkum anında yardımcım,
Ey şaşkınlığım anında yol göstericim,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 12. BAB ---
Ey gaybları bilen,
Ey günahları bağışlayan,
Ey ayıpları örten,
Ey sıkıntıları kaldıran,
Ey kalpleri değiştiren,
Ey kalpleri süsleyen,
Ey kalpleri nurlandıran,
Ey kalplerin tabibi,
Ey kalplerin sevgilisi,
Ey kalplerin dostu,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 13. BAB ---
Ey yücelik ve ululuk sahibi Celil
Ey gerçek güzellik sahibi Cemil,
Ey kendine güvenen kullarının işini en iyi yoluna koyan Vekil,
Ey kullarının takatını aşan işlerini üzerine alan Kefil,
Ey kullarına yol gösteren Delil,
Ey kullarının hata ve yanlışlarını bağışlayan Mukil,
Ey her şeyden haberdar olan Habir,
Ey lütuf u keremi bol olan Latif,
Ey sonsuz izzet sahibi Aziz,
Ey bütün mevcudatın gerçek sahibi ve hükümdarı olan Melik,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 14. BAB ---
Ey şaşkınların yol göstericisi,
Ey yardım isteyenlerin yardımcısı,
Ey medet isteyenlerin imdat edicisi,
Ey korunmak isteyenlerin koruyucusu,
Ey asilerin sığınağı,
Ey günahkârların bağışlayıcısı,
Ey korkanlara emniyet veren,
Ey miskinlere merhamet eden,
Ey yalnızlık duyanların dostu,
Ey darda kalanların dualarına cevap veren,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 15. BAB ---
Ey cömertlik ve ihsan sahibi,
Ey fazl ve iyilik sahibi,
Ey emniyet ve eman sahibi,
Ey kudsiyet (mukaddeslik) ve kemâlât (pâklık) sahibi
Ey hikmet ve beyan sahibi
Ey rahmet ve rıdvan (rıza) sahibi,
Ey kesin delil ve bürhan sahibi,
Ey azamet (büyüklük) ve saltanat sahibi,
Ey af ve mağfiret sahibi,
Ey kendisinden yardım istenen şefkat sahibi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 16. BAB ---
Ey her şeyin rabbi,
Ey her şeyin ilâhı,
Ey her şeyin yaratıcısı,
Ey her şeyin üzerinde olan,
Ey her şeyden önce olan,
Ey her şeyden sonra olan
Ey her şeyi bilen,
Ey her şeye gücü yeten
Ey her şeyin sanatkârı olan
Ey her şey fenâ bulup, Kendisi bâkî kalan
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 17. BAB ---
Ey kalplerde iman nurunu yakan ve kullarına huzur ve güven veren Mü’min
Ey bütün varlıkları ilim ve kontrolü altında tutan Müheymin,
Ey bütün mahlûkatı yoktan meydana getiren Mükevvin,
Ey bütün yaratıklarına dünyadaki vazifelerini öğretip telkin eden Mülakkin,
Ey kulları için açıklanması gereken her şeyi beyan eden Mübeyyin,
Ey musibetleri hafifleten ve zorlukları kolaylaştıran Mühevvin,
Ey her şeyi münasip şekilde süsleyen Müzeyyin,
Ey dilediğini yücelten ve kullarına büyüklüğünü gösteren Muazzim,
Ey muhtaçların yardımına koşan Muavvin,
Ey her şeyi çeşit çeşit renklerle bezeyen Mülevvin,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 18. BAB ---
Ey mülkünde daim olan,
Ey celalinde azim olan,
Ey saltanatında kadim (ezelî) olan,
Ey kullarına rahmet eden,
Ey her şeyi bilen,
Ey emirlerine uymayana halim olan,
Ey kendisine ümit bağlayana kerim olan,
Ey ölçülerinde hikmetli olan,
Ey hükmünde lütuf sahibi olan,
Ey lütfunda kadir olan
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 19. BAB ---
Ey fazlından başka bir şey ümit edilmeyen,
Ey adâletinden başka bir şeyden korkulmayan,
Ey iyiliğinden başka birşey beklenmeyen,
Ey affından başka bir şey istenmeyen,
Ey mülkünden başkası devam etmeyen,
Ey saltanatından başka saltanat bulunmayan,
Ey delilinden başka delil ve rehber bulunmayan,
Ey rahmeti her şeyi kuşatmış olan,
Ey rahmeti gazabını geçmiş olan,
Ey ilmiyle her şeyi kuşatmış olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 20. BAB ---
Ey tasayı kaldıran,
Ey gamı gideren,
Ey günahı affeden,
Ey tevbeyi kabul eden,
Ey yaratılmışların yaratıcısı,
Ey vaadinde sadık olan,
Ey yavrulara rızık veren,
Ey sözünü yerine getiren,
Ey gizliyi bilen,
Ey tohumu yarıp sümbüllendiren,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 21. BAB ---
Ey her şeyiyle yüce olan Ålî,
Ey sözünde vefalı olan ve vaadinden dönmeyen Vefî,
Ey müminlerin dostu olan Velî,
Ey gerçek zenginlik sahibi ve hiçbir şeye muhtaç olmayan Ganî,
Ey sonsuz servet ve tükenmez hazineler sahibi Melî,
Ey her cihetten temiz ve pak olan Zekî,
Ey kendisine kulluk edenlerden hoşnut olan Radî,
Ey eser ve ihsanlarıyla varlığı apaçık görünen Bedî,
Ey şiddet-i zuhurundan gizlenen Hafî,
Ey güç ve kuvveti sonsuz olan Kavî,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 22. BAB ---
Ey güzeli açığa çıkaran,
Ey çirkinin üzerini örten,
Ey suç sebebiyle hemen azarlamayan,
Ey ayıpların üzerindeki perdeyi yırtmayan,
Ey affı büyük olan,
Ey günahkârları cezalandırmaktan vazgeçmesi güzel olan,
Ey mağfireti geniş olan,
Ey rahmeti bol veren,
Ey bütün sessiz yalvarışların sahibi,
Ey bütün şikâyetler kendisinde son bulan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 23. BAB ---
Ey bol nimet sahibi,
Ey geniş rahmet sahibi,
Ey tam hikmet sahibi,
Ey kâmil kudret sahibi,
Ey kesin hüccet sahibi,
Ey açık ikram sahibi,
Ey yüce sıfat sahibi,
Ey daim izzet sahibi,
Ey metin kuvvet sahibi,
Ey geçmiş minnet sahibi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 24. BAB ---
Ey hükmedenlerin en hükmedicisi,
Ey âdillerin en adaletlisi,
Ey doğruların en doğrusu,
Ey varlığı açık olanların en açığı,
Ey temiz olanların en temizi,
Ey yaratıcılık mertebelerinin en güzelinde olan,
Ey hesaba çekenlerin en süratlisi,
Ey işitenlerin en iyi işiticisi,
Ey ikram edenlerin en iyi ikram edicisi,
Ey merhamet edenlerin en merhametlisi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 25. BAB ---
Ey semaları yoktan yaratan,
Ey karanlıkları meydana getiren,
Ey gizlilikleri bilen,
Ey için için üzülenlere acıyan,
Ey utanılacak şeyleri örten,
Ey belaları defeden,
Ey ölüleri dirilten,
Ey sevapları kat kat yazan,
Ey bereketleri indiren,
Ey cezaları şiddetli olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 26. BAB ---
Ey her varlığa münasip şekil giydiren Musavvir,
Ey her şeyin plan ve programını ölçülü yapan Mukaddir,
Ey her şeyi maddi ve manevi kirlerden temizleyen Mutahhir,
Ey nuruyla her şeyi nurlandıran Münevvir,
Ey dilediğini öne geçiren Mukaddim,
Ey istediğini arkaya bırakan Muahhir,
Ey hayırlı işleri kolaylaştıran Müyessir,
Ey kullarını azabıyla korkutan, uyaran Münzir,
Ey kullarını Cennet ve diğer mükâfatlarla müjdeleyen Mübeşşir,
Ey bütün kâinatı tam bir nizam içinde idare eden Müdebbir,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 27. BAB ---
Ey Beyt’ül-Haramın (Kâbe’nin) Rabbi,
Ey haram ayların sahibi,
Ey Mescidü’l Haramın Rabbi,
Ey haram belde olan Mekke’nin Rabbi,
Ey Rükn-u Hacerü’l-Esved ve Makam-ı İbrahim’in Rabbi,
Ey Meş’arü’l Haramın Rabbi,
Ey helal ve haramın Rabbi,
Ey nur ve karanlığın Rabbi,
Ey tahiyyat ve selamın Rabbi,
Ey celal ve ikramın Rabbi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 28. BAB ---
Ey desteği olmayanların desteği,
Ey dayanağı olmayanların dayanağı,
Ey övünülecek bir şeyi olmayanların övüncü,
Ey imdat’a koşacak kimsesi olmayanların imdadı,
Ey korunacak yeri olmayanların koruyucusu,
Ey iftihar edecek kimsesi olmayanların iftiharı,
Ey izzeti olmayanların izzeti,
Ey yardımcısı olmayanların yardımcısı,
Ey dostu olmayanların dostu,
Ey zenginliği olmayanların zenginliği,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 29. BAB ---
Ey varlığında başkasına muhtaç olmayan Kâim,
Ey varlığının sonu olmayan Dâim,
Ey mahlûkatına merhamet eden Râhim,
Ey mevcudatına hükmeden Hâkim,
Ey her şeyi bilen Âlim,
Ey yarattıklarını koruyan Âsım,
Ey her şeyi adaletle taksim eden Kâsım,
Ey ayıp ve kusur kendisine ârız olmayan Sâlim,
Ey istediğinin maddi ve manevi rızkını daraltan Kâbıd,
Ey istediğinin maddi ve manevi rızkını genişleten Bâsıt,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 30. BAB ---
Ey kendisine sığınmak isteyenleri koruyan,
Ey kendisinden merhamet isteyenlere merhamet eden,
Ey kendisinden yardım isteyenlere yardım eden,
Ey korunmak isteyenleri muhafaza eden,
Ey kendisinden ikram isteyenlere ikram eden,
Ey kendisinden irşad edilmeyi isteyenleri irşad eden,
Ey kendisinden inayet isteyenlere inayet eden,
Ey kendisinden imdat isteyenlere imdat eden,
Ey feryat edenlerin feryadına koşan,
Ey kendisinden mağfiret isteyenleri bağışlayan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 31. BAB ---
Ey affı bol olan
Ey iyiliği büyük olan,
Ey hayrı çok olan
Ey fazlı köklü olan,
Ey sanatı güzel olan,
Ey lütfu daim olan,
Ey sıkıntıyı gideren,
Ey zararı kaldıran
Ey mülkün sahibi,
Ey hak ile hükmeden,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 32. BAB ---
Ey mağlup edilmeyen Azîz,
Ey kendisinden uzaklaşılmayan Latîf,
Ey uyumayan gözetleyici,
Ey yok olmayan Mevcûd,
Ey ölmeyen Hayy,
Ey yok olmayan Melik,
Ey fena bulmayan Bâkî,
Ey cehalet arız olmayan Âlim,
Ey taama muhtaç olmayan Samed,
Ey zaafa uğratılmayan Kavî,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 33. BAB ---
Ey isimlerinde, sıfatlarında ve fiillerinde ortağı olmayan Vâhid,
Ey istediğini bulan Vâcid,
Ey her yerde hazır ve nazir olan Şâhid,
Ey sonsuz şan ve yücelik sahibi Mâcid,
Ey bütün işlerini ezeli hikmetine göre neticeye ulaştıran Râşid,
Ey peygamberler gönderen ve ölüleri dirilten Bâis,
Ey bütün mülk ve servetlerin hakiki sahibi Vâris,
Ey hikmeti gereği elem ve zarar verici şeyleri yaratan Darr,
Ey hayır ve menfaatli şeyleri yaratan Nâfi,
Ey kullarına hidayet veren Hâdi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 34. BAB ---
Ey mağlup edilemeyen, bütün azimlerden daha Azîm,
Ey bütün cömertlerden daha Kerîm,
Ey bütün merhametlilerden daha Rahîm,
Ey bütün hikmet sahiplerinden daha Hakîm,
Ey bütün âlimlerden daha Alîm,
Ey bütün zamanları aşan Kadîm,
Ey bütün büyüklerden daha büyük,
Ey bütün yücelerden daha Celîl,
Ey bütün izzet sahiplerinden daha Azîz,
Ey bütün lütuf sahiplerinden daha Latîf,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 35. BAB ---
Ey sözünü yerine getiren, ahdinde vefalı,
Ey sözünü yerine getirirken acze düşmeyen, vefasında kuvvetli,
Ey kuvvetinde yüce,
Ey yüceliğiyle beraber çok yakın olan,
Ey yakınlığıyla beraber latif olan,
Ey lütfunda şeref sahibi olan şerif,
Ey şerefinde izzet sahibi olan aziz,
Ey izzetinde büyük olan azim,
Ey azametinde, büyüklüğünde ikram sahibi mecîd,
Ey yüceliğinde övülen Hamid,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 36. BAB ---
Ey her şeyin kendisine boyun eğdiği,
Ey her şey kendisi için var olan,
Ey her şey kendisi için mevcut olan,
Ey her şeyin kendisine döndüğü,
Ey her şeyin kendisinden korktuğu,
Ey her şeyin kendisini tesbih ettiği,
Ey her şey onunla ayakta olan,
Ey her şeyin kendisine itaat ettiği,
Ey her şeyin kendisine yöneldiği,
Ey ona bakan yüzü müstesna her şeyin helak olduğu,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 37. BAB ---
Ey kullarına yeten Kâfi,
Ey her türlü derde deva veren Şâfî,
Ey vaadinde duran Vâfî,
Ey maddi ve manevi dertlere afiyet veren Muâfî,
Ey her şeyiyle yüce olan Âlî,
Ey kullarını iyiliğe ve Cennete davet eden Dâî,
Ey iyi kullarından hoşnut olan Râdî,
Ey hikmet ve adaletle hükmeden Kâdî,
Ey varlığının sonu olmayan Bâki,
Ey dilediğini doğru yola ulaştıran Hâdi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 38. BAB ---
Ey kendisinden başka kaçacak yer olmayan,
Ey kendisinden başka sığınılacak yer olmayan,
Ey kendisinden başka iltica edilecek yer olmayan,
Ey kendisinden başka tevekkül edilecek kimse olmayan,
Ey kendisinden başka maksud, gaye olmayan,
Ey kendisinden başka kurtuluş yeri olmayan,
Ey kendisinden başkasına rağbet edilmeyen,
Ey kendisinden başkasına ibadet edilmeyen,
Ey kendisinden başkasından yardım istenilmeyen,
Ey kendisinden başka güç ve kuvvet sahibi bulunmayan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 39. BAB ---
Ey kendisine kaçılanların en hayırlısı,
Ey matlubların en hayırlısı,
Ey rağbet edilenlerin en hayırlısı,
Ey kendisinden dilekte bulunulanların en hayırlısı,
Ey maksud olanların en hayırlısı,
Ey zikredilenlerin en hayırlısı,
Ey şükredilenlerin en hayırlısı,
Ey sevilenlerin en hayırlısı,
Ey indirenlerin en hayırlısı,
Ey kendisine ünsiyet edilenlerin en hayırlısı,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 40. BAB ---
Ey yaratıp düzene koyan,
Ey takdir edip hedefe götüren,
Ey belayı kaldıran,
Ey gizli yakarışı işiten,
Ey batmışı kurtaran,
Ey helak olana necat veren,
Ey hastaya şifa veren,
Ey öldüren ve dirilten,
Ey güldüren ve ağlatan,
Ey saptıran ve hidayete erdiren,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 41. BAB ---
Ey dilediği kullarının günahlarını bağışlayan Ğâfir,
Ey ayıp ve kusurları örten Sâtir,
Ey düşmanlarını mağlup eden Kâhir,
Ey her şeye gücü yeten Kâdir,
Ey bütün mahlûkatının hallerini gören Nâzır,
Ey bütün mahlûkatı yoktan var eden Fâtır,
Ey kendisine yapılan ibadet ve şükürlere bol mükafat veren Şâkir,
Ey kendisini zikredenleri yâd eden Zâkir,
Ey dostlarına yardım eden Nâsır,
Ey dilediğini zorla yaptıran Câbir,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 42. BAB ---
Ey karada ve denizde yolu olan,
Ey dış âlemde âyetleri bulunan,
Ey âyetlerinde delili olan,
Ey ölümlerde kudreti tecelli eden,
Ey kabirlerde izzeti olan,
Ey kıyamette saltanatı olan,
Ey hesapta heybeti olan,
Ey mizanda hükmü olan,
Ey Cennette rahmeti olan,
Ey ateşte azabı olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 43. BAB ---
Ey korkanların kendisine kaçtığı,
Ey günahkârların kendisine sığındığı,
Ey tövbe edenlerin kendisine yöneldiği,
Ey asilerin kendisine iltica ettiği,
Ey zâhidlerin kendisine rağbet ettiği,
Ey hatalıların kendisinden ümit beslediği,
Ey kendisini arzulayanların onunla ünsiyet bulduğu,
Ey iyilik yapanların kendisiyle iftihar ettiği,
Ey tevekkül edenlerin kendisine güvendiği,
Ey kuvvetli iman edenlerin kendisiyle huzur bulduğu,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 44. BAB ---
Ey bütün yakınlardan daha yakın,
Ey bütün sevilenlerden daha sevgili,
Ey bütün büyüklerden daha büyük,
Ey bütün izzet sahiplerinden daha aziz,
Ey bütün kuvvetlilerden daha kuvvetli,
Ey bütün zenginlerden daha zengin,
Ey bütün cömertlerden daha cömert,
Ey bütün şefkatlilerden daha şefkatli,
Ey bütün merhametlilerden daha merhametli,
Ey bütün yücelerden daha yüce,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 45. BAB ---
Ey herşeye herşeyden daha yakın olan Karîb,
Ey bütün mahlûkatını gözetleyen Rakîb,
Ey müminlerin sevgilisi olan Habîb,
Ey kullarının dualarına cevap veren Mücîb,
Ey kullarının bütün fiillerinin hesabını gören Hasîb,
Ey bütün dertlere deva veren Tabîb,
Ey her şeyi bütün incelikleriyle gören Basîr,
Ey her şeyden haberdar olan Habîr,
Ey her şeyi nuruyla aydınlatan Münîr,
Ey kullarına gerekli her şeyi açıklayan Mübîn,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 46. BAB ---
Ey mağlup olmayan galib,
Ey yaratılmış olmayan sanatkâr,
Ey mahlûk olmayan yaratıcı,
Ey sahip olunamayan mülk sahibi,
Ey kendisine üstün gelinemeyen Kâhir,
Ey yükseltilmekten münezzeh yükseltici,
Ey korunmaya muhtaç olmayan koruyucu,
Ey yardıma ihtiyacı olmayan Yardım Edici,
Ey kaybolmayan hazır ve Şâhid,
Ey uzak olmayan yakın,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 47. BAB ---
Ey nurların nuru,
Ey nurları nurlandıran,
Ey nurlara suret ve şekil veren,
Ey nurları yaratan,
Ey nurları takdir eden,
Ey nurları idare eden,
Ey bütün nurlardan evvel olan nur,
Ey bütün nurlardan sonra da var olan nur,
Ey bütün nurların üstünde olan nur,
Ey hiçbir nurun kendisine benzemediği nur,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 48. BAB ---
Ey bağış ve ihsanı şerefli olan,
Ey fiili latif ve ince olan,
Ey lütfu daimî olan,
Ey ihsanı ezelî olan,
Ey sözü hak olan,
Ey vaadi doğru olan,
Ey affı fazla olan,
Ey azabı adalet olan,
Ey zikri tatlı olan,
Ey dostluğu lezzetli olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 49. BAB ---
Ey kullarına nimet ihsan eden Münevvil,
Ey bütün müşkilleri halleden ve hak ile batılın arasını ayıran Mufassil,
Ey istediğini istediği şekilde değiştiren Mübeddil,
Ey zorlukları kolaylaştıran Müsehhil,
Ey istediğini zelil kılan ve mahlûkatına boyun eğdiren Müzellil,
Ey kitaplar ve bereketler indiren dilediğinin rütbesini alçaltan Münezzil,
Ey kâinatta bütün işleri döndüren ve kullarını halden hale sevkeden Mühavvil,
Ey her şeyi münasip şekilde güzelleştiren Mücemmil,
Ey her şeyi kemale erdiren Mükemmil,
Ey istediğini istediğine üstün kılan Müfaddil,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 50. BAB ---
Ey her şeyi gören fakat kendisi görülmeyen,
Ey her şeyi yaratan fakat kendisi yaratılmayan,
Ey her şeye yol gösteren fakat kendisi yol gösterilmeye muhtaç olmayan,
Ey hayat veren fakat kendisi hayat verilmeye muhtaç olmayan,
Ey her şeyi doyuran fakat kendisi doyurulmaktan münezzeh olan,
Ey her şeyi koruyan fakat kendisi korunmaya muhtaç olmayan,
Ey her şey hakkında karar veren fakat kendisi hakkında hüküm verilmeyen,
Ey hüküm veren fakat kendisi aleyhinde hüküm verilmeyen,
Ey doğurmayan ve doğmayan,
Ey hiçbir şey kendisine denk olmayan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 51. BAB ---
Ey en güzel Sevgili,
Ey en güzel Tabib,
Ey en güzel Hesap Gören,
Ey en güzel Yakin,
Ey en güzel Gözetleyici,
Ey en güzel Cevap veren,
Ey en güzel Dost,
Ey en güzel Vekil,
Ey en güzel Efendi,
Ey en güzel Yardımcı,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 52. BAB ---
Ey kendisini tanıyanların sevinci,
Ey kendisini arzulayanların dostu,
Ey kendisine müştak olanların imdadına koşan,
Ey tövbekârların sevgilisi,
Ey ihtiyaç sahiplerine rızık veren,
Ey günahkârların ümidi,
Ey sıkıntıda olanların ferahlatıcısı,
Ey gamlılara nefes aldıran,
Ey mahzunlara kurtuluş yolu gösteren,
Ey evvel ve âhirlerin ilâhı,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 53. BAB ---
Ey Cennet ve Cehennemin Rabbi,
Ey Peygamberlerin ve hayırlıların Rabbi
Ey Sıddıkların ve iyilerin Rabbi,
Ey küçüklerin ve büyüklerin Rabbi,
Ey danelerin ve meyvelerin Rabbi,
Ey nehirlerin ve ağaçların Rabbi,
Ey sahraların ve çöllerin Rabbi,
Ey kölelerin ve hürlerin Rabbi,
Ey açığa çıkan ve gizlemelerin Rabbi,
Ey gece ve gündüzün Rabbi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 54. BAB ---
Ey ilmi her şeye ulaşan,
Ey görmesi her şeye nüfuz eden,
Ey kudreti her şeye kavuşan,
Ey nimetleri sayılamayan,
Ey mahlûkatın gerçek şükrüne erişemediği,
Ey zihinlerin yüceliğini idrak edemediği,
Ey hayallerin hakikatına erişemediği,
Ey azamet ve kibriya örtüsü olan,
Ey heybet ve saltanat güzelliği olan,
Ey bekası izzetle izzetlenen,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 55. BAB ---
Ey en yüce misaller Kendisine âit olan,
Ey en yüce sıfatlar Kendisine âit olan,
Ey ahiret ve dünya Kendisine âit olan,
Ey Cennetü’l Me’vânın sahibi,
Ey Cehennem ve ateşin sahibi,
Ey en büyük ayetler sahibi,
Ey en güzel isimler sahibi,
Ey hüküm ve kaza sahibi,
Ey yüce göklerin sahibi,
Ey arş ve yerin sahibi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 56. BAB ---
Ey kullarını çok çok affeden Afüvv,
Ey kullarının günahlarını bağışlayan Ğafûr,
Ey itaatkâr kullarını çok seven Vedûd,
Ey rızası için yapılan işleri bol sevapla karşılayan Şekûr,
Ey asileri hemen cezalandırmayıp çok sabreden Sabûr,
Ey kullarına çok şefkat edip esirgeyen Raûf,
Ey kullarına karşı pek merhametli olan Atûf,
Ey bütün mahlûkatı maddi ve manevi kirlerden arındıran Kuddûs,
Ey gerçek hayat sahibi olan Hayy,
Ey gökleri yeri ve bütün mahlûkatı yerinde tutan Kayyûm,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 57. BAB ---
Ey semâda (gökte) azameti görülen,
Ey yerde âyetleri ve mu’cizeleri tecelli eden,
Ey her şeyde delilleri bulunan,
Ey denizde acâip sanatları bulunan,
Ey mahlûkatı ilk defa yaratıp, öldükten sonra tekrar dirilten,
Ey dağlarda hazineleri bulunan,
Ey yarattığı her şeyi en güzel yapan,
Ey bütün işler kendisine dönen,
Ey her şeyde lütfu açıkça görünen,
Ey mahlûkatına kudretini tanıtan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 58. BAB ---
Ey sevgilisi olmayanların sevgilisi,
Ey tabibi olmayanların tabibi,
Ey isteklerini dinleyip cevap verecek kimsesi olmayanların Mucîbî,
Ey şefkat edecek kimsesi olmayanların şefkat edicisi,
Ey arkadaşı olmayanların arkadaşı,
Ey şefaat edecek kimsesi olmayanların şefaatçisi,
Ey imdâdına koşacak kimsesi olmayanların imdat edicisi,
Ey yol gösterecek kimsesi olmayanların yol göstericisi,
Ey rehberi olmayanların rehberi,
Ey merhamet edecek kimsesi olmayanların merhamet edicisi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 59. BAB ---
Ey Kendisini her şeye bedel yeter görenlerin Kâfisi,
Ey Kendisinden hidâyet isteyenlerin hidâyet edicisi,
Ey gizlenecek yer arayanların üstünü örten,
Ey Kendisini çağıranları cennetine davet eden,
Ey Kendisinden şifa isteyenlere şifa veren,
Ey Kendisine hükmetmesini isteyenler hakkında hükmeden,
Ey maddi ve manevi zenginlik isteyenleri zenginleştiren,
Ey Kendisinden her ihtiyacını yerine getirilmesini isteyenlerin ihtiyaçlarına yeterli cevap veren,
Ey Kendisinden kuvvet ve güç isteyenlere kuvvet veren,
Ey Kendisinden dostluk ve sahiplik isteyenlerin dost ve sahibi,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 60. BAB ---
Ey her şeyden önce olan Evvel,
Ey her şeyden sonra olan Âhir,
Ey varlığı apaçık görünen Zâhir
Ey her şeyin içyüzünden haberdar olan Bâtın,
Ey her şeyi yoktan yaratan Hâlık,
Ey her şeyi münasip bir şekilde rızıklandıran Râzık,
Ey her işi doğru olan ve sözünü yerine getiren Sadık,
Ey varlığı her şeyden önce olan Sâbık,
Ey her şeyi mukadder hedefine sevk eden Sâik,
Ey tohum ve çekirdekleri yarıp sünbüllendiren Fâlık,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 61. BAB ---
Ey gece ve gündüzü peş peşe değiştiren,
Ey karanlıkları ve nuru yaratan,
Ey gölgeleri ve harareti meydana getiren,
Ey güneş ve ay’a boyun eğdiren,
Ey ölümü ve hayatı yaratan,
Ey yaratmak ve emretmek kendisine ait olan,
Ey eş ve evlat edinmeyen,
Ey mülkünde hiçbir şeriki olmayan,
Ey zilletten münezzeh olduğu için dosta ihtiyacı olmayan,
Ey havi kuvvet kendisine ait olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 62. BAB ---
Ey kendisini arzulayanların muradını bilen,
Ey kendisinden dilekte bulunanların ihtiyaç duyduklarına sahip olan,
Ey üzüntüsünden kendinden geçenlerin inlemelerini işiten,
Ey kendisinden korkarak ağlayanların ağlayışını gören,
Ey suskunların içinden geçenleri bilen,
Ey günahlarından pişmanlık duyanların nedametini gören,
Ey tövbekârların özrünü kabul eden,
Ey fesatçıların işini düzeltmeyen,
Ey iyilik yapanların mükâfatını zayi etmeyen,
Ey kendisini tanıyanların kalplerinden uzaklaşmayan
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 63. BAB ---
Ey bekası daim olan,
Ey hataları bağışlayan,
Ey duaları işiten,
Ey ihsanı geniş olan,
Ey gökleri yükselten,
Ey belaları defeden,
Ey medh ü senası büyük olan,
Ey varlığının parıltısı kadim olan,
Ey vefası çok olan,
Ey mükâfatı şerefli olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 64. BAB ---
Ey çok affeden Ğaffâr,
Ey bütün ayıpları örten Settâr,
Ey her şeye galip gelen ve bütün düşmanlarını kahreden Kahhâr,
Ey istediğini zorla yaptıran Cebbâr,
Ey çok sabreden ve kullarına sabır gücü veren Sabbâr,
Ey bütün rızka muhtaç olanları rızıklandıran Rezzâk,
Ey her şeyi hikmetle açan Fettâh,
Ey her şeyi çok iyi bilen Allâm,
Ey bol bol hediyeler veren Vehhâb,
Ey bütün tevbeleri kabul eden Tevvâb,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 65. BAB ---
Ey beni yaratıp azalarımı düzene koyan,
Ey bana rızık veren ve terbiye eden,
Ey beni yedirip içiren,
Ey beni kendisine yaklaştırıp yakın kılan,
Ey beni günah tehlikelerinden koruyup bana kâfi gelen,
Ey beni muhafaza edip ayıplarımı örten,
Ey bana tevfik edip hidayet eden,
Ey beni aziz kılıp ihtiyaçlarımı gideren,
Ey beni öldürüp dirilten,
Ey bana ünsiyet verip rızıklandıran,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 66. BAB ---
Ey kelimeleriyle hakkın hak olduğunu gösteren,
Ey hükmünü geri bıraktıracak kimse olmayan,
Ey kazasını geri çevirecek kimse olmayan,
Ey kişiye kalbinden daha yakın olan,
Ey kullarından tevbeyi kabul eden,
Ey izni olmadan hiçbir şefaat fayda vermeyen,
Ey bütün gökler kudretiyle dürülmüş olan,
Ey yolundan sapanların en iyi bilen,
Ey gök gürültüsünün hamd ederek, meleklerin de korkusuyla kendisini tesbih ettiği,
Ey rahmetinin önünde rüzgârları müjdeci gönderen,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 67. BAB ---
Ey yeri beşik yapan,
Ey dağları direk yapan,
Ey güneşi kandil kılan,
Ey ay’ı nur kılan,
Ey geceyi örtü yapan,
Ey gündüzü maişet zamanı yapan,
Ey uykuyu huzur ve sükûn vasıtası kılan,
Ey semayı bina kılan,
Ey eşyayı çift çift yaratan,
Ey ateşi gözcü kılan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 68. BAB ---
Ey gerçek şefaat sahibi Şefî,
Ey gizli açık her sesi işiten Semî,
Ey istediğini yükselten Rafî,
Ey istediğini engelleyen Menî,
Ey kâinatı en güzel bir şekilde yoktan yaratan Bedî,
Ey hesabı en süratli bir şekilde gören Serî,
Ey sevdiklerini Cennet ve çeşitli mükâfatlarla müjdeleyen Beşîr,
Ey kullarını itaate sevk etmek için azabıyla korkutan Nezîr,
Ey sonsuz kudret sahibi olan Kadîr,
Ey her şeye gücü yeten Muktedir.
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 69. BAB ---
Ey bütün dirilerden önce var olan gerçek hayat sahibi,
Ey bütün dirilerden sonra baki kalacak gerçek hayat sahibi,
Ey hiçbir şeyin kendisine benzemediği gerçek hayat sahibi,
Ey hiçbir dirinin misli gibi olmadığı gerçek hayat sahibi,
Ey hiçbir dirinin kendisine ortak olmadığı gerçek hayat sahibi,
Ey hiçbir diriye muhtaç olmayan gerçek hayat sahibi,
Ey bütün dirileri öldüren gerçek hayat sahibi,
Ey bütün dirileri rızıklandıran gerçek hayat sahibi,
Ey ölüleri dirilten gerçek hayat sahibi,
Ey hiç ölmeyecek olan gerçek hayat sahibi
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 70. BAB ---
Ey unutulmayan ve unutturulmayan zikrin sahibi,
Ey söndürülemeyen nurun sahibi,
Ey hadd ü hesaba gelmeyen medh ü senâ sahibi
Ey hiçbir şekilde değiştirilemeyen vasıflar sahibi,
Ey sayılamayan nimetler sahibi,
Ey zeval bulmayan saltanat sahibi,
Ey gerçek keyfiyeti anlaşılamayan celal sahibi,
Ey reddedilemeyen hüküm sahibi,
Ey tebdil edilemeyen sıfatlar sahibi,
Ey tam idrak edilemeyen kemal sahibi.
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 71. BAB ---
Ey âlemlerin Rabbi,
Ey amellerin karşılıklarının verildiği kıyamet gününün sahibi,
Ey sabredenleri seven,
Ey tevbe edenleri seven,
Ey maddi ve manevi kirlerden temizlenenleri seven,
Ey Allah’ı görür gibi ibadet edenleri ve iyilik yapanları seven,
Ey yardım edenlerin en hayırlısı,
Ey müşkil meseleleri halledip hükme bağlayanların en hayırlısı,
Ey iyi mallara bol karşılık verenlerin en hayırlısı,
Ey ifsat edenleri en iyi bilen,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 72. BAB ---
Ey mahlûkatı örneksiz ve yoktan yaratan Mübdi,
Ey mahlûkatı öldükten sonra yeniden dirilten Muîd,
Ey herşeyi muhafaza eden Hafîz,
Ey herşeyi ilim ve kudretiyle kuşatan Muhît,
Ey hamd ve senaya en çok layık olan ve çok övülen Hamîd,
Ey azamet, şeref ve hâkimiyeti sonsuz Mecîd,
Ey her türlü mahlûkata münasip rızık veren Mukît,
Ey darda kalan çaresizlerin imdadına kosan Mugîs,
Ey istediğine izzet veren ve şereflendiren Muizz,
Ey istediğini zelil kılan Müzill,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 73. BAB ---
Ey zıddı olmayan Ehad,
Ey dengi bulunmayan Ferd,
Ey kusur ve ihtiyaçtan münezzeh olan Samed,
Ey çifti bulunmayan Vitr,
Ey veziri bulunmayan Rab,
Ey fakirliği bulunmayan Gani,
Ey azledilemeyen Sultan,
Ey aczden münezzeh olan Melik,
Ey benzeri olmayan Mevcûd,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 74. BAB ---
Ey zikri Kendisine zikredenlere büyük şeref olan,
Ey şükrü Kendisine şükredenlere büyük kurtuluş olan,
Ey hamdi Kendisini övenlere büyük iftihar vesîlesi olan,
Ey tâati, Kendisine itaat edenlere necât olan,
Ey kapısı Kendisini arayanlara açık olan,
Ey yolu mü’minlere zâhir ve belli olan,
Ey âyetleri bakanlar ve ibret alanlar için kesin delil olan,
Ey kitabi kuvvetli iman sahipleri için öğüt olan,
Ey affı günahkârlar için sığınak olan,
Ey rahmeti Muhsinler için yakın olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 75. BAB ---
Ey ismi yüce ve mübarek olan,
Ey şan ve makamı yüksek olan,
Ey sena ve övgüsü büyük olan,
Ey kendisinden başka ilah olmayan,
Ey isimleri mukaddes olan,
Ey bekası devam eden,
Ey büyüklük, azamet, baha ve kadri olan,
Ey büyüklük ve kibriyâyı kendisine perde yapan,
Ey gizli nimetleri, ihsanları grup grup bile sayılamayacak kadar çok olan,
Ey ihsan ve nimeti hesap ve sayıya gelmeyen,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 76. BAB ---
Ey kullarına yardım eden Muîn,
Ey açıklanması gereken herşeyi beyan eden Mübîn,
Ey kullarına emniyet ve huzur veren Emîn,
Ey saltanatı muhkem, nüfuz ve iktidar sahibi Mekîn,
Ey hiçbir şey hükmünü sarsmayan ve kendisine güvenilen Metîn,
Ey azap ve ikabı şiddetli olan Şedîd,
Ey kullarının her yaptığını gören Şehîd,
Ey bütün islerini ezeli takdirine göre en güzel bir şekilde neticeye ulaştıran Raşîd,
Ey en çok övülen ve en çok övgüye layık olan Hamîd,
Ey sonsuz şeref sahibi Mecîd,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 77. BAB ---
Ey yüce arşın sahibi,
Ey dosdoğru sözün sahibi,
Ey yerli yerince yapılan fazl-ü kerem sahibi,
Ey kıskıvrak yakalayan şiddetli azap sahibi,
Ey vaad ve tehdit sahibi,
Ey uzak olmayan yakin,
Ey en fazla övgüye layık olan dost,
Ey herşeyi müşahedesi altında tutan,
Ey kullarına hiçbir şekilde zulmedici olmayan,
Ey kuluna şah damarından daha yakın olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 78. BAB ---
Ey hiçbir ortak ve veziri olmayan,
Ey hiçbir benzeri ve dengi olmayan,
Ey güneş ve nurlu ayı yaratan
Ey şiddetli sıkıntıya düşmüş fakirleri zenginleştiren,
Ey küçük yavrulara rızık veren,
Ey düşkün ihtiyarlara merhamet eden,
Ey korku içinde kurtuluş isteyenlerin sığınağı,
Ey kullarının her halini gören,
Ey kullarının ihtiyaçlarından haberdar olan,
Ey herşeye gücü yeten,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 79. BAB ---
Ey cömertlik ve nimetler sahibi,
Ey fazl ve kerem sahibi,
Ey şiddetli bela, intikam ve çetin azaplar sahibi,
Ey Levh-i Mahfuz ve Kalemi yaratan,
Ey zerreyi, hoş rüzgârları ve nefesleri yaratan,
Ey bütün kullarına ilhamda bulunan,
Ey zarar ve elemi gideren,
Ey gizli sır ve kaygıları bilen,
Ey Kâbe-i Muazzama ve Harem-i Şerifin sahibi,
Ey eşyayı yoktan yaratan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 80. BAB ---
Ey gerçek adalet sahibi Âdil,
Ey rızası için yapılan işleri kabul eden Kâbil,
Ey herşeyden üstün ve yüce olan Fâdıl,
Ey her işin hakiki yapıcısı olan Fâil,
Ey yaratıkların her işini üzerine alan Kâfil,
Ey herşeyi meydana getiren Câil,
Ey her bakımdan eksiksiz olan Kâmil,
Ey mahlûkatı yokluk karanlıklarından varlık nuruna çıkaran Fâtır,
Ey kulları için hayır murad eden ve onları dergâhına çağıran Tâlib,
Ey kullarını, rızasına ermek ve cemalini görmek için can attığı Matlûb,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 81. BAB ---
Ey güç ve havliyle nimet veren,
Ey geniş ve bol imkânlarıyla ikram eden,
Ey tekrar tekrar lütufta bulunan,
Ey kudretiyle her yerde izzetini gösteren,
Ey herşeyi hikmetiyle ölçüp biçen,
Ey tedbiriyle hükmeden,
Ey ilmiyle herşeyi idare eden,
Ey hilim ve yumuşaklığıyla kullarını cezalandırmaktan vazgeçen,
Ey yüceliğiyle beraber kullarına yakın olan,
Ey yakınlığında yüceliği tezahür eden,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 82. BAB ---
Ey dilediğini yaratan,
Ey dilediğini yapan,
Ey dilediğine hidayet eden,
Ey dilediğini saptıran,
Ey dilediğini bağışlayan,
Ey dilediğine azap eden,
Ey dilediğinin tevbesini kabul eden,
Ey anne rahimlerindeki yavruları dilediği gibi şekillendiren,
Ey yaratıklarında dilediği şeyi ziyâde kılan,
Ey rahmetini dilediğine tahsis eden,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 83. BAB ---
Ey hiçbir eş ve evlat edinmeyen,
Ey kimseyi hükmüne ortak kılmayan,
Ey herşeye bir plan ve miktar tayin eden,
Ey şefkat ve merhameti zeval bulmayıp devam eden,
Ey melekleri elçi kılan,
Ey semada burçlar meydana getiren,
Ey yeryüzünü kararlı ve barınmaya müsait kılan,
Ey insanı bir damla sudan yaratan,
Ey herşeyi sayarak hesabını yapan,
Ey herşeyi ilmiyle kuşatan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 84. BAB ---
Ey eşi ve benzeri olmayan Ferd,
Ey zat, sıfat ve fiillerinde çifti olmayan Vitr,
Ey her bir şeyde birliğini gösteren Ehad,
Ey hiçbir şeye muhtaç olmayan ve her şeyin kendisine muhtaç olduğu Samed,
Ey şan, şeref ve yüceliği en büyük olan Emced,
Ey izzet ve galibiyeti mukayeseye gelmeyen Eazz,
Ey sonsuz azamet, büyüklük ve celal sahibi Ecell,
Ey bütün gerçeklerden daha gerçek ve ibadete en çok layık olan Ehakk,
Ey herkesten en fazla iyilik yapan Eberr,
Ey varlığının sonu olmayan Ebed,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 85. BAB ---
Ey kendisini tanımak isteyenlerin marufu,
Ey kendisine ibadet edenlerin mabudu,
Ey kendisine şükredenlerin meşkûru,
Ey kendisini zikredenlerin, ananların mezkûru,
Ey kendisini övenlerin mahmudu,
Ey kendisini arayanlar için mevcut olan,
Ey kendisini bir tanıyanlara tanıtılmış olan mevsuf,
Ey kendisini sevenlerin sevgilisi,
Ey kendisini arzulayanların merğubu,
Ey dergâhına dönenlerin maksudu,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 86. BAB ---
Ey saltanatından başka gerçek saltanat olmayan,
Ey kulların senasını saymakla bitiremediği,
Ey mahlûkatın celalini vasfedemediği,
Ey künhünü ihatada idraklerin âciz kaldığı,
Ey gözlerin kemalini idrak ve ihata edemediği,
Ey zekâların, sıfatlarına ulaşmaktan aciz kaldığı,
Ey fikirlerin kibriyasının hakikatine ulaşamadığı,
Ey insanların, sıfatlarını güzelce tavsif edemediği,
Ey kulların, hükmünü geri çevirmediği,
Ey herşeyde kendisini tanıtan deliller açıkça görülen,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 87. BAB ---
Ey günahları için ve kendisine olan aşk ve muhabbetten dolayı ağlayanların sevgilisi,
Ey kendisine tevekkül edenlerin dayanağı,
Ey hak yoldan sapanları hidayete erdiren,
Ey müminlerin dost ve sahibi,
Ey kendisini zikredenlerin can yoldaşı,
Ey bütün güçlülerden daha güçlü,
Ey bütün bakanlardan daha iyi gören,
Ey bütün ilim sahiplerinden daha âlim,
Ey kederli biçarelerin kaçıp sığındığı,
Ey bütün yardım edenlerden daha çok yardım eden,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 88. BAB ---
Ey gerçek ikram sahibi Mükrim,
Ey dilediğini büyüten ve eserleriyle büyüklüğünü gösteren Muazzim,
Ey mahlûkatını çeşit çeşit nimetlere gark eden Müna’im,
Ey mahlûkatına lazım olan herşeyi veren Mu’ti,
Ey mahlûkatının ihtiyacını giderip zengin kılan Muğni,
Ey canlılara hayat veren Muhyi,
Ey mahlûkatı maddesiz ve örneksiz ilk defa yaratan Mübdi,
Ey mahlûkatını nimetleriyle hoşnut kılan Murzi,
Ey mahlûkatı her türlü tehlikeden kurtaran Münci,
Ey bol bol iyilikte bulunan Muhsin,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 89. BAB ---
Ey her şeye kâfi,
Ey her şeyi idare eden kâim,
Ey hiç birşey kendisine benzemeyen,
Ey mülkünde, iradesi dışında hiçbir şey artmayan,
Ey hazinelerinden hiçbir şey eksik olmayan,
Ey hiçbir şey kendisine gizli bulunmayan,
Ey misli ve benzeri hiçbir şey bulunmayan,
Ey her şeyin anahtarı elinde olan,
Ey rahmeti her şeyi kuşatan,
Ey her şey fani olduğu halde kendisi baki kalan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 90. BAB ---
Ey gaybı kendisinden başka kimse bilemeyen,
Ey kullarından kötülüğü kendisinden başka kimse defedemeyen,
Ey işleri kendisinden başka kimse idare edemeyen,
Ey günahları kendisinden başka kimse mağfiret edemeyen,
Ey kalbleri kendisinden başkası değiştiremeyen,
Ey mahlûkatı kendisinden başkası yaratamayan,
Ey nimetleri kendisinden başkası tamamlayamayan,
Ey yağmuru kendisinden başkası yağdıramayan,
Ey ölüleri kendisinden başkası diriltemeyen,
Ey kullarını kendisinden başkası gerçek zengin kılamayan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 91. BAB ---
Ey belaları kaldıran ve güzellikleri açığa çıkaran Kâşif,
Ey keder ve tasadan kurtarıp ferahlatan Fâric,
Ey her mevcuda münasip bir suret açan ve fetihler müyesser kılan Fâtih,
Ey kullarına yardım eden Nâsir,
Ey yaratıkların her türlü ihtiyacını üzerine alan Dâmin,
Ey her şeye fıtratının gayesini emreden Âmir,
Ey her türlü kötülükten sakındıran Nâhi,
Ey kullarının ümidi olan Recâ,
Ey kullarının ümit beslediği Mürtecâ,
Ey kendisine büyük ümitler beslenen Azîmü’r Recâ
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 92. BAB ---
Ey zayıfların yardımcısı,
Ey fakirlerin hazinesi,
Ey gariplerin sahibi,
Ey dostların yardımcısı,
Ey düşmanların kahredicisi,
Ey gökleri yükselten,
Ey belaları kaldıran,
Ey dostların can yoldaşı,
Ey takva sahiplerinin sevgilisi,
Ey zenginlerin ma’budu,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 93. BAB ---
Ey her şeyin evveli ve âhiri,
Ey her şeyin ilâhı ve sanatkârı,
Ey her şeyin râzıkı ve hâlıkı,
Ey her şeyin yaratıcısı ve sultanı,
Ey her şeyi daraltan ve genişleten,
Ey her şeyi ilk defa yaratan ve öldükten sonra tekrar iade eden,
Ey her şeye gerekli sebepleri yaratan ve bir ölçü takdir eden,
Ey her şeyi terbiye ve idare eden,
Ey her şeyi döndüren ve değiştiren,
Ey her şeyi dirilten ve öldüren,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 94. BAB ---
Ey yâd edenlerin ve yâd edilenlerin en hayırlısı,
Ey şükrü kabul edenlerin ve şükredilenlerin en hayırlısı,
Ey övenlerin ve övülenlerin en hayırlısı,
Ey görenlerin ve görülenlerin en hayırlısı,
Ey çağıranların ve çağrılanların en hayırlısı,
Ey cevap verenlerin ve cevap verilenlerin en hayırlısı,
Ey ünsiyet verenlerin ve kendisiyle ünsiyet edilenlerin en hayırlısı,
Ey bütün dostların ve meclis arkadaşlarının en hayırlısı,
Ey bütün maksud ve matlubların en hayırlısı,
Ey sevenlerin ve sevilenlerin en hayırlısı,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 95. BAB ---
Ey kendisini çağıranlara cevap veren,
Ey kendisine itaat edenleri seven,
Ey kendisini sevenlere yakın olan,
Ey kendisini arzulayanları çok iyi bilen,
Ey kendisine ümit besleyenlere iyilik eden,
Ey kendisine isyan edenlere yumuşak davranıp hemen cezalandırmayan,
Ey yumuşaklığında hikmetli davranan,
Ey hükmünde büyük olan,
Ey azametinde merhametli olan,
Ey ikram ve ihsanında kadim olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 96. BAB ---
Ey sebepleri takdir eden Müsebbib,
Ey itaatkâr kullarını kendisine yaklaştıran Mukarrib,
Ey eşyayı hikmetle peş peşe getiren Muakkıb,
Ey kullarının kalblerini halden hale değiştiren Mukallib,
Ey her şeye bir miktar tespit eden Mukaddir.
Ey her şeyi düzene koyan Mürettib,
Ey kullarını iyiliğe teşvik eden Murağğib.
Ey kullarına öğüt veren Müzekkir,
Ey mahlûkatı var eden Mükevvin,
Ey sonsuz büyüklük ve azamet sahibi Mütekebbir.
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 97. BAB ---
Ey bir işitme, kendisini diğer bir işitmeden alıkoymayan,
Ey kendisi için bir iş diğer bir işe mani olmayan,
Ey bir söz, kendisini diğer bir sözden oyalamayan,
Ey kullarının bir isteği diğerine cevap vermekte kendisini karışıklığa sevk etmeyen,
Ey ısrarla istekte bulunanların ısrarı kendisini usandırmayan,
Ey müminlerin kalplerini islamla genişleten,
Ey zikriyle mütevâzi ve huşu sahiplerinin kalplerini hoş eden,
Ey kendisine iştiyak duyanların kalblerinden kaybolmayan,
Ey kendisini arzulayanların son arzusu,
Ey âlemde hiçbir şey kendisine gizli olmayan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 98. BAB ---
Ey her şeyi var olmadan bilen,
Ey vaadi doğru olan,
Ey lütfu açık olan,
Ey emri üstün ve galip olan,
Ey kitabı ve kanunu sağlam olan,
Ey kaza ve hükmü var olan,
Ey Kur’anı yüce olan,
Ey saltanatı ve mülkü ebedî olan,
Ey fazl ü keremi dâim olan,
Ey Arşı büyük olan,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 99. BAB ---
Ey rablık iddia edenlerin ve bütün terbiyecilerin Rabbi,
Ey bütün kapıları açan,
Ey sebepler tasarrufunda bulunan,
Ey sevapları veren,
Ey doğruları ilham eden,
Ey bulutları yoktan yaratan,
Ey azab ve ikâbı şiddetli olan,
Ey hesabı sür’atli gören,
Ey dönüş kendisine olan,
Ey bağışlayan ve tövbeleri kabul eden,
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- 100. BAB ---
Ey Rabbimiz, terbiye edenimiz,
Ey İlâhımız,
Ey Seyyidimiz, efendimiz
Ey Mevlâmız, sahibimiz
Ey Yardımcımız,
Ey Koruyucumuz,
Ey Kadirimiz, güç ve kuvvet verenimiz
Ey Razıkımız, rızık verenimiz
Ey Delilimiz, yol göstericimiz
Ey Meded kârımız, sıkıntı ve felâketlerden kurtarıcımız
Sen bütün kusur ve noksan sıfatlardan münezzehsin,
Senden başka İlah yok ki bize imdat etsin.
Emân ver bize, emân diliyoruz. Bizi Cehennemden kurtar.

--- MÜNACAT (Dua Sonu) ---
Ey Allah’ım, ey Rabbimiz! Bizi Cehennem ateşinden halâs eyle, muhafaza et, necat ver!.Allah’ım, bize âfiyet ver, bizi affet, bizi iyilerle birlikte pâk ve temiz diyarın olan Cennete koy.Bunu sadece affınla yap, ey kullarını azaptan koruyan Mücîr! Fazıl ve kereminle olsun, ey bütün günahları bağışlayan Gafur! Ben, şu kıymetli ve şerefli isimlerinin, şu yüce ve lâtif sıfatlarının hakkı için istiyor ve yalvarıyorum ki, Efendimiz Muhammed Aleyhisselâtü Vesselâma, onun yaptığı iyilikler sayısınca salât ve selâm eyle! Allah’ın ismiyle. Allah bana kâfi. Allah’tan başka ilâh yok. Allah her şeye şahit. De ki; O Allah’tır. Allah’ın dilediği olur. Rabbim Allah’tır. Allah’ın şânı yücedir. Allah âlîdir. Allah’a tevekkül edip güvendim. Allah onlara karşı sana kâfidir. O her şeyi işiten ve bilendir.Bütün kusurlardan münezzehsin. Ey kendisinden başka ilah olmayan Allah’ım! Eman ver bize, eman diliyorum. Sana olan medih ve senâları sayıp dökemiyorum. Sen, Zâtını övdüğün gibisin. Ey bütün kemâl sıfatlarını taşıyan hakikî Ma’bud olan Allah! Ey bütün mahlûkata rızık verip merhamet eden Rahman! Ey ahirette sâlih kullarına lütuflarda bulunacak olan Rahîm! Ey bütün günahları bağışlayan Gafûr! Ey kullarının ibâdet ve şükürlerine bol mükâfatla karşılık veren Şekûr!Zâtın için saydığın güzel isimlerin, yüce sıfatların ve eksiksiz kelimelerin hakkı için Senden istiyor ve yalvarıyorum ki, beni, anne-babamı ve bütün erkek ve kadın mümin ve Müslümanlardan hayatta olan ve ölenleri bağışla! Bize öyle bir merhamette bulun ki, Senden başkasının merhametine ihtiyacımız kalmasın! Dünyada ve ahirette ihtiyaçlarımızı yerine getir ve dilediğimizi ihsan eyle! Dünyadan ayrılırken son nefesimizi saâdet, şehâdet, ikram ve müjdeyle vermemizi nasip eyle! Bizim adımıza Hazret-i Muhammed Aleyhissalâtü Vesselâmı lâyık ve müstahak olduğu şeylerle mükâfatlandır.Gözümüzü açıp kapayıncaya kadar bizi ne nefsimize, ne de yaratıklarından hiç birine havâle etme! İşlerimizi ıslah edip, yoluna koy! Bizi, hiç zâil olmayan ilim ve sıyânetinle himâye eyle! Ayrı yaşanamayan desteğinle bizleri muhâfaza eyle, ey Celâl ve İkram Sahibi! Bizden ve bu isimleri üzerinde taşıyan kimselerden cin, insan ve şeytanlardan gelecek âfetleri, yer sarsıntılarını ve Allah korkusundan meydana gelen dağ parçalanışlarını, tâun ve vebâ musîbetlerini, kem gözleri, vücut ağrılarını ve diğer felâketleri def eyle! Bizi bütün şer ve kötülüklerden muhâfaza et.Rahmetinle bize dünyada ve âhirette selâmet, âfiyet ve hayır nasip eyle, ey merhametlilerin en merhametlisi! Allah, Efendimiz Hazret-i Muhammed’e (a.s.m.), onun âl ve Ashâbına sallât ve selâm eylesin! Ezelden ebede her türlü hamd ve övgü, şükür ve minnet Âlemlerin Rabbi olan Allah’a mahsustur.''',
  ),
];
