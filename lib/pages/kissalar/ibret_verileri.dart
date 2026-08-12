// ===========================================================================
// İBRETLİK HİKAYELER & ASFİYA KISSALARI
// Üç başlık: Kur'an Kıssaları, Sahabe & Tâbiîn Hayatından Kesitler,
// İslam Alimleri ve Evliya Menkıbeleri.
// Kaynak esasları: Diyanet Kur'an Yolu Tefsiri, İbn Kesîr, Kadı Iyaz
// "Şifa-i Şerif", İmam Nevevî "Riyâzü's-Sâlihîn".
// ===========================================================================

import 'kissalar_verileri.dart';

final KissaKategori ibretKategorisi = KissaKategori(
  id: 'ibret',
  ad: 'İbretlik Hikayeler',
  altBaslik:
      'Kur\'an kıssaları, sahabe hayatından kesitler ve alimlerin ibretli menkıbeleri',
  emoji: '📜',
  renkHex: '#EC4899',
  renkAkcentHex: '#F2C14E',
  gruplar: [
    // ======================== KUR'AN KISSALARI ========================
    KissaGrubu(
      ad: 'Kur\'an Kıssaları',
      aciklama: 'Kur\'an-ı Kerim\'de anlatılan ibret dolu kıssalar',
      kisalar: [
        const KissaKaydi(
          id: 'ibret-kehf',
          baslik: 'Ashâb-ı Kehf',
          ozet:
              'İmanlarını korumak için şehri terk edip mağaraya sığınan gençler ve 309 yıllık uyku.',
          emoji: '🏔️',
          kategoriId: 'ibret',
          temalar: ['Sadakat', 'Sabır', 'Tevekkül'],
          donem: 'İmtihan Kıssaları',
          metin: [
            'Bir şehirde, halkının çoğu putperestlikte direnen bir grup genç, Allah\'ın varlığına ve birliğine iman etmişlerdi. Kralın baskısına boyun eğmek yerine, imanlarını korumak için şehri terk ederek bir mağaraya sığındılar.',
            'Mağarada uykuya dalan gençler, Allah\'ın dilemesiyle günlerce, yıllarca uyudu. Kur\'an\'da belirtildiğine göre mağarada üç yüz dokuz yıl kaldılar. Uyandıklarında sabah ne kadar uyuduklarını bile bilmiyorlardı; dünya bambaşka olmuştu.',
            'Ashâb-ı Kehf kıssası, "gençliğin iman gücü" ve "örnek bir topluluk oluşturan sadakat" öyküsüdür. Onlar, zalim bir yönetime karşı tek başlarına karşı koyamayacaklarını bildikleri için hicret yolunu seçtiler — hicret, imanı korumanın meşru ve şerefli bir yoludur.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'يَا أَيُّهَا الَّذِينَ آمَنُوا كُونُوا قَوَّامِينَ لِلَّهِ',
              meal:
                  'Ey iman edenler! Adaleti ayakta tutan, Allah için şahitlik eden kimseler olun.',
              kaynak: 'Nisâ Suresi, 135. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Kişi sevdiğiyle beraberdir. (Buhârî, Edeb 96; Müslim, Birr 165)',
              kaynak: 'Buhârî, Edeb',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: 'Rivayete göre 3. yüzyıl', olay: 'Decius döneminde zulüm başladı'),
            KronolojiMadde(tarih: 'Mağaraya giriş', olay: 'Gençler mağaraya sığındı ve uykuya daldı'),
            KronolojiMadde(tarih: 'Uyanış', olay: 'Yıllar sonra uyandılar; şehir iman ehliyle dolmuştu'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Efes (Yedi Uyurlar)',
              aciklama: 'Günümüz Türkiye\'sinde, İzmir yakınlarında',
              enlem: 37.946,
              boylam: 27.340,
            ),
          ],
          hikmetler: [
            'İman, en büyük zenginliktir; onu kaybetmektense her şeyi terk etmek gerekir.',
            'Gençlik, kuvvetli imanın ve dava ahlakının en güzel örneğidir.',
            'Allah\'ın koruması, en zor görünen şartlarda bile iman ehlini ayakta tutar.',
          ],
          akademikNotlar: [
            'Ashâb-ı Kehf kıssası Kehf Suresi 9-26. ayetlerde anlatılır; sayıları ve uyku süreleri hakkında tefsirlerde farklı rivayetler zikredilir, Kur\'an bu konuda "onları yalnız Rabbim bilir" buyurur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Ashâb-ı Kehf hangi dönemde yaşamıştır?',
              secenekler: ['Bedir öncesi pagan Roma', 'Putperest krallar dönemi', 'Endülüs dönemi', 'Osmanlı dönemi'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Mağarada kaç yıl uyudular?',
              secenekler: ['3 yıl', '30 yıl', '309 yıl', '590 yıl'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-karun',
          baslik: 'Karun ve Hazineleri',
          ozet:
              'Haddinden fazla zenginleşen, şımaran ve şükretmeyen zenginin hazineleriyle birlikte batırılışı.',
          emoji: '💎',
          kategoriId: 'ibret',
          temalar: ['Cömertlik', 'Tevekkül', 'Ahlak'],
          donem: 'İmtihan Kıssaları',
          metin: [
            'Karun, Hz. Mûsâ\'nın kavminden biriydi; Allah ona öyle zenginlikler verdi ki hazinelerinin anahtarlarını güçlü bir topluluk bile taşıyamazdı. Kavmi ona "Şımarma! Allah şımaranları sevmez" diye nasihat etti.',
            'Karun, "Bu servet benim ilmim sayesinde bana verildi" dedi; şükrü kendinden, imtihanı Allah\'tan görmedi. Kavmi arasında şöhreti arttıkça kibri arttı. Onunla birlikte küçük bir inanlı topluluğu, "Allah\'ın sevabı daha hayırlıdır" diyerek ders çıkardı.',
            'Sonunda Allah, Karun\'u eviyle birlikte yerin dibine batırdı. Dün ona imrenenler, "Demek ki rızkı Allah bol verir ve kısar; şükreden kurtuldu, şımaran kaybetti" diyerek pişmanlıkla ibret aldılar.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'فَخَسَفْنَا بِهِ وَبِدَارِهِ الْأَرْضَ',
              meal:
                  'Nihayet onu da, sarayını da yerin dibine geçirdik.',
              kaynak: 'Kasas Suresi, 81. Ayet',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: 'Mûsâ (a.s.) dönemi', olay: 'Karun İsrail oğulları içinde zenginleşti'),
            KronolojiMadde(tarih: 'İmtihan', olay: 'Kavminin uyarılarına kulak asmadı'),
            KronolojiMadde(tarih: 'Son', olay: 'Hazinesiyle birlikte yere batırıldı'),
          ],
          hikmetler: [
            'Zenginlik bir makam değil, bir imtihandır; şükürle taşınmadığında sahibini batırır.',
            'İnsan, verilen her nimetin sahibini unutmamalıdır.',
            'Dünyalıkta yarışmak yerine ahiret kazancını tercih edenler gerçek zenginlerdir.',
          ],
          akademikNotlar: [
            'Karun kıssası Kasas Suresi 76-82. ayetlerde anlatılır. Tefsirlerde Hazret-i Mûsâ\'nın amcasının oğlu olduğu rivayet edilir; "hazine anahtarları" tabiri zenginliğin boyutunu sembolize eder.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Karun ne ile yere batırıldı?',
              secenekler: ['Gemisiyle', 'Sarayıyla', 'Ticaret kervanıyla', 'Bahçesiyle'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-hizir',
          baslik: 'Hz. Mûsâ ve Hızır (a.s.)',
          ozet:
              'İlim yolculuğu: Gösterişi itmeyen, hikmetin sırrına sabırla erişen yolcu.',
          emoji: '🚶',
          kategoriId: 'ibret',
          temalar: ['Sabır', 'İlim', 'Tevekkül'],
          donem: 'İmtihan Kıssaları',
          metin: [
            'Hz. Mûsâ\'ya, "Senden daha bilgili biri var" denildiğinde o, mütevazı davranarak bu âlimi aramaya koyuldu. Allah ona, hikmet sahibi bir kul olan Hızır\'ı buluşturdu. Yolculuk şartı gemiye zarar verilmemesi ve soru sorulmamasıydı.',
            'Yolculuk boyunca Hızır, görünüşte şaşırtıcı işler yaptı: Gemiyi deldi, bir çocuğu öldürdü, bir duvarı ücretsiz onardı. Hz. Mûsâ, sabırsızlıkla her defasında itiraz etti; Hızır, sabredemeyeceğini söyledi ve ayrılmadan önce her işin iç yüzünü açıkladı.',
            'Hızır\'ın işleri görünüşte zarar gibiydi; fakat gemi, arkalarından gelen zalim bir hükümdardan kurtuldu; çocuk, ana babasını helake sürükleyecekti; duvarın altında yetimlerin hazinesi vardı. Kıssa, "ilim ve hikmetin zahir ile batın katmanlarını" gösterir.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَلَا تَقْفُ مَا لَيْسَ لَكَ بِهِ عِلْمٌ',
              meal:
                  'Hakkında bilgin olmayan şeyin peşine düşme.',
              kaynak: 'İsrâ Suresi, 36. Ayet',
            ),
          ],
          hikmetler: [
            'Sabır, ilmin kapısıdır; gördüğün her şeyin bir hikmeti olabilir.',
            'Zahirde kötü görünen nice hadise, hayırla neticelenir.',
            'Alimlik, bildiğini kibirsizce taşımaktır; Hz. Mûsâ\'nın mütevazı ilim yolculuğu bunun örneğidir.',
          ],
          akademikNotlar: [
            'Kıssa Kehf Suresi 60-82. ayetlerde geçer. Müfessirler "Hızır" ismi konusunda farklı yorumlar yapmış; kıssanın, ilimde beklenmeyen usulleri ve ilahi takdirin hikmetini öğrettiği hususunda ittifak etmişlerdir.',
          ],
        ),
        const KissaKaydi(
          id: 'ibret-meryem',
          baslik: 'Hz. Meryem (a.s.)',
          ozet:
              'İffeti, teslimiyeti ve mucizevi bir şekilde Hz. Îsâ\'yı dünyaya getirişi.',
          emoji: '🌿',
          kategoriId: 'ibret',
          temalar: ['İffet', 'Sabır', 'Merhamet'],
          donem: 'İmtihan Kıssaları',
          metin: [
            'Hz. Meryem, Allah\'ın özel olarak seçtiği, tertemiz kılınan bir kadındı. Bekaretini korumak için mabetten ayrılıp doğuya çekildiğinde, Cebrail insan suretinde ona göründü ve temiz bir oğul müjdeledi.',
            'Meryem, hamile kalıp uzak bir yere çekildi ve hurma ağacının altında doğum sancısı çekti. "Keşke bundan önce ölseydim" diyecek kadar zorlandı; sonunda çocuğunun beklenen bir peygamber olduğunu gördü. Kavmine onu taşıyarak döndüğünde, "Ey Meryem! Şaşılacak bir iş getirdin" dediler.',
            'Meryem, bebeği işaret etti; beşikteki İsa konuşarak kendisini tanıttı. Meryem\'in iffet imtihanı, Allah\'a güvenen bir annenin yalnızlık ve mahrumiyetlerle dolu yolculuğunun en güzel örneğidir.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَإِذْ قَالَتِ الْمَلَائِكَةُ يَا مَرْيَمُ إِنَّ اللَّهَ اصْطَفَاكِ وَطَهَّرَكِ',
              meal:
                  'Melekler demişti ki: Ey Meryem! Allah seni seçti, seni tertemiz kıldı.',
              kaynak: 'Âl-i İmrân Suresi, 42. Ayet',
            ),
          ],
          hikmetler: [
            'İffet, en güzel örtüdür; Meryem\'in hayatı bunun timsalidir.',
            'Zorluk anında Allah\'a sığınmak, kurtuluşun anahtarıdır.',
            'Bir anne, evladını doğururken dahi rabbinin korumasına teslim olmalıdır.',
          ],
          akademikNotlar: [
            'Hz. Meryem, Kur\'an\'da adı geçen tek kadındır; Meryem Suresi 16-34. ayetlerde kıssası anlatılır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Meryem Suresi\'nde Hz. Meryem\'in doğumu nerede gerçekleşir?',
              secenekler: ['Mabet içinde', 'Hurma ağacı altında', 'Çölde', 'Gemi üzerinde'],
              dogruIndex: 1,
            ),
          ],
        ),
      ],
    ),

    // ==================== SAHABE & TÂBİÎN ====================
    KissaGrubu(
      ad: 'Sahabe ve Tâbiîn Hayatından Kesitler',
      aciklama: 'Aşere-i Mübeşşere, hanım sahabiler ve örnek hayatlar',
      kisalar: [
        const KissaKaydi(
          id: 'ibret-siddik',
          baslik: 'Hz. Ebû Bekir es-Sıddîk',
          ozet:
              'Cennetle müjdelenen ilk halife: malların ve canların en samimi infakı.',
          emoji: '🌟',
          kategoriId: 'ibret',
          temalar: ['Cömertlik', 'Sadakat', 'Adalet'],
          donem: 'Asr-ı Saadet',
          metin: [
            'Hz. Ebû Bekir, İslam\'la ilk şereflenen hür erkekti. Her şeyini, malını ve canını İslam\'a vakfetti. Hicret gecesi mağarada Resûlullah (s.a.v.)\'in yoldaşı oldu; "mağaranın iki kişisinden ikincisi" olarak anıldı.',
            'Miras olarak getirdiği malını \"çoluk çocuğuma yetecek kadar helal kazancım mühimdir\" dedi. Resûlullah (s.a.v.)\'in, \"Ebû Bekir\'in malı bana ne kadar fayda verdi!\" buyurduğu rivayet edilir.',
            'Vefatına kadar infakta, adalette ve sünnete bağlılıkta örnek oldu. \"Sıddîk\" (doğrulayan) lakabı, İsrâ ve Miraç\'ı ilk tasdik eden kişi olmasından gelir.',
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Ebû Bekir\'in malı bana ne kadar fayda verdi! (Tirmizî, Menâkıb 15)',
              kaynak: 'Tirmizî, Menâkıb',
            ),
          ],
          hikmetler: [
            'İman, malını ve canını ortaya koyduğunda gerçek anlam kazanır.',
            'Doğruluk (sıdk), müminin en temiz kimliğidir.',
            'Yönetim makamı, şahsi zenginlik değil; halka adalet ve hizmet mesuliyetidir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Ebû Bekir\'in lakabı hangisidir?',
              secenekler: ['Fârûk', 'Sıddîk', 'Emîn', 'Zünnûn'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-humeyra',
          baslik: 'Hz. Âişe (r.a.)',
          ozet:
              'Sıddîka: Fıkıh, tıp ve hadis alanında dönemin en büyük müçtehidlerinden biri.',
          emoji: '📚',
          kategoriId: 'ibret',
          temalar: ['İlim', 'İffet', 'Sabır'],
          donem: 'Asr-ı Saadet',
          metin: [
            'Hz. Âişe, Peygamber Efendimiz\'in hanımları arasında en çok hadis rivayet edenlerdendir. İslam\'ın ilk yıllarından itibaren ilim meclislerinin baş aktörü oldu; fıkıh, tefsir ve tıp alanlarında dönemin alimlerine ders verdi.',
            'İfk olayında (iftira hadisesi) büyük bir imtihana tabi tutuldu; iffetini Allah (c.c.) bizzat âyetle tezkiye etti. Bu olay, meşakkat ve üzüntüye rağmen sabrın ve tevekkülün nasıl zaferle neticelendiğini gösterdi.',
            'Vefatından sonra dahi onun içtihatları Müslümanların ilim mirasına kaynaklık etti. \"Din, dörtte birini kadınlardan öğrendi\" sözü, onun ilimdeki yerinin göstergesidir.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'إِذْ تَلَقَّوْنَهُ بِأَلْسِنَتِكُمْ',
              meal:
                  'O haberi ağızdan ağıza dolaştırarak dilinize dolamıştınız.',
              kaynak: 'Nûr Suresi, 15. Ayet',
            ),
          ],
          hikmetler: [
            'İlim, kadın erkek her mümin için farzdır; Hz. Âişe bunun en büyük şahididir.',
            'İftiraya karşı sabır ve dua, müminin kalkanıdır.',
            'Meclislerin değeri, orada Allah\'ın kelamının ve peygamber sünnetinin konuşulmasındadır.',
          ],
          akademikNotlar: [
            'İfk hadisesi Nûr Suresi 11-20. ayetlerde anlatılır; Hz. Âişe\'nin ehl-i beyt\'e mensubiyeti ve adalet hassasiyeti hadis ve siyer kaynaklarında genişçe işlenir.',
          ],
        ),
        const KissaKaydi(
          id: 'ibret-bilal',
          baslik: 'Hz. Bilâl-i Habeşî',
          ozet:
              'Kölelikten müezzinliğe: zulme boyun eğmeyen imanın azimli sesi.',
          emoji: '🕌',
          kategoriId: 'ibret',
          temalar: ['Sabır', 'Sadakat', 'Cesaret'],
          donem: 'Asr-ı Saadet',
          metin: [
            'Hz. Bilâl, Mekke\'de müşriklerin kölesiydi. İslam\'la şereflendiğinde Ümeyye bin Halef gibi zalimler onu güneş altında, kızgın kumların üzerinde işkenceyle \"Muhammed\'i inkâr et\" dedikçe o, \"Ehad, Ehad!\" (Allah birdir) diye direndi.',
            'Hz. Ebû Bekir, onu satın alarak azat etti. Buna rağmen müşrikler işkenceye devam edince, Resûlullah (s.a.v.) tarafından övülerek \"Bilâl\'in ayak seslerini cennette işitiyorum\" müjdesi verildi.',
            'Medine\'de İslam\'ın ilk müezzini oldu; insanlık tarihinin en meşhur ezan seslerinden birini oluşturdu. Vefatına kadar gösterişten uzak, ihlas ve sadâkatle yaşadı.',
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Bilâl\'in ayak seslerini cennette işittim. (Buhârî, Menâkıb 26)',
              kaynak: 'Buhârî, Menâkıb',
            ),
          ],
          hikmetler: [
            'İman, kişinin makamı ve mevkii değildir; zalimin karşısındaki duruştur.',
            'Sabah ezanı, kölelikten müezzinliğe yükselen bir imanın sesidir.',
            'Zulme rıza göstermemek müminin ilk şiarıdır.',
          ],
        ),
      ],
    ),

    // ==================== ALİMLER & EVLİYA ====================
    KissaGrubu(
      ad: 'İslam Alimleri ve Evliya Menkıbeleri',
      aciklama: 'İmam-ı Âzam, Hasan-ı Basrî, Mevlânâ ve Yunus Emre',
      kisalar: [
        const KissaKaydi(
          id: 'ibret-imamiazam',
          baslik: 'İmam-ı Âzam Ebû Hanîfe',
          ozet:
              'Fıkıh ilminin imamı: zühd, ticaret ahlakı ve zalime karşı dik duruş.',
          emoji: '⚖️',
          kategoriId: 'ibret',
          temalar: ['İlim', 'Adalet', 'Ahlak'],
          donem: 'Tâbiîn Sonrası',
          metin: [
            'Küfe\'de doğan İmam-ı Âzam, gençliğinde ticaretle meşgul oldu; kumaş ticaretindeki doğruluğu ile tanındı. Şöhreti artınca ilme yöneldi; fıkıh ve hadiste devrin en büyük âlimi haline geldi.',
            'İlmine rağmen ticareti bırakmadı; kazandığının büyük bölümünü talebelerine ve ihtiyaç sahiplerine harcadı. \"İlim talebesi, kendini sıkıntıya atar\" sözü, onun ilim ehline meşakkati göze alma tembihini yansıtır.',
            'Emevî ve Abbâsî dönemlerinde zulme karşı dik durdu; kadılık (hâkimlik) teklifini kabul etmedi ve bu yüzden hapse atıldı, dayak yedi. Vefatına kadar ilmi, zühdü ve istikameti elden bırakmadı.',
          ],
          hikmetler: [
            'Helal kazanç, âlimin ve müminin şiarıdır.',
            'Makam teklifi, imtihan teklifi demektir; İmam-ı Âzam bunu reddetti.',
            'İlmin kıymeti, onu yaşayan ve zulme karşı kullananla artar.',
          ],
          akademikNotlar: [
            'Ebû Hanîfe\'nin mezhebi, günümüzde en yaygın fıkıh mekteplerindendir; görüşleri el-Fıkhü\'l-Ekber ve eserlerinde sistemleşmiştir.',
          ],
        ),
        const KissaKaydi(
          id: 'ibret-mevlana',
          baslik: 'Mevlânâ Celâleddîn Rûmî',
          ozet:
              'Aşk ve ilim: Şems ile tanıştıktan sonra insanlığa hizmet eden bir gönül sultanı.',
          emoji: '🌀',
          kategoriId: 'ibret',
          temalar: ['Merhamet', 'Sabır', 'Tevekkül'],
          donem: 'Selçuklu Dönemi',
          metin: [
            'Belh\'de doğan Mevlânâ, ilim tahsili için Konya\'ya yerleşti. Dönemin alimlerinden dersler aldı; fıkıh, tefsir ve tasavvuf alanlarında derinleşti. Onu asıl dönüştüren, Şems-i Tebrîzî ile tanışması oldu.',
            'Gönlü aşkla yoğrulduktan sonra ilmi, \"gönül ilmine\" dönüştürdü. Mesnevî\'sinde insanı \"biz\"leştirmeye, gönlü birleştirmeye davet etti. \"Ne olursan ol yine gel\" anlayışı, onun rahmete ve umuda açılışını anlatır.',
            'İnsanlara, canlılara ve tüm varlığa şefkatle yaklaştı. Ölümü, \"Şeb-i Arûs\" (düğün gecesi) olarak anılır; onun için ölüm, Hakk\'a kavuşma vuslatıydı.',
          ],
          hikmetler: [
            'İlim, gönülle buluştuğunda hikmete dönüşür.',
            'İnsanlara şefkat, imanın en büyük göstergesidir.',
            'Ölüm, insanı Hakk\'a götüren bir vuslattır; ondan korkmamak gerekir.',
          ],
          akademikNotlar: [
            'Mesnevî-i Manevî, yaklaşık 25.700 beyitten oluşur; Mevlevîlik tarikatı onun öğretilerini sistemleştirmiştir.',
          ],
        ),
        const KissaKaydi(
          id: 'ibret-yunus',
          baslik: 'Yunus Emre',
          ozet:
              'Türkçe\'nin ve gönlün âşığı: \"Yaratılanı severiz, Yaradan\'dan ötürü.\"',
          emoji: '🕊️',
          kategoriId: 'ibret',
          temalar: ['Merhamet', 'Ahlak', 'Sabır'],
          donem: 'Anadolu Selçuklu',
          metin: [
            'Yunus Emre, Anadolu\'da yetişen büyük bir gönül eridir. Halkın anlayacağı Türkçe ile imanı, ahlakı ve aşkı anlattı. Şeriat, tarikat ve hakikat ilimlerini; hepsini aşkla buluşturdu.',
            'Onun şiirlerinde insan sevgisi, Yaratıcı sevgisinin bir parçasıdır. \"Yunus\'un gönlü dolu, birliğe ulaştı\" beyti, gönlün imanla yoğrulmasının göstergesidir.',
            'İster âlim olsun ister avam; herkese \"gel\" diyebildi. Onun dili, halkı irşat etmenin ve ilahi aşkı sadeleştirmenin örneğidir.',
          ],
          hikmetler: [
            '"Yaratılanı Yaratandan ötürü sevmek" müminin düsturu olmalı.',
            'İlim, halkın anlayacağı dille anlatıldığında bereketlenir.',
            'Gönül yapmak, ibadetlerin özüdür.',
          ],
        ),
      ],
    ),
  ],
);

void ibretKaydet() => KissalarVerileri.kayitKategori(ibretKategorisi);