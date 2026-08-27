import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../services/bildirim_merkezi.dart';
import '../services/gercek_bildirimler.dart';
import '../services/namaz_bildirim_ayarlari.dart';
import '../services/renkler.dart';
import '../services/vakit_servisi.dart';
import '../widgets/kart_sekilleri.dart';

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
    final l = AppLocalizations.of(context);
    final mesaj = dakika < 0
        ? l.t('nba.disabled').replaceFirst('{v}', vakit.ad)
        : dakika == 0
            ? l.t('nba.onTimeSnack').replaceFirst('{v}', vakit.ad)
            : l.t('nba.minutesBefore')
                .replaceFirst('{v}', vakit.ad)
                .replaceFirst('{n}', '$dakika');
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
    final l = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(ok ? l.t('nba.testOk') : l.t('nba.testFail')),
      duration: const Duration(seconds: 3),
    ));
  }

  String _dakikaEtiketi(int dk, AppLocalizations l) {
    if (dk < 0) return l.t('nba.off');
    if (dk == 0) return l.t('nba.onTime');
    return l.t('nba.minutesAgo').replaceFirst('{n}', '$dk');
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context).t('nba.settingsError')),
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
    final l = AppLocalizations.of(context);
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
              _baslikSatiri(context, l),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _genelDurumKarti(l),
                    const SizedBox(height: 16),
                    _vakitListesi(l),
                    const SizedBox(height: 16),
                    _testKarti(l),
                    if (defaultTargetPlatform == TargetPlatform.android) ...[
                      const SizedBox(height: 16),
                      _pilKarti(l),
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

  Widget _baslikSatiri(BuildContext context, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const UcdIkon(ikon: Icons.arrow_back_ios_new_rounded, renk: Colors.white),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('nba.title'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  l.t('nba.subtitle'),
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const UcdIkon(ikon: Icons.alarm_on_rounded, renk: Colors.white54),
        ],
      ),
    );
  }

  Widget _genelDurumKarti(AppLocalizations l) {
    return _kart(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: Icons.notifications_active_rounded,
                  renk: Colors.white70, boyut: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l.t('nba.allPrayers'),
                  style: const TextStyle(
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
              const UcdIkon(ikon: Icons.vibration_rounded, renk: Colors.white70, boyut: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l.t('nba.vibration'),
                  style: const TextStyle(
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

  Widget _vakitListesi(AppLocalizations l) {
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
                      child: UcdIkon(
                        ikon: _vakitIkonu(vakit),
                        renk: Colors.lightGreenAccent,
                        boyut: 20,
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
                          icon: const UcdIkon(
                            ikon: Icons.arrow_drop_down_rounded,
                            renk: Colors.white70,
                          ),
                          items: [
                            for (final dk in NamazVakti.tumSecenekler(vakit))
                              DropdownMenuItem<int>(
                                value: dk,
                                child: Text(_dakikaEtiketi(dk, l)),
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
        return Icons.wb_sunny_rounded;
      case NamazVakti.ikindi:
        return Icons.brightness_5_rounded;
      case NamazVakti.aksam:
        return Icons.wb_twilight_rounded;
      case NamazVakti.yatsi:
        return Icons.nights_stay_rounded;
      default:
        return Icons.wb_twilight_rounded;
    }
  }

  Widget _testKarti(AppLocalizations l) {
    return _kart(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.t('nba.testTitle'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l.t('nba.testDesc'),
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _testGonder,
            icon: const UcdIkon(ikon: Icons.notifications_active_rounded, renk: Colors.lightGreenAccent, boyut: 18),
            label: Text(l.t('nba.sendTest')),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.lightGreenAccent.withValues(alpha: 0.2),
              foregroundColor: Colors.lightGreenAccent,
            ),
          ),
        ],
      ),
    );
  }

  Widget _pilKarti(AppLocalizations l) {
    return _kart(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: Icons.battery_alert_rounded,
                  renk: Colors.amberAccent, boyut: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l.t('nba.batteryTitle'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            l.t('nba.batteryDesc'),
            style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: _pilOptimizasyonuIste,
                icon: const UcdIkon(ikon: Icons.battery_charging_full_rounded, renk: Colors.amberAccent, boyut: 16),
                label: Text(l.t('nba.batteryDisable')),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.amberAccent,
                  side: const BorderSide(color: Colors.white24),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _uygulamaAyarlari,
                icon: UcdIkon(ikon: Icons.settings_rounded, renk: Colors.white70, boyut: 16),
                label: Text(l.t('nba.openSettings')),
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
