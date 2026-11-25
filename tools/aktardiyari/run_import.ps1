# Apply Aktar Diyari seed scripts to local SQLEXPRESS
$ErrorActionPreference = "Stop"
$sqlcmd = "C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\SQLCMD.EXE"
$dir = Join-Path $PSScriptRoot "..\..\db\seed\aktardiyari_import" | Resolve-Path

foreach ($f in @(
    "01_categories.sql",
    "02_products.sql",
    "03_stock_settings.sql",
    "04_stock_movements.sql"
)) {
    Write-Host "=== $f ===" -ForegroundColor Cyan
    & $sqlcmd -S ".\SQLEXPRESS" -E -d AktarOtomasyon -I -b -i (Join-Path $dir $f)
    if ($LASTEXITCODE -ne 0) { throw "Failed: $f" }
}

& $sqlcmd -S ".\SQLEXPRESS" -E -d AktarOtomasyon -I -Q "SELECT COUNT(*) AS ady FROM urun WHERE urun_kod LIKE 'ADY-%';"
Write-Host "Import complete." -ForegroundColor Green
