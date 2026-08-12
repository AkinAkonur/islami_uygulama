// ===========================================================================
// PEYGAMBERLER TARİHİ - KRONOLOJİK
// Hz. Âdem'den Hz. Îsâ'ya Kur'an'da geçen peygamberler + adı geçmeyenler.
// Her kayıt: Kimlik Kartı, tarihsel bağlam, tebliğ mücadelesi, mucizeler,
// duaları, helak/kurtuluş ve hikmetler. Kaynak: İbn Kesîr "Peygamberler ve
// Melikler Tarihi", Diyanet Kur'an Yolu Tefsiri.
// Opsiyonel veri vardır; unicode karakterler analize göre illegal karakter olarak işaretlenebilir.
// ===========================================================================

import 'kissalar_verileri.dart' ignore_for_file: unnecessary_const, creation_with_non_type, illegal_parameter_value;

final KissaKategori peygamberlerKategorisi = KissaKategori(
  id: 'peygamberler',
  ad: 'Peygamberler Tarihi',
  altBaslik: 'Hz. Âdem\'den Hz. Îsâ\'ya kronolojik peygamberler tarihi; kimlik kartı, mucizeler ve dualar',
  emoji: '📜',
  renkHex: '#F2C14E',
  renkAkcentHex: '#4FC3C9',
  gruplar: [
    KissaGrubu(
      ad: 'Kur\"n\"da Adi Geçen Peygamberler',
      aciklama: 'Hz. Adem\"den Hz. Isa\"ya: 25 peygamberin kissa\'si',
      kisalar: [
        const KissaKaydi(
          id: 'peygamber-adem',
          baslik: 'Hz. Âdem',
          ozet:
              'İnsanlığın babası: topraktan yaratılış, cennet imtihanı ve tevbe.',
          emoji: '🌱',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'Tevekkül'],
          donem: 'Yaratılış',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Yaşadığı dönem', deger: 'Yaratılışın başlangıcı'),
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Cennet; sonra yeryüzü'),
            KimlikKarti(alanAdi: 'Gönderildiği kavim', deger: 'İlk insanlık'),
            KimlikKarti(alanAdi: 'Ömrü', deger: 'Rivayete göre 1000 yıl (İbn Kesîr)'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '25 surede, 25 kez'),
          ],
          metin: [
            'Allah, meleklere "Ben yeryüzünde bir halife yaratacağım" dedi. Âdem\'i topraktan, en güzel biçimde yarattı; ruhundan üfledi. Melekler secde etti; İblis kibri yüzünden reddetti. Havva ile birlikte cennete yerleştirilen Âdem\'e, "Şu ağaca yaklaşmayın" buyruldu.',
            'Şeytanın vesvesesiyle ikisi de o ağaçtan yediler; günahlarının farkına varınca utandılar. Helak olmadılar: "Rabbimiz! Biz kendimize zulmettik. Eğer bizi bağışlamaz ve bize merhamet etmezsen, hüsrana uğrayanlardan oluruz." (A\'râf 23) Allah tevbesini kabul etti; Âdem\'e kelimeler öğretti ve yeryüzüne halife olarak indirdi.',
            'Âdem, ilk tevbe ve ilk imtihan dersi oldu: hatadan dönüş, insanlığın evrensel yasasıdır.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'وَتَلَقَّىٰ آدَمُ مِن رَّبِّهِ كَلِمَاتٍ فَتَابَ عَلَيْهِ',
              meal:
                  'Âdem, Rabbinden bir takım kelimeler öğrendi (boyun eğdi); O da tevbesini kabul etti. Şüphesiz O, tevbeyi çok kabul edendir, çok bağışlayandır.',
              kaynak: 'Bakara Suresi, 37. Ayet',
            ),
          ],
          hikmetler: [
            'Hata etmek insana özgüdür; marifet, hatada ısrar etmeyip tevbede sebat etmektir.',
            'Kibir (İblis) ve imtihan, dünyanın her çağında aynı sınava tabi tutar.',
            'İnsan halife olarak yaratıldı: yeryüzü, adalet ve şükürle imar edilir.',
          ],
          akademikNotlar: [
            'Yaratılış kıssası Bakara 30-39, A\'râf 11-25, Tâhâ 115-124\'te anlatılır.',
            'Âdem\'in cennetten inişi; "hubbût" ve yeryüzüne inme olayının coğrafyası hakkında tefsirlerde farklı rivayetler vardır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'İblis, Âdem\'e secde etmeyi neden reddetti?',
              secenekler: ['Bilgisizlikten', 'Kibirlenerek "ben ateşten yaratıldım" dedi', 'Emir unutuldu', 'Şeytan yorgundu'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Âdem ve Havva hatadan sonra ne yaptı?',
              secenekler: ['Gizlediler', 'Birbirlerini suçladılar', 'Tevbe edip Allah\'tan af dilediler', 'Cennette kalmaya çalıştılar'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-idris',
          baslik: 'Hz. İdrîs',
          ozet:
              'İlk kalemle yazan, göğe yükseltilen peygamber: ilim ve sabır timsali.',
          emoji: '📖',
          kategoriId: 'peygamberler',
          temalar: ['İlim', 'Sabır'],
          donem: 'İlk Peygamberler',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Yaşadığı dönem', deger: 'Âdem sonrası, Nûh öncesi'),
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Bâbil / Mısır (rivayetler farklı)'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '2 yerde (Meryem 56-57; Enbiya 85-86)'),
          ],
          metin: [
            'Kur\'an, İdrîs\'i şöyle anar: "Kitapta İdrîs\'i de an! Çünkü o, dosdoğru bir peygamberdi. Onu yüce bir makama yükselttik." (Meryem 56-57) Sıddîk olarak nitelenen İdrîs, sabrı ve doğruluğuyla övülür.',
            'İslam geleneğinde ilk kalemle yazan, ilk terzi (dikiş işiyle uğraşan) ve yıldız ilmiyle uğraşan peygamber olarak bilinir; insanlara ticaret, okuma-yazma ve ölçü-tartı kurallarını öğrettiği nakledilir.',
            '"Yüce makam" ifadesi tefsirlerde, onun dördüncü kat göğe yükseltildiği şeklinde yorumlanır; bazı âlimler İdris\'in Hz. Nûh\'un dedesi olduğunu rivayet eder.',
          ],
          hikmetler: [
            'İligim ve mesleki beceri, peygamberlikten ayrı bir onur değil; onun ayrılmaz parçasıdır.',
            'Sabır ve sıddıklık: şeref makamı yükselmekle değil, doğrulukla kazanılır.',
          ],
          akademikNotlar: [
            'İdrîs hakkında Kur\'an\'da sadece iki pasaj vardır; tefsirlerde "yüce makama yükseltme" ifadesinin miraç benzeri bir yükselişi ifade ettiği tartışılır.',
            'Bazı tarihçiler İdrîs\'i, Eski Ahit\'teki Hanok (Enoh) ile özdeşleştirir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Kur\'an\'a göre İdrîs hangi vasfıyla övülür?',
              secenekler: ['Zenginliğiyle', 'Sıddîk (dosdoğru) olmasıyla', 'Krallığıyla', 'Ordusuyla'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-nuh',
          baslik: 'Hz. Nûh',
          ozet:
              '950 yıl kavmini davet eden, tufanla kurtulan ve gemiyi imanla inşa eden peygamber.',
          emoji: '🚢',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'Tevekkül', 'Cesaret'],
          donem: 'İlk Peygamberler',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Yaşadığı dönem', deger: 'M.Ö. ~4. bin (rivayete göre)'),
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Güney Irak bölgesi (Bâbil/Şurupak)'),
            KimlikKarti(alanAdi: 'Gönderildiği kavim', deger: 'Âd\'dan önceki ilk putperest topluluk'),
            KimlikKarti(alanAdi: 'Ömrü', deger: '950 yıl davet (Ankebût 14)'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '43 yerde'),
          ],
          metin: [
            'Nûh, putperestliğe gömülen kavmine gönderildi; "Benden önce sizi uyaran hiçbir kimse gelmedi" dedi. 950 yıl gece gündüz, gizli açık davet etti; "Onları kendine çağırdım ki, af dilesinler..." (Nûh 10). Kavmi onunla alay etti, "Sen bizim gibi bir beşersin" dedi; az inanan kurtuldu.',
            'Allah ona gemi yapmasını emretti. Kavmi, "Her tehlikeye karşı korunaklı evini, şimdi dağların arasında gemi mi yapıyorsun?" diye alay etti. "Benimle alay ediyorsunuz; ben de sizinle alay edeceğim, göreceksiniz" dedi. Tufan geldi; oğlu bile "Ben dağa sığınırım" dedi, onda kurtuluş yoktu.',
            'Nûh, Allah\'ın adıyla gemiyi yürüttü; iman edenlerle kurtuldu. Tufan sonrası yeryüzü yeniden şenlendi. Onun duası: "Rabbim! Beni, anamı-babamı, mümin olarak evime girenleri ve tüm mümin erkek ve kadınları bağışla; zalimlerin ise ancak helakini artır." (Nûh 28)',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'فَكَذَّبُوهُ فَنَجَّيْنَاهُ وَمَن مَّعَهُ فِي الْفُلْكِ',
              meal:
                  'Onu yalanladılar; biz de onu ve onunla birlikte olanları gemi içinde kurtardık.',
              kaynak: 'A\'râf Suresi, 64. Ayet',
            ),
          ],
          hikmetler: [
            'Sabır, 950 yıllık bir ömre yayılır; davetçi, sonuç almadan da sadakatini korur.',
            'Alay etmek, hak üzere olanı yıldırmaz; Nûh alayla bile olsa gemiyi inşa etti.',
            'Kurtuluş, itaat ve imanla; helak, inat ve kibirle gelir: oğul bile kurtaramaz.',
          ],
          akademikNotlar: [
            'Tufan kıssası Kur\'an\'da en geniş anlatılan kıssalardandır (Hûd 25-48, Müminûn 23-30, Nûh Suresi).',
            'Gemiyi yaparken "Gözlerimizin önünde" (Hûd 37) ifadesi, korunmuşluğu anlatır; geminin indiği yer "Cûdî Dağı" (Hûd 44) olarak geçer.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Nûh kaç yıl kavmini davet etti?',
              secenekler: ['100 yıl', '350 yıl', '950 yıl', '500 yıl'],
              dogruIndex: 2,
            ),
            QuizSoru(
              soru: 'Tufandan sonra gemi nereye oturdu?',
              secenekler: ['Arafat Dağı', 'Cûdî Dağı', 'Sînâ Dağı', 'Tûr Dağı'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-hud',
          baslik: 'Hz. Hûd',
          ozet:
              'Âd kavmine gönderilen peygamber: yüksek binalıların helaki ve "haram yazıcılar" dersi.',
          emoji: '🏜️',
          kategoriId: 'peygamberler',
          temalar: ['Adalet', 'Cesaret', 'Tevekkül'],
          donem: 'Helak Kıssaları',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Yaşadığı dönem', deger: 'Nûh sonrası, ~M.Ö. 3. bin'),
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Ahkâf (Güney Arabistan, Hadramut)'),
            KimlikKarti(alanAdi: 'Gönderildiği kavim', deger: 'Âd kavmi'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '7 surede'),
          ],
          metin: [
            'Âd kavmi, fiziksel gücü ve imar kabiliyeti yüksek, ancak şımarık bir topluluktu: "Yüksek köşkler mi yapıyorsunuz? Sonsuza dek mi yaşayacaksınız?" (Şuarâ 129). Hûd, "Ey kavmim! Allah\'a kulluk edin, sizin için O\'ndan başka ilah yoktur" dedi; "Bize akılsızlık ve yalan isnat ettin" diye karşılık aldı.',
            'Kavmi onu yalanladı, "Sen peygamber değilsin" dedi; alaylar bedduaya döndü. Hûd, "Ben Allah\'a tevekkül ettim; O\'nun azabı size gelecektir" dedi. Üç günlük kara bulut halka göründü; helak edici rüzgârla Âd kavmi yok edildi. Hûd ve iman edenler kurtuldu.',
            '"Andolsun barınaklar, yüksek binalar yapan Âd kavmine de (azap indi)." (Fecr 6-8) Güç ve maddi refah, iman olmadan koruyamaz.',
          ],
          hikmetler: [
            'Güç ve servet, ahiret ölçüsü değildir; Âd\'ın helaki bunun kanıtıdır.',
            'Davetçi alaya rağmen "Ben Allah\'a tevekkül ettim" diyebilmelidir.',
            'Üç günlük mühlet: azap, uyarıya rağmen geldiğinde insan pişmanlık nafile faydasızdır.',
          ],
          akademikNotlar: [
            'Ahkâf ismi, kum tepeleri/ovalar anlamına gelir; bölge günümüz Hadramut (Yemen) çevresidir.',
            'Rüzgârın 7 gece 8 gün süren helaki (Hâkka 6-8) tefsirlerde ayrıntılı işlenir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Hûd hangi kavme gönderildi?',
              secenekler: ['Semûd', 'Âd', 'Medyen', 'Kureyş'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-salih',
          baslik: 'Hz. Sâlih',
          ozet:
              'Semûd kavmi ve kayadan çıkarılan mu\'cize devesi; "bir gece daha yaşayın" tehdidi.',
          emoji: '🐪',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'Cesaret'],
          donem: 'Helak Kıssaları',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Yaşadığı dönem', deger: 'Hûd sonrası, ~M.Ö. 2. bin'),
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Hicr bölgesi (Kuzeybatı Arabistan)'),
            KimlikKarti(alanAdi: 'Gönderildiği kavim', deger: 'Semûd kavmi'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '9 surede'),
          ],
          metin: [
            'Semûd kavmi, kayalara oydukları evleriyle ünlü, zengin ve inatçı bir topluluktu. Sâlih, "Ey kavmim! Allah\'a kulluk edin... Bu deve size bir mucizedir; onu serbest bırakın, suyunu içsin" dedi. Kavm, "Seninle bizim aramızdaki belirti olarak kayadan bir deve çıkar" diye meydan okudu.',
            'Allah\'ın izniyle deve kayadan çıktı; bir gün ona, bir gün kavme ait su hakkı tanındı. Semûdlular, buğz ve kibirden deveyi boğazladı. Sâlih: "Üç gün daha yurdunuzda yaşayın, bu yalanlayamayacağınız bir tehdittir" dedi. Gece gelen sayha (uğultu) ile zümreleri helak oldu; Sâlih ve iman edenler kurtuldu.',
            'Kur\'an, "Kim zulmederek o deveyi boğazladı değerini düşürdü" (Şems 11-15) der: Bir kul hakkının ve mucizenin üzerine yürüyen kavim, kendi sonunu hazırladı.',
          ],
          hikmetler: [
            'Mucize istemek kolaydır; mucize geldiğinde ona saygı göstermek zordur.',
            'Bir günlük su hakkı bile ilahi taksimle düzenlenir; adalet en küçük paylaşımda başlar.',
            'Kavmin inat ve kibirle mucizeyi yok etmesi, imanın belirtisi değil kibir belirtisidir.',
          ],
          akademikNotlar: [
            'Hicr (Medâin-i Sâlih) kalıntıları, günümüz Suudi Arabistan sınırlarındaki El-Ulâ yakınlarındadır; UNESCO Dünya Mirası listesindedir.',
            'Deve kıssası A\'râf 73-79, Hûd 64-68, Şuara 141-159 ve Şems Suresi\'nde anlatılır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Semûd kavminin mucizesi neydi?',
              secenekler: ['Asa', 'Kayadan çıkan deve', 'Gemi', 'Ateş'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-ibrahim',
          baslik: 'Hz. İbrâhîm',
          ozet:
              'Putları kıran, ateşe atılan ve "Allah için çok gözyaşı" diyen Halîlullah.',
          emoji: '🔥',
          kategoriId: 'peygamberler',
          temalar: const ['Cesaret', 'Tevekkül', 'Sabır', 'İman'],
          donem: 'Peygamberlerin Büyükleri',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Yaşadığı dönem', deger: '~M.Ö. 2000'),
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Bâbil; sonra Kenan/Şam, Mısır, Hicaz'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '69 yerde, en çok anılan peygamber'),
          ],
          metin: [
            'İbrâhîm, Nemrut\'un putperest toplumunda yıldızları ve güneşi gözlemleyerek "Ben yüzümü gökleri ve yeri yaratan Allah\'a çevirdim" dedi. Putları kırdığında baltayı büyük putun boynuna astı; sorulduğunda "Belki şu büyük olan yapmıştır" dedi: putların acizliğini halka gösterdi. Onu ateşe attılar; Allah buyurdu: "Ey ateş! İbrâhîm\'e karşı serin ve selametli ol!" (Enbiya 69)',
            'İbrâhîm "Halîlullah" (Allah\'ın dostu) oldu; oğlu İsmâil ile birlikte Kâbe\'yi inşa etti: "Rabbimiz! Bizden kabul buyur, şüphesiz sen işitensin, bilensin." (Bakara 127) Eşi Hâcer ve bebeği İsmâil\'i, vahiy gereği Mekke vadisinde bıraktı; Zemzem mucizesi orada yaşandı.',
            'Kur\'an onu "Allah için çok gözyaşı döken bir ümmet" olarak tasvir eder (Fâtır 6'da şeytanın vesvesesine karşı). O, önünde namaz kıldığı kıbleyi, hac ve kurbanın esasını ümmete bıraktı.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'قُلْنَا يَا نَارُ كُونِي بَرْدًا وَسَلَامًا عَلَىٰ إِبْرَاهِيمَ',
              meal: 'Ey ateş! İbrâhîm\'e karşı serin ve selâmet ol! dedik.',
              kaynak: 'Enbiyâ Suresi, 69. Ayet',
            ),
          ],
          hikmetler: [
            'Tevhid, delil ve cesaretle gerekçelendirilir; putların acizliği gösterilir.',
            'İmtihan üç boyutludur: ateş (mal-can), oğul (kurban) ve eman (baba-yurt). Üçü de geçildi.',
            'Kâbe ve kurban: teslimiyetin taşlaşmış ve fiil üzerine yükselmiş halidir.',
          ],
          akademikNotlar: [
            'İbrâhîm\'in ateşteki serinlik bilgisi Kur\'an\'da (Enbiya 68-70) açıktır; kıssanın detayları İbn Kesîr Tefsiri\'nde geniş işlenir.',
            'Kâbe inşasındaki "makam-ı İbrâhîm" ve Hacer\'in Sa\'y\'i, hac ibadetinin temel rükünlerini oluşturur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'İbrâhîm\'e atıldığı ateş için Allah ne buyurdu?',
              secenekler: [
                'Ateşe ibadet et',
                'Ey ateş! İbrâhîm\'e serin ve selâmet ol',
                'Ateş sönsün',
                'Ateş İbrâhîm\'i taşsın',
              ],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'İbrâhîm hangi oğluyla Kâbe\'yi inşa etti?',
              secenekler: ['İshâk', 'İsmâil', 'Yâkub', 'İdrîs'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-lut',
          baslik: 'Hz. Lût',
          ozet:
              'Fuhşa dalmış Sodom halkına gönderilen peygamber ve ahlaki çöküntünün akıbeti.',
          emoji: '🌋',
          kategoriId: 'peygamberler',
          temalar: ['Ahlak', 'Adalet', 'İffet'],
          donem: 'Helak Kıssaları',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Sodom ve Gomorra (Lût Gölü çevresi)'),
            KimlikKarti(alanAdi: 'Gönderildiği kavim', deger: 'Sodom halkı'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '27 yerde'),
          ],
          metin: [
            'Lût, kendisini "temiz bir peygamber" olarak tanıtan, fuhşu yüzleştiren bir topluma gönderildi: "Sizden önce, hiçbir kimsenin yapmadığı fuhşu mu işliyorsunuz?" (A\'râf 80) Kavmi, "Lût\'un ailesini yurdunuzdan çıkarın; onlar temizlik taslayan insanlardır" dedi.',
            'Misafir melekler geldi; kavim saldırmaya yeltendi. Lût, "Kızlarım (kavmin kadınlarıyla evlenme teklifi) sizin için daha temizdir" dedi ancak kavim "Sen de bize iyilik yapanlardan değilsin" diye çıkıştı. Allah, şehrin üzerine taş yağdırdı ve batırdı; Lût ailesinden karısı hariç kurtuldu.',
            'Hûd Suresi\'ndeki ifadeyle: "Şüphesiz bunda düşünen bir toplum için ibret vardır." (Hûd 82-83)',
          ],
          hikmetler: [
            'Ahlaki bozulma, toplumların en derin yıkım sebebidir; Kur\'an bunu en açık şekilde ders eder.',
            'İffet, dinin en korunan değerlerindendir; Lût\'un mücadelesi bunun örneğidir.',
            'Helak, gece kararlığında gelen azap gibi: çöküntü uzun süre gecikmiş olsa da kaçınılmazdır.',
          ],
          akademikNotlar: [
            'Sodom bölgesi, Ölü Deniz (Lût Gölü) civarıdır; bazı araştırmacılar şehrin kalıntılarını Umm Hurays bölgesinde arar.',
            'Kur\'an, kavmi "il günah" olarak nitelemiş ve bunu tüm toplumlar için örnek kılmıştır (Ankebût 28-35).',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Lût hangi kavme gönderildi?',
              secenekler: ['Âd', 'Semûd', 'Sodom halkı', 'Medyen'],
              dogruIndex: 2,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-ismail',
          baslik: 'Hz. İsmâil',
          ozet:
              'Kurban olma imtihanını kabul eden ve Kâbe\'nin inşasında baba hizasında duran evlad.',
          emoji: '🐏',
          kategoriId: 'peygamberler',
          temalar: ['Sadakat', 'Sabır', 'Tevekkül'],
          donem: 'Peygamberlerin Büyükleri',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Mekke (Hicaz)'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '12 yerde'),
          ],
          metin: [
            'İsmâil, Hâcer\'in oğluydu; Mekke vadisinde yetişti ve çölde su kuyularını (Zemzem) bereketlendirdi. Kur\'an onu "sabırlı", "doğru sözlü" ve "kendisine vahiy gelen" bir peygamber olarak anar (Meryem 54).',
            'Rüya, İbrâhîm\'e oğlunu kurban etmesini emretti. İsmâil\'e durumu açıktı: "Yavrucuğum! Rüyamda seni boğazlıyorum görüyorum; ne dersin?" Oğul, tarihin en dokunaklı cevabını verdi: "Babacığım! Emrolunduğun şeyi yap. İnşallah beni sabredenlerden bulacaksın." (Sâffât 102)',
            'İkisi de teslim oldu; bıçak kesmedi ve fidye olarak büyük bir kurbanlık verildi. İsmâil sonra babasıyla Kâbe\'yi yükseltti. Kurban ve hac, bu teslimiyetin abideleşmiş hatırasıdır.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'قَالَ يَا أَبَتِ افْعَلْ مَا تُؤْمَرُ ۖ سَتَجِدُنِي إِن شَاءَ اللَّهُ مِنَ الصَّابِرِينَ',
              meal:
                  'Oğul: Babacığım! Emrolunduğun şeyi yap. İnşallah beni sabredenlerden bulacaksın, dedi.',
              kaynak: 'Sâffât Suresi, 102. Ayet',
            ),
          ],
          hikmetler: [
            'Teslimiyet, imanın en yüksek mertebesidir: "İnşallah sabredenlerden bulacaksın" sözü bunun kodu oldu.',
            'Kurban, kişinin "en değerli verdiğini" Allah için adamasıdır: oğuldan kurbana dönüşen rahmet.',
            'Baba-oğul dayanışması, Kâbe\'nin inşasıyla ebedi bir ibadet şeklini aldı.',
          ],
          quiz: [
            QuizSoru(
              soru: 'İsmâil, kurban emri geldiğinde babasına ne dedi?',
              secenekler: [
                'Önce anneme danış',
                'Emrolunduğun şeyi yap; beni sabredenlerden bulacaksın',
                'Ben kaçayım',
                'Bunu yapma',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-ishak',
          baslik: 'Hz. İshâk',
          ozet:
              'İbrâhîm\'in müjdelendiği ikinci oğlu: "İlim sahibi bir peygamber".',
          emoji: '👨‍👦',
          kategoriId: 'peygamberler',
          temalar: ['İlim', 'Sabır'],
          donem: 'Peygamberlerin Büyükleri',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Kenan (Filistin)'),
            KimlikKarti(alanAdi: 'Önem', deger: 'Ya\'kûb (İsrail) soyunun atası'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '16 yerde'),
          ],
          metin: [
            'İshâk, İbrâhîm\'e yaşlılığında müjdelenen ikinci oğluydu; "İçinde iyilik barınan bir müjde" (Sâffât 101) olarak anılır. Kur\'an: "Siz bazı peygamberlere iman edip bazılarını öldürmüşken..." (Bakara 87) derken İshâk ve Ya\'kûb\'u "ilim sahibi peygamberler" olarak öne çıkarır (Hûd 71).',
            'Âl-i İmrân 84: "Biz Allah\'a, bize indirilene, İbrâhîm, İsmâil, İshâk, Ya\'kûb ve torunlara indirilene iman ettik." İshâk\'ın soyundan Ya\'kûb gelir; İsrail oğullarının peygamber zinciri buradan ilerler.',
          ],
          hikmetler: [
            'Her çocuk bir emanet ve müjdedir; İshâk\'ın müjdelenişi, anne-babayı kuşatan ilahi rahmettir.',
            'Soy ve iman zinciri: baba İbrâhîm, oğul İshâk, torun Ya\'kûb... manevi miras, zenginlikten daha değerlidir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. İshâk\'ın soyundan gelen peygamber zinciri hangi adla anılır?',
              secenekler: ['İsmailoğulları', 'İsrailoğulları', 'Kenanîler', 'Kureyş'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-yakub',
          baslik: 'Hz. Ya\'kûb',
          ozet:
              'Yusuf\'un hasretiyle ağlayan, sabrı güzelleştiren ve "İsrail" lakabıyla anılan baba.',
          emoji: '💙',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'Merhamet'],
          donem: 'Peygamberlerin Büyükleri',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Kenan (Harran, Filistin)'),
            KimlikKarti(alanAdi: 'Önem', deger: 'İsrail (Ya\'kûb) soyunun babası'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '16 yerde'),
          ],
          metin: [
            'Ya\'kûb, İshâk\'ın oğlu; "İsrail" (Allah\'ın kulu) lakabıyla bilinir. En bilinen kıssası oğlu Yûsuf\'un kıssasıdır: "Onunla birlikte Mısır\'a gidin... O, bana dedi ki: yakında o bana ve sana gelecek." (Yûsuf 93)',
            'Ya\'kûb, oğlunun ihanete uğradığını hissetti; Yûsuf kuyuya atıldığında, "Sabr-ı cemil (güzel sabır)" dedi: "Hayır, nefisleriniz sizi bir işe sürükledi. Artık bana düşen güzel sabırdır." (Yûsuf 18) Yıllarca hasretle gözleri ağardı, ama umudunu kaybetmedi.',
            'Kur\'an, sabrın ve tevekkülün en derin örneğini Ya\'kûb\'da canlandırır: acıya karşı gözyaşı, hüzne karşı ümit.',
          ],
          hikmetler: [
            '"Sabr-ı cemil": teselli aramadan, şikayet etmeden sabretmek; acıyı şikayetsizlikle dindirmek.',
            'Evlat acısı, sabrın en derin imtihanıdır; inanç, vakit geç de olsa kavuşmayı vaat eder.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Ya\'kûb oğlu Yûsuf kaybolunca ne dedi?',
              secenekler: [
                '"Bana düşen güzel sabırdır (sabr-ı cemil)"',
                '"Kayboldu, günah bağışlanmaz"',
                '"İntikam alacağım"',
                '"Yeni bir oğul isterim"',
              ],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-yusuf',
          baslik: 'Hz. Yûsuf',
          ozet:
              'Kuyudan zindana, zindandan saraya: iffet ve sabrın en güzel kıssası.',
          emoji: '⭐',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'İffet', 'Adalet', 'Sadakat'],
          donem: 'Mısır Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Kenan → Mısır'),
            KimlikKarti(alanAdi: 'Görevi', deger: 'Mısır hazineleri nazırı, peygamber'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: 'Yûsuf Suresi, "en güzel kıssa"'),
          ],
          metin: [
            'Yûsuf\'un kıssası Kur\'an\'da "kıssaların en güzeli" olarak anılır (Yûsuf 3). Kardeşleri hasetle onu kuyuya attı; kervan onu alıp Mısır\'da köleliğe sattı. Aziz\'in evinde büyüyen Yûsuf, güzelliği ve iffetine rağmen iftiraya uğradı: "Rabbim! Zindan, onların davet ettiği şeye (günaha girmekten) bana daha sevimlidir." (Yûsuf 33)',
            'Zindanda yıllarca sabretti; rüya tabiri ilmiyle tanındı, kralın rüyasını yorumladı ve hazineler nazırı oldu. Kıtlık yıllarında kardeşleri Mısır\'a geldi; Yûsuf ağabeylik yaptı, haklarını bağışladı. Babasını çağırdı: "İzzetlice girin Mısır\'a" (Yûsuf 99).',
            'Kıssanın özü: "Bela ve ihanet, sabırla ve iffetli bir ömürle büyüklüğe dönüşür." Yûsuf sadece kral değil; affeden, adil yönetici ve güzel ahlakın timsali oldu.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'رَبِّ السِّجْنُ أَحَبُّ إِلَيَّ مِمَّا يَدْعُونَنِي إِلَيْهِ',
              meal:
                  'Rabbim! Bana, onların kendisine çağırdıkları şey (günah) yerine zindan daha sevimlidir.',
              kaynak: 'Yûsuf Suresi, 33. Ayet',
            ),
          ],
          hikmetler: [
            'İffet, en büyük güçtür: taht ve hükümranlık zindanda korunan gönülle kazanılır.',
            'Haset, aileyi ve toplumu yıkan virüstür; kardeş kıskançlığı Yûsuf\'u kuyuya attı.',
            'Sabır, zindanı saraya çeviren anahtardır: mevki ve servet gelir, iffet ve emanet kalır.',
            'Affetmek, intikamdan daha güçlüdür; Yûsuf, kardeşlerini affederek yüceldi.',
          ],
          akademikNotlar: [
            'Mısır\'daki saray kalıntıları ve Yûsuf\'un hazine nazırlığı hakkında arkeolojik bağlantılar tartışmalıdır; kıssa tarihsel olmaktan çok itikadî-ahlaki değer taşır.',
            '"Kıssaların en güzeli" ifadesi, kıssanın anlatım üstünlüğüne işaret eder; müfessirler bunu "meâni ve mürâât" açısından tahlil eder.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Yûsuf kıssası Kur\'an\'da nasıl nitelenir?',
              secenekler: ['Uzun kıssa', 'Kıssaların en güzeli', 'Tarihî olay', 'Masal'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Yûsuf zindanı hangi sebeple tercih etti?',
              secenekler: [
                'Kraldan kaçmak için',
                'Günaha düşmek yerine zindanı sevdi',
                'Kardeşlerini cezalandırmak için',
                'İlim öğrenmek için',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-eyyub',
          baslik: 'Hz. Eyyûb',
          ozet:
              'Mal, çocuk ve sağlığını kaybeden ama sabrıyla Rabbine hamdeden peygamber.',
          emoji: '🕊️',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'Tevekkül'],
          donem: 'İmtihan Kıssaları',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Havran (Şam-Ürdün) bölgesi'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '4 surede (Nisâ, En\'âm, Enbiya, Sâd)'),
          ],
          metin: [
            'Eyyûb, zengin ve bolluk içinde yaşayan bir peygamberdi. Allah onu imtihan etti: malı, çocukları helak oldu; bedeni hasatlıkla sarıldı. Yıllarca dertle yattı; ama şikayetini Rabbine değil, sabrını dünyaya gösterdi. Rivayete göre komşularından biri: "Eğer sen peygamber olsaydın Allah böyle bir şey yapmazdı" dedi; o, "Ben sadece kul olarak sabrediyorum" diye karşılık verdi.',
            'Kur\'an onun duasını kaydeder: "Rabbim! Şüphesiz bana zarar dokundu; sen merhametlilerin en merhametlisisin." (Enbiya 83) Allah duasını kabul etti: "Ayağını yere vur! İşte yıkanılacak ve içilecek soğuk su." (Sâd 42)',
            'Eyyûb\'a ailesi ve benzerleriyle birlikte bolluk geri verildi: "Ona ailesini ve onlarla birlikte bir mislini verdik; rahmetimizin bir göstergesi olarak ve akıl sahiplerine ibret için." (Sâd 43)',
          ],
          hikmetler: [
            'Sabır, dertsizlikte değil; dertteki şükürle ölçülür.',
            '"Zarar bana dokundu" duası şikayet değil, merhamet talebidir; ihlasa en yakın sözdür.',
            'İmtihan, dünyanın bir ücret ve geçici hali olduğunu hatırlatır; sonu ibret ve rahmettir.',
          ],
          akademikNotlar: [
            'Eyyûb\'un hastalığının niteliği hakkında tefsirler farklı rivayetler kaydeder; akılcı bir yaklaşımla bedensel rahatsızlık olarak ifade edilir.',
            'Sâd 44\'teki "yüz demet alıp vur" ifadesi, yeminin yerine getirilmesi için kolaylaştırma olarak yorumlanır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Eyyûb hangi vasfıyla örnek gösterilir?',
              secenekler: ['Zenginlikle', 'Sabırla', 'Güçle', 'İlimle'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-suayb',
          baslik: 'Hz. Şuayb',
          ozet:
              'Medyen halkına gönderilen, ölçü-tartı adaletini haykıran peygamber.',
          emoji: '⚖️',
          kategoriId: 'peygamberler',
          temalar: ['Adalet', 'Ahlak'],
          donem: 'Helak Kıssaları',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Medyen (Kuzeybatı Arabistan/Ürdün)'),
            KimlikKarti(alanAdi: 'Gönderildiği kavim', deger: 'Medyen ve Eyke (ormanlık) halkı'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '11 yerde'),
          ],
          metin: [
            'Medyen halkı, ticarette ölçü ve tartıyı eksik yapıyordu. Şuayb: "Ey kavmim! Ölçü ve tartıyı adaletle tam yapın; insanların eşyasını eksiltmeyin; yeryüzünde bozgunculuk yaparak karışıklık çıkarmayın." (A\'râf 85) Kavmi, "Seni yalancı olarak (bu dinden çıkarmakla) tehdit ediyoruz" dedi.',
            'Şuayb güzel konuşmasıyla "hatibü\'l-enbiya" (peygamberlerin hatibi) diye anıldı. Kavmi sonunda "Sana ve iman edenlere ya şehrimizden çıkacağız ya da dinimize döneceksiniz" dedi; Şuayb: "Allah\'ın dilemesi dışında dinimize dönmeyiz" dedi.',
            'Kavmi sayha/zelzele ve gölge bulutu azabıyla helak oldu; "Evet, Medyen halkı Şuayb\'in dediği gibi, sanki orada hiç yaşamamış gibi yok oldu." (Hûd 95)',
          ],
          hikmetler: [
            'Ticaret ahlakı dini bir emirdir: ölçü-tartı adaleti, toplumun güven damarıdır.',
            'Güzel dil ve hitabet, tebliğin en tesirli vasıtalarındandır.',
            'Azabın gelebileceği en son ikaz: uyarıya icabet etmeyen toplum, gölgesinden bile azap bulur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Şuayb hangi kavme gönderildi?',
              secenekler: ['Medyen halkına', 'Âd\'a', 'Semûd\'a', 'Kureyş\'e'],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-musa',
          baslik: 'Hz. Mûsâ',
          ozet:
              'Asa, Tûr-i Sînâ, Kızıldeniz ve Tûr dersi: "Ben, doğrusu senin Rabbinim!"',
          emoji: '🏔️',
          kategoriId: 'peygamberler',
          temalar: ['Cesaret', 'Adalet', 'Sabır'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Yaşadığı dönem', deger: '~M.Ö. 13. yüzyıl'),
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Mısır → Sînâ → Kenan'),
            KimlikKarti(alanAdi: 'Gönderildiği kavim', deger: 'İsrailoğulları ve Firavun'),
            KimlikKarti(alanAdi: 'Önemi', deger: 'Tevrat\'ın gönderildiği "Kelîmullah"'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '136 yerde, en çok anılan'),
          ],
          metin: [
            'Firavun, İsrailoğulları\'nın erkek çocuklarını kestiriyordu. Mûsâ, sepet içinde Nil\'e bırakıldı; Firavun\'un sarayında büyüdü. Bir kavga sırasında bir Kıptî\'nin vefatı üzerine Mısır\'dan kaçtı; Medyen\'de 10 yıl çobanlık etti. Tûr\'da, ilahi hitaba mazhar oldu: "Ben, şüphesiz ben, evet ben senin Rabbinim!" (Tâhâ 14)',
            'Mûsâ ve kardeşi Hârûn, Firavun\'a ve sihirbazlarına karşı gönderildi; asası yılana dönüştü (mucize), eli nurlandı. Firavun ve kavmi isyan etti; Mûsâ, İsrailoğulları\'nı gece Mısır\'dan çıkardı. Kızıldeniz, asanın işaretiyle ikiye yarıldı: "Mûsâ\'ya: Asanı denize vur! diye vahyettik. Birbirine kavuşmamış iki büyük kütle gibi yarılıverdi." (Şuarâ 63)',
            'Tûr\'da 40 gece mükâleme (kelâm) oldu; Tevrat indi. Kavmi buğday heykeli (buzağı) dikti; Mûsâ öfkelendi ama tövbe ve affetmeyi de öğretti. Sînâ çölünde 40 yıl; kavmi, inatları yüzünden yere serildi. Mûsâ, tasavvuf geleneğinde "Kelîmullah" unvanıyla, sabrın ve azmin peygamberi olarak anılır.',
          ],
          ayetler: [
            AyetKaydi(
              arapca: 'فَقُلْنَا اضْرِب بِّعَصَاكَ الْبَحْرَ فَانفَلَقَ',
              meal:
                  'Biz de: Asanı denize vur! dedik. Derken deniz yarılıverdi.',
              kaynak: 'Şuarâ Suresi, 63. Ayet',
            ),
          ],
          hikmetler: [
            'İrade ve azim, Mûsâ gibi şartları zorlayan bir önder yetiştirir; asa küçük ama iman büyüktür.',
            'Zalim, silahını ve sarayını; peygamber duasını getirir. Firavun gücüyle, Mûsâ duasıyla kazandı.',
            'Mûsâ\'nın kavmi, nankörlükle mucizeleri unuttu; nimetler, şükürsüzce elde tutulamaz.',
            'Her peygamberde olduğu gibi: kelâm, eksiksiz bir kulluk ve sebat isteyen ciddi bir tebliğdir.',
          ],
          akademikNotlar: [
            'Mûsâ\'nın tarihselliği Mısırbilim uzmanlarınca tartışılsa da, Kur\'an ve İncil\'in ortak anlatımı M.Ö. 13. yüzyılı işaret eder.',
            'Kızıldeniz geçişi, çeşitli fenomenolojik açıklamalara (rüzgâr kombinasyonu vb.) konu olmuştur; inanç açısından olay mucizedir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Mûsâ\'nın en büyük mucizelerinden biri hangisidir?',
              secenekler: ['Deve', 'Asanın denize vurulmasıyla denizin yarılması', 'Ateş', 'Gemi'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Mûsâ hangi unvanla anılır?',
              secenekler: ['Kelîmullah', 'Halîlullah', 'Rûhullah', 'Sıddîk'],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-harun',
          baslik: 'Hz. Hârûn',
          ozet:
              'Mûsâ\'nın kardeşi ve yardımcısı: güzel diliyle tebliğde zirve olan peygamber.',
          emoji: '🗣️',
          kategoriId: 'peygamberler',
          temalar: ['Sadakat', 'Sabır'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Görevi', deger: 'Mûsâ\'ya yardımcı peygamber'),
            KimlikKarti(alanAdi: 'Özelliği', deger: 'Düzgün konuşma, güçlü hitap'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '20 yerde'),
          ],
          metin: [
            'Hârûn, Mûsâ\'nın kardeşi ve yardımcısıydı. Mûsâ, "Rabbim! Göğsümü genişlet, işimi kolaylaştır; kardeşim Hârûn\'u bana yardımcı kıl" diye dua etmişti (Tâhâ 25-32). Hârûn, güzel konuşması ve halkın sevgisiyle bilinen bir davetçiydi.',
            'Kavmi buzağıya tapınca Hârûn: "Ey kavmim! Bununla siz imtihan edildiniz; Rabbiniz Rahmân\'dır; bana uyun, emrime itaat edin." (Tâhâ 90) dedi. Ancak kavim onu zayıf gördü. Mûsâ dönünce Hârûn: "Anamın oğlu! Sakalımı, başımı tutma; doğrusu kavmim beni zayıf gösterdi, neredeyse beni öldüreceklerdi." (A\'râf 150)',
            'Hârûn, hak ve adalet uğrunda dik durabilen, ancak zayıfın hukukuna da hâkim olan sabır örneğidir.',
          ],
          hikmetler: [
            'Hitabet ve güzel dil, tebliğin en tesirli araçlarındandır: Hârûn bu kapının anahtarını taşırdı.',
            'Davetçi, kavmi imtihan olurken bile itidalli kalmalıdır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Kavim buzağıya tapınca Hârûn ne yaptı?',
              secenekler: [
                'Mûsâ\'yı bekledi',
                'Onları Rahmân\'a davet etti, bana uyun dedi',
                'Kavmiyle birlikte taptı',
                'Mısır\'a kaçtı',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-zulkifl',
          baslik: 'Hz. Zülkifl',
          ozet:
              'Ahdine vefa gösterdiği için "kefil sahibi" unvanını alan sabır peygamberi.',
          emoji: '📿',
          kategoriId: 'peygamberler',
          temalar: ['Ahlak', 'Sabır'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: 'Enbiyâ 85; Sâd 48'),
          ],
          metin: [
            'Kur\'an, Zülkifl\'i sabredenlerden ve güzel kullardan sayar: "İsmâil, İdrîs ve Zülkifl\'i de an. Hepsi sabredenlerdendi." (Enbiya 85)',
            'İsmi "kefil sahibi" anlamındadır. Rivayete göre kavmine, kendisinden sonra kavminin hakkını gözetip hakkı yerine getireceğine dair kefillik (söz) verdi; bu ahde vefa gösterdiği için bu ismi aldı.',
          ],
          hikmetler: [
            'Sözünde durmak, peygamberlerin ahlakıdır: insan ahdine vefa gösterdiği kadar değerlidir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Zülkifl isminin anlamı nedir?',
              secenekler: ['Güç sahibi', 'Kefil (emanet) sahibi', 'Mülk sahibi', 'İlim sahibi'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-davud',
          baslik: 'Hz. Dâvûd',
          ozet:
              'Demiri yumuşatan, Zebur ile övülen ve adaletle hükmeden peygamber-kral.',
          emoji: '🛡️',
          kategoriId: 'peygamberler',
          temalar: ['Cesaret', 'Adalet', 'Ahlak'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Kudüs / İsrail'),
            KimlikKarti(alanAdi: 'Görevi', deger: 'Peygamber, kral ve zırh ustası'),
            KimlikKarti(alanAdi: 'Önemi', deger: 'Zebur kendisine indirildi'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '16 yerde'),
          ],
          metin: [
            'Dâvûd, genç yaşta Câlût (Golyat) karşısında sapan taşını imanla savurdu: "Hakkıyla iman edenler... Dâvûd Câlût\'u öldürdü; Allah ona hükümranlık ve hikmet verdi." (Bakara 251) Genç bir çobanın imanı, dev bir askeri devirdi.',
            'Allah ona demiri yumuşattı (Sebe 10); Zebur\'u verdi (İsrâ 55); dağlar ve kuşlar onunla tesbih etti. Ona şöyle hitap edildi: "Ey Dâvûd! Biz seni yeryüzünde halife kıldık; öyleyse insanlar arasında adaletle hükmet ve hevâya uyma." (Sâd 26)',
            'Dâvûd, oruç ve gece namazıyla ünlüdür: "Dâvûd orucu" bir gün oruç, bir gün iftar olarak tarif edilmiştir; bu, sünnette meşhur bir ibadet örneğidir.',
          ],
          hikmetler: [
            'Zafer, silahla değil imanla kazanılır: çoban Dâvûd, silahlı Câlût\'u sapan taşıyla devirdi.',
            'Verilen mülk ve kudret, adaletle yürütülürse ibadete dönüşür (Sâd 26).',
            'Zühd ve az yemek (oruç), gücün ve hikmetin koruyucusudur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Dâvûd\'a indirilen kitap hangisidir?',
              secenekler: ['Tevrat', 'Zebur', 'İncil', 'Suhuf'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Dâvûd genç yaşta hangi düşmanı yendi?',
              secenekler: ['Firavun', 'Câlût', 'Nemrut', 'Ebû Süfyan'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-suleyman',
          baslik: 'Hz. Süleymân',
          ozet:
              'Rüzgâra, cinlere ve kuşlara hükmeden; Hüdhüd\'den ders alan hikmet sahibi peygamber.',
          emoji: '👑',
          kategoriId: 'peygamberler',
          temalar: ['İlim', 'Adalet', 'Tevekkül'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Kudüs / İsrail-Yemen'),
            KimlikKarti(alanAdi: 'Özelliği', deger: 'Rüzgâra, cinlere ve kuşlara hükmeden'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '17 yerde (Neml, Sebe)'),
          ],
          metin: [
            'Süleymân, Dâvûd\'un oğlu; kendisine "benden sonra kimseye yakışmayacak bir mülk" verilen peygamberdi (Sâd 35). Rüzgâr emrine verildi; cinler onun için kaleler ve heykeller yaptı; kuşlarla konuşur, ordusuna karıncadan ders alırdı.',
            'Hüdhüd kuşu, Sebe melikesi Belkıs\'ın güneşe taptığını haber verdi. Süleymân, Belkıs\'ın tahtını "göz açıp kapamadan" getirttiği ilim sahibine: "Bu, Rabbimin lütfundandır; şükür mü edeceğim, nankörlük mü edeceğim beni deniyor." (Neml 40) dedi. Belkıs iman etti.',
            'Süleymân kıssası, ilim ve hikmetin; hükümdarlık ve adaletin; ve her nimetin bir imtihan olduğunun dersidir.',
          ],
          hikmetler: [
            'Güç, hak ve hikmetle birleşirse umrana dönüşür.',
            'En küçük canlıdan bile (Hüdhüd, karınca) ilim alınır.',
            'Nimet her zaman bir sınavdır: şükür mü, nankörlük mü?',
          ],
          quiz: [
            QuizSoru(
              soru: 'Süleymân\'a emrine verilen unsurlar arasında hangisi yoktur?',
              secenekler: ['Rüzgâr', 'Cinler', 'Kuşlar', 'Ateş'],
              dogruIndex: 3,
            ),
            QuizSoru(
              soru: 'Sebe melikesinin adı nedir?',
              secenekler: ['Belkıs', 'Züleyha', 'Âsiye', 'Havva'],
              dogruIndex: 0,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-ilyas',
          baslik: 'Hz. İlyâs',
          ozet:
              'Ba\'l putuna karşı çıkan ve Rabbine hamd eden seçilmiş peygamber.',
          emoji: '🌧️',
          kategoriId: 'peygamberler',
          temalar: ['Cesaret', 'Tevekkül'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'İsrail, Ba\'lbek bölgesi'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: 'Sâffât 123-132; En\'âm 85'),
          ],
          metin: [
            'İlyâs, Ba\'l adlı puta tapan kavmine "Allah\'tan korkmaz mısınız? En güzel yaratıcı olan Allah\'ı bırakıp da Ba\'l\'e mi yalvarıyorsunuz?" (Sâffât 124-125) dedi. Kavmi zenginlik ve şımarıklık içinde daveti reddetti.',
            'Kur\'an onu över: "Andolsun, İlyâs da gönderilen peygamberlerdendi. ... Şüphesiz o, sadık kullarımızdandı." (Sâffât 123-132)',
          ],
          hikmetler: [
            'Toplumun kutsallaştırdığı sahte ilahlara karşı çıkmak, tevhid davetinin merkezidir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. İlyâs hangi puta karşı mücadele verdi?',
              secenekler: ['Lât', 'Ba\'l', 'Uzzâ', 'Menât'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-elyesa',
          baslik: 'Hz. Elyesa',
          ozet:
              'İlyâs\'ın halefi; sabrı ve güzel kulluğuyla övülen peygamber.',
          emoji: '🕍',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'Ahlak'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: 'En\'âm 86; Sâd 48'),
          ],
          metin: [
            'Elyesa, İlyâs\'ın halefi olarak kavmine gönderildi. Kur\'an onu sabredenlerden ve iyi kullardan sayar: "İsmâil, Elyesa, Yûnus ve Lût... Hepsi âlemlere üstün kılınan seçilmişlerdendi." (En\'âm 86)',
            'Tefsirler, Elyesa\'nın İlyâs\'ın akrabası ve talebesi olduğunu; kavmini tevhid ve güzel ahlaka çağırdığını nakleder.',
          ],
          hikmetler: [
            'Hidâyet zinciri kopmaz: her peygamberin halefi, onun elinden devam eder.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Elyesa kime halef oldu?',
              secenekler: ['Hz. Mûsâ\'ya', 'Hz. İlyâs\'a', 'Hz. Şuayb\'a', 'Hz. Yûşa\'ya'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-yunus',
          baslik: 'Hz. Yûnus',
          ozet:
              'Balığın karnında "lâ ilâhe illâ ente" diyen ve tövbe mucizesiyle kurtulan peygamber.',
          emoji: '🐋',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'Tevekkül'],
          donem: 'İmtihan Kıssaları',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Ninova (Musul, Irak)'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: 'Enbiyâ 87-88; Sâffât 139-148'),
          ],
          metin: [
            'Yûnus, Ninova halkına gönderildi. Kavmi inanmayınca kızarak şehri terk etti ve gemiye bindi; kura onu denize attı, büyük balık onu yuttu: "Zünnûn\'u da an! Hani öfkelenerek gitmişti de, kendisini asla sıkıştırmayacağımızı sanmıştı." (Enbiya 87)',
            'Karanlıklar içinde onun duası: "Lâ ilâhe illâ ente sübhâneke innî küntü mine\'z-zâlimîn: Senden başka ilah yoktur; Seni tenzih ederim; doğrusu ben zalimlerden oldum." (Enbiya 87) Allah tevbesini kabul etti; onu kıyıya çıkardı ve üzerine kabak ağacı bitirdi.',
            '"Eğer o, tesbih edenlerden olmasaydı, diriltilecekleri güne kadar balığın karnında kalırdı." (Sâffât 143-144) Kavmi de iman edince azaptan kurtuldu.',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'لَا إِلَٰهَ إِلَّا أَنتَ سُبْحَانَكَ إِنِّي كُنتُ مِنَ الظَّالِمِينَ',
              meal:
                  'Senden başka hiçbir ilah yoktur. Seni tenzih ederim; doğrusu ben zalimlerden oldum.',
              kaynak: 'Enbiyâ Suresi, 87. Ayet',
            ),
          ],
          hadisler: [
            HadisKaydi(
              metin:
                  'Kim, Yûnus\'un duasıyla dua ederse, Allah onun duasını kabul eder. (Tirmizî, Deavât 82)',
              kaynak: 'Tirmizî, Deavât',
            ),
          ],
          hikmetler: [
            'En karanlık an, en derin dönüşün kapısıdır: ihlasla edilen dua en zor karanlıkları açar.',
            'Öfkeyle acele kararlar, davete zarar verir; sabır ve istişare onarır.',
            '"Zalimlerden oldum" itirafı, tevbenin ilk adımıdır: kusuru kabullenmek.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Yûnus\'un balığın karnında yaptığı dua hangisidir?',
              secenekler: [
                'Rabbenâ zâlemnâ enfüsenâ',
                'Lâ ilâhe illâ ente sübhâneke innî küntü mine\'z-zâlimîn',
                'Rabbenâ âtinâ min ledünke',
                'Rabbi\'şrah lî sadrî',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-zekeriyya',
          baslik: 'Hz. Zekeriyyâ',
          ozet:
              'İhtiyarlıkta evlat müjdesi: "Rabbim! Bana, katından temiz bir nesil ver."',
          emoji: '🙏',
          kategoriId: 'peygamberler',
          temalar: ['Sabır', 'Tevekkül', 'İman'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Kudüs (Beyt-i Makdis)'),
            KimlikKarti(alanAdi: 'Görevi', deger: 'Mabet hizmetçisi şefi'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: 'Âl-i İmrân 37-41; Meryem 1-11'),
          ],
          metin: [
            'Zekeriyyâ, Beyt-i Makdis\'in hizmetçisiydi; Meryem\'e de o bakardı. Onun yanında güzel rızıklar göründüğünde "Bu sana nereden geldi?" diye sorduğunda Meryem "Allah katından" dedi. Zekeriyyâ orada dua etti: "Rabbim! Bana, katından temiz bir nesil ihsan et. Şüphesiz Sen duayı işitensin." (Âl-i İmrân 38)',
            'Yaşı ilerlemiş, başına aklar düşmüştü; melekler ona seslendi: "Allah sana, kendisine ait bir kelime ile (Îsâ\'ya inanacak olan) Yahyâ\'yı müjdeler." (Âl-i İmrân 39) Zekeriyyâ şaşırdı, "Rabbim! Benim çocuğum nasıl olur? Ben yaşlıyım, karım kısır" dedi; "Öyledir ama Allah dilediğini yapar" buyruldu.',
            'Zekeriyyâ üç gün insanlarla konuşmaması (işaretle tebliğ) emredildi; Yahyâ dünyaya geldi. Bu kıssa, dua ve ümidin yaştan bağımsız gücünü anlatır.',
          ],
          hikmetler: [
            'İmkânsız gibi görünen dualar, Allah katında kolaydır: kısırlık çare, yaşlılık engel değildir.',
            'Dua, en karanlık zamanların kapı zilidir; Allah duayı işitendir.',
            '"Temiz (salih) nesil" isteği, ebeveynliğin en güzel biçimidir.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Zekeriyyâ ne için dua etti?',
              secenekler: [
                'Zenginlik için',
                'Katından temiz (salih) bir nesil için',
                'Uzun ömür için',
                'Krallık için',
              ],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-yahya',
          baslik: 'Hz. Yahyâ',
          ozet:
              'Çocuk yaşta hikmet verilen, kalbi yumuşak ve iffetli peygamber.',
          emoji: '🌷',
          kategoriId: 'peygamberler',
          temalar: ['İffet', 'Ahlak'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Kudüs / Ürdün bölgesi'),
            KimlikKarti(alanAdi: 'Özelliği', deger: 'Çocukluğunda hikmet verildi'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: 'Âl-i İmrân 38-41; Meryem 12-15'),
          ],
          metin: [
            'Yahyâ, Zekeriyyâ\'nın müjdelenen oğludur: "Ey Yahyâ! Kitaba sımsıkı sarıl. Biz ona daha çocukken hikmet verdik." (Meryem 12) O, gönülden bağlı, yumuşak kalpli, sevgiyle donatılmış bir gençti.',
            'Kur\'an onun vasıflarını sıralar: "Yumuşak kalpli (hanân), tertemiz (zekiyy), takva sahibi, anne-babasına iyilik eden, zorba ve âsî olmayan biriydi." (Meryem 13-14)',
          ],
          hikmetler: [
            'Gençliğin değeri, hikmet ve takvayla yükselir; yaş, liyâkatin ölçüsü değildir.',
            'Anne-babaya iyilik ve yumuşak kalplilik, peygamberlik vasfının parçasıdır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Yahyâ\'ya ne zaman hikmet verildiğine dair Kur\'an ne der?',
              secenekler: ['Yaşlılığında', 'Daha çocukken', 'Vefatından sonra', 'Hicretinde'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-isa',
          baslik: 'Hz. Îsâ',
          ozet:
              'Babasız dünyaya gelen, beşikte konuşan ve İncil\'le gönderilen Rûhullah.',
          emoji: '🕊️',
          kategoriId: 'peygamberler',
          temalar: ['İffet', 'Sabır', 'İman'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Coğrafya', deger: 'Beytüllahim / Nasıra / Kudüs'),
            KimlikKarti(alanAdi: 'Görevi', deger: 'İsrailoğullarına İncil ile gönderilen peygamber'),
            KimlikKarti(alanAdi: 'Önemi', deger: 'Kelimetullah ve Rûhullah'),
            KimlikKarti(alanAdi: 'Kur\'an\'da anılışı', deger: '25\'e yakın yerde'),
          ],
          metin: [
            'Îsâ, İsrailoğulları\'na gönderilen son büyük peygamberlerdendi. Meryem\'e, babasız olarak dünyaya geleceği müjdelendi: "Allah\'ın katında Îsâ\'nın durumu, Âdem\'in durumu gibidir: onu topraktan yarattı, sonra ona ol! dedi ve oluverdi." (Âl-i İmrân 59) O, beşikte konuşup annesini savundu.',
            'Allah ona kitabı, hikmeti, Tevrat ve İncil\'i öğretti; ölüleri diriltme, körü ve cüzzamlıyı iyileştirme, çamurdan kuş yapıp üfleme mucizeleriyle gönderildi. "Ben, Rabbimin izniyle çamurdan kuş şeklinde bir şey yapar, içine üflerim ve o kuş olur." (Âl-i İmrân 49)',
            'Kavmi onu inkar etti; ama onu öldüremediler: "Onu öldürmediler, asmadılar; fakat (bu) kendilerine benzer gösterildi." (Nisâ 157) Îsâ, insanları tevhide davet etti: "Ey İsrailoğulları! Şüphesiz ben, elimdeki Tevrat\'ı doğrulayıcı ve benden sonra gelecek Ahmed adlı Peygamber\'i müjdeleyici olarak gönderildim." (Sâffât 6)',
          ],
          ayetler: [
            AyetKaydi(
              arapca:
                  'إِنَّ مَثَلَ عِيسَىٰ عِندَ اللَّهِ كَمَثَلِ آدَمَ خَلَقَهُ مِن تُرَابٍ ثُمَّ قَالَ لَهُ كُن فَيَكُونُ',
              meal:
                  'Allah katında Îsâ\'nın örneği, Âdem\'in örneği gibidir: onu topraktan yarattı, sonra ona ol! dedi ve oluverdi.',
              kaynak: 'Âl-i İmrân Suresi, 59. Ayet',
            ),
          ],
          hikmetler: [
            'Îsâ, Allah\'ın kulu ve peygamberidir: tevhid, onun da davetinin özüdür.',
            'Mucizeler, insanı ilahlaştırmak için değil; imanı güçlendirmek için verilir.',
            'Meryem gibi iffetli bir annenin sabrı, kıyamete kadar örnektir.',
          ],
          akademikNotlar: [
            'Nisâ 157\'deki ifade, çarmıh ve haç inancının İslam açısından reddidir; Kur\'an onun Allah katına yükseltildiğini bildirir.',
            'Meryem Suresi, Meryem\'in iffetini ve kavminin iftirasını anlatır; adını ondan alır.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Kur\'an\'a göre Îsâ\'nın durumu hangi peygambere benzetilir?',
              secenekler: ['Nûh\'a', 'Âdem\'e', 'İbrâhîm\'e', 'Mûsâ\'ya'],
              dogruIndex: 1,
            ),
            QuizSoru(
              soru: 'Îsâ hangi peygamberi müjdeledi?',
              secenekler: ['Yahyâ\'yı', 'Ahmed\'i (Hz. Muhammed\'i)', 'Zekeriyyâ\'yı', 'İdrîs\'i'],
              dogruIndex: 1,
            ),
          ],
        ),
      ],
    ),
    KissaGrubu(
      ad: 'Kur\'an\'da Adı Geçmeyen Peygamberler',
      aciklama: 'Şît, Yûşa ve diğerleri: gelenekte yaşayan isimler',
      kisalar: [
        const KissaKaydi(
          id: 'peygamber-sit',
          baslik: 'Hz. Şît',
          ozet:
              'Âdem\'in oğlu, ilk vahye mazhar: barış ve ilim peygamberi.',
          emoji: '🕊️',
          kategoriId: 'peygamberler',
          temalar: ['Ahlak', 'İlim'],
          donem: 'İlk Peygamberler',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Önemi', deger: 'Âdem\'e ilk vahyedilen'),
          ],
          metin: [
            'Şît (a.s.), Kur\'an\'da adı geçmemekle birlikte, Âdem\'in oğlu ve kendisine suhuf (sayfalar) indirilen ilk peygamberdir. Rivayetlerde Âdem\'e "oğlun Şît\'e vahiy indi" diye haber verildiği nakledilir.',
            'Kavmine barışı, ilmi ve dini öğretti; Habil\'in yolunu sürdürdü. İbn Kesîr, Âdem\'den sonra insanlığın hidayet sorumluluğunun Şît\'e geçtiğini kaydeder.',
          ],
          hikmetler: [
            'İlim ve sükunet, barış yolunun öncüleridir: Habil\'in kardeşi Şît de bu yolu izledi.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Şît kimin oğludur?',
              secenekler: ['Nûh\'un', 'Âdem\'in', 'İdrîs\'in', 'İbrâhîm\'in'],
              dogruIndex: 1,
            ),
          ],
        ),
        const KissaKaydi(
          id: 'peygamber-yusa',
          baslik: 'Hz. Yûşa',
          ozet:
              'Mûsâ\'nın talebesi; Arz-ı Mev\'ud\'un kapısını imanla açan önder.',
          emoji: '🏇',
          kategoriId: 'peygamberler',
          temalar: ['Cesaret', 'Sadakat'],
          donem: 'İsrailoğulları Dönemi',
          kimlikKarti: [
            KimlikKarti(alanAdi: 'Görevi', deger: 'Mûsâ\'nın ardılı; İsrailoğullarının önderi'),
            KimlikKarti(alanAdi: 'Kur\'an\'da zikri', deger: 'İsmi geçmez; rivayetlerde zikredilir'),
          ],
          metin: [
            'Yûşa (Yeşu), Kur\'an\'da adı geçmeyen peygamberlerdendir. Mûsâ\'nın öğrencisi ve ardılıydı; Mûsâ vefat ettikten sonra İsrailoğullarına önderlik etti.',
            'Tefsirler, Mâide 23\'teki "içlerinde korku olmadan girebilecekleri kutsal toprağa... girin" diyen iki adamdan birinin Yûşa olduğunu nakleder. Onun döneminde Arz-ı Mev\'ud (Kenan toprakları) fethedildi; Eriha surları iman ve tekbirle yıkıldı.',
            'Güneşe "dur!" diye hitap ettiği rivayet edilen "Şübhân men ehdâ..." hadisiyle de anılır.',
          ],
          hikmetler: [
            'Ardıllık, davanın devamıdır: Yûşa, hocası Mûsâ\'nın azmini taşıdı.',
            'Korku ve inanç yarışı: iki kişi korkmadı, kavim korktu; sebat eden önder olur.',
          ],
          quiz: [
            QuizSoru(
              soru: 'Hz. Yûşa kime halef oldu?',
              secenekler: ['Hz. İlyâs\'a', 'Hz. Mûsâ\'ya', 'Hz. Dâvûd\'a', 'Hz. Süleymân\'a'],
              dogruIndex: 1,
            ),
          ],
        ),
      ],
    ),
  ],
);

void peygamberlerKaydet() => KissalarVerileri.kayitKategori(peygamberlerKategorisi);