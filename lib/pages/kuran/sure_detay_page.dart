import 'dart:async';
import '../../services/renkler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/kuran_api.dart';
import '../../services/kuran_verileri.dart';
import '../../services/manevi_store.dart';

class SureDetayPage extends StatefulWidget {
  final int? sureNo;
  final int? cuzNo;
  const SureDetayPage({super.key, this.sureNo, this.cuzNo});

  @override
  State<SureDetayPage> createState() => _SureDetayPageState();
}

class _SureDetayPageState extends State<SureDetayPage> {
  List<AyetMetni>? _ayetler;
  String? _hata;
  bool _yukleniyor = true;

  int _mealIndex = 0;
  String _kariId = 'ar.abdurrahmaansudais';

  final AudioPlayer _player = AudioPlayer();
  StreamSubscription? _completionSub;
  bool _caliyor = false;
  int? _calanAyetIndex;
  int _tekrarSayisi = 0; // 0 = yok, 1-3 = adet, -1 = sürekli
  int _tekrarKalan = 0;

  @override
  void initState() {
    super.initState();
    _yukle();
    _ayarlariOku();
    _completionSub = _player.onPlayerComplete.listen((_) => _ayetBitti());
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
        if (ayetler.isNotEmpty) {
          ManeviStore.sonOkunanAyetKaydet(
            '${sureAdiTurkce(ayetler.first.sureNo)} ${ayetler.first.ayetNo}',
          );
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
    _player.dispose();
    super.dispose();
  }

  // ---------------- SES ----------------
  Future<void> _ayetBitti() async {
    if (!mounted || _ayetler == null) return;
    final idx = _calanAyetIndex;
    if (idx == null) {
      setState(() => _caliyor = false);
      return;
    }
    if (_tekrarSayisi != 0 && _tekrarKalan > 0) {
      // Aynı âyeti tekrar çal
      setState(() => _tekrarKalan--);
      await _cal(idx);
      return;
    }
    final sonraki = idx + 1;
    if (sonraki < _ayetler!.length) {
      setState(() {
        _calanAyetIndex = sonraki;
        _tekrarKalan = _tekrarSayisi > 0 ? _tekrarSayisi - 1 : 0;
      });
      await _cal(sonraki);
    } else {
      setState(() {
        _caliyor = false;
        _calanAyetIndex = null;
      });
    }
  }

  Future<void> _cal(int index) async {
    final ayet = _ayetler![index];
    final url = KuranApi.ayetSesUrl(_kariId, ayet.globalNo);
    try {
      await _player.stop();
      await _player.setSource(UrlSource(url));
      await _player.resume();
      if (mounted) {
        setState(() {
          _caliyor = true;
          _calanAyetIndex = index;
        });
      }
    } catch (_) {
      _gosterMesaj("Ses çalınamadı. İnternet bağlantınızı kontrol edin.");
    }
  }

  Future<void> _sureyiCal() async {
    if (_ayetler == null || _ayetler!.isEmpty) return;
    setState(() {
      _calanAyetIndex = 0;
      _tekrarKalan = _tekrarSayisi > 0 ? _tekrarSayisi - 1 : 0;
    });
    await _cal(0);
  }

  Future<void> _durdur() async {
    await _player.stop();
    if (mounted) {
      setState(() {
        _caliyor = false;
        _calanAyetIndex = null;
      });
    }
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
    final sureNo = widget.sureNo;
    final cuzNo = widget.cuzNo;

    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          sureNo != null
              ? '$sureNo. ${sureAdiTurkce(sureNo)}'
              : '$cuzNo. Cüz',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          _mealMenu(),
          SizedBox(width: 4),
        ],
      ),
      body: _icerik(sureNo, cuzNo),
    );
  }

  Widget _mealMenu() {
    return PopupMenuButton<int>(
      tooltip: "Meâl Seçimi",
      icon: Icon(Icons.translate, color: Renkler.vurgu),
      color: Renkler.seciliYuzey,
      onSelected: (val) => setState(() => _mealIndex = val),
      itemBuilder: (_) => [
        for (var i = 0; i < mealler.length; i++)
          PopupMenuItem(
            value: i,
            child: Row(
              children: [
                Icon(
                  i == _mealIndex ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: i == _mealIndex ? Renkler.vurgu : Colors.white38,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  mealler[i].ad,
                  style: TextStyle(
                    color: i == _mealIndex ? Renkler.vurgu : Colors.white,
                    fontWeight: i == _mealIndex ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _icerik(int? sureNo, int? cuzNo) {
    if (_yukleniyor) {
      return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
    }
    if (_hata != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, color: Colors.white38, size: 48),
            SizedBox(height: 12),
            Text(
              "Âyetler alınamadı. İnternet bağlantınızı kontrol edin.",
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Renkler.vurgu),
              onPressed: _yukle,
              child: Text("Tekrar Dene"),
            ),
          ],
        ),
      );
    }

    final ayetler = _ayetler!;
    return Column(
      children: [
        // Başlık bilgisi + oynatma çubuğu
        _baslikKart(sureNo, cuzNo),
        _oynatmaCubugu(sureNo != null),
        // Âyet listesi
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
            itemCount: ayetler.length,
            itemBuilder: (context, index) => _ayetKarti(index),
          ),
        ),
      ],
    );
  }

  Widget _baslikKart(int? sureNo, int? cuzNo) {
    final ad = sureNo != null ? sureAdiTurkce(sureNo) : '$cuzNo. Cüz';
    final anlam = sureNo != null ? sureAnlami(sureNo) : (cuzNo == 30 ? 'Amme Cüzü' : '');
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
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (sureNo != null)
                Text(
                  '${_ayetler!.length} âyet',
                  style: TextStyle(color: Renkler.acikVurgu, fontSize: 12),
                ),
            ],
          ),
          if (anlam.isNotEmpty) ...[
            SizedBox(height: 4),
            Text(anlam, style: TextStyle(color: Renkler.acikVurgu, fontSize: 12)),
          ],
          if (ozet.isNotEmpty) ...[
            SizedBox(height: 10),
            Text(
              ozet,
              style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
            ),
          ],
        ],
      ),
    );
  }

  Widget _oynatmaCubugu(bool sureModu) {
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
              tooltip: "Surenin başından dinle",
              onPressed: _caliyor ? _durdur : _sureyiCal,
              icon: Icon(
                _caliyor && _calanAyetIndex == 0 ? Icons.stop_circle : Icons.play_circle,
                color: Renkler.vurgu,
                size: 34,
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
                      ? 'Çalıyor: ${_calanAyetIndex != null ? _calanAyetIndex! + 1 : ''}. âyet'
                      : 'Dinlemek için âyete dokunun',
                  style: TextStyle(
                    color: _caliyor ? Renkler.vurgu : Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Kârî: ${kariler.where((k) => k.id == _kariId).firstOrNull?.ad ?? ''}',
                  style: TextStyle(color: Colors.white38, fontSize: 10),
                ),
              ],
            ),
          ),
          _tekrarMenu(),
          if (_caliyor)
            IconButton(
              tooltip: "Durdur",
              onPressed: _durdur,
              icon: Icon(Icons.stop, color: Colors.white54),
            ),
        ],
      ),
    );
  }

  Widget _tekrarMenu() {
    final etiketler = {
      0: "Tekrar: Kapalı",
      1: "1x",
      2: "2x",
      3: "3x",
      -1: "Sürekli",
    };
    return PopupMenuButton<int>(
      tooltip: "Tekrar Modu",
      color: Renkler.seciliYuzey,
      onSelected: (val) => setState(() => _tekrarSayisi = val),
      itemBuilder: (_) => [
        for (final e in etiketler.entries)
          PopupMenuItem(
            value: e.key,
            child: Row(
              children: [
                Icon(
                  _tekrarSayisi == e.key ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: _tekrarSayisi == e.key ? Renkler.vurgu : Colors.white38,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  e.key == 0 ? e.value : 'Tekrar: ${e.value}',
                  style: TextStyle(
                    color: _tekrarSayisi == e.key ? Renkler.vurgu : Colors.white,
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
            Icon(Icons.repeat, color: Colors.white54, size: 18),
            if (_tekrarSayisi != 0) ...[
              SizedBox(width: 4),
              Text(
                etiketler[_tekrarSayisi]!,
                style: TextStyle(color: Renkler.vurgu, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _ayetKarti(int index) {
    final ayet = _ayetler![index];
    final caliyorMu = _calanAyetIndex == index && _caliyor;

    return Container(
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
                  border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.4)),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${ayet.ayetNo}',
                  style: TextStyle(color: Renkler.vurgu, fontSize: 11, fontWeight: FontWeight.bold),
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
                    "Secde Âyeti",
                    style: TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
              Spacer(),
              if (caliyorMu) ...[
                Icon(Icons.graphic_eq, color: Renkler.vurgu, size: 16),
                SizedBox(width: 6),
              ],
              Text(
                'Cüz ${ayet.cuz} • Sf ${ayet.sayfa}',
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
                    style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
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
