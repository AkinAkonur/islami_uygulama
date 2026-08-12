// ===========================================================================
// YOUTUBE EMBED GÖRÜNTÜLEYİCİ (IFrame/WebView)
// ---------------------------------------------------------------------------
// Mekke & Medine sanal tur ve 360° içerikler için yeniden kullanılabilir
// oynatıcı sayfası. Ham m3u8 akışlarıyla uğraşmak yerine YouTube IFrame
// gömmesi kullanılır: YouTube tüm dünyada ve hücresel veride akışı otomatik
// optimize eder (adaptive bitrate), codec/Cloudflare engeli riskini elemine
// eder.
// ===========================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../services/renkler.dart';

class YoutubeEmbedPage extends StatefulWidget {
  const YoutubeEmbedPage({
    super.key,
    required this.videoId,
    required this.baslik,
    required this.aciklama,
  });

  /// YouTube video veya canlı yayın ID'si.
  final String videoId;
  final String baslik;
  final String aciklama;

  @override
  State<YoutubeEmbedPage> createState() => _YoutubeEmbedPageState();
}

class _YoutubeEmbedPageState extends State<YoutubeEmbedPage> {
  WebViewController? _kontrol;
  bool _yukleniyor = true;
  bool _hata = false;
  bool get _desteklenmiyor => !_webDestekleniyor();

  bool _webDestekleniyor() {
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

  @override
  void initState() {
    super.initState();
    if (!_desteklenmiyor) _yukle();
  }

  Future<void> _yukle() async {
    setState(() {
      _yukleniyor = true;
      _hata = false;
    });
    try {
      final kontrol = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0xFF000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (_) {
              if (mounted) setState(() => _yukleniyor = false);
            },
            onWebResourceError: (_) {
              if (mounted) setState(() => _hata = true);
            },
          ),
        );
      // YouTube IFrame: autoplay kapalı (kullanıcı dokununca oynar).
      final url = 'https://www.youtube.com/embed/${widget.videoId}'
          '?rel=0&playsinline=1&modestbranding=1'
          '&enablejsapi=1&origin=${Uri.encodeComponent('https://localhost')}';
      await kontrol.loadRequest(Uri.parse(url));
      if (mounted) setState(() => _kontrol = kontrol);
    } catch (_) {
      if (mounted) {
        setState(() {
          _yukleniyor = false;
          _hata = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(widget.baslik),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _oynaticiKutusu(),
          const SizedBox(height: 16),
          Text(
            widget.aciklama,
            style: const TextStyle(color: Colors.white70, height: 1.5),
          ),
          const SizedBox(height: 14),
          _uyariKarti(),
        ],
      ),
    );
  }

  Widget _oynaticiKutusu() {
    if (_desteklenmiyor) {
      return _kutu(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.live_tv_outlined, color: Colors.white54, size: 40),
            SizedBox(height: 10),
            Text(
              'Bu içerik bu cihazda desteklenmiyor',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      );
    }
    final kontrol = _kontrol;
    if (kontrol != null && !_hata) {
      return _kutu(
        Stack(
          fit: StackFit.expand,
          children: [
            WebViewWidget(controller: kontrol),
            if (_yukleniyor)
              Container(
                color: Colors.black.withValues(alpha: 0.65),
                child: const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }
    return _kutu(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _hata ? Icons.cloud_off_outlined : Icons.play_circle_outline,
            color: Colors.white54,
            size: 40,
          ),
          const SizedBox(height: 10),
          const Text(
            'Video yüklenemedi',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'İnternet bağlantınızı kontrol edip tekrar deneyin.',
            style: TextStyle(color: Colors.white70, fontSize: 12.5),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: Renkler.vurgu),
            onPressed: _yukle,
            icon: const Icon(Icons.refresh),
            label: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  Widget _kutu(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(color: Colors.black, child: child),
      ),
    );
  }

  Widget _uyariKarti() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Renkler.vurgu, size: 18),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Canlı yayınlar 24/7 kesintisiz izlenir. Kalite, internet '
              'hızınıza göre otomatik ayarlanır (360p - 1080p). Mobil '
              'veride önemli miktarda veri tüketilebilir.',
              style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}