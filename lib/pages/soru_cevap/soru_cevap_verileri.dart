// lib/pages/soru_cevap/soru_cevap_verileri.dart
// Soru-Cevap (Fetva) modülünün çevrimdışı içerik havuzu.
// Her soru "hibrit"tir: cevap alanı Bilgi Bankası akordeonunu besler,
// secenekler + dogruIndex ise Bilgi Testleri ve Günün Sorusu'nu.
// Kaynaklar: Diyanet İşleri Başkanlığı ilmihal ve Kur'an mealleri,
// Sahih-i Buhari, Sahih-i Müslim, İbn Kesîr (el-Bidâye ve'n-Nihâye).

import 'soru_cevap_model.dart';

class SoruCevapVerileri {
  SoruCevapVerileri._();

  static const List<SoruKategorisi> kategoriler = [
    SoruKategorisi(
      id: 'namaz',
      ad: 'Namaz & Abdest',
      emoji: '🧼',
      aciklama:
          'Namazın şartları, abdest ve teyemmüm ile ilgili günlük hayata dair sorular.',
      sorular: [
        SoruCevapSorusu(
          id: 'n1',
          kategori: 'namaz',
          soru: 'Sehiv secdesi ne zaman yapılır?',
          cevap:
              'Namazda unutma veya yanılma sonucu vaciplerden birinin terk edilmesi '
              'ya da geciktirilmesi hâlinde (Hanefî mezhebine göre) selam vermeden önce '
              'tıpkı normal secde gibi iki secde yapılır. Farzların birinde yanılırsa da '
              'sehiv secdesi gerekir.',
          kaynak: 'Namaz İlmihali (Diyanet İşleri Başkanlığı)',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Selamdan önce iki secde yapılarak',
            'Namazdan sonra dört rekât eklenerek',
            'Sadece vitir namazında',
            'Namazı yeniden kılarak',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'n2',
          kategori: 'namaz',
          soru: 'Aşağıdakilerden hangisi abdesti bozan durumlardan biridir?',
          cevap:
              'Abdesti bozan durumlar arasında tuvaletten gelen şeyler (idrar, gaita), yel, '
              'vücuttan kan/irin gibi akıntıların çıkması, bayılma, sarhoşluk ve yatarak '
              'uyumak sayılır. Ağızda kalan yemek artığını yutmak abdesti bozmaz.',
          kaynak: 'Diyanet İlmihali - Abdest bahsi',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Yatarak uyumak',
            'Ağızdaki yemek artığını yutmak',
            'Tırnak kesmek',
            'Sakalı okşamak',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'n3',
          kategori: 'namaz',
          soru: 'Teyemmüm hangi durumda yapılabilir?',
          cevap:
              'Su bulunamadığında veya suyu kullanmak sağlığa zarar verdiğinde abdest ve '
              'gusül yerine temiz toprakla teyemmüm edilir. Kur\'an\'da "temiz toprakla '
              'teyemmüm edin" buyrulur (Mâide 6).',
          kaynak: 'Mâide Suresi, 6. Ayet',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Su bulunamadığında veya su kullanmak zararlı olduğunda',
            'Her namazdan önce mecbur olmadan',
            'Sadece yolculukta olmak şartıyla',
            'Güneşli havalarda namazı geciktirmemek için',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'n4',
          kategori: 'namaz',
          soru: 'Namazın farzları toplam kaçtır?',
          cevap:
              'Namazın 12 farzı vardır: namazdan önce yerine getirilen 6 şart '
              '(hadesten taharet, necasetten taharet, setr-i avret, istikbal-i kıble, vakit, '
              'niyet) ve namaz içindeki 6 rükün (iftitah tekbiri, kıyam, kıraat, rükû, '
              'secde, son oturuş/ka\'de).',
          kaynak: 'Diyanet İlmihali - Namazın farzları',
          seviye: SoruSeviyesi.orta,
          secenekler: ['12', '8', '5', '15'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'n5',
          kategori: 'namaz',
          soru: 'Vitir namazı hangi vakitte kılınır?',
          cevap:
              'Vitir namazı, yatsı namazından sonra sabah vaktinin girmesine kadar kılınır ve '
              'günlük kılınması vacip olan tek namazdır. Hanefîlere göre üç rekâttır.',
          kaynak: 'Diyanet İlmihali - Vitir namazı',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Yatsıdan sonra sabaha kadar',
            'Sabah güneş doğarken',
            'Öğle ile ikindi arası',
            'Cuma namazından önce',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'n6',
          kategori: 'namaz',
          soru: 'Seferî (yolcu) bir kişi dört rekâtlı farzları kaç rekât kılar?',
          cevap:
              'Mazeretsiz olarak 90 km\'yi aşan bir yolculuğa çıkan yolcu, dört rekâtlı '
              'farzları iki rekât olarak kılar (kasr-ı salât). Öğle, ikindi ve yatsının '
              'farzları ikişer rekât kılınır.',
          kaynak: 'Nisâ Suresi, 101. Ayet; Diyanet İlmihali',
          seviye: SoruSeviyesi.zor,
          secenekler: ['İki rekât', 'Üç rekât', 'Dört rekât', 'Bir rekât'],
          dogruIndex: 0,
        ),
      ],
    ),
    SoruKategorisi(
      id: 'oruc',
      ad: 'Oruç & Ramazan',
      emoji: '🌙',
      aciklama:
          'Orucun farzları, orucu bozan durumlar, fitre ve fidye hakkında sorular.',
      sorular: [
        SoruCevapSorusu(
          id: 'o1',
          kategori: 'oruc',
          soru: 'Ramazan orucu hangi ayetle farz kılınmıştır?',
          cevap:
              'Bakara Suresi\'nin 183. ayetiyle Ramazan ayında oruç tutmak iman edenlere farz '
              'kılınmıştır. Ayette "Ey iman edenler! Oruç, sizden öncekilere farz kılındığı gibi '
              'size de farz kılındı" buyrulur.',
          kaynak: 'Bakara Suresi, 183. Ayet',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Bakara 183',
            'Fâtiha 1',
            'İhlâs 2',
            'Nas 1',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'o2',
          kategori: 'oruc',
          soru: 'Orucu bozan durumlardan hangisi kefareti de gerektirir?',
          cevap:
              'Ramazan gününde bilerek yemek-içmek, cinsel ilişki veya buna benzer bilinçli '
              'hareketler orucu bozar ve kefaret gerekir. Kefaret, peş peşe 60 gün oruç tutmak; '
              'buna güç yetiremeyen 60 fakiri doyurmaktır.',
          kaynak: 'Sahih-i Buhari, Kitâbü\'s-Savm; Sahih-i Müslim',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'Ramazan günü bilerek yemek yemek',
            'Unutarak yemek içmek',
            'Diş fırçalamak',
            'Ağız çalkalamak',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'o3',
          kategori: 'oruc',
          soru: 'Oruç tutamayacak yaşlı ve sürekli hasta kimseler ne yapmalıdır?',
          cevap:
              'Oruç tutmaya güç yetiremeyen yaşlı ve iyileşmesi umulmayan hastalar, her gün '
              'için bir fakiri doyuracak miktarda fidye verirler. Kur\'an\'da "Güç yetiremeyenler '
              'üzerine bir yoksul doyurmak fidye vardır" buyrulur (Bakara 184).',
          kaynak: 'Bakara Suresi, 184. Ayet',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'Her gün için fidye verir',
            'Orucu telafi etmek zorunda kalmaz',
            'Sadece kaza orucu tutar',
            'Zekat vermesi yeterli olur',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'o4',
          kategori: 'oruc',
          soru: 'Teravih namazı hangi vakitte kılınır?',
          cevap:
              'Teravih, Ramazan ayına mahsus bir namazdır ve yatsı namazından sonra, vitir '
              'namazından önce veya sonra cemaatle ya da tek başına kılınır. Peygamberimiz '
              '(s.a.v.) bu namazı teşvik etmiş, sünnet olduğu kabul edilmiştir.',
          kaynak: 'Sahih-i Buhari, Teravih bahsi',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Yatsıdan sonra',
            'Sahur vakti',
            'İkindi ile akşam arası',
            'Bayram namazında',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'o5',
          kategori: 'oruc',
          soru: 'Sahur yemenin hükmü nedir?',
          cevap:
              'Sahur yemek müstehaptır (teşvik edilmiştir). Peygamberimiz (s.a.v.) "Sahur yemeği '
              'yiyin, çünkü sahurda bereket vardır" buyurmuştur. Sahur vaktinin sona ermesiyle '
              'imsak girer ve oruç başlar.',
          kaynak: 'Sahih-i Buhari, Kitâbü\'s-Savm',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Müstehaptır, bereketlidir',
            'Farzdır, terk edilmez',
            'Sadece erkeklere sünnettir',
            'Terki sevaptır',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'o6',
          kategori: 'oruc',
          soru: 'Kaza orucu hangi vakte kadar tutulabilir?',
          cevap:
              'Ramazan\'da tutulamayan veya bozulan oruçların kazası, özür hâlleri hariç '
              'mümkün olan en kısa sürede tutulmalıdır. Kadınların âdet günleri dışında, '
              'kaza orucu normal günlerde tutulabilir; bir sonraki Ramazan\'a bırakılması '
              'mekruhtur ve geciktirilen her gün için fidye gerekebilir.',
          kaynak: 'Bakara Suresi, 184. Ayet; Diyanet Fetvaları',
          seviye: SoruSeviyesi.zor,
          secenekler: [
            'En geç gelecek Ramazan\'a kadar',
            'Sadece aynı hafta içinde',
            'Yalnızca kış aylarında',
            'Üç yıl içinde serbestçe',
          ],
          dogruIndex: 0,
        ),
      ],
    ),
    SoruKategorisi(
      id: 'zekat',
      ad: 'Zekat & Sadaka',
      emoji: '🤲',
      aciklama: 'Zekat, nisap, öşür ve sadaka hakkında sorular.',
      sorular: [
        SoruCevapSorusu(
          id: 'z1',
          kategori: 'zekat',
          soru: 'Zekatın nisabı (altın ölçüsü) nedir?',
          cevap:
              'Zekatın nisabı, bir kişinin temel ihtiyaçları dışında yaklaşık 80,18 gram '
              'altın değerinde mala sahip olmasıdır. Bu miktara ulaşan ve üzerinden bir '
              'hicri yıl geçen kimse, malının 1/40\'ını (yüzde 2,5) zekat olarak verir.',
          kaynak: 'Diyanet İlmihali - Zekatın nisabı',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'Yaklaşık 80 gram altın değeri',
            'Yaklaşık 20 gram altın değeri',
            'Bir ev sahibi olmak',
            'Aylık asgari ücret geliri',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'z2',
          kategori: 'zekat',
          soru: 'Zekatın verileceği sınıflar kaç başlıkta belirtilmiştir?',
          cevap:
              'Kur\'an\'da zekatın verileceği yerler sekiz sınıf olarak sayılır: fakirler, '
              'miskinler, zekat toplama memurları, müellefe-i kulûb (kalpleri ısındırılacaklar), '
              'köleler, borçlular, Allah yolunda olanlar ve yolda kalmış yolcular (Tevbe 60).',
          kaynak: 'Tevbe Suresi, 60. Ayet',
          seviye: SoruSeviyesi.orta,
          secenekler: ['Sekiz', 'Üç', 'On', 'Beş'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'z3',
          kategori: 'zekat',
          soru: 'Zekat kime verilmez?',
          cevap:
              'Zekat; anne-babaya, evlatlara, eşe, zengine ve kişinin bakmakla yükümlü olduğu '
              'kimselere verilmez. Ayrıca gayrimüslimlere farz olan zekat verilmemekle birlikte '
              'sadaka verilebilir.',
          kaynak: 'Diyanet İlmihali - Zekatın verilemeyeceği yerler',
          seviye: SoruSeviyesi.zor,
          secenekler: [
            'Anne ve babaya',
            'Yolda kalmış bir yolcuya',
            'Borçlu bir fakire',
            'Zekat memuruna',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'z4',
          kategori: 'zekat',
          soru: 'Öşür (toprak ürünleri zekatı) oranı nedir?',
          cevap:
              'Emek ve masraf isteyen sulama ile yetiştirilen ürünlerden 1/20 (yüzde 5), '
              'doğal olarak yetişen (yağmur/nehir ile sulanan) ürünlerden 1/10 (yüzde 10) '
              'öşür verilir.',
          kaynak: 'Sahih-i Buhari, Kitâbü\'z-Zekât; Diyanet İlmihali',
          seviye: SoruSeviyesi.zor,
          secenekler: [
            'Doğal sulamada onda bir',
            'Her durumda yüzde bir',
            'Yalnızca meyvelerde beşte bir',
            'Her üründen yüzde elli',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'z5',
          kategori: 'zekat',
          soru: 'Sadaka-i cariye nedir?',
          cevap:
              'Sadaka-i cariye, ölümden sonra da sevabı devam eden sadakadır. Mescid, çeşme, '
              'okul yaptırmak veya ilim neşreden bir eser bırakmak buna örnektir. Peygamberimiz '
              '(s.a.v.) "İnsan ölünce ameli kesilir; üç şey hariç: sadaka-i cariye, kendisine dua '
              'eden hayırlı evlat ve istifade edilen ilim" buyurmuştur.',
          kaynak: 'Sahih-i Müslim, Vasiyet 14',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'Sevabı devam eden sadaka',
            'Bir kez verilen sadaka',
            'Ramazan\'da verilen zekat',
            'Sadece mescide yapılan bağış',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'z6',
          kategori: 'zekat',
          soru: 'Fitre (fıtır sadakası) ne zaman verilir?',
          cevap:
              'Fitre, Ramazan Bayramı\'na kavuşan ve zekat nisabına sahip kimselere vaciptir; '
              'bayramın ilk günü güneş doğmadan önce verilmesi en faziletlisidir. Bayramdan '
              'önce de verilebilir.',
          kaynak: 'Sahih-i Buhari, Kitâbü\'z-Zekât',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Ramazan Bayramı\'ndan önce',
            'Sadece kurban bayramında',
            'Her cuma namazından sonra',
            'Yalnızca yılbaşında',
          ],
          dogruIndex: 0,
        ),
      ],
    ),
    SoruKategorisi(
      id: 'peygamberler',
      ad: 'Peygamberler Tarihi',
      emoji: '🕋',
      aciklama:
          'Kur\'an ve sahih kaynaklara dayalı peygamberler tarihi soruları.',
      sorular: [
        SoruCevapSorusu(
          id: 'p1',
          kategori: 'peygamberler',
          soru: 'Hz. İbrahim (a.s.) neden ateşe atıldı?',
          cevap:
              'Hz. İbrahim, kavminin putlarını kırarak tevhid mücadelesi verdi. Kavmi onu '
              'cezalandırmak için büyük bir ateş yaktı ve içine attı. Ancak Allah, "Ey ateş! '
              'İbrahim için serin ve esenlik ol" buyurdu ve ateş onu yakmadı (Enbiya 68-69).',
          kaynak: 'Enbiya Suresi, 68-69. Ayetler',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Putları kırdığı için',
            'Ticaret yaptığı için',
            'Dili sürçtüğü için',
            'Krala boyun eğmediği için',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'p2',
          kategori: 'peygamberler',
          soru: 'Ashâb-ı Kehf mağarada kaç yıl uyudu?',
          cevap:
              'Ashâb-ı Kehf, putperest kavimlerinden kaçarak bir mağaraya sığındı ve Allah '
              'onları orada uzun bir uykuya daldırdı. Kur\'an\'a göre üç yüz yıl uyudular, '
              'dokuz yıl da buna eklenir; yani toplam 309 yıl (Kehf 25).',
          kaynak: 'Kehf Suresi, 25. Ayet',
          seviye: SoruSeviyesi.kolay,
          secenekler: ['309 yıl', '100 yıl', '50 yıl', '1000 yıl'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'p3',
          kategori: 'peygamberler',
          soru: 'Hz. Yunus (a.s.) balığın karnında ne yaptı?',
          cevap:
              'Hz. Yunus, kavmini bırakıp gittiği için denize atıldı ve büyük bir balık onu '
              'yuttu. Karanlıklarda "Senden başka ilah yoktur, seni her türlü noksandan '
              'tenzih ederim, gerçekten ben zalimlerden oldum" diyerek dua etti; Allah onu '
              'balığın karnından kurtardı (Enbiya 87-88).',
          kaynak: 'Enbiya Suresi, 87. Ayet; Saffat 139-144',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'Tevbe edip dua etti',
            'Kavmine döndü',
            'Balığı çıkardı',
            'Suskun bekledi',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'p4',
          kategori: 'peygamberler',
          soru: 'Hz. Musa\'ya (a.s.) verilen mucizelerden hangisi doğrudur?',
          cevap:
              'Hz. Musa\'ya asasının yılana dönüşmesi, elinin parlaması (yed-i beyzâ) ve Kızıldeniz\'in '
              'yarılması gibi mucizeler verildi. Kızıldeniz\'in yarılmasıyla İsrailoğulları kurtuldu, '
              'Firavun ve ordusu boğuldu.',
          kaynak: 'A\'râf Suresi, 107-108; Şuarâ Suresi, 63-66',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Asanın yılana dönüşmesi',
            'Rüzgara hükmetmek',
            'Kuşlarla konuşmak',
            'Güneşi durdurmak',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'p5',
          kategori: 'peygamberler',
          soru: 'Kur\'an\'da adı geçen peygamber sayısı kaçtır?',
          cevap:
              'Kur\'an\'da adı geçen peygamber sayısı 25 olarak kabul edilir. Bunlar Âdem, '
              'İdris, Nûh, Hûd, Sâlih, İbrâhim, Lût, İsmâil, İshâk, Ya\'kûb, Yûsuf, Eyyûb, '
              'Şuayb, Mûsâ, Hârûn, Dâvûd, Süleymân, İlyâs, Elyesa, Zülkifl, Yûnus, Zekeriyyâ, '
              'Yahyâ, Îsâ ve Muhammed\'dir (s.a.v.).',
          kaynak: 'Kur\'an-ı Kerim (En\'âm Suresi, 83-86; Diyanet)',
          seviye: SoruSeviyesi.zor,
          secenekler: ['25', '12', '30', '99'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'p6',
          kategori: 'peygamberler',
          soru: 'Hızır (a.s.) ile yolculuk yapan peygamber hangisidir?',
          cevap:
              'Hz. Musa (a.s.), ilim yolculuğunda Hızır ile birlikte yürüdü. Bu yolculukta gemi '
              'delinmesi, bir çocuğun öldürülmesi ve yıkık duvarın tamir edilmesi olayları '
              'yaşandı; Hızır her birinin ardındaki hikmeti açıkladı (Kehf 60-82).',
          kaynak: 'Kehf Suresi, 60-82. Ayetler',
          seviye: SoruSeviyesi.orta,
          secenekler: ['Hz. Musa', 'Hz. İsa', 'Hz. İbrahim', 'Hz. Yusuf'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'p7',
          kategori: 'peygamberler',
          soru: 'Hz. Yusuf (a.s.) hangi olaylardan geçmiştir?',
          cevap:
              'Hz. Yusuf, kardeşleri tarafından kuyuya atıldı, kervan tarafından bulunarak Mısır\'a '
              'satıldı, iftira yüzünden uzun süre zindanda kaldı ve sonunda Mısır\'a hazinedar oldu. '
              'Bu kıssa Kur\'an\'da "kıssaların en güzeli" olarak anılır (Yusuf 3).',
          kaynak: 'Yûsuf Suresi, 3-101. Ayetler',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Kuyuya atılıp Mısır\'a satıldı',
            'Balığın karnında kaldı',
            'Ateşe atıldı',
            'Kavmini helak etti',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'p8',
          kategori: 'peygamberler',
          soru: 'Fil Vakası hangi olayı anlatır?',
          cevap:
              'Fil Vakası, Ebrehe\'nin ordusunun Kâbe\'yi yıkmak için fillerle saldırması olayıdır. '
              'Allah, Ebâbil kuşları aracılığıyla bu orduyu helak etti (Fil Suresi). Peygamberimiz '
              '(s.a.v.) bu olayın yaşandığı yıl dünyaya gelmiştir.',
          kaynak: 'Fil Suresi, 1-5. Ayetler',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'Ebrehe\'nin Kâbe\'ye saldırısı',
            'Hz. İbrahim\'in ateşe atılması',
            'Ashâb-ı Kehf\'in uyuması',
            'Kavmin deve mucizesini reddi',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'p9',
          kategori: 'peygamberler',
          soru: 'Firavun\'un sonu nasıl olmuştur?',
          cevap:
              'Firavun, İsrailoğulları\'nı köleleştiren zorba hükümdardı. Hz. Musa\'nın '
              'daveti ve mucizelerine rağmen inanmadı. Kızıldeniz\'i takip ettiğinde deniz '
              'yarılıp kendini boğulmak üzere bulunca iman ettiğini söyledi; ancak bu iman '
              'kabul edilmedi ve boğuldu (Yûnus 90-92).',
          kaynak: 'Yûnus Suresi, 90-92. Ayetler',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'Denizde boğuldu',
            'Ateşe atıldı',
            'Bir dağın altında kaldı',
            'Taşlaştırıldı',
          ],
          dogruIndex: 0,
        ),
      ],
    ),
    SoruKategorisi(
      id: 'kuran',
      ad: 'Kur\'an & Kıssalar',
      emoji: '📖',
      aciklama: 'Kur\'an\'ın inişi, sureler ve içindeki kıssalar hakkında sorular.',
      sorular: [
        SoruCevapSorusu(
          id: 'k1',
          kategori: 'kuran',
          soru: 'Kur\'an\'ın ilk inen ayetleri hangisidir?',
          cevap:
              'İlk inen ayetler, Alak Suresi\'nin ilk beş ayetidir: "Yaratan Rabbinin adıyla oku..." '
              'Bu olay, Hira Mağarası\'nda Cebrail (a.s.) ile gerçekleşmiştir ve "Oku" emriyle '
              'vahiy süreci başlamıştır.',
          kaynak: 'Alak Suresi, 1-5. Ayetler; Sahih-i Buhari',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Alak Suresi\'nin ilk ayetleri',
            'Fatiha Suresi',
            'İhlas Suresi',
            'Bakara\'nın ilk ayetleri',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'k2',
          kategori: 'kuran',
          soru: 'Müslümanların kıblesi hangi olayla Kâbe\'ye çevrilmiştir?',
          cevap:
              'Mescid-i Aksa\'ya yönelen kıble, hicretin ikinci yılında Bakara Suresi\'nin 144. '
              'ayetiyle Kâbe\'ye çevrilmiştir. Ayette "Yüzünü Mescid-i Haram\'a çevir" buyrulur.',
          kaynak: 'Bakara Suresi, 144. Ayet',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'Bakara 144 ile Kâbe\'ye',
            'Bedir zaferiyle Kudüs\'e',
            'Miraç\'ta Mescid-i Aksa\'ya',
            'Hudeybiye antlaşmasıyla',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'k3',
          kategori: 'kuran',
          soru: 'İsrâ gecesi Peygamberimiz (s.a.v.) nereden nereye götürülmüştür?',
          cevap:
              'İsrâ gecesi Peygamberimiz (s.a.v.) Mescid-i Haram\'dan (Mekke) Mescid-i Aksa\'ya '
              '(Kudüs) götürülmüştür. Ardından Miraç\'la göklere yükseltilmiş ve beş vakit namaz '
              'farz kılınmıştır (İsrâ 1).',
          kaynak: 'İsrâ Suresi, 1. Ayet',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Mescid-i Haram\'dan Mescid-i Aksa\'ya',
            'Mescid-i Aksa\'dan Mescid-i Haram\'a',
            'Kâbe\'den Mina\'ya',
            'Hira\'dan Sevr\'e',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'k4',
          kategori: 'kuran',
          soru: 'Kur\'an\'ın en uzun ayeti hangisidir?',
          cevap:
              'Kur\'an\'ın en uzun ayeti, Bakara Suresi\'nin 282. ayetidir (Müdâyene / borç ayeti). '
              'Bu ayet, borç ve alışverişlerde yazılı belge düzenlenmesini ve şahit bulunmasını '
              'öğütler.',
          kaynak: 'Bakara Suresi, 282. Ayet',
          seviye: SoruSeviyesi.zor,
          secenekler: [
            'Bakara 282 (borç ayeti)',
            'Bakara 255 (Âyetü\'l-Kürsî)',
            'Tevbe 60',
            'İsrâ 1',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'k5',
          kategori: 'kuran',
          soru: 'Kur\'an\'da adı geçen tek kadın kimdir?',
          cevap:
              'Kur\'an\'da ismiyle anılan tek kadın Hz. Meryem\'dir. Ona Meryem Suresi\'nde yer '
              'verilmiş, Hz. Îsâ\'nın babasız dünyaya gelmesi ve beşikte konuşması anlatılmıştır '
              '(Meryem 16-33; Âl-i İmrân 42-47).',
          kaynak: 'Meryem Suresi, 16-33. Ayetler',
          seviye: SoruSeviyesi.orta,
          secenekler: ['Hz. Meryem', 'Havva', 'Hz. Asiye', 'Belkıs'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'k6',
          kategori: 'kuran',
          soru: 'Lokman (a.s.) hangi surede hikmetli öğütleriyle anılır?',
          cevap:
              'Lokman\'a verilen hikmet ve oğluna yaptığı öğütler, Lokman Suresi\'nde (12-19) '
              'anlatılır: "Yavrucuğum! Allah\'a şirk koşma; şüphesiz şirk büyük bir zulümdür. '
              'Ana-babaya iyilik et, namazı kıl, iyiliği emret."',
          kaynak: 'Lokman Suresi, 12-19. Ayetler',
          seviye: SoruSeviyesi.orta,
          secenekler: ['Lokman Suresi', 'Yûsuf Suresi', 'Kehf Suresi', 'Hûd Suresi'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'k7',
          kategori: 'kuran',
          soru: 'Ashâb-ı Sebt kimdir?',
          cevap:
              'Ashâb-ı Sebt, cumartesi yasağını çiğneyerek o gün balık avlayan İsrailoğulları '
              'topluluğudur. Allah onları maymuna dönüştürmüş ve bu olay ibret olarak anlatılmıştır '
              '(A\'râf 163-166; Bakara 65).',
          kaynak: 'A\'râf Suresi, 163-166. Ayetler',
          seviye: SoruSeviyesi.zor,
          secenekler: [
            'Cumartesi yasağını çiğneyen topluluk',
            'Bir mağarada uyuyan gençler',
            'Kâbe\'ye saldıran ordu',
            'Putları kıran kavim',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'k8',
          kategori: 'kuran',
          soru: '"Günün Ayeti" bölümündeki Ra\'d 28 ayetinin anlamı nedir?',
          cevap:
              'Ra\'d Suresi 28. ayette "Bilesiniz ki kalpler ancak Allah\'ı anmakla huzur bulur" '
              'buyrulur. Ayetin devamında iman edip kalpleri Allah\'ı anmakla huzura kavuşanlar '
              'övülür; bu ayet zikrin kalbe huzur verdiğini bildirir.',
          kaynak: 'Ra\'d Suresi, 28. Ayet',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Kalpler Allah\'ı anmakla huzur bulur',
            'Sabredenler kurtulur',
            'Namaz insanı hayâsızlıktan alıkoyar',
            'Allah güç yetmeyeni yüklemez',
          ],
          dogruIndex: 0,
        ),
      ],
    ),
    SoruKategorisi(
      id: 'iman',
      ad: 'İman & İbadet',
      emoji: '🕊️',
      aciklama: 'İmanın şartları, İslam\'ın şartları ve günlük ibadetler.',
      sorular: [
        SoruCevapSorusu(
          id: 'i1',
          kategori: 'iman',
          soru: 'İslam\'ın şartları kaçtır?',
          cevap:
              'İslam\'ın şartı beştir: Kelime-i şehadet getirmek, namaz kılmak, zekat vermek, '
              'Ramazan orucunu tutmak ve gücü yetenin hacca gitmesi. Bunlar Hz. Peygamber\'in '
              's.a.v. hadislerinde sayılmıştır.',
          kaynak: 'Sahih-i Buhari, Kitâbü\'l-Îmân; Sahih-i Müslim',
          seviye: SoruSeviyesi.kolay,
          secenekler: ['Beş', 'Üç', 'Yedi', 'Altı'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'i2',
          kategori: 'iman',
          soru: 'İmanın şartları kaçtır ve hangileridir?',
          cevap:
              'İmanın şartı altıdır: Allah\'a, meleklerine, kitaplarına, peygamberlerine, ahiret '
              'gününe ve kaderin hayır ve şerrinin Allah\'tan olduğuna inanmak (İman-ı Mufassal).',
          kaynak: 'Sahih-i Müslim, Kitâbü\'l-Îmân',
          seviye: SoruSeviyesi.orta,
          secenekler: ['Altı', 'Beş', 'Dört', 'On'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'i3',
          kategori: 'iman',
          soru: 'Günde kaç vakit namaz farzdır?',
          cevap:
              'Günde beş vakit namaz farzdır: sabah, öğle, ikindi, akşam ve yatsı. Farz rekât '
              'sayıları toplam 17\'dir: sabah 2, öğle 4, ikindi 4, akşam 3, yatsı 4.',
          kaynak: 'Diyanet İlmihali - Namaz vakitleri',
          seviye: SoruSeviyesi.kolay,
          secenekler: ['Beş vakit, 17 rekât', 'Beş vakit, 20 rekât', 'Üç vakit, 12 rekât', 'Yedi vakit, 21 rekât'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'i4',
          kategori: 'iman',
          soru: 'Beş vakit namaz hangi gece farz kılınmıştır?',
          cevap:
              'Beş vakit namaz, İsrâ ve Miraç gecesi farz kılınmıştır. İlk başta elli vakit '
              'takdir edilmiş, Hz. Musa\'nın (a.s.) tavsiyesiyle Peygamberimiz (s.a.v.) için '
              'beşe indirilmiştir.',
          kaynak: 'Sahih-i Buhari, Kitâbü\'s-Salât; İsrâ Suresi',
          seviye: SoruSeviyesi.orta,
          secenekler: [
            'İsrâ ve Miraç gecesinde',
            'Hicretin ilk gecesinde',
            'Bedir zaferinin gecesinde',
            'Veda Haccı gününde',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'i5',
          kategori: 'iman',
          soru: 'Hangi ayet zikrin faziletini bildirir?',
          cevap:
              'Ra\'d 28: "Bilesiniz ki kalpler ancak Allah\'ı anmakla huzur bulur." Ayrıca Ahzâb '
              '41-42\'de "Allah\'ı çokça zikredin, sabah akşam O\'nu tesbih edin" buyrulur.',
          kaynak: 'Ra\'d Suresi, 28. Ayet; Ahzâb Suresi, 41-42',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Ra\'d 28',
            'Yûnus 90',
            'Mâide 6',
            'Tevbe 60',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'i6',
          kategori: 'iman',
          soru: 'Kelime-i şehadetin anlamı nedir?',
          cevap:
              'Kelime-i şehadet: "Allah\'tan başka ilah olmadığına ve Muhammed\'in (s.a.v.) '
              'Allah\'ın kulu ve elçisi olduğuna şahitlik ederim" anlamına gelir. İslam\'a girişin '
              'ilk şartıdır.',
          kaynak: 'Sahih-i Buhari, Kitâbü\'l-Îmân',
          seviye: SoruSeviyesi.kolay,
          secenekler: [
            'Allah\'tan başka ilah yoktur, Muhammed O\'nun elçisidir',
            'Allah en büyüktür',
            'Hamd Allah\'a mahsustur',
            'Allah\'a tevekkül ettim',
          ],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'i7',
          kategori: 'iman',
          soru: 'Dinin (namazın) direği olarak anılan ibadet hangisidir?',
          cevap:
              'Namaz, dinin direği olarak anılır. Peygamberimiz (s.a.v.) "Namaz, dinin direğidir; '
              'onu terk eden dini yıkmış olur" buyurmuştur. Beş vakit namaz aynı zamanda günlük '
              'iman tazelemenin anahtarıdır.',
          kaynak: 'Beyhakî, Şuabü\'l-Îmân',
          seviye: SoruSeviyesi.zor,
          secenekler: ['Namaz', 'Zekat', 'Hac', 'Oruç'],
          dogruIndex: 0,
        ),
        SoruCevapSorusu(
          id: 'i8',
          kategori: 'iman',
          soru: '"Allah, hiç kimseye gücünün üstünde yük yüklemez" hangi surede geçer?',
          cevap:
              'Bu ifade Bakara Suresi\'nin 286. ayetinde geçer: "Allah, hiç kimseye gücünün '
              'üstünde bir yük yüklemez. Kazandığı iyilik kendi yararına, kötülük de kendi '
              'zararınadır."',
          kaynak: 'Bakara Suresi, 286. Ayet',
          seviye: SoruSeviyesi.kolay,
          secenekler: ['Bakara 286', 'Talak 3', 'Zümer 53', 'İbrahim 7'],
          dogruIndex: 0,
        ),
      ],
    ),
  ];

  static List<SoruCevapSorusu> get tumSorular =>
      [for (final k in kategoriler) ...k.sorular];

  static List<String> get tumKategoriler =>
      [for (final k in kategoriler) k.ad];

  /// Günün Sorusu: gün numarasına göre döner (her gün farklı soru).
  static SoruCevapSorusu gununSorusu() {
    final liste = tumSorular;
    final gun = DateTime.now()
        .difference(DateTime(DateTime.now().year, 1, 1))
        .inDays;
    return liste[gun % liste.length];
  }

  static SoruCevapSorusu? bul(String id) {
    for (final s in tumSorular) {
      if (s.id == id) return s;
    }
    return null;
  }

  static List<SoruCevapSorusu> seviyeyeGore(SoruSeviyesi seviye) =>
      tumSorular.where((s) => s.seviye == seviye && s.quizVar).toList();

  static List<SoruCevapSorusu> kategoriyeGore(String kategoriAdi) =>
      tumSorular.where((s) => s.kategori == kategoriAdi).toList();

  static List<SoruCevapSorusu> ara(String sorgu) {
    final q = sorgu.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return tumSorular.where((s) => s.aramaMetni.contains(q)).toList();
  }

  /// Rozetler: toplam doğru sayısına göre kazanılır.
  static const List<Rozet> rozetler = [
    Rozet(
      id: 'kissa-ciragi',
      ad: 'Kıssa Çırağı',
      emoji: '🌱',
      esik: 5,
      aciklama: '5 doğru cevaba ulaşınca kazanılır',
    ),
    Rozet(
      id: 'tarih-kasifi',
      ad: 'Tarih Kaşifi',
      emoji: '🕵️',
      esik: 15,
      aciklama: '15 doğru cevaba ulaşınca kazanılır',
    ),
    Rozet(
      id: 'fetva-bilgini',
      ad: 'Fetva Bilgini',
      emoji: '📜',
      esik: 30,
      aciklama: '30 doğru cevaba ulaşınca kazanılır',
    ),
    Rozet(
      id: 'kuran-alimi',
      ad: 'Kur\'an Âlimi',
      emoji: '🏆',
      esik: 50,
      aciklama: '50 doğru cevaba ulaşınca kazanılır',
    ),
  ];
}
