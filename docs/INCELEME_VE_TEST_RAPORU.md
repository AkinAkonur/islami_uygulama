# Proje incelemesi ve düzeltme raporu

Tarih: 8 Eylül 2026
Temel: Önceki altın/yeşil, 3D kıble ve Android kaynak-adı düzeltmeli kaynak proje.

## Doğrulamanın sınırı

Bu paket kaynak incelemesi ve yapısal kontroller sonucunda hazırlanmıştır. Bu ortamda Flutter/Dart SDK, Android SDK ve emülatör bulunmadığı için `flutter analyze`, `flutter test`, Gradle derlemesi ve gerçek cihaz testleri ÇALIŞTIRILMADI. SDK indirme denemesinde DNS bağlantısı kurulamadı. Paket, hatasızlık veya mağazaya hazır olma garantisi taşımaz.

153 Dart kaynak dosyası otomatik kaynak taramasına dahil edildi. 82 Page/Screen sınıfı ve regex tabanlı tarayıcının bulduğu 167 etkileşim bileşeni envanterlendi. Bu sayılar ekranların açılıp tüm düğmelerin çalıştırıldığı anlamına GELMEZ; özel bileşenleri ve dinamik oluşturulan bütün rotaları eksiksiz doğrulamaz.

## Düzeltilen somut sorunlar

### Kur’an ve dil
- Secde bilgisi bazı API yanıtlarında boolean yerine nesne olabiliyor. Sure okumasındaki hatalı boolean dönüşümü kaldırıldı; sure/cüz/tek ayet aynı kontrolü kullanıyor.
- Meal menüsü daha önce yalnızca işareti değiştiriyordu. Seçilen edisyon artık API isteğine aktarılıyor ve metin yeniden yükleniyor.
- Türkçe dışındaki dillerde, Türkçe meal seçenekleri seçilmiş dilin içeriği gibi sunulmuyor. Seçili dile ait meal kaynağı gösteriliyor.
- Açık sure/cüz okuma sayfası, uygulama dili değişince metinleri tekrar istiyor. Geciken eski istek yeni seçimi ezemiyor.
- Cüz yüklenirken dil değişmesi nedeniyle eski/yeni edisyon anahtarlarının karışması giderildi.
- Kur’an araması artık sabit Türkçe yerine aktif meal edisyonunu kullanıyor.
- Sure/cüz numaraları ve tek hedef şartı istek öncesinde doğrulanıyor.
- Kayıtlı bölgesel dil kodları normalize ediliyor; desteklenmeyen kayıt Türkçe varsayılana dönüyor.
- Açılış ekranının üç metni ve yeni uyarılar dokuz dile eklendi.

### Namaz ve bildirimler
- Bugünün vakitlerini her gün aynı saatte tekrarlama kaldırıldı. Bugün ve takip eden iki gün, o tarihin API verisi ve konumun saat dilimi kullanılarak tek seferlik planlanıyor.
- API başarısızlığında örnek saatler doğrulanmış günlük önbellek olarak kaydedilmiyor ve bu saatlerle OS bildirimi kurulmuyor.
- Eski sürümün doğrulanmamış önbelleği geçerli kabul edilmiyor. Ana sayfada örnek saatler gösterildiğinde uyarı var.
- Aladhan isteklerinde tarih endpoint yoluna taşındı. Saat metninde ek zaman dilimi ifadesi varsa saat/dakika ayrıştırması buna dayanıklı.
- Genel bildirim kapatma ve sessiz mod dua/ilham planlama yollarında da kontrol ediliyor.
- Android kanal kimliği hem ses hem titreşim tercihini içeriyor. Android mevcut kanalın titreşim/ses özelliklerini uygulama isteğiyle değiştirmediği için yeni sürümlenmiş kanallar kullanılıyor; eski kanallar kullanıcıya ait sistem ayarlarını silmemek için topluca silinmiyor.
- Yeni “Sessiz (ses kapalı)” seçeneği eklendi. Titreşim açık bırakılarak yalnız titreşim kullanılabilir. Yerleşik özel sesler Android içindir; iOS için özel ses paketlemesi yapılmadı.
- Önceki `.mp3` biçimli ses kayıtları ve yeni kaynak kodları okunuyor; şema dosya adını saklamaya devam ediyor.
- Geçersiz dakika değerleri ayar listesine sokulmuyor.
- Zamanlı bildirim testi planlama başarısızlığında artık başarı döndürmüyor. Android debug APK’de de izin durumu sorgulanıyor.
- Dua hatırlatıcıları tam alarm izni yoksa yaklaşık planlamayı deniyor. Silinmiş dua ve ilham hatırlatıcılarının bekleyen kayıtları temizleniyor.
- Arka plan görevi izin ekranı açmayı denemiyor. Ön plandaki planlama istekleri sıraya alınıyor; konum değişimi ve uygulamaya dönüşte yenileme ekleniyor.
- İmsak öncesi ana sayfa geri sayımına yanlışlıkla 24 saat eklenmesi düzeltildi.

### Açılış, oynatma ve dayanıklılık
- Bağımsız başlangıç servisleri ayrıldı. Yayın veya medya başlatma hatası bildirim kurulumunu kesmiyor.
- `just_audio.play()` sonucu oynatma bittiğinde tamamlanır. Radyo ve sure okumasında bu sonucu bekleyerek arayüz güncellemesini geciktiren kullanım giderildi; oynatma hataları yakalanıyor.
- Başka içerik aynı global oynatıcıyı kullanınca Kur’an sayfasının yanlış indeks/bitirme olayını işlemesine karşı kaynak kontrolü eklendi.
- Pusulada geçersiz/sonsuz sensör değerleri ve sensör hatası sonrasında eski hizalanma durumu temizleniyor. Konum hatasında yüklenme göstergesi kapanıyor.
- Android pil/uygulama ayarlarını açan düğmeler desteklenmeyen platform çağrılarında uygulamayı hataya düşürmüyor.
- Medya indirmelerinde bağlantı/akış zaman aşımı, 250 MiB boyut sınırı, boş/eksik dosya kontrolü, dosya adı temizliği ve yarım dosya temizliği eklendi.
- Yapay zekâ servisindeki model seçimi yapılandırılabilir hale getirildi. Çalışır anahtar veya uzak servis doğrulaması yapıldığı iddia edilmiyor.
- Android titreşim izni açıkça tanımlandı. Önceki NOTICE.txt kaynak adı düzeltmesi korundu.

## Eklenen doğrulama araçları

- `test/review_regression_test.dart`: 10 regresyon testi. Secde türü, ses kaydı uyumluluğu, yalnız titreşim tercihi, hatalı dakika, kayıtlı dil, dil bazlı arama, gerçek meal seçimi, istek sırasında dil değişimi ve sure/cüz sınırlarını kapsar. Testler yazıldı, burada ÇALIŞTIRILMADI.
- Mevcut ana sayfa widget testlerine 5 saniyelik açılış geçişi eklendi.
- Test tanımlamayan manuel ağ kontrolü `test/api_smoke_test.dart` yerine `tool/api_smoke.dart` içine taşındı; böylece normal test keşfine karışmaz.
- `tool/source_audit.py`: Python ile relatif import, kaynak dosyası adı, XML/JSON, gömülü ZIP bütünlüğü, çeviri anahtarları ve ses varlığı denetimi.
- `tool/verify_project.ps1`: Windows bilgisayarında gerçek Flutter analiz/test/debug APK adımlarını kaydederek çalıştırır.
- `docs/source_audit.json`: bu ortamda gerçekten çalıştırılmış yapısal denetim sonucu.

## Çalıştırılan kontroller

- Yapısal denetim: hata listesi boş.
- Dokuz dilde aynı 1.679 çeviri anahtarı; yinelenen veya çağrılan fakat tanımsız sabit anahtar bulunmadı. Bu, tüm metinlerin yerelleştirildiği veya çevirilerin dilbilimsel olarak kusursuz olduğu anlamına gelmez.
- Android XML ve asset JSON dosyaları ayrıştırıldı; res dosya adları kontrol edildi.
- Kaynak importları, test importları ve gömülü ZIP CRC’leri kontrol edildi.
- Dört MP3 dosyası ffprobe ile okunabildi. Mevcut `ezan_kisa.mp3` yaklaşık 178 saniyedir; adı “kısa” olsa da kısa zil değildir. Yeni zil dosyaları yaklaşık 0,89–1,12 saniyedir.
- Flutter analiz/test/derleme/telefon: ÇALIŞTIRILMADI.

## Açık kalan ve yayın öncesi tamamlanması gerekenler

1. **Gerçek telefon doğrulaması:** SM A145F üzerinde bütün sayfalar, geri gezinme, kaydırma, büyük yazı, dar ekran, RTL, tema ve oynatma denenmeli. Statik tarama bunları kanıtlamaz.
2. **Bildirim güvenilirliği:** üç günlük programın devamı uygulama/Workmanager yenilemesine ve güncel veriye bağlı. Üç günden uzun çevrimdışı kalma veya Android zorla durdurma durumunda kesintisizlik garanti edilemez. Tam alarm izni yoksa yaklaşık alarm gecikmesi işletim sistemine bağlıdır; “en fazla birkaç dakika” garantisi yoktur. Kullanıcının sistemde değiştirdiği kanal sesi/titreşimi uygulama tercihini geçersiz kılabilir.
3. **Konum/ağ yokluğu:** ana sayfada örnek saat uyarısı eklendi, ancak diğer vakit kullanan ekranların tamamında ayrı veri-doğruluğu sunumu henüz birleştirilmedi. Konum seçilmemişse mevcut İstanbul varsayılanı sürüyor; gerçek şehir seçilmeden saatlere güvenilmemeli. Tarih değişimi, seyahat ve sistem saat dilimi değişimi cihazda ayrıca test edilmeli.
4. **İçerik dilleri:** arayüz anahtarlarının eşitliği, bütün dua/hadis/sure açıklaması veri setlerinin dokuz dilde bulunduğu anlamına gelmez. Bazı metinler Türkçe sabit, hadis sağlayıcısının Malayca kaynağı yoksa mevcut İngilizce yedek kullanılıyor. Eksik dinî metin çevirileri uydurulmadı; doğrulanmış kaynak ve lisans gerektirir.
5. **Topluluk özellikleri:** Dua Kardeşliği ilk akışı örnek yerel veriyle oluşturuyor. Bazı oda aramaları yerel simülasyondur. Gerçek çok kullanıcılı altyapı, kimlik doğrulama, moderasyon ve sunucu eşitlemesi bu pakette kurulmadı.
6. **Uzak servisler:** canlı radyo/video, hadis ve Kur’an sağlayıcıları bu ortamdan canlı doğrulanamadı. Yayın URL’leri zamanla kapanabilir. Yapay zekâ için geçerli servis yapılandırması gerekir; APK içine gömülen anahtar gizli kabul edilmemeli, üretimde sunucu aracısı tercih edilmeli.
7. **Çevrimdışı içerik:** tam Kur’an meali ve çok dilli hadis çevrimdışı indirme/önbellek sistemi tamamlanmış sayılmamalı.
8. **Yayınlama:** release keystore ve imzalı AAB, güncel gizlilik beyanları, SDK/eklenti uyumluluğu ve mağaza politikaları ayrıca tamamlanmalı. Bağımlılıklar topluca yükseltilmedi; KGP uyarısını test edilmemiş bir sürüm yükseltmesiyle gizlemekten kaçınıldı.
9. **Lisanslar:** üç sentez zilinin notu `docs/bildirim_sesleri_lisans.txt` içinde. Projeden gelen ezan kaydının ve uzak/yerel dinî veri kümelerinin dağıtım lisansları ayrıca belgelenmeli.

## Telefon kontrol sırası

- ZIP’i eski klasörün üzerine açmayın; yeni bir klasör kullanın.
- `flutter clean`, `flutter pub get`, `flutter run`.
- Açılış 5 saniye, geri tuşu, ana menüden her ekran.
- Türkçe → Melayu → Arapça; açık sure okumasında meal yenilenmesi ve RTL.
- Secde ayeti içeren sure/cüz; meal seçimi; Kur’an/radyo arasında geçiş; duraklat/devam.
- Dört ses + sessiz, titreşim açık/kapalı; anlık ve 5 saniyelik bildirim.
- Bildirim master kapalı, tam alarm izni reddedilmiş, telefon yeniden başlatılmış ve uygulama arka planda senaryoları.
- Konum kapalı, sensör yok, ağ yok, indirme yarıda kesilmiş senaryoları.
- Sabah imsak öncesi geri sayım, gün değişimi, farklı şehir ve saat dilimi.

Bulunan yeni derleme veya çalışma hatasının tam çıktısı sonraki düzeltme için gereklidir.
