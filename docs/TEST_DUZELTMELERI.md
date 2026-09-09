# Test raporuna göre düzeltmeler — 8 Eylül 2026

## Gelen sonuç ve doğrulama sınırı

Kullanıcının önceki paket üzerinde çalıştırdığı tüm test sonucu: **143 başarılı, 25 başarısız, 1 atlanmış**. Önceki paketin debug APK derlemesi ve emülatörde başlangıcı da kullanıcı çıktısıyla doğrulandı. Bu, BU YENİ PAKETİN test sonucu değildir. Burada Flutter/Dart SDK olmadığı için yamalar sonrasında Flutter testleri yeniden çalıştırılamadı. Yapısal kontroller derleme veya ekran testi yerine geçmez.

## Uygulanan düzeltmeler

### 18 ana sayfa/açılış testi
- `test/helpers/app_test_harness.dart` ortak başlangıç yordamı eklendi.
- Asenkron yerelleştirme yüklenip gerçek açılış ekranı oluşmadan test saati ilerletilmiyor.
- Açılış ekranının varlığı ve ana sayfanın henüz bulunmaması açıkça doğrulanıyor; sonra 5 saniye ve rota animasyonu ilerletiliyor, ana sayfanın varlığı doğrulanıyor.
- Testler doğrudan AnaSayfa açarak splash kontrolünü atlamıyor.
- Vakit/konum için yalnız testte kullanılan yerel fikstür hazırlandı. Kayıtlı profil ve bildirim tohumları silinmiyor.
- Metinle hedeflenen kontrollere dokunmadan önce gerektiğinde kaydırma yapılıyor; testler eski ekran koordinatlarına bağlı değil.
- Test sonunda widget ağacı kaldırılarak zamanlayıcıların ve dinleyicilerin temizlenmesi sağlanıyor.

### 4 yinelenen ikon testi ve diğer ikon kullanıcıları
- `UcdIkon` içinde görsel derinlik için üç ayrı Icon kullanılıyordu.
- Metalik ön yüz tek Icon olarak korundu. Kabartı ve yansıma katmanları Canvas üzerinde çiziliyor; ayrı dokunma hedefi veya erişilebilirlik öğesi değiller.
- Böylece `find.byIcon` tek mantıksal simge buluyor; testsiz `.first`/`findsWidgets` ile hatayı gizleme yapılmadı.
- RTL yönü ve font ailesi/paketi dekoratif çizimde korunuyor. Bu pakette görsel altın dosyaları güncellenmedi.

### Hadis dili beklentisi
- Eski test Melayu için Endonezce veritabanı bekliyordu. Mevcut İngilizce yedek davranışı testte açıkça belirtildi.
- Bu değişiklik Malayca hadis verisi sağlamaz. Doğrulanmış Malayca kaynak içeriği hâlâ ayrı açık iştir.

### 2 bildirim arayüz testi ve bildirim kuyruğu
- Beklenen dakika mesajı gerçek Türkçe yerelleştirmeye (`İmsak Namazı`) uyarlandı; kaydedilen 45 dakika değeri kontrolü korundu.
- Android bildirim kanalı testte açıkça taklit ediliyor; initialize, izin, show ve zonedSchedule çağrıları kontrollü yanıt alıyor.
- Test düğmesi artık yalnızca herhangi bir SnackBar aramıyor; bir anlık ve bir zamanlı OS isteği ile başarı metnini doğruluyor.
- Üretim bildirim servisi artık tamamlanmış kuyruk Future'ını süresiz saklamıyor. Kuyruk boşalınca referans temizleniyor; aktif işlemler sıralı kalıyor.
- Her test için servis durumunu sıfırlayan test yordamı eklendi. Üretim koduna testte otomatik başarı döndüren debug kestirmesi eklenmedi.

### Medya alıcısı
- Emülatör günlüğündeki medya tuşu alıcısı uyarısı için audio_service MediaButtonReceiver bildirimi Android manifestine eklendi.
- Bu alıcı yeni APK kurularak ve kulaklık/medya tuşuyla doğrulanmalı; hot reload manifest değişikliğini uygulamaz.

## Yeni regresyon testleri

`suite_fix_regression_test.dart` içine altı test eklendi:
1. Tek 3D ikon ve tek düğme tıklaması.
2. Gölgesiz RTL ikon.
3. Zamanlama ve yedek zamanlama başarısızlığında false sonucu.
4. İzin reddinde yanlış başarı bildirilmemesi.
5. Anlık ve zamanlı testlerin ayrı platform çağrılarına dönüşmesi.
6. Tamamlanmış bildirim kuyruğunun yeniden kullanılabilmesi.

Bu altı test yazıldı; bu ortamda çalıştırılmadı. Gerçek cihaz bildirim teslimi taklit platform testleriyle doğrulanamaz.

## Atlanan test

Kaynak projede zaten `skip: true` olan canlı podcast/radyo testi korunmuştur; yeni bir test atlanmadı veya silinmedi. Bu test just_audio/yerel oynatıcı entegrasyonu için gerçek platform veya daha kapsamlı sahte oynatıcı gerektirir. Paket bütün testleri ve entegrasyonları geçmiştir iddiası taşımaz. Bu açık testi yalnızca yeşil sonuç elde etmek için etkinleştirip gerçek oynatma denetimini kaldırmadık.

## Yeniden çalıştırma

Yeni ZIP'i eski proje üzerine değil yeni bir klasöre çıkarın. `pubspec.yaml` bulunan klasörde:

```powershell
flutter pub get
flutter test --reporter expanded 2>&1 | Tee-Object -FilePath .\tum_test_sonuclari_v2.txt
```

Ardından yeni APK için:

```powershell
flutter run -d emulator-5554
```

Sonuç dosyası tekrar değerlendirilmeden 25 başarısızlığın tamamı giderildi veya sıfır hata kaldı denemez. Yeni testler, önceki hatalar yüzünden erişilemeyen daha sonraki adımlarda başka sorunlar açığa çıkarabilir. Önceki içerik, lisans, çevrimdışı veri, topluluk altyapısı ve release imzası sınırları `INCELEME_VE_TEST_RAPORU.md` içinde geçerliliğini korur.
