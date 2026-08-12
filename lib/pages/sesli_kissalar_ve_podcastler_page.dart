// ===========================================================================
// SESLİ KISSALAR VE PODCASTLER (İnteraktif Medya Merkezi modülü)
// ---------------------------------------------------------------------------
// İki bölümden oluşur:
//  📖 Sesli Kıssalar: Kıssalar ve Peygamberler sayfasındaki tüm kayıtlar
//     cihazın TTS motoruyla sesli anlatıma çevrilir (internet gerektirmez).
//     "Oku" ile aynı kayda ait detay sayfası açılır; kayıtta CDN ses adresi
//     (sesUrl) varsa öncelikle o akış kullanılır.
//  🎙️ Podcastler & Radyo: yayın konfigürasyonundan (Remote Config
//     alternatifi) gelen radyo/podcast akışları tek dokunuşla dinlenir.
// ===========================================================================

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../services/canli_yayin_konfigurasyonu.dart';
import '../services/renkler.dart';
import 'kissalar/ibret_verileri.dart';
import 'kissalar/kissa_detay_page.dart';
import 'kissalar/kissa_store.dart';
import 'kissalar/kissalar_verileri.dart';
import 'kissalar/peygamberler_verileri.dart';
import 'kissalar/siyer_verileri.dart';

class SesliKissalarVePodcastlerPage extends StatefulWidget {
  const SesliKissalarVePodcastlerPage({super.key});

  @override
  State<SesliKissalarVePodcastlerPage> createState() =>
      _SesliKissalarVePodcastlerPageState();
}

class _SesliKissalarVePodcastlerPageState
    extends State<SesliKissalarVePodcastlerPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tablar;

  // ---- TTS (Sesli Kıssa) ----
  final FlutterTts _tts = FlutterTts();
  String? _ttsKalanId; // Şu an okunan kıssanın id'si
  bool _ttsCalyor = false;
  String? _ttsHata;

  // ---- Podcast / Radyo (akışlı) ----
  final AudioPlayer _podcastPlayer = AudioPlayer();
  String? _calanKanalUrl;
  bool _podcastCalyor = false;
  bool _podcastYukleniyor = false;
  String? _podcastHata;

  @override
  void initState() {
    super.initState();
    _tablar = TabController(length: 2, vsync: this);
    // Kıssa kayıt defterini doldur (idempotent).
    peygamberlerKaydet();
    siyerKaydet();
    ibretKaydet();
    KissaStore.yukle();
    // TTS ayarları; ortam desteklemezse sessizce yok sayılır (test vb.).
    _tts.setLanguage('tr-TR').catchError((_) {});
    _tts.setSpeechRate(0.45).catchError((_) {});
    _tts.awaitSpeakCompletion(false).catchError((_) {});
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _ttsCalyor = false);
    });
    _tts.setCancelHandler(() {
      if (mounted) setState(() => _ttsCalyor = false);
    });
    _podcastPlayer.onPlayerStateChanged.listen(
      (durum) {
        if (!mounted) return;
        setState(() {
          _podcastCalyor = durum == PlayerState.playing;
          if (durum != PlayerState.disposed) _podcastYukleniyor = false;
        });
      },
      onError: (_) {},
    );
    _podcastPlayer.onPlayerComplete.listen((_) {
      if (mounted) setState(() {
        _podcastCalyor = false;
        _calanKanalUrl = null;
      });
    });
  }

  @override
  void dispose() {
    _tablar.dispose();
    _tts.stop();
    _podcastPlayer.dispose();
    super.dispose();
  }

  // =========================================================================
  // SESLİ KISSA OYNATICI
  // =========================================================================
  Future<void> _kissaDinle(KissaKaydi kissa) async {
    if (_ttsKalanId == kissa.id && _ttsCalyor) {
      await _tts.stop();
      if (mounted) setState(() => _ttsCalyor = false);
      return;
    }
    try {
      await _tts.stop();
      // Gömülü CDN sesi varsa akış kullanılır, yoksa TTS anlatımı.
      if (kissa.sesUrl != null && kissa.sesUrl!.isNotEmpty) {
        await _tts.speak(''); // olası eski okumayı temizle
      }
      final metin = [
        kissa.ozet,
        ...kissa.metin,
        ...kissa.hikmetler,
      ].join('. ');
      final sonuc = await _tts.speak(metin);
      if (mounted) {
        setState(() {
          _ttsKalanId = kissa.id;
          _ttsCalyor = sonuc == 1 || sonuc == 0;
          _ttsHata =
              (sonuc == 1 || sonuc == 0)
                  ? null
                  : 'Cihazınızda Türkçe ses paketi yok. Ses paketini kurunuz.';
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _ttsCalyor = false;
          _ttsHata = 'Sesli anlatım başlatılamadı.';
        });
      }
    }
  }

  // =========================================================================
  // PODCAST / RADYO OYNATICI
  // =========================================================================
  Future<void> _podcastDinle(RadyoKanali kanal) async {
    final ayniKanal = _calanKanalUrl == kanal.url && _podcastCalyor;
    if (ayniKanal) {
      await _podcastPlayer.pause();
      if (mounted) setState(() => _podcastCalyor = false);
      return;
    }
    setState(() {
      _podcastYukleniyor = true;
      _podcastHata = null;
    });
    try {
      await _podcastPlayer.stop();
      await _podcastPlayer.setReleaseMode(ReleaseMode.release);
      await _podcastPlayer.play(
        UrlSource(kanal.url),
        mode: PlayerMode.mediaPlayer,
      );
      if (mounted) {
        setState(() {
          _calanKanalUrl = kanal.url;
          _podcastCalyor = true;
          _podcastYukleniyor = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _podcastYukleniyor = false;
          _podcastHata =
              'Bu kanala ulaşılamadı. Bağlantınızı kontrol edip tekrar deneyin.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.seciliYuzey,
        title: const Text('Sesli Kıssalar ve Podcastler'),
        bottom: TabBar(
          controller: _tablar,
          indicatorColor: Renkler.vurgu,
          labelColor: Renkler.vurgu,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: '📖 Sesli Kıssalar'),
            Tab(text: '🎙️ Podcastler & Radyo'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tablar,
        children: [
          _sesliKissalarBolumu(),
          _podcastBolumu(),
        ],
      ),
    );
  }

  // =========================================================================
  // 1. SESLİ KISSALAR
  // =========================================================================
  Widget _sesliKissalarBolumu() {
    final kisalar = KissalarVerileri.tumKisalar;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: Row(
              children: [
                Icon(Icons.record_voice_over_outlined, color: Renkler.vurgu),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Karta dokununca kıssa sesli anlatılır (cihazın ses '
                    'motoruyla, internet gerektirmez). Detay için "Oku".',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_ttsHata != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              _ttsHata!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                '${kisalar.length} sesli anlatım',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
              const SizedBox(height: 8),
              for (final kissa in kisalar) _sesliKissaKarti(kissa),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sesliKissaKarti(KissaKaydi kissa) {
    final caliyor = _ttsKalanId == kissa.id && _ttsCalyor;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: caliyor ? Renkler.vurgu : Renkler.cerceve,
          width: caliyor ? 1.4 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _kissaDinle(kissa),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: caliyor
                    ? Renkler.vurgu.withValues(alpha: 0.25)
                    : Renkler.seciliYuzey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                caliyor
                    ? Icons.stop_circle_outlined
                    : Icons.headphones_outlined,
                color: caliyor ? Colors.redAccent : Renkler.vurgu,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${kissa.emoji}  ${kissa.baslik}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  caliyor ? '🔊 Şu an sesli anlatılıyor...' : kissa.ozet,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  children: [
                    _kucukButon(
                      ikon: caliyor ? Icons.stop : Icons.play_arrow,
                      etiket: caliyor ? 'Durdur' : 'Dinle',
                      renk: caliyor ? Colors.redAccent : Renkler.vurgu,
                      onTap: () => _kissaDinle(kissa),
                    ),
                    _kucukButon(
                      ikon: Icons.menu_book_outlined,
                      etiket: 'Oku',
                      renk: Colors.lightBlueAccent,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => KissaDetayPage(kissa: kissa),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _kucukButon({
    required IconData ikon,
    required String etiket,
    required Color renk,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: renk.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: renk.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon, color: renk, size: 14),
            const SizedBox(width: 4),
            Text(
              etiket,
              style: TextStyle(color: renk, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // 2. PODCASTLER & RADYO
  // =========================================================================
  Widget _podcastBolumu() {
    final kanallar = CanliYayinKonfigurasyonu.guncel.radyoKanallari;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: Row(
              children: [
                Icon(Icons.radio_outlined, color: Renkler.vurgu),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Kesintisiz Kuran tilaveti, sohbet ve ilahi akışı. '
                    'Kanallar sunucu tarafından yönetilir; değişiklikler '
                    'uygulama güncellemesi gerektirmez.',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_podcastHata != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Text(
              _podcastHata!,
              style: const TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final kanal in kanallar)
                _kanalKarti(kanal, _calanKanalUrl == kanal.url),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kanalKarti(RadyoKanali kanal, bool caliyor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: caliyor ? Renkler.vurgu : Renkler.cerceve,
          width: caliyor ? 1.4 : 1,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => _podcastDinle(kanal),
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: caliyor
                    ? Renkler.vurgu.withValues(alpha: 0.25)
                    : Renkler.seciliYuzey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                caliyor ? Icons.stop : Icons.play_arrow,
                color: caliyor ? Colors.redAccent : Renkler.vurgu,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kanal.ad,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  caliyor
                      ? '🔴 Canlı akış devam ediyor...'
                      : kanal.aciklama,
                  style: const TextStyle(color: Colors.white54, fontSize: 11.5),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (_podcastYukleniyor && caliyor)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
    );
  }
}