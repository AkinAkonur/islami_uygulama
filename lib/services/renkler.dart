// ===========================================================================
// VAKİT GRADYANI - TEK MERKEZ RENK PALETİ
// Uygulamanın tüm renkleri buradan beslenir. Namaz vaktine göre "gökyüzü"
// değişir: şafak, sabah, öğle, ikindi, akşam, yatsı.
// Şablon kodu ASLA değişmez; yalnızca bu dosyadaki değerler renklendirmeyi
// belirler.
// ===========================================================================

import 'package:flutter/material.dart';

class VakitPalet {
  const VakitPalet({
    required this.ad,
    required this.zemin,
    required this.kart,
    required this.yuzey,
    required this.seciliYuzey,
    required this.cerceve,
    required this.cerceve2,
    required this.vurgu,
    required this.acikVurgu,
    required this.navBar,
    required this.bannerUst,
    required this.bannerAlt,
  });

  final String ad;
  final Color zemin;
  final Color kart;
  final Color yuzey;
  final Color seciliYuzey;
  final Color cerceve;
  final Color cerceve2;
  final Color vurgu;
  final Color acikVurgu;
  final Color navBar;
  final Color bannerUst;
  final Color bannerAlt;
}

class Renkler {
  Renkler._();

  // ------------------ VAKİT PALETLERİ ------------------

  static const _safak = VakitPalet(
    ad: 'Şafak',
    zemin: Color(0xFF18241C),
    kart: Color(0xFF23332A),
    yuzey: Color(0xFF1D2B23),
    seciliYuzey: Color(0xFF2E4436),
    cerceve: Color(0xFF395244),
    cerceve2: Color(0xFF27382E),
    vurgu: Color(0xFFF5A97C),
    acikVurgu: Color(0xFFFAD3B8),
    navBar: Color(0xFF121C16),
    bannerUst: Color(0xFF4A1F3D),
    bannerAlt: Color(0xFF2A1530),
  );

  static const _sabah = VakitPalet(
    ad: 'Sabah',
    zemin: Color(0xFF0E1F1A),
    kart: Color(0xFF163027),
    yuzey: Color(0xFF12281F),
    seciliYuzey: Color(0xFF1E4233),
    cerceve: Color(0xFF2A5441),
    cerceve2: Color(0xFF1A352B),
    vurgu: Color(0xFF5FA8E8),
    acikVurgu: Color(0xFFA8D4F6),
    navBar: Color(0xFF0A1712),
    bannerUst: Color(0xFF1B4A7A),
    bannerAlt: Color(0xFF0F2A4A),
  );

  static const _ogle = VakitPalet(
    ad: 'Öğle',
    zemin: Color(0xFF0C211B),
    kart: Color(0xFF133028),
    yuzey: Color(0xFF0F2821),
    seciliYuzey: Color(0xFF184238),
    cerceve: Color(0xFF1E5448),
    cerceve2: Color(0xFF16382E),
    vurgu: Color(0xFF4FC3C9),
    acikVurgu: Color(0xFFA8E6EA),
    navBar: Color(0xFF081712),
    bannerUst: Color(0xFF155A63),
    bannerAlt: Color(0xFF0C3740),
  );

  static const _ikindi = VakitPalet(
    ad: 'İkindi',
    zemin: Color(0xFF1D2218),
    kart: Color(0xFF2A3120),
    yuzey: Color(0xFF232A1B),
    seciliYuzey: Color(0xFF3A452B),
    cerceve: Color(0xFF4A5736),
    cerceve2: Color(0xFF333B24),
    vurgu: Color(0xFFF2C14E),
    acikVurgu: Color(0xFFF9E3A8),
    navBar: Color(0xFF151910),
    bannerUst: Color(0xFF5C4518),
    bannerAlt: Color(0xFF3A2C10),
  );

  static const _aksam = VakitPalet(
    ad: 'Akşam',
    zemin: Color(0xFF1E241C),
    kart: Color(0xFF2B3328),
    yuzey: Color(0xFF242C22),
    seciliYuzey: Color(0xFF3B473A),
    cerceve: Color(0xFF4C584C),
    cerceve2: Color(0xFF333D31),
    vurgu: Color(0xFFF09A6E),
    acikVurgu: Color(0xFFF6CBB8),
    navBar: Color(0xFF151A14),
    bannerUst: Color(0xFF5C2E33),
    bannerAlt: Color(0xFF3A1B26),
  );

  static const _yatsi = VakitPalet(
    ad: 'Yatsı',
    zemin: Color(0xFF0D1A16),
    kart: Color(0xFF142820),
    yuzey: Color(0xFF10231C),
    seciliYuzey: Color(0xFF1C3A2D),
    cerceve: Color(0xFF224832),
    cerceve2: Color(0xFF183023),
    vurgu: Color(0xFF9BB8E8),
    acikVurgu: Color(0xFFC9DAF6),
    navBar: Color(0xFF091410),
    bannerUst: Color(0xFF1D3F73),
    bannerAlt: Color(0xFF12264A),
  );

  // ------------------ AKTİF VAKİT ------------------

  static VakitPalet get aktif {
    final saat = DateTime.now().hour;
    if (saat >= 4 && saat < 7) return _safak;
    if (saat >= 7 && saat < 12) return _sabah;
    if (saat >= 12 && saat < 17) return _ogle;
    if (saat >= 17 && saat < 19) return _ikindi;
    if (saat >= 19 && saat < 22) return _aksam;
    return _yatsi;
  }

  // ------------------ RENK SLAYLARI ------------------
  // Şablon, renk literalleri yerine aşağıdaki adları kullanır.
  // Değerler vakitle değişir; yapı asla değişmez.

  static Color get zemin => aktif.zemin;
  static Color get kart => aktif.kart;
  static Color get yuzey => aktif.yuzey;
  static Color get seciliYuzey => aktif.seciliYuzey;
  static Color get cerceve => aktif.cerceve;
  static Color get cerceve2 => aktif.cerceve2;
  static Color get vurgu => aktif.vurgu;
  static Color get acikVurgu => aktif.acikVurgu;
  static Color get navBar => aktif.navBar;
  static Color get bannerUst => aktif.bannerUst;
  static Color get bannerAlt => aktif.bannerAlt;
}
