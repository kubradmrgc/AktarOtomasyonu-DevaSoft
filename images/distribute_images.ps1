$repoRoot = Split-Path -Parent $PSScriptRoot
$productsFile = Join-Path $PSScriptRoot "products.csv"
$artifactsDir = Join-Path $PSScriptRoot "artifacts"
$targetBaseDir = Join-Path $repoRoot "src\AktarOtomasyon.Forms\bin\Debug\App_Data\Images\Urunler"
$outputSqlFile = Join-Path $PSScriptRoot "seed_images.sql"

# Source Images Map
$imgMap = @{
    "baharat"   = "baharat_genel_1767723751844.png"
    "cay"       = "bitki_cayi_genel_1767723772529.png"
    "kuruyemis" = "kuruyemis_genel_1767723791896.png"
    "yag"       = "yag_genel_1767723831506.png"
    "macun"     = "macun_bal_genel_1767723853132.png"
    "bakliyat"  = "bakliyat_genel_v2_1767723908307.png"
    "kozmetik"  = "kozmetik_sabun_genel_v2_1767723929943.png"
}

# Ensure Output Dir Exists
if (!(Test-Path $targetBaseDir)) {
    New-Item -ItemType Directory -Force -Path $targetBaseDir | Out-Null
}

$sqlContent = @"
-- Bulk Image Insert
USE AktarOtomasyon;
GO
TRUNCATE TABLE urun_gorsel;
GO
DECLARE @gid int;
"@

$lines = Get-Content $productsFile
foreach ($line in $lines) {
    if ([string]::IsNullOrWhiteSpace($line)) { continue }
    
    $parts = $line -split '\|'
    $id = $parts[0].Trim()
    $name = $parts[1].Trim().ToLower()
    
    # Determine Category
    $category = "baharat" # Default
    
    if ($name -match "cay|─▒hlamur|papatya|melisa|ku┼şburnu|rezene|civanper├ğemi|ebeg├╝meci|hatmi|─▒s─▒rgan|kiraz sap─▒|alt─▒n ├ğilek|mate|rooibos|yaprak|├ği├ğek") { $category = "cay" }
    elseif ($name -match "ceviz|f─▒nd─▒k|f─▒st─▒k|badem|kaju|leblebi|kabak ├ğekirde─şi|ay ├ğekirde─şi|├╝z├╝m|kay─▒s─▒|incir|erik|dut|hurma|goji|berry") { $category = "kuruyemis" }
    elseif ($name -match "ya─ş|argan|jojoba") { $category = "yag" }
    elseif ($name -match "macun|bal|polen|propolis|ar─▒ s├╝t├╝|pekmez") { $category = "macun" }
    elseif ($name -match "mercimek|fasulye|nohut|bulgur|pirin├ğ|yulaf|kinoa|chia|keten|ha┼şha┼ş|quinoa|tohum") { $category = "bakliyat" }
    elseif ($name -match "sabun|suyu|maske|tablet|omega|krem") { $category = "kozmetik" }
    elseif ($name -match "biber|kimyon|tar├ğ─▒n|baharat|tuz|zerde├ğal|sumak|k├Âri|yenibahar|karanfil|kakule|safran|hardal|nane|kekik|biberiye|lavanta|fesle─şen") { $category = "baharat" }
    
    # Copy Logic
    $sourceFile = Join-Path $artifactsDir $imgMap[$category]
    $prodDir = Join-Path $targetBaseDir $id
    
    if (!(Test-Path $prodDir)) {
        New-Item -ItemType Directory -Force -Path $prodDir | Out-Null
    }
    
    $newFileName = [guid]::NewGuid().ToString() + ".png"
    $destFile = Join-Path $prodDir $newFileName
    
    if (Test-Path $sourceFile) {
        Copy-Item $sourceFile $destFile
        
        # Append to SQL using stored procedure
        # sp_urun_gorsel_ekle parameters: @urun_id, @gorsel_path (relative), @gorsel_tip, @ana_gorsel, @gorsel_id OUTPUT
        # Relative path: App_Data/Images/Urunler/{id}/{guid}.png
        $relPath = "App_Data/Images/Urunler/$id/$newFileName"
        
        $sqlContent += "`nEXEC sp_urun_gorsel_ekle @urun_id = $id, @gorsel_path = '$relPath', @gorsel_tip = 'Genel', @ana_gorsel = 1, @gorsel_id = @gid OUTPUT;"
        Write-Host "Processed Product ${id}: ${name} -> $category"
    }
    else {
        Write-Warning "Source file not found: $sourceFile"
    }
}

$sqlContent | Set-Content $outputSqlFile -Encoding UTF8
Write-Host "SQL generated at $outputSqlFile"
