$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)
New-Item -ItemType Directory -Force -Path "verification_logs" | Out-Null
function Invoke-FlutterStep([string]$Name, [string[]]$Arguments) {
    & flutter @Arguments 2>&1 | Tee-Object -FilePath "verification_logs/$Name.log"
    if ($LASTEXITCODE -ne 0) { throw "$Name failed. See verification_logs/$Name.log" }
}
Invoke-FlutterStep "clean" @("clean")
Invoke-FlutterStep "dependencies" @("pub", "get")
Invoke-FlutterStep "analyze" @("analyze")
Invoke-FlutterStep "tests" @("test")
Invoke-FlutterStep "debug_build" @("build", "apk", "--debug")
Write-Host "Analysis, tests and debug APK build completed. Device tests are still required."
