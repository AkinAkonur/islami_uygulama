import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/kart_sekilleri.dart';
import '../../l10n/app_localizations.dart';

import 'sure_detay_page.dart';

class HatimTakibiPage extends StatefulWidget {
  const HatimTakibiPage({super.key});

  @override
  State<HatimTakibiPage> createState() => _HatimTakibiPageState();
}

class _HatimTakibiPageState extends State<HatimTakibiPage> {
  static const _toplamSayfa = 604;
  static const _zemin = Color(0xFF111111);
  static const _kart = Color(0xFF1A1A19);
  static const _mint = Color(0xFF6EDAB4);
  static const _altin = Color(0xFFE9C349);

  int _sayfa = 1;
  int _hatimSayisi = 0;
  int _gunlukHedef = 20;
  int _bugunOkunan = 0;
  int _seri = 0;
  String _sonTarih = '';
  List<Map<String, dynamic>> _sonOkumalar = [];
  bool _yuklendi = false;

  String get _bugun => _tarih(DateTime.now());
  String get _dun => _tarih(DateTime.now().subtract(const Duration(days: 1)));
  int get _aktifCuz => (((_sayfa - 1) ~/ 20) + 1).clamp(1, 30);
  double get _ilerleme => (_sayfa / _toplamSayfa).clamp(0.0, 1.0);

  String _tarih(DateTime tarih) =>
      '${tarih.year}-${tarih.month.toString().padLeft(2, '0')}-${tarih.day.toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final p = await SharedPreferences.getInstance();
    final sonTarih = p.getString('hatim_son_tarih') ?? '';
    var bugunOkunan = p.getInt('hatim_bugun_okunan') ?? 0;
    var seri = p.getInt('hatim_streak') ?? 0;
    if (sonTarih != _bugun) bugunOkunan = 0;
    if (sonTarih.isNotEmpty && sonTarih != _bugun && sonTarih != _dun) seri = 0;

    final okumalar = <Map<String, dynamic>>[];
    for (final raw in p.getStringList('hatim_son_okumalar') ?? const []) {
      try {
        okumalar.add(jsonDecode(raw) as Map<String, dynamic>);
      } catch (_) {
        // Bozuk geçmiş kaydı diğer kayıtları etkilemez.
      }
    }

    if (!mounted) return;
    setState(() {
      _sayfa = (p.getInt('hatim_sayfa') ?? 1).clamp(1, _toplamSayfa);
      _hatimSayisi = p.getInt('hatim_sayisi') ?? 0;
      _gunlukHedef = p.getInt('hatim_gunluk_hedef') ?? 20;
      _bugunOkunan = bugunOkunan;
      _seri = seri;
      _sonTarih = sonTarih;
      _sonOkumalar = okumalar;
      _yuklendi = true;
    });
  }

  Future<void> _kaydet() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('hatim_sayfa', _sayfa);
    await p.setInt('hatim_sayisi', _hatimSayisi);
    await p.setInt('hatim_gunluk_hedef', _gunlukHedef);
    await p.setInt('hatim_bugun_okunan', _bugunOkunan);
    await p.setInt('hatim_streak', _seri);
    await p.setString('hatim_son_tarih', _sonTarih);
    await p.setStringList(
      'hatim_son_okumalar',
      _sonOkumalar.map(jsonEncode).toList(),
    );
  }

  Future<void> _sayfaDegistir(int fark) async {
    final onceki = _sayfa;
    final yeni = (_sayfa + fark).clamp(1, _toplamSayfa);
    final gercekFark = yeni - onceki;
    if (gercekFark == 0) return;

    setState(() {
      if (gercekFark > 0) {
        if (_sonTarih != _bugun) {
          _seri = _sonTarih == _dun ? _seri + 1 : 1;
          _bugunOkunan = 0;
        }
        _bugunOkunan += gercekFark;
        _sonTarih = _bugun;
        _gecmiseEkle(onceki, yeni, gercekFark);
      } else {
        _bugunOkunan = (_bugunOkunan + gercekFark).clamp(0, 999);
      }
      _sayfa = yeni;
    });
    await _kaydet();
    if (yeni == _toplamSayfa && mounted) _hatimTamamlandi();
  }

  void _gecmiseEkle(int onceki, int yeni, int adet) {
    final now = DateTime.now();
    _sonOkumalar.insert(0, {
      'baslangic': onceki,
      'bitis': yeni,
      'adet': adet,
      'cuz': (((yeni - 1) ~/ 20) + 1).clamp(1, 30),
      'zaman': now.toIso8601String(),
    });
    if (_sonOkumalar.length > 8) {
      _sonOkumalar.removeRange(8, _sonOkumalar.length);
    }
  }

  Future<void> _hedefSec() async {
    final l = AppLocalizations.of(context);
    final secilen = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: _kart,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.t('hkb.dailyGoalSheetTitle'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final hedef in [1, 2, 4, 5, 10, 20])
                    ChoiceChip(
                      label: Text(
                        l.t('hkb.pageCount').replaceFirst('{n}', '$hedef'),
                      ),
                      selected: hedef == _gunlukHedef,
                      selectedColor: _mint,
                      backgroundColor: const Color(0xFF2A2A29),
                      labelStyle: TextStyle(
                        color: hedef == _gunlukHedef
                            ? const Color(0xFF003829)
                            : Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                      onSelected: (_) => Navigator.pop(ctx, hedef),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    if (secilen == null || !mounted) return;
    setState(() => _gunlukHedef = secilen);
    await _kaydet();
  }

  void _okumayaDevamEt() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SureDetayPage(cuzNo: _aktifCuz)),
    );
  }

  Future<void> _hatimTamamlandi() async {
    final l = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: _kart,
        title: Text(
          l.t('hkb.hatimComplete'),
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          l.t('hkb.hatimCompleteMsg'),
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: _mint,
              foregroundColor: const Color(0xFF003829),
            ),
            onPressed: () {
              setState(() {
                _hatimSayisi++;
                _sayfa = 1;
              });
              _kaydet();
              Navigator.pop(ctx);
            },
            child: Text(l.t('hkb.startNewHatim')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_yuklendi) {
      return const Scaffold(
        backgroundColor: _zemin,
        body: Center(child: CircularProgressIndicator(color: _mint)),
      );
    }

    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: _zemin,
      appBar: AppBar(
        backgroundColor: _zemin,
        elevation: 0,
        title: Text(
          l.t('hkb.title'),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            tooltip: l.t('hkb.dailyGoalTooltip'),
            onPressed: _hedefSec,
            icon: const UcdIkon(ikon: Icons.tune_rounded, renk: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _ilhamKarti(l),
          const SizedBox(height: 18),
          _ilerlemeKarti(l),
          const SizedBox(height: 18),
          _sonKonumKarti(l),
          const SizedBox(height: 18),
          _gunlukSayacKarti(l),
          const SizedBox(height: 18),
          _cuzKarti(l),
          const SizedBox(height: 18),
          _aliskanlikKarti(l),
        ],
      ),
    );
  }

  Widget _ilhamKarti(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _altin.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: _altin, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0x334D421D),
            child: UcdIkon(
              ikon: Icons.lightbulb_rounded,
              renk: _altin,
              boyut: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('hkb.todayInspiration'),
                  style: TextStyle(
                    color: _altin,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.t('hkb.hadithQuote'),
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.35,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l.t('hkb.hadithSource'),
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ilerlemeKarti(AppLocalizations l) {
    final yuzde = (_ilerleme * 100).round();
    final kalanSayfa = _toplamSayfa - _sayfa;
    final kalanGun = (kalanSayfa / _gunlukHedef).ceil();
    return _kartKabuk(
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: _ilerleme,
                  strokeWidth: 10,
                  strokeCap: StrokeCap.round,
                  backgroundColor: const Color(0xFF353534),
                  valueColor: const AlwaysStoppedAnimation(_mint),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '%$yuzde',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        l.t('hkb.completed'),
                        style: const TextStyle(color: Colors.white60, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A29),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _altin.withValues(alpha: 0.3)),
            ),
            child: Text(
              l.t('hkb.personalHatim'),
              style: const TextStyle(color: _altin, fontSize: 11),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l.t('hkb.daysRemaining').replaceFirst('{n}', '$kalanGun'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l.t('hkb.dailyPlan').replaceFirst('{n}', '$_gunlukHedef'),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          if (_hatimSayisi > 0) ...[
            const SizedBox(height: 8),
            Text(
              l.t('hkb.hatimsCompleted').replaceFirst('{n}', '$_hatimSayisi'),
              style: const TextStyle(color: _mint, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }

  Widget _sonKonumKarti(AppLocalizations l) {
    return _kartKabuk(
      borderColor: _mint.withValues(alpha: 0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.t('hkb.lastPosition'),
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const UcdIkon(
                ikon: Icons.menu_book_rounded,
                renk: _mint,
                boyut: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l.t('hkb.juzPage')
                      .replaceFirst('{c}', '$_aktifCuz')
                      .replaceFirst('{p}', '$_sayfa'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _mint,
                foregroundColor: const Color(0xFF003829),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _okumayaDevamEt,
              iconAlignment: IconAlignment.end,
              icon: const UcdIkon(
                ikon: Icons.arrow_forward,
                renk: Color(0xFF003829),
                boyut: 18,
              ),
              label: Text(
                l.t('hkb.continueReading'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gunlukSayacKarti(AppLocalizations l) {
    final hedefOrani = (_bugunOkunan / _gunlukHedef).clamp(0.0, 1.0);
    return _kartKabuk(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.t('hkb.todayQuestion'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: _hedefSec,
                icon: const UcdIkon(
                  ikon: Icons.settings_outlined,
                  renk: Colors.white54,
                  boyut: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _yuvarlakButon(Icons.remove, () => _sayfaDegistir(-1)),
              SizedBox(
                width: 112,
                child: Column(
                  children: [
                    Text(
                      '$_bugunOkunan',
                      style: const TextStyle(
                        color: _mint,
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      l.t('hkb.page'),
                      style: const TextStyle(color: Colors.white60, fontSize: 11),
                    ),
                  ],
                ),
              ),
              _yuvarlakButon(Icons.add, () => _sayfaDegistir(1)),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: hedefOrani,
              minHeight: 7,
              backgroundColor: const Color(0xFF353534),
              valueColor: const AlwaysStoppedAnimation(_mint),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.t('hkb.juzCount').replaceFirst('{n}', '$_aktifCuz'),
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
              Text(
                l.t('hkb.dailyGoalLabel').replaceFirst('{n}', '$_gunlukHedef'),
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final adet in [2, 5, 10])
                Expanded(
                  child: TextButton(
                    onPressed: () => _sayfaDegistir(adet),
                    child: Text(
                      l.t('hkb.pageIncrement').replaceFirst('{n}', '$adet'),
                      style: const TextStyle(color: _mint, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cuzKarti(AppLocalizations l) {
    return _kartKabuk(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.t('hkb.juzProgress'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                l.t('hkb.thirtyJuz'),
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 30,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final cuz = index + 1;
              final tamam = cuz < _aktifCuz;
              final aktif = cuz == _aktifCuz;
              return InkWell(
                borderRadius: BorderRadius.circular(99),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SureDetayPage(cuzNo: cuz)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: tamam ? _mint : const Color(0xFF353534),
                    border: aktif ? Border.all(color: _mint, width: 2) : null,
                    boxShadow: (tamam || aktif)
                        ? [
                            BoxShadow(
                              color: _mint.withValues(alpha: 0.25),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$cuz',
                    style: TextStyle(
                      color: tamam
                          ? const Color(0xFF003829)
                          : aktif
                          ? _mint
                          : Colors.white38,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 14,
            runSpacing: 8,
            children: [
              _DurumAciklama(renk: _mint, metin: l.t('hkb.completed')),
              _DurumAciklama(
                renk: _mint,
                metin: l.t('hkb.inProgress'),
                sadeceCerceve: true,
              ),
              _DurumAciklama(
                renk: Color(0xFF353534),
                metin: l.t('hkb.notStarted'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _aliskanlikKarti(AppLocalizations l) {
    return _kartKabuk(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l.t('hkb.readingHabit'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: _altin.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(color: _altin.withValues(alpha: 0.3)),
                ),
                child: Text(
                  l.t('hkb.dailyStreak').replaceFirst('{n}', '$_seri'),
                  style: const TextStyle(
                    color: _altin,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(28, (i) {
              final dolu = i < (_seri.clamp(0, 28));
              return Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: dolu
                      ? _mint.withValues(alpha: 0.35 + (i % 4) * 0.18)
                      : const Color(0xFF353534),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          ),
          const SizedBox(height: 22),
          const Divider(color: Colors.white12),
          const SizedBox(height: 12),
          Text(
            l.t('hkb.recentReadings'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          if (_sonOkumalar.isEmpty)
            Text(
              l.t('hkb.noReadingYet'),
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            )
          else
            for (final okuma in _sonOkumalar.take(5))
              _okumaSatiri(okuma, l),
        ],
      ),
    );
  }

  Widget _okumaSatiri(Map<String, dynamic> okuma, AppLocalizations l) {
    final baslangic = okuma['baslangic'] as int? ?? 1;
    final bitis = okuma['bitis'] as int? ?? baslangic;
    final adet = okuma['adet'] as int? ?? 1;
    final cuz = okuma['cuz'] as int? ?? 1;
    DateTime? zaman;
    try {
      zaman = DateTime.parse(okuma['zaman'] as String);
    } catch (_) {
      zaman = null;
    }
    final saat = zaman == null
        ? ''
        : '${zaman.hour.toString().padLeft(2, '0')}:${zaman.minute.toString().padLeft(2, '0')}';
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: Color(0x196EDAB4),
            child: UcdIkon(
              ikon: Icons.menu_book_rounded,
              renk: _mint,
              boyut: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('hkb.readingRow')
                      .replaceFirst('{c}', '$cuz')
                      .replaceFirst('{s}', '$baslangic')
                      .replaceFirst('{e}', '$bitis'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  l.t('hkb.pagesRead').replaceFirst('{n}', '$adet'),
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
              ],
            ),
          ),
          Text(
            saat,
            style: const TextStyle(color: Colors.white38, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _yuvarlakButon(IconData ikon, VoidCallback onTap) {
    return IconButton.filledTonal(
      onPressed: onTap,
      style: IconButton.styleFrom(
        backgroundColor: const Color(0xFF2A2A29),
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white12),
      ),
      icon: UcdIkon(ikon: ikon, renk: Colors.white),
    );
  }

  Widget _kartKabuk({required Widget child, Color? borderColor}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _kart,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: borderColor ?? Colors.white10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _DurumAciklama extends StatelessWidget {
  const _DurumAciklama({
    required this.renk,
    required this.metin,
    this.sadeceCerceve = false,
  });

  final Color renk;
  final String metin;
  final bool sadeceCerceve;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: sadeceCerceve ? Colors.transparent : renk,
            border: sadeceCerceve ? Border.all(color: renk, width: 2) : null,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          metin,
          style: const TextStyle(color: Colors.white54, fontSize: 10),
        ),
      ],
    );
  }
}
