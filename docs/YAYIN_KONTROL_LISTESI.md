# Yayın öncesi kontrol listesi

Bu liste, kodda tamamlanan işlerle **hesap yetkisi gerektiren** veya **gerçek cihaz**
isteyen işleri ayırır. Kod tarafındaki maddeler bu paketle kapatılmıştır.

## 1. Depo hijyeni — tamamlandı

- [x] `.gitignore` genişletildi (iOS/macOS Firebase dosyaları, `.firebaserc`, `*.apk`/`*.aab`, editör ve işletim sistemi dosyaları).
- [x] `.gitattributes` eklendi; depoda LF, PowerShell betiklerinde CRLF, ikili dosyalar korumalı.
- [x] Tüm metin dosyalarının satır sonları LF'ye normalize edildi (PowerShell betikleri hariç).
- [x] `pubspec.yaml` açıklaması varsayılan "A new Flutter project" yerine gerçek açıklamayla değiştirildi.
- [x] `README.md` yeniden düzenlendi: güncel sürüm en üstte, proje yapısı, doğrulama, sürüm geçmişi tablosu.
- [x] `SECURITY.md` eklendi: sır yönetimi, anahtar iptal prosedürü.
- [x] `tool/secret_scan.sh` eklendi: yasaklı dosya ve gömülü anahtar taraması.
- [x] `.github/workflows/ci.yml` eklendi: her push'ta `flutter analyze`, `flutter test`,
      backend sözdizimi + katalog testi, yapısal denetim ve sır taraması.
- [x] `GITHUB_PUSH.ps1` yasaklı dosya listesi genişletildi.

## 2. Otomatik doğrulama — CI'ya devredildi

Daha önceki paketlerde "testler çalıştırılmadı" notu vardı; sebebi hazırlama ortamında
Flutter SDK bulunmamasıydı. Artık GitHub Actions bu adımları her gönderimde koşuyor.

- [ ] İlk push'tan sonra **Actions** sekmesinden CI sonucunu kontrol edin.
- [ ] `flutter analyze` uyarılarını ve varsa başarısız testleri tam çıktıyla ele alın.
- [ ] `test/sesli_kissalar_etkilesim_test.dart` öteden beri atlanan tek testtir; bilinçli durumdur.

## 3. Hesap sahibinin bizzat yapması gerekenler

Bunlar Google/GitHub hesap yetkisi gerektirdiği için koddan tamamlanamaz.

- [ ] `firebase login` tarayıcı onayı.
- [ ] Cloud Functions için **Blaze** faturalandırma planının kabulü.
- [ ] Gemini anahtarının Firebase CLI'nin güvenli isteminde girilmesi (`GEMINI_API_KEY`).
- [ ] App Check ekranında Android uygulaması için **Play Integrity** kaydı.
- [ ] `RELEASE_IMZA_OLUSTUR.ps1` ile release keystore üretimi ve güvenli yedeklemesi.
- [ ] Release imzasının **SHA-256** değerinin Play Console'a kaydedilmesi.
- [ ] GitHub Personal Access Token ile push (token asla dosyaya yazılmaz).

## 4. Gerçek cihaz doğrulaması

- [ ] Bir Android telefonda tüm sayfalar, geri gezinme, kaydırma, büyük yazı tipi, dar ekran, RTL, tema.
- [ ] Dil geçişi: Türkçe → Malayca → Arapça; açık sure okumasında meal yenilenmesi.
- [ ] Secde ayeti içeren sure/cüz; meal seçimi; Kur'an ile radyo arasında geçiş; durdur/devam.
- [ ] Dört bildirim sesi + sessiz mod; titreşim açık/kapalı; anında ve 5 saniyelik bildirim.
- [ ] Bildirim ana anahtarı kapalı, tam alarm izni reddedilmiş, telefon yeniden başlatılmış senaryoları.
- [ ] Konum kapalı, sensör yok, ağ yok, indirme yarıda kesilmiş senaryoları.
- [ ] İmsak öncesi geri sayım, gün değişimi, farklı şehir ve saat dilimi.

## 5. İçerik ve hukuk

- [ ] Dini metin, dua, hadis ve sure açıklamalarının yetkin editör incelemesi.
- [ ] Ezan kaydının ve uzak/yerel dini veri kümelerinin dağıtım lisanslarının belgelenmesi
      (mevcut not: `docs/bildirim_sesleri_lisans.txt`).
- [ ] Gizlilik politikası metninin ve Play Console veri güvenliği formunun güncellenmesi.
- [ ] Depo için lisans kararı: açık kaynak lisansı mı, yoksa "tüm hakları saklı" mı.

## 6. Bilinçli olarak yapılmayanlar

Bu maddeler kasten değiştirilmedi; test edilmemiş değişiklik riski taşıdıkları için
kararı cihaz üzerinde doğrulamaya bırakıldı.

- Bağımlılıklar toplu yükseltilmedi; `pubspec.lock` korundu.
- `just_audio`, `audioplayers` ve `audio_service` birlikte kullanılıyor; sadeleştirme cihaz testi ister.
- `assets/gorseller/medya_kapak.png` ve `medya_kapak.jpg` kodda doğrudan kullanılmıyor
  (yalnız `medya_kapak_bildirim.jpg` kullanılıyor). Silinmedi; görsel bir tercih olabilir.
  Silinirse yaklaşık 0,5 MB paket boyutu kazanılır.
- `ezan_kisa.mp3` yaklaşık 178 saniyedir; adı "kısa" olsa da kısa bir zil değildir.
  Kısaltılması ses düzenleme kararıdır.
