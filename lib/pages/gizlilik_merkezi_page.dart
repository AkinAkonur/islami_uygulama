// ===========================================================================
// GİZLİLİK MERKEZİ SAYFASI
// ---------------------------------------------------------------------------
// KVKK (madde 11) ve GDPR beklentilerini "insan diliyle" karşılayan merkez:
//   • İzin kartları: Konum (gerçek izin durumu + cihaz ayarlarına yönlendirme),
//     Çevrimdışı depolama (indirilen dosya sayısı) ve Analitik (kapatma anahtarı).
//   • Kullanıcı hakları: "Tüm Verilerimi İndir" (JSON dökümü + paylaşım) ve
//     "Hesabımı ve Verilerimi Kalıcı Olarak Sil" (unutulma hakkı).
//   • Yasal bilgilendirme: kısa özet + tam metin bağlantıları.
// Tüm içerik, gizlilik_merkezi JSON şemasından (GizlilikMerkeziServisi) beslenir.
// ===========================================================================

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'gizlilik_politikasi_page.dart';
import '../services/gizlilik_merkezi.dart';
import '../services/medya_indirme_servisi.dart';
import '../services/renkler.dart';

class GizlilikMerkeziPage extends StatefulWidget {
  const GizlilikMerkeziPage({super.key});

  @override
  State<GizlilikMerkeziPage> createState() => _GizlilikMerkeziPageState();
}

class _GizlilikMerkeziPageState extends State<GizlilikMerkeziPage> {
  final GizlilikMerkeziVerisi _merkez = GizlilikMerkeziServisi.veri;

  bool _konumAktif = false;
  bool _indirmeYukleniyor = false;
  bool _silmeYukleniyor = false;

  @override
  void initState() {
    super.initState();
    _konumDurumunuOku();
  }

  Future<void> _konumDurumunuOku() async {
    final aktif = await GizlilikMerkeziServisi.konumAktifMi();
    if (mounted) setState(() => _konumAktif = aktif);
  }

  // ---------------------- KULLANICI HAKLARI ----------------------

  Future<void> _verileriIndir() async {
    if (_indirmeYukleniyor) return;
    setState(() => _indirmeYukleniyor = true);
    // Küçük bir gecikme ile kullanıcıya "hazırlanıyor" geri bildirimi verilir.
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final yol = await GizlilikMerkeziServisi.verileriDisaAktar();
    if (!mounted) return;
    setState(() => _indirmeYukleniyor = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Renkler.seciliYuzey,
        content: Text(
          yol == null
              ? 'Veri dökümü oluşturulamadı. Lütfen tekrar deneyin.'
              : 'Verileriniz hazırlandı ve paylaşım sayfası açıldı.',
        ),
      ),
    );
  }

  Future<void> _hesabiVeVerileriSil() async {
    if (_silmeYukleniyor) return;
    final hak = _merkez.kullaniciHaklari.where((h) => h.aksiyonId == 'hesap_sil').firstOrNull;
    final onay = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Renkler.yuzey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
        title: Text(
          'Kalıcı Silme Onayı',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          hak?.uyari ??
              'Bu işlem geri alınamaz. Tüm verileriniz anında silinir.',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, height: 1.5),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            style: TextButton.styleFrom(foregroundColor: Colors.white70),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Evet, Kalıcı Sil'),
          ),
        ],
      ),
    );
    if (onay != true || !mounted) return;

    setState(() => _silmeYukleniyor = true);
    await GizlilikMerkeziServisi.verileriSil();
    if (!mounted) return;
    setState(() => _silmeYukleniyor = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.redAccent.withValues(alpha: 0.85),
        content: const Text(
          'Tüm verileriniz kalıcı olarak silindi. En iyi deneyim için uygulamayı yeniden başlatın.',
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Future<void> _tamMetniAc() async {
    final url = _merkez.yasalMetinler.tamMetinUrl;
    if (url.isEmpty) return;
    try {
      final uri = Uri.parse(url);
      final acildi = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!acildi && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gizlilik politikası sayfası açılamadı.')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gizlilik politikası sayfası açılamadı.')),
        );
      }
    }
  }

  // ------------------------------ UI ------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Gizlilik Merkezi'),
        backgroundColor: Renkler.seciliYuzey,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _baslikKarti(),
          const SizedBox(height: 20),
          _bolumBasligi('İzinleriniz', Icons.shield_outlined, Colors.tealAccent),
          const SizedBox(height: 2),
          for (final izin in _merkez.izinKartlari) ...[
            _izinKarti(izin),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          _bolumBasligi('Haklarınız (KVKK · md.11)', Icons.verified_user_outlined, Colors.amberAccent),
          const SizedBox(height: 2),
          for (final hak in _merkez.kullaniciHaklari) ...[
            _hakKarti(hak),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          _bolumBasligi('Yasal Bilgilendirme', Icons.gavel_outlined, Colors.orangeAccent),
          const SizedBox(height: 2),
          _yasalKart(),
          const SizedBox(height: 12),
          _teknikGuvenceKarti(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _baslikKarti() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Renkler.seciliYuzey.withValues(alpha: 0.9),
            Renkler.kart,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.greenAccent.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shield, color: Colors.greenAccent, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _merkez.baslik,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _merkez.altBaslik,
                  style: const TextStyle(color: Colors.white70, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bolumBasligi(String metin, IconData ikon, Color renk) {
    return Row(
      children: [
        Icon(ikon, size: 17, color: renk),
        const SizedBox(width: 8),
        Text(
          metin,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _izinKarti(GizlilikIzinKarti izin) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Renkler.seciliYuzey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  GizlilikMerkeziServisi.ikonCevir(izin.ikon),
                  color: Renkler.vurgu,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  izin.baslik,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              _izinDenetim(izin),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            izin.aciklama,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
          if (izin.id == 'izin_konum') ...[
            const SizedBox(height: 6),
            Text(
              _konumAktif
                  ? 'Durum: İzin verildi — cihazdan değiştirilebilir.'
                  : 'Durum: İzin yok — namaz vakitleri manuel şehirle hesaplanabilir.',
              style: TextStyle(
                color: _konumAktif ? Colors.greenAccent : Colors.orangeAccent,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ] else if (izin.id == 'izin_depolama') ...[
            const SizedBox(height: 6),
            ValueListenableBuilder<Map<String, dynamic>>(
              valueListenable: MedyaIndirmeServisi.instance.indirilenler,
              builder: (context, indirilenler, _) => Text(
                indirilenler.isEmpty
                    ? 'Durum: Şu an indirilmiş içerik yok.'
                    : 'Durum: ${indirilenler.length} ses dosyası cihazınızda saklanıyor.',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// İzin kartının sağındaki denetim: konum → cihaz ayarları, analitik → anahtar.
  Widget _izinDenetim(GizlilikIzinKarti izin) {
    if (izin.id == 'izin_analitik') {
      return ValueListenableBuilder<bool>(
        valueListenable: GizlilikMerkeziServisi.analitikKapali,
        builder: (context, kapali, _) => Switch(
          value: kapali,
          activeThumbColor: Colors.greenAccent,
          onChanged: izin.degistirilebilirMi
              ? (v) => GizlilikMerkeziServisi.analitikDegistir(v)
              : null,
        ),
      );
    }
    if (izin.id == 'izin_konum') {
      return TextButton(
        onPressed: () async {
          await GizlilikMerkeziServisi.cihazKonumAyarlariniAc();
          await _konumDurumunuOku();
        },
        style: TextButton.styleFrom(foregroundColor: Renkler.vurgu),
        child: const Text('Yönet'),
      );
    }
    // Depolama: salt okunur etiket.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Yerel',
        style: TextStyle(color: Colors.tealAccent, fontSize: 11.5),
      ),
    );
  }

  Widget _hakKarti(GizlilikKullaniciHakki hak) {
    final tehlikeli = hak.tehlikeliMi;
    final renk = tehlikeli ? Colors.redAccent : Colors.tealAccent;
    final yukleniyor = tehlikeli ? _silmeYukleniyor : _indirmeYukleniyor;
    return Material(
      color: tehlikeli
          ? Colors.redAccent.withValues(alpha: 0.12)
          : Colors.tealAccent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: yukleniyor
            ? null
            : () => tehlikeli ? _hesabiVeVerileriSil() : _verileriIndir(),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: renk.withValues(alpha: 0.45)),
          ),
          child: Row(
            children: [
              Icon(
                tehlikeli ? Icons.delete_forever : Icons.download,
                color: renk,
                size: 26,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  hak.butonMetni,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              if (yukleniyor)
                const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.4),
                )
              else
                Icon(Icons.chevron_right, color: renk.withValues(alpha: 0.8)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _yasalKart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _merkez.yasalMetinler.kisaOzet,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12.5,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const GizlilikPolitikasiSayfasi(),
                    ),
                  );
                },
                icon: const Icon(Icons.menu_book_outlined, size: 17),
                label: const Text('Uygulamada tam metni oku'),
                style: TextButton.styleFrom(foregroundColor: Renkler.vurgu),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _tamMetniAc,
                icon: const Icon(Icons.open_in_new, size: 17),
                label: const Text('İnternette aç'),
                style: TextButton.styleFrom(foregroundColor: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teknikGuvenceKarti() {
    const satirlar = [
      (Icons.lock_outline, 'HTTPS / SSL', 'Tüm ağ istekleri (canlı yayın, podcast listeleri) uçtan uca şifreli taşınır.'),
      (Icons.phone_android, 'Minimal Veri', 'Uygulama yalnızca çalışması için gereken izinleri ister; rehbere, kameraya veya gereksiz verilere erişmez.'),
      (Icons.cloud_off_outlined, 'Sunucusuz Mimarî', 'Favoriler, dinleme geçmişi ve notlarınız yalnızca cihazınızda saklanır; hiçbir sunucuya aktarılmaz.'),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.yuzey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Teknik Güvence Altyapısı',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          for (final (ikon, baslik, detay) in satirlar)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(ikon, color: Renkler.vurgu, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          baslik,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          detay,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11.5,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}