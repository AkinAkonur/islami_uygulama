enum GunlukHedefTipi { kissa, soru, kardeslik, zikir }

class GunlukHedefGorev {
  final GunlukHedefTipi tip;
  final String ad;
  final String aciklama;
  final String ikon;
  final int xp;
  final int hedefSayi;

  const GunlukHedefGorev({
    required this.tip,
    required this.ad,
    required this.aciklama,
    required this.ikon,
    required this.xp,
    required this.hedefSayi,
  });
}

const List<GunlukHedefGorev> gunlukGorevler = [
  GunlukHedefGorev(
    tip: GunlukHedefTipi.kissa,
    ad: 'Günün Kıssası',
    aciklama: 'Bugünün ibret dolu kıssasını oku',
    ikon: '📖',
    xp: 10,
    hedefSayi: 1,
  ),
  GunlukHedefGorev(
    tip: GunlukHedefTipi.soru,
    ad: 'Günün Sorusu',
    aciklama: 'Soru-Cevap modülünden günün sorusunu bil',
    ikon: '❓',
    xp: 15,
    hedefSayi: 1,
  ),
  GunlukHedefGorev(
    tip: GunlukHedefTipi.kardeslik,
    ad: 'Kardeşlik Bağı',
    aciklama: 'Dua Kardeşliği akışında 3 kardeşine Amin de',
    ikon: '🤝',
    xp: 10,
    hedefSayi: 3,
  ),
  GunlukHedefGorev(
    tip: GunlukHedefTipi.zikir,
    ad: 'Günün Zikri',
    aciklama: '33 kez "Sübhanallah" de',
    ikon: '📿',
    xp: 15,
    hedefSayi: 33,
  ),
];

GunlukHedefGorev gorevIcin(GunlukHedefTipi tip) =>
    gunlukGorevler.firstWhere((g) => g.tip == tip);

class HedefRozet {
  final String id;
  final String ad;
  final String ikon;
  final int esik;
  final String aciklama;

  const HedefRozet({
    required this.id,
    required this.ad,
    required this.ikon,
    required this.esik,
    required this.aciklama,
  });
}

const List<HedefRozet> kilometreTaslari = [
  HedefRozet(
    id: 'istikrar',
    ad: 'İstikrar',
    ikon: '🔥',
    esik: 7,
    aciklama: '7 günlük seriye ulaş',
  ),
  HedefRozet(
    id: 'azim',
    ad: 'Azim',
    ikon: '⚡',
    esik: 14,
    aciklama: '14 günlük seriye ulaş',
  ),
  HedefRozet(
    id: 'sabir',
    ad: 'Sabır',
    ikon: '🏅',
    esik: 30,
    aciklama: '30 günlük seriye ulaş',
  ),
  HedefRozet(
    id: 'sebat',
    ad: 'Sebat',
    ikon: '🌟',
    esik: 60,
    aciklama: '60 günlük seriye ulaş',
  ),
  HedefRozet(
    id: 'kubbe',
    ad: 'Manevi Kubbe',
    ikon: '🕌',
    esik: 100,
    aciklama: '100 günlük seriye ulaş',
  ),
  HedefRozet(
    id: 'veli',
    ad: 'Yıllık Veli',
    ikon: '🕋',
    esik: 365,
    aciklama: '365 günlük seriye ulaş',
  ),
];

const int dondurucuFiyati = 100;

class KissaIcerik {
  final String baslik;
  final String metin;
  final String kaynak;

  const KissaIcerik({
    required this.baslik,
    required this.metin,
    required this.kaynak,
  });
}

const List<KissaIcerik> _kissalar = [
  KissaIcerik(
    baslik: 'Karanlıklarda Bir Nida',
    metin:
        'Yunus aleyhisselâm, kavmini terk ettiği için bir balığın karnına '
        'düştü. Üç kat karanlığın (gece, deniz ve balığın karnı) içinde '
        'yalnız başmaydı. O andaki tek çaresi vardı: samimi bir yakarış. '
        '"Senden başka ilah yoktur; seni tesbih ederim, gerçekten ben '
        'zulmedenlerden oldum" diye yalvardı.',
    kaynak: 'Enbiyâ Sûresi 87-88 · Kur\'ân kıssası',
  ),
  KissaIcerik(
    baslik: 'Sabrın Zirvesi: Eyyûb',
    metin:
        'Eyyûb aleyhisselâm yıllarca hastalık ve yokluk içinde kaldı. '
        'Vücudundaki dertler arttı, yakınları uzaklaştı; yine de dilinden '
        'sabır ve şükür eksik olmadı. "Başıma gelen bu dertler yüzünden '
        'gerçekten zarara uğradım" deyip Rabbine sığındı. Allah onun '
        'sabrını karşılıksız bırakmadı: "Ayağını yere vur; işte yıkanacak '
        've içilecek soğuk bir su."',
    kaynak: 'Sâd Sûresi 41-42 · Kur\'ân kıssası',
  ),
  KissaIcerik(
    baslik: 'Kuyudan Saraya: Yusuf',
    metin:
        'Hz. Yusuf kardeşleri tarafından kuyuya atıldı, köle olarak '
        'satıldı, iftiraya uğrayıp yıllarca zindanda kaldı. Her musibette '
        'dilinden "Bilin ki Allah\'ım benimle beraberdir, bana en güzel '
        'şekilde sabredersin" temennisi eksik olmadı. Sonunda zindandan '
        'çıkıp Mısır\'a vezir oldu. Kardeşleri karşısına geldiğinde '
        'affetti ve "Bugün size kınama yok" dedi.',
    kaynak: 'Yûsuf Sûresi · affetme dersi',
  ),
  KissaIcerik(
    baslik: 'Ateşin İçinde Güven',
    metin:
        'Hz. İbrahim putları kırınca kavmi onu koca bir ateşe attı. '
        'Alevler yükselirken melekler yardım teklif etti; o, "Allah '
        'yeter, O ne güzel vekildir" dedi. Allah ateşe emretti: "Ey ateş, '
        'İbrahim\'e serinlik ve esenlik ol!" Ateş yakmadı. Tevekkülün '
        'zaferi, ateşin serinliğe dönüşmesiyle taçlandı.',
    kaynak: 'Enbiyâ Sûresi 68-69 · tevekkül kıssası',
  ),
  KissaIcerik(
    baslik: 'Mağaradaki Dostluk',
    metin:
        'Hicret gecesi Resûlullah ile Hz. Ebû Bekir Sevr mağarasına '
        'sığındılar. Müşrikler mağaranın ağzına kadar geldiler. Hz. Ebû '
        'Bekir "Ya Resûlallah, içlerinden biri ayağının altına baksa bizi '
        'görecek" deyince Efendimiz sükûnetle buyurdu: "Ey Ebû Bekir, '
        'iki kişiden üçüncüsü Allah olan hakkında ne dersin?" Kalp '
        'huzurunu dostluktan değil, Allah\'a güvenden alanlar korkmaz.',
    kaynak: 'Tevbe Sûresi 40 · hicret kıssası',
  ),
  KissaIcerik(
    baslik: 'Mağara Ashabı',
    metin:
        'Gençler putlara tapmayı reddedip imanlarını korumak için '
        'mağaraya sığındılar. "Rabbimiz göklerin ve yerin Rabbidir; '
        'O\'ndan başkasına ilah demeyiz" dediler. Allah onları yıllarca '
        'uyuttu, sonra diriltti. Nice asır sonra uyandılar ve şehrin '
        'hâlini görünce "Rabbimiz daha iyi bilir" dediler. İman, zor '
        'görünen zamanlarda bile en büyük sığınaktır.',
    kaynak: 'Kehf Sûresi 9-26 · Kur\'ân kıssası',
  ),
  KissaIcerik(
    baslik: 'Gizli Veli: Uveys',
    metin:
        'Yemenli Uveys el-Karânî, Resûlullah\'ı göremeden Müslüman oldu. '
        'Annesine hizmet ettiği için yolculuktan geri durdu; buluşmak '
        'için gittiğinde ise Efendimiz\'i bulamadı. Ümmetin ilk '
        'Tâbiîlerindendir. Peygamberimiz onun için "Allah\'ın gökten '
        'muhakkak bakacağı kişi" buyurdu. Görünürde parlak bir makamı '
        'yoktu; mükâfatı yalnız Allah katında idi.',
    kaynak: 'Sahîh-i Müslim · Uveys el-Karânî kıssası',
  ),
  KissaIcerik(
    baslik: 'Hz. Musa ve Hızır',
    metin:
        'Musa aleyhisselâm kendisinden daha bilgili bir kul bulmak için '
        'yola çıktı. Hızır ile yürürken sıra dışı üç olay yaşandı: bir '
        'gemi delindi, bir çocuk öldürüldü, yıkık bir duvar onarıldı. '
        'Musa sabredemedi, her seferinde sordu. Sonunda hikmet açığa '
        'çıktı: Zahirde kötü görünen şeylerin içinde hayır gizliydi. '
        'Sabır, kalbin en derin idrakidir.',
    kaynak: 'Kehf Sûresi 60-82 · ilim ve sabır kıssası',
  ),
];

KissaIcerik gununKissasi() {
  final gun = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
  return _kissalar[gun % _kissalar.length];
}
