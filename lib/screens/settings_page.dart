import 'package:flutter/material.dart';
import '../pages/bildirimler_sayfasi.dart';
import '../pages/profil_sayfasi.dart';
import '../services/ayarlar_store.dart';
import '../services/bildirim_merkezi.dart';
import '../services/gercek_bildirimler.dart';
import '../services/vakit_servisi.dart';

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  bool _karanlikMod = true;
  bool _konumOtomatik = true;
  bool _masterBildirim = true;
  String _metotKod = AyarlarStore.diyanetKod;

  static const List<({String kod, String ad, String aciklama})> _metotlar = [
    (kod: '13', ad: 'Diyanet İşleri Başkanlığı', aciklama: 'Türkiye için önerilir'),
    (kod: '3', ad: 'Müslüman Dünya Ligi (MWL)', aciklama: 'Dünya genelinde yaygın'),
    (kod: '2', ad: 'ISNA (Kuzey Amerika)', aciklama: 'ABD ve Kanada için'),
    (kod: '1', ad: 'Karaçi Üniversitesi', aciklama: 'Güney Asya için'),
    (kod: '4', ad: 'Ümmü\'l-Kura (Mekke)', aciklama: 'Suudi Arabistan ve çevresi'),
    (kod: '5', ad: 'Mısır Genel Araştırma Kurumu', aciklama: 'Afrika ve Orta Doğu'),
  ];

  String get _metotAd {
    for (final m in _metotlar) {
      if (m.kod == _metotKod) return m.ad;
    }
    return 'Ülkeye göre otomatik';
  }

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final karanlik = await AyarlarStore.karanlikOku();
    final konum = await AyarlarStore.konumOtomatikOku();
    final master = await BildirimMerkezi.masterOku();
    final metot = await AyarlarStore.metotOku();
    if (!mounted) return;
    setState(() {
      _karanlikMod = karanlik;
      _konumOtomatik = konum;
      _masterBildirim = master;
      _metotKod = metot ?? '';
    });
  }

  Future<void> _karanlikDegistir(bool deger) async {
    await AyarlarStore.karanlikYaz(deger);
    if (mounted) setState(() => _karanlikMod = deger);
  }

  Future<void> _konumDegistir(bool deger) async {
    await AyarlarStore.konumOtomatikYaz(deger);
    if (mounted) setState(() => _konumOtomatik = deger);
    if (deger) {
      // GPS ile konumu al, şehri bul ve vakit önbelleğini yenile.
      final basarili = await VakitServisi.konumuOtomatikAl();
      if (!mounted) return;
      if (basarili) {
        final sehir = await VakitServisi.sehirOku() ?? 'konumun algılandı';
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Konum güncellendi: $sehir'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        if (!mounted) return;
        // Başarısızsa kullanıcı Konum sayfasından manuel şehir seçebilir.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Konum alınamadı. GPS iznini ve cihaz konumunu kontrol et, '
              'ya da Konum ekranından şehri manuel seçebilirsin.',
            ),
            duration: Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _masterBildirimDegistir(bool deger) async {
    await BildirimMerkezi.masterYaz(deger);
    await BildirimMerkezi.guncelle();
    await GercekBildirimler.planla();
    if (mounted) {
      setState(() => _masterBildirim = deger);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            deger
                ? 'Tüm bildirimlere izin verildi.'
                : 'Tüm bildirimler kapatıldı.',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _metotSec() async {
    final secilen = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        backgroundColor: const Color(0xFF14382B),
        title: const Text(
          'Hesaplama Yöntemi',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        children: [
          for (final m in _metotlar)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, m.kod),
              child: Row(
                children: [
                  Icon(
                    m.kod == _metotKod
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: const Color(0xFF10B981),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.ad,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          m.aciklama,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        const Padding(
          padding: EdgeInsets.fromLTRB(24, 6, 24, 18),
          child: Text(
            'Namaz vakitleri Güneş\'in konumuna göre hesaplanır. Dünyada '
            'kullanılan birçok hesap ekolü vardır; ülke ve bölgelere göre '
            'vakitler dakikalarca değişebilir. Seçtiğin yöntem vakit '
            'takvimine ve tüm bildirimlere uygulanır.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
        ],
      ),
    );
    if (secilen == null || secilen == _metotKod || !mounted) return;

    await AyarlarStore.metotYaz(secilen);
    // Önbelleğe takılmadan yeni yöntemle API'den yeniden çek. Bu, ana
    // ekrandaki vakit kartlarının da anında güncellenmesini sağlar.
    await VakitServisi.vakitleriYenile();
    await GercekBildirimler.planla();
    if (!mounted) return;
    setState(() => _metotKod = secilen);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Yeni yöntemle vakitler güncellendi.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _gizlilikGoster() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF14382B),
        title: const Text(
          'Gizlilik Politikası',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        content: const Text(
          'Uygulama verilerinizi cihazınızda saklar; şehir ve konum bilgisi '
          'yalnızca namaz vakitlerini ve Kıble yönünü doğru hesaplamak için '
          'kullanılır. Konum bilgileri üçüncü taraflarla paylaşılmaz, '
          'kullanıcı tarafından silinebilir.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Anladım',
              style: TextStyle(color: Color(0xFF10B981)),
            ),
          ),
        ],
      ),
    );
  }

  void _puanlaGoster() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF14382B),
        title: const Text(
          'Teşekkürler! 🙏',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        content: const Text(
          'Uygulamamızı kullandığın için mutluyuz. Uygulama mağazasından '
          'puanlayarak daha fazla kardeşe ulaşmamıza destek olabilirsin.',
          style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'Tamam',
              style: TextStyle(color: Color(0xFF10B981)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            altMetin: "Fotoğraf, isim ve istatistikler",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilSayfasi()),
              );
            },
          ),

          const SizedBox(height: 20),
          _bolumBasligi("Namaz Vakitleri ve Konum"),
          _ayarSwitch(
            Icons.location_on_outlined,
            "Otomatik Konum (GPS)",
            "Konum izni verilirse şehir otomatik algılanır",
            _konumOtomatik,
            _konumDegistir,
          ),
          _ayarSecenegi(
            Icons.calculate_outlined,
            "Hesaplama Yöntemi",
            altMetin: _metotAd,
            onTap: _metotSec,
          ),

          const SizedBox(height: 20),
          _bolumBasligi("Bildirimler"),
          _ayarSwitch(
            Icons.notifications_active_outlined,
            "Tüm Bildirimlere İzin Ver",
            "Namaz vakitleri, ayet ve özel gün bildirimleri",
            _masterBildirim,
            _masterBildirimDegistir,
          ),
          _ayarSecenegi(
            Icons.tune_outlined,
            "Bildirim Merkezi",
            altMetin: "Sessiz mod, kaza sayacı, tür ayarları",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BildirimlerSayfasi()),
              );
            },
          ),

          const SizedBox(height: 20),
          _bolumBasligi("Görünüm"),
          _ayarSwitch(
            Icons.dark_mode_outlined,
            "Karanlık Mod",
            "Uygulama teması anında güncellenir",
            _karanlikMod,
            _karanlikDegistir,
          ),

          const SizedBox(height: 20),
          _bolumBasligi("Hakkında"),
          _ayarSecenegi(
            Icons.info_outline,
            "Gizlilik Politikası",
            onTap: _gizlilikGoster,
          ),
          _ayarSecenegi(
            Icons.star_rate_outlined,
            "Uygulamayı Puanla",
            onTap: _puanlaGoster,
          ),
          const SizedBox(height: 20),

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

  Widget _ayarSecenegi(
    IconData ikon,
    String baslik, {
    String? altMetin,
    required VoidCallback onTap,
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
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Colors.white54, size: 16),
      onTap: onTap,
    );
  }

  Widget _ayarSwitch(
    IconData ikon,
    String baslik,
    String aciklama,
    bool deger,
    Future<void> Function(bool) onChanged,
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
      subtitle: Text(
        aciklama,
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
      trailing: Switch(
        value: deger,
        onChanged: (v) => onChanged(v),
        activeThumbColor: const Color(0xFF10B981),
      ),
    );
  }
}
