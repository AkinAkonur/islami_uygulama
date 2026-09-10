#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Dart kodunda yorum/string dışındaki ASCII olmayan karakterleri yakalar.

Dart, Türkçe noktasız ı (U+0131) gibi bazı karakterleri tanımlayıcılarda
kabul etmez. Bu denetim aynı derleme hatasının yeniden eklenmesini önler.
"""
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
DIZINLER = [ROOT / "lib", ROOT / "test"]


def kod_karakterleri(metin: str):
    i = 0
    durum = "kod"
    tirnak = ""
    uclu = False
    while i < len(metin):
        c = metin[i]
        iki = metin[i:i + 2]
        if durum == "kod":
            if iki == "//":
                durum = "satir_yorum"
                i += 2
                continue
            if iki == "/*":
                durum = "blok_yorum"
                i += 2
                continue
            if c in ("'", '"'):
                tirnak = c
                uclu = metin[i:i + 3] == c * 3
                durum = "string"
                i += 3 if uclu else 1
                continue
            yield i, c
            i += 1
            continue
        if durum == "satir_yorum":
            if c == "\n":
                durum = "kod"
            i += 1
            continue
        if durum == "blok_yorum":
            if iki == "*/":
                durum = "kod"
                i += 2
            else:
                i += 1
            continue
        # String: kaçışları atla, tekli veya üçlü kapanışı bul.
        if c == "\\":
            i += 2
            continue
        if uclu and metin[i:i + 3] == tirnak * 3:
            durum = "kod"
            i += 3
            continue
        if not uclu and c == tirnak:
            durum = "kod"
        i += 1


def main() -> int:
    hatalar = []
    for dizin in DIZINLER:
        if not dizin.exists():
            continue
        for yol in sorted(dizin.rglob("*.dart")):
            metin = yol.read_text(encoding="utf-8")
            for konum, c in kod_karakterleri(metin):
                if ord(c) <= 127:
                    continue
                satir = metin.count("\n", 0, konum) + 1
                sutun = konum - metin.rfind("\n", 0, konum)
                hatalar.append(
                    f"{yol.relative_to(ROOT)}:{satir}:{sutun} "
                    f"U+{ord(c):04X} {c!r}"
                )
    if hatalar:
        print("Dart kodunda ASCII olmayan karakter bulundu:")
        print("\n".join(f" - {h}" for h in hatalar))
        return 1
    print("Dart ASCII kod denetimi temiz.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
