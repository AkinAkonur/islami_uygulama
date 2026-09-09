# İslami Uygulama

Kur'an, namaz vakitleri, dualar, hadis kütüphanesi, kıble pusulası, Hac & Umre rehberi,
kıssalar ve ümmet topluluğu özelliklerini bir arada sunan **çok dilli Flutter uygulaması**.

[![CI](https://github.com/AkinAkonur/islami_uygulama/actions/workflows/ci.yml/badge.svg)](https://github.com/AkinAkonur/islami_uygulama/actions/workflows/ci.yml)

- **Geçerli sürüm:** V8 — üretim AI mimarisi (Firebase Auth + App Check + callable backend + Secret Manager + kota + çevrimdışı yedek)
- **Diller:** Türkçe, İngilizce, Arapça, Bengalce, Fransızca, Endonezce, Malayca, Rusça, Urduca (9 dil, 1712 eş çeviri anahtarı)
- **Platformlar:** Android (ana hedef), iOS, Web, Windows iskeletleri mevcut

## Hızlı başlangıç

ZIP ile geldiyseniz **yeni bir klasöre** çıkarın; eski proje üzerine kopyalamayın.

```powershell
flutter clean
flutter pub get
flutter run
```

Dart SDK koşulu: `^3.12.2` — uyumlu Flutter SDK gerekir. Bağımlılık kilidi (`pubspec.lock`)
bilinçli olarak korunmuştur; toplu sürüm yükseltmesi yapılmamıştır.

## Doğrulama

```powershell
.\tool\verify_project.ps1     # clean + pub get + analyze + test + debug APK
```

PowerShell betik yürütmesine izin verilmiyorsa adımları tek tek çalıştırın:

```powershell
flutter analyze
flutter test
flutter build apk --debug
```

SDK gerektirmeyen ek kontroller (Linux/macOS/WSL veya CI):

```bash
python tool/source_audit.py            # yapısal kaynak denetimi
bash tool/secret_scan.sh               # sır taraması
node --check backend/functions/index.js
node backend/functions/test/retrieval_test.js
```

Bunlar `flutter analyze`/`flutter test` yerine geçmez.

### Sürekli entegrasyon

`.github/workflows/ci.yml` her push ve pull request'te GitHub'da şunları çalıştırır:
`flutter analyze`, `flutter test`, backend sözdizimi + katalog testi, yapısal denetim ve sır taraması.
Böylece test sonuçları her zaman güncel görünür.

## Proje yapısı

| Yol | İçerik |
| --- | --- |
| `lib/pages/` | 100+ ekran (Kur'an, namaz, dualar, hadis, Hac & Umre, kıssalar, ümmet, AI tefsir) |
| `lib/screens/` | Namaz kılınış, abdest, kaza, ayarlar ekranları |
| `lib/services/` | Vakit servisi, bildirim merkezi, Kur'an API, hadis SQLite, konum/cami, medya, AI geçidi |
| `lib/l10n/` | 9 dilin çeviri kataloğu ve dil hizmetleri |
| `lib/widgets/`, `lib/tema.dart` | Altın/yeşil "tactile" tasarım dili |
| `assets/` | 30 cüz JSON, dualar, ilham/hikmet, gömülü hadis SQLite, görseller |
| `backend/functions/` | Firebase Cloud Functions — `islamiAiSor` callable (Node 22) |
| `test/` | 34 test dosyası ve golden görsel testi |
| `docs/` | Sürüm notları, inceleme raporları, denetim çıktıları |
| `tool/` | Denetim ve doğrulama betikleri |

## Yapılandırma (örnek dosyalardan kopyalayın)

```bash
cp .firebaserc.example .firebaserc
cp config/firebase.production.example.json config/firebase.production.json
cp android/key.properties.example android/key.properties
```

Bu dosyaların gerçek sürümleri `.gitignore` içindedir ve **asla depoya gönderilmez**.
Ayrıntı: [`SECURITY.md`](SECURITY.md).

### Otomasyon betikleri

| Betik | İşlev |
| --- | --- |
| `FIREBASE_KURULUM.ps1` | Firebase CLI kurar, proje seçer, FlutterFire yapılandırır, Firestore oluşturur, secret ister, deploy eder |
| `FIREBASE_DEBUG_CALISTIR.ps1` | Yapılandırma ile debug çalıştırma |
| `RELEASE_IMZA_OLUSTUR.ps1` | Release keystore ve `key.properties` üretir |
| `RELEASE_AAB_OLUSTUR.ps1` | Test + imzalı AAB üretir |
| `GITHUB_PUSH.ps1` | Sır kontrolü yaptıktan sonra GitHub'a gönderir |

## AI mimarisi (V8)

- API anahtarı istemcide değil; Secret Manager'da tutulur ve yalnız callable backend okur.
- App Check (release'de Play Integrity) + anonim Firebase Auth zorunludur.
- Kullanıcı başına günde 10 / dakikada 3 istek, 600 karakter giriş sınırı, hata durumunda kota iadesi.
- Kota/ağ/backend hatasında uygulama otomatik olarak sınırsız çevrimdışı rehbere düşer
  (çevrimdışı rehber AI değil, sınırlı bir referans rehberidir).

Ayrıntı: [`docs/V8_URETIM_AI_MIMARISI.md`](docs/V8_URETIM_AI_MIMARISI.md).

## GitHub'a gönderme

```powershell
.\GITHUB_PUSH.ps1                      # uretim-ai-v8 dalına
.\GITHUB_PUSH.ps1 -MainBranchinaGonder # doğrudan main dalına
```

Şifre yerine **Personal Access Token** kullanın ve token'ı yalnız Git'in kendi isteminde girin.

## Bilinen sınırlar

- Bildirimler güncel API verisiyle **üç günlük** planlanır; Workmanager/uygulama yeniler.
  Uzun süre çevrimdışı kalma, zorla durdurma veya tam alarm izninin kapalı olması nedeniyle
  zamanında teslim garantisi verilemez.
- Konum seçilmemişse İstanbul varsayılanı kullanılır; gerçek şehir seçilmeden saatlere güvenilmemelidir.
- Topluluk özelliklerinin bir kısmı henüz yerel simülasyondur; gerçek çok kullanıcılı altyapı kurulmamıştır.
- Uzak radyo/video/hadis/Kur'an sağlayıcıları canlı doğrulanmamıştır; yayın adresleri zamanla kapanabilir.
- Dini kaynak kataloğu teknik bir başlangıç setidir; yayından önce yetkin editörlerce gözden geçirilmelidir.
- Gemini kullanımı proje düzeyinde ücretli/kotalıdır; Cloud Functions için Blaze planı gerekir.

Tüm açık işler ve yayın öncesi kontrol listesi: [`docs/INCELEME_VE_TEST_RAPORU.md`](docs/INCELEME_VE_TEST_RAPORU.md)
ve [`docs/YAYIN_KONTROL_LISTESI.md`](docs/YAYIN_KONTROL_LISTESI.md).

## Sürüm geçmişi

| Sürüm | Özet | Belge |
| --- | --- | --- |
| V8 | Üretim AI mimarisi, Secret Manager, kota, App Check | `docs/V8_URETIM_AI_MIMARISI.md` |
| V7 | Derleme hatası düzeltmesi | `docs/V7_DERLEME_HATASI_DUZELTMESI.md` |
| V6 | AI anahtarı cihaz ayarına taşındı | `docs/API_ANAHTARI_NASIL_GIRILIR.md` |
| V5 | AI çözümü | `docs/AI_COZUMU_V5.md` |
| V4 | Kart hizası, ana ekran dili, çevrimdışı rehber | `docs/GORSEL_DIL_VE_REHBER_V4.md` |
| V3 | Test platformu düzeltmeleri | `docs/TEST_DUZELTMELERI_V3.md` |
| V2 | Kaynak düzeyi hata düzeltmeleri | `docs/TEST_DUZELTMELERI.md` |

## Lisans ve haklar

Proje sahibi: **Akin Akonur**. Depo için bir açık kaynak lisansı seçilmemiştir;
lisans dosyası eklenmediği sürece tüm haklar saklıdır.
Bildirim seslerinin lisans notları: `docs/bildirim_sesleri_lisans.txt`.
Dini veri kümelerinin ve ezan kaydının dağıtım lisansları yayından önce belgelenmelidir.
