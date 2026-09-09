# AI API hatası çözümü — V5

## Sorunun nedeni
AI sayfası Google Gemini API anahtarı olmadan çevrimiçi istek atıyordu.
`gizli_anahtar.dart` boş; derlemede `--dart-define=GEMINI_API_KEY=...` yoktu.
Bu yüzden "API anahtarı tanımlı değil" hatası görünüyordu.

## Bu pakette ne değişti?
1. **Varsayılan mod: ücretsiz çevrimdışı rehber**
   - API anahtarı gerekmez.
   - İnternet kotası / sunucu ücreti yoktur.
   - Uygulama içi Soru-Cevap bilgi bankasından yanıt verir.
   - Bilinen tefsir örneklerini ayet referansına yönlendirir.

2. **API hatası kullanıcıya gösterilmez**
   - Anahtar yoksa yerel motor çalışır.
   - Çevrimiçi istek başarısız olursa otomatik yerel yedeğe düşer.
   - Ham API gövdesi, derleme komutu veya anahtar uyarısı ekrana yazılmaz.

3. **Gemini model adı** varsayılan olarak `gemini-2.0-flash` olacak şekilde düzeltildi
   (eski geçersiz varsayılan kaldırıldı). Yalnızca geçerli anahtar verildiğinde kullanılır.

## Önemli sınır
Bu çözüm **ücretsiz ve kotasız** çalışır; ancak **gerçek bulut AI sohbeti değildir**.
Yerel bilgi bankası + ayet yönlendirmesidir. Sınırsız gerçek Gemini/ChatGPT
benzeri üretim için kendi ücretsiz Google AI Studio anahtarınız gerekir ve
o anahtarın da Google tarafında kotası vardır. Ortak bir anahtarı APK içine
gömmek güvenli değildir ve tüm kullanıcılar için sınırsız hizmet garantisi vermez.

## İsteğe bağlı gerçek AI (kendi anahtarınız)
1. https://aistudio.google.com/apikey adresinden ücretsiz anahtar alın.
2. Çalıştırın:
```powershell
flutter run -d emulator-5554 --dart-define=GEMINI_API_KEY=SIZIN_ANAHTAR
```
Anahtar varsa sayfada çevrimdışı/çevrimiçi geçişi görünür. Anahtar yoksa
sadece ücretsiz yerel mod çalışır ve hata vermez.

## Doğrulama
Bu ortamda Flutter testleri çalıştırılamadı. Kaynak denetimi geçti.
Kullanıcıda:
```
TESTI_CALISTIR.cmd
UYGULAMAYI_AC.cmd
```
AI sayfasında örnek soruya dokunun; yanıt gelmeli, API hatası olmamalı.
