// ===========================================================================
// SİYER-İ NEBÎ - HZ. MUHAMMED (s.a.v.)'İN HAYATI
// Evreler: Mekke Dönemi, Medine Dönemi, Gazveler ve Seriyyeler,
// Veda Dönemi ve Vefatı, Şemail-i Şerif.
// Kaynak esasları: M. Âsım Köksal "İslam Tarihi", Kadı Iyaz "Şifa-i Şerif",
// İbn Hişâm "Sîre", Diyanet İşleri Başkanlığı siyer külliyatı.
// ===========================================================================

import 'kissalar_verileri.dart';

final KissaKategori siyerKategorisi = KissaKategori(
  id: 'siyer',
  ad: 'Siyer-i Nebî',
  altBaslik:
      'Hz. Muhammed (s.a.v.)\'in hayatı: Mekke ve Medine dönemi, gazveler, veda ve şemail',
  emoji: '🕋',
  renkHex: '#4FC3C9',
  renkAkcentHex: '#F2C14E',
  gruplar: [
    // ============================== MEKKE DÖNEMİ ==============================
    KissaGrubu(
      ad: 'Mekke Dönemi',
      aciklama: 'Doğumdan hicrete: 53 yıllık Mekke hayatı',
      kisalar: [
        const KissaKaydi(
          id: 'siyer-dogum',
          baslik: 'Doğumu ve Gençliği',
          ozet:
              'Fil yılında dünyaya gelen yetim bir çocuğun, güvenilir bir genç olma yolculuğu.',
          emoji: '🌙',
          kategoriId: 'siyer',
          temalar: ['Ahlak', 'Tevekkül', 'Sabır'],
          donem: 'Mekke Dönemi',
          metin: [
            'Hz. Muhammed (s.a.v.), Fil Vakası yılında (571) Mekke\'de doğdu. Babası Abdullah, o daha doğmadan vefat etmişti. Annesi Âmine, onu sütannesi Halîme\'ye verdi; çölün tertemiz havasında büyüyen çocuğun dili en fasih, kalbi en temiz örnek haline geldi.',
            'Altı yaşında annesini, sekiz yaşında dedesi Abdülmuttalib\'i kaybetti; amcası Ebû Tâlib\'in himayesine girdi. Küçük yaştan itibaren deve güderek kazanmaya katkı verdi; 25 yaşına kadar ticaret kervanlarına katıldı ve dürüstlüğüyle "el-Emîn" (güvenilir) lakabını kazandı. Cahiliye adetlerinden uzak durdu; içki içmedi, putlara tapmadı, doğru ve iffetli bir hayat yaşadı.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَإِنَّكَ لَعَلَىٰ خُلُقٍ عَظِيمٍ',
              meal: 'Ve şüphesiz sen büyük bir ahlak üzeresin.',
              kaynak: 'Kalem Suresi, 4. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Ben güzel ahlâkı tamamlamak üzere gönderildim. (Buhârî, Edeb 273; Muvatta)',
              kaynak: 'Buhârî, Edeb',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '571 (Fil yılı)', olay: 'Mekke\'de dünyaya geldi'),
            KronolojiMadde(tarih: '577', olay: 'Annesi Âmine vefat etti'),
            KronolojiMadde(tarih: '579', olay: 'Dedesi Abdülmuttalib vefat etti; Ebû Tâlib\'in himayesine girdi'),
            KronolojiMadde(tarih: '595', olay: 'Hz. Hatice ile evlendi'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Mekke',
              aciklama:
                  'Kâbe\'nin bulunduğu ticaret ve hac merkezi; Peygamberimiz burada doğdu ve 53 yıl yaşadı.',
              enlem: 21.4225,
              boylam: 39.8262,
            ),
            CografyaNokta(
              yer: 'Bediye (Benî Sa\'d yurdu)',
              aciklama:
                  'Sütannesinin yaşadığı çöl bölgesi; çocukluğunun ilk yılları burada geçti.',
            ),
          ],
          hikmetler: [
            'Yetimlik ve yoksulluk engel değil; Allah\'ın bir tezkiye (arındırma) vesilesidir.',
            '"El-Emîn" olmak, toplumda kazanılan en kıymetli sermayedir; güven olmadan davet olmaz.',
            'Zor şartlar altında da doğruluktan taviz verilmez; erdem imtihan ortamında görülür.',
          ],
          akademikNotlar: [
            'Fil Vakası, Kâbe\'ye saldıran Ebrehe ordusunun helakini anlatır (Fîl Suresi).',
            'Doğum tarihi için 570-571 tartışması vardır; ekser siyer kaynakları Fil Yılı\'nı esas alır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Peygamberimiz peygamberlikten önce hangi lakabı almıştı?',
              secenekler: ['el-Emîn', 'es-Sıddîk', 'el-Fârûk', 'Ebû\'l-Hakem'],
              dogruIndex: 0,
            ),
            QuizSoru(
              soru: 'Dedesi Abdülmuttalib vefat edince Peygamberimizi kim himayesine aldı?',
              secenekler: ['Halid b. Velid', 'Amcası Ebû Tâlib', 'Dayısı Ebû Leheb', 'Dedesi Ebû Bekir'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-hilfulfudul',
          baslik: 'Hilfü\'l-Fudûl ve Kâbe Hakemliği',
          ozet:
              'Zulme karşı kurulan adalet ittifakı ve Hacerü\'l-Esved krizinde verilen hakemlik kararı.',
          emoji: '⚖️',
          kategoriId: 'siyer',
          temalar: ['Adalet', 'Ahlak'],
          donem: 'Mekke Dönemi',
          metin: [
            'Mekke\'de kervanlarla gelen yabancı tüccarlara zulmediliyor; mallar gaspediliyor, hak sahibi hakkından oluyordu. Bu zulme karşı fazilet sahibi kabileler bir sözleşme yaptı: "Mekke\'de haksızlığa uğrayan herkese, Kureyş\'ten olsun olmasın, hakkı geri alınıncaya kadar yardım edeceğiz." Peygamberimiz bu ittifakla daima övündü: "Kızıl develerim olması pahasına ondan vazgeçmem. Bugün İslâm\'a dahi o andlaşma gibi birine çağrılsam icabet ederim."',
            '35 yaşlarında Kâbe yeniden inşa edilirken Hacerü\'l-Esved\'in yerine konulmasında kabileler çekişti; kavga kan dökülme noktasına geldi. Peygamberimiz taşı bir kumaşa koyup kabilelerin birlikte kaldırmasını sağladı, taşı yerine kendisi yerleştirdi. Bu hakemlik, toplum nezdindeki itibarını zirveye taşıdı.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'يَا أَيُّهَا الَّذِينَ آمَنُوا كُونُوا قَوَّامِينَ بِالْقِسْطِ شُهَدَاءَ لِلَّهِ',
              meal:
                  'Ey iman edenler! Adaleti titizlikle ayakta tutan, Allah için şahitlik eden kimseler olun.',
              kaynak: 'Nisâ Suresi, 135. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Haksızlığa uğrayan mazlûmun duasından sakının. Çünkü o dua ile Allah arasında perde yoktur. (Buhârî, Mezâlim 9)',
              kaynak: 'Buhârî, Mezâlim',
            ),
          ],
          hikmetler: [
            'Zulüm nereden gelirse gelsin, mazlumun yanında olmak imanın gereğidir.',
            'Adalet hizmeti insanı şereflendirir; bu sözleşme ile İslâm\'dan sonra da övünülmüştür.',
            'Kriz anlarında çözüm, hakkaniyetli ve yaratıcı teklifte saklıdır.',
          ],
          akademikNotlar: [
            'Hilfü\'l-Fudûl adı, ittifaka katılan Fudûl kabilelerinden gelir.',
            'Kâbe hakemliği olayı, Peygamberimizin tebliğden önce de toplum önderi olduğunu gösteren meşhur rivayettir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hilfü\'l-Fudûl ittifakının amacı neydi?',
              secenekler: [
                'Ticaret yollarını tekelleştirmek',
                'Mekke\'de haksızlığa uğrayan herkese hakkını almak için yardım etmek',
                'Kâbe\'yi yeniden inşa etmek',
                'Kureyş\'i içki ve kumardan vazgeçirmek',
              ],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Hacerü\'l-Esved krizinde Peygamberimiz hangi yöntemi önerdi?',
              secenekler: [
                'Kurayla karar verilmesini',
                'Taşın kumaş üzerinde kabilelerce birlikte kaldırılmasını',
                'Taşı en yaşlı kişinin koymasını',
                'Taşın yerinin değiştirilmemesini',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-ilkvahiy',
          baslik: 'İlk Vahiy: Hira\'daki Gece',
          ozet:
              'Hira Mağarası\'nda gelen "Oku!" emri ve vahyin ağırlığıyla başlayan yeni çağ.',
          emoji: '💡',
          kategoriId: 'siyer',
          temalar: ['Cesaret', 'İlim', 'Sabır'],
          donem: 'Mekke Dönemi',
          metin: [
            'Peygamberimiz 40 yaşına yaklaştığında Mekke\'nin yukarısındaki Hira mağarasına çekilir, günlerce tefekkür ederdi. Toplumun putperestliği, kız çocuklarının diri diri gömülmesi ve ahlaki çöküşü onu derinden rahatsız ediyordu. Bu inziva ilahi bir hazırlıktı.',
            'Ramazan\'ın bir gecesi (Kadir Gecesi) Cebrail (a.s.) gelerek "İkra\'!" (Oku!) dedi. "Ben okuma bilmem" deyince melek onu kucaklayıp sıktı ve tekrar "Oku!" dedi. Üçüncü tekrarda "Yaratan Rabbinin adıyla oku! O, insanı alaktan yarattı..." (Alak 1-3) ayetleri indi.',
            'Vahyin ilk ağırlığını taşıyan Peygamberimiz titreyerek eve döndü: "Beni örtün, beni örtün!" dedi. Hz. Hatice onu teselli etti; amcasının oğlu Varaka b. Nevfel gelenin "Nâmûs-i Ekber" (Cebrail) olduğunu, kavminin onu yalanlayacağını ve eziyet edeceğini söyledi. Böylece üç yıl sürecek gizli davet devri başladı.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'اقْرَأْ بِاسْمِ رَبِّكَ الَّذِي خَلَقَ ۝ خَلَقَ الْإِنسَانَ مِنْ عَلَقٍ',
              meal:
                  'Yaratan Rabbinin adıyla oku! O, insanı alak (asılı tutunan zigot)tan yarattı.',
              kaynak: 'Alak Suresi, 1-2. Ayetler',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  '"Oku!" dedi. "Ben okuma bilmem" dedim. Melek beni kavrayıp takatimi aşıncaya kadar sıktı, sonra bıraktı ve "Oku!" dedi. (Buhârî, Bed\'ü\'l-vahy 1; Müslim, Îmân 73)',
              kaynak: 'Buhârî, Bed\'ü\'l-vahy',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '610 (40 yaş)', olay: 'Hira\'da ilk vahiy: Alak 1-5'),
            KronolojiMadde(tarih: '610-613', olay: 'Gizli davet dönemi'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Hira Mağarası (Cebel-i Nûr)',
              aciklama:
                  'Mekke\'nin kuzeydoğusunda Nur Dağı\'ndaki mağara; ilk vahyin indiği yer.',
              enlem: 21.4575,
              boylam: 39.8583,
            ),
          ],
          hikmetler: [
            'Hidayet aranınca bulunur; tefekkür ve inziva kalbi vahye hazırlar.',
            '"Oku!" emri İslam\'ın ilk emridir: ilim, imanın başıdır.',
            'Vahyin ağırlığını taşımak büyük bir sorumluluktur; dava sahipleri bu ağırlığa hazır olmalıdır.',
          ],
          akademikNotlar: [
            'İlk vahyin okuma/yazma emriyle başlaması, İslam medeniyetinin temel kodudur.',
            '"Tahannüs" (Hira inzivası), Cahiliye Mekke\'sinde bazılarının tefekkür için dağa çıkma adetiydi (İbn Sa\'d).',
          ],
          quiz: [
            QuizSoru(
              soru: 'İlk inen ayetler hangi surede yer alır?',
              secenekler: ['Fâtiha', 'Alak', 'Müddessir', 'İhlâs'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Cebrail (a.s.) ilk vahiyde Peygamberimizden ne yapmasını istedi?',
              secenekler: ['Namaz kılmasını', 'İnsanları uyarmasını', 'Okumasını', 'Hicret etmesini'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-gizliacikdavet',
          baslik: 'Gizli ve Açık Davet',
          ozet:
              'Safâ Tepesi\'nden başlayan çağrı: "Ey Kureyş! Sabahladınız..." ve yıllar süren eziyetler.',
          emoji: '📣',
          kategoriId: 'siyer',
          temalar: ['Cesaret', 'Sabır', 'Sadakat'],
          donem: 'Mekke Dönemi',
          metin: [
            'Üç yıl süren gizli davette ilk Müslümanlar Hz. Hatice, Hz. Ebû Bekir, Hz. Ali ve Hz. Zeyd oldu. Evlerde yapılan toplantılarla inananların sayısı arttı. Sonra "Sana emrolunanı açıkça duyur ve ortak koşanlardan yüz çevir" (Hicr 94) ayetiyle açık davet emri geldi.',
            'Peygamberimiz Safâ tepesine çıkıp "Ey Kureyş! Size şu dağın ardından bir süvari ordusu geliyor dersem, bana inanır mısınız?" diye sordu. "Evet, senden hiç yalan görmedik" dediler. "Öyleyse size yakın bir azap gelmeden önce işte ben bir uyarıcıyım" dedi. Amcası Ebû Leheb "Yazıklar olsun sana! Bizi bunun için mi topladın?" diye bağırdı. İşte o gün Tebbet Suresi indi.',
            'İman edenlere eziyet günleri başladı: Bilâl kızgın kumlara yatırıldı, Âmir b. Füheyre işkenceden geçirildi, Ammâr\'ın ailesi azap edildi. Hz. Ebû Bekir kölesi Bilâl\'i azad etti; inananlar "erkek köleyi azad eden, kız çocuğunu diri diri toprağa gömen..." (Beled 12-13) ayetinin tecellisiyle bedeller ödediler.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَأَنذِرْ عَشِيرَتَكَ الْأَقْرَبِينَ',
              meal: 'En yakın akrabanı uyar.',
              kaynak: 'Şuarâ Suresi, 214. Ayet',
            ),
            AyetKaydi(
              arapca: 'فَاصْدَعْ بِمَا تُؤْمَرُ وَأَعْرِضْ عَنِ الْمُشْرِكِينَ',
              meal: 'Sana emrolunanı açıkça duyur ve ortak koşanlardan yüz çevir.',
              kaynak: 'Hicr Suresi, 94. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Bu davanın başlangıcı azlık ve eziyetle oldu; nice topluluklar eziyet görerek büyüdü. (İbn Hişâm, Sîre)',
              kaynak: 'İbn Hişâm, Sîre',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '610-613', olay: 'Gizli davet'),
            KronolojiMadde(tarih: '613 sonrası', olay: 'Safâ tepesi çağrısı ve açık davet'),
            KronolojiMadde(tarih: '614', olay: 'Müslümanlara sistematik işkenceler başladı'),
          ],
          hikmetler: [
            'Bir hak dava sabırla yeşerir; açılış acelecilikle değil sebeplere riayetle yapılır.',
            'En yakınların reddi, davetçinin kararlılığını sınar; Ebû Leheb\'in tepkisi daveti durduramadı.',
            'Mazlumların feryadı ve şehitlerin kanıyla kurulan medeniyet, güçle değil inançla ayakta durur.',
          ],
          akademikNotlar: [
            'Safâ çağrısının meşhur rivayeti Buhârî (Tefsir 26/214) ve Müslim\'de geçer.',
            'İlk Müslümanların sayısıyla ilgili rivayetler farklıdır; ekser tarihçiler 40-45 kişilik öncü kitle kabul eder.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Açık davet çağrısı hangi tepede yapıldı?',
              secenekler: ['Cebel-i Nûr', 'Safâ Tepesi', 'Merve Tepesi', 'Arafat'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Peygamberimiz açık davete başlamadan önce kimlere seslendi?',
              secenekler: ['Kabile reislerine', 'Herkese', 'En yakın akrabasına (aşiretine)', 'Sadece kölelere'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-habesistan',
          baslik: 'Habeşistan Hicretleri',
          ozet:
              'İlk Müslümanların Necaşi\'nin adaletli ülkesine göçü ve gönül yakan davet sahnesi.',
          emoji: '✈️',
          kategoriId: 'siyer',
          temalar: ['Sabır', 'Sadakat', 'Cesaret'],
          donem: 'Mekke Dönemi',
          metin: [
            'Müslümanların üzerindeki baskı dayanılmaz hale gelince Peygamberimiz, onları komşu Habeşistan\'a göç etmeye teşvik etti: "Orada, yanında kimseye zulmedilmeyen bir hükümdar vardır." İlk kafile (615) 11 erkek 4 kadındı; aralarında Hz. Osman ve Hz. Rukiyye de vardı. İkinci kafileyle birlikte toplam göç eden sayısı 100\'ü buldu.',
            'Kureyş, kaçakları geri getirmek için Amr b. Âs ve Abdullah b. Ebî Rebîa\'yı değerli hediyelerle Necaşi\'ye gönderdi. Necaşi, Câfer b. Ebî Tâlib\'i huzuruna çağırdı: "İçinizde dininden ayrılan bu topluluk nedir?" Câfer, kısaca İslam\'ı anlattı ve Meryem Suresi\'nden ayetler okudu. Necaşi\'nin gözleri yaşardı: "Bu ile bizim indirdiğimiz arasında fark yok" dedi ve muhacirleri korumayı kabul etti.',
            'Necaşi\'nin İslam\'ı kabul ettiği ve vefatında Peygamberimizin gıyabi cenaze namazı kıldırdığı rivayet edilir. Necm Suresi indiğinde, Habeşistan\'daki muhacirler şöyle dedi: "İslam\'ımızda kendimizi arındırdık; artık dönüyoruz."',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَالَّذِينَ آمَنُوا وَهَاجَرُوا وَجَاهَدُوا فِي سَبِيلِ اللَّهِ',
              meal:
                  'İman edip hicret eden ve Allah yolunda cihad edenler... Allah\'ın rahmetini umarlar.',
              kaynak: 'Bakara Suresi, 218. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Habeşistan\'da yanında kimseye zulmedilmeyen bir hükümdar var; oraya hicret edin. (İbn Hişâm, Sîre)',
              kaynak: 'İbn Hişâm, Sîre',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '615 (5. nübüvvet)', olay: 'İlk Habeşistan hicreti'),
            KronolojiMadde(tarih: '616', olay: 'İkinci kafile; yaklaşık 100 kişi'),
            KronolojiMadde(tarih: '628', olay: 'Muhacirler Medine\'ye döndü'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Habeşistan (Etiyopya)',
              aciklama:
                  'Adil hükümdar Necaşi\'nin yönettiği, muhacirlere kapılarını açan ülke.',
              enlem: 9.145,
              boylam: 40.4897,
            ),
          ],
          hikmetler: [
            'Zulümden kaçmak hicret, adaleti aramak ibadettir.',
            'Mazlumların yanında duran yönetici, tarihte "iyi örnek" olarak yaşar: Necaşi bunun şahididir.',
            'Baskı altında dininden dönme teklifleri, Câfer gibi şahitlerle karşılanır.',
          ],
          akademikNotlar: [
            'Habeşistan hicretleri, İslam tarihinin ilk hicretleridir; Medine hicretinden yaklaşık 7 yıl önce gerçekleşmiştir.',
            'Necaşi Eshame\'nin Müslüman oluşu ve gıyabi cenaze namazı hadis kaynaklarında mevcuttur (Buhârî, Cenâiz).',
          ],
          quiz: [
            QuizSoru(
              soru: 'Habeşistan\'a hicret edenlere kim öncülük etti?',
              secenekler: ['Hz. Ebû Bekir', 'Hz. Câfer b. Ebî Tâlib', 'Hz. Hamza', 'Hz. Ömer'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Necaşi\'nin huzurunda okumuş olan sure hangisidir?',
              secenekler: ['Fâtiha', 'Nâs', 'Meryem', 'İhlâs'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-huzunyili',
          baslik: 'Hüzün Yılı ve Taif Yolculuğu',
          ozet:
              'Hz. Hatice ve Ebû Tâlib\'in vefatı; Taif\'te taşlanan Peygamberin göğe yükselen duası.',
          emoji: '🤲',
          kategoriId: 'siyer',
          temalar: ['Sabır', 'Tevekkül', 'Merhamet'],
          donem: 'Mekke Dönemi',
          metin: [
            'Müslümanların dayanışması için yapılan boykot (Şi\'b-i Ebî Tâlib) sona erdikten kısa süre sonra, peygamberlik yılında iki büyük kayıp geldi: Hz. Hatice ile amcası Ebû Tâlib, 619\'da peş peşe vefat etti. İşkenceler de yoğunlaşınca Peygamberimiz için "Hüzün Yılı" başladı.',
            'Can dayanağı kalmayınca Peygamberimiz Taif\'e gitti; Sakif kabilesine kendisini anlattı ama onlar en inançsız karşılığı verdi. Sokak çocuklarını arkasından taşlattılar. Kanlar içinde kalan Peygamberimiz bir üzüm bağına sığındı ve şöyle dua etti: "Ey Allah\'ım! Aşırılıklarıma veya günahlarıma değil, kuvvetimin zayıflığına ve çaresizliğime rağmen sana şikâyet ederim. Kulların içinde bana merhamet edecek olan sensin. Gazabın bana değilse üzülmem."',
            'Dönüş yolunda cinlerin Kur\'an\'ı dinleyip iman etmesine vesile oldu. Taif\'in kapısı kapanmıştı ama iman eden bir grup hacı, Arap yarımadasında İslam\'ın tohumlarını yayacaktı. Bir yıl sonra İsra ve Miraç\'la, kalbin en derin yaralarına merhem inildi.',
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Ey Allah\'ım! Sana, kuvvetimin zayıflığından, çaresizliğimden ve insanların gözünde küçük düşürülmemden şikâyet ederim. Sen merhametlilerin en merhametlisisin. (Hâkim, Müstedrek)',
              kaynak: 'Hâkim, Müstedrek',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '619', olay: 'Hz. Hatice ve Ebû Tâlib vefatı → Hüzün Yılı'),
            KronolojiMadde(tarih: '619 yazı', olay: 'Taif yolculuğu ve taşlanma'),
            KronolojiMadde(tarih: '620', olay: 'İsra ve Miraç'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Taif',
              aciklama:
                  'Mekke\'nin doğusunda bahçeler diyarı; Sakif kabilesinin yurdu. Peygamberimiz burada taşlandı.',
              enlem: 21.2703,
              boylam: 40.4158,
            ),
          ],
          hikmetler: [
            'İnsanın sığınağı Allah\'tır; en çaresiz anda edilen dua en makbul duadır.',
            'Reddedilmek davayı bitirmez; Taif\'ten dönen Peygamber, dünyanın en büyük medeniyetini kuracaktı.',
            'Hz. Hatice\'ye ve hamisiz kalan dava sahiplerine selam olsun: "Vefasızlık, sabır ile taşınır."',
          ],
          akademikNotlar: [
            'Hüzün Yılı kavramı, M. Âsım Köksal\'ın İslam Tarihi\'nde de ana başlıklardan biridir.',
            'Taif dönüşündeki cin ayetleri (Ahkâf 29-32) tefsirlerde bu hadise ile bağlantılandırılır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hüzün Yılı\'nda vefat eden iki isim kimlerdir?',
              secenekler: [
                'Hz. Hatice ve Ebû Tâlib',
                'Hz. Ebû Bekir ve Hz. Ömer',
                'Varaka ve Ammâr',
                'Hz. Hamza ve Hz. Câfer',
              ],
              dogruIndex: 0,
            ),
            QuizSoru(
              soru: 'Peygamberimiz Taif\'te hangi kabile tarafından taşlandı?',
              secenekler: ['Sakif', 'Evs', 'Hazrec', 'Gatafan'],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-isra-miraj',
          baslik: 'İsra ve Miraç',
          ozet:
              'Mescid-i Haram\'dan Mescid-i Aksa\'ya, oradan "Sidretü\'l-Müntehâ"ya yükseliş ve beş vakit namaz hediyesi.',
          emoji: '🕌',
          kategoriId: 'siyer',
          temalar: ['İman', 'Sabır'],
          donem: 'Mekke Dönemi',
          metin: [
            'Hüzün Yılı\'nın hemen ardından Peygamberimiz, bir gece Mescid-i Haram\'dan Mescid-i Aksa\'ya götürüldü (İsra), oradan da Allah\'ın huzuruna yükseltildi (Miraç). Kur\'an bu geceyi şöyle anlatır: "Ayetlerimizden bir kısmını ona göstermek için kulu bir gece Mescid-i Haram\'dan çevresini mübarek kıldığımız Mescid-i Aksa\'ya götüren Allah\'ın şanı yücedir."',
            'Yolculukta Peygamberimiz süt ve şarap sunuldu, sütü seçti; Cebrail "Fıtratı seçtin" dedi. Önceki peygamberlerle buluştu: Mûsâ ile görüştü, namaz 50 vakte indirildiğinde Mûsâ\'nın tavsiyesiyle 5 vakte kadar azaltıldı. Sidretü\'l-Müntehâ\'da kendisine Bakara\'nın son ayetleri verildi; "cehennemi ve cenneti" gösterildi.',
            'Mekkeliler bu haberle alay etti; Hz. Ebû Bekir ise "O söylüyorsa doğrudur, o sıddîktır" dedi ve "Sıddîk" lakabını pekiştirdi. İsra gecesi, imanın; namaz ise her Müslümanın "miraç" kapısı oldu.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'سُبْحَانَ الَّذِي أَسْرَىٰ بِعَبْدِهِ لَيْلًا مِّنَ الْمَسْجِدِ الْحَرَامِ إِلَى الْمَسْجِدِ الْأَقْصَى',
              meal:
                  'Bir gece kulunu, Mescid-i Haram\'dan çevresini mübarek kıldığımız Mescid-i Aksa\'ya götüren Allah\'ın şanı yücedir.',
              kaynak: 'İsrâ Suresi, 1. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  '"Sidretü\'l-Müntehâ\'da bana iki şey verildi: Bakara\'nın son ayetleri ve ümmetine, Allah\'a hiçbir şeyi ortak koşmayan kimsenin günahlarının affedileceğinin müjdelenmesi." (Müslim, Îmân 279)',
              kaynak: 'Müslim, Îmân',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '620', olay: 'İsra gecesi: Kudüs\'e götürülüş'),
            KronolojiMadde(tarih: 'Aynı gece', olay: 'Miraç: Sidretü\'l-Müntehâ\'ya yükseliş ve namaz farz kılındı'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Mescid-i Aksa (Kudüs)',
              aciklama:
                  'İsrâ gecesinin menzili; çevresi mübarek kılınmış, İslam\'ın ilk kıblesi',
              enlem: 31.7767,
              boylam: 35.2349,
            ),
          ],
          hikmetler: [
            'En karanlık geceden sonra en büyük aydınlık gelir: İsra ve Miraç bunun en büyük delilidir.',
            'Namaz, her gün inen ilahi bir miraçtır; Müslüman onunla arşa yükselir.',
            'Hz. Ebû Bekir gibi, akla garip gelen haberlere yakîn ile yaklaşmak sıddîklıktır.',
          ],
          akademikNotlar: [
            'İsra ve Miraç\'ın bedenle mi ruhla mı olduğu mezhepler arasında tartışılmıştır; cumhur, İsra\'nın bedenen olduğunda birleşmiştir.',
            'Namazın 50 vakit olarak farz kılındığı ve 5\'e indirildiği bilgisi Müslim ve Nesâî rivayetlerinde geçer.',
          ],
          quiz: [
            QuizSoru(
              soru: 'İsrâ gecesi Peygamberimiz nereye götürüldü?',
              secenekler: ['Mescid-i Aksa', 'Mescid-i Nebevî', 'Taif', 'Hira'],
              dogruIndex: 0,
            ),
            QuizSoru(
              soru: 'Miraç\'ta günde kaç vakit namaz farz kılındı?',
              secenekler: ['3', '5', '7', '50'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-akabe',
          baslik: 'Akabe Biatları',
          ozet:
              'Medineli gençlerin Hac mevsiminde kurulan köprü: 12 kişilik Birinci Akabe, 75 kişilik İkinci Akabe.',
          emoji: '🤝',
          kategoriId: 'siyer',
          temalar: ['Sadakat', 'Cesaret'],
          donem: 'Mekke Dönemi',
          metin: [
            'Peygamberimiz her yıl panayırlarda İslam\'a davetini sunuyordu. 620\'de altı Medineli (Hazrecli), Peygamberimizin davetini duyunca onu dinledi ve iman etti. Geri dönünce Medine\'de İslam yayıldı.',
            'Bir yıl sonra 12 Medineli, Akabe\'de Peygamberimizle buluştu: Allah\'a ortak koşmamak, hırsızlık yapmamak, zina işlememek, çocuk öldürmemek ve iftira etmemek üzere biat ettiler. Peygamberimiz onlara Mus\'ab b. Umeyr\'i öğretmen olarak Medine\'ye gönderdi.',
            'İkinci yıl 75 kişilik Medineli topluluğu, savaş dâhil her konuda Peygamberimizi koruyacaklarına dair biat etti. Hz. Abbas\'ın da katıldığı bu biat, hicretin zeminini hazırladı. Medine kapıları İslam\'a açılıyordu.',
          ],
          hikmetler: [
            'Bir şehrin gönlünü kazanmak için kurumlara değil, insanların kalbine hitap etmek gerekir.',
            'Akabe biatları, bir davanın büyümesinde "eğitimci gönderme" (Mus\'ab) stratejisinin önemini gösterir.',
            'Sadakat, sözde değil; zor zamanda korunmak için verilen sözdedir.',
          ],
          akademikNotlar: [
            'Birinci Akabe Biatı "bey\'atü\'n-nisâ" (savaşsız) biat, İkincisi ise "bey\'atü\'l-harb" (savaşlı) biat olarak İbn Hişâm\'da geçer.',
            'Hz. Abbas\'ın, Peygamberimizle birlikte Akabe görüşmelerine katılması ve yeğeni için kefillik alması rivayetleri meşhurdur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'İlk Medineli Müslümanlar hangi kabileye mensuptu?',
              secenekler: ['Sakif', 'Hazrec', 'Gatafan', 'Kurayza'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Medine\'ye öğretmen olarak gönderilen sahabi kimdir?',
              secenekler: ['Mus\'ab b. Umeyr', 'Muâz b. Cebel', 'İbn Mes\'ûd', 'Zeyd b. Sabit'],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-hicret',
          baslik: 'Hicret',
          ozet:
              'Sevr Mağarası\'nda örümcek ağı, yolda sahabî sadakati ve Medine\'nin açılan kolları.',
          emoji: '🐪',
          kategoriId: 'siyer',
          temalar: ['Tevekkül', 'Cesaret', 'Sadakat'],
          donem: 'Medine Dönemi',
          metin: [
            'Yıl 622. Mekke\'nin zulmü zirvede; hicret izni geldi. Peygamberimiz, Hz. Ebû Bekir ile birlikte gece yola çıktı; Sevr Mağarası\'nda üç gece saklandılar. Müşrikler mağaranın ağzına kadar geldi; Hz. Ebû Bekir\'in endişesine Peygamberimiz, "Üzülme! Allah bizimle beraberdir" dedi. (Tevbe 40)',
            'Örümcek ağı ve güvercin yuvaları, mağaranın "boş olduğu" izlenimini vererek izleyicileri geri çevirdi. Yolda rehber Abdullah b. Uraykıt ile kıyı yolunu tuttular. Sürâka b. Mâlik\'in kovalayışında atının ayakları kuma gömüldü; Peygamberimiz ona eman verdi, Sürâka hidayete erdi.',
            'Küba köyünde ilk mescit yapıldı; Medinelilerin "Gel, gel! Ey Allah\'ın elçisi" nidalarıyla karşılanan Peygamberimiz, devesi Kasvâ\'nın çöktüğü yere Mescid-i Nebevî\'nin temelini attı. Hicret, miladı olduğu takvimle birlikte İslam tarihinin yeni başlangıcıdır.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'لَا تَحْزَنْ إِنَّ اللَّهَ مَعَنَا',
              meal: 'Üzülme! Allah bizimle beraberdir.',
              kaynak: 'Tevbe Suresi, 40. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Muhacir, Allah\'ın yasakladıklarını terk edendir. (Buhârî, Îmân 4)',
              kaynak: 'Buhârî, Îmân',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '622, Eylül', olay: 'Mekke\'den ayrılış; Sevr Mağarası\'nda saklanma'),
            KronolojiMadde(tarih: '622, sonbahar', olay: 'Küba\'ya varış, ilk mescit'),
            KronolojiMadde(tarih: '622', olay: 'Mescid-i Nebevî\'nin inşası ve hicri takvimin başlangıcı'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Sevr Mağarası',
              aciklama:
                  'Mekke\'nin güneyinde, hicrette üç gece saklanılan mağara.',
              enlem: 21.3783,
              boylam: 39.8497,
            ),
            CografyaNokta(
              yer: 'Küba',
              aciklama:
                  'Medine\'nin güneyinde ilk durağandı; İslam\'ın ilk mescidi burada yapıldı. "İlk günden takva üzerine kurulan mescit." (Tevbe 108)',
              enlem: 24.4397,
              boylam: 39.6206,
            ),
            CografyaNokta(
              yer: 'Medine (Yesrib)',
              aciklama:
                  'Hicret edilen şehir; Mescid-i Nebevî ve ilk İslam devletinin başkenti.',
              enlem: 24.4672,
              boylam: 39.6111,
            ),
          ],
          hikmetler: [
            'Tevekkül, sebepleri tamamlayıp Allah\'a güvenmektir; Sevr mağarası bunun öğretisidir.',
            'Allah\'ın yardımı, müminin zannedemeyeceği kapılardan gelir: örümcek ve güvercin misali.',
            'Hicret yalnız mekân değişikliği değil; haramları terk ederek günahlardan uzaklaşmaktır.',
          ],
          akademikNotlar: [
            'Hicret takvimi, Hz. Ömer\'in halifeliği döneminde hicri 17. yılda resmîleştirilmiştir.',
            'Küba Mescidi hakkında "İlk günden itibaren takva üzerine kurulan mescit" ayeti (Tevbe 108) indi.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hicrette Peygamberimizle birlikte Saklanan sahabi kimdir?',
              secenekler: ['Hz. Ömer', 'Hz. Ali', 'Hz. Ebû Bekir', 'Hz. Osman'],
              dogruIndex: 2,
            ),
            QuizSoru(
              soru: 'Sevr Mağarası\'nda müşrikleri geri çeviren ilahi işaret neydi?',
              secenekler: [
                'Kar fırtınası',
                'Örümcek ağı ve güvercin yuvası',
                'Kasvâ devesinin durması',
                'Güneş tutulması',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
      ],
    ),
    // ============================== MEDİNE DÖNEMİ ==============================
    KissaGrubu(
      ad: 'Medine Dönemi',
      aciklama: 'Hicretten sonra devletleşme ve kardeşlik yılları',
      kisalar: [
        const KissaKaydi(
          id: 'siyer-mescid-nebevi',
          baslik: 'Mescid-i Nebevî ve Muâhât',
          ozet:
              'Devenin çöktüğü arsaya kurulan İslam\'ın kalbi ve muhacir-ensar kardeşliği.',
          emoji: '🕌',
          kategoriId: 'siyer',
          temalar: ['Merhamet', 'Adalet'],
          donem: 'Medine Dönemi',
          metin: [
            'Peygamberimiz devesi Kasvâ\'nın çöktüğü hurma kurutma yerini Sehl ve Süheyl\'den satın alarak buraya mescit yaptırdı. Müslümanlar inşaatta bizzat çalıştı; taş, kerpiç ve hurma dallarıyla yükselen Mescid-i Nebevî, hem ibadet hem eğitim hem yönetim merkezi oldu: "Suffa" denilen bölümde ilim öğrenen ashab barındı.',
            'Peygamberimiz muhacirleri ensarla "Muâhât" (kardeşlik) ile kardeş ilan etti. Her muhacirin bir ensar kardeşi vardı; ensar malını ve evini paylaştı. Bir rivayete göre ensar, mallarını "bölüşmeyi" teklif etti; muhacirler ise pazarda çalışmayı, hurma bahçesi bakımı karşılığı paylaşımı kabul etti. Hz. Sa\'d b. Rebî\'in Hz. Abdurrahman b. Avf\'a "malımın yarısı senin" demesi bunun en meşhur örneğidir.',
            'Mescid, caminin ötesinde bir medeniyet müessesesi kurdu: orada ilk eğitim, ilk yargı, ilk toplumsal yardımlaşma örgütlendi. "Suffa ehli" Kur\'an ve sünneti kendilerinden sonraki nesle taşıyan neslin öncüleri oldu.',
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Müminler birbirlerine karşı, parçaları birbirini tutan bina gibidirler. Birbirinize merhamet edin! (Buhârî, Edeb 27; Müslim, Birr 66)',
              kaynak: 'Buhârî / Müslim',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '622', olay: 'Mescid-i Nebevî\'nin inşası'),
            KronolojiMadde(tarih: '622-623', olay: 'Muâhât: muhacir-ensar kardeşliği'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Mescid-i Nebevî (Medine)',
              aciklama:
                  'Kasvâ\'nın çöktüğü hurma kurutma yerine kurulan, İslam\'ın kalbi sayılan mescit.',
              enlem: 24.4672,
              boylam: 39.6111,
            ),
          ],
          hikmetler: [
            'İslam, zengin ile yoksulu kardeş kılan tek sistemdir; Muâhât bunun ete kemiğe bürünmüş halidir.',
            'Mescit sadece ibadet yeri değil; ilim, adalet ve yönetim merkezidir.',
            'Aç karnına kurulan devlet, Suffa\'da yetişen alimlerle dünyaya ders oldu.',
          ],
          akademikNotlar: [
            'Muâhât\'ın her bir muhaciri kapsadığı ifade edilse de bazı rivayetlerde "kardeşlik" sadece miras ve yardımlaşma için kurulmuştu; miras kardeşliği sonradan Kur\'an ayetleriyle (Enfâl 75) kaldırıldı.',
            'Suffa ehlinin ilmi faaliyeti, İslam\'ın ilk "açık üniversitesi" olarak değerlendirilir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Mescid-i Nebevî nereye yapıldı?',
              secenekler: [
                'Bir muhacirin evine',
                'Peygamberimizin devesinin çöktüğü hurma kurutma yerine',
                'Küba\'ya',
                'Bir hurma bahçesine ücretsiz olarak',
              ],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Hz. Sa\'d b. Rebî, kardeşi Hz. Abdurrahman b. Avf\'a ne teklif etti?',
              secenekler: [
                'Malının yarısını paylaşmayı',
                'Evini tamamen vermeyi',
                'Kızını nikahlamayı',
                'Onunla birlikte ticarete başlamayı',
              ],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-medine-sozlesmesi',
          baslik: 'Medine Sözleşmesi',
          ozet:
              'Müslümanlar, Yahudiler ve diğer grupları bir arada tutan ilk anayasalaşma belgesi.',
          emoji: '📜',
          kategoriId: 'siyer',
          temalar: ['Adalet', 'Merhamet'],
          donem: 'Medine Dönemi',
          metin: [
            'Peygamberimiz Medine\'ye yerleşince, şehirde yaşayan Müslümanlar (muhacir ve ensar), Yahudi kabileleri (Benî Kaynuka, Benî Nadîr, Benî Kurayza) ve diğer gruplar arasında yazılı bir sözleşme yaptı. Bu belge, tarihte bilinen ilk anayasal belgelerden biri sayılır.',
            'Sözleşmenin maddeleri: Müslümanlar ve Yahudiler bir tek ümmet (cemaat) oluşturur; herkes kendi dininde serbesttir; savaşta ve barışta ortak savunma esastır; hiçbir grup bir diğerinin düşmanıyla iş birliği yapamaz; haksızlık edene karşı mazlumun yanında olunur; anlaşmazlıklar Allah\'ın ve Peygamberinin hakemliğine götürülür.',
            'Sözleşme; din, dil ve kabile farklarını ayrışma değil, "ortak vatan ve ortak hukuk" etrafında birleşme noktasına taşıdı. Fakat Yahudi kabileleri, münafıklık ve ihanetleri sebebiyle sözleşmeye zamanla ihanet etti; Peygamberimiz bunlara karşı hem hakem hem yönetici olarak adil davrandı.',
          ],
          hikmetler: [
            'Farklı inançların barış içinde yaşaması, İslam\'ın bir "ümmet" tasavvurudur; Medine Sözleşmesi bunun belgesidir.',
            'Anlaşmazlıkta hakeme gitmek (hukuka başvurmak), İslami yönetimin ilkelerindendir.',
            'Mazlumun yanında olmak, kim olursa olsun zulme sessiz kalmamaktır.',
          ],
          akademikNotlar: [
            'Medine Sözleşmesi metni İbn İshak\'ın Sîre\'sinde tam olarak nakledilir; İslam hukuk tarihinde "ilk yazılı anayasa" olarak kabul edilir.',
            'Sözleşmede "Müslümanlar bir ümmettir; Yahudiler kendi dinlerinde" ifadesi, din hürriyetini garanti eder.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Medine Sözleşmesi\'ne göre anlaşmazlıklar kime götürülürdü?',
              secenekler: [
                'Kabile reislerine',
                'Allah\'a ve Peygamberine',
                'Yahudi hahamlara',
                'Kureyş\'e',
              ],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Sözleşme hangi toplulukları bir arada tutuyordu?',
              secenekler: [
                'Sadece Müslümanları',
                'Müslümanlar ve Hıristiyanlar',
                'Müslümanlar, Yahudiler ve diğer gruplar',
                'Sadece ensar ve muhaciri',
              ],
              dogruIndex: 2,
            ),
          ],
        ),
      ],
    ),
    // ============================== GAZVELER ==============================
    KissaGrubu(
      ad: 'Gazveler ve Seriyyeler',
      aciklama: 'Bedir\'den Tebük\'e: Sebep, strateji, kronoloji, sonuçlar ve dersler',
      kisalar: [
        const KissaKaydi(
          id: 'siyer-bedir',
          baslik: 'Bedir Gazvesi',
          ozet:
              'Sayıca üç katı düşmana karşı ilk büyük zafer: 313 kişinin imanı, meleklerin yardımı.',
          emoji: '⚔️',
          kategoriId: 'siyer',
          temalar: ['Cesaret', 'Tevekkül'],
          donem: 'Medine Dönemi',
          metin: [
            'Sebep: Hicretle malı Müslümanlara geçmiş olan müşrikler, kervanlarını korumak için saldırı hazırlığındaydı. Peygamberimiz, Suriye\'den dönen Ebû Süfyan kervanı için Bedir\'e doğru yola çıktı. Kervan kaçtı; ancak 950 kişilik Kureyş ordusu savaş için geldi.',
            'Strateji ve kronoloji: Peygamberimiz orduyu kuyuların bulunduğu bölgede konuşlandırdı, kuyuları tahkim etti. Gece Kur\'an okuyarak dua etti: "Ey Allah\'ım! Sana söz verdiğimiz zaferi ver!" Ashap, "Bedir\'e gidiyorsak bineriz binmeyiz ayrılmayız" dedi. 2 Ramazan 2. hicri yıl (624) sabahı savaş başladı; Hz. Ali, Hz. Hamza ve Ubeyde ilk meydan okuyanlar oldu. Allah, meleklerle yardım etti (Enfâl 9).',
            'Sonuçlar: Müşriklerin 70\'i öldürüldü, 70\'i esir alındı; Müslümanlardan 14 şehit oldu. Esirlere iyi muamele edildi, okuma-yazma bilenler 10 Müslümana öğretmek (muallimlik) karşılığında serbest bırakıldı. Bedir, İslam devletinin varlığını kabul ettirdiği ilk büyük zaferdir.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'إِذْ تَسْتَغِيثُونَ رَبَّكُمْ فَاسْتَجَابَ لَكُمْ أَنِّي مُمِدُّكُم بِأَلْفٍ مِّنَ الْمَلَائِكَةِ مُرْدِفِينَ',
              meal:
                  'Siz Rabbinizden yardım istiyordunuz; O, "Size, birbiri ardınca bin melek ile yardım edeceğim" diye karşılık verdi.',
              kaynak: 'Enfâl Suresi, 9. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Bedir\'de bize meleklerle yardım edildi. (Buhârî, Meğâzî 6)',
              kaynak: 'Buhârî, Meğâzî',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '624, Ramazan 17', olay: 'Bedir Savaşı'),
            KronolojiMadde(tarih: 'Savaş sonrası', olay: 'Esirlere iyi muamele ve okuma-yazma öğretme karşılığı serbest bırakma'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Bedir Kuyuları',
              aciklama:
                  'Medine\'nin 150 km güneybatısında, ticaret yolu üzerindeki kuyu bölgesi.',
              enlem: 23.7808,
              boylam: 38.7908,
            ),
          ],
          hikmetler: [
            'Azınlık, iman ve isabetli stratejiyle çokluğa galip gelir.',
            'Zaferden önce gelen şey dua ve istiğfardır; Bedir gecesi bu dersle doludur.',
            'Savaşın akabinde bile eğitim (okuma-yazma) önceliklidir; esîrlere öğretmek özgürlüktür.',
          ],
          akademikNotlar: [
            'Bedir\'e katılan Müslüman sayısı 313-317 arası rivayet edilir; şehit sayısı 14\'tür.',
            'Bedir ehlinin cennet ehli olduğu hadisi (Buhârî, Meğâzî 6) meşhurdur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Bedir\'de Müslümanların sayısı yaklaşık kaçtı?',
              secenekler: ['313', '950', '500', '1000'],
              dogruIndex: 0,
            ),
            QuizSoru(
              soru: 'Bedir esirlerinden okuma-yazma bilenler ne karşılığında serbest bırakıldı?',
              secenekler: [
                'Fidye ödemek',
                '10 Müslümana okuma-yazma öğretmek',
                'Bir daha savaşmayacağına söz vermek',
                'Müslüman olmak',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-uhud',
          baslik: 'Uhud Gazvesi',
          ozet:
              'Okuyucuların emri terk etmesiyle gelen imtihan: "Allah\'ın elçisi öldürüldü" dediler.',
          emoji: '⛰️',
          kategoriId: 'siyer',
          temalar: ['Sabır', 'Sadakat', 'Cesaret'],
          donem: 'Medine Dönemi',
          metin: [
            'Bedir\'in öcünü almak isteyen Kureyş, 3000 kişilik orduyla (700 zırhlı) Medine\'ye yürüdü. Peygamberimiz istişareyle Medine dışında, Uhud dağının eteklerinde savunmayı seçti. 1000 kişilik orduya münafık Abdullah b. Übey\'in 300 adamıyla çekilmesiyle 700 kişi kaldı.',
            'Peygamberimiz, İbn Cübeyr komutasındaki 50 okçuyu "Kuşlar bize saldırsa bile burayı terk etmeyin!" diyerek Ayneyn geçidine yerleştirdi. Savaşın ilk safhası zaferdi; müşrikler dağılmaya başladı. Ancak okçular ganimet toplamak için mevzilerini terk etti; Halid b. Velid\'in süvarileri arkadan saldırdı. Müslümanlar dağıldı, 70 kişi şehit oldu; aralarında Peygamberimizin mübarek dişi kırılan, "Sana mübarek olsun" diyen Hamza da vardı.',
            'Muhammed öldürüldü sözü yayıldı; ancak Peygamberimiz yaralı halde hayattaydı. Hz. Fâtıma babasının yarasını sardı; ashab toparlanarak yeniden saf tuttu ve müşrikler geri çekildi. Allah, okçuların hatalarını ve sabredenlerin mükafatını Âl-i İmrân ayetlerinde anlattı: "Allah\'a ve Peygamberine itaat edin ki size merhamet edilsin.",
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَكَذَٰلِكَ أَرْسَلْنَاكَ فِي أُمَّةٍ قَدْ خَلَتْ مِن قَبْلِهَا أُمَمٌ',
              meal:
                  'Sana açık ayetlerle geldikten sonra, "Biz bu iki topluluktan hangisinin uzuvları sağlam ve hayırlıdır?" diye sorulur. (imtihan ilkesi)',
              kaynak: 'Âl-i İmrân Suresi, 152-154. Ayetler',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Cebrail: "Ümmeti içinde Hamza, Allah\'ın ve Resûlünün ismini en çok taşıyan kişidir. Cennet\'te \"Allah\'ın Arslanı\" diye çağrılır." (Tirmizî)',
              kaynak: 'Tirmizî, Menâkıb',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '625, Şevval', olay: 'Uhud Savaşı'),
            KronolojiMadde(tarih: 'Savaş sonrası', olay: 'Uhud şehitlerinin defni; Hamza\'nın şehadeti'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Uhud Dağı',
              aciklama:
                  'Medine\'nin kuzeyindeki dağ; savaşın yapıldığı bölge. "Uhud, bizi sever, biz de onu severiz." (Buhârî)',
              enlem: 24.5281,
              boylam: 39.6519,
            ),
          ],
          hikmetler: [
            'Emre itaat, zaferin sigortasıdır; okçuların tek hatası büyük bir bedele mal oldu.',
            'Yenilgi ve imtihan, zafer gibi Allah\'ın hikmetinin parçasıdır; mümin işleminin sonucunu sabırla taşır.',
            '"Muhammed öldürüldü" dediler: dava kişilere bağlanmaz; Allah\'ın dini bâkidir.',
            'Hamza misali: dava için canıyla bedel ödeyenler, Allah\'ın arslanı olarak anılır.',
          ],
          akademikNotlar: [
            'Okçuların mevziyi terk etmesi, İslam savaş hukukunda "emre itaat" ilkesinin meşhur örneğidir.',
            'Uhud\'da Peygamberimizin dişinin kırılması ve yüzünün kanaması, siyer kitaplarında geniş yer tutar (İbn Hişâm).',
          ],
          quiz: [
            QuizSoru(
              soru: 'Uhud\'da Ayneyn geçidini kimler tutuyordu?',
              secenekler: ['Süvariler', 'Okçular', 'Münafıklar', 'Kadınlar'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Uhud şehitleri içinde \'Allah\'ın Arslanı\' unvanıyla anılan sahabi kimdir?',
              secenekler: ['Hz. Hamza', 'Hz. Ali', 'Hz. Cafer', 'Hz. Zübeyr'],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-hendek',
          baslik: 'Hendek (Ahzâb) Gazvesi',
          ozet:
              '10 bin kişilik ittifak ordusu, bir hendek ve Selmân-ı Fârisî\'nin stratejik dehası.',
          emoji: '⛏️',
          kategoriId: 'siyer',
          temalar: ['Cesaret', 'Tevekkül', 'Sabır'],
          donem: 'Medine Dönemi',
          metin: [
            'Hendek Savaşı, 627 yılında Kureyş ve müttefik Arap kabileleri ile Hayber Yahudilerinden oluşan 10 bin kişilik ittifak ordusunun Medine\'ye yürümesiyle başladı. Peygamberimiz istişare etti; Selmân-ı Fârisî, Medine\'nin kuzey açığını siper almayı önerdi. Bu strateji, İslam savaş tarihinde ilk kez uygulandı.',
            'Hendek kazılırken ashabının taşıdığı zorluklar devam etti; bir kayanın parçalanmasıyla Peygamberimiz "Bana Şam\'ın, Fars ülkesinin ve Yemen\'in anahtarları verildi" müjdesini aldı. Abluka 15-20 gün sürdü; müşrikler geçemedi. Münafıklar panikledi, bazıları "Evlerimiz savunmasız" dedi; Kur\'an bu imtihanı Ahzâb Suresi\'nde anlatır.',
            'Neticede şiddetli bir fırtına ittifak ordusunu dağıttı; Kurayza Yahudilerinin ihaneti üzerine verilen kararla savaş, tek bir genel çatışma yaşanmadan bertaraf edildi. Hendek, "İslam ordusunun stratejik zaferi" ve "savunma harbinin modeli" olarak tarihe geçti.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَرَدَّ اللَّهُ الَّذِينَ كَفَرُوا بِغَيْظِهِمْ لَمْ يَنَالُوا خَيْرًا',
              meal:
                  'Allah, inkar edenleri öfkeleriyle birlikte hiçbir hayra ulaşamadan geri çevirdi. Müminlere savaşta Allah yetti.',
              kaynak: 'Ahzâb Suresi, 25. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Hendek kazılırken: "Ben, Şam\'ın, Fars\'ın ve Yemen\'in anahtarları verildiğini müjdeliyorum." (Buhârî, Meğâzî 29)',
              kaynak: 'Buhârî, Meğâzî',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '627, Şevval-Zilkade', olay: 'Hendegin kazılması ve abluka'),
            KronolojiMadde(tarih: 'Aynı dönem', olay: 'Kurayza ihaneti ve sonuçları'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Medine (hendek hattı)',
              aciklama:
                  'Medine\'nin kuzeyindeki açığa kazılan hendek; günümüzde "Hendek Camii" bölgesi.',
              enlem: 24.5014,
              boylam: 39.6161,
            ),
          ],
          hikmetler: [
            'İstişare, ilahi ilhamdan önce gelir: hendek fikri Selmân\'ındır, Peygamber onu kabul eder.',
            'Savunma teknolojisi ve strateji, savaşın kaderini değiştirir; akıl imanla birleşirse zafer gelir.',
            'Fırtına ve himaye: Allah\'ın yardımı, en umutsuz anda gelir.',
          ],
          akademikNotlar: [
            'Hendek\'in Selmân-ı Fârisî tarafından önerildiği bütün siyer kaynaklarında geçer; İran savaşlarında bu yöntem kullanılırdı.',
            'Ahzâb Suresi\'nde geçen "örnek imtihan" ifadeleri, bu savaşın müminler açısından muhasebe vesilesi olduğunu gösterir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hendek kazma fikrini ilk öneren sahabi kimdir?',
              secenekler: ['Selmân-ı Fârisî', 'Hz. Ömer', 'Zeyd b. Sabit', 'Mus\'ab b. Umeyr'],
              dogruIndex: 0,
            ),
            QuizSoru(
              soru: 'Hendek Savaşı\'nda Medine\'ye saldıran ordunun büyüklüğü neydi?',
              secenekler: ['3 bin', '5 bin', '10 bin', '20 bin'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-hudeybiye',
          baslik: 'Hudeybiye Antlaşması',
          ozet:
              '"Apaçık fetih" olarak Kur\'an\'da anılan, sahabeye ağır gelen antlaşmanın ardındaki hikmet.',
          emoji: '🕊️',
          kategoriId: 'siyer',
          temalar: ['Sabır', 'Adalet', 'Tevekkül'],
          donem: 'Medine Dönemi',
          metin: [
            '628 yılında Peygamberimiz, 1400 kişiyle umre için Mekke\'ye yöneldi; silahla değil, ihramlarla. Kureyş şehrin kapısını kapatınca Hudeybiye denilen yerde konuşlandı. Görüşmeleri Hz. Osman yürüttü; "Osman\'a biat" (Rıdvan Biatı) yapıldı.',
            'Kureyş\'in elçisi Süheyl b. Amr ile antlaşma yapıldı: 10 yıl savaş yok; Kureyş\'ten Medine\'ye kaçanlar geri verilecek, Müslümanlardan Mekke\'ye dönenler kalmayacak; kabilelerin istediği tarafa katılması serbest; o yıl umre yapılmadan dönülecek, ertesi yıl 3 gün umreye gelinilecek. Peygamberimiz "Bismillâhirrahmânirrahîm" ve "Allah\'ın Resûlü" ifadelerinin çıkarılmasını kabul etti. Ashabın üzüntüsü büyüktü; "Hak ettik mi?" dediler.',
            'Peygamberimiz "Ben Allah\'ın kuluyum ve Resûlüyüm, dediği her şeyde haktır" diyerek imzaladı. Allah, bu antlaşmayı "Fetih" olarak adlandırdı (Fetih 1): çünkü barış, davetin önüne açılan en büyük kapıydı. İki yıl sonra Mekke barış içinde fethedildi.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'إِنَّا فَتَحْنَا لَكَ فَتْحًا مُّبِينًا',
              meal: 'Doğrusu biz sana apaçık bir fetih nasip ettik.',
              kaynak: 'Fetih Suresi, 1. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Rıdvan Biatı\'nda ağacın altında, "Senin rızan için, yol olsun yâ Resûlallah!" dediler. (Buhârî, Hudeybiye)',
              kaynak: 'Buhârî, Meğâzî',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '628, Zilkade', olay: 'Hudeybiye umre yürüyüşü'),
            KronolojiMadde(tarih: 'Aynı günler', olay: 'Rıdvan Biatı ve antlaşma'),
            KronolojiMadde(tarih: '630', olay: 'Barışın meyvesi: Mekke\'nin fethi'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Hudeybiye',
              aciklama:
                  'Mekke\'nin 22 km kuzeybatısındaki bölge; antlaşmanın yapıldığı yer. Günümüzde Şumaysi.',
              enlem: 21.6593,
              boylam: 39.4686,
            ),
          ],
          hikmetler: [
            'Barış, görünen gallebinin en büyük galibi oldu.',
            'Zahirde kayıp gibi görünen antlaşma, batında "apaçık fetih"dir; varf-i halin ötesine bakmak gerekir.',
            'Müzakere, kazanımları ertelese de çatışmayı dönüştürür; İslam stratejisi burada tezahür eder.',
            'Sadakat ve sabır, istikbalin gizli kapılarını açar.',
          ],
          akademikNotlar: [
            'Rıdvan Biatı, Fetih Suresi\'nin 18. ayetiyle anılır; katılanlar Hz. Peygamber\'den "Allah\'a ve Resûlüne karşı gelmeyeceğiz" biatı aldı.',
            'Antlaşmanın maddeleri üzerindeki rivayet farklılıkları, İslam hukukunda "musâlaha" örneklerinin en meşhurudur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hudeybiye Antlaşması\'nı Kur\'an hangi isimle anar?',
              secenekler: ['Zafer', 'Fetih', 'İnşirah', 'Nusret'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Antlaşma kaç yıllık barış getirdi?',
              secenekler: ['5 yıl', '10 yıl', '3 yıl', '1 yıl'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-mekke-fethi',
          baslik: 'Mekke\'nin Fethi',
          ozet:
              '10 bin kişilik ordu, savaşsız giren şehir ve "Size bir zarar yok, gidin, hepiniz serbestsiniz!"',
          emoji: '🏰',
          kategoriId: 'siyer',
          temalar: ['Adalet', 'Merhamet', 'Cesaret'],
          donem: 'Medine Dönemi',
          metin: [
            'Hudeybiye Antlaşması\'nın 10. maddesiyle kabileler katıldı; Kureyş\'in müttefiki Benî Bekir, Müslümanların müttefiki Huzâa\'ya saldırınca antlaşma bozuldu. Peygamberimiz, Kureyş\'e uzlaşma teklif etti; reddedildi. 630 yılının Ramazan ayında, 10 bin kişilik orduyla Mekke\'ye yürüdü.',
            'Yolda amcası Abbas\'ın tavsiyesiyle Ebû Süfyan güvenceye alındı; "Kim Ebû Süfyan\'ın evine girerse güvendedir, kapısını kapayan güvendedir" ilan edildi. Şehre girildiğinde tek taraflı küçük bir çatışma oldu; Peygamberimiz Kâbe\'ye geldi, putları kırdı: "Hak geldi, batıl zail oldu." (İsrâ 81)',
            'Kâbe\'nin kapısında, yıllarca kendisine eziyet edenlere baktı ve sordu: "Size ne yapacağımı düşünürsünüz?" "Sen asil ve cömert bir kardeşsin" dediler. Buyurdu: "Gidin, hepiniz serbestsiniz!" Bu, tarihin en merhametli fethiydi. Şehrin halkı akın akın İslam\'a girdi.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَقُلْ جَاءَ الْحَقُّ وَزَهَقَ الْبَاطِلُ ۚ إِنَّ الْبَاطِلَ كَانَ زَهُوقًا',
              meal: 'Ve de ki: Hak geldi, batıl yok oldu. Şüphesiz batıl, yok olmaya mahkumdur.',
              kaynak: 'İsrâ Suresi, 81. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  '"Bugün size geçmişin cezası yoktur. Gidin, hepiniz serbesttiniz!" (İbn Hişâm, Sîre)',
              kaynak: 'İbn Hişâm, Sîre',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '630, Ramazan', olay: 'Mekke\'nin fethi'),
            KronolojiMadde(tarih: 'Aynı yıl', olay: 'İslam\'a toplu girişler ve Huneyn zorluğu'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Mekke ve Kâbe',
              aciklama:
                  'Fethin kalbi; Kâbe içindeki putların kırıldığı, dünyanın en büyük hac merkezi.',
              enlem: 21.4225,
              boylam: 39.8262,
            ),
          ],
          hikmetler: [
            'Zafer çoğunlukla savaştan değil, gönüllere girerek kazanılır.',
            '"Gidin serbestsiniz!" — af, en büyük vicdan yönetimidir; binlerce gönlü İslâm\'a çevirdi.',
            'Kuvvet, adaleti korumak için gerekli olduğunda kullanılır; asla zulüm için değil.',
          ],
          akademikNotlar: [
            'Fetih tarihi konusunda hicri 8. yılın Ramazan ayı (Ocak 630) kabul edilir.',
            'Peygamberimizin fetih günü Kâbe\'ye elinde asa ile girip putları kırması ve İsrâ 81 ayetini okuması, tefsir ve siyer kaynaklarının ortak rivayetidir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Mekke fethedildiğinde ordu kaç kişiydi?',
              secenekler: ['3 bin', '5 bin', '10 bin', '15 bin'],
              dogruIndex: 2,
            ),
            QuizSoru(
              soru: 'Fetih günü Kâbe\'de Peygamberimiz Mekkelilere ne dedi?',
              secenekler: [
                '"Gidin, hepiniz serbestsiniz"',
                '"Bir daha buraya girmeyin"',
                '"Cezanızı çekeceksiniz"',
                '"Kâbe\'yi terk edin"',
              ],
              dogruIndex: 0,
            ),
          ],
        ),
      ],
    ),
    // ============================== VEDA DÖNEMİ ==============================
    KissaGrubu(
      ad: 'Veda Dönemi ve Vefatı',
      aciklama: 'Veda Haccı, Veda Hutbesi ve son günler',
      kisalar: [
        const KissaKaydi(
          id: 'siyer-veda-hutbesi',
          baslik: 'Veda Haccı ve Veda Hutbesi',
          ozet:
              '"Ey insanlar! Sözümü iyi dinleyin..." İnsan hakları ve ahlak ilkelerinin evrensel bildirgesi.',
          emoji: '🌍',
          kategoriId: 'siyer',
          temalar: ['Adalet', 'Ahlak', 'Merhamet'],
          donem: 'Veda Dönemi',
          metin: [
            '631\'de veda haccı için yola çıktı; 100 binden fazla sahabi ona tabi oldu. Arafat\'ta, öğleden sonra devesi Kasvâ\'nın üzerinde, "Bugün sizin için dininizi tamamladım" ayetinin (Mâide 3) indiği ortamda Veda Hutbesi\'ni okudu.',
            'Veda Hutbesi\'nin maddeleri: kanlarınız ve mallarınız kıyamete kadar korunmuştur; Cahiliye faiz ve kan davaları kaldırılmıştır; kadınların hakları, kocaların hakları hesaba katılacaktır; emanet iade edilecektir; müslüman, müslümanın kardeşidir; Araplık üstünlük değil, takva eşitlik ve üstünlük kaynağıdır. "Arap\'ın Arap olmayana, beyazın siyaha takvadan başka bir üstünlüğü yoktur."',
            'Hutbeyi bitirdiğinde: "Şahit ol yâ Rabbî!" dedi; ashabın "Şahit ol!" nidâsı Arafat\'ı inletti. "Burada olmayanlara ulaştırın" dedi: Söz, yüzyıllara ve kıtalara böyle taşındı.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'الْيَوْمَ أَكْمَلْتُ لَكُمْ دِينَكُمْ وَأَتْمَمْتُ عَلَيْكُمْ نِعْمَتِي',
              meal:
                  'Bugün sizin için dininizi tamamladım, üzerinize nimetimi tamamladım ve sizin için İslam\'ı bir din olarak seçtim.',
              kaynak: 'Mâide Suresi, 3. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Ey insanlar! Rabbiniz birdir, babanız birdir. Arap\'ın Arap olmayana, beyazın siyaha takvadan başka üstünlüğü yoktur. (Müsned-i Ahmed; İbn Hişâm)',
              kaynak: 'Müsned-i Ahmed',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '631, Zilhicce', olay: 'Veda Haccı'),
            KronolojiMadde(tarih: '9 Zilhicce', olay: 'Arafat\'ta Veda Hutbesi'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Arafat',
              aciklama:
                  'Hac\'ın farzı. Veda Hutbesi\'nin okunduğu, rahmet meydanı.',
              enlem: 21.3549,
              boylam: 39.984,
            ),
            CografyaNokta(
              yer: 'Mina ve Müzdelife',
              aciklama:
                  'Veda Haccı\'nın diğer durakları; şeytan taşlama ve vakfe bölgeleri.',
              enlem: 21.413,
              boylam: 39.893,
            ),
          ],
          hikmetler: [
            'Veda Hutbesi, İslam\'ın evrensel insan hakları beyannamesidir; asırlar sonra ilan edilecek evrensel beyannamelerden önce gelir.',
            'Üstünlük takvadadır: ırk, renk ve soya göre ayrımcılık reddedilir.',
            'Din namına da olsa hiçbir söz, ahlak ölçüsünün dışına çıkamaz.',
            'Bildiğini başkasına aktarmak, bir haktır: "Burada olmayana ulaştırın."',
          ],
          akademikNotlar: [
            'Veda Hutbesi metinleri, İbn Hişâm ve Buhârî (Hac 133) rivayetleriyle günümüze ulaştı.',
            '"Din tamamlandı" ayeti, bazı âlimlere göre Kur\'an\'ın en son inen ayetlerindendir; genel kabul ise Bakara 281\'dir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Veda Hutbesi nerede okundu?',
              secenekler: ['Mina', 'Arafat', 'Muzdelife', 'Kâbe'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Veda Hutbesi\'ne göre insanlar arasındaki tek üstünlük ölçüsü nedir?',
              secenekler: ['Soy', 'Zenginlik', 'Takva', 'Yaş'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-vefat',
          baslik: 'Son Günler ve Vefatı',
          ozet:
              'Hastalanan Peygamberin ümmetine son sözleri: "Namaz! Namaz! Sahip olduklarınız..."',
          emoji: '🤲',
          kategoriId: 'siyer',
          temalar: ['Sabır', 'Merhamet', 'İman'],
          donem: 'Veda Dönemi',
          metin: [
            'Hicri 11. yılın Safer ayında Peygamberimiz hastalandı. "Ben, Rabbinim size benden daha hayırlıdır" diyerek aradığı şeyi seçti; günlerce ateşi yükseldi. Hz. Fâtıma\'nın "Babam acı çekti" sözüne "Bugünden sonra baban için hiçbir sıkıntı yok" dedi.',
            'Hastalığı sırasında mescidde namaz kıldırdı, müezzinlerden sonra "Namaz! Sahip olduğunuz içindekiler! (köleler)" diye tembihledi. Hz. Ebû Bekir\'i imamlığa tayin etti; kızı Fâtıma\'nın yanında "Namaz! Namaz! ve sahip olduklarınız..." diyerek adeta vasiyet etti.',
            'Peygamberimiz, Rebiülevvel ayının 12\'sinde (8 Haziran 632) kuşluk vaktinde vefat etti. Hz. Ömer "Öldü diyenin başını vururum" dedi; Hz. Ebû Bekir ise "Kim Muhammed\'e tapıyorsa bilsin ki o ölmüştür. Kim Allah\'a tapıyorsa, Allah diridir, asla ölmez" (Zümer 30) ayetini okudu. Cenazesi Hz. Aişe\'nin odasında defnedildi. Mescid-i Nebevî, onun kabrinin üzerinde bugün de ayakta.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'إِنَّكَ مَيِّتٌ وَإِنَّهُم مَّيِّتُونَ',
              meal: 'Şüphesiz sen öleceksin, onlar da ölecekler.',
              kaynak: 'Zümer Suresi, 30. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Namaz, namaz! Ve sahip olduğunuz köleler... (Ebû Dâvûd, Edeb 182)',
              kaynak: 'Ebû Dâvûd, Edeb',
            ),
          ],
          kronoloji: [
            KronolojiMadde(tarih: '632, Safer', olay: 'Hastalığın başlaması'),
            KronolojiMadde(tarih: '632, 12 Rebiülevvel', olay: 'Hz. Peygamber\'in vefatı (63 yaş)'),
            KronolojiMadde(tarih: '632', olay: 'Hz. Ebû Bekir\'in halife seçilmesi'),
          ],
          cografya: [
            CografyaNokta(
              yer: 'Mescid-i Nebevî (Ravza-i Mutahhara)',
              aciklama:
                  'Peygamberimizin kabrinin bulunduğu, cennet bahçelerinden bir köşe.',
              enlem: 24.4672,
              boylam: 39.6111,
            ),
          ],
          hikmetler: [
            'En büyük davetçi bile dünyadan göçendir; geride kalan ise onun ahlakıdır.',
            'Ölüm döşeğinde bile "namaz" ve "mazlumların hakkı" vasiyet edildi; ümmetin geçim düsturu bellidir.',
            'Hz. Ebû Bekir\'in teskin edici aklama: dava, kişilere değil; Allah\'a aittir.',
          ],
          akademikNotlar: [
            'Peygamberimizin vefat yeri Hz. Âişe\'nin hücresi (Ravza), yaşı hicri/kameri olarak 63 kabul edilir.',
            'Vefat günü konusunda 12 Rebiülevvel\'in yanında 1-2 Rebiülevvel rivayetleri de vardır; bu tarihler arasında 8-15 Haziran 632 aralığı kabul edilir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Peygamberimiz son vasiyetinde ümmetine hangi iki şeyi emretti?',
              secenekler: [
                'Oruç ve zekat',
                'Namaz ve sahip olunanların (mazlumların) hakkı',
                'Hac ve cihat',
                'İlim ve ticaret',
              ],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Vefat haberi üzerine \"Kim Muhammed\'e tapıyorsa, o ölmüştür\" sözünü kim söyledi?',
              secenekler: ['Hz. Ömer', 'Hz. Ali', 'Hz. Ebû Bekir', 'Hz. Âişe'],
              dogruIndex: 2,
            ),
          ],
        ),
      ],
    ),
    // ============================== ŞEMAİL-İ ŞERİF ==============================
    KissaGrubu(
      ad: 'Şemail-i Şerif',
      aciklama: 'Fiziki özellikleri, ahlakı, aile hayatı, çocuk ve hayvan sevgisi',
      kisalar: [
        const KissaKaydi(
          id: 'siyer-semail-fiziki',
          baslik: 'Fiziki Özellikleri',
          ozet:
              'Orta boylu, güzel yüzlü, nurani: Sahabilerin anlatımıyla Efendimizin fiziki görünümü.',
          emoji: '🌟',
          kategoriId: 'siyer',
          temalar: ['Ahlak', 'Merhamet'],
          donem: 'Şemail',
          metin: [
            'Sahabiler Peygamberimizin görünümünü şöyle anlatır: "Orta boylu ne uzun ne kısa; güneşte ve gölgede yürüdüğü farklı görülmezdi. Yüzü dolunay gibi parlardı; teni, gül gibi yumuşak ve beyazdı. Gözleri siyah, kirpikleri uzundu; sakalı sık ve gürdü. Saçları kulak memelerine kadar uzanırdı; alnı açık ve genişti."',
            'Hasan-ı Basrî\'nin aktardığına göre: "Onu gören, ayı toplamış bir bedevinden daha çok etkilenirdi." Hz. Câbir: "Bir ay dolunay gecesinde ona baktım; dolunaydan daha güzel olduğunu gördüm" dedi. Ümmü Ma\'bed\'in anlatımıyla: "Temiz, kokusu güzel, yüzü parlak; gözleri sürmeli gibi, kara-kahverengi gözler; uzun kirpikler... sustuğunda vakur, konuştuğunda cennet kokusu..."',
            'Peygamberimiz güzelliğini zahmata sokmazdı: "Allah bir kuluna verdiği güzelliği sevsin ve ona muhabbet etsin" buyurdu. O, aynada göründüğünde kendisini değil, ümmetini düşünürdü.',
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Câbir: "Dolunay gecesinde Peygamber\'e baktım; dolunaydan daha güzeldi." (Kadı Iyaz, Şifa, 1/62)',
              kaynak: 'Kadı Iyaz, Şifa',
            ),
          ],
          hikmetler: [
            'Güzel ahlak, güzel yüzün vaktine göre daha kalıcı güzelliğidir.',
            'Peygamberimizin güzelliği, davetinin çekiciliğinin görsel yansımasıydı.',
          ],
          akademikNotlar: [
            'Şemail ilmi, İmam Tirmizî\'nin "Şemâil-i Şerife" eseriyle kurumsallaşmıştır.',
            'Fiziki özelliklere dair rivayetler ağırlıkla Hz. Ali, Hz. Berâ b. Âzib ve Ümmü Ma\'bed kanalından gelir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Şemail ilminde en meşhur eser kimindir?',
              secenekler: ['İmam Tirmizî', 'İmam Buhârî', 'İmam Malik', 'İmam Nevevî'],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-semail-ahlak',
          baslik: 'Ahlakı ve Davranışları',
          ozet:
              '"O, yürüyen Kur\'an\'dı" sözünün sahibi: Affetme, tevazu ve güler yüz timsali.',
          emoji: '🥰',
          kategoriId: 'siyer',
          temalar: ['Ahlak', 'Merhamet', 'Adalet'],
          donem: 'Şemail',
          metin: [
            'Hz. Âişe\'ye "Peygamberin ahlakı nasıldı?" diye sorulduğunda şu cevabı verdi: "Onun ahlâkı Kur\'an\'dı." (Müslim, Müsâfirîn 139) Kur\'an\'ın rahmetini, affını ve hakkı gözetmesini hayatında bizzat yaşadı.',
            'Kendisine eziyet edenlere beddua etmezdi; Taif\'te taşlanmasına rağmen "Onlara Allah\'ım, hidayet ver!" dedi. Câhiliyeden kinle gelenlerle evlendi; evinde kimseye sert davranmadı. Yanında oturanlara "siz" diye hitap eder, selamı yaygınlaştırırdı. Şaka yapardı ama şakasında bile yalan yoktu: "Ben şaka da yapsam doğruyu söylerim."',
            'Hiçbir kimseyi eliyle vurmadı; kadınlara, çocuklara ve yaşlılara özel ilgi gösterdi. Evi, eşinin sohbetine ve çocuğun oyununa açıktı. O; esnaf, köle, yoksul demeden selam verir, hal hatır sorardı. "Allah\'ım! Ben insanlara yumuşak davrandım, zayıflığımı gizle!" duasıyla bilinirdi.',
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Âişe: "Onun ahlâkı Kur\'an idi." (Müslim, Müsâfirîn 139)',
              kaynak: 'Müslim, Müsâfirîn',
            ),
            HadisKaydi(
              metin:
                  '"Allah\'ım! Ben, bir kul gibi (halka) yumuşak davranırım, fakat kimseye kızmam." (Nesâî)',
              kaynak: 'Nesâî, Edeb',
            ),
          ],
          hikmetler: [
            'Ahlak, Kur\'an\'ın pratiğe dönmüş halidir: kim bilgin olursa olsun yaşamak gerekir.',
            'Düşmana bile merhamet ve affetme, davetçinin silahıdır.',
            'Şaka ve mizah; doğruluk ve edepten ayrılmadığında sosyal hayatın tadıdır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Âişe, Peygamberimizin ahlakını neye benzetmiştir?',
              secenekler: ['Kitaba', 'Kur\'an\'a', 'Suya', 'Süt\'e'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-semail-aile',
          baslik: 'Aile Hayatı ve Komşuluk',
          ozet:
              'Ehline şefkat, ev işlerinde yardım ve "Cebrail komşu hakkını vasiyet etti."',
          emoji: '🏠',
          kategoriId: 'siyer',
          temalar: ['Ahlak', 'Merhamet'],
          donem: 'Şemail',
          metin: [
            'Peygamberimiz ev işlerinde eşlerine yardım ederdi: "Evinde ailesinin işlerine yardım eder, namaz zamanı gelince çıkardı." (Buhârî, Edeb 168) Ayakkabısını diker, elbisesini yamar, evi süpürürdü. Çocuklarla oynar, onlara selam verir, oyunlarına eşlik ederdi: "Kim çocuğu sever, onu kucağına alırsa, kıyamet günü bana daha yakındır."',
            'Komşu hakkı konusunda şöyle buyurdu: "Cebrail bana komşu hakkını (sürekli) öğütledi; öyle ki, komşuyu komşuya mirasçı kılacağını zannettim." (Buhârî, Edeb 29) Komşusu aç olduğu halde tok yatan mümin olmadığını ifade etti. Komşusunun ihtiyacını giderene cenneti müjdeledi.',
            'Aile hayatında; Hz. Hatice\'ye vefa, Hz. Âişe ve diğer eşlerine adalet ve şefkat eksenli bir yaşam sürdü. "Sizin en hayırlınız, ailesine karşı en hayırlı olanınızdır; ben de aileme karşı en hayırlınızım." (Tirmizî)',
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Sizin en hayırlınız, ailesine karşı en hayırlı olanınızdır; ben aileme karşı en hayırlınızım. (Tirmizî, Menâkıb 63)',
              kaynak: 'Tirmizî, Menâkıb',
            ),
            HadisKaydi(
              metin:
                  'Cebrail bana komşu hakkını öğütledi; öyle ki komşuyu komşuya mirasçı kılacağını zannettim. (Buhârî, Edeb 28)',
              kaynak: 'Buhârî, Edeb',
            ),
          ],
          hikmetler: [
            'Ev halkına hizmet, büyüklükten değil, şereflilikten kaynaklanır.',
            'Komşuluk, İslam\'ın sosyal sıcaklığının çekirdeğidir: hakkı güçlü vurgulanır.',
            'Çocuğa sevgi ve ilgi, dini terbiyenin ilk kapısıdır.',
          ],
          quiz: [
            QuizSoru(
              soru: '"Sizin en hayırlınız, ailesine karşı en hayırlı olanınızdır" sözü kime aittir?',
              secenekler: ['Hz. Ebû Bekir', 'Peygamberimize', 'Hz. Hasan', 'Hz. Ali'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'siyer-semail-merhamet',
          baslik: 'Çocuklara ve Hayvanlara Davranışı',
          ozet:
              'Öpücükten evrensel merhamete: "Merhamet etmeyene merhamet olunmaz."',
          emoji: '🐦',
          kategoriId: 'siyer',
          temalar: ['Merhamet', 'Ahlak'],
          donem: 'Şemail',
          metin: [
            'Peygamberimiz çocuklara gösterdiği sevgiyle tanınırdı: Hz. Hasan ve Hüseyin\'i emzirir, kucağında gezdirdi. Namazda omzunda torununu taşıdı. "Çocuğu öptüğünü gören A\'râbî: 'Benim on çocuğum var, ben hiçbirini öpmedim' dedi; Peygamberimiz: 'Allah kalbindeki merhameti almış; şâyet verseydi, çocuklarına şefkat ederdin. Merhamet etmeyene, merhamet olunmaz.'" (Buhârî, Edeb 18)',
            'Hayvanlara karşı da rahmeti güzeldi: serçe yavrusunu alan birine "Yavrusunu geri ver" dedi; kuş yuvalarını kuran kervanlara "Yuvayı da bırakın" buyurdu. Açlıktan zayıf kalmış bir köpeğe ekmek veren fâhişenin, bu davranışıyla bağışlandığını haber verdi; bir kediyi hapseden kadının cezalandırıldığını anlattı.',
            '"Allah\'ın yeryüzündeki kullarına merhamet edin ki, gökteki (melekler) size merhamet etsin." (Tirmizî, Birr 17) O, besmele ile kesmeyi, hayvana eziyetten kaçınmayı ve emeğin karşılığında ücretini vermeyi dinin bir parçası haline getirdi.',
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Merhamet etmeyene, (Allah da) merhamet etmez. (Buhârî, Edeb 18)',
              kaynak: 'Buhârî, Edeb',
            ),
            HadisKaydi(
              metin:
                  'Susuz bir köpeğe su içiren bir fâhişenin günahları bağışlandı. (Buhârî, Bed\'ü\'l-halk 17)',
              kaynak: 'Buhârî, Bed\'ü\'l-halk',
            ),
          ],
          hikmetler: [
            'Merhamet, imanın meyvesidir: çocuğa, komşuya ve hayvana karşı rahmet aynı takımdan gelir.',
            'Bir hayvana iyilik bile günahlara kefaret olabilir; niyet ve şefkat değerlidir.',
            'Çocuk terbiyesi sevgiyle; korkutma ve horlamayla yapılmaz.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Serçe yavrusunu alan kimseye Peygamberimiz ne dedi?',
              secenekler: [
                'Yavruyu yanında almasına izin verdi',
                '"Yavrusunu geri ver" dedi',
                'Onu cezalandırdı',
                'Kuşu eve götürmesini söyledi',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
      ],
    ),
  ],
);

void siyerKaydet() => KissalarVerileri.kayitKategori(siyerKategorisi);