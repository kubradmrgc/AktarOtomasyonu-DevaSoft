# -*- coding: utf-8 -*-
"""Fetch Aktar Diyarı product catalog via sitemaps (+ optional category pages)."""
from __future__ import annotations

import sys
import xml.etree.ElementTree as ET
from typing import Dict, List, Optional, Set
from urllib.parse import urljoin

from common import (
    BASE_URL,
    CATALOG_FIELDS,
    CATEGORY_URLS,
    OUT_DIR,
    absolute_url,
    fetch_response,
    get_soup,
    parse_price,
    session,
    slug_from_url,
    write_csv,
)


def collect_product_urls(s) -> List[str]:
    index_xml = fetch_response(s, f"{BASE_URL}/sitemap.xml", delay=1.0).text
    root = ET.fromstring(index_xml)
    sitemap_urls = []
    for loc in root.findall(".//{*}loc"):
        if loc.text and "sitemap_product_" in loc.text:
            sitemap_urls.append(loc.text.strip())

    urls: List[str] = []
    seen: Set[str] = set()
    for sm_url in sitemap_urls:
        print(f"  sitemap: {sm_url}")
        xml = fetch_response(s, sm_url, delay=1.5).text
        sm_root = ET.fromstring(xml)
        for loc in sm_root.findall(".//{*}loc"):
            if not loc.text:
                continue
            u = loc.text.strip().split("?")[0].rstrip("/")
            if "/urun/" not in u or u in seen:
                continue
            seen.add(u)
            urls.append(u)
    return urls


def find_product_cards(soup):
    for sel in (
        "div.product-item",
        "div.productItem",
        "div.catalogWrapper div.product",
        "li.product-item",
        "div.showcase",
        "div[class*='product-item']",
        "div[class*='productItem']",
    ):
        found = soup.select(sel)
        if found:
            return found
    return soup.select("a[href*='/urun/']")


def extract_from_card(node, kategori_site: str, kategori_kod: str) -> Optional[Dict]:
    link = node if getattr(node, "name", None) == "a" else node.select_one("a[href*='/urun/']")
    if not link or not link.get("href"):
        return None
    href = absolute_url(link["href"])
    if not href or "/urun/" not in href:
        return None
    href = href.split("?")[0].rstrip("/")

    name = ""
    if getattr(node, "name", None) != "a":
        for sel in ("a.product-title", "a.name", ".product-title", ".productName", "h3", "h2"):
            el = node.select_one(sel)
            if el and el.get_text(strip=True):
                txt = el.get_text(" ", strip=True)
                if txt.lower() not in ("add to favorites", "favorilere ekle"):
                    name = txt
                    break
    if not name:
        name = link.get_text(" ", strip=True)
    if not name or name.lower() in ("add to favorites", "favorilere ekle"):
        name = slug_from_url(href).replace("-", " ").title()

    price = None
    if getattr(node, "name", None) != "a":
        for sel in (".product-price", ".currentPrice", ".price", "span[class*='price']", "div[class*='price']"):
            price_el = node.select_one(sel)
            if price_el:
                price = parse_price(price_el.get_text(" ", strip=True))
                if price is not None:
                    break

    img_url = ""
    if getattr(node, "name", None) != "a":
        img = node.select_one("img")
        if img:
            img_url = absolute_url(img.get("data-src") or img.get("src") or img.get("data-original")) or ""

    return {
        "url": href,
        "slug": slug_from_url(href),
        "urun_adi": name.strip(),
        "kategori_site": kategori_site,
        "kategori_kod": kategori_kod,
        "fiyat": f"{price:.2f}" if price is not None else "",
        "gorsel_url": img_url,
        "selected": "0",
    }


def scrape_category(s, path: str, kategori_site: str, kategori_kod: str) -> List[Dict]:
    rows: List[Dict] = []
    seen: Set[str] = set()
    page = 1
    while page <= 40:
        url = urljoin(BASE_URL, path if page == 1 else f"{path}?page={page}")
        print(f"  [{kategori_kod}] page {page}: {url}")
        try:
            soup = get_soup(s, url, delay=2.5)
        except Exception as exc:
            print(f"    ! fail: {exc}")
            break

        cards = find_product_cards(soup)
        page_new = 0
        for card in cards:
            row = extract_from_card(card, kategori_site, kategori_kod)
            if not row or row["url"] in seen:
                continue
            seen.add(row["url"])
            rows.append(row)
            page_new += 1

        print(f"    + {page_new} products (total {len(rows)})")
        if page_new == 0:
            break

        page_nums = []
        for a in soup.select("ul.pagination a, .pagination a, .pager a"):
            t = a.get_text(strip=True)
            if t.isdigit():
                page_nums.append(int(t))
        next_link = soup.select_one("a[rel='next'], a.next, li.next a")
        if not next_link and not any(n > page for n in page_nums):
            break
        page += 1
    return rows


def guess_category(slug: str) -> tuple:
    s = slug.lower()
    rules = [
        (("biber", "kimyon", "zerdecal", "tarçin", "tarcin", "karabiber", "sumak", "nane", "kekik", "baharat", "köri", "kori", "pul"), "Baharat", "BAHARAT"),
        (("cay", "çay", "hibisk", "ihlamur", "adaçay", "adacay", "matcha", "rooibos"), "Bitki Çayları", "CAY"),
        (("yag", "yağ", "oil"), "Bitkisel Yağlar", "YAG"),
        (("tohum", "chia", "kenevir", "susam", "corek"), "Tohum", "TOHUM"),
        (("su-", "-su", "hidrosol", "toner"), "Bitkisel Sular", "SIVI"),
        (("propolis", "polen", "spirulina", "takviye", "vitamin", "kollajen", "kolajen", "macun"), "Gıda Takviyeleri", "TAKVIYE"),
        (("krem", "sabun", "sampuan", "şampuan", "maske", "kozmetik", "kına", "kina"), "Kozmetik", "KOZMETIK"),
        (("kahve", "coffee", "espresso"), "Kahve", "KAHVE"),
        (("bal", "pekmez", "lokum", "helva", "ikram"), "İkramlık", "TATLI"),
        (("yaprak", "otu", "çiçek", "cicek", "kök", "kok", "bitki"), "Bitki", "BITKI"),
    ]
    for keys, site, kod in rules:
        if any(k in s for k in keys):
            return site, kod
    return "Diğer", "DIGER"


def merge_catalog(sitemap_urls: List[str], category_rows: List[Dict]) -> List[Dict]:
    by_url: Dict[str, Dict] = {}
    for row in category_rows:
        by_url[row["url"]] = row

    for url in sitemap_urls:
        url = url.split("?")[0].rstrip("/")
        if url in by_url:
            continue
        slug = slug_from_url(url)
        site, kod = guess_category(slug)
        by_url[url] = {
            "url": url,
            "slug": slug,
            "urun_adi": slug.replace("-", " ").title(),
            "kategori_site": site,
            "kategori_kod": kod,
            "fiyat": "",
            "gorsel_url": "",
            "selected": "0",
        }
    return sorted(by_url.values(), key=lambda r: (r.get("kategori_kod") or "", r.get("urun_adi") or ""))


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    s = session()
    # Warm up homepage like a browser
    try:
        fetch_response(s, BASE_URL + "/", delay=1.0)
    except Exception as exc:
        print(f"Homepage warm-up warning: {exc}")

    print("1) Collecting product URLs from sitemaps...")
    try:
        sitemap_urls = collect_product_urls(s)
    except Exception as exc:
        print(f"Sitemap failed: {exc}")
        sitemap_urls = []
    print(f"   {len(sitemap_urls)} product URLs")

    print("2) Scraping category listing pages (best effort)...")
    category_rows: List[Dict] = []
    for path, site_name, kod in CATEGORY_URLS:
        try:
            rows = scrape_category(s, path, site_name, kod)
            category_rows.extend(rows)
        except Exception as exc:
            print(f"  Category {path} failed: {exc}")
    print(f"   {len(category_rows)} rows from categories")

    catalog = merge_catalog(sitemap_urls, category_rows)
    out_path = OUT_DIR / "catalog.csv"
    write_csv(out_path, catalog, CATALOG_FIELDS)
    print(f"3) Wrote {len(catalog)} products -> {out_path}")
    return 0 if catalog else 1


if __name__ == "__main__":
    sys.exit(main())
