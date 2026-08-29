import 'dart:async';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../services/ummet_verileri.dart';

class UmmetHaritasiPage extends StatefulWidget {
  const UmmetHaritasiPage({super.key});

  @override
  State<UmmetHaritasiPage> createState() => _UmmetHaritasiPageState();
}

class _UmmetHaritasiPageState extends State<UmmetHaritasiPage> {
  Timer? _timer;
  int _namaz = 214362410;
  int _zikir = 96081240;
  int _aktif = 12483;
  int _dua = 48214;
  int _darbe = 0;
  final _rng = Random(42);

  @override
  void initState() {
    super.initState();
    _duaYukle();
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      if (!mounted) return;
      setState(() {
        _namaz += 3 + _rng.nextInt(11);
        _zikir += 5 + _rng.nextInt(19);
        _aktif += _rng.nextInt(3);
        _dua += 1 + _rng.nextInt(5);
        _darbe = (_darbe + 1) % 6;
      });
    });
  }

  Future<void> _duaYukle() async {
    final toplam = await UmmetStore.bugunYapilanDua();
    if (!mounted) return;
    setState(() => _dua = toplam);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('uh.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // ---------- KÜRE ----------
          Center(
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Renkler.bannerUst, Color(0xFF0A1A10)],
                  stops: [0.4, 1.0],
                ),
                border: Border.all(
                  color: Renkler.vurgu.withValues(alpha: 0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Renkler.vurgu.withValues(alpha: 0.25),
                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Meridyen çizgileri
                  for (final k in [0.3, 0.15, 0.0, -0.15, -0.3])
                    Positioned(
                      left: 120 + k * 240,
                      top: 20,
                      bottom: 20,
                      width: 1,
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  // Kâbe işareti
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Renkler.vurgu.withValues(alpha: 0.15),
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: Renkler.vurgu,
                      size: 30,
                    ),
                  ),
                  // Işıldayan noktalar (ünmetin dört bir yanı)
                  for (var i = 0; i < 6; i++)
                    Positioned(
                      left: 44 + ((i * 37) % 150).toDouble(),
                      top: 40 + ((i * 53) % 160).toDouble(),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 900),
                        width: _darbe == i ? 14 : 8,
                        height: _darbe == i ? 14 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _darbe == i
                              ? Renkler.vurgu
                              : Renkler.vurgu.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              l.t('uh.liveHint'),
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          SizedBox(height: 16),

          // ---------- CANLI SAYAÇLAR ----------
          _sayacKart(
            Icons.nightlight_round,
            l.t('uh.namaz'),
            _namaz,
            Renkler.vurgu,
            l.t('uh.namazSub'),
          ),
          SizedBox(height: 12),
          _sayacKart(
            Icons.self_improvement,
            l.t('uh.zikir'),
            _zikir,
            Renkler.acikVurgu,
            l.t('uh.zikirSub'),
          ),
          SizedBox(height: 12),
          _sayacKart(
            Icons.people_alt_outlined,
            l.t('uh.aktif'),
            _aktif,
            Renkler.vurgu,
            l.t('uh.aktifSub'),
          ),
          SizedBox(height: 12),
          _sayacKart(
            Icons.favorite_outline,
            l.t('uh.dua'),
            _dua,
            Renkler.acikVurgu,
            l.t('uh.duaSub'),
          ),
          SizedBox(height: 20),

          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Renkler.yuzey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Renkler.vurgu, size: 16),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.t('uh.info'),
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _sayacKart(IconData ikon, String baslik, int deger,
      Color renk, String alt) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: renk.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(ikon, color: renk, size: 26),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  binlikSayi(deger),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  alt,
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: renk,
              boxShadow: [
                BoxShadow(color: renk.withValues(alpha: 0.6), blurRadius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

