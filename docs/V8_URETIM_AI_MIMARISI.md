# V8 – Üretim AI mimarisi

## Uygulamaya gömülen çalışan kısımlar

- `lib/services/firebase_ai_backend.dart`: Firebase başlatma, App Check
  (release'de Play Integrity, debug'da debug provider), anonim oturum ve
  `islamiAiSor` callable çağrısı.
- `lib/services/gemini_servisi.dart`: Önce güvenli backend; doğrudan Gemini
  çağrısı yalnız `kDebugMode` geliştirmesinde.
- `lib/screens/settings_screen.dart`: API anahtarı alanı yalnız debug'da
  görünür; yayın APK'sında kullanıcıdan anahtar istenmez.
- `lib/pages/ai_tefsir_page.dart`: Backend durumunu dinler; kota/ağ/backend
  hatasında otomatik olarak sınırsız çevrimdışı rehbere döner.
- `backend/functions/index.js`: App Check zorunlu, kimlik doğrulaması zorunlu,
  Secret Manager'dan `GEMINI_API_KEY`, kullanıcı başına günde 10 ve dakikada 3
  istek, 600 karakter giriş sınırı, kaynak temelli prompt, sağlayıcı hatasında
  kota iadesi.
- `firestore.rules`: İstemciden doğrudan okuma/yazma tamamen kapalı.
- `firebase.json`: Functions, Firestore ve Anonymous Authentication yapılandırması.

## Otomasyon betikleri

| Betik | İşlev |
| --- | --- |
| `FIREBASE_KURULUM.ps1` | Firebase CLI kurar, proje oluşturur/seçer, FlutterFire yapılandırır, Firestore oluşturur, secret ister, deploy eder |
| `FIREBASE_DEBUG_CALISTIR.ps1` | Yapılandırma ile debug çalıştırma |
| `RELEASE_IMZA_OLUSTUR.ps1` | Release keystore ve `key.properties` üretir |
| `RELEASE_AAB_OLUSTUR.ps1` | Test + imzalı AAB üretir |

## Hesap sahibinin bizzat yapması gerekenler

Bunlar Google hesabı yetkisi gerektirdiği için betikten tamamlanamaz:

1. `firebase login` tarayıcı onayı.
2. Cloud Functions için Blaze faturalandırma planının kabulü.
3. Gemini anahtarının Firebase CLI'nin güvenli isteminde girilmesi
   (anahtar hiçbir kaynak dosyada tutulmaz).
4. App Check ekranında Android uygulaması için Play Integrity kaydı.
5. Play Console'a yükleyecekseniz release imzasının SHA-256 kaydı.

## Doğrulama durumu

- `node --check` ve backend katalog testi bu ortamda geçti.
- Yapısal kaynak denetimi geçti; 9 dilde 1712 çeviri anahtarı eşit.
- Flutter testleri ve Android derlemesi bu ortamda çalıştırılamaz (SDK yok);
  `RELEASE_AAB_OLUSTUR.ps1` bunları sizin makinenizde çalıştırır.
- `test/sesli_kissalar_etkilesim_test.dart` önceden beri atlanan tek testtir.

## Maliyet ve güvenlik notları

- Gemini kullanımı proje düzeyinde ücretli/kotalıdır; "sınırsız ücretsiz"
  garanti edilemez. Kullanıcı başına günlük 10 istek sınırı bu yüzden vardır.
- Çevrimdışı rehber sınırsızdır ve kota tükenince otomatik devreye girer.
- Kaynak kataloğu teknik bir başlangıç setidir; yayından önce yetkin
  editörlerce gözden geçirilmelidir.
