# -*- coding: utf-8 -*-
"""
1) Fix mojibake in urun / urun_kategori via SqlClient (Unicode-safe)
2) Download product images for ADY-* and insert urun_gorsel rows
"""
from __future__ import annotations

import csv
import hashlib
import os
import sys
import time
import uuid
from pathlib import Path
from typing import Dict, List, Optional, Tuple
from urllib.parse import urlparse

import requests

OUT_DIR = Path(__file__).resolve().parent / "out"
REPO_ROOT = Path(__file__).resolve().parents[2]
BIN_DIR = REPO_ROOT / "src" / "AktarOtomasyon.Forms" / "bin" / "Debug"
IMAGES_ROOT = BIN_DIR / "App_Data" / "Images" / "Urunler"

CONN = (
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=.\\SQLEXPRESS;"
    "Database=AktarOtomasyon;"
    "Trusted_Connection=yes;"
)

USER_AGENT = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
)

TURKISH = set("ğüşıöçĞÜŞİÖÇ")
MOJI_HINT = set("ÃÂÅÆÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ") | {
    chr(i) for i in range(0x80, 0xA0)
}


def score(text: str) -> int:
    if not text:
        return -10**9
    s = sum(20 for c in text if c in TURKISH)
    for c in text:
        if 0x80 <= ord(c) <= 0x9F:
            s -= 50
        if c in "ÃÂÅ":
            s -= 15
        if c == "\ufffd":
            s -= 40
    if any(c in MOJI_HINT for c in text):
        s -= 10
    return s


def decode_latin1_bytes_as_utf8(text: str) -> Optional[str]:
    if any(ord(c) > 0xFF for c in text):
        return None
    try:
        return bytes(ord(c) for c in text).decode("utf-8")
    except UnicodeDecodeError:
        return None


def decode_cp_as_utf8(text: str, cp: str) -> Optional[str]:
    try:
        return text.encode(cp).decode("utf-8")
    except (UnicodeEncodeError, UnicodeDecodeError):
        return None


def fix_mojibake(text: Optional[str]) -> Optional[str]:
    if text is None:
        return None
    if text == "":
        return text
    if not any(c in MOJI_HINT for c in text) and any(c in TURKISH for c in text):
        return text

    best = text
    best_s = score(text)
    for cand in (
        decode_latin1_bytes_as_utf8(text),
        decode_cp_as_utf8(text, "cp1252"),
        decode_cp_as_utf8(text, "latin-1"),
    ):
        if not cand:
            continue
        sc = score(cand)
        if sc > best_s:
            best, best_s = cand, sc
    return best


def get_conn():
    try:
        import pyodbc
    except ImportError:
        import subprocess

        subprocess.check_call([sys.executable, "-m", "pip", "install", "pyodbc", "-q"])
        import pyodbc
    return pyodbc.connect(CONN)


def fix_database(conn) -> Tuple[int, int]:
    cur = conn.cursor()
    kat_fixed = 0
    cur.execute("SELECT kategori_id, kategori_adi FROM urun_kategori")
    rows = cur.fetchall()
    for kid, adi in rows:
        fixed = fix_mojibake(adi)
        if fixed and fixed != adi:
            cur.execute(
                "UPDATE urun_kategori SET kategori_adi = ? WHERE kategori_id = ?",
                fixed,
                kid,
            )
            kat_fixed += 1
            print(f"  kategori {kid}: {adi!r} -> {fixed!r}")

    urun_fixed = 0
    cur.execute("SELECT urun_id, urun_adi, aciklama FROM urun")
    for uid, adi, acik in cur.fetchall():
        new_adi = fix_mojibake(adi)
        new_acik = fix_mojibake(acik) if acik else acik
        if (new_adi and new_adi != adi) or (new_acik != acik):
            cur.execute(
                "UPDATE urun SET urun_adi = ?, aciklama = ? WHERE urun_id = ?",
                new_adi or adi,
                new_acik,
                uid,
            )
            urun_fixed += 1
    conn.commit()
    return kat_fixed, urun_fixed


def load_enriched() -> Dict[str, Dict[str, str]]:
    path = OUT_DIR / "selected_enriched.csv"
    by_slug = {}
    with path.open("r", encoding="utf-8-sig", newline="") as f:
        for row in csv.DictReader(f):
            by_slug[row.get("slug") or ""] = row
            # also map by approximate name later
    return by_slug


def ady_products(conn) -> List[Tuple[int, str, str]]:
    cur = conn.cursor()
    cur.execute(
        "SELECT urun_id, urun_kod, urun_adi FROM urun WHERE urun_kod LIKE 'ADY-%' ORDER BY urun_kod"
    )
    return [(r[0], r[1], r[2]) for r in cur.fetchall()]


def download_image(session: requests.Session, url: str, dest: Path) -> bool:
    if not url:
        return False
    try:
        time.sleep(0.8)
        r = session.get(url, timeout=60, headers={"User-Agent": USER_AGENT})
        if r.status_code != 200 or len(r.content) < 500:
            return False
        ctype = (r.headers.get("Content-Type") or "").lower()
        ext = ".jpg"
        if "png" in ctype or url.lower().endswith(".png"):
            ext = ".png"
        elif "webp" in ctype:
            ext = ".webp"
        dest = dest.with_suffix(ext)
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_bytes(r.content)
        return True
    except Exception as exc:
        print(f"    image fail: {exc}")
        return False


def ensure_gorsel(conn, urun_id: int, relative_path: str) -> None:
    cur = conn.cursor()
    cur.execute(
        "SELECT COUNT(*) FROM urun_gorsel WHERE urun_id = ? AND ana_gorsel = 1",
        urun_id,
    )
    if cur.fetchone()[0] > 0:
        return
    # clear any existing non-ana for simplicity
    cur.execute(
        """
        INSERT INTO urun_gorsel (urun_id, gorsel_path, gorsel_tip, ana_gorsel, sira)
        VALUES (?, ?, 'Urun', 1, 1)
        """,
        urun_id,
        relative_path.replace("\\", "/"),
    )


def sync_ady_names_from_csv(conn) -> int:
    """Overwrite ADY product names/descriptions from UTF-8 enriched CSV (source of truth)."""
    enriched = list(
        csv.DictReader((OUT_DIR / "selected_enriched.csv").open("r", encoding="utf-8-sig"))
    )
    products = ady_products(conn)
    cur = conn.cursor()
    n = 0
    for i, (uid, kod, _adi) in enumerate(products):
        if i >= len(enriched):
            break
        row = enriched[i]
        adi = (row.get("urun_adi") or "").strip()[:200]
        acik = (row.get("aciklama") or "").strip()[:500]
        if not adi:
            continue
        cur.execute(
            "UPDATE urun SET urun_adi = ?, aciklama = ? WHERE urun_id = ?",
            adi,
            acik or None,
            uid,
        )
        n += 1
    conn.commit()
    return n


def import_images(conn) -> int:
    enriched = list(
        csv.DictReader((OUT_DIR / "selected_enriched.csv").open("r", encoding="utf-8-sig"))
    )
    # Map by order: ADY-00001 = first enriched row (same order as generate_seed)
    products = ady_products(conn)
    if len(products) != len(enriched):
        print(f"  warn: products={len(products)} enriched={len(enriched)} — matching by index")

    session = requests.Session()
    session.headers.update({"User-Agent": USER_AGENT, "Accept-Encoding": "gzip, deflate"})
    # warm-up
    try:
        session.get("https://www.aktardiyari.com/", timeout=30)
    except Exception:
        pass

    done = 0
    n = min(len(products), len(enriched))
    for i in range(n):
        uid, kod, adi = products[i]
        row = enriched[i]
        url = (row.get("gorsel_url") or "").strip()
        if not url:
            print(f"  skip {kod}: no image url")
            continue

        folder = IMAGES_ROOT / str(uid)
        folder.mkdir(parents=True, exist_ok=True)
        fname = f"{uuid.uuid4().hex}.jpg"
        dest = folder / fname
        print(f"  [{i+1}/{n}] {kod} <- {url[:80]}...")
        ok = download_image(session, url, dest)
        if not ok:
            # dest may have different extension
            found = list(folder.glob(f"{dest.stem}.*"))
            if not found:
                continue
            dest = found[0]
        else:
            # download_image may change suffix
            found = list(folder.glob(f"{dest.stem}.*"))
            if found:
                dest = found[0]

        rel = str(Path("App_Data") / "Images" / "Urunler" / str(uid) / dest.name)
        ensure_gorsel(conn, uid, rel)
        done += 1
        if done % 10 == 0:
            conn.commit()
            print(f"  progress images {done}")

    conn.commit()
    return done


def force_fix_known_categories(conn) -> None:
    """Hard-set known category names (authoritative)."""
    mapping = {
        "BAHARAT": "Baharatlar",
        "KURUYEMIS": "Kuruyemişler",
        "BAKLIYAT": "Bakliyatlar",
        "SEKER": "Şekerlemeler",
        "KAHVE": "Kahve ve Çay",
        "DIGER": "Diğer",
        "BITKI": "Bitkisel Ürünler",
        "CAY": "Çay ve İçecekler",
        "YAG": "Doğal Yağlar",
        "TOHUM": "Tohum ve Taneler",
        "KOZMETIK": "Doğal Kozmetik",
        "TAKVIYE": "Takviye Ürünleri",
        "SIVI": "Sıvı Ürünler",
        "TATLI": "Tatlı ve İkramlık",
        "MACUN": "Macun ve Karışımlar",
        "BAL": "Bal ve Arı Ürünleri",
    }
    cur = conn.cursor()
    for kod, adi in mapping.items():
        cur.execute(
            "UPDATE urun_kategori SET kategori_adi = ? WHERE kategori_kod = ?",
            adi,
            kod,
        )
    conn.commit()
    print("  kategori adları zorla düzeltildi")


def main() -> int:
    print("Connecting...")
    conn = get_conn()
    print("1) Force-fix category names...")
    force_fix_known_categories(conn)
    print("2) Sync ADY names from UTF-8 CSV...")
    synced = sync_ady_names_from_csv(conn)
    print(f"   synced: {synced}")
    print("3) Auto-fix mojibake in remaining urun rows...")
    k, u = fix_database(conn)
    print(f"   kategori auto-fix: {k}, urun fixed: {u}")
    print("4) Import images for ADY products...")
    n = import_images(conn)
    print(f"   images linked: {n}")
    # verify
    cur = conn.cursor()
    cur.execute("SELECT kategori_kod, kategori_adi FROM urun_kategori WHERE kategori_kod='SEKER'")
    print("   SEKER =>", cur.fetchone())
    cur.execute("SELECT COUNT(*) FROM urun_gorsel")
    print("   urun_gorsel count =>", cur.fetchone()[0])
    conn.close()
    return 0


if __name__ == "__main__":
    sys.exit(main())
