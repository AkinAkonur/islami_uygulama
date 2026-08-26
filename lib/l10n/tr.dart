/// Türkçe çeviriler (referans dil).
const Map<String, String> trDil = {
  // ---------------- ANA SAYFA ----------------
  'h.priv': 'UÇTAN UCA GİZLİLİK',
  'h.how': 'Bugün nasıl hissediyorsun?',
  'h.daily': 'Günlük Maneviyat',
  'h.discover': 'Keşfet',
  'h.more': 'Daha Fazla',
  'h.duas': 'Dualar',
  'h.cuzler': 'Cüz''ler',
  'h.donate': 'Bağış',
  'h.ilham': 'İlham',
  'h.qiblaTitle': 'Kıble',
  'h.qiblaDir': 'Kıble Yönü',
  'h.kaaba': "Kâbe'ye Doğru",
  'h.locate': 'Konumla',
  'h.ayet': 'Günün Ayeti',
  'h.last': 'Son:',
  'h.streak': '{n} gün seri',
  'h.navHome': 'Ana Sayfa',
  'h.navNamaz': 'Namazlar',
  'h.navAi': 'AI',
  'h.navKuran': "Kur'an",
  'h.navUmmet': 'Ümmet',

  // Duygu durumları
  'm.huzurlu': 'Huzurlu',
  'm.sukurlu': 'Şükür Dolu',
  'm.yorgun': 'Yorgun',
  'm.umutlu': 'Umutlu',
  'm.kaygili': 'Kaygılı',

  // Günlük Maneviyat modülleri
  'mod.devam': 'Devam Et',
  'mod.gorev': 'Günlük Görevler',
  'mod.cami': 'Cami & Konum',
  'mod.camiAlt': 'Kıble, camiler ve vakitler',
  'mod.carki': 'Hedef Çarkı',
  'mod.carkiAlt': "Kuran · Zikir · Namaz",
  'mod.hizli': 'Hızlı Tesbih',
  'mod.dinle': 'Kuran Dinle',
  'mod.dinleAlt': "Kuran okuyucuları",
  'mod.widget': 'Widget Rehberi',
  'mod.widgetAlt': "Vakit widget'ı kurulumu",
  'mod.pusula': 'Kıble Pusulası',
  'mod.pusulaAlt': "Kabe'ye yönü bul",
  'mod.gorsel': 'Görsel Kılınış',
  'mod.gorselAlt': 'Namaz & abdest rehberi',

  // Namaz vakitleri
  'p.imsak': 'İmsak Namazı',
  'p.gunes': 'Güneş',
  'p.ogle': 'Öğle Namazı',
  'p.ikindi': 'İkindi Namazı',
  'p.aksam': 'Akşam Namazı',
  'p.yatsi': 'Yatsı Namazı',
  'v.yaklasan': 'YAKLAŞAN VAKİT',
  'v.siradaki': 'SIRADAKİ',
  'v.kaldi': 'kaldı',

  // Günün Ayeti
  'ay.1': 'Şüphesiz her zorlukla beraber bir kolaylık vardır.',
  'ay.2': "Bilesiniz ki, kalpler ancak Allah'ı anmakla huzur bulur.",
  'ay.3': 'O zaman beni anın ki ben de sizi anayım.',
  'ay.4': 'Andolsun, eğer şükrederseniz elbette size nimetimi artırırım.',
  'ay.5': 'Kim Allah’a tevekkül ederse, O, kendisine yeter.',
  'ay.6': 'Allah’ın rahmetinden ümidinizi kesmeyin.',
  'ay.7': 'Allah, hiç kimseye gücünün üstünde bir yük yüklemez.',
  'ref.1': 'İnşirah Suresi, 6. Ayet',
  'ref.2': "Ra'd Suresi, 28. Ayet",
  'ref.3': 'Bakara Suresi, 152. Ayet',
  'ref.4': 'İbrahim Suresi, 7. Ayet',
  'ref.5': 'Talak Suresi, 3. Ayet',
  'ref.6': 'Zümer Suresi, 53. Ayet',
  'ref.7': 'Bakara Suresi, 286. Ayet',

  // ---------------- AYARLAR ----------------
  'set.title': 'Ayarlar',
  'set.account': 'Hesap ve Profil',
  'set.editProfile': 'Profili Düzenle',
  'set.editProfileAlt': 'Fotoğraf, isim ve istatistikler',
  'set.time': 'Namaz Vakitleri ve Konum',
  'set.autoLoc': 'Otomatik Konum (GPS)',
  'set.autoLocAlt': 'Konum izni verilirse şehir otomatik algılanır',
  'set.method': 'Hesaplama Yöntemi',
  'set.methodDialog': 'Hesaplama Yöntemi',
  'set.methodAuto': 'Ülkeye göre otomatik',
  'set.methodInfo':
      "Namaz vakitleri Güneş'in konumuna göre hesaplanır. Dünyada kullanılan "
      'birçok hesap ekolü vardır; ülke ve bölgelere göre vakitler dakikalarca '
      'değişebilir. Seçtiğin yöntem vakit takvimine ve tüm bildirimlere '
      'uygulanır.',
  'set.notif': 'Bildirimler',
  'set.notifAll': 'Tüm Bildirimlere İzin Ver',
  'set.notifAllAlt': 'Namaz vakitleri, ayet ve özel gün bildirimleri',
  'set.notifCenter': 'Bildirim Merkezi',
  'set.notifCenterAlt': 'Sessiz mod, kaza sayacı, tür ayarları',
  'set.namazNotif': 'Namaz Vakti Hatırlatıcıları',
  'set.namazNotifAlt': 'Her vakit için ayrı hatırlatma süresi',
  'set.langSection': 'Dil ve Bölge',
  'set.lang': 'Dil',
  'set.langAlt': 'Tüm dünyadan Müslümanlar kendi dilini seçer',
  'set.chooseLang': 'Dili Seç',
  'set.langUpdated': 'Dil güncellendi.',
  'set.dark': 'Karanlık Mod',
  'set.darkAlt': 'Uygulama teması anında güncellenir',
  'set.appearance': 'Görünüm',
  'set.about': 'Hakkında',
  'set.privacy': 'Gizlilik Politikası',
  'set.privacyCenter': 'Gizlilik Merkezi',
  'set.privacyCenterAlt': 'İzinler, verilerinizi indirme ve silme',
  'set.rate': 'Uygulamayı Puanla',
  'set.version': 'Sürüm 1.0.0',
  'set.accent': 'Vurgu Rengi',
  'set.accentDialog': 'Vurgu Rengini Seç',
  'set.accentInfo': 'Vurgu rengi, uygulamanın ana renk tonunu belirler. '
      '"Otomatik" seçilirse renk namaz vaktine göre doğal olarak değişir.',
  's.accentUpdated': 'Vurgu rengi güncellendi.',
  'c.auto': 'Otomatik (vakte göre)',
  'c.zumrut': 'Zümrüt',
  'c.mavi': 'Mavi',
  'c.altin': 'Altın',
  'c.turkuaz': 'Turkuaz',
  'c.gul': 'Gül',

  // Yöntem açıklamaları
  'm.13': 'Türkiye için önerilir',
  'm.3': 'Dünya genelinde yaygın',
  'm.2': 'ABD ve Kanada için',
  'm.1': 'Güney Asya için',
  'm.4': 'Suudi Arabistan ve çevresi',
  'm.5': 'Afrika ve Orta Doğu',

  // Bilgi mesajları
  's.locUpdated': 'Konum güncellendi: {sehir}',
  's.locFail': 'Konum alınamadı. GPS iznini ve cihaz konumunu kontrol et, '
      'ya da Konum ekranından şehri manuel seçebilirsin.',
  's.notifOn': 'Tüm bildirimlere izin verildi.',
  's.notifOff': 'Tüm bildirimler kapatıldı.',
  's.methodUpdated': 'Yeni yöntemle vakitler güncellendi.',

  // Diyaloglar
  'd.privacy': 'Gizlilik Politikası',
  'd.privacyBody': 'Uygulama verilerinizi cihazınızda saklar; şehir ve konum '
      'bilgisi yalnızca namaz vakitlerini ve Kıble yönünü doğru hesaplamak '
      'için kullanılır. Konum bilgileri üçüncü taraflarla paylaşılmaz, '
      'kullanıcı tarafından silinebilir.',
  'd.understand': 'Anladım',
  'd.thanks': 'Teşekkürler! 🙏',
  'd.rateBody': 'Uygulamamızı kullandığın için mutluyuz. Uygulama '
      'mağazasından puanlayarak daha fazla kardeşe ulaşmamıza destek '
      'olabilirsin.',
  'd.ok': 'Tamam',

  // Gizlilik Politikası sayfası
  'pp.intro': 'Bu gizlilik politikası, Huzur & Manevi Yolculuk uygulamasının '
      'hangi bilgileri topladığını, nasıl kullandığını ve koruduğunu açıklar. '
      'Uygulamayı kullanarak bu politikayı kabul etmiş olursunuz.',
  'pp.s1t': 'Toplanan Veriler',
  'pp.s1b': 'Uygulama verilerinizin tamamını cihazınızda saklar; hesap '
      'oluşturmayı gerektirmez. Profil bilgileri, okuma ilerlemesi, ibadet '
      'kayıtları ve ayar tercihleriniz yalnızca yerel depolamada tutulur.',
  'pp.s2t': 'Konum ve Kıble Kullanımı',
  'pp.s2b': 'Namaz vakitlerini doğru hesaplamak ve Kıble yönünü bulmak için '
      'şehir veya koordinat bilginiz kullanılır. Bu bilgi yalnızca namaz '
      'vakitleri API hizmetine iletilir; hiçbir pazarlama amacıyla '
      'kullanılmaz ve cihaz dışında saklanmaz.',
  'pp.s3t': 'Bildirimler',
  'pp.s3b': 'Namaz vakitleri ve özel gün bildirimleri yalnızca sizin '
      'izninizle gönderilir. Bildirim tercihlerinizi ayarlar ekranından '
      'istediğiniz zaman açıp kapatabilirsiniz.',
  'pp.s4t': 'Üçüncü Taraflarla Paylaşım',
  'pp.s4b': 'Verileriniz hiçbir üçüncü taraf ile paylaşılmaz, satılmaz veya '
      'kiralanmaz. Uygulama isteğe bağlı ücretsiz API hizmetleri dışında '
      'herhangi bir dış bağlantı kurmaz.',
  'pp.s5t': 'Veri Saklama ve Silme',
  'pp.s5b': 'Verileriniz yalnızca cihazınızda güvenle saklanır. Uygulamayı '
      'kaldırdığınızda veya uygulama ayarlarından verileri temizlediğinizde '
      'tüm bilgileriniz kalıcı olarak silinir.',
  'pp.s6t': 'Çocuk Gizliliği',
  'pp.s6b': 'Uygulama genel içerik barındırır ve çocuk kullanıcılardan '
      'bilgi talep etmez. Yine de ailelerin artı gözetim yapması önerilir.',
  'pp.s7t': 'Değişiklikler ve İletişim',
  'pp.s7b': 'Bu politika güncellenebilir; önemli değişiklikler uygulama '
      'içinde duyurulur. Sorularınız için uygulama içi iletişim kanallarını '
      'kullanabilirsiniz.',
  'pp.last': 'Son güncelleme: Ağustos 2026',

  // Puanlama sayfası
  'r.baslik': 'Deneyimin nasıldı?',
  'r.baslikPuanli': 'Değerli görüşün için teşekkürler!',
  'r.altBaslik': 'Puanın, uygulamayı geliştirmemize ve daha fazla '
      'kardeşe ulaşmamıza yardımcı olur.',
  'r.soru': 'Uygulamayı kaç yıldızla değerlendirirsin?',
  'r.etiket1': 'Çok kötü',
  'r.etiket2': 'Kötü',
  'r.etiket3': 'İyi',
  'r.etiket4': 'Çok iyi',
  'r.etiket5': 'Mükemmel',
  'r.ipucu': 'Yukarıdaki yıldızlara dokunarak değerlendirmeye başlayabilirsin.',
  'r.oneriBaslik': 'Bizi geliştirmene yardım et',
  'r.oneriIpucu': 'Karşılaştığın sorun veya önerilerini buraya yazabilirsin…',
  'r.gonder': 'Geri Bildirimi Gönder',
  'r.gonderildi': 'Gönderildi',
  'r.gonderildiMetin': 'Görüşün bize ulaştı. Her geri bildirim uygulamayı '
      'daha iyi hale getirir.',
  'r.tesekkurBaslik': 'Çok sevindik!',
  'r.tesekkurMetin': 'Verdiğin yüksek puan bize güç veriyor. Puanını '
      'kaydederek bu memnuniyeti bizimle paylaşabilirsin.',
  'r.kaydet': 'Puanımı Kaydet',
  'r.kaydedildi': 'Puanın kaydedildi. Teşekkürler! 🙏',
  'r.not': 'Puanın yalnızca cihazında saklanır ve hiçbir sunucuya gönderilmez.',

  // ---------------- AI ASISTAN ----------------
  'ai.title': 'AI Tefsir & Asistan',
  'ai.hak': 'Hak',
  'ai.disclaimer': 'Bu asistan bilgi ve tefsir amaçlıdır; bağlayıcı dini hüküm '
      '(fetva) için yetkili bir âlime danışınız.',
  'ai.mode': 'Asistan Modu',
  'ai.askTitle': 'Ayet, Sure veya Manevi Soru Sorun',
  'ai.hint': 'Örn: Nisa 34 hakkında ne söylersin?',
  'ai.samples': 'Örnek Sorular',
  'ai.answerTitle': 'AI Yanıtı',
  'ai.apiMissingTitle': 'API anahtarı ayarlanmamış',
  'ai.apiMissingBody': 'Ücretsiz anahtar için: aistudio.google.com/apikey\n'
      'Sonra uygulamayı şöyle çalıştırın:\n'
      'flutter run --dart-define=GEMINI_API_KEY=ANAHTAR',
  'ai.fbUp': 'Geri bildiriminiz için teşekkürler!',
  'ai.fbDown': 'Geri bildiriminiz alındı.',
  'ai.c.tefsir': 'Kur\'an Tefsiri',
  'ai.c.fikih': 'Fıkıh & İbadet',
  'ai.c.akaid': 'Akaid & İman',
  'ai.c.hadis': 'Hadis & Sünnet',
  'ai.c.siyer': 'Siyer & Tarih',
  'ai.c.dua': 'Dua & Zikir',
  'ai.c.aile': 'Aile & Evlilik',
  'ai.c.teselli': 'Teselli & Umut',
  'ai.c.karsilastirma': 'Karşılaştırma',
  'ai.c.ogrenme': 'Öğrenme Modu',
  'ai.q1': 'Fatiha Suresini adım adım tefsir et.',
  'ai.q2': 'Sabır ile ilgili ayet ve hadisler nelerdir?',
  'ai.q3': 'Kaza namazı nasıl kılınır?',
  'ai.q4': 'Tefsir ile meal arasındaki fark nedir?',
  'ai.q5': 'Bağışlanma ve tövbe ile ilgili ayetler nelerdir?',
  'ai.q6': 'Anne babaya iyilik ile ilgili hadisler nelerdir?',
'ai.q7': 'Zor bir günde manevi destek için ne önerirsin?',
  'ai.q8': 'Zekât ile sadaka arasındaki fark nedir?',
  'ai.cs.tefsir.1': 'İhlas Suresinin tefsiri nedir?',
  'ai.cs.tefsir.2': 'Ayetel Kürsi ne anlatır?',
  'ai.cs.tefsir.3': 'Rahman Suresinde tekrarlanan ayetin hikmeti nedir?',
  'ai.cs.fikih.1': 'Namazın farzları nelerdir?',
  'ai.cs.fikih.2': 'Abdesti bozan şeyler nelerdir?',
  'ai.cs.fikih.3': 'Zekât nasıl hesaplanır?',
  'ai.cs.akaid.1': 'İmanın şartları nelerdir?',
  'ai.cs.akaid.2': 'Kader nedir, nasıl anlaşılır?',
  'ai.cs.akaid.3': 'Meleklere iman ne demektir?',
  'ai.cs.hadis.1': 'Güvenilir hadis kitapları hangileridir?',
  'ai.cs.hadis.2': 'Sahih ve zayıf hadis arasındaki fark nedir?',
  'ai.cs.hadis.3': 'Komşu hakkı ile ilgili hadisler nelerdir?',
  'ai.cs.siyer.1': 'Peygamberimizin çocukluğu hakkında bilgi ver.',
  'ai.cs.siyer.2': 'Hicret olayını anlatır mısın?',
  'ai.cs.siyer.3': 'Bedir Savaşını özetler misin?',
  'ai.cs.dua.1': 'Kur\'anda geçen duaları listeler misin?',
  'ai.cs.dua.2': 'Kaygı ve stres için hangi dua okunur?',
  'ai.cs.dua.3': 'Sabah ve akşam zikirleri nelerdir?',
  'ai.cs.aile.1': 'Evlilikte geçimi güzel tutmanın yolları nelerdir?',
  'ai.cs.aile.2': 'Anne baba hakları nelerdir?',
  'ai.cs.aile.3': 'İslamda çocuk terbiyesi nasıl olur?',
  'ai.cs.teselli.1': 'Kaygılıyım, içimi ferahlatacak ayetler hangileri?',
  'ai.cs.teselli.2': 'Keder ve üzüntü için manevi sözler söyle.',
  'ai.cs.teselli.3': 'Umudumu kaybediyorum, ne yapmalıyım?',
  'ai.cs.karsilastirma.1': 'Farz ve sünnet namaz arasındaki fark nedir?',
  'ai.cs.karsilastirma.2': 'Zekât ile sadaka farkı nedir?',
  'ai.cs.karsilastirma.3': 'Mezhepler arasındaki temel görüş farkları nelerdir?',
  'ai.cs.ogrenme.1': 'Tefsir ilmi nedir, kısaca açıkla.',
  'ai.cs.ogrenme.2': 'Fıkıh usulüne nasıl başlanır?',
  'ai.cs.ogrenme.3': 'Sık kullanılan İslami terimleri açıkla.',
  'ai.kaynak': 'Kaynak',
  'ai.kaynakNot': 'Bu yanıt bilgilendirme amaçlıdır; ayet ve hadis '
      'numaralarını mutlaka tefsir ve hadis kaynaklarından doğrulayınız.',
  'ai.yardimBaslik': 'Sana nasıl yardımcı olabilirim?',
  'ai.ornekBaslik': 'Hızlı Örnekler',
  'h.welcome': 'Hoşgeldin, {name}',
  'h.hijriYear': 'Hicri {year}',
  'h.ilhamDesc': 'Her gün yeni bir ilham, her an yeni bir keşif.',
  'h.ilhamExplore': 'İlham sayfasını keşfet →',
  'h.greeting.sub': 'Hicri {year}',
};