#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Sadece RAPOR: `const` ifadesi icinde calisma zamani ceviri cagrisi var mi?

Yalnizca gercek metot cagrilari (.t(, .aktif, .vakitAdi( ...) ve getter
kullanimlari isaretlenir; sinif adina yapilan referanslar (AppLocalizations.delegate
gibi sabit ifadeler) yok sayilir.
"""
import io
import os
import re
import sys

KOK = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "lib")
TETIK = re.compile(
    r"\.t\(|AppLocalizations\.aktif|AppLocalizations\.of\(|"
    r"\.vakitAdi\(|\.kisaVakitAdi\(|\.hesapMetodu\(|DilHizmetleri\.aktifDil"
)
CONST = re.compile(r"(?<![A-Za-z0-9_$])const(?![A-Za-z0-9_$])")
ACIK = {"(": ")", "[": "]", "{": "}"}
KAPALI = {")": "(", "]": "[", "}": "{"}


def ifade_sonu(kod, bas):
    i, yigin, n = bas, [], len(kod)
    while i < n:
        c = kod[i]
        if c in ("'", '"'):
            tirnak = c
            i += 1
            while i < n:
                if kod[i] == "\\":
                    i += 2
                    continue
                if kod[i] == tirnak:
                    break
                i += 1
        elif c in ACIK:
            yigin.append(c)
        elif c in KAPALI:
            if not yigin:
                return i
            yigin.pop()
            if not yigin:
                return i + 1
        elif c in ",;" and not yigin:
            return i
        elif c == "\n" and not yigin:
            return i
        i += 1
    return n


def main():
    bulgu = 0
    for kokdiz, _, dosyalar in os.walk(KOK):
        for d in sorted(dosyalar):
            if not d.endswith(".dart"):
                continue
            yol = os.path.join(kokdiz, d)
            kod = io.open(yol, encoding="utf-8").read()
            if not TETIK.search(kod):
                continue
            for m in CONST.finditer(kod):
                parca = kod[m.end():ifade_sonu(kod, m.end())]
                if TETIK.search(parca):
                    satir = kod.count("\n", 0, m.start()) + 1
                    print("%s:%d  const%s" % (yol.replace(KOK + "/", ""), satir, parca[:70].replace("\n", " ")))
                    bulgu += 1
    if bulgu:
        print("HATA: %d adet const ifadesi calisma zamani ceviri cagirisi iceriyor." % bulgu)
        return 1
    print("const/ceviri denetimi temiz.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
