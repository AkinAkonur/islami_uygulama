# V8 Üretim AI sürümünü GitHub'a gönderir.
# Kullanım: PowerShell'i bu klasörde açıp  .\GITHUB_PUSH.ps1  yazın.
param(
  [string]$RemoteUrl = "https://github.com/AkinAkonur/islami_uygulama.git",
  [string]$Branch = "uretim-ai-v8",
  [switch]$MainBranchinaGonder
)
$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  throw "git bulunamadı. https://git-scm.com/download/win adresinden kurun."
}

if ($MainBranchinaGonder) { $Branch = "main" }

if (-not (Test-Path (Join-Path $Root ".git"))) {
  git init | Out-Null
}

# Kimlik yoksa geçici olarak ayarla (global ayarınızı değiştirmez).
if (-not (git config user.email)) { git config user.email "akin.akonur74@gmail.com" }
if (-not (git config user.name))  { git config user.name  "Akin Akonur" }

# Uzak adresi ayarla.
if (git remote | Select-String -Quiet '^origin$') {
  git remote set-url origin $RemoteUrl
} else {
  git remote add origin $RemoteUrl
}

# Güvenlik kontrolü: sır içeren dosyalar asla gönderilmemeli.
$yasakli = @(
  "config/firebase.production.json",
  ".firebaserc",
  "android/key.properties",
  "android/app/release-keystore.jks",
  "android/app/google-services.json",
  "ios/Runner/GoogleService-Info.plist",
  "ios/firebase_app_id_file.json",
  "lib/firebase_options.dart",
  ".env"
)
git add -A
foreach ($dosya in $yasakli) {
  git rm --cached --ignore-unmatch -q -- $dosya 2>$null | Out-Null
}
$staged = git diff --cached --name-only
foreach ($dosya in $yasakli) {
  if ($staged -contains $dosya) {
    throw "Güvenlik: $dosya gönderim listesinde. İşlem iptal edildi."
  }
}

git checkout -B $Branch | Out-Null

if (git diff --cached --quiet) {
  Write-Host "Yeni değişiklik yok; mevcut commit gönderilecek." -ForegroundColor Yellow
} else {
  git commit -m "V8: üretim AI mimarisi (Firebase Auth + App Check + callable backend + Secret Manager + kota + çevrimdışı yedek)" | Out-Null
}

Write-Host "GitHub kimlik doğrulaması istenebılir." -ForegroundColor Cyan
Write-Host "Şifre yerine Personal Access Token kullanın; token'ı buraya değil Git isteminin kendisine girin." -ForegroundColor Yellow

git push -u origin $Branch
if ($LASTEXITCODE -ne 0) {
  Write-Host "Push başarısız. Olası nedenler: kimlik doğrulama, depo yetkisi veya uzaktaki geçmişle çakışma." -ForegroundColor Red
  Write-Host "main dalda geçmiş farklıysa bu dalı gönderip GitHub'da Pull Request açmanız en güvenlisidir." -ForegroundColor Red
  throw "git push başarısız oldu."
}

Write-Host "Push tamamlandı: $Branch dalı -> $RemoteUrl" -ForegroundColor Green
Write-Host "Pull Request: https://github.com/AkinAkonur/islami_uygulama/pull/new/$Branch"
