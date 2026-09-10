#!/usr/bin/env bash
# Depoya sır sızmasını engelleyen basit kontrol.
# Kullanım: bash tool/secret_scan.sh
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1

hata=0

echo "== 1) Takip edilmemesi gereken dosyalar =="
yasakli=(
  "config/firebase.production.json"
  "android/key.properties"
  "android/app/release-keystore.jks"
  "android/app/google-services.json"
  "ios/Runner/GoogleService-Info.plist"
  "lib/firebase_options.dart"
  ".firebaserc"
  ".env"
)
for dosya in "${yasakli[@]}"; do
  if git ls-files --error-unmatch "$dosya" >/dev/null 2>&1; then
    echo "HATA: $dosya git tarafından takip ediliyor."
    hata=1
  fi
done

echo "== 2) Anahtar/sertifika desenleri =="
if git ls-files -z | xargs -0 grep -InE 'AIza[0-9A-Za-z_-]{30,}|-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----|ya29\.[0-9A-Za-z_-]{20,}' 2>/dev/null | grep -v '^tool/secret_scan.sh'; then
  echo "HATA: Kaynak içinde anahtar benzeri değer bulundu."
  hata=1
fi

echo "== 3) Uzantı kontrolü =="
if git ls-files | grep -Ei '\.(jks|keystore|p12|pem|mobileprovision)$'; then
  echo "HATA: İmza/sertifika dosyası takip ediliyor."
  hata=1
fi

if [ "$hata" -eq 0 ]; then
  echo "Sır taraması temiz."
fi
exit "$hata"
