param(
  [string]$ProjectId = "islami-uygulama-ai-akinakonur"
)
$ErrorActionPreference = "Stop"
$PackageName = "com.akinakonur.islamiuygulama"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root

function Require-Command([string]$Name, [string]$Help) {
  if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
    throw "$Name bulunamadı. $Help"
  }
}

Require-Command "flutter" "Flutter PATH'e eklenmeli."
Require-Command "dart" "Flutter ile gelen Dart PATH'e eklenmeli."
Require-Command "node" "Node.js 22 kurulmalı."
Require-Command "npm" "Node.js ile gelen npm kurulmalı."

if (-not (Get-Command firebase -ErrorAction SilentlyContinue)) {
  Write-Host "Firebase CLI kuruluyor..." -ForegroundColor Cyan
  npm install -g firebase-tools
}

Write-Host "Google hesabı yetkilendiriliyor..." -ForegroundColor Cyan
firebase projects:list --json | Out-Null
if ($LASTEXITCODE -ne 0) {
  firebase login
  if ($LASTEXITCODE -ne 0) { throw "Firebase girişi tamamlanamadı." }
}

$projectsRaw = firebase projects:list --json | Out-String
if ($LASTEXITCODE -ne 0) { throw "Firebase proje listesi alınamadı." }
$projectsJson = $projectsRaw | ConvertFrom-Json
$projects = @($projectsJson.result)
$exists = $projects | Where-Object {
  $_.projectId -eq $ProjectId -or $_.project_id -eq $ProjectId
}
if (-not $exists) {
  Write-Host "Firebase projesi oluşturuluyor: $ProjectId" -ForegroundColor Cyan
  firebase projects:create $ProjectId --display-name "Islami Uygulama AI"
  if ($LASTEXITCODE -ne 0) {
    $suffix = -join ((97..122) | Get-Random -Count 6 | ForEach-Object {[char]$_})
    $ProjectId = "islami-uygulama-ai-$suffix"
    Write-Host "İlk kimlik kullanılamadı; yeni kimlik deneniyor: $ProjectId" -ForegroundColor Yellow
    firebase projects:create $ProjectId --display-name "Islami Uygulama AI"
    if ($LASTEXITCODE -ne 0) { throw "Firebase projesi oluşturulamadı." }
  }
}

@{
  projects = @{ default = $ProjectId }
} | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath ".firebaserc" -Encoding UTF8
firebase use $ProjectId

Write-Host "FlutterFire yapılandırılıyor..." -ForegroundColor Cyan
dart pub global activate flutterfire_cli
$pubCacheBin = Join-Path $env:LOCALAPPDATA "Pub\Cache\bin"
if (Test-Path $pubCacheBin) { $env:PATH = "$pubCacheBin;$env:PATH" }
flutterfire configure `
  --project=$ProjectId `
  --platforms=android `
  --android-package-name=$PackageName `
  --yes

$googleFile = Join-Path $Root "android\app\google-services.json"
if (-not (Test-Path $googleFile)) {
  throw "google-services.json üretilemedi. FlutterFire çıktısını kontrol edin."
}
$google = Get-Content -Raw -LiteralPath $googleFile | ConvertFrom-Json
$client = @($google.client) | Where-Object {
  $_.client_info.android_client_info.package_name -eq $PackageName
} | Select-Object -First 1
if (-not $client) { throw "$PackageName Firebase Android istemcisi bulunamadı." }
$config = [ordered]@{
  FIREBASE_API_KEY = [string]$client.api_key[0].current_key
  FIREBASE_APP_ID = [string]$client.client_info.mobilesdk_app_id
  FIREBASE_MESSAGING_SENDER_ID = [string]$google.project_info.project_number
  FIREBASE_PROJECT_ID = [string]$google.project_info.project_id
  FIREBASE_FUNCTIONS_REGION = "europe-west1"
}
New-Item -ItemType Directory -Force -Path (Join-Path $Root "config") | Out-Null
$config | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $Root "config\firebase.production.json") -Encoding UTF8

Write-Host "Anonymous Authentication yapılandırması koddan etkinleştirilecek." -ForegroundColor Cyan

Write-Host "Firestore veritabanı kontrol ediliyor..." -ForegroundColor Cyan
$dbRaw = firebase firestore:databases:list --project $ProjectId --json | Out-String
if ($LASTEXITCODE -ne 0) { throw "Firestore veritabanları listelenemedi." }
$dbJson = $dbRaw | ConvertFrom-Json
$databases = @($dbJson.result)
$defaultDb = $databases | Where-Object {
  $_.name -like "*/databases/(default)" -or $_.databaseId -eq "(default)"
}
if (-not $defaultDb) {
  firebase firestore:databases:create "(default)" `
    --location eur3 `
    --delete-protection ENABLED `
    --project $ProjectId
  if ($LASTEXITCODE -ne 0) { throw "Firestore (default) veritabanı oluşturulamadı." }
}

Write-Host "Backend bağımlılıkları kuruluyor..." -ForegroundColor Cyan
Push-Location (Join-Path $Root "backend\functions")
npm install
npm run check
Pop-Location

Write-Host "Gemini anahtarı Secret Manager'a kaydedilecek." -ForegroundColor Yellow
Write-Host "Anahtarı yalnız Firebase CLI'nin güvenli istemine girin; kaynak dosyaya yazmayın." -ForegroundColor Yellow
firebase functions:secrets:set GEMINI_API_KEY --project $ProjectId

Write-Host "Functions ve Firestore kuralları yayınlanıyor..." -ForegroundColor Cyan
try {
  firebase deploy --only auth,functions,firestore:rules,firestore:indexes --project $ProjectId
} catch {
  Write-Host "Deploy tamamlanamadı. Cloud Functions için Blaze planı veya Firestore oluşturma onayı gerekebilir." -ForegroundColor Red
  Start-Process "https://console.firebase.google.com/project/$ProjectId/usage/details"
  Start-Process "https://console.firebase.google.com/project/$ProjectId/firestore"
  throw
}

Write-Host "Anonymous Authentication koddan etkinleştirildi." -ForegroundColor Green
Write-Host "App Check uygulama kaydı Google hesabı/Play Integrity onayı gerektirir." -ForegroundColor Yellow
Write-Host "Açılan ekranda Android uygulaması için Play Integrity kaydını tamamlayın."
Start-Process "https://console.firebase.google.com/project/$ProjectId/appcheck/apps"

Write-Host "Firebase backend deploy edildi." -ForegroundColor Green
Write-Host "Yapılandırma: config\firebase.production.json"
Write-Host "Sonraki: .\FIREBASE_DEBUG_CALISTIR.ps1"
