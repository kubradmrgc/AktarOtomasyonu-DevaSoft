# -*- coding: utf-8 -*-
"""Enrich selected catalog rows with product detail page fields."""
from __future__ import annotations

import json
import re
import sys
from typing import Dict, List, Optional, Tuple

from common import (
    ENRICHED_FIELDS,
    OUT_DIR,
    absolute_url,
    get_soup,
    parse_price,
    read_csv,
    session,
    write_csv,
)


def extract_label_value(soup, labels: List[str]) -> Optional[str]:
    text = soup.get_text("\n", strip=True)
    for label in labels:
        # Label on its own line, value on next
        m = re.search(
            rf"{re.escape(label)}\s*\n\s*([^\n]+)",
            text,
            flags=re.IGNORECASE,
        )
        if m:
            val = m.group(1).strip()
            if val and val.lower() not in ("stokta var", "stokta yok", "tükendi"):
                return val
    # Table / dl style
    for label in labels:
        for el in soup.find_all(string=re.compile(rf"^\s*{re.escape(label)}\s*$", re.I)):
            parent = el.parent
            if not parent:
                continue
            nxt = parent.find_next(string=True)
            # sibling value
            sib = parent.find_next_sibling()
            if sib:
                v = sib.get_text(" ", strip=True)
                if v:
                    return v
            # next td
            td = parent.find_next("td")
            if td:
                v = td.get_text(" ", strip=True)
                if v and label.lower() not in v.lower():
                    return v
    return None


def parse_variants(soup) -> List[Tuple[str, float]]:
    variants = []
    for lab in soup.select("label, .variant-list label, .product-variants label, li"):
        t = lab.get_text(" ", strip=True)
        m = re.search(
            r"(\d+)\s*(GR|G|KG|ML|LT|ADET)\s*[-–]?\s*\(?\s*([\d.,]+)\s*TL?",
            t,
            flags=re.IGNORECASE,
        )
        if not m:
            continue
        amount, unit, price_s = m.group(1), m.group(2).upper(), m.group(3)
        price = parse_price(price_s)
        if price is None:
            continue
        if unit == "G":
            unit = "GR"
        variants.append((f"{amount} {unit}", price))
    # de-dupe preserving order
    seen = set()
    out = []
    for v in variants:
        if v[0] in seen:
            continue
        seen.add(v[0])
        out.append(v)
    return out


def choose_unit_and_price(variants: List[Tuple[str, float]], list_price: Optional[float]):
    """Prefer 1000 GR / 1 KG as canonical; else largest GR; else list price + GR."""
    if not variants:
        return "KG", list_price, list_price

    # Look for 1000 GR
    for label, price in variants:
        if re.match(r"^1000\s*GR$", label, re.I):
            return "KG", price, price
    for label, price in variants:
        if re.match(r"^1\s*KG$", label, re.I):
            return "KG", price, price

    # largest GR
    gr_vars = []
    for label, price in variants:
        m = re.match(r"^(\d+)\s*GR$", label, re.I)
        if m:
            gr_vars.append((int(m.group(1)), price))
    if gr_vars:
        gr_vars.sort(key=lambda x: x[0], reverse=True)
        grams, price = gr_vars[0]
        if grams >= 1000:
            return "KG", price, price
        return "GR", price, price

    # ML / LT / ADET
    for label, price in variants:
        if "LT" in label.upper():
            return "LT", price, price
    for label, price in variants:
        if "ML" in label.upper():
            return "ML", price, price
    for label, price in variants:
        if "ADET" in label.upper():
            return "ADET", price, price

    return "ADET", variants[0][1], variants[0][1]


def extract_description(soup) -> str:
    for sel in (
        "#productDetailTab",
        ".product-detail-tab",
        ".product-description",
        "#product-description",
        ".tab-content",
        "div[itemprop='description']",
    ):
        el = soup.select_one(sel)
        if el:
            text = el.get_text(" ", strip=True)
            if len(text) > 40:
                return text[:500]
    # fallback: first long paragraph near product
    for p in soup.select("p"):
        t = p.get_text(" ", strip=True)
        if len(t) > 80 and "ücretsiz" not in t.lower():
            return t[:500]
    return ""


BREADCRUMB_MAP = {
    "baharat": "BAHARAT",
    "bitki": "BITKI",
    "bitkiler": "BITKI",
    "bitki çayları": "CAY",
    "çaylar": "CAY",
    "caylar": "CAY",
    "tohum": "TOHUM",
    "bitkisel yağlar": "YAG",
    "bitkisel yaglar": "YAG",
    "bitkisel sular": "SIVI",
    "gıda takviyeleri": "TAKVIYE",
    "gida takviyeleri": "TAKVIYE",
    "kozmetik": "KOZMETIK",
    "kozmetik ve kişisel bakım": "KOZMETIK",
    "kahve": "KAHVE",
    "kahveler": "KAHVE",
    "ikramlık": "TATLI",
    "ikramlik": "TATLI",
    "gıda": "TAKVIYE",
    "kimyasal ürünler": "DIGER",
    "diğer ürünler": "DIGER",
}


def enrich_row(s, row: Dict[str, str]) -> Dict[str, str]:
    url = row["url"]
    print(f"  enrich: {url}")
    soup = get_soup(s, url, delay=2.2)

    h1 = soup.select_one("h1")
    if h1 and h1.get_text(strip=True):
        row["urun_adi"] = h1.get_text(" ", strip=True)

    # breadcrumb category
    crumbs = [a.get_text(strip=True) for a in soup.select(".breadcrumb a, nav.breadcrumb a, ol.breadcrumb a")]
    if len(crumbs) >= 2:
        cat_name = crumbs[-2] if crumbs[-1].lower() == row["urun_adi"].lower() else crumbs[1] if len(crumbs) > 1 else crumbs[-1]
        row["kategori_site"] = cat_name
        mapped = BREADCRUMB_MAP.get(cat_name.lower().strip())
        if mapped:
            row["kategori_kod"] = mapped


    barkod = extract_label_value(soup, ["Barkod Kodu", "Barkod", "Barcode"])
    stok = extract_label_value(soup, ["Stok Kodu", "Stok Kodu:", "SKU"])
    if barkod:
        # Filter non-barcode junk
        barkod = re.sub(r"\D", "", barkod) or barkod
        row["barkod"] = barkod
    else:
        row["barkod"] = row.get("barkod") or ""
    row["stok_kodu"] = stok or row.get("stok_kodu") or ""

    variants = parse_variants(soup)
    list_price = parse_price(row.get("fiyat") or "")
    # Try page price
    price_el = soup.select_one(".product-price, .currentPrice, span[itemprop='price'], .price")
    if price_el:
        lp = parse_price(price_el.get_text(" ", strip=True))
        if lp:
            list_price = lp

    birim, fiyat, fiyat_1000 = choose_unit_and_price(variants, list_price)
    row["birim_kod"] = birim
    if fiyat is not None:
        row["fiyat"] = f"{fiyat:.2f}"
    row["fiyat_1000gr"] = f"{fiyat_1000:.2f}" if fiyat_1000 is not None else ""
    row["varyantlar"] = json.dumps(variants, ensure_ascii=False) if variants else ""

    img = soup.select_one(
        "img#productImage, .product-image img, .productImage img, "
        "div.product-images img, meta[property='og:image']"
    )
    if img:
        src = img.get("content") or img.get("data-src") or img.get("src")
        abs_u = absolute_url(src)
        if abs_u:
            row["gorsel_url"] = abs_u

    desc = extract_description(soup)
    if desc:
        # Shorten for DB / copyright-friendly summary
        row["aciklama"] = desc[:280]
    else:
        row["aciklama"] = row.get("aciklama") or f"{row['urun_adi']} - demo import"

    row["selected"] = "1"
    return row


def main() -> int:
    catalog_path = OUT_DIR / "catalog.csv"
    rows = read_csv(catalog_path)
    selected = [r for r in rows if (r.get("selected") or "").strip() == "1"]
    if not selected:
        print("No selected=1 rows in catalog.csv")
        return 1

    print(f"Enriching {len(selected)} selected products...")
    s = session()
    enriched = []
    for i, row in enumerate(selected, 1):
        try:
            enriched.append(enrich_row(s, dict(row)))
        except Exception as exc:
            print(f"  ! failed {row.get('url')}: {exc}")
            row = dict(row)
            row.setdefault("barkod", "")
            row.setdefault("stok_kodu", "")
            row.setdefault("aciklama", row.get("urun_adi", ""))
            row.setdefault("birim_kod", "KG")
            row.setdefault("fiyat_1000gr", row.get("fiyat", ""))
            row.setdefault("varyantlar", "")
            enriched.append(row)
        if i % 10 == 0:
            print(f"  progress {i}/{len(selected)}")

    out_path = OUT_DIR / "selected_enriched.csv"
    write_csv(out_path, enriched, ENRICHED_FIELDS)
    print(f"Wrote {len(enriched)} rows -> {out_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
