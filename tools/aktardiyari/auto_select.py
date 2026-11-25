# -*- coding: utf-8 -*-
"""Mark ~100 products across categories as selected=1 for demo import."""
from __future__ import annotations

import random
import sys
from collections import defaultdict
from typing import Dict, List

from common import CATALOG_FIELDS, OUT_DIR, read_csv, write_csv

# Prefer well-known / presentation-friendly names when present
PREFERRED_SLUGS = {
    "hibiskus",
    "chia-tohumu",
    "spirulina",
    "ari-poleni",
    "isvec-surubu",
    "kristal-mentol",
    "bira-mayasi",
    "zencefil",
    "zerdecal",
    "tarçın",
    "tarcin",
    "karabiber",
    "kimyon",
    "nane",
    "adaçayi",
    "adacayi",
    "kekik",
    "lavanta",
    "ihlamur",
    "yesil-cay",
    "cay",
    "susam",
    "corek-otu",
    "sumak",
    "pul-biber",
    "kirmizi-biber",
    "vanilya",
    "safran",
    "goji",
    "matcha",
    "propolis",
    "ari-sutu",
    "macun",
    "yag",
    "hindistan",
    "badem",
    "ceviz",
}


def score_row(row: Dict[str, str]) -> int:
    slug = (row.get("slug") or "").lower()
    name = (row.get("urun_adi") or "").lower()
    score = 0
    if row.get("fiyat"):
        score += 5
    if row.get("gorsel_url"):
        score += 3
    if row.get("kategori_site"):
        score += 2
    for p in PREFERRED_SLUGS:
        if p in slug or p in name:
            score += 20
            break
    # Prefer shorter, cleaner names
    if 3 <= len(name.split()) <= 5:
        score += 2
    return score


def main() -> int:
    catalog_path = OUT_DIR / "catalog.csv"
    rows = read_csv(catalog_path)
    if not rows:
        print("catalog.csv empty")
        return 1

    by_cat: Dict[str, List[Dict[str, str]]] = defaultdict(list)
    for r in rows:
        r["selected"] = "0"
        kod = r.get("kategori_kod") or "DIGER"
        by_cat[kod].append(r)

    rng = random.Random(42)
    target_per_cat = {
        "BAHARAT": 15,
        "BITKI": 15,
        "CAY": 12,
        "TOHUM": 8,
        "YAG": 8,
        "SIVI": 6,
        "TAKVIYE": 10,
        "KOZMETIK": 8,
        "KAHVE": 6,
        "TATLI": 6,
        "DIGER": 6,
    }

    selected_count = 0
    for kod, target in target_per_cat.items():
        pool = by_cat.get(kod, [])
        if not pool:
            continue
        ranked = sorted(pool, key=score_row, reverse=True)
        # Take top half by score, then sample
        top_n = max(target * 2, min(len(ranked), target + 10))
        candidates = ranked[:top_n]
        pick_n = min(target, len(candidates))
        picks = candidates[: pick_n // 2]  # keep best half deterministic
        remaining = [c for c in candidates if c not in picks]
        rng.shuffle(remaining)
        picks.extend(remaining[: pick_n - len(picks)])
        for p in picks:
            p["selected"] = "1"
            selected_count += 1

    # Ensure at least ~80 if categories thin
    if selected_count < 80:
        others = [r for r in rows if r.get("selected") != "1"]
        others.sort(key=score_row, reverse=True)
        for r in others[: 80 - selected_count]:
            r["selected"] = "1"
            selected_count += 1

    write_csv(catalog_path, rows, CATALOG_FIELDS)
    print(f"Selected {selected_count} / {len(rows)} products in {catalog_path}")
    for kod in sorted(by_cat.keys()):
        n = sum(1 for r in by_cat[kod] if r.get("selected") == "1")
        if n:
            print(f"  {kod}: {n}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
