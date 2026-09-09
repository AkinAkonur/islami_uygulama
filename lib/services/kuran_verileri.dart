// Kur'an-ı Kerim yerel verileri: Türkçe sure adları, kısa özetler,
// tematik ayetler, günün ayetleri ve özel bölüm verileri.
class SureOzeti {
  final int numara;
  final String turkce;
  final String anlami;
  final String ozet;

  const SureOzeti(this.numara, this.turkce, this.anlami, this.ozet);
}

List<SureOzeti> sureOzetleri = [
  SureOzeti(1, "Fâtiha", "Açılış", "Kur'an'ın özü kabul edilen bu sure, övgü, hamd, ibadet ve hidayet duasını bir arada sunar; her rekâtta okunması vaciptir."),
  SureOzeti(2, "Bakara", "Sığır", "Kur'an'ın en uzun suresi; inanç, ibadet, muamelat, aile hukuku ve cihat konularını kapsayan kapsamlı bir anayasadır. Ayetü'l-Kürsî buradadır."),
  SureOzeti(3, "Âl-i İmrân", "İmrân Ailesi", "Ehl-i kitap ile ilişkiler, tevhid mücadelesi ve Uhud savaşı dersleri; müminlerin sabır ve tevekkülü üzerinde durur."),
  SureOzeti(4, "Nisâ", "Kadınlar", "Aile hukuku, miras payları, kadın hakları ve toplum düzeni; yetimlerin korunmasını emreder."),
  SureOzeti(5, "Mâide", "Sofra", "Helâl-haram hükümleri, ahitlere vefa, kısas ve ehl-i kitap ile ilişkiler; son ilâhî vahyin tamamlayıcı hükümlerini içerir."),
  SureOzeti(6, "En'âm", "Hayvanlar", "Tevhid ve şirk reddi ekseninde Allah'ın varlığı, peygamberlik ve âhiret delillerini anlatır."),
  SureOzeti(7, "A'râf", "Yüksek Yerler", "Âdem'den itibaren peygamberlerin kıssaları, cennet-cehennem ehlinin tasviri ve cennetle cehennem arasındaki A'râf halkı."),
  SureOzeti(8, "Enfâl", "Ganimetler", "Bedir savaşı dersleri, ganimet taksimi ve savaş ahlâkı; Allah'a ve Resûlüne itaat vurgusu."),
  SureOzeti(9, "Tevbe", "Tövbe", "Münafıklarla mücadele, antlaşmaların bozulması ve Tebük seferi; son iki ayeti olmadan birçok hüküm eksik kalır."),
  SureOzeti(10, "Yûnus", "Yûnus Peygamber", "Vahiy ve risalet gerçeği, Yûnus'un (a.s.) kıssası ve Kur'an'ın mucize oluşu işlenir."),
  SureOzeti(11, "Hûd", "Hûd Peygamber", "Nûh, Hûd, Sâlih, Lût, Şuayb ve Mûsâ kıssaları; inkârcıların akıbeti ve müminlerin sabrı anlatılır."),
  SureOzeti(12, "Yûsuf", "Yûsuf Peygamber", "Kur'an'ın en güzel kıssası: kardeş kıskançlığı, iffet imtihanı ve sabırla gelen azizlik makamı."),
  SureOzeti(13, "Ra'd", "Gök Gürültüsü", "Kur'an'ın hak oluşu, kâinat delilleri ve gök gürültüsünün Allah'ı hamd ile tesbih ettiği gerçeği."),
  SureOzeti(14, "İbrâhîm", "İbrâhîm Peygamber", "İbrâhîm'in (a.s.) duası, şükrün artırılması ve inkârcıların amellerinin boşa gitmesi."),
  SureOzeti(15, "Hicr", "Hicr Bölgesi", "Kur'an'ın korunması vaadi, meleklerin İbrâhîm ve Lût'a gelişi ve Sâlih kavminin helâki."),
  SureOzeti(16, "Nahl", "Bal Arısı", "Bal arısı örneğiyle yaratılış delilleri; nimetler, şükür ve hicret konuları işlenir."),
  SureOzeti(17, "İsrâ", "Gece Yürüyüşü", "Miraç olayı, İsrâiloğulları kıssası ve anne-babaya iyilik emri; Kur'an'ın şifa oluşu."),
  SureOzeti(18, "Kehf", "Mağara", "Kehf gençleri, iki bahçe, Mûsâ-Hızır yolculuğu ve Zülkarneyn kıssalarıyla imtihan, ilim ve salih amel dersleri. Cuma günü okunması sünnettir."),
  SureOzeti(19, "Meryem", "Hz. Meryem", "Zekeriyyâ, Yahyâ, Meryem, Îsâ ve diğer peygamberlerin kıssaları; rahmet ve hidayet temaları."),
  SureOzeti(20, "Tâhâ", "Tâhâ", "Mûsâ'nın (a.s.) peygamberlik görevi, Firavun ile mücadelesi ve Âdem kıssası; tevhid çağrısı."),
  SureOzeti(21, "Enbiyâ", "Peygamberler", "Çeşitli peygamberlerin kıssalarından kesitler; Allah'ın birliği ve vahyin birliği vurgusu."),
  SureOzeti(22, "Hac", "Hac", "Hac ibadeti, Kâbe'nin önemi, kurban ve hacda yapılan zikirler; müminlerin ümmet bilinci."),
  SureOzeti(23, "Mü'minûn", "Müminler", "Müminlerin özellikleri sıralanır; iffet, emanet ve namazda huşu gibi ahlâkî olgunluk hedeflenir."),
  SureOzeti(24, "Nûr", "Nur", "İffet ve tesettür hükümleri, iftira olayı ve evlere girme adabı; Allah'ın göklerin nuru olduğu ayet."),
  SureOzeti(25, "Furkân", "Ayırt Edici", "Kur'an'ın hak ile bâtılı ayırt edici oluşu; rahmânın kullarının vasıfları anlatılır."),
  SureOzeti(26, "Şuarâ", "Şairler", "Mûsâ, İbrâhîm, Nûh, Hûd, Sâlih, Lût ve Şuayb kıssaları; şairlerin ahlâkına dikkat çekilir."),
  SureOzeti(27, "Neml", "Karınca", "Süleyman'ın (a.s.) mucizeleri, karınca ile konuşması, Sebe melikesinin imanı ve Hûdhüd kıssası."),
  SureOzeti(28, "Kasas", "Kıssalar", "Mûsâ'nın doğumu, sarayda büyümesi ve Medyen yolculuğu; Kârûn kıssası ile dünyevî malın imtihanı."),
  SureOzeti(29, "Ankebût", "Örümcek", "Örümcek ağına benzetilen bâtıl inançlar; imanın imtihanla sabit olduğu ve hicretin önemi."),
  SureOzeti(30, "Rûm", "Rumlar", "Rumların zaferiyle ilgili gayb haberleri; yaratılış delilleri ve fıtrat dini."),
  SureOzeti(31, "Lokmân", "Lokmân Hekim", "Lokmân'ın (a.s.) oğluna nasihatleri: şirk yasağı, ana-babaya iyilik, namaz ve sabır."),
  SureOzeti(32, "Secde", "Secde", "Yaratılış delilleri, kıyamet sahneleri ve secde ayeti; geceleri ibadet edenlerin hâli."),
  SureOzeti(33, "Ahzâb", "Topluluklar", "Hendek savaşı, peygamber eşlerinin örnekliği, tesettür ve aile hukuku; Peygamber'e itaat."),
  SureOzeti(34, "Sebe'", "Sebe' Kavmi", "Süleyman'ın (a.s.) kıssası ve Sebe' halkının nankörlüğü; âhiret inancının delilleri."),
  SureOzeti(35, "Fâtır", "Yaratıcı", "Yaratılıştaki nizam ve deliller; Kur'an'ı okuyanların ve onu uygulayanların mükâfatı."),
  SureOzeti(36, "Yâsîn", "Yâsîn", "Kur'an'ın kalbi olarak anılır; vahiy, peygamberlik ve âhiret gerçeğini güçlü üslupla işler. Ölülerin başında okunması âdettendir."),
  SureOzeti(37, "Sâffât", "Sıralananlar", "Meleklerin saffı, şeytanların kovuluşu ve peygamber kıssaları; cehennem ehlinin hâli."),
  SureOzeti(38, "Sâd", "Sâd", "Davud ve Süleyman kıssaları, Eyüp'ün sabrı; şeytanın Âdem'e secde etmeyişi ve kibri."),
  SureOzeti(39, "Zümer", "Zümreler", "Tevhidin saf hâli; kulların kaderde Allah'a tevekkülü ve cennet-cehennem zümreleri."),
  SureOzeti(40, "Mü'min", "Mümin", "Firavun ailesinden iman eden gizli bir müminin kıssası; Allah'ın rahmetinden ümit kesilmemesi."),
  SureOzeti(41, "Fussilet", "Ayrıntılı Açıklanan", "Vahiy ve Kur'an'ın özellikleri; secde ayeti ve âhiret sahneleri işlenir."),
  SureOzeti(42, "Şûrâ", "Danışma", "Vahyin gelişi, müminlerin işlerini danışarak yapmaları ve Allah'ın affediciliği."),
  SureOzeti(43, "Zuhruf", "Süsler", "Kur'an'ın Arapça oluşu, Mekkeli müşriklerin itirazları ve İbrâhîm'in tevhid mücadelesi."),
  SureOzeti(44, "Duhân", "Duman", "Kıyamet günü göğü kaplayacak duman; Firavun kavminin helâki ve kadir gecesinin önemi."),
  SureOzeti(45, "Câsiye", "Diz Çökenler", "Kıyamette her ümmetin diz çökeceği sahne; Kur'an'ın hak oluşu ve yaratılış delilleri."),
  SureOzeti(46, "Ahkâf", "Kum Tepeleri", "Âd kavminin helâki ve cinlerin Kur'an dinleyip iman etmeleri; hicret tavsiyesi."),
  SureOzeti(47, "Muhammed", "Hz. Muhammed", "Savaş hukuku, esirlerin durumu ve müminlerin ahlâkı; cennet tasvirleriyle süslenir."),
  SureOzeti(48, "Fetih", "Fetih", "Hudeybiye antlaşması ve Mekke'nin fetih müjdesi; imanın kalbe yerleşmesi ve itaat."),
  SureOzeti(49, "Hucurât", "Odalar", "Edep ve ahlâk suresi: Peygamber'in yanında edep, müminlerin kardeşliği, gıybet ve tecessüs yasağı."),
  SureOzeti(50, "Kâf", "Kâf", "Ölümden sonra dirilme delilleri, insanın içinden geçenleri bilen Allah; kıyamet sahneleri."),
  SureOzeti(51, "Zâriyât", "Savuran Rüzgârlar", "Yeminlerle başlayan sure; yaratılış delilleri, İbrâhîm misafirleri ve rızık teminatı."),
  SureOzeti(52, "Tûr", "Tûr Dağı", "Mûsâ'ya verilen Tûr'daki vahiy; cennet ehlinin nimetleri ve cehennem azabı."),
  SureOzeti(53, "Necm", "Yıldız", "Miraç'ta görülen vahiy gerçeği, Lat-Menât gibi putların reddi ve şefaat hakkının yalnız Allah'a ait olması."),
  SureOzeti(54, "Kamer", "Ay", "Ayın yarılması mucizesi; Nûh, Âd, Semûd, Lût ve Firavun kavimlerinin helâk ibretleri."),
  SureOzeti(55, "Rahmân", "Rahmân", "Allah'ın sayısız nimetleri sayılır: 'O hâlde Rabbinizin hangi nimetlerini yalanlarsınız?' tekrarlanır."),
  SureOzeti(56, "Vâkıa", "Gerçekleşen", "Kıyametin kesinliği; öne geçenler, sağdakiler ve soldakiler olmak üzere üç sınıf insan."),
  SureOzeti(57, "Hadîd", "Demir", "Demirin indirilişi ve kuvveti; infak, tesbih ve dünya hayatının aldatıcılığı."),
  SureOzeti(58, "Mücâdele", "Tartışan Kadın", "Zıhar olayı, karı-koca anlaşmazlıkları ve gizli konuşma adabı; Allah'ın her şeyi işittiği."),
  SureOzeti(59, "Haşr", "Toplanma", "Benî Nadîr yahudilerinin sürgünü; ganimet hukuku ve son iki ayette Allah'ın güzel isimleri."),
  SureOzeti(60, "Mümtehine", "İmtihan Edilen", "Mümin kadınların hicreti ve imtihanı; düşmanlarla dostluk kurma yasağı."),
  SureOzeti(61, "Saff", "Saf", "Allah'ın sevmediği söz-amel uyumsuzluğu; Mûsâ ve Îsâ'nın ümmetlerinden ibretler."),
  SureOzeti(62, "Cum'a", "Cuma", "Cuma namazı ve hutbe adabı; ticaret için ezandan önce çağrıya icabet edilmesi."),
  SureOzeti(63, "Münafikûn", "Münafıklar", "Münafıkların vasıfları ve hileleri; onlardan gelen haberlerde dikkatli olunması."),
  SureOzeti(64, "Tegâbün", "Karşılıklı Aldanma", "Kıyamette karşılıklı pişmanlık sahnesi; Allah'a ve Resûlüne itaat, infak öğüdü."),
  SureOzeti(65, "Talâk", "Boşanma", "İddet hükümleri ve boşanma hukuku; kim Allah'a tevekkül ederse Allah ona yeter."),
  SureOzeti(66, "Tahrîm", "Haram Kılma", "Peygamber hanımlarıyla ilgili bir olay; tövbe, ihlas ve takva dersleri."),
  SureOzeti(67, "Mülk", "Mülk", "Mülkün ve ölümün yaratılışı; her gece okunması tavsiye edilen sure, kabir azabından korunmaya vesile olur."),
  SureOzeti(68, "Kalem", "Kalem", "Kaleme ve yazdıklarına yemin; Peygamber'in ahlâkının yüceliği ve bahçe sahipleri kıssası."),
  SureOzeti(69, "Hâkka", "Gerçekleşen", "Kıyamet gerçeğinin dehşeti; Ad, Semûd, Firavun ve Nûh kavimlerinin helâki."),
  SureOzeti(70, "Meâric", "Yükselme Dereceleri", "Azabın acele istenmesi; meleklerin ve ruhun Allah'a yükselişi, namaza devam edenlerin vasıfları."),
  SureOzeti(71, "Nûh", "Nûh Peygamber", "Nûh'un (a.s.) 950 yıllık tebliğ mücadelesi ve kavmine yaptığı dua; günahların affı için istiğfar."),
  SureOzeti(72, "Cin", "Cinler", "Cinlerin Kur'an'ı dinleyip iman etmeleri; vahiy koruması ve Allah'ın hiçbir şeyi gizli bırakmadığı."),
  SureOzeti(73, "Müzzemmil", "Örtünen", "Gece namazına kalkma emri; Kur'an'ı tane tane okuma ve sabır tavsiyesi."),
  SureOzeti(74, "Müddessir", "Bürünen", "Peygamber'e bürünüp örtünme emri; uyarı, tekbir ve temizlik; cehennem bekçileri."),
  SureOzeti(75, "Kıyâmet", "Kıyamet", "Kıyametin dehşeti, kemiklerin birleştirilmesi ve o gün yüzlerin Rabbe bakması."),
  SureOzeti(76, "İnsân", "İnsan", "İnsanın yaratılışı ve imtihanı; ebrârın (iyilerin) cennetteki nimetleri ve şükür."),
  SureOzeti(77, "Mürselât", "Gönderilenler", "Ard arda gönderilen rüzgârlara yemin; o gün vay yalanlayanların hâline, cennet-cehennem sahneleri."),
  SureOzeti(78, "Nebe'", "Büyük Haber", "Kıyamet haberi, ölümden sonra diriliş tartışması ve cennet-cehennem tasvirleri. Amme cüzünün başıdır."),
  SureOzeti(79, "Nâziât", "Çekip Çıkaranlar", "Meleklerin can alışına yemin; Mûsâ ve Firavun kıssası, kıyametin zamanı."),
  SureOzeti(80, "Abese", "Yüzünü Ekşitti", "Peygamber'in âmâ sahabiye yönelik ilgisizliğinin uyarısı; Kur'an'ın hatırlatma olduğu."),
  SureOzeti(81, "Tekvîr", "Dürülme", "Güneşin dürülmesi, yıldızların sönmesi; vahyin gerçekliği ve nefse karşı uyarı."),
  SureOzeti(82, "İnfitâr", "Yarılma", "Göğün yarılması, yıldızların dağılması; her nefsin yanındaki koruyucu melekler."),
  SureOzeti(83, "Mutaffifîn", "Eksik Tartanlar", "Ölçü ve tartıda hile yapanların azabı; illiyyûn ve siccîn defterleri."),
  SureOzeti(84, "İnşikâk", "Yarılış", "Göğün yarılışı ve dünyanın düzleneceği an; amel defterinin sağdan veya arkadan verilişi."),
  SureOzeti(85, "Bürûc", "Burçlar", "Burçlar sahibi göğe yemin; Ashab-ı Uhud'un (hendekte yakılan müminler) kıssası."),
  SureOzeti(86, "Târık", "Târık Yıldızı", "Gece gelen yıldıza yemin; insanın meniden yaratılışı ve koruyucu melekler."),
  SureOzeti(87, "A'lâ", "En Yüce", "Rabbinin adını tesbih et; yaratıp düzenleyen, takdir edip doğru yolu gösteren Allah."),
  SureOzeti(88, "Gâşiye", "Kuşatan", "Kıyametin herkesi kuşatışı; cennet ve cehennem ehlinin tasviri."),
  SureOzeti(89, "Fecr", "Şafak", "Fecr vaktine yemin; Âd, Semûd ve Firavun kavimlerinin helâki; nefs-i mutmainne."),
  SureOzeti(90, "Beled", "Şehir", "Mekke şehrine yemin; insanın zorluk içinde yaratıldığı ve sarp yokuşun (akabe) ne olduğu."),
  SureOzeti(91, "Şems", "Güneş", "Güneşe ve nefse yemin; nefsini arındıranın kurtuluşu, Semûd kavminin helâki."),
  SureOzeti(92, "Leyl", "Gece", "Geceye yemin; infak edip sakınanın kurtuluşu, cimrilik yapanın azabı."),
  SureOzeti(93, "Duhâ", "Kuşluk Vakti", "Yetimliğe, yolunu kaybetmişliğe rağmen Allah'ın nimetleri; şükür ve ihsan öğüdü."),
  SureOzeti(94, "İnşirâh", "Ferahlık", "Zorlukla beraber kolaylık; göğsün açılması ve yüce adın anılması. Her zorlukla beraber bir kolaylık vardır."),
  SureOzeti(95, "Tîn", "İncir", "İncir, zeytin ve Tûr dağına yemin; insanın en güzel kıvamda yaratılışı."),
  SureOzeti(96, "Alak", "Asılan Cenin", "İlk vahiy: 'Yaratan Rabbinin adıyla oku!' İnsanın alaktan yaratılışı ve kalemle öğretme."),
  SureOzeti(97, "Kadir", "Kadir Gecesi", "Kadir gecesinin bin aydan hayırlı olduğu ve meleklerin o gece yeryüzüne inişi."),
  SureOzeti(98, "Beyyine", "Açık Delil", "Ehl-i kitabın ve müşriklerin ayrılığı; apaçık delil olan Resûl ve arınmışların mükâfatı."),
  SureOzeti(99, "Zilzâl", "Deprem", "Yerin sarsılması, ağırlıklarını çıkarması; zerre kadar hayır ve şerrin karşılığının verileceği."),
  SureOzeti(100, "Âdiyât", "Koşan Atlar", "Savaş atlarına yemin; insanın nankörlüğü ve kabirde olanların bilinmesi."),
  SureOzeti(101, "Kâria", "Çarpıntı", "Yürekleri hoplatan büyük felaket; amellerin tartılması ve güzel huyluların hâli."),
  SureOzeti(102, "Tekâsür", "Çoklukla Övünme", "Çokluk yarışının insanı oyaladığı; kabre kadar süren dünya hırsı ve o gün nimetlerin sorulacağı."),
  SureOzeti(103, "Asr", "Zaman", "Zamana yemin; insanın hüsranda olduğu, ancak iman edip salih amel işleyen, hakkı ve sabrı tavsiye edenler hariç."),
  SureOzeti(104, "Hümeze", "Arkadan Çekiştiren", "Arkadan çekiştirip kaş göz işareti yapanların azabı; Hutame cehennemine atılmaları."),
  SureOzeti(105, "Fîl", "Fil", "Fil ordusunun helâki; Kâbe'yi yıkmak isteyen Ebrehe ordusuna ebâbil kuşları gönderildi."),
  SureOzeti(106, "Kureyş", "Kureyş", "Kureyş'in kış ve yaz yolculuklarında güvende olması; bu evin Rabbine kulluk emri."),
  SureOzeti(107, "Mâûn", "Yardımlaşma", "Dini yalanlayanların vasıfları; yetimi itip kakan ve namazından gafil olanlara yazıklar olsun."),
  SureOzeti(108, "Kevser", "Kevser", "Kevser havzı ve bolluk müjdesi; Peygamber'i kötüleyenin soyunun kesik kalacağı."),
  SureOzeti(109, "Kâfirûn", "İnkârcılar", "İhlâs suresiyle birlikte namazda sık okunur; 'Sizin dininiz size, benim dinim bana.'"),
  SureOzeti(110, "Nasr", "Yardım", "Allah'ın yardımı ve fetih geldiğinde insanların bölük bölük dine girişi; tesbih ve istiğfar."),
  SureOzeti(111, "Mesed", "Hurma Lifleri", "Ebû Leheb ve karısının azabı; onun malı ve kazandıkları kendine fayda vermeyecek."),
  SureOzeti(112, "İhlâs", "Tevhid", "Kur'an'ın üçte birine denk sayılan sure: De ki O Allah birdir, Allah Samed'dir, doğurmadı ve doğurulmadı."),
  SureOzeti(113, "Felak", "Sabah Aydınlığı", "Sığınma suresi: karanlığın, düğümlere üfleyenlerin ve hasetçilerin şerrinden Allah'a sığınma."),
  SureOzeti(114, "Nâs", "İnsanlar", "Sığınma suresi: vesvese veren sinsi şeytanın şerrinden insanların Rabbine, Melikine ve İlâhına sığınma."),
];

String sureAdiTurkce(int numara) {
  return sureOzetleri
      .firstWhere((s) => s.numara == numara, orElse: () => SureOzeti(numara, "Sure $numara", "", ""))
      .turkce;
}

String sureAnlami(int numara) {
  return sureOzetleri
      .firstWhere((s) => s.numara == numara, orElse: () => SureOzeti(numara, "", "", ""))
      .anlami;
}

String sureOzetiMetni(int numara) {
  return sureOzetleri
      .firstWhere((s) => s.numara == numara, orElse: () => SureOzeti(numara, "", "", ""))
      .ozet;
}

// Cüz başlangıç bilgileri (cüz numarası -> başlangıç suresi)
Map<int, String> cuzBaslangic = {
  1: "Fâtiha Suresi (1)",
  2: "Bakara Suresi (2) - 142. âyet",
  3: "Bakara Suresi (2) - 253. âyet",
  4: "Âl-i İmrân Suresi (3) - 93. âyet",
  5: "Nisâ Suresi (4) - 24. âyet",
  6: "Nisâ Suresi (4) - 148. âyet",
  7: "Mâide Suresi (5) - 82. âyet",
  8: "En'âm Suresi (6) - 111. âyet",
  9: "A'râf Suresi (7) - 88. âyet",
  10: "Enfâl Suresi (8) - 41. âyet",
  11: "Tevbe Suresi (9) - 93. âyet",
  12: "Hûd Suresi (11) - 6. âyet",
  13: "Yûsuf Suresi (12) - 53. âyet",
  14: "Hicr Suresi (15) - 1. âyet",
  15: "İsrâ Suresi (17) - 1. âyet",
  16: "Kehf Suresi (18) - 75. âyet",
  17: "Enbiyâ Suresi (21) - 1. âyet",
  18: "Mü'minûn Suresi (23) - 1. âyet",
  19: "Furkân Suresi (25) - 21. âyet",
  20: "Neml Suresi (27) - 56. âyet",
  21: "Ankebût Suresi (29) - 46. âyet",
  22: "Ahzâb Suresi (33) - 31. âyet",
  23: "Yâsîn Suresi (36) - 28. âyet",
  24: "Zümer Suresi (39) - 32. âyet",
  25: "Fussilet Suresi (41) - 47. âyet",
  26: "Ahkâf Suresi (46) - 1. âyet",
  27: "Zâriyât Suresi (51) - 31. âyet",
  28: "Mücâdele Suresi (58) - 1. âyet",
  29: "Mülk Suresi (67) - 1. âyet",
  30: "Nebe' Suresi (78) - 1. âyet (Amme)",
};

// Namazda okunan kısa sureler (Amme cüzü seçkisi)
List<Map<String, Object>> kisaSureler = [
  {"no": 1, "ad": "Fâtiha", "not": "Her rekâtta okunur (vacip)"},
  {"no": 112, "ad": "İhlâs", "not": "Kur'an'ın üçte birine denk"},
  {"no": 113, "ad": "Felak", "not": "Sığınma suresi"},
  {"no": 114, "ad": "Nâs", "not": "Sığınma suresi"},
  {"no": 108, "ad": "Kevser", "not": "En kısa sure"},
  {"no": 103, "ad": "Asr", "not": "Zamana yemin"},
  {"no": 109, "ad": "Kâfirûn", "not": "İhlâs ile birlikte okunur"},
  {"no": 110, "ad": "Nasr", "not": "Fetih müjdesi"},
  {"no": 111, "ad": "Mesed (Leheb)", "not": "Ebû Leheb kıssası"},
  {"no": 105, "ad": "Fîl", "not": "Fil ordusunun helâki"},
  {"no": 106, "ad": "Kureyş", "not": "Kureyş kabilesi"},
  {"no": 107, "ad": "Mâûn", "not": "Yardımlaşma ahlâkı"},
  {"no": 97, "ad": "Kadir", "not": "Kadir gecesi"},
  {"no": 98, "ad": "Beyyine", "not": "Açık delil"},
  {"no": 99, "ad": "Zilzâl", "not": "Deprem suresi"},
  {"no": 100, "ad": "Âdiyât", "not": "Koşan atlar"},
  {"no": 101, "ad": "Kâria", "not": "Büyük felaket"},
  {"no": 102, "ad": "Tekâsür", "not": "Çoklukla övünme"},
  {"no": 104, "ad": "Hümeze", "not": "Arkadan çekiştiren"},
];

// Özel gün ve zamanların sureleri (hadis ve rivayetlere dayalı)
List<Map<String, Object>> ozelGunSureleri = [
  {"no": 18, "ad": "Kehf", "not": "Cuma günü okunması sünnettir; Deccal fitnesinden korur (Suyûtî, el-Câmiu's-Sağir)."},
  {"no": 67, "ad": "Mülk (Tebâreke)", "not": "Her gece okunması tavsiye edilir; kabir azabından korur."},
  {"no": 36, "ad": "Yâsîn", "not": "Kur'an'ın kalbidir; kandillerde, ölülerin başında ve şifa niyetiyle okunur."},
  {"no": 56, "ad": "Vâkıa", "not": "Fakirlikten koruduğuna inanılır; kıyamet ahvalini anlatır."},
  {"no": 112, "ad": "İhlâs", "not": "Arefe günü bin defa okunması tavsiye edilir; Her namazda ve gece yatarken okunur."},
  {"no": 78, "ad": "Nebe (Amme)", "not": "Cuma ve kandil gecelerinin meşhur surelerinden; rızkı bereketlendirdiği rivayet edilir."},
  {"no": 97, "ad": "Kadir", "not": "Kadir gecesi özel okunur; o gece bin aydan daha hayırlıdır."},
  {"no": 44, "ad": "Duhân", "not": "İçinde 'mübarek gece' ifadesi geçtiği için Berat kandilinde sık okunur (Duhân 44/3-4)."},
  {"no": 48, "ad": "Fetih", "not": "Berat gecesi, zorluklardan sonra ve hayırlı kapıların açılması için okunur."},
  {"no": 55, "ad": "Rahman", "not": "Mübarek gecelerde ve hastalara şifa niyetiyle okunur; nimetlere şükür suresidir."},
  {"no": 17, "ad": "İsrâ", "not": "Miraç hadisesinin anlatıldığı sure; Miraç gecesinde okunması tavsiye edilir."},
  {"no": 11, "ad": "Hûd", "not": "'Cuma günü Hûd suresini okuyunuz' buyurulmuştur (Dârimî, Fezâilü'l-Kur'ân 17)."},
  {"no": 99, "ad": "Zilzâl", "not": "Perşembeyi cumaya bağlayan gece on beş defa okumanın fazileti rivayet edilir."},
  {"no": 113, "ad": "Felak", "not": "Cuma namazından sonra İhlâs, Felak ve Nâs yedişer defa okunur; korunma suresidir."},
  {"no": 114, "ad": "Nâs", "not": "Gece yatarken ve sabah okunur; sığınma (muavvizât) suresidir."},
  {"no": 109, "ad": "Kâfirûn", "not": "Arefe ve nâfile namazlarda sık okunur; şirkten arınmayı öğretir."},
  {"no": 76, "ad": "İnsân (Dehr)", "not": "Peygamberimiz Cuma namazında Secde ve İnsân surelerini okurdu."},
  {"no": 32, "ad": "Secde", "not": "Cuma namazında okunan surelerden; secde âyeti bulundurur."},
  {"no": 69, "ad": "Hâkka", "not": "Hûd suresi ile birlikte anılan kardeş surelerden; Cuma günü okunması tavsiye edilir."},
  {"no": 77, "ad": "Mürselât", "not": "Hûd suresi kardeşlerinden; kıyameti ders verir, Cuma günü okunur."},
  {"no": 81, "ad": "Tekvîr", "not": "Hûd suresi kardeşlerinden; Cuma günü okunması tavsiye edilir."},
  {"no": 2, "ad": "Bakara (son 2 âyet)", "not": "'Âmenerrasûlü' son iki âyeti Miraç gecesinde nazil olmuştur; gece okunması kişiye yeter."},
];

// Tematik ayet paketleri
class TematikPaket {
  final String baslik;
  final String ikon;
  final List<String> ayetler; // "sure:ayet" biçiminde
  const TematikPaket(this.baslik, this.ikon, this.ayetler);
}

List<TematikPaket> tematikPaketler = [
  TematikPaket("Sabır", "🛡️", ["2:45", "2:153", "3:200", "94:5", "94:6"]),
  TematikPaket("Tövbe & İstiğfar", "🤲", ["39:53", "66:8", "71:10", "11:3", "2:222"]),
  TematikPaket("Rızık & Geçim", "🌾", ["11:6", "65:2", "65:3", "51:22", "29:62"]),
  TematikPaket("Anne & Baba", "👨‍👩‍👧", ["17:23", "17:24", "31:14", "46:15", "14:41"]),
  TematikPaket("Huzur & Gönül Rahatlığı", "🕊️", ["13:28", "8:2", "3:139", "2:286", "13:28"]),
  TematikPaket("Şükür", "🌹", ["14:7", "2:152", "16:18", "2:172", "27:40"]),
  TematikPaket("Merhamet", "💚", ["21:107", "6:54", "7:156", "3:159", "24:22"]),
  TematikPaket("Kaygı & Endişe", "🌤️", ["9:40", "65:3", "13:28", "2:62", "12:87"]),
  TematikPaket("Duânın Önemi", "🙏", ["40:60", "2:186", "25:77", "7:55", "40:60"]),
  TematikPaket("Ahlâk & Güzel Söz", "💬", ["41:34", "33:70", "4:114", "49:12", "23:96"]),
];

// Günün ayetleri (her gün otomatik döner)
List<Map<String, String>> gununAyetleri = [
  {
    "arabic": "إِنَّ مَعَ الْعُسْرِ يُسْرًا",
    "translation": "Şüphesiz her zorlukla beraber bir kolaylık vardır.",
    "reference": "İnşirâh Suresi, 6. Ayet"
  },
  {
    "arabic": "أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ",
    "translation": "Bilesiniz ki, kalpler ancak Allah'ı anmakla huzur bulur.",
    "reference": "Ra'd Suresi, 28. Ayet"
  },
  {
    "arabic": "فَاذْكُرُونِي أَذْكُرْكُمْ",
    "translation": "Öyleyse beni anın ki ben de sizi anayım.",
    "reference": "Bakara Suresi, 152. Ayet"
  },
  {
    "arabic": "لَئِن شَكَرْتُمْ لَأَزِيدَنَّكُمْ",
    "translation": "Andolsun, eğer şükrederseniz elbette size nimetimi artırırım.",
    "reference": "İbrâhîm Suresi, 7. Ayet"
  },
  {
    "arabic": "وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ",
    "translation": "Kim Allah'a tevekkül ederse, O, kendisine yeter.",
    "reference": "Talâk Suresi, 3. Ayet"
  },
  {
    "arabic": "لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ",
    "translation": "Allah'ın rahmetinden ümidinizi kesmeyin.",
    "reference": "Zümer Suresi, 53. Ayet"
  },
  {
    "arabic": "لَا يُكَلِّفُ اللَّهُ نَفْسًا إِلَّا وُسْعَهَا",
    "translation": "Allah, hiç kimseye gücünün üstünde bir yük yüklemez.",
    "reference": "Bakara Suresi, 286. Ayet"
  },
  {
    "arabic": "قُلْ يَا عِبَادِيَ الَّذِينَ أَسْرَفُوا عَلَىٰ أَنفُسِهِمْ لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ",
    "translation": "De ki: Ey kendilerine zulmeden kullarım! Allah'ın rahmetinden ümit kesmeyin.",
    "reference": "Zümer Suresi, 53. Ayet"
  },
  {
    "arabic": "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ",
    "translation": "Rabbimiz! Bize dünyada da iyilik ver, âhirette de iyilik ver ve bizi ateş azabından koru.",
    "reference": "Bakara Suresi, 201. Ayet"
  },
  {
    "arabic": "الَّذِينَ آمَنُوا وَتَطْمَئِنُّ قُلُوبُهُم بِذِكْرِ اللَّهِ",
    "translation": "Onlar iman edenlerdir ve kalpleri Allah'ı anmakla huzura kavuşur.",
    "reference": "Ra'd Suresi, 28. Ayet"
  },
];

// Kur'an okuma adabı
List<Map<String, String>> kuranAdabi = [
  {"baslik": "Abdestli Olmak", "detay": "Mushaf'a abdestsiz dokunulmaz. Hanefî mezhebine göre elini sürmekten sakınmak şarttır. Teyemmüm ile de bu temizlik sağlanabilir."},
  {"baslik": "Temiz Yer ve Kıbleye Yönelme", "detay": "Kur'an okunacak ortamın temiz olmasına dikkat edilir. Mümkünse kıbleye yönelerek okumak edeptendir."},
  {"baslik": "Eûzü ve Besmele", "detay": "Okumaya 'Eûzü billâhi mine'ş-şeytâni'r-racîm' ve 'Bismillâhirrahmânirrahîm' ile başlanır. Bu, okumayı şeytanın vesvesesinden arındırır."},
  {"baslik": "Tertil ile Okumak", "detay": "Kur'an'ı acele etmeden, harfleri doğru ve hakkını vererek (tertil üzere) okumak emredilmiştir. (Müzzemmil 73/4)"},
  {"baslik": "Okunurken Konuşmamak", "detay": "Kur'an okunurken başka işlerle meşgul olmak ve lüzumsuz konuşmak edebe aykırıdır. Dinleyenlerin de susup dinlemesi gerekir."},
  {"baslik": "Secde Ayetlerinde Secde", "detay": "Kur'an'da 15 secde âyeti vardır. Bu âyetler okunduğunda veya duyulduğunda tilâvet secdesi yapılır."},
  {"baslik": "Mushaf'ı Yüksekte Tutmak", "detay": "Mushaf'ı yere koymamak, yüksek ve temiz bir yere koymak, kapatırken üzerine başka kitap koymamak edeptendir."},
  {"baslik": "Ölçülü Sesle Okumak", "detay": "Başkalarını rahatsız etmeyecek, ancak kişinin kendisinin de duyabileceği bir ses tonu tercih edilir."},
  {"baslik": "Uykulu ve Yorgunken Okumamak", "detay": "Dikkat dağınıklığı olan, uykulu veya dalgın hâldeyken okumak, anlamı kaçırmaya sebep olur. Dinç ve hazır bir zihinle okunmalıdır."},
  {"baslik": "Tefsirini ve Meâlini Okumak", "detay": "Kur'an'ın anlaşılarak okunması asıl hedeftir. Meâl ve tefsir okuyarak âyetlerin anlamı üzerinde düşünmek (tedebbür) büyük sevaptır."},
];

// Karîler (sesli okuma seçenekleri)
class Kari {
  final String id; // API edisyon kodu
  final String ad;
  const Kari(this.id, this.ad);
}

List<Kari> kariler = [
  Kari("ar.abdurrahmaansudais", "Abdurrahman Sudeys"),
  Kari("ar.alafasy", "Mişari Reşid Alafasy"),
  Kari("ar.mahermuaiqly", "Mâher el-Muaykılî"),
  Kari("ar.abdulbasitmurattal", "Abdulbasit Abdussamed"),
  Kari("ar.husary", "Mahmûd Halil el-Husarî"),
];

// Meâl seçenekleri
class Meal {
  final String id;
  final String ad;
  const Meal(this.id, this.ad);
}

List<Meal> mealler = [
  Meal("tr.diyanet", "Diyanet İşleri"),
  Meal("tr.vakfi", "Diyanet Vakfı"),
  Meal("tr.yazir", "Elmalılı Hamdi Yazır"),
  Meal("tr.bulac", "Ali Bulaç"),
  Meal("tr.ates", "Süleyman Ateş"),
];

// Yerel sure verileri: [numara, arapça adı, ayet sayısı, iniş yeri (Mekkî/Medenî)]
// İnternet yokken 114 surelik listenin çalışmasını sağlar.
class SureKayit {
  final int numara;
  final String arapcaAdi;
  final int ayetSayisi;
  final String inisYeri;
  const SureKayit(this.numara, this.arapcaAdi, this.ayetSayisi, this.inisYeri);
}

const List<SureKayit> sureKayitlari = [
  SureKayit(1, "الفاتحة", 7, "Mekkî"),
  SureKayit(2, "البقرة", 286, "Medenî"),
  SureKayit(3, "آل عمران", 200, "Medenî"),
  SureKayit(4, "النساء", 176, "Medenî"),
  SureKayit(5, "المائدة", 120, "Medenî"),
  SureKayit(6, "الأنعام", 165, "Mekkî"),
  SureKayit(7, "الأعراف", 206, "Mekkî"),
  SureKayit(8, "الأنفال", 75, "Medenî"),
  SureKayit(9, "التوبة", 129, "Medenî"),
  SureKayit(10, "يونس", 109, "Mekkî"),
  SureKayit(11, "هود", 123, "Mekkî"),
  SureKayit(12, "يوسف", 111, "Mekkî"),
  SureKayit(13, "الرعد", 43, "Medenî"),
  SureKayit(14, "إبراهيم", 52, "Mekkî"),
  SureKayit(15, "الحجر", 99, "Mekkî"),
  SureKayit(16, "النحل", 128, "Mekkî"),
  SureKayit(17, "الإسراء", 111, "Mekkî"),
  SureKayit(18, "الكهف", 110, "Mekkî"),
  SureKayit(19, "مريم", 98, "Mekkî"),
  SureKayit(20, "طه", 135, "Mekkî"),
  SureKayit(21, "الأنبياء", 112, "Mekkî"),
  SureKayit(22, "الحج", 78, "Medenî"),
  SureKayit(23, "المؤمنون", 118, "Mekkî"),
  SureKayit(24, "النور", 64, "Medenî"),
  SureKayit(25, "الفرقان", 77, "Mekkî"),
  SureKayit(26, "الشعراء", 227, "Mekkî"),
  SureKayit(27, "النمل", 93, "Mekkî"),
  SureKayit(28, "القصص", 88, "Mekkî"),
  SureKayit(29, "العنكبوت", 69, "Mekkî"),
  SureKayit(30, "الروم", 60, "Mekkî"),
  SureKayit(31, "لقمان", 34, "Mekkî"),
  SureKayit(32, "السجدة", 30, "Mekkî"),
  SureKayit(33, "الأحزاب", 73, "Medenî"),
  SureKayit(34, "سبأ", 54, "Mekkî"),
  SureKayit(35, "فاطر", 45, "Mekkî"),
  SureKayit(36, "يس", 83, "Mekkî"),
  SureKayit(37, "الصافات", 182, "Mekkî"),
  SureKayit(38, "ص", 88, "Mekkî"),
  SureKayit(39, "الزمر", 75, "Mekkî"),
  SureKayit(40, "غافر", 85, "Mekkî"),
  SureKayit(41, "فصلت", 54, "Mekkî"),
  SureKayit(42, "الشورى", 53, "Mekkî"),
  SureKayit(43, "الزخرف", 89, "Mekkî"),
  SureKayit(44, "الدخان", 59, "Mekkî"),
  SureKayit(45, "الجاثية", 37, "Mekkî"),
  SureKayit(46, "الأحقاف", 35, "Mekkî"),
  SureKayit(47, "محمد", 38, "Medenî"),
  SureKayit(48, "الفتح", 29, "Medenî"),
  SureKayit(49, "الحجرات", 18, "Medenî"),
  SureKayit(50, "ق", 45, "Mekkî"),
  SureKayit(51, "الذاريات", 60, "Mekkî"),
  SureKayit(52, "الطور", 49, "Mekkî"),
  SureKayit(53, "النجم", 62, "Mekkî"),
  SureKayit(54, "القمر", 55, "Mekkî"),
  SureKayit(55, "الرحمن", 78, "Medenî"),
  SureKayit(56, "الواقعة", 96, "Mekkî"),
  SureKayit(57, "الحديد", 29, "Medenî"),
  SureKayit(58, "المجادلة", 22, "Medenî"),
  SureKayit(59, "الحشر", 24, "Medenî"),
  SureKayit(60, "الممتحنة", 13, "Medenî"),
  SureKayit(61, "الصف", 14, "Medenî"),
  SureKayit(62, "الجمعة", 11, "Medenî"),
  SureKayit(63, "المنافقون", 11, "Medenî"),
  SureKayit(64, "التغابن", 18, "Medenî"),
  SureKayit(65, "الطلاق", 12, "Medenî"),
  SureKayit(66, "التحريم", 12, "Medenî"),
  SureKayit(67, "الملك", 30, "Mekkî"),
  SureKayit(68, "القلم", 52, "Mekkî"),
  SureKayit(69, "الحاقة", 52, "Mekkî"),
  SureKayit(70, "المعارج", 44, "Mekkî"),
  SureKayit(71, "نوح", 28, "Mekkî"),
  SureKayit(72, "الجن", 28, "Mekkî"),
  SureKayit(73, "المزمل", 20, "Mekkî"),
  SureKayit(74, "المدثر", 56, "Mekkî"),
  SureKayit(75, "القيامة", 40, "Mekkî"),
  SureKayit(76, "الإنسان", 31, "Medenî"),
  SureKayit(77, "المرسلات", 50, "Mekkî"),
  SureKayit(78, "النبأ", 40, "Mekkî"),
  SureKayit(79, "النازعات", 46, "Mekkî"),
  SureKayit(80, "عبس", 42, "Mekkî"),
  SureKayit(81, "التكوير", 29, "Mekkî"),
  SureKayit(82, "الانفطار", 19, "Mekkî"),
  SureKayit(83, "المطففين", 36, "Mekkî"),
  SureKayit(84, "الانشقاق", 25, "Mekkî"),
  SureKayit(85, "البروج", 22, "Mekkî"),
  SureKayit(86, "الطارق", 17, "Mekkî"),
  SureKayit(87, "الأعلى", 19, "Mekkî"),
  SureKayit(88, "الغاشية", 26, "Mekkî"),
  SureKayit(89, "الفجر", 30, "Mekkî"),
  SureKayit(90, "البلد", 20, "Mekkî"),
  SureKayit(91, "الشمس", 15, "Mekkî"),
  SureKayit(92, "الليل", 21, "Mekkî"),
  SureKayit(93, "الضحى", 11, "Mekkî"),
  SureKayit(94, "الشرح", 8, "Mekkî"),
  SureKayit(95, "التين", 8, "Mekkî"),
  SureKayit(96, "العلق", 19, "Mekkî"),
  SureKayit(97, "القدر", 5, "Mekkî"),
  SureKayit(98, "البينة", 8, "Medenî"),
  SureKayit(99, "الزلزلة", 8, "Medenî"),
  SureKayit(100, "العاديات", 11, "Mekkî"),
  SureKayit(101, "القارعة", 11, "Mekkî"),
  SureKayit(102, "التكاثر", 8, "Mekkî"),
  SureKayit(103, "العصر", 3, "Mekkî"),
  SureKayit(104, "الهمزة", 9, "Mekkî"),
  SureKayit(105, "الفيل", 5, "Mekkî"),
  SureKayit(106, "قريش", 4, "Mekkî"),
  SureKayit(107, "الماعون", 7, "Mekkî"),
  SureKayit(108, "الكوثر", 3, "Mekkî"),
  SureKayit(109, "الكافرون", 6, "Mekkî"),
  SureKayit(110, "النصر", 3, "Medenî"),
  SureKayit(111, "المسد", 5, "Mekkî"),
  SureKayit(112, "الإخلاص", 4, "Mekkî"),
  SureKayit(113, "الفلق", 5, "Mekkî"),
  SureKayit(114, "الناس", 6, "Mekkî"),
];
