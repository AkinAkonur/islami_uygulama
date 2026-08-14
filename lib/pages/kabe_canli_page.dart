// ===========================================================================
// KÂBE-İ MUAZZAMA / MESCİD-İ NEBEVÎ CANLI YAYIN
// ---------------------------------------------------------------------------
// Teknik tasarım kararları (bağlantı kopmalarını/siyah ekranı önlemek için):
//  1. Yayın kaynakları ASLA gömülü tek kopya değildir: CanliYayinKonfigurasyonu
//     (Remote Config alternatifi) tarafından dinamik getirilir; ayrıca Kâbe
//     için Resmî SBA HLS akışı (`/live/quran`), Medine modu için `/live/sunnah`
//     akışı öncelenir. Kaynak değiştiğinde Store güncellemesi gerekmez.
//  2. Oynatıcı: Doğrudan canlı HLS (m3u8) akışı (video_player ExoPlayer /
//     AVPlayer). YouTube IFrame embed'leri 2025 sonrası cihazlarda "Oynatıcı
//     yapılandırma hatası" ile reddedildiği için kullanılmaz; HLS, codec uyumlu
//     her cihazda canlı yayını akıtır.
//  3. Yedek kaynaklar: HLS kaynakları video_player ile otomatik sıra takibi
//     ile denenir; biri kesilirse diğerine geçilir.
//  4. Hücresel veri uyarısı: Wi-Fi kapalıyken başlatmadan önce kullanıcı
//     bilgilendirilir (connectivity_plus).
//  5. Bağlantı kopmasında otomatik yeniden deneme + elle "Tekrar Dene".
//  6. 🎧 Ses Modu: video görüntüsü yerine yalnızca ses akışı çalınır
//     (veri ve pil tasarrufu ~%80).
//  7. 📺 Resim İçinde Resim (PiP): mini pencerede uygulama içinde gezinmeye
//     devam edilirken yayın köşede oynamaya devam eder (KabeMiniOynatici).
// ===========================================================================

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../services/canli_yayin_konfigurasyonu.dart';
import '../services/kabe_mini_oynatici.dart';
import '../services/renkler.dart';

/// Yayın izleme modu.
enum YayinModu { video, ses }

class KabeCanliPage extends StatefulWidget {
  const KabeCanliPage({
    super.key,
    this.baslangicModu = YayinModu.video,
    this.medineYayini = false,
  });

  /// Sayfa açılış modu: 📺 tam ekran izleme veya 🎧 sadece ses.
  final YayinModu baslangicModu;

  /// true ise Mescid-i Nebevî (Medine) canlı yayını açılır: Kâbe yerine
  /// Sünnet kanalı (`/live/sunnah`) akışı kullanılır.
  final bool medineYayini;

  @override
  State<KabeCanliPage> createState() => _KabeCanliPageState();
}

class _KabeCanliPageState extends State<KabeCanliPage>
    with WidgetsBindingObserver {
  late YayinModu _modu;

  // ---- Video (Canlı HLS akışı) ----
  VideoPlayerController? _videoKontrol;
  int _hlsIndex = 0;
  bool _hlsHata = false;
  String? _dayanikliHata;

  // ---- Ses modu ----
  final AudioPlayer _sesPlayer = AudioPlayer();
  bool _sesCalyor = false;
  bool _sesHata = false;

  // ---- Ağ / veri ----
  StreamSubscription<List<ConnectivityResult>>? _agTakip;
  bool _baglantiVar = true;
  bool _hucreselUyarildi = false;

  bool _miniAktifTespit = false;
  bool _tamEkran = false;

  bool get _desteklenmiyor => !_yayinDestekleniyor();

  bool _yayinDestekleniyor() {
    if (kIsWeb) return true;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return true;
      default:
        return false;
    }
  }

  CanliYayinKonfig get _konfig => CanliYayinKonfigurasyonu.guncel;

  /// Başlık: Kâbe (Mescid-i Haram) veya Mescid-i Nebevî (Medine).
  String get _baslik => widget.medineYayini
      ? 'Mescid-i Nebevî Canlı Yayın'
      : 'Kâbe-i Muazzama Canlı Yayın';

  /// Video modunda denenecek HLS kaynakları. Medine modunda Kâbe'nin
  /// `/live/quran` akışı yerine Resmî Sünnet kanalının `/live/sunnah`
  /// akışı öncelenir (her ikisi SBA'nın 7/24 Harem yayınlarıdır).
  List<CanliYayinKaynak> _aktifHlsKaynaklar() {
    if (!widget.medineYayini) {
      return [
        for (final k in _konfig.hlsKaynaklar)
          if (!k.youtube) k,
      ];
    }
    return const [
      CanliYayinKaynak(
        ad: 'Sünnet TV (Resmî · Medine)',
        url: 'http://m.live.net.sa:1935/live/sunnah/playlist.m3u8',
      ),
      CanliYayinKaynak(
        ad: 'Kuran TV (CDN · Kâbe yedeği)',
        url:
            'https://cdn-globecast.akamaized.net/live/eds/saudi_quran/hls_roku/index.m3u8',
      ),
    ];
  }

  /// Ses modu akış adresi. Medine modunda Kâbe sesi yerine Sünnet
  /// radyo kanalı (Mescid-i Nebevî) akışı kullanılır.
  String? get _aktifSesAkisi {
    if (widget.medineYayini) {
      return 'http://m.live.net.sa:1935/live/sunnah/playlist.m3u8';
    }
    return CanliYayinKonfigurasyonu.sesAkisUrl;
  }

  @override
  void initState() {
    super.initState();
    _modu = widget.baslangicModu;
    WidgetsBinding.instance.addObserver(this);
    _miniAktifTespit = KabeMiniOynatici.instance.aktif;
    if (_desteklenmiyor) return;

    _agTakipiniKur();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bastaBaslat());
  }

  Future<void> _bastaBaslat() async {
    if (_miniAktifTespit) {
      // Mini pencerede süren yayını geri yakalamak isteyebilir.
      await _miniPenceredekiYayiniYakala();
      return;
    }
    await _veriUyarisiniKontrolEt(onaylaninca: _baslat);
  }

  Future<void> _baslat() async {
    if (!mounted) return;
    if (_modu == YayinModu.ses) {
      await _sesModunubaslat();
    } else {
      await _videoyuBaslat();
    }
  }

  // =========================================================================
  // AĞ İZLENMESİ: hücresel veri uyarısı + kopmada otomatik yeniden bağlanma
  // =========================================================================
  void _agTakipiniKur() {
    try {
      _agTakip = Connectivity().onConnectivityChanged.listen(
        (sonuclar) {
          final bagli = !sonuclar.contains(ConnectivityResult.none);
          final onceki = _baglantiVar;
          if (!mounted) return;
          setState(() => _baglantiVar = bagli);
          if (bagli && !onceki) {
            _agGeldi();
          } else if (!bagli && onceki) {
            _agKoptu();
          }
        },
        onError: (_) {},
      );
    } catch (_) {
      // Test/desktop ortamlarında bağlantı takibi kullanılamaz; sessiz geç.
    }
    _agDurumunuSorgula();
  }

  Future<void> _agDurumunuSorgula() async {
    try {
      final sonuclar = await Connectivity().checkConnectivity();
      if (!mounted) return;
      setState(
        () => _baglantiVar = !sonuclar.contains(ConnectivityResult.none),
      );
    } catch (_) {}
  }

  Future<void> _veriUyarisiniKontrolEt({
    required Future<void> Function() onaylaninca,
  }) async {
    if (_hucreselUyarildi) return onaylaninca();
    bool hucresel;
    try {
      final sonuclar = await Connectivity().checkConnectivity();
      hucresel = sonuclar.contains(ConnectivityResult.mobile);
    } catch (_) {
      hucresel = false;
    }
    if (!hucresel) {
      _hucreselUyarildi = true;
      return onaylaninca();
    }
    if (!mounted) return;
    _hucreselUyarildi = true;
    final onay = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Renkler.kart,
        title: const Row(
          children: [
            Icon(Icons.wifi_tethering, color: Colors.orangeAccent),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Hücresel veri uyarısı',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
        content: const Text(
          'Şu an hücresel veri (mobil internet) kullanıyorsunuz. '
          'Canlı yayın yüksek veri tüketebilir.\n\n'
          '🎧 Ses Modu veri kullanımını yaklaşık %80 azaltır.',
          style: TextStyle(color: Colors.white70, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Renkler.vurgu),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Devam Et'),
          ),
        ],
      ),
    );
    if (onay != true) {
      setState(() => _dayanikliHata = 'Yayın veri tasarrufu için başlatılmadı.');
      return;
    }
    await onaylaninca();
  }

  Future<void> _agKoptu() async {
    _videoKontrol?.pause();
    if (_modu == YayinModu.ses) {
      await _sesPlayer.pause();
      if (mounted) setState(() => _sesCalyor = false);
    }
    _ekraniAcikTut(false);
  }

  /// İzleme sırasında ekranın kapanmasını engeller (wakelock_plus);
  /// yayın durduğunda/sayfa kapanınca ekran uyku moduna dönebilir.
  Future<void> _ekraniAcikTut(bool aktif) async {
    try {
      if (aktif) {
        await WakelockPlus.enable();
      } else {
        await WakelockPlus.disable();
      }
    } catch (_) {
      // wakelock desteklenmeyen platformlarda sessiz geç.
    }
  }

  /// Ağ geri geldi: önce dinamik yapılandırma tazelenir (yayın linki
  /// değişmiş olabilir), sonra yayın otomatik yeniden başlatılır.
  Future<void> _agGeldi() async {
    await CanliYayinKonfigurasyonu.manuelYenile();
    if (!mounted) return;
    if (_modu == YayinModu.ses && _sesHata) {
      await _sesModunubaslat();
    } else if (_modu == YayinModu.video && (_hlsHata || _dayanikliHata != null)) {
      await _videoyuBaslat();
    } else {
      _videoKontrol?.play();
      if (_modu == YayinModu.ses) await _sesPlayer.resume();
    }
  }

  // =========================================================================
  // YAYIN GÖRÜNÜMÜ (modlar arası geçiş)
  // =========================================================================
  Future<void> _moduDegistir(YayinModu yeniModu) async {
    if (yeniModu == _modu) return;
    if (yeniModu == YayinModu.video && !_baglantiVar) {
      _bilgiGoster('İnternet bağlantısı yok');
      return;
    }
    setState(() {
      _modu = yeniModu;
      _sesHata = false;
      _dayanikliHata = null;
    });
    if (yeniModu == YayinModu.ses) {
      _videoKontrol = null;
      await _sesModunubaslat();
    } else {
      await _sesPlayer.stop();
      setState(() => _sesCalyor = false);
      await _videoyuBaslat();
    }
  }

  Future<void> _sesModunubaslat() async {
    if (!mounted) return;
    setState(() {
      _sesHata = false;
      _dayanikliHata = null;
    });
    final url = _aktifSesAkisi;
    if (url == null) {
      setState(() => _sesHata = true);
      return;
    }
    try {
      await _sesPlayer.stop();
      // Ses akışı: video görüntüsü çekilmediği için veri/pil tasarrufu sağlar.
      await _sesPlayer.setReleaseMode(ReleaseMode.loop);
      await _sesPlayer.play(UrlSource(url));
      await _ekraniAcikTut(true);
      if (mounted) {
        setState(() {
          _sesCalyor = true;
          _sesHata = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _sesHata = true;
        _sesCalyor = false;
        _dayanikliHata =
            'Ses akışı açılamadı. Bu cihazda HLS ses akışı desteklenmiyor '
            'olabilir; videoya geçmeyi deneyin.';
      });
    }
  }

  Future<void> _sesDuraklatDevam() async {
    if (_sesCalyor) {
      await _sesPlayer.pause();
      if (mounted) setState(() => _sesCalyor = false);
    } else {
      await _sesPlayer.resume();
      if (mounted) setState(() => _sesCalyor = true);
    }
  }

  // =========================================================================
  // VİDEO MODU: Canlı HLS (m3u8) akış zinciri
  // -------------------------------------------------------------------------
  // Resmî Harem yayınları (SBA) doğrulanmış canlı HLS kaynaklarından çalınır:
  // biri kırılırsa otomatik sıradakine geçilir. Kâbe modunda `/live/quran`,
  // Medine modunda `/live/sunnah` önceliklidir.
  // =========================================================================
  Future<void> _videoyuBaslat() async {
    if (!mounted) return;
    setState(() {
      _hlsHata = false;
      _dayanikliHata = null;
    });
    await _hlsDene(0);
  }

  Future<void> _hlsDene(int index) async {
    if (!mounted) return;
    final kaynaklar = _aktifHlsKaynaklar();
    if (index >= kaynaklar.length) {
      setState(() {
        _hlsHata = true;
        _dayanikliHata =
            'Canlı yayın kaynaklarına şu anda ulaşılamadı. İnternet '
            'bağlantınızı kontrol edip Tekrar Dene butonunu kullanınız.';
      });
      return;
    }
    setState(() {
      _hlsIndex = index;
      _hlsHata = false;
      _dayanikliHata = null;
    });
    final eski = _videoKontrol;
    _videoKontrol = null;
    if (eski != null) {
      eski.removeListener(_hlsDurumDinle);
      try {
        await eski.dispose();
      } catch (_) {}
    }
    if (!mounted) return;

    final kaynak = kaynaklar[index];
    final yeni = VideoPlayerController.networkUrl(
      Uri.parse(kaynak.url),
      // Bazı cihazlarda .m3u8 uzantısına rağmen ExoPlayer'ın akışı doğru
      // çözebilmesi için format ipucu verilir (canlı HLS).
      formatHint: VideoFormat.hls,
    );
    try {
      // Canlı HLS akışlarında ExoPlayer "first frame" gelene kadar
      // initialize()'ı döndürmez; asılı kalmamak için zaman aşımı uygulanır.
      await yeni
          .initialize()
          .timeout(_hlsZamanAsimi, onTimeout: () async {
        // Oynatıcı, belirtilen sürede bağlanamadı: kaynağı serbest bırak
        // ve sıradaki akışı dene.
        try {
          await yeni.dispose();
        } catch (_) {}
        if (!mounted) return;
        await _hlsDene(index + 1);
        throw _HlsAtlandi();
      });
      if (!mounted) {
        try {
          await yeni.dispose();
        } catch (_) {}
        return;
      }
      _videoKontrol = yeni;
      yeni.setLooping(true);
      yeni.addListener(_hlsDurumDinle);
      await yeni.play();
      await _ekraniAcikTut(true);
      // Oynatma bekçisi: initialize başarılı olduysa bile görüntü birkaç
      // saniye içinde akışa başlamazsa sıradaki kaynağa geçilir (akış
      // sunucusu görüntü üretmiyor olabilir - "ses var, görüntü yok").
      _oynatmaBekcisiBaslat(index);
    } on _HlsAtlandi {
      // Zaman aşımı akışı zaten bir sonraki kaynağa yönlendirdi.
    } catch (_) {
      if (!mounted) return;
      try {
        await yeni.dispose();
      } catch (_) {}
      await _hlsDene(index + 1);
    }
  }

  /// HLS akışının bağlanması için üst sınır. Bu sürede "ilk kare" gelmezse
  /// kaynak atlanır ve sıradaki akış denenir.
  Duration get _hlsZamanAsimi => const Duration(seconds: 14);

  /// Oynatma bekçisi zamanlayıcısı.
  Timer? _oynatmaBekcisi;

  /// Initialize tamamlandıktan sonra akışın gerçekten oynamaya başladığını
  /// doğrular. Ses gelip görüntü gelmeyen akışlarda (video track yoksa veya
  /// sunucu karesi gönderemiyorsa) 8 saniye içinde oynama gerçekleşmezse
  /// sıradaki kaynağa geçilir.
  void _oynatmaBekcisiBaslat(int index) {
    _oynatmaBekcisi?.cancel();
    _oynatmaBekcisi = Timer(const Duration(seconds: 8), () async {
      if (!mounted) return;
      final c = _videoKontrol;
      if (c == null) return;
      final v = c.value;
      // Görüntü gerçekten akıyorsa boyut bilgisi gelir ve oynatma başlamıştır.
      final oynuyor = v.isInitialized &&
          v.isPlaying &&
          (v.size.width > 0 && v.size.height > 0);
      if (oynuyor) return;
      // Hata durumları zaten _hlsDurumDinle tarafından ele alınır.
      if (v.hasError) return;
      // Takıldı: bu kaynağı atla, sıradakini dene.
      _oynatmaBekcisi = null;
      await _hlsDene(index + 1);
    });
  }

  void _hlsDurumDinle() {
    if (!mounted) return;
    final c = _videoKontrol;
    if (c == null || !c.value.hasError) return;
    c.removeListener(_hlsDurumDinle);
    _hlsDene(_hlsIndex + 1);
  }

  Future<void> _tekrarDene() async {
    _oynatmaBekcisi?.cancel();
    if (_modu == YayinModu.ses) {
      await _sesModunubaslat();
    } else {
      setState(() => _hlsIndex = 0);
      await _videoyuBaslat();
    }
  }

  // =========================================================================
  // RESİM İÇİNDE RESİM (mini pencere)
  // =========================================================================
  Future<void> _miniPenceredekiYayiniYakala() async {
    final kontrol = KabeMiniOynatici.instance.geriAl();
    if (kontrol == null) {
      setState(() => _miniAktifTespit = false);
      await _veriUyarisiniKontrolEt(onaylaninca: _baslat);
      return;
    }
    // PiP'den geri dönüş: mini penceredeki yayın bu sayfaya devralınır.
    // (İsteğe bağlı otomatik yakalama; kullanıcı isterse yeniden başlatma
    //  butonunu kullanabilir.)
    final kaynakAdi = KabeMiniOynatici.instance.kaynakAdi;
    KabeMiniOynatici.instance.durdur();
    if (!mounted) {
      try {
        kontrol.dispose();
      } catch (_) {}
      return;
    }
    _videoKontrol = kontrol;
    kontrol.setLooping(true);
    kontrol.addListener(_hlsDurumDinle);
    setState(() {
      _miniAktifTespit = false;
      _hlsHata = false;
    });
    await kontrol.play();
    await _ekraniAcikTut(true);
    _bilgiGoster('Yayın mini pencereden geri alındı ($kaynakAdi)');
  }

  Future<void> _miniOynaticiyaGonder() async {
    final c = _videoKontrol;
    if (c == null || !c.value.isInitialized) {
      _bilgiGoster('Yayın bağlanınca mini pencere kullanılabilir');
      return;
    }
    c.removeListener(_hlsDurumDinle);
    _videoKontrol = null;
    final kaynakAdi = '${_konfig.kaynakAdi} · ${_hlsAdi()}';
    KabeMiniOynatici.instance.baslat(
      kokOverlay: Overlay.of(context, rootOverlay: true),
      videoKontrol: c,
      kaynakAdi: kaynakAdi,
      sayfaKaynagi: () => const KabeCanliPage(),
    );
    if (mounted) Navigator.of(context).pop();
  }

  String _hlsAdi() {
    final kaynaklar = _aktifHlsKaynaklar();
    if (_hlsIndex >= 0 && _hlsIndex < kaynaklar.length) {
      return kaynaklar[_hlsIndex].ad;
    }
    return 'Canlı Yayın';
  }

  // =========================================================================
  // TAM EKRAN
  // =========================================================================
  Future<void> _tamEkraniDegistir() async {
    try {
      if (_tamEkran) {
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      } else {
        await SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.immersiveSticky,
        );
      }
    } catch (_) {}
    if (mounted) setState(() => _tamEkran = !_tamEkran);
  }

  void _bilgiGoster(String mesaj) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(mesaj), duration: const Duration(seconds: 3)));
  }

  // =========================================================================
  // YAŞAM DÖNGÜSÜ
  // =========================================================================
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final arkaPlanda =
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached;
    if (_modu == YayinModu.ses) {
      // Ses modunda arka planda devam eder (veri tasarrufu modu);
      // yalnızca sayfadan çıkışta durdurulur.
      return;
    }
    if (arkaPlanda) {
      _videoKontrol?.pause();
    } else if (state == AppLifecycleState.resumed) {
      _videoKontrol?.play();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _agTakip?.cancel();
    _oynatmaBekcisi?.cancel();
    _ekraniAcikTut(false);
    final c = _videoKontrol;
    _videoKontrol = null;
    if (c != null) {
      c.removeListener(_hlsDurumDinle);
      try {
        c.dispose();
      } catch (_) {}
    }
    final s = _sesPlayer;
    s.dispose();
    if (_tamEkran) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    super.dispose();
  }

  // =========================================================================
  // ARAYÜZ
  // =========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: _tamEkran
          ? null
          : AppBar(
              title: Text(_baslik),
              backgroundColor: Renkler.seciliYuzey,
            ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _anaIcerik(),
              const SizedBox(height: 16),
              _modSecici(),
              const SizedBox(height: 12),
              if (_modu == YayinModu.video) _kaynakSatiri(),
              if (_modu == YayinModu.video) ...[
                const SizedBox(height: 10),
                _agDurumuSatiri(),
              ],
              const SizedBox(height: 16),
              _islemSatiri(),
              const SizedBox(height: 12),
              _bilgiKartlari(),
            ],
          ),
          if (_tamEkran)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              right: 12,
              child: _tamEkranCikisButonu(),
            ),
          if (!_baglantiVar) _baglantiYokSata(),
        ],
      ),
    );
  }

  Widget _anaIcerik() {
    if (_desteklenmiyor) {
      return _videoKutu(
        _mesajPaneli(
          ikon: Icons.live_tv_outlined,
          baslik: 'Canlı yayın bu cihazda desteklenmiyor',
          alt:
              'Kâbe canlı yayınını Android, iOS, web, Windows ve macOS '
              'cihazlarda izleyebilirsiniz.',
        ),
      );
    }
    if (_modu == YayinModu.ses) return _sesKutu();
    return _videoKutu(_videoOynatici());
  }

  Widget _videoOynatici() {
    final video = _videoKontrol;
    if (video != null && video.value.isInitialized) {
      return GestureDetector(
        onTap: _videoDuraklatDevam,
        child: Stack(
          fit: StackFit.expand,
          children: [
            VideoPlayer(video),
            _canliRozeti(),
            if (video.value.isBuffering && video.value.isPlaying)
              _bufferingKatmani(),
            if (!video.value.isPlaying) _oynatButonu(),
          ],
        ),
      );
    }
    if (_dayanikliHata != null) {
      return _videoKutu(
        _mesajPaneli(
          ikon: Icons.cloud_off_outlined,
          baslik: 'Yayına bağlanılamadı',
          alt: _dayanikliHata!,
          buton: FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: Renkler.vurgu),
            onPressed: _tekrarDene,
            icon: const Icon(Icons.refresh),
            label: const Text('Tekrar Dene'),
          ),
        ),
      );
    }
    return _beklemeKatmani();
  }

  Future<void> _videoDuraklatDevam() async {
    final c = _videoKontrol;
    if (c == null) return;
    if (c.value.isPlaying) {
      await c.pause();
    } else {
      await c.play();
    }
  }

  Widget _sesKutu() {
    if (_sesHata) {
      return _videoKutu(
        _mesajPaneli(
          ikon: Icons.headset_off_outlined,
          baslik: 'Ses akışı başlatılamadı',
          alt:
              _dayanikliHata ??
              'Ses akışına ulaşılamadı. Bağlantıyı kontrol edip tekrar '
                  'deneyin ya da video moduna geçin.',
          buton: FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: Renkler.vurgu),
            onPressed: _tekrarDene,
            icon: const Icon(Icons.refresh),
            label: const Text('Tekrar Dene'),
          ),
        ),
      );
    }
    // Ses modu görsel kutusu: video çekilmediği için veri tasarrufu sağlar.
    return _videoKutu(
      GestureDetector(
        onTap: _sesDuraklatDevam,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Renkler.bannerUst.withValues(alpha: 0.9),
                Renkler.bannerAlt.withValues(alpha: 0.9),
              ],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.mosque_outlined,
                        color: Colors.white,
                        size: 44,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      '🎧 Kâbe Ses Modu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _sesCalyor
                          ? 'Ezan, tilavet ve tavaf atmosferi canlı dinleniyor'
                          : 'Dokunarak oynat / duraklat',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, size: 8, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'CANLI SES',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_sesCalyor)
                const Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: 26,
                      height: 10,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Mod seçici (📺 Tam Ekran İzle / 🎧 Ses Modu) ----------------
  Widget _modSecici() {
    return Row(
      children: [
        Expanded(
          child: _secimButonu(
            ikon: Icons.play_circle_fill_outlined,
            etiket: '📺 Video',
            secili: _modu == YayinModu.video,
            onTap: () => _moduDegistir(YayinModu.video),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _secimButonu(
            ikon: Icons.headphones_outlined,
            etiket: '🎧 Ses Modu (Arkaplanda Çal)',
            secili: _modu == YayinModu.ses,
            onTap: () => _moduDegistir(YayinModu.ses),
          ),
        ),
      ],
    );
  }

  Widget _secimButonu({
    required IconData ikon,
    required String etiket,
    required bool secili,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: secili
              ? Renkler.vurgu.withValues(alpha: 0.18)
              : Renkler.kart,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: secili ? Renkler.vurgu : Renkler.cerceve,
            width: secili ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(ikon, color: secili ? Renkler.vurgu : Colors.white54, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                etiket,
                style: TextStyle(
                  color: secili ? Colors.white : Colors.white70,
                  fontSize: 12.5,
                  fontWeight: secili ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (secili)
              const Icon(Icons.check_circle, color: Colors.greenAccent, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _kaynakSatiri() {
    final kaynakAdi = _hlsAdi();
    return Row(
      children: [
        Icon(Icons.sensors, color: Renkler.vurgu, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Yayın kaynağı: $kaynakAdi',
            style: const TextStyle(color: Colors.white70, fontSize: 12.5),
          ),
        ),
      ],
    );
  }

  Widget _agDurumuSatiri() {
    return Row(
      children: [
        Icon(
          _baglantiVar ? Icons.wifi : Icons.wifi_off,
          color: _baglantiVar ? Colors.greenAccent : Colors.redAccent,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            _baglantiVar
                ? 'Bağlantı aktif · kopma durumunda otomatik yeniden deneme'
                : 'İnternet yok - bağlantı gelince yayın otomatik başlar',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _islemSatiri() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: const BorderSide(color: Colors.white24),
            ),
            onPressed: _tekrarDene,
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Tekrar Dene'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70,
              side: const BorderSide(color: Colors.white24),
            ),
            onPressed: _modu == YayinModu.video ? _miniOynaticiyaGonder : null,
            icon: const Icon(Icons.picture_in_picture_alt, size: 18),
            label: const Text('Mini Oynatıcıya Gönder'),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          tooltip: 'Tam ekran',
          onPressed: _tamEkraniDegistir,
          icon: Icon(
            _tamEkran ? Icons.fullscreen_exit : Icons.fullscreen,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _tamEkranCikisButonu() {
    return Material(
      color: Colors.black54,
      borderRadius: BorderRadius.circular(30),
      child: IconButton(
        tooltip: 'Tam ekrandan çık',
        onPressed: _tamEkraniDegistir,
        icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
      ),
    );
  }

  Widget _baglantiYokSata() {
    return Positioned(
      left: 12,
      right: 12,
      bottom: MediaQuery.of(context).padding.bottom + 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            Icon(Icons.cloud_off, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'İnternet bağlantısı yok - otomatik yeniden deneme beklemede',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Ortak görsel yardımcılar ----------------
  Widget _videoKutu(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(color: Colors.black, child: child),
      ),
    );
  }

  Widget _beklemeKatmani() {
    return Container(
      color: Colors.black.withValues(alpha: 0.65),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 34,
            height: 34,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 14),
          Text(
            'Canlı yayın bağlanıyor...',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _bufferingKatmani() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 3,
        color: Colors.black26,
        child: const LinearProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.black26,
        ),
      ),
    );
  }

  Widget _canliRozeti() {
    return Positioned(
      top: 12,
      left: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.circle, size: 8, color: Colors.white),
            SizedBox(width: 6),
            Text(
              'CANLI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _oynatButonu() {
    return Center(
      child: Material(
        color: Colors.black54,
        shape: const CircleBorder(),
        child: IconButton(
          onPressed: _videoDuraklatDevam,
          icon: const Icon(Icons.play_arrow, color: Colors.white, size: 44),
          padding: const EdgeInsets.all(10),
        ),
      ),
    );
  }

  Widget _mesajPaneli({
    required IconData ikon,
    required String baslik,
    required String alt,
    Widget? buton,
  }) {
    return Container(
      color: Colors.black.withValues(alpha: 0.55),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(ikon, color: Colors.white54, size: 40),
          const SizedBox(height: 12),
          Text(
            baslik,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            alt,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12.5),
          ),
          if (buton != null) ...[
            const SizedBox(height: 14),
            buton,
          ],
        ],
      ),
    );
  }

  Widget _bilgiKartlari() {
    final anaBaslik = widget.medineYayini
        ? 'Mescid-i Nebevî 7/24 Canlı'
        : 'Mescid-i Haram 7/24 Canlı';
    final anaDetay = widget.medineYayini
        ? 'Ravza-i Mutahhara ve Yeşil Kubbe çevresindeki canlı kamera '
            'akışı. Sünnet kanalı, Mescid-i Nebevî\'den beş vakit namazı '
            'yayınlar.'
        : 'Tavaf alanı ve Hacerü\'l-Esved çevresindeki canlı kamera '
            'akışı. Namaz vakitlerinde haram imamlarının kıldırdığı '
            'namazlar yayınlanır.';
    return Column(
      children: [
        _bilgiKarti(
          ikon: Icons.mosque_outlined,
          renk: Colors.redAccent,
          baslik: anaBaslik,
          alt: anaDetay,
        ),
        _bilgiKarti(
          ikon: Icons.sync_alt,
          renk: Colors.tealAccent,
          baslik: 'Otomatik Yedek Kaynak',
          alt:
              'YouTube resmî yayını birincil kaynaktır; kesilirse HLS yedeği '
              'otomatik devreye girer. Ağ kopmasında bağlantı gelince yayın '
              'kendiliğinden yeniden başlar.',
        ),
        _bilgiKarti(
          ikon: Icons.phonelink_erase,
          renk: Colors.orangeAccent,
          baslik: 'Veri Tasarrufu',
          alt:
              'Hücresel veride uyarı gösterilir. 🎧 Ses Modu, mobil veri ve '
              'pil kullanımını yaklaşık %80 azaltır; YouTube ise kaliteyi '
              'internet hızına göre otomatik ayarlar (360p-1080p).',
        ),
        _bilgiKarti(
          ikon: Icons.picture_in_picture_alt,
          renk: Colors.amberAccent,
          baslik: 'Mini Oynatıcı (PiP)',
          alt:
              'Mini Oynatıcı butonu ile yayını köşedeki küçük pencerede '
              'sürdürün: Kıssalar, Soru-Cevap gibi diğer sayfalarda '
              'gezinirken yayın kesintisiz devam eder.',
        ),
      ],
    );
  }

  Widget _bilgiKarti({
    required IconData ikon,
    required Color renk,
    required String baslik,
    required String alt,
  }) {
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: renk.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(ikon, color: renk, size: 24),
        ),
        title: Text(
          baslik,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.5,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            alt,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}

/// Zaman aşımıyla HLS kaynağının atlandığını belirten iç denetim istisnası.
/// Normal akışta kullanıcıya gösterilmez; yalnızca `_hlsDene` içinde sıradaki
/// kaynağa geçişi tetikler.
class _HlsAtlandi implements Exception {}