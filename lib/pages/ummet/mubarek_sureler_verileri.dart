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

  const MubarekSureVerisi({
    required this.baslik,
    required this.baslikEn,
    required this.arapca,
    required this.okunus,
    required this.mana,
  });
}

const List<MubarekSureVerisi> mubarekSureler = [
  MubarekSureVerisi(
    baslik: 'Yâsîn Suresi',
    baslikEn: 'Surah Ya-Sin',
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
    mana: '''Mekke döneminde inmiştir. Seksen üç âyettir. Resmî nüshada 36. sırada olup Kuran\'ın yedinci büyük sûresidir. Hz. Peygamber (s.a.s.) "Her şeyin bir kalbi vardır; Kur\'ân\'ın kalbi de Yâsîn\'dir" buyurmuştur. Sûrede; Kur\'ân\'ın vahiy olduğu, Hz. Peygamber\'in hak peygamber olduğu, öldükten sonra dirilme ve hesap için herkesin Allah\'ın huzurunda toplanacağı, müminlerle kâfirlerin âkıbetleri ve Allah\'ın kudretinin delilleri anlatılır.''',
  ),
  MubarekSureVerisi(
    baslik: 'Mülk Suresi',
    baslikEn: 'Surah Al-Mulk',
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
    mana: '''Mekke döneminde inmiştir. Otuz âyettir. İlk kelimesi "Tebâreke" olduğu için "Tebâreke Suresi" diye de anılır. Hz. Peygamber (s.a.s.), her gece Mülk Suresi\'ni okuyanı kabir azabından koruduğunu, kıyamet günü onun için şefaatçi olacağını haber vermiştir. Yirmi beş ve yirmi yedi. âyetlerinde, ölümden sonra diriliş ve hesap günü inkârcıların sorguya çekileceği ifade edilir. Sûre, Allah\'ın mülkünün kudretini, ölüm ve hayatın yaratılış hikmetini, yaratılıştaki düzeni ve inkârcıların âkıbetini anlatır.''',
  ),
  MubarekSureVerisi(
    baslik: 'Mülk (Tebâreke) - Kısa',
    baslikEn: 'Al-Mulk (Key Verses)',
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
    mana: '''Mülk (Tebâreke) Suresi\'nin ilk âyetlerinin özeti. Bu sûre Allah\'ın mülkünün elinde olduğunu, O\'nun her şeye gücü yettiğini, ölümü ve hayatı imtihan için yarattığını anlatır. Yedi kat gökleri kusursuz ve kat kat yaratan O\'dur; göz, onlarda bir çatlaklık görmez. Kıyamet günü cehennemi inkâr edenleri koruyacak biri yoktur; onlar peygamberler geldiğinde yalanlayanlardandır.''',
  ),
  MubarekSureVerisi(
    baslik: 'İnşirâh Suresi',
    baslikEn: 'Surah Ash-Sharh',
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
    mana: '''Mekke döneminde inmiştir. Sekiz âyettir. "İnşirah" açılmak, genişlemek demektir. Sûrede, Hz. Peygamber\'in gönlünün ferahlatıldığı, yükünün hafifletildiği ve adının yüceltildiği bildirilir. "Muhakkak ki her zorlukla birlikte bir kolaylık vardır" âyeti, güçlüklerin ardından kolaylığın geleceğini müjdeler. Sıkıntı anlarında teselli kaynağı olan bir sûredir.''',
  ),
  MubarekSureVerisi(
    baslik: 'Kıyâmet Suresi',
    baslikEn: 'Surah Al-Qiyamah',
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
    mana: '''Mekke döneminde inmiştir. Kırk âyettir. "Kıyâmet" kalkış, diriliş demektir. Sûrede kıyamet gününün dehşeti, ölüm ânı, hesap ve diriliş anlatılır. Ayrıca insanın boşuna yaratılmadığı, nutfeden yaratılıp en güzel biçimde şekillendirildiği ve Allah\'ın ölüleri diriltmeye kadir olduğu bildirilir. Âhirete inanmayanlar uyarılır.''',
  ),
  MubarekSureVerisi(
    baslik: 'Fetih Suresi',
    baslikEn: 'Surah Al-Fath',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
إِنَّا فَتَحْنَا لَكَ فَتْحًا مُبِينًا
لِيَغْفِرَ لَكَ اللَّهُ مَا تَقَدَّمَ مِنْ ذَنْبِكَ وَمَا تَأَخَّرَ وَيُتِمَّ نِعْمَتَهُ عَلَيْكَ وَيَهْدِيَكَ صِرَاطًا مُسْتَقِيمًا
وَيَنْصُرَكَ اللَّهُ نَصْرًا عَزِيزًا
هُوَ الَّذِي أَنْزَلَ السَّكِينَةَ فِي قُلُوبِ الْمُؤْمِنِينَ لِيَزْدَادُوا إِيمَانًا مَعَ إِيمَانِهِمْ ۗ وَلِلَّهِ جُنُودُ السَّمَاوَاتِ وَالْأَرْضِ ۚ وَكَانَ اللَّهُ عَلِيمًا حَكِيمًا
لِيُدْخِلَ الْمُؤْمِنِينَ وَالْمُؤْمِنَاتِ جَنَّاتٍ تَجْرِي مِنْ تَحْتِهَا الْأَنْهَارُ خَالِدِينَ فِيهَا وَيُكَفِّرَ عَنْهُمْ سَيِّئَاتِهِمْ ۚ وَكَانَ ذَٰلِكَ عِنْدَ اللَّهِ فَوْزًا عَظِيمًا
وَيُعَذِّبَ الْمُنَافِقِينَ وَالْمُنَافِقَاتِ وَالْمُشْرِكِينَ وَالْمُشْرِكَاتِ الظَّانِّينَ بِاللَّهِ ظَنَّ السَّوْءِ ۚ عَلَيْهِمْ دَائِرَةُ السَّوْءِ ۖ وَغَضِبَ اللَّهُ عَلَيْهِمْ وَلَعَنَهُمْ وَأَعَدَّ لَهُمْ جَهَنَّمَ ۖ وَسَاءَتْ مَصِيرًا
وَلِلَّهِ جُنُودُ السَّمَاوَاتِ وَالْأَرْضِ ۚ وَكَانَ اللَّهُ عَزِيزًا حَكِيمًا
إِنَّا أَرْسَلْنَاكَ شَاهِدًا وَمُبَشِّرًا وَنَذِيرًا
لِتُؤْمِنُوا بِاللَّهِ وَرَسُولِهِ وَتُعَزِّرُوهُ وَتُوَقِّرُوهُ وَتُسَبِّحُوهُ بُكْرَةً وَأَصِيلًا
إِنَّ الَّذِينَ يُبَايِعُونَكَ إِنَّمَا يُبَايِعُونَ اللَّهَ ۖ يَدُ اللَّهِ فَوْقَ أَيْدِيهِمْ ۚ فَمَنْ نَكَثَ فَإِنَّمَا يَنْكُثُ عَلَىٰ نَفْسِهِ ۖ وَمَنْ أَوْفَىٰ بِمَا عَاهَدَ عَلَيْهُ اللَّهَ فَسَيُؤْتِيهِ أَجْرًا عَظِيمًا''',
    okunus: '''Bismillâhirrahmânirrahîm.
İnnâ fetehnâ leke fethan mübînâ.
Li-yağfira lekellâhü mâ tekaddeme min zenbike ve mâ teahhar, ve yütimme ni'metehû aleyke ve yehdieke sırâtan müstekîmâ.
Ve yensurakellâhü nasran azîzâ.
Hüvel-lezî enzeles-sekînete fî kulûbil-mü'minîne li-yezdâdû îmânen mea îmânihim, ve lillâhi cünûdüs-semâvâti vel-ard, ve kânellâhü alîmen hakîmâ.
Li-yüdhilel-mü'minîne vel-mü'minâti cennâtin tecrî min tahtihâl-enhâru hâlidîne fîhâ ve yükeffira anhüm seyyiâtihim, ve kâne zâlike indallâhi fevzen azîmâ.
Ve yüazzibel-münâfikîne vel-münâfikâti vel-müşrikîne vel-müşrikâtiz-zannîne billâhi zannes-sev', aleyhim dâiretüs-sev', ve ğadıballâhü aleyhim ve leanahüm ve eadde lehüm cehennem, ve sâet masîrâ.
Ve lillâhi cünûdüs-semâvâti vel-ard, ve kânellâhü azîzen hakîmâ.
İnnâ erselnâke şâhiden ve mübeşşiran ve nezîrâ.
Li-tü'minû billâhi ve rasûlihî ve tüazzirûhü ve tüvekkirûhü ve tüsebbihûhü bükraten ve asîlâ.
İnnel-lezîne yübâyiûneke innemâ yübâyiûnellâh, yedullâhi fevka eydîhim, fe men nekesa feinnemâ yenküsü alâ nefsih, ve men evfâ bimâ âhede aleyhullâhe fe seyü'tîhi ecran azîmâ.''',
    mana: '''Medine döneminde, Hudeybiye antlaşmasından sonra inmiştir. Yirmi dokuz âyettir. "Fetih" zafer, fetih demektir. Sûre, Hz. Peygamber\'e verilen apaçık fetih müjdesiyle başlar; zafere giden yolda Allah\'ın yardımını, sabrı, hoşgörüyü ve Hudeybiye antlaşmasının önemini anlatır. Müminlere cennet müjdesi verilir, münafıklarla müşrikler uyarılır. Bir âyetinde Allah\'a biat edenlerin gerçekte Allah\'a biat ettiği bildirilir.''',
  ),
  MubarekSureVerisi(
    baslik: 'Vâkı\'a Suresi',
    baslikEn: 'Surah Al-Waqiah',
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
    mana: '''Mekke döneminde inmiştir. Doksan altı âyettir. "Vâkı\'a" olacak, vuku bulacak şey demektir; kıyametin adlarından biridir. Sûrede kıyametin kopacağı, insanların üç gruba ayrılacağı anlatılır: Öne geçenler, sağdakiler ve soldakiler. Bunların âkıbetleriyle birlikte, Allah\'ın varlığının ve kudretinin delilleri, öldükten sonra dirilme ve hesap günü tasvir edilir. Her cuma okunması tavsiye edilir.''',
  ),
  MubarekSureVerisi(
    baslik: 'Cuma Suresi',
    baslikEn: 'Surah Al-Jumuah',
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
    mana: '''Medine döneminde inmiştir. On bir âyettir. "Cuma" günü, Cumartesi\'dir. Sûrede Allah\'ın kudreti, peygamber göndermenin hikmeti ve ümmî topluma peygamber gönderilmesi anlatılır. Dokuz ve onuncu âyetlerinde, Cuma günü namaza çağrıldığında alışverişin bırakılıp namaz için acele edilmesi, namaz bitince de yeryüzüne dağılıp Allah\'ın lütfundan istenmesi emredilir. Cuma günü bu sûreyi okumak faziletlidir.''',
  ),
  MubarekSureVerisi(
    baslik: 'Haşr Suresi (22-24. Âyetler)',
    baslikEn: 'Surah Al-Hashr (Verses 22-24)',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
هُوَ اللَّهُ الَّذِي لَا إِلَٰهَ إِلَّا هُوَ ۖ عَالِمُ الْغَيْبِ وَالشَّهَادَةِ ۖ هُوَ الرَّحْمَٰنُ الرَّحِيمُ
هُوَ اللَّهُ الَّذِي لَا إِلَٰهَ إِلَّا هُوَ الْمَلِكُ الْقُدُّوسُ السَّلَامُ الْمُؤْمِنُ الْمُهَيْمِنُ الْعَزِيزُ الْجَبَّارُ الْمُتَكَبِّرُ ۚ سُبْحَانَ اللَّهِ عَمَّا يُشْرِكُونَ
هُوَ اللَّهُ الْخَالِقُ الْبَارِئُ الْمُصَوِّرُ ۖ لَهُ الْأَسْمَاءُ الْحُسْنَىٰ ۚ يُسَبِّحُ لَهُ مَا فِي السَّمَاوَاتِ وَالْأَرْضِ ۖ وَهُوَ الْعَزِيزُ الْحَكِيمُ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Hüvallâhül-lezî lâ ilâhe illâ hüv, âlimül-ğaybi veş-şehâdeh, hüver-rahmânür-rahîm.
Hüvallâhül-lezî lâ ilâhe illâ hüvel-melikül-kuddûsüs-selâmül-mü'minül-müheyminül-azîzül-cebbârul-mütekebbir, sübhânallâhi ammâ yüşrikûn.
Hüvallâhül-hâlikul-bâriül-musavvir, lehül-esmâül-hüsnâ, yüsebbihu lehû mâ fis-semâvâti vel-ard, ve hüvel-azîzül-hakîm.''',
    mana: '''Haşr Suresi\'nin yirmi ikiden yirmi dörde kadar olan üç âyeti. Bu âyetler, Allah\'ın isimlerini ve sıfatlarını en güzel şekilde öğreten âyetlerdir: O, kendisinden başka ilâh olmayan, gaybı ve şahidi bilen, Rahmân ve Rahîm olan Allah\'tır. Melik, Kuddûs, Selâm, Mü\'min, Müheymin, Azîz, Cebbâr, Mütekebbir\'dir. O, yaratan, yoktan var eden, şekil veren Allah\'tır; en güzel isimler O\'nundur. Sabah ve akşam bu âyetleri okumak faziletlidir; içlerinde Allah\'ın Esmâ-i Hüsnâ\'sı (en güzel isimleri) toplanmıştır.''',
  ),
  MubarekSureVerisi(
    baslik: 'Duha Suresi',
    baslikEn: 'Surah Ad-Duha',
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
    mana: '''Mekke döneminde inmiştir. On bir âyettir. "Duha" kuşluk vaktidir. Sûre, Hz. Peygamber\'in vahiy gecikince üzülmesi üzerine inmiştir; Allah\'ın onu terk etmediğini, darılmadığını bildirir. Âhiretin dünyadan daha hayırlı olduğu, Allah\'ın onu yetimken barındırdığı, şaşkınken hidayet verdiği, yoksulken zengin ettiği hatırlatılır. Buna göre yetimi horlamamak, isteyeni azarlamamak ve Rabbin nimetini anlatmak emredilir. Üzüntü ve keder anlarında teselli kaynağıdır.''',
  ),
  MubarekSureVerisi(
    baslik: 'İsmi Azam Duası',
    baslikEn: 'Dua of the Greatest Name',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
اللَّهُمَّ إِنِّي أَسْأَلُكَ بِأَنَّ لَكَ الْحَمْدَ، لَا إِلَٰهَ إِلَّا أَنْتَ الْمَنَّانُ، بَدِيعُ السَّمَاوَاتِ وَالْأَرْضِ، يَا ذَا الْجَلَالِ وَالْإِكْرَامِ، يَا حَيُّ يَا قَيُّومُ، إِنِّي أَسْأَلُكَ بِأَنَّكَ أَنْتَ اللَّهُ الَّذِي لَا إِلَٰهَ إِلَّا أَنْتَ، الْوَاحِدُ الْأَحَدُ، الصَّمَدُ، الَّذِي لَمْ يَلِدْ وَلَمْ يُولَدْ، وَلَمْ يَكُنْ لَهُ كُفُوًا أَحَدٌ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Allâhümme innî es'elüke bi-enne lekel-hamd, lâ ilâhe illâ entel-mennân, bedîus-semâvâti vel-ard, yâ zel-celâli vel-ikrâm, yâ Hayyü yâ Kayyûm, innî es'elüke bi-enneke entellâhül-lezî lâ ilâhe illâ ent, el-vâhidül-ehad, es-samed, el-lezî lem yelid ve lem yûled, ve lem yekün lehû küfüven ehad.''',
    mana: '''İsmi Azam Duası, Allah\'ın en büyük ismiyle yapılan duadır. Bu duada; hamd\'in yalnız Allah\'a ait olduğu, O\'ndan başka ilâh olmadığı, O\'nun Mennân (lütufkâr), göklerin ve yerin yaratıcısı, Celâl ve İkram sahibi, Hayy (diri) ve Kayyûm (her şeyi ayakta tutan) olduğu, tek ve bir olan, Samed olan, doğurmayan ve doğurulmayan Allah olduğu dile getirilerek O\'ndan bağışlanma ve ihtiyaçların giderilmesi istenir. Bu duanın, Allah\'ın en büyük ismiyle edilen dualardan olduğu rivayet edilir.''',
  ),
  MubarekSureVerisi(
    baslik: 'Neml Suresi (30. Âyet)',
    baslikEn: 'Surah An-Naml (Verse 30)',
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
    mana: '''Neml Suresi\'nin 30. âyeti. Hz. Süleyman, hüdhüt kuşu aracılığıyla Sebe Melikesi Belkıs\'a bir mektup göndermiştir. Bu mektubun başı "Bismillâhirrahmânirrahîm" ile başlamakta ve "Bana karşı büyüklük taslamayın, teslim olmuş olarak bana gelin" diye devam etmektedir. Bu âyet, Bismillah\'ın ve tevazuyla Allah\'a teslim olmanın önemini öğretir; Hz. Süleyman\'ın üstünlük taslamadan Allah\'ın ismiyle davet etmesini gösterir.''',
  ),
  MubarekSureVerisi(
    baslik: 'Neml Suresi',
    baslikEn: 'Surah An-Naml',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
طس ۚ تِلْكَ آيَاتُ الْقُرْآنِ وَكِتَابٍ مُبِينٍ
هُدًى وَبُشْرَىٰ لِلْمُؤْمِنِينَ
الَّذِينَ يُقِيمُونَ الصَّلَاةَ وَيُؤْتُونَ الزَّكَاةَ وَهُمْ بِالْآخِرَةِ هُمْ يُوقِنُونَ
إِنَّ الَّذِينَ لَا يُؤْمِنُونَ بِالْآخِرَةِ زَيَّنَّا لَهُمْ أَعْمَالَهُمْ فَهُمْ يَعْمَهُونَ
أُولَٰئِكَ الَّذِينَ لَهُمْ سُوءُ الْعَذَابِ وَهُمْ فِي الْآخِرَةِ هُمُ الْأَخْسَرُونَ
وَإِنَّكَ لَتُلَقَّى الْقُرْآنَ مِنْ لَدُنْ حَكِيمٍ عَلِيمٍ
إِذْ قَالَ مُوسَىٰ لِأَهْلِهِ إِنِّي آنَسْتُ نَارًا سَآتِيكُمْ مِنْهَا بِخَبَرٍ أَوْ آتِيكُمْ بِشِهَابٍ قَبَسٍ لَعَلَّكُمْ تَصْطَلُونَ
فَلَمَّا جَاءَهَا نُودِيَ أَنْ بُورِكَ مَنْ فِي النَّارِ وَمَنْ حَوْلَهَا وَسُبْحَانَ اللَّهِ رَبِّ الْعَالَمِينَ
يَا مُوسَىٰ إِنَّهُ أَنَا اللَّهُ الْعَزِيزُ الْحَكِيمُ
وَأَلْقِ عَصَاكَ ۖ فَلَمَّا رَآهَا تَهْتَزُّ كَأَنَّهَا جَانٌّ وَلَّىٰ مُدْبِرًا وَلَمْ يُعَقِّبْ ۚ يَا مُوسَىٰ لَا تَخَفْ إِنِّي لَا يَخَافُ لَدَيَّ الْمُرْسَلُونَ
إِلَّا مَنْ ظَلَمَ ثُمَّ بَدَّلَ حُسْنًا بَعْدَ سُوءٍ فَإِنِّي غَفُورٌ رَحِيمٌ
وَأَدْخِلْ يَدَكَ فِي جَيْبِكَ تَخْرُجْ بَيْضَاءَ مِنْ غَيْرِ سُوءٍ ۖ فِي تِسْعِ آيَاتٍ إِلَىٰ فِرْعَوْنَ وَقَوْمِهِ ۚ إِنَّهُمْ كَانُوا قَوْمًا فَاسِقِينَ
فَلَمَّا جَاءَتْهُمْ آيَاتُنَا مُبْصِرَةً قَالُوا هَٰذَا سِحْرٌ مُبِينٌ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Tâ-sîn, tilke âyâtül-Kur'âni ve kitâbin mübîn.
Hüden ve büşrâ lil-mü'minîn.
El-lezîne yükîmûnes-salâte ve yü'tûnez-zekâte ve hüm bil-âhıreti hüm yûkınûn.
İnnel-lezîne lâ yü'minûne bil-âhıreti zeyyennâ lehüm a'mâlehüm fehüm ya'mehûn.
Ülâikel-lezîne lehüm sûül-azâbi ve hüm fil-âhıreti hümül-ahserûn.
Ve inneke le-tülekkal-Kur'âne min ledün hakîmin alîm.
İz kâle Mûsâ li-ehlihî innî ânestü nâran seâtîküm minhâ bi-haberin ev âtîküm bi-şihâbin kabesin lealleküm tastalûn.
Fe lemmâ câehâ nûdiye en bûrike men fin-nâri ve men havlehâ, ve sübhânallâhi rabbil-âlemîn.
Yâ Mûsâ innehû enellâhül-azîzül-hakîm.
Ve elkı asâk, fe lemmâ reâhâ tehtezzü ke-ennehâ cânnün vellâ müdbiran ve lem yuakkib, yâ Mûsâ lâ tehaf innî lâ yehâfü ledeyyel-mürselûn.
İllâ men zaleme sümme beddele hüsnen ba'de sûin fe innî ğafûrun rahîm.
Ve edhıl yedeke fî ceybike tahruc beydâe min ğayri sû', fî tis'ı âyâtin ilâ Fir'avne ve kavmih, innehüm kânû kavmen fâsikîn.
Fe lemmâ câethüm âyâtünâ mübsıraten kâlû hâzâ sihrun mübîn.''',
    mana: '''Mekke döneminde inmiştir. Doksan üç âyettir. "Neml" karınca demektir. Sûrenin başında Kitab\'ın (Kur\'ân\'ın) müminlere hidayet ve müjde olduğu, namazı kılıp zekâtı veren ve âhirete kesin inananların kurtulacağı belirtilir. Ardından Hz. Musa\'nın Tur dağındaki mücadelesi, Hz. Süleyman\'ın kuşlarla konuşması, Belkıs\'ın İslam\'a daveti anlatılır. Karıncanın Hz. Süleyman\'a hitabı, Allah\'a şükür ve teslimiyet örneğidir. Allah\'ın kudretinin delilleri ve peygamberlerin daveti anlatılır.''',
  ),
  MubarekSureVerisi(
    baslik: 'Cevşen-ül Kebîr Duası',
    baslikEn: 'Al-Jawshan Al-Kabir Dua',
    arapca: '''بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ
اللَّهُمَّ إِنِّي أَسْأَلُكَ بِأَنَّ لَكَ الْحَمْدَ، لَا إِلَٰهَ إِلَّا أَنْتَ
الْمَنَّانُ بَدِيعُ السَّمَاوَاتِ وَالْأَرْضِ
ذُو الْجَلَالِ وَالْإِكْرَامِ
ذُو الْعِزِّ الَّذِي لَا يُضَامُ
تَبَارَكْتَ وَتَعَالَيْتَ
اللَّهُمَّ إِنِّي أَسْأَلُكَ بِاسْمِكَ الْأَعْظَمِ، الَّذِي إِذَا دُعِيتَ بِهِ أَجَبْتَ
وَإِذَا سُئِلْتَ بِهِ أَعْطَيْتَ
يَا حَيُّ يَا قَيُّومُ
يَا بَاسِطَ الرِّزْقِ
يَا ذَا الْجَلَالِ وَالْإِكْرَامِ''',
    okunus: '''Bismillâhirrahmânirrahîm.
Allâhümme innî es'elüke bi-enne lekel-hamd, lâ ilâhe illâ ent.
El-mennânü bedîus-semâvâti vel-ard.
Zül-celâli vel-ikrâm.
Zül-ızillezî lâ yudâm.
Tebârekte ve teâleyt.
Allâhümme innî es'elüke bismikel-a'zam, ellezî izâ düîte bihî ecest.
Ve izâ süilte bihî a'tayt.
Yâ Hayyü yâ Kayyûm.
Yâ bâsitar-rızk.
Yâ zel-celâli vel-ikrâm.''',
    mana: '''Cevşen-ül Kebîr, Hz. Peygamber (s.a.s.)\'in: "Allah\'ım! Senden, Cevşen hakkına ve yüceliğine ve göğe koyduğun isminin hakkı için Muhammed\'e ve âl-i Muhammed\'e salât etmeni istiyorum" diyerek başladığı ve savaşta zırh gibi koruyucu olduğu rivayet edilen büyük bir duadır. Yüz bölümden oluşur; her bölümünde Allah\'ın isim ve sıfatlarıyla niyaz edilir. Sıkıntı, darlık ve musibet anlarında okunması tavsiye edilir. Burada bir bölümünün özeti sunulmaktadır; tamamı ayrıca okunur.''',
  ),
];
