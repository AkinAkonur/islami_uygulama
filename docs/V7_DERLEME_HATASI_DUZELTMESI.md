# V7 derleme düzeltmesi

Son V6 ZIP doğrudan açılıp denetlendi. ZIP CRC sağlamdı ve Android yol kontrolü ayarı mevcuttu. Ancak sonradan eklenen `AiTefsirPage._askAi()` içinde gerçek bir Dart derleme hatası bulundu: metodun kapsamı dışında kalan `onlineHazir` adı kullanılıyordu. Bu ifade `_gemini.hazir` olarak düzeltildi.

Ek denetimler:
- AI sayfası, Ayarlar ekranı ve AyarlarStore süslü parantez dengesi
- son eklenen importların hedefleri
- cihazdaki API anahtarının servise bağlanması
- dokuz dilde 1712 anahtar eşitliği
- Android `android.overridePathCheck=true`
- gömülü API anahtarı örüntüsü bulunmaması
- mevcut tek `skip: true` dışında yeni test atlaması olmaması
- ZIP CRC ve arşivdeki proje dosyalarının çalışma ağacıyla byte-byte eşleşmesi

Bu ortamda Flutter/Dart SDK bulunmadığı için `flutter analyze`, `flutter test` ve Android derlemesi çalıştırılamadı. Kaynak denetimi derleme sonucu değildir. V7 yeni klasöre çıkarılıp test edilmelidir.

Not: API anahtarı SharedPreferences içinde yalnızca cihazda tutulur fakat şifreli kasa değildir. Üretim dağıtımında istemciye ortak sağlayıcı anahtarı koymayın; sunucu aracısı kullanın.
