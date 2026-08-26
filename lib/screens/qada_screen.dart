import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class QadaScreen extends StatefulWidget {
  const QadaScreen({super.key});

  @override
  State<QadaScreen> createState() => _QadaScreenState();
}

class _QadaScreenState extends State<QadaScreen> {
  final Map<String, int> _qadaCounts = {
    "Sabah": 145,
    "Öğle": 92,
    "İkindi": 60,
    "Akşam": 40,
    "Yatsı": 110,
    "Vitir": 55,
  };

  void _decrement(String key) {
    setState(() {
      if ((_qadaCounts[key] ?? 0) > 0) {
        _qadaCounts[key] = _qadaCounts[key]! - 1;
      }
    });
  }

  void _increment(String key) {
    setState(() {
      _qadaCounts[key] = (_qadaCounts[key] ?? 0) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalQada = _qadaCounts.values.fold(0, (sum, val) => sum + val);

    return Scaffold(
      backgroundColor: Color(0xFF0F1410),
      appBar: AppBar(
        title: Text("Kaza Namazı Takipçisi", style: TextStyle(fontWeight: FontWeight.bold, color: Renkler.vurgu)),
        backgroundColor: Color(0xFF141F18),
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
                  colors: [Color(0xFF3B2E1B), Color(0xFF1D170D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.4), width: 1.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TOPLAM BEKLEYEN KAZA", style: TextStyle(color: Colors.orangeAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                      SizedBox(height: 6),
                      Text("$totalQada Vakit", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  UcdIkon(ikon: Icons.assignment_turned_in_rounded, renk: Colors.orangeAccent, boyut: 40),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text("Vakit Bazlı Kaza Borçları", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),

            // Kaza Listesi / Grid
            ..._qadaCounts.keys.map((vakit) {
              int count = _qadaCounts[vakit]!;
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF161E18),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFF223028)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vakit, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _decrement(vakit),
                          icon: UcdIkon(ikon: Icons.remove_circle_outline_rounded, renk: Colors.orangeAccent),
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
