# -*- coding: utf-8 -*-
"""Generate SQL seed scripts from enriched selected products."""
from __future__ import annotations

import random
import sys
from pathlib import Path
from typing import Dict, List, Tuple

from common import OUT_DIR, read_csv, sql_escape

SEED_DIR = Path(__file__).resolve().parents[2] / "db" / "seed" / "aktardiyari_import"

CATEGORY_DEFS = [
    ("BAHARAT", "Baharatlar"),
    ("BITKI", "Bitkisel Ürünler"),
    ("CAY", "Çay ve İçecekler"),
    ("YAG", "Doğal Yağlar"),
    ("TOHUM", "Tohum ve Taneler"),
    ("KOZMETIK", "Doğal Kozmetik"),
    ("TAKVIYE", "Takviye Ürünleri"),
    ("SIVI", "Sıvı Ürünler"),
    ("KAHVE", "Kahve"),
    ("TATLI", "Tatlı ve İkramlık"),
    ("DIGER", "Diğer"),
    ("MACUN", "Macun ve Karışımlar"),
    ("BAL", "Bal ve Arı Ürünleri"),
]

# kategori_kod -> (kritik, min, max) thresholds by typical unit
THRESHOLDS = {
    "BAHARAT": (5, 10, 80),
    "BITKI": (5, 10, 70),
    "CAY": (4, 8, 60),
    "TOHUM": (5, 12, 90),
    "YAG": (3, 6, 40),
    "SIVI": (3, 6, 40),
    "TAKVIYE": (3, 8, 40),
    "KOZMETIK": (3, 6, 35),
    "KAHVE": (4, 8, 50),
    "TATLI": (4, 8, 45),
    "DIGER": (3, 6, 40),
    "MACUN": (3, 6, 35),
    "BAL": (3, 6, 40),
}


def stock_segment(rng: random.Random) -> str:
    r = rng.random()
    if r < 0.25:
        return "kritik"
    if r < 0.45:
        return "dusuk"
    if r < 0.90:
        return "normal"
    return "yuksek"


def balance_for(segment: str, kritik: int, mn: int, mx: int, rng: random.Random) -> float:
    if segment == "kritik":
        return float(rng.randint(max(1, kritik - 3), max(1, kritik - 1)))
    if segment == "dusuk":
        return float(rng.randint(mn, mn + 3))
    if segment == "yuksek":
        return float(rng.randint(max(mn + 1, mx - 10), mx))
    return float(rng.randint(mn + 4, max(mn + 5, (mn + mx) // 2)))


def write_categories(path: Path) -> None:
    lines = [
        "-- Aktar Diyarı import - categories",
        "SET QUOTED_IDENTIFIER ON;",
        "SET ANSI_NULLS ON;",
        "GO",
        "USE [AktarOtomasyon]",
        "GO",
        "",
    ]
    for kod, adi in CATEGORY_DEFS:
        lines += [
            f"IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = '{kod}')",
            "BEGIN",
            f"    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)",
            f"    VALUES ('{kod}', N'{sql_escape(adi)}', 1);",
            f"    PRINT '  + {kod} eklendi';",
            "END",
            "GO",
            "",
        ]
    path.write_text("\n".join(lines), encoding="utf-8")


def write_products(path: Path, rows: List[Dict[str, str]]) -> List[Tuple[str, Dict]]:
    """Returns list of (urun_kod, row)."""
    lines = [
        "-- Aktar Diyarı import - products",
        "SET QUOTED_IDENTIFIER ON;",
        "SET ANSI_NULLS ON;",
        "GO",
        "USE [AktarOtomasyon]",
        "GO",
        "",
        "PRINT 'Aktar Diyarı ürünleri ekleniyor...';",
        "GO",
        "",
    ]
    mapping = []
    for i, row in enumerate(rows, 1):
        kod = f"ADY-{i:05d}"
        mapping.append((kod, row))
        kat = row.get("kategori_kod") or "DIGER"
        birim = (row.get("birim_kod") or "KG").upper()
        if birim not in ("KG", "GR", "ADET", "ML", "LT", "PKT", "KTU"):
            birim = "KG"
        try:
            satis = float(row.get("fiyat") or 0)
        except ValueError:
            satis = 0.0
        if satis <= 0:
            satis = 50.0
        alis = round(satis * 0.65, 2)
        adi = sql_escape((row.get("urun_adi") or kod)[:200])
        aciklama = sql_escape((row.get("aciklama") or "")[:500])
        barkod = (row.get("barkod") or "").strip()
        barkod_sql = f"'{sql_escape(barkod)}'" if barkod else "NULL"

        lines += [
            f"-- {kod}: {adi}",
            f"IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = '{kod}')",
            "BEGIN",
            "    DECLARE @kat INT, @birim INT;",
            f"    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = '{kat}';",
            f"    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = '{birim}';",
            "    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)",
            f"    VALUES ('{kod}', N'{adi}', @kat, @birim, {alis:.2f}, {satis:.2f}, {barkod_sql}, N'{aciklama}', 1);",
            "END",
            "GO",
            "",
        ]
    lines += ["PRINT 'Ürün ekleme tamamlandı.';", "GO", ""]
    path.write_text("\n".join(lines), encoding="utf-8")
    return mapping


def write_stock_settings(path: Path, mapping: List[Tuple[str, Dict]]) -> Dict[str, Tuple[int, int, int]]:
    lines = [
        "-- Aktar Diyarı import - stock settings",
        "USE [AktarOtomasyon]",
        "GO",
        "",
    ]
    thresholds: Dict[str, Tuple[int, int, int]] = {}
    for kod, row in mapping:
        kat = row.get("kategori_kod") or "DIGER"
        kritik, mn, mx = THRESHOLDS.get(kat, (3, 6, 40))
        thresholds[kod] = (kritik, mn, mx)
        lines += [
            "DECLARE @uid INT;",
            f"SELECT @uid = urun_id FROM urun WHERE urun_kod = '{kod}';",
            "IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)",
            "BEGIN",
            "    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)",
            f"    VALUES (@uid, {mn}, {mx}, {kritik}, {max(5, mn)});",
            "END",
            "GO",
            "",
        ]
    path.write_text("\n".join(lines), encoding="utf-8")
    return thresholds


def write_stock_movements(
    path: Path,
    mapping: List[Tuple[str, Dict]],
    thresholds: Dict[str, Tuple[int, int, int]],
) -> None:
    rng = random.Random(20261125)
    lines = [
        "-- Aktar Diyarı import - stock movements (presentation scenario)",
        "USE [AktarOtomasyon]",
        "GO",
        "",
        "DECLARE @AdminKullaniciId INT;",
        "SELECT TOP 1 @AdminKullaniciId = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';",
        "IF @AdminKullaniciId IS NULL SET @AdminKullaniciId = 1;",
        "",
    ]
    # Use a batch without GO between declares - rewrite per product with GO
    lines = [
        "-- Aktar Diyarı import - stock movements (presentation scenario)",
        "USE [AktarOtomasyon]",
        "GO",
        "",
    ]
    for kod, row in mapping:
        kritik, mn, mx = thresholds[kod]
        segment = stock_segment(rng)
        qty = balance_for(segment, kritik, mn, mx, rng)
        # Prefer whole numbers for ADET, one decimal for KG
        birim = (row.get("birim_kod") or "KG").upper()
        if birim in ("ADET", "PKT", "KTU"):
            qty = float(int(qty))
        else:
            qty = round(qty, 1)

        lines += [
            "DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);",
            "SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';",
            "IF @admin IS NULL SET @admin = 1;",
            f"SELECT @uid = urun_id FROM urun WHERE urun_kod = '{kod}';",
            f"SET @miktar = {qty};",
            "IF @uid IS NOT NULL",
            "AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')",
            "BEGIN",
            "    SET @onceki = 0;",
            "    INSERT INTO stok_hareket",
            "        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)",
            "    VALUES",
            f"        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu ({segment})', @admin, GETDATE());",
            "END",
            "GO",
            "",
        ]
    lines += ["PRINT 'Stok hareketleri eklendi.';", "GO", ""]
    path.write_text("\n".join(lines), encoding="utf-8")


def write_execute_all(path: Path) -> None:
    path.write_text(
        "\n".join(
            [
                "-- Run all Aktar Diyarı import seeds",
                "USE [AktarOtomasyon]",
                "GO",
                ":r 01_categories.sql",
                ":r 02_products.sql",
                ":r 03_stock_settings.sql",
                ":r 04_stock_movements.sql",
                "PRINT 'Aktar Diyarı import tamamlandı.';",
                "GO",
                "",
            ]
        ),
        encoding="utf-8",
    )


def main() -> int:
    enriched_path = OUT_DIR / "selected_enriched.csv"
    if not enriched_path.exists():
        print(f"Missing {enriched_path}")
        return 1
    rows = read_csv(enriched_path)
    if not rows:
        print("No enriched rows")
        return 1

    SEED_DIR.mkdir(parents=True, exist_ok=True)
    write_categories(SEED_DIR / "01_categories.sql")
    mapping = write_products(SEED_DIR / "02_products.sql", rows)
    thresholds = write_stock_settings(SEED_DIR / "03_stock_settings.sql", mapping)
    write_stock_movements(SEED_DIR / "04_stock_movements.sql", mapping, thresholds)
    write_execute_all(SEED_DIR / "EXECUTE_ALL.sql")

    print(f"Generated {len(mapping)} products into {SEED_DIR}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
