# V4 — ekran görüntülerine göre düzeltmeler

## 1. Dört ana ekran kartı
İkon ve etiketler kartın tamamına göre yatay ortalanır. Etiket alanı iki satır için eşit yüksekliktedir; kıble etiketi uzun açıklama yerine kısa başlıktır. Normal genişlikte dört kart yan yana, dar ekranda veya büyütülmüş metinde 2×2 yerleşim kullanılır. Altın-yeşil ve tek mantıksal 3D ikon korunmuştur.

## 2. Ana ekranda dil değişikliği
Karşılama mesajındaki varsayılan hitap, büyük vakit adı, altı kısa vakit etiketi, vakit saati başlığı ve hesaplama yöntemi aktif dilde render edilir. Dil değişince önceden önbelleğe alınmış Türkçe etiket kullanılmaz. Kullanıcının kendi yazdığı profil adı çevrilmez. Kurum kısaltmaları (MWL, ISNA) korunur. Dokuz dilin her birine 21 anahtar eklendi; toplam 1700 anahtar/dil. Bu çalışma tüm dini kaynak dosyalarının çevrildiği iddiasını taşımaz.

## 3. AI/API ve ücretsiz kullanım sınırı
Çevrimiçi AI'ı bütün kullanıcılara ücretsiz ve sınırsız sunan bir hizmet sağlanmadı; sağlayıcının maliyeti/kotası kaldırılmadı. API anahtarı yoksa uygulama hata veya derleme komutu göstermek yerine açıkça çevrimdışı rehber modunda açılır.

Çevrimdışı rehber gerçek AI değildir. Üç tefsir örneğini yerel ayet referanslarına eşleştirir: 112:1–4, 2:255, 55:13. Aynı referanslar elle de girilebilir. Bilinmeyen sorulara içerik uydurmaz. Yönlendirme metni seçilen dilde gösterilir; kapsamlı tefsir veya fetva üretmez. Bu yerel kullanım için internet, anahtar, sunucu ücreti veya günlük sayaç yoktur. Kur’an bölümünde açılan diğer içeriklerin internet/önbellek ihtiyaçları değişmemiştir.

API yapılandırılmışsa çevrimiçi AI korunur; kullanıcı çevrimdışı moda da geçebilir. Sağlayıcı kotasının geçerli olduğu belirtilir. API hatasında teknik yanıt/anahtar kullanıcıya gösterilmez; yerel rehbere geçiş sunulur. Kamuya dağıtılan APK'da ortak API anahtarı güvenli değildir: üretimde sunucu aracısı, kötüye kullanım sınırları ve bütçe gerekir. Bu pakete yeni ortak anahtar, kota atlatma veya kamuya açık bir AI arka ucu eklenmedi.

Sabit ve gerçeği yansıtmayan 5/5 rozeti kaldırıldı. AI sayfasının üst başlığı ve kaydırma alanı ayrıldı; durum çubuğuyla metinlerin üst üste binmesine neden olan app-bar arkasına taşma kaldırıldı. İşlevsiz mikrofon ve doğrulanmamış “Onaylı Tefsir/Âlim Modu” sunumu kaldırıldı; kaynak yönlendirmesi açıkça etiketlendi.

## Doğrulama
ÖNCEKİ V3: kullanıcının Windows ortamında 174 başarılı, 0 başarısız, 1 atlanan test doğrulandı.
BU V4: Flutter/Dart SDK bulunmadığından derleme, widget testleri ve ekran görüntüsü karşılaştırması burada çalıştırılamadı. Kaynak/import/çeviri anahtarları, Android XML, dosyalar ve ZIP bütünlüğü kontrol edildi. Önceki başarılı test sonucu V4 için geçerli sonuç gibi sunulamaz.

Kart merkez koordinatları ve dokunma; ana ekranda İngilizce→Melayu dil değişikliği; dokuz dilde çevrimdışı yanıt; API çağrısı yapılmaması; bilinmeyen sorunun reddi ve başlığın giriş alanını örtmemesi için testler eklendi. Mevcut AI ekran testi sahte kota yerine açık yerel mod etiketini kontrol eder. Testler yeniden çalıştırılmalıdır. Önceki tek canlı radyo testinin atlanması değişmedi.

## Kullanım
ZIP'in tamamını yeni klasöre çıkarın. TESTI_CALISTIR.cmd bütün testleri çalıştırır ve kaynak sürümünü doğrular. UYGULAMAYI_AC.cmd yanındaki projeyi emulator-5554 üzerinde yeniden derleyerek açar. İkisi de eski terminal klasörünü kullanmaz. Gerçek telefonda görsel, dil ve bildirim denetimleri ayrıca gereklidir.
