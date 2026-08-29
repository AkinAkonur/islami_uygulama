import 'dart:async';

import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';
import '../services/vakit_servisi.dart';

class NamazScreen extends StatefulWidget {
  const NamazScreen({super.key});

  @override
  State<NamazScreen> createState() => _NamazScreenState();
}

class _NamazScreenState extends State<NamazScreen> {
  Timer? _sureci;
  List<VakitBilgisi> _vakitler = VakitServisi.varsayilan;

  @override
  void initState() {
    super.initState();
    _yukle();
    _sureci = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _sureci?.cancel();
    super.dispose();
  }

  Future<void> _yukle() async {
    final guncel = await VakitServisi.gunlukVakitler();
    if (!mounted) return;
    setState(() => _vakitler = guncel);
  }

  VakitBilgisi? _siradaki(DateTime now) {
    final dk = now.hour * 60 + now.minute;
    for (final v in _vakitler) {
      if (v.dakikaToplam > dk) return v;
    }
    return _vakitler.isNotEmpty ? _vakitler.first : null;
  }

  String _sureYaz(int sn) {
    String iki(int n) => n.toString().padLeft(2, '0');
    final s = sn % 60;
    final dk = (sn ~/ 60) % 60;
    final sa = sn ~/ 3600;
    return '${iki(sa)}:${iki(dk)}:${iki(s)}';
  }

  String _kalanYaz(VakitBilgisi v, DateTime now) {
    var hedef = v.dakikaToplam - (now.hour * 60 + now.minute);
    if (hedef < 0) hedef += 1440; // gece yarısını aşan vakit
    final sn = hedef * 60 - now.second;
    return AppLocalizations.of(context).t('vakitRemaining').replaceAll('{time}', _sureYaz(sn));
  }

  double _ilerleme(DateTime now) {
    final dk = now.hour * 60 + now.minute;
    final list = List<VakitBilgisi>.from(_vakitler)
      ..sort((a, b) => a.dakikaToplam.compareTo(b.dakikaToplam));
    if (list.isEmpty) return 0;
    int i = list.indexWhere((v) => v.dakikaToplam > dk);
    if (i == -1) i = 0;
    final onceki = list[(i - 1 + list.length) % list.length];
    final siradaki = list[i];
    final bitis = i == 0 ? siradaki.dakikaToplam + 1440 : siradaki.dakikaToplam;
    final toplam = bitis - onceki.dakikaToplam;
    final kalan = i == 0
        ? siradaki.dakikaToplam + 1440 - dk
        : siradaki.dakikaToplam - dk;
    final gecen = toplam - kalan;
    return (gecen / toplam).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final siradaki = _siradaki(now);

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).t('h.navNamaz'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Renkler.vurgu),
        ),
        backgroundColor: Renkler.kart,
        elevation: 0,
        iconTheme: IconThemeData(color: Renkler.vurgu),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Renkler.kart, Renkler.zemin],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Renkler.vurgu.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                          decoration: BoxDecoration(
                            color: Renkler.vurgu.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            AppLocalizations.of(context).t('h.active'),
                            style: TextStyle(
                              color: Renkler.vurgu,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                      Text(
                        (siradaki?.saatYaz ?? '--:--'),
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
          Text(
              "${siradaki?.ad ?? ''} ${AppLocalizations.of(context).t('vakitTitle')}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
                  SizedBox(height: 6),
                  Text(
                    siradaki != null
                        ? _kalanYaz(siradaki, now)
                        : "--:--:--",
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _ilerleme(now),
                      backgroundColor: Colors.black38,
                      valueColor: AlwaysStoppedAnimation<Color>(Renkler.vurgu),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text(
              AppLocalizations.of(context).t('vakitlerTitle'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            for (final t in _vakitler) ...[
              _vakitTile(
                t.ad,
                t.saatYaz,
                t == siradaki,
              ),
              SizedBox(height: 1),
            ],
          ],
        ),
      ),
    );
  }

  Widget _vakitTile(String name, String time, bool isCurrent) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isCurrent ? Renkler.seciliYuzey : Renkler.yuzey,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isCurrent ? Renkler.vurgu : Renkler.cerceve2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              UcdIkon(
                ikon: isCurrent ? Icons.access_time_filled : Icons.access_time_rounded,
                renk: isCurrent ? Renkler.vurgu : Colors.white54,
                boyut: 20,
              ),
              SizedBox(width: 12),
              Text(
                name,
                style: TextStyle(
                  color: isCurrent ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Text(
            time,
            style: TextStyle(
              color: isCurrent ? Renkler.vurgu : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

}
