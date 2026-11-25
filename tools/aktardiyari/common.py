# -*- coding: utf-8 -*-
"""Shared helpers for Aktar Diyarı scrape/import tools."""
from __future__ import annotations

import csv
import re
import time
from pathlib import Path
from typing import Dict, Iterable, List, Optional
from urllib.parse import urljoin, urlparse

import requests
from bs4 import BeautifulSoup

BASE_URL = "https://www.aktardiyari.com"
OUT_DIR = Path(__file__).resolve().parent / "out"
USER_AGENT = (
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/120.0.0.0 Safari/537.36"
)
REQUEST_DELAY_SEC = 2.0

CATEGORY_URLS = [
    ("/kategori/baharatlar", "Baharat", "BAHARAT"),
    ("/kategori/bitkiler", "Bitki", "BITKI"),
    ("/kategori/caylar", "Bitki Çayları", "CAY"),
    ("/kategori/tohum", "Tohum", "TOHUM"),
    ("/kategori/bitkisel-yaglar", "Bitkisel Yağlar", "YAG"),
    ("/kategori/bitkisel-sular", "Bitkisel Sular", "SIVI"),
    ("/kategori/gida-takviyeleri", "Gıda Takviyeleri", "TAKVIYE"),
    ("/kategori/kozmetik-ve-kisisel-bakim", "Kozmetik", "KOZMETIK"),
    ("/kategori/kimyasal-urunler", "Kimyasal Ürünler", "DIGER"),
    ("/kategori/ikramlik", "İkramlık", "TATLI"),
    ("/kategori/kahveler-1", "Kahve", "KAHVE"),
    ("/kategori/muhtelif-urunler-1", "Diğer Ürünler", "DIGER"),
    ("/kategori/gida-takviyeleri-1", "Gıda", "TAKVIYE"),
]

CATALOG_FIELDS = [
    "url",
    "slug",
    "urun_adi",
    "kategori_site",
    "kategori_kod",
    "fiyat",
    "gorsel_url",
    "selected",
]

ENRICHED_FIELDS = CATALOG_FIELDS + [
    "barkod",
    "stok_kodu",
    "aciklama",
    "birim_kod",
    "fiyat_1000gr",
    "varyantlar",
]


def session() -> requests.Session:
    s = requests.Session()
    s.headers.update(
        {
            "User-Agent": USER_AGENT,
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
            "Accept-Language": "tr-TR,tr;q=0.9,en-US;q=0.8,en;q=0.7",
            "Accept-Encoding": "gzip, deflate",
            "Connection": "keep-alive",
            "Upgrade-Insecure-Requests": "1",
            "Sec-Fetch-Dest": "document",
            "Sec-Fetch-Mode": "navigate",
            "Sec-Fetch-Site": "none",
            "Sec-Fetch-User": "?1",
            "Cache-Control": "max-age=0",
        }
    )
    return s


def fetch_response(
    s: requests.Session,
    url: str,
    delay: float = REQUEST_DELAY_SEC,
    retries: int = 5,
) -> requests.Response:
    last_exc: Optional[Exception] = None
    for attempt in range(1, retries + 1):
        time.sleep(delay if attempt == 1 else min(30, delay * (2 ** (attempt - 1))))
        try:
            resp = s.get(url, timeout=60)
            if resp.status_code in (429, 500, 502, 503, 520, 521, 522, 524):
                last_exc = requests.HTTPError(f"{resp.status_code} for {url}", response=resp)
                print(f"    retry {attempt}/{retries}: HTTP {resp.status_code}")
                continue
            resp.raise_for_status()
            resp.encoding = resp.apparent_encoding or "utf-8"
            return resp
        except requests.RequestException as exc:
            last_exc = exc
            print(f"    retry {attempt}/{retries}: {exc}")
    raise last_exc or RuntimeError(f"Failed to fetch {url}")


def get_soup(s: requests.Session, url: str, delay: float = REQUEST_DELAY_SEC) -> BeautifulSoup:
    resp = fetch_response(s, url, delay=delay)
    return BeautifulSoup(resp.text, "lxml")


def slug_from_url(url: str) -> str:
    path = urlparse(url).path.rstrip("/")
    return path.split("/")[-1]


def parse_price(text: str) -> Optional[float]:
    if not text:
        return None
    cleaned = (
        text.replace("₺", "")
        .replace("TL", "")
        .replace("tl", "")
        .strip()
    )
    # TR format: 1.234,56 or 520,90
    cleaned = cleaned.replace(".", "").replace(",", ".")
    cleaned = re.sub(r"[^0-9.]", "", cleaned)
    if not cleaned:
        return None
    try:
        return float(cleaned)
    except ValueError:
        return None


def sql_escape(value: Optional[str]) -> str:
    if value is None:
        return ""
    return value.replace("'", "''")


def write_csv(path: Path, rows: Iterable[Dict], fieldnames: List[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction="ignore")
        writer.writeheader()
        for row in rows:
            writer.writerow({k: row.get(k, "") for k in fieldnames})


def read_csv(path: Path) -> List[Dict[str, str]]:
    with path.open("r", encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


def absolute_url(href: Optional[str]) -> Optional[str]:
    if not href:
        return None
    return urljoin(BASE_URL, href)
