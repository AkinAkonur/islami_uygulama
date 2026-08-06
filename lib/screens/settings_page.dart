import 'package:flutter/material.dart';

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  // Switch (Aç/Kapat) butonları için durum değişkenleri
  bool bildirimAcik = true;
  bool karanlikMod = true;
  bool konumOtomatik = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ana arka plan rengi
      backgroundColor: const Color(0xFF0F291E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14382B),
        title: const Text("Ayarlar", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _bolumBasligi("Hesap ve Profil"),
          _ayarSecenegi(
            Icons.person_outline,
            "Profili Düzenle",
            yonlendirme: true,
          ),
          _ayarSecenegi(
            Icons.star_border,
            "Premium Abonelik",
            yonlendirme: true,
            altMetin: "Aktif (71 Saat Kaldı)",
          ),

          const SizedBox(height: 20),
          _bolumBasligi("Namaz Vakitleri ve Konum"),
          _ayarSwitch(
            Icons.location_on_outlined,
            "Otomatik Konum (GPS)",
            konumOtomatik,
            (val) {
              setState(() => konumOtomatik = val);
            },
          ),
          _ayarSecenegi(
            Icons.calculate_outlined,
            "Hesaplama Yöntemi",
            yonlendirme: true,
            altMetin: "Diyanet İşleri Başkanlığı",
          ),

          const SizedBox(height: 20),
          _bolumBasligi("Bildirimler"),
          _ayarSwitch(
            Icons.notifications_active_outlined,
            "Tüm Bildirimlere İzin Ver",
            bildirimAcik,
            (val) {
              setState(() => bildirimAcik = val);
            },
          ),
          _ayarSecenegi(
            Icons.volume_up_outlined,
            "Ezan Sesi Seçimi",
            yonlendirme: true,
            altMetin: "Standart Ezan",
          ),

          const SizedBox(height: 20),
          _bolumBasligi("Görünüm"),
          _ayarSwitch(Icons.dark_mode_outlined, "Karanlık Mod", karanlikMod, (
            val,
          ) {
            setState(() => karanlikMod = val);
          }),
          _ayarSecenegi(
            Icons.language,
            "Uygulama Dili",
            yonlendirme: true,
            altMetin: "Türkçe",
          ),

          const SizedBox(height: 20),
          _bolumBasligi("Hakkında"),
          _ayarSecenegi(
            Icons.info_outline,
            "Gizlilik Politikası",
            yonlendirme: true,
          ),
          _ayarSecenegi(
            Icons.star_rate_outlined,
            "Uygulamayı Puanla",
            yonlendirme: true,
          ),
          const SizedBox(height: 20),

          // Sürüm Bilgisi
          const Center(
            child: Text(
              "Sürüm 1.0.0",
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // Bölüm başlıkları için yardımcı widget
  Widget _bolumBasligi(String baslik) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        baslik,
        style: const TextStyle(
          color: Color(0xFF10B981),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Yönlendirmeli veya tıklanabilir standart ayar satırı için yardımcı widget
  Widget _ayarSecenegi(
    IconData ikon,
    String baslik, {
    bool yonlendirme = false,
    String? altMetin,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF14382B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(ikon, color: Colors.white70, size: 20),
      ),
      title: Text(
        baslik,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      subtitle: altMetin != null
          ? Text(
              altMetin,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            )
          : null,
      trailing: yonlendirme
          ? const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16)
          : null,
      onTap: () {
        // İlgili sayfaya gitme komutları buraya eklenecek
      },
    );
  }

  // Aç/Kapat (Switch) barındıran ayar satırı için yardımcı widget
  Widget _ayarSwitch(
    IconData ikon,
    String baslik,
    bool deger,
    Function(bool) onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF14382B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(ikon, color: Colors.white70, size: 20),
      ),
      title: Text(
        baslik,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      trailing: Switch(
        value: deger,
        onChanged: onChanged,
        activeColor: const Color(0xFF10B981),
      ),
    );
  }
}
