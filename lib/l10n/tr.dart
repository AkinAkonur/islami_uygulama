/// Türkçe çeviriler (referans dil).
const Map<String, String> trDil = {
  // ---------------- ANA SAYFA ----------------
  'h.priv': 'UÇTAN UCA GİZLİLİK',
  'h.how': 'Bugün nasıl hissediyorsun?',
  'h.daily': 'Günlük Maneviyat',
  'h.discover': 'Keşfet',
  'h.more': 'Daha Fazla',
  'h.duas': 'Dualar',
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
  'h.navVideo': 'Videolar',

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
  'mod.tesbih': 'Tesbih',
  'mod.tesbihAlt': 'Zikir sayacı',

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
};