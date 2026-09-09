# V6 — AI anahtarı cihaz ayarına taşındı

API anahtarını sohbete yapıştırmayın.
Ayarlar → AI Asistan → Gemini API Anahtarı

Ayrıntı: docs/API_ANAHTARI_NASIL_GIRILIR.md

# V4 — Kart hizası, ana ekran dili ve çevrimdışı rehber

Ayrıntılar: `docs/GORSEL_DIL_VE_REHBER_V4.md`.
V3 testleri geçmişti; V4 için testler yeniden çalıştırılmalıdır.
Çevrimdışı rehber ücretsiz ve kotasızdır, ancak sınırlı bir referans rehberidir; AI değildir.

# V3 test platformu düzeltmesi

Son değişiklikler: `docs/TEST_DUZELTMELERI_V3.md`. V2 test sonucu 167 başarılı / 7 başarısız / 1 atlanan. V3 testleri yeniden çalıştırılmalıdır.

# İslami Uygulama — test düzeltme paketi

Altın/yeşil görünüm ve önceki özellikler korunarak kaynak düzeyinde hata düzeltmeleri yapıldı.
Önceki paket kullanıcının emülatöründe derlendi; 10 regresyon testi geçti.
Bu yeni test düzeltme paketinin Flutter testleri yeniden çalıştırılmalıdır.
Son test raporundaki 143 başarılı / 25 başarısız / 1 atlanan sonuç önceki pakete aittir.
Yeni yamalar için bkz. `docs/TEST_DUZELTMELERI.md`.

## Başlatma

ZIP’i yeni klasöre çıkarın; eski proje üzerine kopyalamayın.

```powershell
flutter clean
flutter pub get
flutter run
```

Projede belirtilen Dart SDK koşulu: `^3.12.2`. Uyumlu Flutter SDK gerekir.
Bağımlılık kilit dosyası korundu; toplu sürüm yükseltmesi yapılmadı.

## Doğrulama

```powershell
.\tool\verify_project.ps1
```

PowerShell betik yürütmesine izin vermiyorsa aşağıdaki komutları ayrı ayrı çalıştırın:

```powershell
flutter analyze
flutter test
flutter build apk --debug
```

Yeni regresyon testini tek başına çalıştırmak için:

```powershell
flutter test test/review_regression_test.dart
```

Python kuruluysa yapısal kontrol: `python tool/source_audit.py`.
Yapısal kontrol Flutter analizinin yerine geçmez.

## Rapor

Ayrıntılı düzeltmeler, doğrulama sınırları ve açık kalan işler:
`docs/INCELEME_VE_TEST_RAPORU.md`.

Bildirimler güncel API verisiyle üç günlük planlanır; Workmanager/uygulama yeniler.
Uzun süre çevrimdışı kalma, zorla durdurma ve tam alarm izninin kapalı olması nedeniyle
zamanında teslim garantisi verilemez. Topluluk altyapısı, çok dilli kaynak içerik,
canlı yayınların doğrulanması ve release imzalama raporda ayrı açık işlerdir.
