$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root
$Config = Join-Path $Root "config\firebase.production.json"
if (-not (Test-Path $Config)) {
  throw "Firebase yapılandırması yok. Önce FIREBASE_KURULUM.ps1 çalıştırın."
}
flutter clean
flutter pub get
flutter run --dart-define-from-file="$Config"
