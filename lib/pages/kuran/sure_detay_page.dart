import 'dart:async';
import '../../services/renkler.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/kuran_api.dart';
import '../../services/kuran_verileri.dart';
import '../../services/manevi_store.dart';
import '../../services/muzik_handler.dart';
import '../../services/radyo_oynatici_store.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/kart_sekilleri.dart';
import 'sure_listesi_page.dart';

class SureDetayPage extends StatefulWidget {
  final int? sureNo;
  final int? cuzNo;
  final int? baslangicAyetNo;
  const SureDetayPage({
    super.key,
    this.sureNo,
    this.cuzNo,
    this.baslangicAyetNo,
  });

  @override
  State<SureDetayPage> createState() => _SureDetayPageState();
}

class _SureDetayPageState extends State<SureDetayPage> {
  List<AyetMetni>? _ayetler;
  String? _hata;
  bool _yukleniyor = true;

  int _mealIndex = 0;
  String _kariId = 'ar.abdurrahmaansudais';

  AudioPlayer get _oynatici => RadyoOynaticiStore.player;
  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _ayetAnahtarlari = {};
  StreamSubscription<ProcessingState>? _completionSub;
  StreamSubscription<int?>? _indexSub;
  bool _caliyor = false;
  bool _sureTamamlandi = false;
  int? _calanAyetIndex;
  int _tekrarSayisi = 0; // 0 = yok, 1-3 = adet, -1 = sürekli
  int _tekrarKalan = 0;

  /// Tüm âyetlerin tek seferde yüklendiği kesintisiz kaynak: ayet geçişlerinde
  /// oynatıcı durup yeniden başlamaz, ExoPlayer sıradaki ayeti önceden hazırlar.
  ConcatenatingAudioSource? _concat;
  int? _oncekiConcatanIndex;

  @override
  void initState() {
    super.initState();
    _yukle();
    _ayarlariOku();
    _completionSub = _oynatici.processingStateStream.listen((durum) {
      if (durum == ProcessingState.completed) _listeBitti();
    });
    _indexSub = _oynatici.currentIndexStream.listen((idx) {
      if (idx == null) {
        _oncekiConcatanIndex = null;
        return;
      }
      _indexDegisti(idx);
    });
  }

  Future<void> _ayarlariOku() async {
    final prefs = await SharedPreferences.getInstance();
    final kariId = prefs.getString('kuran_kari_id');
    if (kariId != null && mounted) {
      setState(() => _kariId = kariId);
    }
  }

  Future<void> _yukle() async {
    setState(() {
      _yukleniyor = true;
      _hata = null;
    });
    try {
      final ayetler = await KuranApi.instance.ayetleriGetir(
        sureNo: widget.sureNo,
        cuzNo: widget.cuzNo,
      );
      if (mounted) {
        setState(() {
          _ayetler = ayetler;
          _yukleniyor = false;
        });
        final baslangicAyetNo = widget.baslangicAyetNo;
        if (baslangicAyetNo != null) {
          final index = ayetler.indexWhere(
            (ayet) => ayet.ayetNo == baslangicAyetNo,
          );
          if (index >= 0) _calanAyeteKaydir(index);
        }
      }
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
    _indexSub?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // ---------------- SES ----------------
  Future<void> _cal(int index) async {
    final ayet = _ayetler![index];
    final l = AppLocalizations.of(context);
    try {
      if (_concat == null || _oynatici.processingState == ProcessingState.idle) {
        // Tüm ayetler tek bir kesintisiz kaynakta: ayet geçişlerinde oynatıcı
        // durup yeniden başlamaz, sıradaki ayet önceden hazırlanır.
        _concat ??= ConcatenatingAudioSource(
          children: [
            for (final a in _ayetler!)
              AudioSource.uri(Uri.parse(KuranApi.ayetSesUrl(_kariId, a.globalNo))),
          ],
        );
        await _oynatici.setAudioSource(_concat!);
      }
      await _oynatici.seek(Duration.zero, index: index);
      RadyoOynaticiStore.calanKanal.value = null;
      await _oynatici.play();
      unawaited(
        ManeviStore.sonOkunanAyetKaydet(
          sureNo: ayet.sureNo,
          ayetNo: ayet.ayetNo,
          sureAdi: sureAdiTurkce(ayet.sureNo),
        ),
      );
      if (mounted) {
        setState(() {
          _caliyor = true;
          _calanAyetIndex = index;
          _sureTamamlandi = false;
        });
        _calanAyeteKaydir(index);
      }
      _medyaHaber(index);
    } catch (_) {
      _gosterMesaj(l.t('sd.playError'));
    }
  }

  void _medyaHaber(int index) {
    if (index >= _ayetler!.length) return;
    final ayet = _ayetler![index];
    final url = KuranApi.ayetSesUrl(_kariId, ayet.globalNo);
    MuzikHandler.aktif?.medyaHaber(MediaItem(
      id: url,
      title: '${sureAdiTurkce(ayet.sureNo)} - Ayet ${ayet.ayetNo}',
      artist: _kariId.replaceFirst('ar.', ''),
    ));
  }

  void _indexDegisti(int idx) {
    if (!mounted || _ayetler == null) return;
    // Bir önceki ayete otomatik geçildiğinde tekrar modu uygulanır.
    final onceki = _oncekiConcatanIndex;
    _oncekiConcatanIndex = idx;
    final ileriGecis = onceki != null && idx > onceki;
    if (ileriGecis && _tekrarSayisi == -1) {
      // Sürekli tekrar: aynı ayeti sonsuza dek çal.
      unawaited(_oynatici.seek(Duration.zero, index: idx - 1));
      return;
    }
    if (ileriGecis && _tekrarSayisi > 0 && _tekrarKalan > 0) {
      _tekrarKalan--;
      unawaited(_oynatici.seek(Duration.zero, index: idx - 1));
      return;
    }
    setState(() {
      _caliyor = true;
      _calanAyetIndex = idx;
      _sureTamamlandi = false;
    });
    _calanAyeteKaydir(idx);
    _medyaHaber(idx);
  }

  void _listeBitti() {
    if (!mounted) return;
    setState(() {
      _caliyor = false;
      _calanAyetIndex = null;
      _sureTamamlandi = true;
    });
  }

  Future<void> _sureyiCal() async {
    if (_ayetler == null || _ayetler!.isEmpty) return;
    setState(() {
      _calanAyetIndex = 0;
      _tekrarKalan = _tekrarSayisi > 0 ? _tekrarSayisi - 1 : 0;
      _sureTamamlandi = false;
    });
    await _cal(0);
  }

  Future<void> _durdur() async {
    await _oynatici.stop();
    if (mounted) {
      setState(() {
        _caliyor = false;
        _calanAyetIndex = null;
        _sureTamamlandi = false;
      });
    }
  }

  void _calanAyeteKaydir(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final hedefContext = _ayetAnahtarlari[index]?.currentContext;
      if (hedefContext != null) {
        Scrollable.ensureVisible(
          hedefContext,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
          alignment: 0.18,
        );
      } else if (_scrollController.hasClients && _ayetler!.length > 1) {
        // ListView yalnızca görünür kartları oluşturur. Uzak bir âyete
        // geçildiğinde önce yaklaşık konuma kayarak kartın görünmesini sağlar.
        final oran = index / (_ayetler!.length - 1);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent * oran,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeInOut,
        );
      }
    });
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
    final l = AppLocalizations.of(context);
    final sureNo = widget.sureNo;
    final cuzNo = widget.cuzNo;

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          sureNo != null
              ? '$sureNo. ${sureAdiTurkce(sureNo)}'
              : l.t('sd.juzTitle').replaceFirst('{n}', '$cuzNo'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [_mealMenu(l), SizedBox(width: 4)],
      ),
      body: _icerik(sureNo, cuzNo, l),
    );
  }

  Widget _mealMenu(AppLocalizations l) {
    return PopupMenuButton<int>(
      tooltip: l.t('sd.translation'),
      icon: UcdIkon(ikon: Icons.translate_rounded, renk: Renkler.vurgu),
      color: Renkler.seciliYuzey,
      onSelected: (val) => setState(() => _mealIndex = val),
      itemBuilder: (_) => [
        for (var i = 0; i < mealler.length; i++)
          PopupMenuItem(
            value: i,
            child: Row(
              children: [
                UcdIkon(
                  ikon: i == _mealIndex
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked,
                  renk: i == _mealIndex ? Renkler.vurgu : Colors.white38,
                  boyut: 16,
                ),
                SizedBox(width: 8),
                Text(
                  mealler[i].ad,
                  style: TextStyle(
                    color: i == _mealIndex ? Renkler.vurgu : Colors.white,
                    fontWeight: i == _mealIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _icerik(int? sureNo, int? cuzNo, AppLocalizations l) {
    if (_yukleniyor) {
      return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
    }
    if (_hata != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            UcdIkon(ikon: Icons.wifi_off_rounded, renk: Colors.white38, boyut: 48),
            SizedBox(height: 12),
            Text(
              l.t('sd.loadError'),
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Renkler.vurgu),
              onPressed: _yukle,
              child: Text(l.t('sd.retry')),
            ),
          ],
        ),
      );
    }

    final ayetler = _ayetler!;
    return Column(
      children: [
        // Başlık bilgisi + oynatma çubuğu
        _baslikKart(sureNo, cuzNo, l),
        _oynatmaCubugu(sureNo != null, l),
        _sureBittiKontrolleri(l),
        // Âyet listesi
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: ayetler.length,
            itemBuilder: (context, index) => _ayetKarti(index, l),
          ),
        ),
      ],
    );
  }

  Widget _baslikKart(int? sureNo, int? cuzNo, AppLocalizations l) {
    final ad = sureNo != null
        ? sureAdiTurkce(sureNo)
        : l.t('sd.juzTitle').replaceFirst('{n}', '$cuzNo');
    final anlam = sureNo != null
        ? sureAnlami(sureNo)
        : (cuzNo == 30 ? l.t('sd.ammeJuz') : '');
    final ozet = sureNo != null
        ? sureOzetiMetni(sureNo)
        : cuzBaslangic[cuzNo] ?? '';

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  ad,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (sureNo != null)
                Text(
                  l.t('sd.ayetCount').replaceFirst('{n}', '${_ayetler!.length}'),
                  style: TextStyle(color: Renkler.acikVurgu, fontSize: 12),
                ),
            ],
          ),
          if (anlam.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(
              anlam,
              style: TextStyle(color: Renkler.acikVurgu, fontSize: 12),
            ),
          ],
          if (ozet.isNotEmpty) ...[
            SizedBox(height: 10),
            Text(
              ozet,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _oynatmaCubugu(bool sureModu, AppLocalizations l) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve2),
      ),
      child: Row(
        children: [
          if (sureModu) ...[
            IconButton(
              tooltip: l.t('sd.listenFromStart'),
              onPressed: _caliyor ? _durdur : _sureyiCal,
              icon: UcdIkon(
                ikon: _caliyor && _calanAyetIndex == 0
                    ? Icons.stop_circle
                    : Icons.play_circle,
                renk: Renkler.vurgu,
                boyut: 34,
              ),
            ),
            SizedBox(width: 6),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _caliyor
                      ? l.t('sd.playing').replaceFirst('{n}', '${_calanAyetIndex != null ? _calanAyetIndex! + 1 : ''}')
                      : l.t('sd.tapToListen'),
                  style: TextStyle(
                    color: _caliyor ? Renkler.vurgu : Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${l.t('sd.reciter')}${kariler.where((k) => k.id == _kariId).firstOrNull?.ad ?? ''}',
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ),
          _tekrarMenu(l),
          if (_caliyor)
            IconButton(
              tooltip: l.t('sd.stop'),
              onPressed: _durdur,
              icon: UcdIkon(ikon: Icons.stop_rounded, renk: Colors.white54),
            ),
        ],
      ),
    );
  }

  Widget _sureBittiKontrolleri(AppLocalizations l) {
    if (!_sureTamamlandi) return const SizedBox.shrink();
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.t('sd.sureCompleted'),
            style: TextStyle(
              color: Renkler.vurgu,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _sureyiCal,
                  icon: const UcdIkon(ikon: Icons.replay_rounded, renk: Colors.white),
                  label: Text(l.t('sd.listenStart')),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Renkler.vurgu,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SureListesiPage()),
                  ),
                  icon: const UcdIkon(ikon: Icons.menu_book_rounded, renk: Colors.white),
                  label: Text(l.t('sd.selectSure')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tekrarMenu(AppLocalizations l) {
    final etiketler = {
      0: l.t('sd.repeatOff'),
      1: "1x",
      2: "2x",
      3: "3x",
      -1: l.t('sd.repeatContinuous'),
    };
    return PopupMenuButton<int>(
      tooltip: l.t('sd.repeatMode'),
      color: Renkler.seciliYuzey,
      onSelected: (val) => setState(() => _tekrarSayisi = val),
      itemBuilder: (_) => [
        for (final e in etiketler.entries)
          PopupMenuItem(
            value: e.key,
            child: Row(
              children: [
                UcdIkon(
                  ikon: _tekrarSayisi == e.key
                      ? Icons.check_circle_rounded
                      : Icons.radio_button_unchecked,
                  renk: _tekrarSayisi == e.key
                      ? Renkler.vurgu
                      : Colors.white38,
                  boyut: 16,
                ),
                SizedBox(width: 8),
                Text(
                  e.key == 0 ? e.value : l.t('sd.repeatValue').replaceFirst('{v}', e.value),
                  style: TextStyle(
                    color: _tekrarSayisi == e.key
                        ? Renkler.vurgu
                        : Colors.white,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            UcdIkon(ikon: Icons.repeat, renk: Colors.white54, boyut: 18),
            if (_tekrarSayisi != 0) ...[
              SizedBox(width: 4),
              Text(
                etiketler[_tekrarSayisi]!,
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _ayetKarti(int index, AppLocalizations l) {
    final ayet = _ayetler![index];
    final caliyorMu = _calanAyetIndex == index && _caliyor;

    return Container(
      key: _ayetAnahtarlari.putIfAbsent(index, GlobalKey.new),
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: caliyorMu ? Renkler.seciliYuzey : Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: caliyorMu ? Renkler.vurgu : Color(0xFF262626),
          width: caliyorMu ? 1.4 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
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
              SizedBox(width: 8),
              if (ayet.secdeAyeti)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    l.t('sd.secdeAyeti'),
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Spacer(),
              if (caliyorMu) ...[
                UcdIkon(ikon: Icons.graphic_eq, renk: Renkler.vurgu, boyut: 16),
                SizedBox(width: 6),
              ],
              Text(
                l.t('sd.juzPage')
                    .replaceFirst('{j}', '${ayet.cuz}')
                    .replaceFirst('{p}', '${ayet.sayfa}'),
                style: TextStyle(color: Colors.white24, fontSize: 9),
              ),
            ],
          ),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (caliyorMu) {
                _durdur();
              } else {
                _tekrarKalan = _tekrarSayisi > 0 ? _tekrarSayisi - 1 : 0;
                _cal(index);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ayet.arapca,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (ayet.okunus.isNotEmpty) ...[
                  SizedBox(height: 10),
                  Text(
                    ayet.okunus,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    ),
                  ),
                ],
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Renkler.kart,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Renkler.cerceve),
                  ),
                  child: Text(
                    ayet.meal,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.5,
                    ),
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
