// ===========================================================================
// İBADET AKIŞLARI VERİLERİ
// Umre, Hac-ı İfrâd, Hac-ı Kırân ve Hac-ı Temettu için adım adım rehber.
// Her adımda: Ne yapılmalı? (fıkıh), okunacak dua (Arapça/okunuş/meal) ve
// sık yapılan hatalar.
// ===========================================================================

import 'hac_umre_verileri.dart';

const List<IbadetAkisi> ibadetAkilari = [
  IbadetAkisi(
    tur: IbadetTuru.umre,
    baslik: 'Umre Akışı',
    girisNotu:
        'Umre; ihram, tavaf, sa\'y ve tıraştan oluşan, yılın her günü '
        'yapılabilen bir ziyaret ibadetidir. Umrede vakfe ve şeytan taşlama '
        'yoktur.',
    adimlar: [
      IbadetAdimi(
        id: 'umre_mikat',
        baslik: 'Hazırlık ve İhrama Girme (Mikat)',
        kisaAciklama: 'Niyet, telbiye ve ihram yasaklarının başlangıcı',
        neYapilir: [
          'Önce gusül abdesti alın, kokuları sürünün (ihramdan önce yasak değildir).',
          'İhram elbisesi giyin: erkekler iki parça dikişsiz bez (izar + rida), kadınlar normal örtünür (eldiven ve yüz örtüsü hariç).',
          'Mikat sınırını geçmeden önce iki rekât ihram namazı kılın (sünnet).',
          'Umreye niyet edin ve telbiyeye başlayın: "Lebbeyk Allahümme lebbeyk…".',
          'İhram yasaklarını hatırlayın: koku, tırnak/saç kesme, avlanma, eşle cinsel temas, dikişli giysi (erkek), tartışma/kötü söz.',
        ],
        dua: DuaMetni(
          arapca:
              'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ، لَبَّيْكَ لاَ شَرِيكَ لَكَ لَبَّيْكَ، إِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَالْمُلْكَ، لاَ شَرِيكَ لَكَ',
          okunus:
              'Lebbeyk Allahümme lebbeyk, lebbeyke lâ şerîke leke lebbeyk. İnnel-hamde ven-ni\'mete leke vel-mülk, lâ şerîke lek.',
          meal:
              'Buyur Allah\'ım buyur! Emrindeyim, senin ortağın yoktur, emrindeyim. Şüphesiz hamd, nimet ve mülk senindir; senin ortağın yoktur.',
          kaynak: 'Telbiye (Buhârî, Hac 26)',
        ),
        sikHatalar: [
          'Mikat geçtikten sonra ihrama girmeyi unutmak — dönüş maddi ceza (dem) gerektirir.',
          'İhramdan önce değil sonra koku sürmek.',
          'Niyet etmeden sadece ihram elbisesi giymek.',
        ],
      ),
      IbadetAdimi(
        id: 'umre_mescid',
        baslik: 'Mekke\'ye Varış ve Mescid-i Haram\'a Giriş',
        kisaAciklama: 'Mescid-i Haram\'a sağ ayakla, huzurla girilir',
        neYapilir: [
          'Mekke\'ye varınca önce eşyalarınızı bırakıp Mescid-i Haram\'a gidin.',
          'Mescide sağ ayakla girin ve içeri girerken dua edin.',
          'Tavafa başlamadan önce Hacerü\'l-Esved\'in hizasına gelin.',
          'Kadınlar âdet hâlinde tavaf yapamaz; temizleninceye kadar beklenir.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
          okunus: 'Allahümme\'ftah lî ebvâbe rahmetik.',
          meal: 'Allah\'ım! Bana rahmetinin kapılarını aç.',
          kaynak: 'Mescide giriş duası (Müslim, Hac 79)',
        ),
        sikHatalar: [
          'Yorgun hâlde acele tavafa başlamak; önce kısa bir dinlenme sünnete daha uygundur.',
          'Hacerü\'l-Esved hizasını kaçırıp yanlış noktadan tavafa başlamak.',
        ],
      ),
      IbadetAdimi(
        id: 'umre_tavaf',
        baslik: 'Umre Tavafı (7 Şavt)',
        kisaAciklama: 'Kâbe\'nin etrafında yedi tur; ihramlıyken yapılır',
        neYapilir: [
          'Hacerü\'l-Esved\'in hizasından "Bismillâhi Allahu ekber" diyerek niyetle tavafa başlayın.',
          'Kâbe solda kalacak şekilde yedi şavt tamamlayın; her şavt bir turdur.',
          'Mümkünse her turda Hacerü\'l-Esved\'i sağ elle selamlayın (öpme zorunlu değildir).',
          'Sünnet bölge (Rükn-i Yemânî ile Hacerü\'l-Esved arası) varsa orada dua edin.',
          'Tavaf boyunca niyetli kalın; arada bir şavt kaçırırsanız ekstra turla tamamlayın.',
          'Tavaf sırasında "Tavaf Sayacı" modülünü kullanarak turları takip edebilirsiniz.',
        ],
        dua: DuaMetni(
          arapca:
              'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
          okunus:
              'Rabbenâ âtinâ fid-dünyâ haseneten ve fil-âhirati haseneten ve kınâ azâben-nâr.',
          meal:
              'Ey Rabbimiz! Bize dünyada da iyilik ver, ahirette de iyilik ver ve bizi ateş azabından koru.',
          kaynak: 'Bakara 201 (tavaf duası)',
        ),
        sikHatalar: [
          'Şavt sayısını karıştırmak — sayaç kullanarak takip edin.',
          'Kâbe\'nin sağından yürümek (Kâbe solda kalmalıdır).',
          'Kalabalıkta Hacerü\'l-Esved\'i öpmeye zorlanmak; zarar verme ihtimali varsa uzaktan işaret etmek yeterlidir.',
        ],
      ),
      IbadetAdimi(
        id: 'umre_namaz_zemzem',
        baslik: 'Tavaf Namazı ve Zemzem',
        kisaAciklama: 'Tavafın ardından iki rekât namaz + zemzem',
        neYapilir: [
          'Tavaf bitince Makam-ı İbrahim\'in arkasında (uygun bir yerde) iki rekât tavaf namazı kılın.',
          'Birinci rekâtta Kâfirûn, ikinci rekâtta İhlâs suresi okumak sünnettir.',
          'Namazdan sonra zemzem suyundan için ve dua edin.',
          'Tavaf namazından sonra Hacerü\'l-Esved\'i tekrar selamlamak tavafın tamamlandığını gösterir.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ إِنِّي أَسْأَلُكَ عِلْمًا نَافِعًا وَرِزْقًا وَاسِعًا وَشِفَاءً مِنْ كُلِّ دَاءٍ',
          okunus:
              'Allahümme innî es\'elüke ilmen nâfi\'an ve rizkan vâsi\'an ve şifâen min külli dâ\'in.',
          meal:
              'Allah\'ım! Senden faydalı ilim, bol rızık ve her derde deva şifa dilerim.',
          kaynak: 'Zemzem içerken dua',
        ),
        sikHatalar: [
          'Tavaf namazını tamamen atlamak (sünnettir, terk edilmemelidir).',
          'Zemzem kuyusu civarında izdihama girmek; kapalı alanlardaki zemzem makineleri de aynı suyu verir.',
        ],
      ),
      IbadetAdimi(
        id: 'umre_say',
        baslik: 'Sa\'y İbadeti (Safa-Merve)',
        kisaAciklama: 'Safa ve Merve tepeleri arasında yedi gidiş-geliş',
        neYapilir: [
          'Tavaf namazından sonra Safa tepesine çıkıp sa\'y niyeti edin.',
          'Safa tepesinde Kâbe\'ye yönelip tekbir ve dua edin.',
          'Safa ile Merve arasını yedi defa gidip gelin; gidiş bir, dönüş iki şavt sayılır.',
          'Sa\'y\'ın dört şavtı farz, tamamı vaciptir (cumhura göre).',
          'Yeşil işaretler arasında erkeklerin koşması (hervele) sünnettir.',
          'Merve tepesinde sa\'y sona erer.',
        ],
        dua: DuaMetni(
          arapca:
              'إِنَّ الصَّفَا وَالْمَرْوَةَ مِنْ شَعَائِرِ اللَّهِ',
          okunus: 'İnnes-Safâ vel-Mervete min şe\'âirillâh.',
          meal:
              'Şüphesiz Safa ve Merve, Allah\'ın (dininin) işaretlerindendir.',
          kaynak: 'Bakara 158',
        ),
        sikHatalar: [
          'Safa\'da Kâbe\'ye dönüp dua etmeyi unutmak.',
          'Şavt sayısını karıştırmak — "Sa\'y Sayacı" modülünü kullanın.',
          'Sa\'y bitmeden tıraş olup ihramdan çıkmak.',
        ],
      ),
      IbadetAdimi(
        id: 'umre_tiras',
        baslik: 'Tıraş Olup İhramdan Çıkış',
        kisaAciklama: 'Saçların kısaltılması ile ihram yasakları kalkar',
        neYapilir: [
          'Sa\'y bitince erkekler saçlarını tıraş eder veya kısaltır (tıraş etmek efdaldir).',
          'Kadınlar saçlarının ucundan bir tutam (parmak ucu kadar) kısaltır.',
          'Tıraş/kısaltma ile ihramdan tamamen çıkılır; bütün yasaklar kalkar.',
          'Umre tamamlanmıştır. İstediğiniz sıklıkta tekrar edebilirsiniz.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُ أَكْبَرُ، اللَّهُ أَكْبَرُ، اللَّهُ أَكْبَرُ',
          okunus: 'Allâhu ekber, Allâhu ekber, Allâhu ekber.',
          meal: 'Allah en büyüktür; her işte O\'nun büyüklüğüne şükrederiz.',
          kaynak: 'Tıraş sırasında tekbir',
        ),
        sikHatalar: [
          'Sa\'y tamamlanmadan tıraş olmak.',
          'Tıraş yerine sadece ihram kıyafetini çıkarmak (asıl çıkış tıraşladır).',
        ],
      ),
    ],
  ),
  IbadetAkisi(
    tur: IbadetTuru.hacTemettu,
    baslik: 'Hac-ı Temettu Akışı (En Yaygın)',
    girisNotu:
        'Önce umre yapılıp ihramdan çıkılır; 8 Zilhicce (Terviye) günü hac '
        'niyetiyle tekrar ihrama girilir. Şâfiî ve Mâlikîlere göre kurban '
        'vaciptir; Hanefîlere göre de Temettu kurbanı kesilir.',
    adimlar: [
      IbadetAdimi(
        id: 'temettu_umre_ihram',
        baslik: 'Umre Niyetiyle İhram (Mikat)',
        kisaAciklama: 'İlk ihram umre içindir; telbiye ile niyet edilir',
        neYapilir: [
          'Mikat sınırında gusül, ihram elbisesi ve iki rekât ihram namazı.',
          'Umreye niyet edin: "Lebbeyk Allahümme umreten…" telbiyesiyle ihrama girin.',
          'İhram yasaklarını koruyarak Mekke\'ye ulaşın.',
        ],
        dua: DuaMetni(
          arapca:
              'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ، لَبَّيْكَ لاَ شَرِيكَ لَكَ لَبَّيْكَ',
          okunus: 'Lebbeyk Allahümme lebbeyk, lebbeyke lâ şerîke leke lebbeyk.',
          meal: 'Buyur Allah\'ım buyur! Emrindeyim, senin ortağın yoktur, emrindeyim.',
          kaynak: 'Telbiye',
        ),
        sikHatalar: [
          'Hac ve umre niyetini karıştırmak (Temettu\'da ilk ihram yalnız umredir).',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_umre_adimlari',
        baslik: 'Umre: Tavaf, Sa\'y, Tıraş',
        kisaAciklama: 'Mekke\'de umre tamamlanır ve ihramdan çıkılır',
        neYapilir: [
          'Mescid-i Haram\'da yedi şavt tavaf + iki rekât tavaf namazı.',
          'Safa-Merve arasında yedi şavt sa\'y.',
          'Erkekler tıraş/kısaltma, kadınlar tutam kısaltma ile ihramdan çıkın.',
          'Artık bütün yasaklar kalkmıştır; serbestçe günlük hayata dönülür.',
        ],
        dua: DuaMetni(
          arapca:
              'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
          okunus:
              'Rabbenâ âtinâ fid-dünyâ haseneten ve fil-âhirati haseneten ve kınâ azâben-nâr.',
          meal: 'Ey Rabbimiz! Bize dünyada da iyilik, ahirette de iyilik ver; bizi ateş azabından koru.',
          kaynak: 'Bakara 201',
        ),
        sikHatalar: [
          'Temettu kurbanını unutmak için kurban vekâletini zamanında ayarlamak.',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_bekleyis',
        baslik: 'İhramsız Bekleyiş (5–8 Zilhicce)',
        kisaAciklama: 'Umre bitti, hac ihramı 8 Zilhicce\'de girilecek',
        neYapilir: [
          'Mekke\'de günlük namazlara, ziyaretlere ve istirahate devam edin.',
          '8 Zilhicce (Terviye) günü öncesinde vekâlet ile kurban işlemini organize edin.',
          'Hac günleri için plan yapın: Mina/Arafat bölgesi kalabalık olacaktır.',
        ],
        sikHatalar: [
          'Hac niyeti için 8 Zilhicce\'den önce ihrama girmek (gerek yoktur).',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_hac_ihram',
        baslik: '8 Zilhicce: Hac Niyetiyle Yeniden İhram',
        kisaAciklama: 'Terviye günü ihram + Mina\'ya hareket',
        neYapilir: [
          '8 Zilhicce günü (Terviye) gusül, ihram ve iki rekât namaz.',
          'Hacca niyet edin ve telbiyeye başlayın.',
          'Öğle/ikindi sonrası Mina\'ya hareket edin; geceyi Mina\'da geçirin.',
          'Mina\'da öğle, ikindi, akşam, yatsı ve sabah namazları kılınır (cuma değilse kısaltılmaz).',
        ],
        dua: DuaMetni(
          arapca:
              'لَبَّيْكَ اللَّهُمَّ حَجًّا',
          okunus: 'Lebbeyk Allahümme haccen.',
          meal: 'Buyur Allah\'ım, haccetmek üzere emrindeyim.',
          kaynak: 'Hac niyeti',
        ),
        sikHatalar: [
          '8 Zilhicce günü ihrama girmeyi geciktirmek; Mina planını aksatmak.',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_arafat',
        baslik: '9 Zilhicce: Arafat Vakfesi',
        kisaAciklama: 'Haccın rüknü; güneş batana kadar Arafat\'ta durulur',
        neYapilir: [
          'Güneş doğduktan sonra Arafat\'a hareket edin.',
          'Öğle ve ikindi namazları birleştirilip kısaltılarak kılınır (imam/cemâat ile).',
          'Vakfe: Arefe günü güneşin zevâlinden güneş batana kadar Arafat\'ta bulunmak vaciptir (rüknün şartı).',
          'Telbiye, tekbir, tehlil, Kur\'an ve dua ile vakfeyi değerlendirin.',
          'Vakfe, haccın en büyük rüknüdür; burada yapılan duanın kabulü umulur.',
        ],
        dua: DuaMetni(
          arapca:
              'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
          okunus:
              'Lâ ilâhe illallâhü vahdehû lâ şerîke leh. Lehül-mülkü ve lehül-hamdü ve hüve alâ külli şey\'in kadîr.',
          meal:
              'Allah\'tan başka ilah yoktur; O tektir, ortağı yoktur. Mülk ve hamd O\'nundur; O her şeye kadirdir.',
          kaynak: 'Arefe vakfesi zikri (Tirmizî, Hac 76)',
        ),
        sikHatalar: [
          'Arefe günü Arafat\'tan erken ayrılmak (güneş batmadan ayrılmak vakfeyi ihlal eder).',
          'Vakfeyi yanlış alanlarda (Müzdelife sınırında) yapmak — Arafat sınır levhalarına dikkat.',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_muzdelife',
        baslik: 'Müzdelife Vakfesi',
        kisaAciklama: 'Arefe gecesi Müzdelife\'de geçirilir',
        neYapilir: [
          'Güneş battıktan sonra Arafat\'tan Müzdelife\'ye hareket edin.',
          'Müzdelife\'de akşam (mağrip) ve yatsı namazları birleştirilerek kılınır.',
          'Geceyi Müzdelife\'de geçirin; bu geceki vakfe vaciptir.',
          'Sahur vaktine kadar dua ve zikirle meşgul olun.',
          'Küçük şeytan taşlama için taşları (49–70 adet) buradan toplayın.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ هَذَا جَمْعٌ فَاجْعَلْنَا فِيهِ مِنَ الْمُسْتَغْفِرِينَ',
          okunus:
              'Allahümme hâzâ cem\'un fac\'alnâ fîhi minel-müstağfirîn.',
          meal: 'Allah\'ım! Burası Müzdelife\'dir; bizi burada bağışlanma dileyenlerden kıl.',
          kaynak: 'Müzdelife duası',
        ),
        sikHatalar: [
          'Müzdelife gecesi erken ayrılıp şeytan taşlamayı gece yarısından önce yapmak (Hanefî\'de gerekli vaktin beklenmesi).',
          'Taş yerine başka şey toplamak (taşlar nohut büyüklüğünde olmalıdır).',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_akabe',
        baslik: '10 Zilhicce: Akabe Cemresi',
        kisaAciklama: 'Bayram günü büyük şeytan taşlama',
        neYapilir: [
          'Müzdelife\'den güneş doğmadan Mina\'ya hareket edin.',
          'Cemre-i Akabe (büyük cemre) ile eşit aralıklarla yedi taş atın.',
          'Her taşı atarken "Bismillâhi Allâhu ekber" deyin.',
          'Akabe taşlaması yapılmadan tavaf-ı ziyaret yapılamaz.',
        ],
        dua: DuaMetni(
          arapca:
              'بِسْمِ اللَّهِ وَاللَّهُ أَكْبَرُ',
          okunus: 'Bismillâhi vellâhu ekber.',
          meal: 'Allah\'ın adıyla; Allah en büyüktür.',
          kaynak: 'Taş atarken (Buhârî, Hac 81)',
        ),
        sikHatalar: [
          'Taşları havaya fırlatmak (isabet etmesi yeterlidir, güç gerekmez).',
          'Cemre alanına taş atmak için tehlikeli şekilde yaklaşmak.',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_kurban',
        baslik: 'Kurban Kesme',
        kisaAciklama: 'Temettu kurbanı: bayram günü veya sonrası',
        neYapilir: [
          'Temettu kurbanı vaciptir; genellikle vekâlet yoluyla kurban kesim organizasyonlarına başvurulur.',
          'Kurban, bayram günlerinde (10–13 Zilhicce) kesilir.',
          'Kurban kesilmeden tıraş olunmaz (sıralama: taşlama → kurban → tıraş).',
          'Yedi kişi bir deveye/sığıra ortak olabilir; koyun-keçi tek kişilik kesilir.',
        ],
        dua: DuaMetni(
          arapca:
              'بِسْمِ اللَّهِ وَاللَّهُ أَكْبَرُ، اللَّهُمَّ تَقَبَّلْ مِنِّي',
          okunus: 'Bismillâhi vellâhu ekber. Allahümme tekabbel minnî.',
          meal: 'Allah\'ın adıyla, Allah en büyüktür. Allah\'ım, bunu benden kabul et.',
          kaynak: 'Kurban duası',
        ),
        sikHatalar: [
          'Kurbanı kesmeden tıraş olmak (tıraş, kurbanın ardına bırakılır).',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_tiras',
        baslik: 'Tıraş (Tahallül)',
        kisaAciklama: 'İlk ihramdan çıkış: küçük tahallül',
        neYapilir: [
          'Kurban sonrası erkekler tıraş eder/kısaltır, kadınlar tutam kısaltır.',
          'Tıraşla ihram yasaklarının bir kısmı kalkar (koku, dikişli giysi vb.).',
          'Eşle ilişki hâlâ yasaktır; büyük tahallül için tavaf-ı ziyaret gerekir.',
        ],
        dua: DuaMetni(
          arapca:
              'الْحَمْدُ لِلَّهِ الَّذِي أَذْهَبَ عَنَّا الْحَرَجَ',
          okunus: 'Elhamdülillâhil-lezî ezhebe annel-harac.',
          meal: 'Üzerimizdeki zorluğu kaldıran Allah\'a hamd olsun.',
          kaynak: 'Tıraş duası',
        ),
        sikHatalar: [
          'Tıraşın ardından hemen eşle birlikte olmak (tavaf-ı ziyaret yapılmadan caiz değildir).',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_tavaf_ziyaret',
        baslik: 'Tavaf-ı Ziyaret (İfâza) + Sa\'y',
        kisaAciklama: 'Bayram günü haccın en büyük tavafı',
        neYapilir: [
          '10 Zilhicce günü (veya izin verilen günlerde) Mekke\'ye gidip yedi şavt tavaf-ı ziyaret yapın.',
          'İki rekât tavaf namazı kılın.',
          'Daha önce hac sa\'yı yapılmadıysa Safa-Merve arasında sa\'y edin.',
          'Tavaf-ı ziyaret haccın rüknüdür; mutlaka yapılmalıdır.',
          'Bu tavaf ile büyük tahallül gerçekleşir; artık bütün ihram yasakları kalkar.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ تَقَبَّلْ مِنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا',
          okunus: 'Allahümme tekabbel minnâ ve\'gfir lenâ verhamnâ.',
          meal: 'Allah\'ım! Bizden kabul et, bizi bağışla ve bize merhamet et.',
          kaynak: 'Tavaf duası',
        ),
        sikHatalar: [
          'Tavaf-ı ziyareti 13 Zilhicce sonrasına bırakmak (kaçırma riski vardır).',
          'Hac sa\'yını unutmak (Temettu\'da iki sa\'y gerekir: umre + hac).',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_mina',
        baslik: 'Mina Günleri (11–13 Zilhicce): Şeytan Taşlama',
        kisaAciklama: 'Teşrik günleri üç cemre de taşlanır',
        neYapilir: [
          'Mina\'da geçirilen günlerde üç cemreyi (küçük, orta, büyük) sırasıyla taşlayın.',
          '11 ve 12. günler her cemreye yedişer taş; sıra: küçük → orta → Akabe.',
          '13. güne kalmak isteyenler üç cemreyi de tekrar taşlar (teşrik).',
          'Mina gecelerini Mina\'da geçirmek vaciptir.',
          'Erken ayrılanlar 12. gün taşlamadan sonra güneş batmadan Mina\'dan çıkabilir.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ اجْعَلْهُ حَجًّا مَبْرُورًا وَذَنْبًا مَغْفُورًا',
          okunus:
              'Allahümme\'c\'alhû haccen mebrûran ve zenben mağfûrâ.',
          meal: 'Allah\'ım! Bu haccı kabul olunmuş ve günahı bağışlanmış kıl.',
          kaynak: 'Teşrik günü duası',
        ),
        sikHatalar: [
          'Cemre sıralamasını karıştırmak (küçük → orta → Akabe).',
          '12. gün güneş batmadan Mina\'dan çıkmamak.',
        ],
      ),
      IbadetAdimi(
        id: 'temettu_veda',
        baslik: 'Veda Tavafı',
        kisaAciklama: 'Mekke\'den ayrılış tavafı',
        neYapilir: [
          'Mekke\'den ayrılmadan önce son bir tavaf (yedi şavt) yapın.',
          'Veda tavafı, hac yapanlar için vaciptir (Şâfiî\'de sünnet).',
          'Tavafın ardından Kâbe\'ye son bir selam verip ayrılın.',
          'Veda tavafından sonra alışveriş vb. işlere dönülmemesi tavsiye edilir.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ لاَ تَجْعَلْهُ آخِرَ الْعَهْدِ بِبَيْتِكَ الْحَرَامِ',
          okunus:
              'Allahümme lâ tec\'alhû âhiral-ahdi bi-beytikel-harâm.',
          meal: 'Allah\'ım! Bunu Beyt-i Haram ile son ahdimiz kılma (bize tekrar nasip et).',
          kaynak: 'Veda duası',
        ),
        sikHatalar: [
          'Veda tavafını unutmak (bilerek terk edilirse ceza kurbanı gerekebilir).',
        ],
      ),
    ],
  ),
  IbadetAkisi(
    tur: IbadetTuru.hacIfrad,
    baslik: 'Hac-ı İfrâd Akışı',
    girisNotu:
        'Sadece hac niyetiyle tek ihrama girilir; umre için ayrı ihrama '
        'girilmez. Hac tamamlanana kadar ihramlı kalınır.',
    adimlar: [
      IbadetAdimi(
        id: 'ifrad_mikat',
        baslik: 'Mikatta Hac Niyetiyle İhram',
        kisaAciklama: 'Tek ihram: yalnız hacca niyet edilir',
        neYapilir: [
          'Mikatta gusül, ihram elbisesi ve iki rekât ihram namazı.',
          'Sadece hacca niyet edin: "Lebbeyk Allahümme haccen…".',
          'Umre için ayrıca niyet etmezsiniz; ihram haccın bitimine kadar sürer.',
        ],
        dua: DuaMetni(
          arapca:
              'لَبَّيْكَ اللَّهُمَّ حَجًّا',
          okunus: 'Lebbeyk Allahümme haccen.',
          meal: 'Buyur Allah\'ım, haccetmek üzere emrindeyim.',
          kaynak: 'Hac niyeti',
        ),
        sikHatalar: [
          'İhramdan çıkıp umre yapmak (İfrâd\'da böyle bir uygulama yoktur).',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_tavaf_kudum',
        baslik: 'Mekke\'de Tavaf-ı Kudüm',
        kisaAciklama: 'Varış tavafı: ihramlı olarak yapılır',
        neYapilir: [
          'Mescid-i Haram\'a varınca önce yedi şavt tavaf-ı kudüm yapın.',
          'İki rekât tavaf namazı kılın.',
          'Bu tavaf Mekke\'ye varışın sünnetidir; hac sa\'yı ayrı yapılır.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
          okunus: 'Allahümme\'ftah lî ebvâbe rahmetik.',
          meal: 'Allah\'ım! Bana rahmetinin kapılarını aç.',
          kaynak: 'Mescide giriş duası',
        ),
        sikHatalar: [
          'Tavaf-ı kudümü ihramsız yapmak (ihramlıyken yapılır).',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_say',
        baslik: 'Hac Sa\'yı (Safa-Merve)',
        kisaAciklama: 'İhramlı hâlde sa\'y yapılır',
        neYapilir: [
          'Tavaf-ı kudümün ardından Safa-Merve arasında yedi şavt sa\'y edin.',
          'Sa\'y, ihramlıyken yapılır; İfrâd\'da sa\'y tek yapılır (tavaf-ı ziyaret sonrası tekrar gerekmez).',
        ],
        dua: DuaMetni(
          arapca:
              'إِنَّ الصَّفَا وَالْمَرْوَةَ مِنْ شَعَائِرِ اللَّهِ',
          okunus: 'İnnes-Safâ vel-Mervete min şe\'âirillâh.',
          meal: 'Şüphesiz Safa ve Merve, Allah\'ın (dininin) işaretlerindendir.',
          kaynak: 'Bakara 158',
        ),
        sikHatalar: [
          'Sa\'yı tamamlamadan ihramlı bekleyişe geçmek.',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_bekleyis',
        baslik: 'İhramlı Bekleyiş (5–8 Zilhicce)',
        kisaAciklama: 'Hac günlerine kadar ihram korunur',
        neYapilir: [
          'Mekke\'de ihramlı olarak kalmaya devam edin; yasaklara dikkat edin.',
          'Tavaf-ı ziyareti yapmadan ihramdan çıkılamaz.',
          '8 Zilhicce (Terviye) hazırlıkları yapın.',
        ],
        sikHatalar: [
          'İhram yasaklarını unutup günlük alışkanlıklara dönmek.',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_terviye',
        baslik: 'Terviye Günü: Mina\'ya Hareket',
        kisaAciklama: '8 Zilhicce Mina\'da geçirilir',
        neYapilir: [
          '8 Zilhicce günü telbiye ve zikirlerle Mina\'ya hareket edin.',
          'Mina\'da namazları tam kılın (kısaltılmaz).',
          'Geceyi Mina\'da geçirin.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
          okunus:
              'Allahümme e\'innî alâ zikrike ve şükrike ve hüsni ibâdetik.',
          meal: 'Allah\'ım! Seni anmak, Sana şükretmek ve güzelce kulluk etmek için bana yardım et.',
          kaynak: 'Terviye duası',
        ),
        sikHatalar: [
          '8 Zilhicce günü Mina\'ya geç kalmak.',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_arafat',
        baslik: 'Arafat Vakfesi',
        kisaAciklama: 'Haccın rüknü; güneş batana kadar kalınır',
        neYapilir: [
          '9 Zilhicce sabahı Arafat\'a hareket edin.',
          'Öğle + ikindi birleştirilerek kısaltılıp kılınır.',
          'Güneş batana kadar Arafat sınırları içinde kalın (vakfe).',
          'Dua, telbiye ve zikirle meşgul olun.',
        ],
        dua: DuaMetni(
          arapca:
              'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
          okunus:
              'Lâ ilâhe illallâhü vahdehû lâ şerîke leh. Lehül-mülkü ve lehül-hamdü ve hüve alâ külli şey\'in kadîr.',
          meal: 'Allah\'tan başka ilah yoktur; O tektir, ortağı yoktur. Mülk ve hamd O\'nundur; O her şeye kadirdir.',
          kaynak: 'Arefe vakfesi zikri',
        ),
        sikHatalar: [
          'Güneş batmadan Arafat\'tan ayrılmak.',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_muzdelife',
        baslik: 'Müzdelife Vakfesi',
        kisaAciklama: 'Arefe gecesi Müzdelife',
        neYapilir: [
          'Güneş batınca Müzdelife\'ye hareket edin; akşam + yatsı birleştirilir.',
          'Gece vakfesi yapın; taşları toplayın.',
          'Sabah güneş doğmadan Mina\'ya geçin.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ هَذَا جَمْعٌ فَاجْعَلْنَا فِيهِ مِنَ الْمُسْتَغْفِرِينَ',
          okunus:
              'Allahümme hâzâ cem\'un fac\'alnâ fîhi minel-müstağfirîn.',
          meal: 'Allah\'ım! Burası Müzdelife\'dir; bizi burada bağışlanma dileyenlerden kıl.',
          kaynak: 'Müzdelife duası',
        ),
        sikHatalar: [
          'Taşsız gitmek (taşlar Müzdelife\'den toplanır).',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_akabe',
        baslik: '10 Zilhicce: Akabe Cemresi',
        kisaAciklama: 'Bayram günü büyük cemre taşlanır',
        neYapilir: [
          'Güneş doğduktan sonra Akabe cemresine yedi taş atın.',
          'Her taşta tekbir getirin.',
        ],
        dua: DuaMetni(
          arapca:
              'بِسْمِ اللَّهِ وَاللَّهُ أَكْبَرُ',
          okunus: 'Bismillâhi vellâhu ekber.',
          meal: 'Allah\'ın adıyla; Allah en büyüktür.',
          kaynak: 'Taş atarken',
        ),
        sikHatalar: [
          'Cemre sırasını bekleyip yanlış cemreyi taşlamak.',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_tiras',
        baslik: 'Kurban (İsteğe Bağlı) ve Tıraş',
        kisaAciklama: 'İfrâd\'da kurban vacip değildir; tıraşla çıkış',
        neYapilir: [
          'İfrâd\'da kurban gerekmez; dilerseniz nafile kurban kesebilirsiniz.',
          '10 Zilhicce tıraş/kısaltma ile ilk tahallül gerçekleşir.',
          'Eşle ilişki için tavaf-ı ziyaret şarttır.',
        ],
        dua: DuaMetni(
          arapca:
              'الْحَمْدُ لِلَّهِ الَّذِي أَذْهَبَ عَنَّا الْحَرَجَ',
          okunus: 'Elhamdülillâhil-lezî ezhebe annel-harac.',
          meal: 'Üzerimizdeki zorluğu kaldıran Allah\'a hamd olsun.',
          kaynak: 'Tıraş duası',
        ),
        sikHatalar: [
          'İfrâd\'da vacip kurban zannıyla gereksiz kurban yüküne girmek.',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_tavaf_ziyaret',
        baslik: 'Tavaf-ı Ziyaret',
        kisaAciklama: 'Bayram günü rükün tavafı',
        neYapilir: [
          '10 Zilhicce tavaf-ı ziyareti (yedi şavt) + iki rekât namaz yapın.',
          'Sa\'yı daha önce yaptıysanız tekrar gerekmez.',
          'Bu tavaf ile ihram yasakları tamamen kalkar.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ تَقَبَّلْ مِنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا',
          okunus: 'Allahümme tekabbel minnâ ve\'gfir lenâ verhamnâ.',
          meal: 'Allah\'ım! Bizden kabul et, bizi bağışla ve bize merhamet et.',
          kaynak: 'Tavaf duası',
        ),
        sikHatalar: [
          'Tavaf-ı ziyareti bayram günü yapmamak.',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_mina',
        baslik: 'Mina Günleri (11–13 Zilhicce)',
        kisaAciklama: 'Teşrik günleri taşlamaları',
        neYapilir: [
          'Üç cemreyi 11 ve 12. günler taşlayın; 13. gün kalırsanız tekrar taşlayın.',
          'Mina gecelerini Mina\'da geçirin.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ اجْعَلْهُ حَجًّا مَبْرُورًا وَذَنْبًا مَغْفُورًا',
          okunus:
              'Allahümme\'c\'alhû haccen mebrûran ve zenben mağfûrâ.',
          meal: 'Allah\'ım! Bu haccı kabul olunmuş ve günahı bağışlanmış kıl.',
          kaynak: 'Teşrik duası',
        ),
        sikHatalar: [
          'Mina\'dan erken ayrılırken 12. gün güneş batışını beklemeden yola çıkmak.',
        ],
      ),
      IbadetAdimi(
        id: 'ifrad_veda',
        baslik: 'Veda Tavafı',
        kisaAciklama: 'Mekke\'den ayrılış tavafı',
        neYapilir: [
          'Ayrılıştan önce son bir tavaf yapın.',
          'Veda tavafı sonrası işlere dönülmemesi tavsiye edilir.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ لاَ تَجْعَلْهُ آخِرَ الْعَهْدِ بِبَيْتِكَ الْحَرَامِ',
          okunus:
              'Allahümme lâ tec\'alhû âhiral-ahdi bi-beytikel-harâm.',
          meal: 'Allah\'ım! Bunu Beyt-i Haram ile son ahdimiz kılma.',
          kaynak: 'Veda duası',
        ),
        sikHatalar: [
          'Veda tavafını terk etmek.',
        ],
      ),
    ],
  ),
  IbadetAkisi(
    tur: IbadetTuru.hacKirran,
    baslik: 'Hac-ı Kırân Akışı',
    girisNotu:
        'Umre ve hac, tek ihramla birlikte niyet edilir. İhramdan yalnızca '
        'haccın bitiminde (tıraşla) çıkılır. Kırân yapanlara kurban vaciptir.',
    adimlar: [
      IbadetAdimi(
        id: 'kirran_mikat',
        baslik: 'Mikatta Umre + Hac Niyetiyle Tek İhram',
        kisaAciklama: 'İki niyet, tek ihram',
        neYapilir: [
          'Mikatta gusül, ihram ve iki rekât namaz.',
          '"Lebbeyk Allahümme umreten ve haccen…" diye iki niyeti birlikte yapın.',
          'İhram, hac tamamlanıncaya kadar sürer; tıraş hacca kadar yapılmaz.',
        ],
        dua: DuaMetni(
          arapca:
              'لَبَّيْكَ اللَّهُمَّ عُمْرَةً وَحَجًّا',
          okunus: 'Lebbeyk Allahümme umreten ve haccen.',
          meal: 'Buyur Allah\'ım, umre ve hac için emrindeyim.',
          kaynak: 'Kırân niyeti',
        ),
        sikHatalar: [
          'İki ihramla niyet etmek (kırânda tek ihram yeterlidir).',
        ],
      ),
      IbadetAdimi(
        id: 'kirran_tavaf_say',
        baslik: 'Tavaf-ı Kudüm ve Sa\'y',
        kisaAciklama: 'Mekke\'de ilk tavaf ve sa\'y',
        neYapilir: [
          'Mescid-i Haram\'da yedi şavt tavaf + iki rekât namaz.',
          'Safa-Merve arasında yedi şavt sa\'y yapın.',
          'İhramlı kalmaya devam edilir; tıraş yoktur.',
        ],
        dua: DuaMetni(
          arapca:
              'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
          okunus:
              'Rabbenâ âtinâ fid-dünyâ haseneten ve fil-âhirati haseneten ve kınâ azâben-nâr.',
          meal: 'Ey Rabbimiz! Bize dünyada da iyilik, ahirette de iyilik ver; bizi ateş azabından koru.',
          kaynak: 'Bakara 201',
        ),
        sikHatalar: [
          'Sa\'y sonrası tıraş olup ihramdan çıkmak (kırânda çıkış haccın bitimindedir).',
        ],
      ),
      IbadetAdimi(
        id: 'kirran_bekleyis',
        baslik: 'İhramlı Bekleyiş',
        kisaAciklama: '8 Zilhicce\'ye kadar ihram korunur',
        neYapilir: [
          'Mekke\'de ihramlı kalın; yasaklara riayet edin.',
          'Kırân kurbanı için vekâlet ayarlayın.',
        ],
        dua: DuaMetni(
          arapca:
              'لَبَّيْكَ اللَّهُمَّ لَبَّيْكَ',
          okunus: 'Lebbeyk Allahümme lebbeyk.',
          meal: 'Buyur Allah\'ım, buyur!',
          kaynak: 'Telbiye',
        ),
        sikHatalar: [
          'İhramı uzun süre korumak zor gelince yasakları ihlal etmek.',
        ],
      ),
      IbadetAdimi(
        id: 'kirran_terviye',
        baslik: 'Terviye: Mina',
        kisaAciklama: '8 Zilhicce Mina gecesi',
        neYapilir: [
          'Mina\'ya hareket edin, geceyi orada geçirin.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
          okunus:
              'Allahümme e\'innî alâ zikrike ve şükrike ve hüsni ibâdetik.',
          meal: 'Allah\'ım! Seni anmak, Sana şükretmek ve güzelce kulluk etmek için bana yardım et.',
          kaynak: 'Terviye duası',
        ),
        sikHatalar: [],
      ),
      IbadetAdimi(
        id: 'kirran_arafat',
        baslik: 'Arafat Vakfesi',
        kisaAciklama: '9 Zilhicce vakfe',
        neYapilir: [
          'Arafat\'a hareket, öğle+ikindi birleştirilir.',
          'Güneş batana kadar Arafat sınırları içinde kalın.',
        ],
        dua: DuaMetni(
          arapca:
              'لاَ إِلَهَ إِلاَّ اللَّهُ وَحْدَهُ لاَ شَرِيكَ لَهُ',
          okunus: 'Lâ ilâhe illallâhü vahdehû lâ şerîke leh.',
          meal: 'Allah\'tan başka ilah yoktur; O tektir, ortağı yoktur.',
          kaynak: 'Arefe zikri',
        ),
        sikHatalar: [
          'Güneş batmadan Arafat\'tan ayrılmak.',
        ],
      ),
      IbadetAdimi(
        id: 'kirran_muzdelife',
        baslik: 'Müzdelife',
        kisaAciklama: 'Arefe gecesi Müzdelife vakfesi',
        neYapilir: [
          'Müzdelife\'de akşam + yatsı birleştirilir, gece vakfesi yapılır.',
          'Taşları toplayın.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ هَذَا جَمْعٌ فَاجْعَلْنَا فِيهِ مِنَ الْمُسْتَغْفِرِينَ',
          okunus:
              'Allahümme hâzâ cem\'un fac\'alnâ fîhi minel-müstağfirîn.',
          meal: 'Allah\'ım! Burası Müzdelife\'dir; bizi burada bağışlanma dileyenlerden kıl.',
          kaynak: 'Müzdelife duası',
        ),
        sikHatalar: [],
      ),
      IbadetAdimi(
        id: 'kirran_akabe',
        baslik: '10 Zilhicce: Akabe Cemresi',
        kisaAciklama: 'Büyük cemre taşlanır',
        neYapilir: [
          'Güneş doğduktan sonra Akabe\'ye yedi taş atın.',
        ],
        dua: DuaMetni(
          arapca:
              'بِسْمِ اللَّهِ وَاللَّهُ أَكْبَرُ',
          okunus: 'Bismillâhi vellâhu ekber.',
          meal: 'Allah\'ın adıyla; Allah en büyüktür.',
          kaynak: 'Taş atarken',
        ),
        sikHatalar: [],
      ),
      IbadetAdimi(
        id: 'kirran_kurban',
        baslik: 'Kırân Kurbanı',
        kisaAciklama: 'Kırân kurbanı vaciptir',
        neYapilir: [
          '10–13 Zilhicce arasında kırân kurbanını kestirin (vekâlet ile olabilir).',
          'Kurban kesilmeden tıraş olunmaz.',
        ],
        dua: DuaMetni(
          arapca:
              'بِسْمِ اللَّهِ وَاللَّهُ أَكْبَرُ، اللَّهُمَّ تَقَبَّلْ مِنِّي',
          okunus: 'Bismillâhi vellâhu ekber. Allahümme tekabbel minnî.',
          meal: 'Allah\'ın adıyla, Allah en büyüktür. Allah\'ım, bunu benden kabul et.',
          kaynak: 'Kurban duası',
        ),
        sikHatalar: [
          'Kırân kurbanını unutmak.',
        ],
      ),
      IbadetAdimi(
        id: 'kirran_tiras',
        baslik: 'Tıraş (İlk Çıkış)',
        kisaAciklama: 'Kurban sonrası tıraş',
        neYapilir: [
          'Kurbanın ardından tıraş/kısaltma yapın.',
          'Eşle ilişki tavaf-ı ziyaret sonrasına bırakılır.',
        ],
        dua: DuaMetni(
          arapca:
              'الْحَمْدُ لِلَّهِ الَّذِي أَذْهَبَ عَنَّا الْحَرَجَ',
          okunus: 'Elhamdülillâhil-lezî ezhebe annel-harac.',
          meal: 'Üzerimizdeki zorluğu kaldıran Allah\'a hamd olsun.',
          kaynak: 'Tıraş duası',
        ),
        sikHatalar: [
          'Tavaf-ı ziyaretten önce eşle birlikte olmak.',
        ],
      ),
      IbadetAdimi(
        id: 'kirran_tavaf_ziyaret',
        baslik: 'Tavaf-ı Ziyaret',
        kisaAciklama: 'Rükün tavafı + ikinci sa\'y',
        neYapilir: [
          'Yedi şavt tavaf-ı ziyaret + iki rekât namaz.',
          'Sa\'y daha önce yapılmışsa tekrar gerekmez (cumhura göre).',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ تَقَبَّلْ مِنَّا وَاغْفِرْ لَنَا وَارْحَمْنَا',
          okunus: 'Allahümme tekabbel minnâ ve\'gfir lenâ verhamnâ.',
          meal: 'Allah\'ım! Bizden kabul et, bizi bağışla ve bize merhamet et.',
          kaynak: 'Tavaf duası',
        ),
        sikHatalar: [],
      ),
      IbadetAdimi(
        id: 'kirran_mina',
        baslik: 'Mina Günleri (11–13 Zilhicce)',
        kisaAciklama: 'Teşrik taşlamaları',
        neYapilir: [
          'Üç cemreyi 11 ve 12. gün taşlayın; kalanlar 13. gün tekrarlar.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ اجْعَلْهُ حَجًّا مَبْرُورًا وَذَنْبًا مَغْفُورًا',
          okunus:
              'Allahümme\'c\'alhû haccen mebrûran ve zenben mağfûrâ.',
          meal: 'Allah\'ım! Bu haccı kabul olunmuş ve günahı bağışlanmış kıl.',
          kaynak: 'Teşrik duası',
        ),
        sikHatalar: [],
      ),
      IbadetAdimi(
        id: 'kirran_veda',
        baslik: 'Veda Tavafı',
        kisaAciklama: 'Ayrılış tavafı',
        neYapilir: [
          'Mekke\'den ayrılmadan önce son tavafı yapın.',
        ],
        dua: DuaMetni(
          arapca:
              'اللَّهُمَّ لاَ تَجْعَلْهُ آخِرَ الْعَهْدِ بِبَيْتِكَ الْحَرَامِ',
          okunus:
              'Allahümme lâ tec\'alhû âhiral-ahdi bi-beytikel-harâm.',
          meal: 'Allah\'ım! Bunu Beyt-i Haram ile son ahdimiz kılma.',
          kaynak: 'Veda duası',
        ),
        sikHatalar: [
          'Veda tavafını terk etmek.',
        ],
      ),
    ],
  ),
];

/// Tavaf şavtları için önerilen dualar (1–7).
const List<SayaDuasi> tavafSekizDualari = [
  SayaDuasi(
    sira: 1,
    etiket: '1. Şavt',
    dua: DuaMetni(
      arapca:
          'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
      okunus:
          'Rabbenâ âtinâ fid-dünyâ haseneten ve fil-âhirati haseneten ve kınâ azâben-nâr.',
      meal: 'Ey Rabbimiz! Bize dünyada da iyilik, ahirette de iyilik ver ve bizi ateş azabından koru.',
      kaynak: 'Bakara 201',
    ),
  ),
  SayaDuasi(
    sira: 2,
    etiket: '2. Şavt',
    dua: DuaMetni(
      arapca:
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِي الدُّنْيَا وَالآخِرَةِ',
      okunus:
          'Allahümme innî es\'elükel-afve vel-âfiyete fid-dünyâ vel-âhirah.',
      meal: 'Allah\'ım! Senden dünya ve ahirette af ve afiyet dilerim.',
      kaynak: 'Tavaf duası',
    ),
  ),
  SayaDuasi(
    sira: 3,
    etiket: '3. Şavt',
    dua: DuaMetni(
      arapca:
          'اللَّهُمَّ أَعِنِّي عَلَى ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ',
      okunus:
          'Allahümme e\'innî alâ zikrike ve şükrike ve hüsni ibâdetik.',
      meal: 'Allah\'ım! Seni anmak, Sana şükretmek ve güzelce kulluk etmek için bana yardım et.',
      kaynak: 'Tavaf duası',
    ),
  ),
  SayaDuasi(
    sira: 4,
    etiket: '4. Şavt',
    dua: DuaMetni(
      arapca:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الشِّرْكِ وَالْكُفْرِ وَالنِّفَاقِ وَسُوءِ الأَخْلاَقِ',
      okunus:
          'Allahümme innî eûzü bike mineş-şirki vel-küfri ven-nifâkı ve sûil-ahlâk.',
      meal: 'Allah\'ım! Şirk, küfür, nifak ve kötü ahlaktan sana sığınırım.',
      kaynak: 'Tavaf duası',
    ),
  ),
  SayaDuasi(
    sira: 5,
    etiket: '5. Şavt',
    dua: DuaMetni(
      arapca:
          'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ وَالْعَجْزِ وَالْكَسَلِ وَالْبُخْلِ وَالْجُبْنِ',
      okunus:
          'Allahümme innî eûzü bike minel-hammi vel-hazeni vel-aczi vel-keseli vel-buhli vel-cübn.',
      meal: 'Allah\'ım! Üzüntüden, kederden, acizlikten, tembellikten, cimrilikten ve korkaklıktan sana sığınırım.',
      kaynak: 'Tavaf duası',
    ),
  ),
  SayaDuasi(
    sira: 6,
    etiket: '6. Şavt',
    dua: DuaMetni(
      arapca:
          'اللَّهُمَّ إِنِّي أَسْأَلُكَ الْجَنَّةَ وَأَعُوذُ بِكَ مِنَ النَّارِ',
      okunus: 'Allahümme innî es\'elükel-cennete ve eûzü bike minen-nâr.',
      meal: 'Allah\'ım! Senden cenneti diler, ateşten sana sığınırım.',
      kaynak: 'Tavaf duası',
    ),
  ),
  SayaDuasi(
    sira: 7,
    etiket: '7. Şavt',
    dua: DuaMetni(
      arapca:
          'اللَّهُمَّ اجْعَلْ حَجَّنَا مَبْرُورًا وَسَعْيَنَا مَشْكُورًا وَذَنْبَنَا مَغْفُورًا',
      okunus:
          'Allahümme\'c\'al haccenâ mebrûran ve sa\'yenâ meşkûran ve zenbenâ mağfûrâ.',
      meal: 'Allah\'ım! Haccımızı kabul olunmuş, sa\'yimizi makbul ve günahımızı bağışlanmış kıl.',
      kaynak: 'Tavaf duası',
    ),
  ),
];

/// Sa\'y sırasında okunabilecek dua.
const DuaMetni sayDuasi = DuaMetni(
  arapca:
      'إِنَّ الصَّفَا وَالْمَرْوَةَ مِنْ شَعَائِرِ اللَّهِ فَمَنْ حَجَّ الْبَيْتَ أَوِ اعْتَمَرَ فَلاَ جُنَاحَ عَلَيْهِ أَنْ يَطَّوَّفَ بِهِمَا',
  okunus:
      'İnnes-Safâ vel-Mervete min şe\'âirillâh. Fe men haccel-beyte evi\'tamera felâ cünâha aleyhi en yettavvefe bihimâ.',
  meal:
      'Şüphesiz Safa ve Merve, Allah\'ın (dininin) işaretlerindendir. Kim Beyt\'i hacceder veya umre yaparsa bu ikisi arasında gidip gelmesinde bir sakınca yoktur.',
  kaynak: 'Bakara 158',
);
