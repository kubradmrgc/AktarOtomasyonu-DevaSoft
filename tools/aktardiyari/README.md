# Aktar Diyarı scrape & import

Yerel sunum/demo için [aktardiyari.com](https://www.aktardiyari.com/) katalog çekimi ve SQL seed üretimi.

## Kurulum

```powershell
py -3 -m pip install -r requirements.txt
```

## Akış

1. `py -3 fetch_catalog.py` — sitemap (+ isteğe bağlı kategori) → `out/catalog.csv`
2. Excel’de `selected=1` işaretle **veya** `py -3 auto_select.py` (~100 ürün)
3. `py -3 enrich_selected.py` — seçilen detay sayfaları → `out/selected_enriched.csv`
4. `py -3 generate_seed.py` — `db/seed/aktardiyari_import/*.sql`
5. SQL uygulaması:

```powershell
$sqlcmd = "C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\SQLCMD.EXE"
$dir = "..\..\db\seed\aktardiyari_import"
# -I : QUOTED_IDENTIFIER (filtered barkod index için gerekli)
foreach ($f in "01_categories.sql","02_products.sql","03_stock_settings.sql","04_stock_movements.sql") {
  & $sqlcmd -S ".\SQLEXPRESS" -E -d AktarOtomasyon -I -b -i "$dir\$f"
}
```

Ürün kodları: `ADY-00001` … Stok: `stok_hareket.referans_tip = 'ADY_IMPORT'`.
