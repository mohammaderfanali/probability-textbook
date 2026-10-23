# ------------------------------------------------------------
#  ساخت PDF جزوه
#
#  یک فایل:      powershell -ExecutionPolicy Bypass -File build.ps1 jalase02
#  همهٔ جلسه‌ها:  powershell -ExecutionPolicy Bypass -File build.ps1 all
#  پاک‌سازی:      powershell -ExecutionPolicy Bypass -File build.ps1 clean
#
#  فایل‌های کمکی (aux, log, ...) در پوشهٔ build/ و PDF نهایی در پوشهٔ pdf/ ذخیره می‌شود.
#  (xelatex -no-pdf و بعد xdvipdfmx: چون مرحلهٔ داخلی ساخت PDF در MiKTeX این سیستم خطا می‌دهد.)
# ------------------------------------------------------------
param([string]$name = "main")
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if ($name -eq "clean") {
    if (Test-Path build) { Remove-Item -Recurse -Force build }
    Write-Host "build/ پاک شد." -ForegroundColor Green
    exit 0
}

$targets = @($name)
if ($name -eq "all") { $targets = Get-ChildItem -Filter "jalase*.tex" | ForEach-Object { $_.BaseName } }

New-Item -ItemType Directory -Force build | Out-Null
New-Item -ItemType Directory -Force pdf   | Out-Null

foreach ($t in $targets) {
    $t = $t -replace '\.tex$', ''
    if (-not (Test-Path "$t.tex")) { Write-Host "$t.tex پیدا نشد." -ForegroundColor Red; exit 1 }
    Write-Host "== $t ==" -ForegroundColor Cyan
    for ($i = 1; $i -le 2; $i++) {
        xelatex -no-pdf -interaction=nonstopmode -halt-on-error -output-directory=build "$t.tex" | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "خطا در کامپایل $t — جزئیات در build\$t.log" -ForegroundColor Red
            Select-String -Path "build\$t.log" -Pattern "^!" -Context 0,4 | Select-Object -First 5
            exit 1
        }
    }
    xdvipdfmx -q -o "pdf\$t.pdf" "build\$t.xdv"
    Write-Host "  -> pdf\$t.pdf" -ForegroundColor Green
}
