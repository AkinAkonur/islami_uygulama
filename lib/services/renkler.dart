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


  // ------------------ SABIT MARKA VE DURUM RENKLERI ------------------
  // Uygulamanın her sayfası aynı altın/yeşil dilini kullanır. Durum renkleri
  // de bu paletin içinden seçilmiştir; neon veya yabancı ton kullanılmaz.
  static const Color altinSabit = Color(0xFFD4AF37);
  static const Color acikAltinSabit = Color(0xFFEED07A);
  static const Color koyuAltinSabit = Color(0xFF8A6A16);
  static const Color zumrutSabit = Color(0xFF2FA97A);
  static const Color acikZumrutSabit = Color(0xFF7FD9B4);
  static const Color basari = Color(0xFF3FA57A);
  static const Color uyari = Color(0xFFE0A32E);
  static const Color hata = Color(0xFFC9603F);

  // ------------------ VAKİT PALETLERİ ------------------

  static const _safak = VakitPalet(
    ad: 'Şafak',
    zemin: Color(0xFF08150F),
    kart: Color(0xFF11291D),
    yuzey: Color(0xFF0C1F16),
    seciliYuzey: Color(0xFF1C4231),
    cerceve: Color(0xFF3F6B52),
    cerceve2: Color(0xFF20402F),
    vurgu: Color(0xFFD4AF37),
    acikVurgu: Color(0xFFEED07A),
    navBar: Color(0xFF061009),
    bannerUst: Color(0xFF1A3A28),
    bannerAlt: Color(0xFF08150F),
  );

  static const _sabah = VakitPalet(
    ad: 'Sabah',
    zemin: Color(0xFF08150F),
    kart: Color(0xFF11291D),
    yuzey: Color(0xFF0C1F16),
    seciliYuzey: Color(0xFF1C4231),
    cerceve: Color(0xFF3F6B52),
    cerceve2: Color(0xFF20402F),
    vurgu: Color(0xFFD4AF37),
    acikVurgu: Color(0xFFEED07A),
    navBar: Color(0xFF061009),
    bannerUst: Color(0xFF1A3A28),
    bannerAlt: Color(0xFF08150F),
  );

  static const _ogle = VakitPalet(
    ad: 'Öğle',
    zemin: Color(0xFF08150F),
    kart: Color(0xFF11291D),
    yuzey: Color(0xFF0C1F16),
    seciliYuzey: Color(0xFF1C4231),
    cerceve: Color(0xFF3F6B52),
    cerceve2: Color(0xFF20402F),
    vurgu: Color(0xFFD4AF37),
    acikVurgu: Color(0xFFEED07A),
    navBar: Color(0xFF061009),
    bannerUst: Color(0xFF1A3A28),
    bannerAlt: Color(0xFF08150F),
  );

  static const _ikindi = VakitPalet(
    ad: 'İkindi',
    zemin: Color(0xFF08150F),
    kart: Color(0xFF11291D),
    yuzey: Color(0xFF0C1F16),
    seciliYuzey: Color(0xFF1C4231),
    cerceve: Color(0xFF3F6B52),
    cerceve2: Color(0xFF20402F),
    vurgu: Color(0xFFD4AF37),
    acikVurgu: Color(0xFFEED07A),
    navBar: Color(0xFF061009),
    bannerUst: Color(0xFF1A3A28),
    bannerAlt: Color(0xFF08150F),
  );

  static const _aksam = VakitPalet(
    ad: 'Akşam',
    zemin: Color(0xFF08150F),
    kart: Color(0xFF11291D),
    yuzey: Color(0xFF0C1F16),
    seciliYuzey: Color(0xFF1C4231),
    cerceve: Color(0xFF3F6B52),
    cerceve2: Color(0xFF20402F),
    vurgu: Color(0xFFD4AF37),
    acikVurgu: Color(0xFFEED07A),
    navBar: Color(0xFF061009),
    bannerUst: Color(0xFF1A3A28),
    bannerAlt: Color(0xFF08150F),
  );

  static const _yatsi = VakitPalet(
    ad: 'Yatsı',
    zemin: Color(0xFF08150F),
    kart: Color(0xFF11291D),
    yuzey: Color(0xFF0C1F16),
    seciliYuzey: Color(0xFF1C4231),
    cerceve: Color(0xFF3F6B52),
    cerceve2: Color(0xFF20402F),
    vurgu: Color(0xFFD4AF37),
    acikVurgu: Color(0xFFEED07A),
    navBar: Color(0xFF061009),
    bannerUst: Color(0xFF1A3A28),
    bannerAlt: Color(0xFF08150F),
  );

  // ------------------ AKTİF VAKİT ------------------

  /// Yalnızca testlerde: golden görüntülerin bilgisayar saatine bağlı
  /// olmaması için aktif vakit paleti bununla sabitlenebilir.
  @visibleForTesting
  static DateTime? testVakti;

  static VakitPalet get aktif {
    final saat = (testVakti ?? DateTime.now()).hour;
    if (saat >= 4 && saat < 7) return _safak;
    if (saat >= 7 && saat < 12) return _sabah;
    if (saat >= 12 && saat < 17) return _ogle;
    if (saat >= 17 && saat < 19) return _ikindi;
    if (saat >= 19 && saat < 22) return _aksam;
    return _yatsi;
  }

  // ------------------ VURGU RENGİ SEÇİMİ ------------------
  // Kullanıcı bir vurgu rengi seçerse (null = vakite göre otomatik) tüm
  // uygulamanın vurgu tonu bu renge sabitlenir. Renkler, uygulamanın renk
  // paletiyle uyumlu tonlardan seçilmiştir.

  static String? seciliVurguKod;

  static const Map<String, Color> _vurguRenkler = {
    'zumrut': Color(0xFF10B981),
    'mavi': Color(0xFF1B5E46),
    'altin': Color(0xFFD4AF37),
    'turkuaz': Color(0xFFB98F2E),
    'gul': Color(0xFFEED07A),
  };

  static const Map<String, Color> _acikVurguRenkler = {
    'zumrut': Color(0xFF6EE7B7),
    'mavi': Color(0xFF82A88F),
    'altin': Color(0xFFEED07A),
    'turkuaz': Color(0xFFE4C25B),
    'gul': Color(0xFFF9E3A8),
  };

  /// Seçili vurgu kodunun rengi; seçim yoksa vakit paletinin rengi.
  static Color get seciliVurguRengi =>
      _vurguRenkler[seciliVurguKod] ?? aktif.vurgu;

  // ------------------ RENK SLAYLARI ------------------
  // Şablon, renk literalleri yerine aşağıdaki adları kullanır.
  // Değerler vakitle değişir; yapı asla değişmez.

  static Color get zemin => aktif.zemin;
  static Color get kart => aktif.kart;
  static Color get yuzey => aktif.yuzey;
  static Color get seciliYuzey => aktif.seciliYuzey;
  static Color get cerceve => aktif.cerceve;
  static Color get cerceve2 => aktif.cerceve2;
  static Color get vurgu => _vurguRenkler[seciliVurguKod] ?? aktif.vurgu;
  static Color get acikVurgu =>
      _acikVurguRenkler[seciliVurguKod] ?? aktif.acikVurgu;
  static Color get navBar => aktif.navBar;
  static Color get bannerUst => aktif.bannerUst;
  static Color get bannerAlt => aktif.bannerAlt;
}
