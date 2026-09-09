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
              arapca:
                  'يَا أَيُّهَا الَّذِينَ آمَنُوا كُونُوا قَوَّامِينَ لِلَّهِ',
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
            KronolojiMadde(
              tarih: 'Rivayete göre 3. yüzyıl',
              olay: 'Decius döneminde zulüm başladı',
            ),
            KronolojiMadde(
              tarih: 'Mağaraya giriş',
              olay: 'Gençler mağaraya sığındı ve uykuya daldı',
            ),
            KronolojiMadde(
              tarih: 'Uyanış',
              olay: 'Yıllar sonra uyandılar; şehir iman ehliyle dolmuştu',
            ),
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
              secenekler: [
                'Bedir öncesi pagan Roma',
                'Putperest krallar dönemi',
                'Endülüs dönemi',
                'Osmanlı dönemi',
              ],
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
              meal: 'Nihayet onu da, sarayını da yerin dibine geçirdik.',
              kaynak: 'Kasas Suresi, 81. Ayet',
            ),
          ],
          kronoloji: [
            KronolojiMadde(
              tarih: 'Mûsâ (a.s.) dönemi',
              olay: 'Karun İsrail oğulları içinde zenginleşti',
            ),
            KronolojiMadde(
              tarih: 'İmtihan',
              olay: 'Kavminin uyarılarına kulak asmadı',
            ),
            KronolojiMadde(
              tarih: 'Son',
              olay: 'Hazinesiyle birlikte yere batırıldı',
            ),
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
              secenekler: [
                'Gemisiyle',
                'Sarayıyla',
                'Ticaret kervanıyla',
                'Bahçesiyle',
              ],
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
              meal: 'Hakkında bilgin olmayan şeyin peşine düşme.',
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
              arapca:
                  'وَإِذْ قَالَتِ الْمَلَائِكَةُ يَا مَرْيَمُ إِنَّ اللَّهَ اصْطَفَاكِ وَطَهَّرَكِ',
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
              soru:
                  'Meryem Suresi\'nde Hz. Meryem\'in doğumu nerede gerçekleşir?',
              secenekler: [
                'Mabet içinde',
                'Hurma ağacı altında',
                'Çölde',
                'Gemi üzerinde',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-habil-kabil',
          baslik: 'Habil ile Kabil',
          ozet:
              'Kur\'an\'ın anlattığı ilk cinayet: kardeş kıskançlığı, bir kuzgunun dersi ve vicdan.',
          emoji: '🐦',
          kategoriId: 'ibret',
          temalar: ['Ahlak', 'Adalet'],
          donem: 'İlk Kıssalar',
          metin: [
            'Kur\'an, ilk insanın oğullarından söz eder: "Onlara Âdem\'in iki oğlunun haberini gerçek olarak oku. İkisi birer kurban takdim etmişlerdi; birinin kabul edildi, ötekinin kabul edilmedi. Kabul edilmeyen: Andolsun seni öldüreceğim, dedi." (Mâide 27)',
            'Kabil kurbanının reddedildiğini kabullenemedi; kardeşi Habil ise "Allah ancak takva sahiplerinden kabul eder" (Mâide 27) diyerek gönül rahatlığı içindeydi. Kabil, Habil\'i öldürdü ve yeryüzünün ilk kanını döktü. Sonra ne yapacağını bilemedi; Allah ona, toprağı eşeleyerek bir kuzgunu (kara haberci) gönderdi ve kardeşinin cesedini nasıl gömeceğini öğretti.',
            '"Eyvah! Bu kuzgun, benim kadar olmaktan âciz kaldı ve kardeşimin cesedini gömmemi bana göstermedi mi?" diye pişmanlık duydu ve ızdırap içinde kaldı. (Mâide 30-31) İlk büyük günah işlendi; kıskançlık, insanlığın ilk katliamının sebebi oldu.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَاتْلُ عَلَيْهِمْ نَبَأَ ابْنَيْ آدَمَ بِالْحَقِّ',
              meal:
                  'Onlara, Âdem\'in iki oğlunun (Kabil ile Habil\'in) haberini gerçek olarak oku.',
              kaynak: 'Mâide Suresi, 27. Ayet',
            ),
          ],
          hikmetler: [
            'Kıskançlık ve kibir, insanı ilk günahtan beri kardeşine düşman eder.',
            'Amellerin kabulü takvaya bağlıdır; gösteriş kabul ettirmez.',
            'Allah, kuzgunla bile insana ders verir: pişmanlık, suçun karşısında geç kalan ama asla gereksiz olmayan bir vicdan sesidir.',
          ],
          akademikNotlar: [
            'Kıssa Mâide 27-31. ayetlerde anlatılır; "bir kimse bir canı haksız yere öldürürse bütün insanları öldürmüş gibi olur" ayeti (Mâide 32) bu kıssanın hemen ardından gelir.',
            'Kuzgunun kardeşini gömmeyi öğrettiği rivayeti, klasik tefsirlerin ortak anlatımıdır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Habil\'in kurbanı neden kabul edildi?',
              secenekler: [
                'Zengin olduğu için',
                'Takva sahibi olduğu için',
                'Kurbanı daha büyük olduğu için',
                'Yaşı büyük olduğu için',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-fil',
          baslik: 'Fil Vakası (Ashâb-ı Fil)',
          ozet:
              'Kâbe\'yi yıkmaya gelen Ebrehe\'nin ordusu: ebabil kuşları ve "sikkil" taşları.',
          emoji: '🐘',
          kategoriId: 'ibret',
          temalar: ['Tevekkül', 'Cesaret'],
          donem: 'Hicaz Tarihi',
          metin: [
            'Habeş kralının Yemen valisi Ebrehe, Kâbe\'ye rakip bir kilise yaptırmış ve hacıları oraya yönlendirmek istemişti. Kâbe\'ye hürmet gösterilmesine öfkelenince, büyük bir orduyla ve ordunun önünde savaş fillerini taşıyarak Mekke\'ye yürüdü.',
            'Abdülmuttalib, "Develerimin sahibi benim; Kâbe\'nin de bir sahibi var, O onu korur" dedi. Ebrehe\'nin ordusu, filleriyle Mekke yakınlarına (Muhassir) varınca gökten, sürüler halinde kuşlar (ebabil) gönderildi: "Onların üzerine, pişmiş çamurdan (sikkil) taşlar atan kuşlar gönderdi." (Fîl 3-4)',
            'Taşlara isabet eden askerler, yenmiş ekin gibi çiğnenmiş halde dağıldı. Bu olay, Kur\'an\'ın tamamıyla ayrı bir sureyle (Fîl) anlattığı bir mucizedir; aynı yılın içinde Hz. Muhammed (s.a.v.) dünyaya geldi.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'أَلَمْ تَرَ كَيْفَ فَعَلَ رَبُّكَ بِأَصْحَابِ الْفِيلِ',
              meal:
                  'Rabbinin fil ordusu sahiplerine nasıl davrandığını görmedin mi?',
              kaynak: 'Fîl Suresi, 1. Ayet',
            ),
          ],
          hikmetler: [
            'Kâbe\'nin koruyucusu Allah\'tır; en güçlü ordu bile ilahi irade karşısında hiçtir.',
            'Azmin ve tevekkülün karşısında imanlı bir topluluk, "kuşlar ve taşlarla" nasıl korunur? İşte ders budur.',
            'İman, korkuya yenik düşmez: Abdülmuttalib\'in duruşu bunun örneğidir.',
          ],
          akademikNotlar: [
            'Fîl Suresi, Ebrehe ordusunun helakini anlatır; olay hicri takvimde "Fil Yılı" (571) olarak adlandırılmıştır.',
            'Ebabil kuşları ve sikkil taşları hakkında tefsirlerde sembolik ve gerçekçi yorumlar bir arada bulunur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Ebrehe\'nin ordusunu kim durdurdu?',
              secenekler: [
                'Savaşçılar',
                'Ebabil kuşlarının attığı sikkil taşları',
                'Gemi',
                'Deprem',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-uhdud',
          baslik: 'Ashâb-ı Uhdud (Hendek Ashabı)',
          ozet:
              'İman etmeyenlerce kazılmış ateşli hendekler ve inancına teslim olanların kıssası.',
          emoji: '🔥',
          kategoriId: 'ibret',
          temalar: ['Sabır', 'Sadakat', 'Cesaret'],
          donem: 'İmtihan Kıssaları',
          metin: [
            'Kur\'an, "Hendek sahipleri lanetlendi" (Büruc 4) diyerek bir ibret örneğini anlatır. Zalim yöneticiler, iman edenleri; alevler yanan bir hendek kazarak içine atmış ve onları dinlerinden döndürmek için yakmışlardı. "Hani o hendeklerin/ateşlerin çevresinde oturup, inananlara yaptıklarını seyrediyorlardı." (Büruc 6-7)',
            'İman edenler, dinlerinden dönmediler; ateşe atılmayı göze aldılar. Bir genç kadın, çocuğuyla birlikte tutulmuştu; "Sabret anne, sen hak üzeresin" diyen o küçük çocuk büyüklüğü öğretti; ikisi de ateşe atıldı. Yöneticiler, yalnızca "Rabbimiz Allah\'tır" dedikleri için onlardan intikam aldılar.',
            'Sonunda Allah: "İman edip salih ameller işleyenlere, içinden ırmaklar akan cennetler vardır; bu büyük kurtuluştur." (Büruc 9) buyurdu. Ateş, müminler için zafer; zalimler için hesap gününün elçisi oldu.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'وَمَا نَقَمُوا مِنْهُمْ إِلَّا أَن يُؤْمِنُوا بِاللَّهِ الْعَزِيزِ الْحَمِيدِ',
              meal:
                  'Onlardan ancak, mutlak güç ve hamd sahibi Allah\'a iman ettikleri için intikam aldılar.',
              kaynak: 'Büruc Suresi, 8. Ayet',
            ),
          ],
          hikmetler: [
            'İnanç, ateşe atılmayı göze aldıracak kadar kıymetlidir; müminler bu sınavı aşanlardır.',
            'Zulmeden, asıl kaybedendir: yaktığı ateş, kendisi için hesap oldu.',
            'En zor imtihanlarda bile sabredenlere, ebedi kurtuluş müjdesi vardır.',
          ],
          akademikNotlar: [
            'Kıssa Büruc Suresi 4-9. ayetlerde geçer; tarihsel olarak Yemen\'deki Necran Hıristiyanları\'nın kıssasıyla ilişkilendirilir.',
            'Lamış, yakılan kalplerin; dikenli ateşlerin ve seyredenlerin tasviri, zulmün soğukkanlılık boyutunu anlatır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Ashâb-ı Uhdud hangi surede anlatılır?',
              secenekler: ['Fîl', 'Büruc', 'Nâs', 'Kevser'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-sebt',
          baslik: 'Ashâb-ı Sebt (Cumartesi Yasağına Uymayanlar)',
          ozet:
              'Kıyı kasabasında cumartesi av yasağını delmek isteyenlerin maymuna dönüştürülmesi.',
          emoji: '🐟',
          kategoriId: 'ibret',
          temalar: ['Ahlak', 'Adalet'],
          donem: 'İsrailoğulları Kıssaları',
          metin: [
            'Kur\'an, "Sahil kasabası halkına sor" (A\'râf 163) diyerek bir topluluğu hatırlatır: İsrailoğulları\'ndan bir kasaba halkına, cumartesi günü avlanmaları yasaklanmıştı. O gün balıklar suyun yüzüne çıkar, diğer günler onlara görünmezlerdi. Hileye sapıp bahaneyle yasağı deldiler.',
            'Allah onlara: "Söz verdiğiniz günü çiğnediğiniz için maymun olun" buyurdu. Maymuna dönüştürüldüler (A\'râf 164-166). Aralarından bir grup: "Niye nasihat ediyorsunuz? Allah onları helak edecek" dediğinde, başkaları: "Rabbinize özür olarak" (davet görevini bırakmamak için) dediler.',
            'Kıssa, helalin-haramın sınırlarını "hile ve kılıf" ile aşmaya çalışanlara dönüştürülmek suretiyle verilen cezayı anlatır: dönüşüm, sadece beden değil; gönüllerin sapmasıdır.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'وَلَقَدْ عَلِمْتُمُ الَّذِينَ اعْتَدَوْا مِنكُمْ فِي السَّبْتِ فَقُلْنَا لَهُمْ كُونُوا قِرَدَةً خَاسِئِينَ',
              meal:
                  'İçinizden cumartesi yasağını çiğneyenleri bilirsiniz; onlara "aşağılık maymunlar olun" dedik.',
              kaynak: 'Bakara Suresi, 65. Ayet',
            ),
          ],
          hikmetler: [
            'Haramı hile ile delmek, onu haram olmaktan çıkarmaz; niyet, görünüşü kurtarmaz.',
            'Kanun ve ahlak, kılıflarla aldatılmaz; "bahaneler" sadece vicdanı susturur.',
            'Zulme sessiz kalmayanlarla, susanların akıbeti farklıdır: hesap gününde konuşanlar kazandı.',
          ],
          akademikNotlar: [
            'Kıssa A\'râf 163-166 ve Bakara 65-66. ayetlerde anlatılır; kasabanın Eyle (Akabe kıyısı) bölgesi olduğu rivayet edilir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Ashâb-ı Sebt nasıl cezalandırıldı?',
              secenekler: [
                'Taş yağmuruna tutuldular',
                'Maymuna dönüştürüldüler',
                'Sürgüne gönderildiler',
                'Helak edildiler',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-karye',
          baslik: 'Ashâb-ı Karye (Karye Halkı)',
          ozet:
              'Üç elçiye karşı çıkan şehir halkı ve şehrin en uzak yerinden koşarak gelen imanlı adam.',
          emoji: '🏙️',
          kategoriId: 'ibret',
          temalar: ['Sadakat', 'Cesaret'],
          donem: 'İmtihan Kıssaları',
          metin: [
            'Kur\'an: "Onlara, o şehir halkını örnek ver" (Yâsîn 13) diyerek, kendilerine gönderilen elçileri yalanlayan bir halkı anlatır. İki elçi gelmiş; yalanlanınca üçüncüyle desteklenmişti. Elçiler: "Biz size gönderilmiş elçileriz" dediler; halk: "Siz de bizim gibi insandan başka bir şey değilsiniz" dedi.',
            'Şehrin en uzak yerinden bir adam koşarak geldi: "Ey kavmim! Elçilere uyun. Sizden hiçbir ücret istemeyen, doğru yolda olanlara uyun. Bana ibadet eden ve benim gibi yaratana ne oluyor ki O\'na kulluk etmeyeyim?" (Yâsîn 20-22) dedi.',
            'Adam, kavmi tarafından öldürüldü; Allah ona: "Cennete gir!" buyurdu. O: "Keşke kavmim, Rabbimin beni bağışladığını ve beni ikram edilenlerden kıldığını bilseydi!" dedi. (Yâsîn 26-27) İmanlı adam, kurtuluşun örneği oldu; şehir halkı ise azapla helak edildi.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'يَا لَيْتَ قَوْمِي يَعْلَمُونَ بِمَا غَفَرَ لِي رَبِّي وَجَعَلَنِي مِنَ الْمُكْرَمِينَ',
              meal:
                  'Keşke kavmim, Rabbimin beni bağışladığını ve beni ikram edilenlerden kıldığını bilseydi!',
              kaynak: 'Yâsîn Suresi, 26-27. Ayetler',
            ),
          ],
          hikmetler: [
            'Doğruyu söylemek, sonucu ne olursa olsun kurtuluş vesilesidir.',
            'İmanlı bir kişinin şehadeti, davayı zayıflatmaz; aksine davanın canlı şahidi olur.',
            'Davete muhatap olanlar; "elçi bizim gibi insan" diyerek daveti reddedemezler.',
          ],
          akademikNotlar: [
            'Kıssa Yâsîn 13-27. ayetlerde geçer; kasabanın Antakya, elçilerin ise Havârîler dönemine atfedildiği rivayetler vardır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Ashâb-ı Karye kıssasında şehre kaç elçi gönderildi?',
              secenekler: ['1', '2', '3', '4'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-irem',
          baslik: 'İrem Şehri ve Âd\'ın Helaki',
          ozet:
              'Yüksek köşkleri ve bahçeleriyle ünlü İrem\'in yok oluşu: görünür güç, koruyamaz.',
          emoji: '🏜️',
          kategoriId: 'ibret',
          temalar: ['Ahlak', 'Adalet', 'Tevekkül'],
          donem: 'Helak Kıssaları',
          metin: [
            'Kur\'an, "İrem\'in zengin şehri" (bir görüşe göre sütunlarla bezeli İrem) hakkında şöyle der: "Rabbinin, Âd kavmine ne yaptığını görmedin mi? Sütunlu İrem\'e ki, odalarının ve şehirlerinin eşsiz yapısı, beldeler içinde görülmemiş bir örnekti." (Fecr 6-8)',
            'Âd kavmi, yüksek köşkler inşa etmiş; refah ve güçle şımararak Hûd (a.s.)\'ı yalanlamıştı. Hûd onlara: "Yüksek yerlerde her geçen köşk (kule) mi yapıyorsunuz? Sonsuza kadar yaşayacağınızı mı sanıyorsunuz?" (Şuarâ 129) dedi.',
            'Kavim azıttı; yedi gece sekiz gün süren kasırga rüzgârla helak edildi. "Yüksek binalar yapan Âd kavmine de (azap inmişti)." (Fecr 6-8) İrem\'in bahçeleri ve kuleleri, iman olmadan hiçbir şeyi koruyamadı.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'أَلَمْ تَرَ كَيْفَ فَعَلَ رَبُّكَ بِعَادٍ ۝ إِرَمَ ذَاتِ الْعِمَادِ',
              meal:
                  'Rabbinin Âd kavmine, sütunlarla (yüksek binalarla) dolu İrem\'e ne yaptığını görmedin mi?',
              kaynak: 'Fecr Suresi, 6-7. Ayetler',
            ),
          ],
          hikmetler: [
            'Maddi şehirler ve mimari zaferler, manevi çöküntüyü örtemez.',
            'Şımarma ve azgınlık, toplumların sonunu hazırlayan başlıca amildir.',
            'Hûd (a.s.)\'ın daveti gibi; güce rağmen hak üzere konuşmaktan çekinmemek gerekir.',
          ],
          akademikNotlar: [
            'İrem\'in tarihsel konumu (Hadramut, Umman) tartışmalıdır; bazı araştırmacılar Ubar (Yemen) kalıntılarıyla ilişkilendirir.',
            'Fecr 6-8, Âd kavminin maddi gelişmişliğini ve ilahi cezayı birlikte anlatır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'İrem şehri hangi kavme aitti?',
              secenekler: ['Semûd', 'Âd', 'Medyen', 'Lût kavmi'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-lokman',
          baslik: 'Hz. Lokman (a.s.)',
          ozet:
              'Hikmet sahibi babanın oğluna vasiyeti: tevhid, anne-baba hakkı ve güzel ahlak.',
          emoji: '📿',
          kategoriId: 'ibret',
          temalar: ['Ahlak', 'İlim', 'Adalet'],
          donem: 'Hikmet Kıssaları',
          metin: [
            'Kur\'an, Lokman hakkında: "Andolsun, Lokman\'a hikmeti verdik: Allah\'a şükret..." (Lokman 12) buyurur. Onun hikmeti, sözlerinde ve oğluna yaptığı nasihatlerde görünür.',
            'Lokman oğluna şöyle dedi: "Yavrucuğum! Allah\'a ortak koşma! Şüphesiz şirk büyük bir zulümdür. İnsana anne-babasına iyilik etmesini emrettik; anası onu zayıflık üstüne zayıflıkla taşımıştır... Yavrucuğum! Yaptığın şey bir hardal tanesi ağırlığında olsa bile, ister bir kayanın içinde, ister göklerde, ister yerin dibinde olsun, Allah onu getirir..." (Lokman 13-16)',
            'Nasihatlerinin özü: namazı kıl, iyiliği emret, kötülükten vazgeçir, başına gelene sabret; insanlara yüzünü burma (kibirlenme), yeryüzünde böbürlenerek yürüme; yürüyüşünde ölçülü ol, sesini alçalt, çünkü seslerin en çirkini eşeklerin sesidir. (Lokman 17-19)',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'يَا بُنَيَّ لَا تُشْرِكْ بِاللَّهِ ۖ إِنَّ الشِّرْكَ لَظُلْمٌ عَظِيمٌ',
              meal:
                  'Yavrucuğum! Allah\'a ortak koşma; doğrusu şirk, büyük bir zulümdür.',
              kaynak: 'Lokman Suresi, 13. Ayet',
            ),
          ],
          hikmetler: [
            'Ebeveyn nasihati, çocuğa en değerli mirastır; tevhid, ilk ders; ahlak, sonraki.',
            'Anne hakkı, hamilelik fedakârlığıyla tarif edilir; şükür, üstün emirdir.',
            'Hardal tanesi kadar bile olsa, her amel Allah\'ın terazisindedir.',
          ],
          akademikNotlar: [
            'Lokman\'ın peygamber mi yoksa hikmet sahibi bir kul mu olduğu tefsirlerde tartışılmıştır; cumhur, hikmet sahibi salih bir kul olduğu görüşündedir.',
            'Nasihatler Lokman Suresi 12-19. ayetlerde yer alır ve İslam ahlakının özeti sayılır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Lokman oğluna ilk olarak neyi öğütledi?',
              secenekler: [
                'Zenginliği',
                'Allah\'a ortak koşmamayı',
                'Savaşmayı',
                'Ticaret yapmayı',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-zulkarneyn',
          baslik: 'Hz. Zülkarneyn (a.s.)',
          ozet:
              'Doğuya batıya yolculuk eden, güneşin battığı yerde adaletle hükmeden ve Ye\'cüc-Me\'cüc seddini kuran hükümdar.',
          emoji: '🗺️',
          kategoriId: 'ibret',
          temalar: ['Adalet', 'İlim', 'Tevekkül'],
          donem: 'Hükümdar Kıssaları',
          metin: [
            'Kur\'an, "Sana Zülkarneyn\'den sorarlar; de ki: Onun haberini size anlatacağım" (Kehf 83) buyurur. Zülkarneyn\'e yeryüzünde güç ve sebeplere erişme imkânı verilmişti; yeryüzünü adaletle dolaştı.',
            'Batıya doğru gitti, güneşin battığı yerde (batı ufku) bir topluluğa ulaştı; "Zalimiz, ona ceza veririz; hakkında hayırlısıyla yaşayanı da ödüllendiririz" dedi. Sonra doğuya yöneldi; güneşin doğduğu yerde, güneşten korunması olmayan bir halk buldu. Sonra iki dağ arasındaki bir vadiye (geçide) ulaştı; orada, aralarındaki geçitten Ye\'cüc ve Me\'cüc\'ün taşkınlık yaptığı bir kavimle karşılaştı.',
            'Onlar: "Bize karşılık (ücret) karşılığında, bu geçide bir sed (set) yapar mısın?" dedi. Zülkarneyn: "Rabbimin verdiği güç daha hayırlıdır; bana demir getirin" dedi. Demir ve bakır (asf) ile iki dağı birleştiren bir set ördü: "Bu, Rabbimin rahmetindendir; Rabbimin vaadi gelince onu dümdüz eder." (Kehf 98)',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'قَالُوا يَا ذَا الْقَرْنَيْنِ إِنَّ يَأْجُوجَ وَمَأْجُوجَ مُفْسِدُونَ فِي الْأَرْضِ',
              meal:
                  'Onlar: Ey Zülkarneyn! Doğrusu Ye\'cüc ve Me\'cüc yeryüzünde bozgunculuk yapıyorlar. Bize karşılığında bir set yapman için sana vergi verelim mi? dediler.',
              kaynak: 'Kehf Suresi, 94. Ayet',
            ),
          ],
          hikmetler: [
            'Güç, adalet ve şükürle kullanılır; Zülkarneyn hem kral hem âbiddir.',
            'Toplumlar, bozgunculuğa karşı kendilerini koruyan adil bir yapıya muhtaçtır (set).',
            'Her güç geçicidir: "Rabbimin vaadi gelince onu dümdüz eder" — yalnız Allah\'ın kudreti bâkidir.',
          ],
          akademikNotlar: [
            'Zülkarneyn\'in tarihsel kimliği (Büyük İskender, Koreş vb.) tefsirlerde tartışılmış; kıssa Kehf Suresi 83-98. ayetlerde anlatılır.',
            'Set; iki dağ arasındaki geçitten Ye\'cüc-Me\'cüc\'ün çıkışı, kıyamet alametleriyle ilişkilendirilir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Zülkarneyn hangi topluluğa set yaptı?',
              secenekler: [
                'Âd kavmine',
                'Ye\'cüc ve Me\'cüc\'ün bozgunculuğuna karşı',
                'Semûd kavmine',
                'Kureyş\'e',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'ibret-talut-calut',
          baslik: 'Talut ve Calut',
          ozet:
              'İsrailoğulları\'nın kral talebi, küçük su birikintisi imtihanı ve Davud\'un sapan taşı.',
          emoji: '🛡️',
          kategoriId: 'ibret',
          temalar: ['Cesaret', 'Tevekkül', 'Adalet'],
          donem: 'İsrailoğulları Kıssaları',
          metin: [
            'Mûsâ\'dan sonra İsrailoğulları, kendi aralarından bir kral gönderilmesini istediler: "Bize kral gönder de Allah yolunda savaşalım." Allah, onlara Talut\'u kral olarak seçti. Kavmi itiraz etti: "O, zengin ve soylu değil; niye o?" Allah: "Talut\'u sizin üzerinize seçti; ilim ve beden gücüyle onu artırdı" buyurdu. (Bakara 246-247)',
            'Talut\'un ordusuna imtihan verildi: "Bir ırmağın suyundan içmeyin; ancak avucuyla bir avuç (içen içsin)." Ordunun çoğu suyu doyasıya içti; az bir grup (bir rivayete göre 313 kişi) emre uydu. Ordunun önünde Calut (Golyat) ve ordusu vardı; azınlık: "Kaç kez azınlık, Allah\'ın izniyle çokluğu yenmiştir!" (Bakara 249) dedi.',
            'Genç Davud, sapan taşıyla Calut\'u yere serdi; Allah ona hükümranlık ve hikmet verdi. "Allah, insanların bir kısmını diğerleriyle defetmeseydi, yeryüzü bozulurdu." (Bakara 251) — bir sapan taşı, tarihin akışını değiştirdi.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'كَم مِّن فِئَةٍ قَلِيلَةٍ غَلَبَتْ فِئَةً كَثِيرَةً بِإِذْنِ اللَّهِ',
              meal:
                  'Nice küçük topluluklar, Allah\'ın izniyle çok büyük toplulukları yenmiştir.',
              kaynak: 'Bakara Suresi, 249. Ayet',
            ),
          ],
          hikmetler: [
            'Liderlik, soy ve servetle değil; ilim, güç ve emanetle kazanılır.',
            'İmtihan büyük işlerin kapısıdır: az ama sadık topluluk, çok ama itaatsiz güruhu yener.',
            'Davud örneği, gençlik ve imanın birlikte neler başaracağını gösterir.',
          ],
          akademikNotlar: [
            'Kıssa Bakara 246-251. ayetlerde anlatılır; Talut\'un kimliği konusunda tefsirlerde "Saul" (Tâlût) ile özdeşleştirme yaygındır.',
            'Davud\'un Calut\'u öldürmesi, Bakara 251. ayette zikredilir; Davud\'a verilen hükümranlık ve hikmet aynı ayetin devamındadır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Talut\'un ordusu hangi imtihanla sınandı?',
              secenekler: [
                'Açlık imtihanı ile',
                'Irmaktan yalnız bir avuç su içebilme imtihanı ile',
                'Gece yürüyüşü ile',
                'Silah bırakma ile',
              ],
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
            'Miras olarak getirdiği malını "çoluk çocuğuma yetecek kadar helal kazancım mühimdir" dedi. Resûlullah (s.a.v.)\'in, "Ebû Bekir\'in malı bana ne kadar fayda verdi!" buyurduğu rivayet edilir.',
            'Vefatına kadar infakta, adalette ve sünnete bağlılıkta örnek oldu. "Sıddîk" (doğrulayan) lakabı, İsrâ ve Miraç\'ı ilk tasdik eden kişi olmasından gelir.',
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
            'Vefatından sonra dahi onun içtihatları Müslümanların ilim mirasına kaynaklık etti. "Din, dörtte birini kadınlardan öğrendi" sözü, onun ilimdeki yerinin göstergesidir.',
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
            'Hz. Bilâl, Mekke\'de müşriklerin kölesiydi. İslam\'la şereflendiğinde Ümeyye bin Halef gibi zalimler onu güneş altında, kızgın kumların üzerinde işkenceyle "Muhammed\'i inkâr et" dedikçe o, "Ehad, Ehad!" (Allah birdir) diye direndi.',
            'Hz. Ebû Bekir, onu satın alarak azat etti. Buna rağmen müşrikler işkenceye devam edince, Resûlullah (s.a.v.) tarafından övülerek "Bilâl\'in ayak seslerini cennette işitiyorum" müjdesi verildi.',
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
            'İlmine rağmen ticareti bırakmadı; kazandığının büyük bölümünü talebelerine ve ihtiyaç sahiplerine harcadı. "İlim talebesi, kendini sıkıntıya atar" sözü, onun ilim ehline meşakkati göze alma tembihini yansıtır.',
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
            'Gönlü aşkla yoğrulduktan sonra ilmi, "gönül ilmine" dönüştürdü. Mesnevî\'sinde insanı "biz"leştirmeye, gönlü birleştirmeye davet etti. "Ne olursan ol yine gel" anlayışı, onun rahmete ve umuda açılışını anlatır.',
            'İnsanlara, canlılara ve tüm varlığa şefkatle yaklaştı. Ölümü, "Şeb-i Arûs" (düğün gecesi) olarak anılır; onun için ölüm, Hakk\'a kavuşma vuslatıydı.',
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
              'Türkçe\'nin ve gönlün âşığı: "Yaratılanı severiz, Yaradan\'dan ötürü."',
          emoji: '🕊️',
          kategoriId: 'ibret',
          temalar: ['Merhamet', 'Ahlak', 'Sabır'],
          donem: 'Anadolu Selçuklu',
          metin: [
            'Yunus Emre, Anadolu\'da yetişen büyük bir gönül eridir. Halkın anlayacağı Türkçe ile imanı, ahlakı ve aşkı anlattı. Şeriat, tarikat ve hakikat ilimlerini; hepsini aşkla buluşturdu.',
            'Onun şiirlerinde insan sevgisi, Yaratıcı sevgisinin bir parçasıdır. "Yunus\'un gönlü dolu, birliğe ulaştı" beyti, gönlün imanla yoğrulmasının göstergesidir.',
            'İster âlim olsun ister avam; herkese "gel" diyebildi. Onun dili, halkı irşat etmenin ve ilahi aşkı sadeleştirmenin örneğidir.',
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
