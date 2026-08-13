import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/bildirim_merkezi.dart';
import '../services/gercek_bildirimler.dart';
import '../services/namaz_bildirim_ayarlari.dart';
import '../services/renkler.dart';
import '../services/vakit_servisi.dart';

/// Namaz vakitleri hatırlatıcı ayarları:
/// - genel aç/kapa ve titreşim
/// - her vakit için "dakika önce" (veya Kapalı) seçimi
/// - test bildirimi ve pil optimizasyonu ipuçları
class NamazBildirimAyarlariPage extends StatefulWidget {
  const NamazBildirimAyarlariPage({super.key});

  @override
  State<NamazBildirimAyarlariPage> createState() =>
      _NamazBildirimAyarlariPageState();
}

class _NamazBildirimAyarlariPageState extends State<NamazBildirimAyarlariPage> {
  bool _master = true;
  final Map<NamazVakti, String> _vakitSaatleri = {};

  @override
  void initState() {
    super.initState();
    _bastaYukle();
  }

  Future<void> _bastaYukle() async {
    await NamazBildirimAyarlari.yukle();
    final master = await BildirimMerkezi.masterOku();
    if (!mounted) return;
    setState(() => _master = master);
    await _vakitleriYukle();
  }

  Future<void> _vakitleriYukle() async {
    final vakitler = await VakitServisi.gunlukVakitler();
    if (!mounted) return;
    setState(() {
      _vakitSaatleri.clear();
      for (final v in vakitler) {
        final kod = NamazVakti.adindan(v.ad);
        if (kod != null) _vakitSaatleri[kod] = v.saatYaz;
      }
    });
  }

  Future<void> _masterDegistir(bool deger) async {
    await BildirimMerkezi.masterYaz(deger);
    await BildirimMerkezi.guncelle();
    await NamazBildirimAyarlari.aktifAyarla(deger);
    await GercekBildirimler.planla();
    if (!mounted) return;
    setState(() => _master = deger);
  }

  Future<void> _titresimDegistir(bool deger) async {
    await NamazBildirimAyarlari.titresimAyarla(deger);
    await GercekBildirimler.planla();
  }

  Future<void> _dakikaSec(NamazVakti vakit, int? dakika) async {
    if (dakika == null) return;
    await NamazBildirimAyarlari.ayarla(vakit, dakika);
    await GercekBildirimler.planla();
    if (!mounted) return;
    final mesaj = dakika < 0
        ? '${vakit.ad} bildirimleri kapatıldı'
        : dakika == 0
            ? '${vakit.ad}: vaktinde bildirilecek'
            : '${vakit.ad}: $dakika dk önce bildirilecek';
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(mesaj),
        duration: const Duration(seconds: 2),
      ));
  }

  Future<void> _testGonder() async {
    final ok = await GercekBildirimler.testBildirimi();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok
          ? 'Test bildirimi 5 saniye içinde gelecek'
          : 'Bildirimler hazır değil. Uygulama ayarlarından bildirim iznini kontrol et.'),
      duration: const Duration(seconds: 3),
    ));
  }

  String _dakikaEtiketi(int dk) {
    if (dk < 0) return 'Kapalı';
    if (dk == 0) return 'Vaktinde';
    return '$dk dk önce';
  }

  Future<void> _pilOptimizasyonuIste() async {
    const appId = 'com.example.islami_uygulama';
    final acildi = await _intentAc(
      'intent:package:$appId#Intent;'
      'action=android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS;end',
    );
    if (!acildi) await _uygulamaAyarlari();
  }

  Future<void> _uygulamaAyarlari() async {
    const appId = 'com.example.islami_uygulama';
    final acildi = await _intentAc(
      'intent:package:$appId#Intent;'
      'action=android.settings.APPLICATION_DETAILS_SETTINGS;end',
    );
    if (!acildi && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Ayarlar sayfası açılamadı.'),
      ));
    }
  }

  Future<bool> _intentAc(String url) async {
    try {
      return await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Renkler.bannerUst, Renkler.bannerAlt],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _baslikSatiri(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _genelDurumKarti(),
                    const SizedBox(height: 16),
                    _vakitListesi(),
                    const SizedBox(height: 16),
                    _testKarti(),
                    if (defaultTargetPlatform == TargetPlatform.android) ...[
                      const SizedBox(height: 16),
                      _pilKarti(),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baslikSatiri(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Namaz Vakti Hatırlatıcıları',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Her vakit için ayrı hatırlatma süresi belirleyebilirsin',
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Icon(Icons.alarm_on, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _genelDurumKarti() {
    return _kart(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.notifications_active_outlined,
                  color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Tüm namaz bildirimleri',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Switch(
                value: _master,
                onChanged: _masterDegistir,
                activeThumbColor: Colors.white,
                activeTrackColor: Colors.lightGreenAccent,
              ),
            ],
          ),
          const Divider(height: 24, color: Colors.white12),
          Row(
            children: [
              const Icon(Icons.vibration, color: Colors.white70, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Titreşim',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: NamazBildirimAyarlari.titresim,
                builder: (context, titresim, _) => Switch(
                  value: titresim,
                  onChanged: _titresimDegistir,
                  activeThumbColor: Colors.white,
                  activeTrackColor: Colors.lightGreenAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _vakitListesi() {
    return ValueListenableBuilder<Map<NamazVakti, int>>(
      valueListenable: NamazBildirimAyarlari.dakikalar,
      builder: (context, dakikalar, _) {
        return Column(
          children: [
            for (final vakit in NamazVakti.values) ...[
              _kart(
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        _vakitIkonu(vakit),
                        color: Colors.lightGreenAccent,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            vakit.ad,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _vakitSaatleri[vakit] ?? '—',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: dakikalar[vakit] ?? vakit.varsayilan,
                          dropdownColor: const Color(0xFF2E3B2E),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white70,
                          ),
                          items: [
                            for (final dk in NamazVakti.tumSecenekler(vakit))
                              DropdownMenuItem<int>(
                                value: dk,
                                child: Text(_dakikaEtiketi(dk)),
                              ),
                          ],
                          onChanged: (dk) => _dakikaSec(vakit, dk),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ],
        );
      },
    );
  }

  IconData _vakitIkonu(NamazVakti vakit) {
    switch (vakit) {
      case NamazVakti.gunes:
      case NamazVakti.ogle:
        return Icons.wb_sunny;
      case NamazVakti.ikindi:
        return Icons.brightness_5;
      case NamazVakti.aksam:
        return Icons.wb_twilight;
      case NamazVakti.yatsi:
        return Icons.nights_stay;
      default:
        return Icons.wb_twilight;
    }
  }

  Widget _testKarti() {
    return _kart(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Test Bildirimi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Ayarların doğru çalışıp çalışmadığını görmek için hemen bir '
            'bildirim gönder.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _testGonder,
            icon: const Icon(Icons.notifications_active, size: 18),
            label: const Text('Test Bildirimi Gönder'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.lightGreenAccent.withValues(alpha: 0.2),
              foregroundColor: Colors.lightGreenAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pilKarti() {
    return _kart(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.battery_alert_outlined,
                  color: Colors.amberAccent, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Pil Optimizasyonu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Bazı telefonlar (özellikle Xiaomi, Samsung, Huawei) arka plan '
            'işlemlerini kısıtlar ve tam zamanlı bildirimleri geciktirebilir. '
            'Namaz bildirimlerinin aksamaması için uygulamanın pil '
            'optimizasyonundan muaf tutulması önerilir.',
            style: TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: _pilOptimizasyonuIste,
                icon: const Icon(Icons.battery_charging_full, size: 16),
                label: const Text('Pil Optimizasyonunu Kapat'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.amberAccent,
                  side: const BorderSide(color: Colors.white24),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _uygulamaAyarlari,
                icon: const Icon(Icons.settings_outlined, size: 16),
                label: const Text('Uygulama Ayarlarını Aç'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kart({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: child,
    );
  }
}
