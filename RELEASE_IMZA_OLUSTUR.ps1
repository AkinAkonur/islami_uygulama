$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root
if (-not (Get-Command keytool -ErrorAction SilentlyContinue)) {
  throw "keytool bulunamadı. JDK 17 kurun ve PATH'e ekleyin."
}
$Store = Join-Path $Root "android\app\release-keystore.jks"
$Properties = Join-Path $Root "android\key.properties"
if ((Test-Path $Store) -or (Test-Path $Properties)) {
  throw "Release anahtarı zaten var. Üzerine yazılmadı. Bu dosyaları güvenli biçimde yedekleyin."
}
$bytes = New-Object byte[] 24
[Security.Cryptography.RandomNumberGenerator]::Fill($bytes)
$password = [Convert]::ToBase64String($bytes).Replace("/", "A").Replace("+", "B").TrimEnd("=")
& keytool -genkeypair -v -keystore $Store -storepass $password -keypass $password `
  -alias release -keyalg RSA -keysize 2048 -validity 10000 `
  -dname "CN=Islami Uygulama, OU=Mobile, O=Akin Akonur, L=Istanbul, C=TR"
if ($LASTEXITCODE -ne 0) { throw "Keystore oluşturulamadı." }
@"
storePassword=$password
keyPassword=$password
keyAlias=release
storeFile=release-keystore.jks
"@ | Set-Content -LiteralPath $Properties -Encoding ASCII
Write-Host "Release imzası oluşturuldu. Aşağıdaki iki dosyayı çevrimdışı yedekleyin:" -ForegroundColor Green
Write-Host $Store
Write-Host $Properties
Write-Host "SHA-256 sertifika parmak izi:"
& keytool -list -v -keystore $Store -storepass $password -alias release | Select-String "SHA256:"
