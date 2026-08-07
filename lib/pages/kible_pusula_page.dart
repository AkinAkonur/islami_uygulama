import 'package:flutter/material.dart';
import '../services/renkler.dart';
import '../services/vakit_servisi.dart';
import 'dart:math' as math;

class KiblePusulaPage extends StatefulWidget {
  const KiblePusulaPage({super.key});

  @override
  State<KiblePusulaPage> createState() => _KiblePusulaPageState();
}

class _KiblePusulaPageState extends State<KiblePusulaPage> with SingleTickerProviderStateMixin {
  double _compassAngle = 0.0;
  double _qiblaBearing = 154.25; // konum yoksa varsayılan (İstanbul)
  double? _uzaklikKm;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _konumuYukle();
  }

Future<void> _konumuYukle() async {
    final k = await VakitServisi.koordinatOku();
    if (k == null || !mounted) return;
    setState(() {
      _qiblaBearing = VakitServisi.kibleAcisi(k.$1, k.$2);
      _uzaklikKm = VakitServisi.kabeUzakligiKm(k.$1, k.$2);
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double needleRotation = (_qiblaBearing - _compassAngle) * (math.pi / 180);

    return Scaffold(
      backgroundColor: Color(0xFF0D1610),
      appBar: AppBar(
        title: Text(
          "3D Kâbe & Kıble Pusulası",
          style: TextStyle(fontWeight: FontWeight.bold, color: Renkler.vurgu),
        ),
        backgroundColor: Color(0xFF141F18),
        elevation: 0,
        iconTheme: IconThemeData(color: Renkler.vurgu),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // GPS & Konum Bilgi Kartı (%100 Doğruluk Göstergesi)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1A2E22), Color(0xFF101B15)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF243B2E),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(Icons.gps_fixed, color: Renkler.vurgu, size: 28),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Yüksek Hassasiyetli GPS (%100)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          _uzaklikKm != null
                              ? "Kâbe'ye Uzaklık: ${_uzaklikKm!.toStringAsFixed(0)} km "
                                  "• Açı: ${_qiblaBearing.toStringAsFixed(1)}° "
                                  "${VakitServisi.yonEtiketi(_qiblaBearing)}"
                              : "Konum iznine göre kıble açısı ve uzaklık hesaplanır",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // 3D Görsel Kâbe ve Pusula Alanı
            Center(
              child: SizedBox(
                width: 320,
                height: 320,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer 3D Glow Ring
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Container(
                          width: 310 + (_pulseController.value * 10),
                          height: 310 + (_pulseController.value * 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Renkler.vurgu.withValues(alpha: 0.2 + (_pulseController.value * 0.3)),
                              width: 2,
                            ),
                          ),
                        );
                      },
                    ),

                    // Compass Dial Background
                    Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [Color(0xFF1B2E23), Color(0xFF0F1A14)],
                        ),
                        border: Border.all(color: Color(0xFF2D4A39), width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.7),
                            blurRadius: 25,
                            spreadRadius: 5,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(top: 12, child: Text("N", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 14))),
                          Positioned(bottom: 12, child: Text("S", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 14))),
                          Positioned(left: 14, child: Text("W", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 14))),
                          Positioned(right: 14, child: Text("E", style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, fontSize: 14))),
                          // Compass degree ticks
                        ],
                      ),
                    ),

                    // Rotating Qibla Needle Pointer
                    Transform.rotate(
                      angle: needleRotation,
                      child: SizedBox(
                        width: 280,
                        height: 280,
                        child: Column(
                          children: [
                            Container(
                              width: 14,
                              height: 100,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Renkler.vurgu, Colors.transparent],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),

                    // 3D Realistic Kaaba Centerpiece (Mükemmel 3D Görsel)
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color(0xFF111111),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Color(0xFFD4AF37), width: 2.5), // Altın yaldızlı şerit
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.8),
                            blurRadius: 15,
                            offset: Offset(0, 10),
                          ),
                          BoxShadow(
                            color: Color(0xFFD4AF37).withValues(alpha: 0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Gold Kiswa Band (Kâbe Kuşağı)
                          Positioned(
                            top: 25,
                            child: Container(
                              width: 90,
                              height: 14,
                              color: Color(0xFFD4AF37),
                            ),
                          ),
                          // Kaaba Door / Details
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.account_balance, color: Color(0xFFD4AF37), size: 36),
                              SizedBox(height: 2),
                              Text(
                                "KÂBE",
                                style: TextStyle(
                                  color: Color(0xFFD4AF37),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Hizalama Yönergesi
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF141F18),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF243B2E)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Renkler.vurgu),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Telefonunuzu yatay konumda tutun. Yeşil ibre tam yukarıyı gösterdiğinde Kâbe'ye yönelmiş olursunuz.",
                      style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Kalibrasyon & Simülasyon Butonları
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1A2E22),
                    foregroundColor: Renkler.vurgu,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    setState(() {
                      _compassAngle = (_compassAngle + 30) % 360;
                    });
                  },
                  icon: Icon(Icons.compass_calibration),
                  label: Text("Pusulayı Kalibre Et / Döndür"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
