import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../l10n/app_localizations.dart';
import '../services/cuz_hatim_store.dart';
import '../services/cuz_verileri.dart';
import '../services/kuran_verileri.dart';
import '../services/muzik_handler.dart';
import '../services/radyo_oynatici_store.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

/// Bir cüzün okuma sayfası.
/// Metin uygulamayla birlikte gelen varlıklardan (assets/cuzler) çevrimdışı
/// okunur; ses ise internetten akışla oynatılır (EveryAyah / Alafasy).
class CuzOkumaPage extends StatefulWidget {
  final int cuzNo;

  const CuzOkumaPage({super.key, required this.cuzNo});

  @override
  State<CuzOkumaPage> createState() => _CuzOkumaPageState();
}

class _CuzOkumaPageState extends State<CuzOkumaPage> {
  List<CuzAyah>? _ayetler;
  String? _hata;
  bool _yukleniyor = true;
  bool _okundu = false;

  /// Ses motu uygulama genelindeki tek just_audio oynatıcısıdır; böylece sayfa
  /// kapanınca bile Kur'an sesi arka planda çalmaya devam eder ve `audio_service`
  /// ile kilit ekranından kontrol edilebilir.
  AudioPlayer get _oynatici => RadyoOynaticiStore.player;
  StreamSubscription? _completionSub;
  bool _caliyor = false;
  int? _calanIndex;

  @override
  void initState() {
    super.initState();
    _yukle();
    _completionSub = _oynatici.processingStateStream.listen((durum) {
      if (durum == ProcessingState.completed) _ayetBitti();
    });
  }

  Future<void> _yukle() async {
    setState(() {
      _yukleniyor = true;
      _hata = null;
    });
    try {
      final ayetler = await CuzVerileri.cuzuYukle(widget.cuzNo);
      final okundu = (await CuzHatimStore.oku())[widget.cuzNo - 1];
      if (!mounted) return;
      setState(() {
        _ayetler = ayetler;
        _okundu = okundu;
        _yukleniyor = false;
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _hata = e.toString();
          _yukleniyor = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _completionSub?.cancel();
    super.dispose();
  }

  // ---------------- SES ----------------
  Future<void> _ayetBitti() async {
    if (!mounted || _ayetler == null) return;
    final idx = _calanIndex;
    if (idx == null) {
      setState(() => _caliyor = false);
      return;
    }
    final sonraki = idx + 1;
    if (sonraki < _ayetler!.length) {
      await _cal(sonraki);
    } else {
      setState(() {
        _caliyor = false;
        _calanIndex = null;
      });
      _gosterMesaj(AppLocalizations.of(context).t('co.listenDone'));
    }
  }

  Future<void> _cal(int index) async {
    final ayet = _ayetler![index];
    final url = CuzVerileri.ayetSesUrl(ayet.sureNo, ayet.ayetNo);
    final l = AppLocalizations.of(context);
    try {
      await _oynatici.setAudioSource(AudioSource.uri(Uri.parse(url)));
      MuzikHandler.aktif?.medyaHaber(MediaItem(
        id: url,
        title: 'Cüz ${widget.cuzNo} - Ayet ${index + 1}',
        artist: 'Kur\'an-ı Kerim',
      ));
      RadyoOynaticiStore.calanKanal.value = null;
      await _oynatici.play();
      setState(() {
        _caliyor = true;
        _calanIndex = index;
      });
    } catch (_) {
      _gosterMesaj(l.t('co.noSound'));
    }
  }

  Future<void> _durdur() async {
    await _oynatici.stop();
    setState(() {
      _caliyor = false;
      _calanIndex = null;
    });
  }

  // ---------------- HATİM TAKİBİ ----------------
  Future<void> _okunduDegistir() async {
    final l = AppLocalizations.of(context);
    final yeni = !_okundu;
    setState(() => _okundu = yeni);
    await CuzHatimStore.isaretle(widget.cuzNo, yeni);
    _gosterMesaj(
      yeni
          ? l.t('co.marked').replaceFirst('{cuz}', '${widget.cuzNo}')
          : l.t('co.unmarked').replaceFirst('{cuz}', '${widget.cuzNo}'),
    );
  }

  void _gosterMesaj(String mesaj) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mesaj)));
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).t('co.title').replaceFirst('{cuz}', '${widget.cuzNo}'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: _icerik(),
      bottomNavigationBar: _ayetler == null ? null : _okunduCubugu(),
    );
  }

  Widget _icerik() {
    final l = AppLocalizations.of(context);
    if (_yukleniyor) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_hata != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UcdIkon(ikon: Icons.error_outline_rounded, renk: Colors.white38, boyut: 48),
            const SizedBox(height: 12),
            Text(
              l.t('co.loadError'),
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Renkler.vurgu),
              onPressed: _yukle,
              child: Text(l.t('co.retry')),
            ),
          ],
        ),
      );
    }

    final ayetler = _ayetler!;
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: ayetler.length,
      itemBuilder: (context, index) {
        final onceki = index > 0 ? ayetler[index - 1] : null;
        final ayet = ayetler[index];
        final yeniSure = onceki == null || onceki.sureNo != ayet.sureNo;
        if (!yeniSure) return _ayetKarti(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sureBasligi(ayet),
            const SizedBox(height: 10),
            _ayetKarti(index),
          ],
        );
      },
    );
  }

  Widget _sureBasligi(CuzAyah ayet) {
    final l = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            sureAdiTurkce(ayet.sureNo),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            l.t('co.surah').replaceFirst('{no}', '${ayet.sureNo}'),
            style: TextStyle(color: Renkler.acikVurgu, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _ayetKarti(int index) {
    final l = AppLocalizations.of(context);
    final ayet = _ayetler![index];
    final caliyorMu = _calanIndex == index && _caliyor;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: caliyorMu ? Renkler.seciliYuzey : Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: caliyorMu ? Renkler.vurgu : Renkler.cerceve2,
          width: caliyorMu ? 1.4 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                tooltip: caliyorMu ? l.t('co.stop') : l.t('co.play'),
                onPressed: () => caliyorMu ? _durdur() : _cal(index),
                icon: UcdIkon(
                  ikon: caliyorMu ? Icons.stop_circle_rounded : Icons.play_circle_rounded,
                  renk: Renkler.vurgu,
                  boyut: 26,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Renkler.yuzey,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Renkler.vurgu.withValues(alpha: 0.4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${ayet.ayetNo}',
                  style: TextStyle(
                    color: Renkler.vurgu,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (ayet.secdeAyeti)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    l.t('co.secdeAyeti'),
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              const Spacer(),
              Text(
                l.t('co.page').replaceFirst('{page}', '${ayet.sayfa}'),
                style: const TextStyle(color: Colors.white24, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            ayet.metin,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              height: 1.8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _okunduCubugu() {
    final l = AppLocalizations.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        decoration: BoxDecoration(
          color: Renkler.navBar,
          border: Border(top: BorderSide(color: Renkler.cerceve)),
        ),
        child: FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor:
                _okundu ? Colors.greenAccent.shade400 : Renkler.vurgu,
            foregroundColor: _okundu ? Colors.black : Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 13),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: _okunduDegistir,
          icon: UcdIkon(ikon: _okundu ? Icons.check_circle_rounded : Icons.check_circle_outline_rounded, renk: Colors.black, boyut: 20),
          label: Text(
            _okundu ? l.t('co.readDone') : l.t('co.read'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
