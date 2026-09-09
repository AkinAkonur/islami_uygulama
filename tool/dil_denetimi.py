#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Dil (lokalizasyon) denetimi.

Kontroller:
  1) 9 dil dosyasindaki anahtar kumeleri birebir ayni mi?
  2) Kodda kullanilan t('anahtar') cagrilarinin tamami tanimli mi?
  3) Bos ceviri degeri var mi?

Kullanim: python3 tool/dil_denetimi.py
Cikis kodu 0 = temiz, 1 = hata.
"""
import os
import re
import sys

KOK = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LIB = os.path.join(KOK, "lib")
L10N = os.path.join(LIB, "l10n")
DILLER = ["tr", "en", "ar", "id", "ms", "ur", "bn", "fr", "ru"]

# Anahtar/deger cifti: deger tek satirda, sonraki satirda veya bitisik
# string parcalari halinde ('abc' 'def') yazilmis olabilir.
GIRIS = re.compile(
    r"(['\"])(?P<k>[A-Za-z0-9_.]+)\1\s*:\s*"
    r"(?P<v>(?:\s*(['\"])(?:\\.|(?!\4).)*\4)+)"
)
PARCA = re.compile(r"(['\"])((?:\\.|(?!\1).)*)\1")
KULLANIM = re.compile(r"\.t\(\s*'([a-zA-Z0-9_.]+)'\s*\)")


def anahtarlari_oku(kod):
    yol = os.path.join(L10N, "%s.dart" % kod)
    with open(yol, encoding="utf-8") as fh:
        icerik = fh.read()
    anahtarlar = {}
    for m in GIRIS.finditer(icerik):
        deger = "".join(p.group(2) for p in PARCA.finditer(m.group("v")))
        anahtarlar[m.group("k")] = deger
    return anahtarlar


def main():
    hatalar = []
    tablo = {}
    for kod in DILLER:
        tablo[kod] = anahtarlari_oku(kod)
        print("%s: %d anahtar" % (kod, len(tablo[kod])))

    temel = set(tablo["tr"])
    for kod in DILLER[1:]:
        eksik = sorted(temel - set(tablo[kod]))
        fazla = sorted(set(tablo[kod]) - temel)
        if eksik:
            hatalar.append("%s dilinde eksik anahtar (%d): %s" % (kod, len(eksik), ", ".join(eksik[:10])))
        if fazla:
            hatalar.append("%s dilinde fazla anahtar (%d): %s" % (kod, len(fazla), ", ".join(fazla[:10])))

    for kod in DILLER:
        bos = sorted(k for k, v in tablo[kod].items() if v.strip() == "")
        if bos:
            hatalar.append("%s dilinde bos ceviri (%d): %s" % (kod, len(bos), ", ".join(bos[:10])))

    kullanilan = set()
    for dizin, _, dosyalar in os.walk(LIB):
        if os.path.abspath(dizin).startswith(os.path.abspath(L10N)):
            continue
        for d in dosyalar:
            if not d.endswith(".dart"):
                continue
            with open(os.path.join(dizin, d), encoding="utf-8") as fh:
                kullanilan.update(KULLANIM.findall(fh.read()))

    tanimsiz = sorted(k for k in kullanilan if k not in temel)
    # Dinamik olusturulan anahtarlar (ornek: 'v.short.' + kod) haric tutulur.
    tanimsiz = [k for k in tanimsiz if not any(t.startswith(k + ".") for t in temel)]
    if tanimsiz:
        hatalar.append("Kodda tanimsiz anahtar (%d): %s" % (len(tanimsiz), ", ".join(tanimsiz[:15])))

    print("Kodda kullanilan anahtar: %d" % len(kullanilan))
    if hatalar:
        print("\nHATALAR:")
        for h in hatalar:
            print(" -", h)
        return 1
    print("Dil denetimi temiz.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
