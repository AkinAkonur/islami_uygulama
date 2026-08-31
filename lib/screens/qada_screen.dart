import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class QadaScreen extends StatefulWidget {
  const QadaScreen({super.key});

  @override
  State<QadaScreen> createState() => _QadaScreenState();
}

class _QadaScreenState extends State<QadaScreen> {
  static const _kayitAnahtari = 'kaza_sayaclari';
  static const _varsayilan = {
    "Sabah": 145,
    "Öğle": 92,
    "İkindi": 60,
    "Akşam": 40,
    "Yatsı": 110,
    "Vitir": 55,
  };
  final Map<String, int> _qadaCounts = Map.of(_varsayilan);

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final p = await SharedPreferences.getInstance();
    final kayit = p.getString(_kayitAnahtari);
    if (kayit == null || !mounted) return;
    setState(() {
      final gelen = jsonDecode(kayit);
      if (gelen is Map) {
        _qadaCounts.clear();
        for (final e in gelen.entries) {
          if (e.key is String && e.value is num) {
            _qadaCounts[e.key as String] = (e.value as num).toInt();
          }
        }
      }
      for (final v in _varsayilan.keys) {
        _qadaCounts.putIfAbsent(v, () => _varsayilan[v]!);
      }
    });
  }

  Future<void> _kaydet() async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kayitAnahtari, jsonEncode(_qadaCounts));
  }

  void _decrement(String key) {
    setState(() {
      if ((_qadaCounts[key] ?? 0) > 0) {
        _qadaCounts[key] = _qadaCounts[key]! - 1;
      }
    });
    _kaydet();
  }

  void _increment(String key) {
    setState(() {
      _qadaCounts[key] = (_qadaCounts[key] ?? 0) + 1;
    });
    _kaydet();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    int totalQada = _qadaCounts.values.fold(0, (sum, val) => sum + val);

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).t('c.kazaTracker'),
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
            // Toplam Kaza Özeti
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Renkler.kart, Renkler.zemin],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TOPLAM BEKLEYEN KAZA", style: TextStyle(color: Renkler.vurgu, fontSize: 11, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text(l.t('qd.prayerTimes').replaceAll('{count}', totalQada.toString()), style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  UcdIkon(ikon: Icons.assignment_turned_in_rounded, renk: Renkler.vurgu, boyut: 40),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text(l.t('qd.byTime'), style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),

            // Kaza Listesi / Grid
            ..._qadaCounts.keys.map((vakit) {
              int count = _qadaCounts[vakit]!;
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
color: Renkler.yuzey,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Renkler.cerceve2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vakit, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _decrement(vakit),
                          icon: UcdIkon(ikon: Icons.remove_circle_outline_rounded, renk: Renkler.vurgu),
                        ),
                        Container(
                          width: 50,
                          alignment: Alignment.center,
                          child: Text("$count", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        IconButton(
                          onPressed: () => _increment(vakit),
                          icon: UcdIkon(ikon: Icons.add_circle_outline_rounded, renk: Renkler.vurgu),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
