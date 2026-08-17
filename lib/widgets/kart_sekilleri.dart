// lib/widgets/kart_sekilleri.dart
// Ana ekran kartlarına uygulanabilen silüet çeşitleri (KartSekli) ve ikon
// rozetlerinde kullanılan 3D geometrik şekiller (SekilPlaka).
//
// Amaç: mevcut içerik şablonunu bozmadan, kartların dış hatlarını ve ikon
// rozetlerini çeşitlendirerek ana ekrana dikkat çekici ama sade bir derinlik
// kazandırmak. Silüetler içeriği kırpmayacak şekilde (köşe varyasyonları +
// alt kenar kavisi) tasarlanmıştır.

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Ana ekran kartlarına uygulanabilen dış hat (silüet) çeşitleri.
enum KartSekli {
  /// Düzgün yuvarlak köşeli — mevcut (klasik) görünüm.
  klasik,

  /// Yumuşak "squircle" (süper elips): köşeler daha organik kavis alır.
  yuvar,

  /// Köşeleri 45° kesilmiş "oktagon" görünüm.
  kose,

  /// Alt kenarı ortada hafif yukarı kavis alan "kemer" silüeti.
  sivri,
}

/// İkon rozetlerine (plaka) uygulanabilen 3D geometrik şekiller.
enum PlakaSekli {
  /// Tam daire.
  daire,

  /// Yuvarlak köşeli kare (meydan).
  yuvarlakKare,

  /// Altıgen.
  altigen,

  /// Elmas / baklava.
  baklava,

  /// İslami mihrap kavisi (üstte sivri kemer).
  mihrap,
}

/// Kart silüetini çizen clipper. [KartSekli] + [radius] kombinasyonunu
/// [UcdKart]'ın içine katman gibi uygular.
class KartSiluet extends CustomClipper<Path> {
  const KartSiluet(this.sekil, this.radius);

  final KartSekli sekil;
  final double radius;

  @override
  Path getClip(Size s) {
    final r = radius > 0 ? radius : 20.0;
    switch (sekil) {
      case KartSekli.klasik:
        return Path()..addRRect(
          RRect.fromRectAndRadius(Offset.zero & s, Radius.circular(r)),
        );
      case KartSekli.yuvar:
        return _squircle(s, r);
      case KartSekli.kose:
        return _chamfer(s, r);
      case KartSekli.sivri:
        return _kemerAlt(s, r);
    }
  }

  /// Süper elips benzeri yumuşak köşeler; içerik güvenli (yalnızca köşeler).
  Path _squircle(Size s, double r) {
    final w = s.width, h = s.height;
    final k = (r / math.min(w, h)).clamp(0.0, 0.5 - 0.001);
    final xs = w * k, xe = w - w * k;
    final ys = h * k, ye = h - h * k;
    return Path()
      ..moveTo(xs, 0)
      ..lineTo(xe, 0)
      ..quadraticBezierTo(w, 0, w, ys)
      ..lineTo(w, ye)
      ..quadraticBezierTo(w, h, xe, h)
      ..lineTo(xs, h)
      ..quadraticBezierTo(0, h, 0, ye)
      ..lineTo(0, ys)
      ..quadraticBezierTo(0, 0, xs, 0)
      ..close();
  }

  /// Köşeleri 45° kesilmiş sekizgen; içerik güvenli (köşelerden eksiltir).
  Path _chamfer(Size s, double r) {
    final w = s.width, h = s.height;
    final c = r.clamp(2.0, math.min(w, h) / 3);
    return Path()
      ..moveTo(c, 0)
      ..lineTo(w - c, 0)
      ..lineTo(w, c)
      ..lineTo(w, h - c)
      ..lineTo(w - c, h)
      ..lineTo(c, h)
      ..lineTo(0, h - c)
      ..lineTo(0, c)
      ..close();
  }

  /// Alt kenarın ortası hafif yukarı kavis alan "kemer" silüeti. İçerik
  /// güvenli: yalnızca alt-orta boşluğu inceltir.
  Path _kemerAlt(Size s, double r) {
    final w = s.width, h = s.height;
    final rk = r.clamp(2.0, math.min(w, h) / 3);
    return Path()
      ..moveTo(rk, 0)
      ..lineTo(w - rk, 0)
      ..quadraticBezierTo(w, 0, w, rk)
      ..lineTo(w, h - rk)
      ..quadraticBezierTo(w, h, w - rk, h)
      ..quadraticBezierTo(w * 0.5, h - rk * 1.6, rk, h)
      ..quadraticBezierTo(0, h, 0, h - rk)
      ..quadraticBezierTo(0, 0, rk, 0)
      ..close();
  }

  @override
  bool shouldReclip(KartSiluet oldClipper) =>
      oldClipper.sekil != sekil || oldClipper.radius != radius;
}

/// Rozet (plaka) şeklini çizen clipper.
class PlakaKesici extends CustomClipper<Path> {
  const PlakaKesici(this.sekil, {this.radius = 10});

  final PlakaSekli sekil;
  final double radius;

  @override
  Path getClip(Size s) {
    final w = s.width, h = s.height;
    final r = radius.clamp(2.0, math.min(w, h) / 3);
    switch (sekil) {
      case PlakaSekli.daire:
        return Path()..addOval(Offset.zero & s);
      case PlakaSekli.yuvarlakKare:
        return Path()..addRRect(
          RRect.fromRectAndRadius(Offset.zero & s, Radius.circular(r)),
        );
      case PlakaSekli.altigen:
        {
          final cx = w / 2, cy = h / 2;
          return Path()
            ..moveTo(cx - w * 0.5, cy)
            ..lineTo(cx - w * 0.25, 0)
            ..lineTo(cx + w * 0.25, 0)
            ..lineTo(cx + w * 0.5, cy)
            ..lineTo(cx + w * 0.25, h)
            ..lineTo(cx - w * 0.25, h)
            ..close();
        }
      case PlakaSekli.baklava:
        return Path()
          ..moveTo(w * 0.5, 0)
          ..lineTo(w, h * 0.5)
          ..lineTo(w * 0.5, h)
          ..lineTo(0, h * 0.5)
          ..close();
      case PlakaSekli.mihrap:
        return Path()
          ..moveTo(0, h)
          ..lineTo(w * 0.16, h * 0.55)
          ..quadraticBezierTo(w * 0.32, h * 0.08, w * 0.5, 0)
          ..quadraticBezierTo(w * 0.68, h * 0.08, w * 0.84, h * 0.55)
          ..lineTo(w, h)
          ..close();
    }
  }

  @override
  bool shouldReclip(PlakaKesici oldClipper) =>
      oldClipper.sekil != sekil || oldClipper.radius != radius;
}

/// İkon rozeti: geometrik şekle bürünmüş, hafif kabarık (3D) görünümlü
/// yüzey + parlak üst vurgu + alt gölge. [UcdKart]'ın içinde, kartın kendi
/// ikon kutusu yerine kullanılır; içerik akışını değiştirmez.
class SekilPlaka extends StatelessWidget {
  const SekilPlaka({
    super.key,
    required this.sekil,
    required this.ikon,
    required this.ikonRenk,
    this.boyut = 34,
    this.zemin,
    this.derinlik,
    this.ikonBoyut,
  });

  /// Rozetin geometrik biçimi.
  final PlakaSekli sekil;

  /// Rozet içindeki ikon.
  final IconData ikon;

  /// İkon rengi.
  final Color ikonRenk;

  /// Rozetin toplam kenar uzunluğu (kare alan).
  final double boyut;

  /// Ön yüzün ana rengi (varsayılan: ikon renginin hafif saydam tonu).
  final Color? zemin;

  /// Alt gölge/kalınlık rengi (varsayılan: ikon renginin koyu tonu).
  final Color? derinlik;

  /// İkon boyutu; verilmezse şekle göre otomatik ayarlanır.
  final double? ikonBoyut;

  @override
  Widget build(BuildContext context) {
    final kes = PlakaKesici(sekil, radius: boyut * 0.3);
    final ust = zemin ?? ikonRenk.withValues(alpha: 0.34);
    final dip = derinlik ?? ikonRenk.withValues(alpha: 0.72);
    final ib =
        ikonBoyut ?? (sekil == PlakaSekli.mihrap ? boyut * 0.42 : boyut * 0.52);

    Widget yuzey(Color renk, Gradient? gradyan) => ClipPath(
      clipper: kes,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: gradyan == null ? renk : null,
          gradient: gradyan,
        ),
      ),
    );

    return SizedBox(
      width: boyut,
      height: boyut,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          // 3D kalınlık: alt kenardan hafif taşarak kabarık his verir.
          Transform.translate(
            offset: const Offset(0, 2.2),
            child: yuzey(dip, null),
          ),
          // Ön yüz: yukarıdan aşağı hafif degrade.
          yuzey(
            ust,
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white.withValues(alpha: 0.16), ust, dip],
            ),
          ),
          // Parlak üst vurgusu (gloss).
          yuzey(
            Colors.transparent,
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withValues(alpha: 0.38),
                Colors.white.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.55],
            ),
          ),
          Center(
            child: UcdIkon(ikon: ikon, renk: ikonRenk, boyut: ib),
          ),
        ],
      ),
    );
  }
}

/// Tek ikon glisine 3D görünüm kazandıran sarmalayıcı: yukarıdan aşağı
/// parlayan degrade dolgu (üst aydınlık → alt koyu) ile yüzey derinliği verir.
/// Hem [SekilPlaka] rozetlerinin içinde hem de ana ekrandaki bağımsız
/// ikonlarda kullanılır.
class UcdIkon extends StatelessWidget {
  const UcdIkon({
    super.key,
    required this.ikon,
    required this.renk,
    this.boyut = 24,
    this.derinlik,
  });

  /// Çizilecek ikon.
  final IconData ikon;

  /// İkonun ana (en parlak) rengi.
  final Color renk;

  /// İkonun kutu boyutu.
  final double boyut;

  /// Alt ton rengi; verilmezse ana rengin koyulaştırılmış hâli.
  final Color? derinlik;

  @override
  Widget build(BuildContext context) {
    final dip = derinlik ?? Color.lerp(renk, Colors.black, 0.35)!;
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color.lerp(renk, Colors.white, 0.50)!, renk, dip],
        stops: const [0.0, 0.38, 1.0],
      ).createShader(bounds),
      child: Icon(ikon, size: boyut, color: Colors.white),
    );
  }
}
