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

import '../../l10n/app_localizations.dart';
import 'gizlilik_politikasi_page.dart';
import '../services/gizlilik_merkezi.dart';
import '../services/medya_indirme_servisi.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

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

  Future<void> _verileriIndir(AppLocalizations l) async {
    if (_indirmeYukleniyor) return;
    setState(() => _indirmeYukleniyor = true);
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final yol = await GizlilikMerkeziServisi.verileriDisaAktar();
    if (!mounted) return;
    setState(() => _indirmeYukleniyor = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Renkler.seciliYuzey,
        content: Text(
          yol == null ? l.t('gm.exportFailed') : l.t('gm.exportSuccess'),
        ),
      ),
    );
  }

  Future<void> _hesabiVeVerileriSil(AppLocalizations l) async {
    if (_silmeYukleniyor) return;
    final hak = _merkez.kullaniciHaklari.where((h) => h.aksiyonId == 'hesap_sil').firstOrNull;
    final onay = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Renkler.yuzey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        icon: const UcdIkon(ikon: Icons.warning_amber_rounded, renk: Colors.redAccent),
        title: Text(
          l.t('gm.deleteConfirmTitle'),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Text(
          hak?.uyari ?? l.t('gm.deleteWarning'),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, height: 1.5),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            style: TextButton.styleFrom(foregroundColor: Colors.white70),
            child: Text(l.t('gm.cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: Text(l.t('gm.confirmDelete')),
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
        content: Text(l.t('gm.deleted')),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Future<void> _tamMetniAc(AppLocalizations l) async {
    final url = _merkez.yasalMetinler.tamMetinUrl;
    if (url.isEmpty) return;
    try {
      final uri = Uri.parse(url);
      final acildi = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!acildi && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.t('gm.policyError'))),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.t('gm.policyError'))),
        );
      }
    }
  }

  // ------------------------------ UI ------------------------------

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('gm.title')),
        backgroundColor: Renkler.seciliYuzey,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _baslikKarti(),
          const SizedBox(height: 20),
          _bolumBasligi(l.t('gm.permissions'), Icons.shield_rounded, Colors.tealAccent),
          const SizedBox(height: 2),
          for (final izin in _merkez.izinKartlari) ...[
            _izinKarti(izin, l),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          _bolumBasligi(l.t('gm.rights'), Icons.verified_user_rounded, Colors.amberAccent),
          const SizedBox(height: 2),
          for (final hak in _merkez.kullaniciHaklari) ...[
            _hakKarti(hak, l),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          _bolumBasligi(l.t('gm.legal'), Icons.gavel_rounded, Colors.orangeAccent),
          const SizedBox(height: 2),
          _yasalKart(l),
          const SizedBox(height: 12),
          _teknikGuvenceKarti(l),
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
            child: const UcdIkon(ikon: Icons.shield_rounded, renk: Colors.greenAccent, boyut: 28),
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
        UcdIkon(ikon: ikon, renk: renk, boyut: 17),
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

  Widget _izinKarti(GizlilikIzinKarti izin, AppLocalizations l) {
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
                child: UcdIkon(
                  ikon: GizlilikMerkeziServisi.ikonCevir(izin.ikon),
                  renk: Renkler.vurgu,
                  boyut: 22,
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
              _izinDenetim(izin, l),
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
                  ? l.t('gm.locationGranted')
                  : l.t('gm.locationDenied'),
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
                    ? l.t('gm.noDownloads')
                    : l.t('gm.downloadsCount').replaceFirst('{n}', '${indirilenler.length}'),
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
  Widget _izinDenetim(GizlilikIzinKarti izin, AppLocalizations l) {
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
        child: Text(l.t('gm.manage')),
      );
    }
    // Depolama: salt okunur etiket.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        l.t('gm.local'),
        style: const TextStyle(color: Colors.tealAccent, fontSize: 11.5),
      ),
    );
  }

  Widget _hakKarti(GizlilikKullaniciHakki hak, AppLocalizations l) {
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
            : () => tehlikeli ? _hesabiVeVerileriSil(l) : _verileriIndir(l),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: renk.withValues(alpha: 0.45)),
          ),
          child: Row(
            children: [
              UcdIkon(
                ikon: tehlikeli ? Icons.delete_forever_rounded : Icons.download_rounded,
                renk: renk,
                boyut: 26,
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
                UcdIkon(ikon: Icons.chevron_right_rounded, renk: renk.withValues(alpha: 0.8)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _yasalKart(AppLocalizations l) {
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
                icon: UcdIkon(ikon: Icons.menu_book_rounded, renk: Renkler.vurgu, boyut: 17),
                label: Text(l.t('gm.readFullApp')),
                style: TextButton.styleFrom(foregroundColor: Renkler.vurgu),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () => _tamMetniAc(l),
                icon: const UcdIkon(ikon: Icons.open_in_new_rounded, renk: Colors.white70, boyut: 17),
                label: Text(l.t('gm.openWeb')),
                style: TextButton.styleFrom(foregroundColor: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _teknikGuvenceKarti(AppLocalizations l) {
    const satirlar = [
      (Icons.lock_outline_rounded, 'gm.tech1Title', 'gm.tech1Desc'),
      (Icons.phone_android_rounded, 'gm.tech2Title', 'gm.tech2Desc'),
      (Icons.cloud_off_rounded, 'gm.tech3Title', 'gm.tech3Desc'),
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
          Text(
            l.t('gm.techTitle'),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          for (final (ikon, baslikKey, detayKey) in satirlar)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UcdIkon(ikon: ikon, renk: Renkler.vurgu, boyut: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.t(baslikKey),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          l.t(detayKey),
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