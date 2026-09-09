$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root
$Config = Join-Path $Root "config\firebase.production.json"
if (-not (Test-Path $Config)) { throw "Önce FIREBASE_KURULUM.ps1 çalıştırın." }
if (-not (Test-Path "android\key.properties")) { throw "Önce RELEASE_IMZA_OLUSTUR.ps1 çalıştırın." }
flutter clean
flutter pub get
flutter test
if ($LASTEXITCODE -ne 0) { throw "Testler geçmedi; release oluşturulmadı." }
flutter build appbundle --release --dart-define-from-file="$Config"
if ($LASTEXITCODE -ne 0) { throw "AAB oluşturulamadı." }
Write-Host "AAB hazır: build\app\outputs\bundle\release\app-release.aab" -ForegroundColor Green
