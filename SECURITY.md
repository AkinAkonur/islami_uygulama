# Güvenlik ve sır yönetimi

## Depoya asla girmemesi gereken dosyalar

| Dosya | Nedir | Nasıl üretilir |
| --- | --- | --- |
| `config/firebase.production.json` | Üretim Firebase yapılandırması | `config/firebase.production.example.json` kopyalanır |
| `.firebaserc` | Aktif Firebase projesi | `.firebaserc.example` kopyalanır |
| `android/key.properties` | Release imza şifreleri | `android/key.properties.example` kopyalanır |
| `android/app/release-keystore.jks` | Release imza anahtarı | `RELEASE_IMZA_OLUSTUR.ps1` |
| `android/app/google-services.json` | Firebase Android yapılandırması | Firebase Console / FlutterFire |
| `ios/Runner/GoogleService-Info.plist` | Firebase iOS yapılandırması | Firebase Console / FlutterFire |
| `lib/firebase_options.dart` | FlutterFire üretimi | `flutterfire configure` |
| `.env`, `.env.*` | Yerel ortam değişkenleri | Elle |

Hepsi `.gitignore` içindedir. Kontrol için:

```bash
bash tool/secret_scan.sh
```

Bu betik CI'da her push'ta da çalışır (`.github/workflows/ci.yml`).

## Gemini API anahtarı

- Anahtar **hiçbir kaynak dosyada, APK içinde veya sohbette** tutulmaz.
- Üretimde anahtar yalnız Google Cloud **Secret Manager**'da (`GEMINI_API_KEY`) durur ve
  yalnız `backend/functions/index.js` callable fonksiyonu okur.
- İstemci tarafı Firebase Auth (anonim) + App Check ile doğrulanır; Firestore kuralları
  istemciden tüm okuma/yazmayı kapatır.
- Doğrudan Gemini çağrısı yalnız `kDebugMode` geliştirmesinde ve geliştiricinin kendi
  cihaz ayarındaki anahtarla çalışır.

## Kota ve kötüye kullanım koruması

- Kullanıcı başına günde 10, dakikada 3 istek; 600 karakter giriş sınırı.
- Sağlayıcı hatasında kota iade edilir.
- Kota tükendiğinde uygulama otomatik olarak sınırsız çevrimdışı rehbere düşer.

## Yanlışlıkla sır gönderildiyse

1. Anahtarı/keystore'u derhal **iptal edip yenileyin** (Google Cloud, Play Console).
2. Ardından geçmişi temizleyin (`git filter-repo` veya yeni depo).
3. Sadece dosyayı silmek yeterli değildir; git geçmişinde kalır.

## Güvenlik açığı bildirimi

Açığı herkese açık issue olarak açmayın; depo sahibine özel olarak bildirin.
