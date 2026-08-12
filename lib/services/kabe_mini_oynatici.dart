// ===========================================================================
// KÂBE MİNİ OYNATICI (Resim İçinde Resim - PiP)
// ---------------------------------------------------------------------------
// Canlı yayın sayfasından ayrıldıktan sonra bile Kâbe canlı yayınının
// uygulamanın diğer sayfalarında (Kıssalar, Soru-Cevap...) küçük bir
// köşe penceresinde oynamaya devam etmesini sağlar.
//
// Uygulama-içi PiP yaklaşımı: video oynatıcı kontrolü bu tekil servise
// devredilir ve kök Navigator'ın Overlay'ine eklenen küçük bir pencere,
// tüm sayfaların üzerinde kalır. Kullanıcı isterse pencereyi tıklayarak
// tam canlı yayın sayfasına geri dönebilir.
// ===========================================================================

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class KabeMiniOynatici extends ChangeNotifier {
  KabeMiniOynatici._();

  static final KabeMiniOynatici instance = KabeMiniOynatici._();

  /// HLS akışını çalan video kontrolü (sahipliği sayfadan devralınır).
  VideoPlayerController? kontrol;

  String kaynakAdi = '';
  OverlayEntry? _giris;

  bool get aktif => _giris != null && kontrol != null;

  /// Sayfadan devralınan kontrolü [kökOverlay] üzerindeki mini pencereye
  /// taşır. Kök overlay kullanıldığı için pencere tüm sayfaların üzerinde
  /// kalır (Resim İçinde Resim).
  /// [kaynakAdi]: yayın kaynağının görünen adı.
  /// [sayfaKaynagi]: kullanıcı pencereye dokununca açılacak sayfa.
  void baslat({
    required OverlayState kokOverlay,
    required VideoPlayerController videoKontrol,
    required String kaynakAdi,
    required Widget Function() sayfaKaynagi,
  }) {
    _kapatGiris();
    kontrol = videoKontrol;
    this.kaynakAdi = kaynakAdi;
    kontrol!.setLooping(true);
    kontrol!.play();
    _giris = OverlayEntry(
      builder: (context) => _MiniPencere(
        kontrol: kontrol!,
        sayfaKaynagi: sayfaKaynagi,
      ),
    );
    kokOverlay.insert(_giris!);
    notifyListeners();
  }

  /// Mini pencereyi kapatır ve video oynatıcıyı serbest bırakır.
  Future<void> durdur() async {
    _kapatGiris();
    notifyListeners();
  }

  /// Mini penceredeki yayını sahibine geri verir (imha etmeden).
  /// Pencere kapanır; kontrol artık çağıran tarafındır.
  VideoPlayerController? geriAl() {
    final g = _giris;
    _giris = null;
    final c = kontrol;
    kontrol = null;
    if (g != null && g.mounted) g.remove();
    notifyListeners();
    return c;
  }

  void _kapatGiris() {
    final g = _giris;
    _giris = null;
    final c = kontrol;
    kontrol = null;
    if (g != null && g.mounted) g.remove();
    if (c != null) {
      try {
        c.dispose();
      } catch (_) {}
    }
  }
}

// ===========================================================================
// MİNİ PENCERE WIDGET'I
// ===========================================================================
class _MiniPencere extends StatefulWidget {
  const _MiniPencere({required this.kontrol, required this.sayfaKaynagi});

  final VideoPlayerController kontrol;
  final Widget Function() sayfaKaynagi;

  @override
  State<_MiniPencere> createState() => _MiniPencereState();
}

class _MiniPencereState extends State<_MiniPencere>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 250),
  );
  late final Animation<Offset> _kayma = Tween<Offset>(
    begin: const Offset(0, 0.4),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _anim, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _genislet(BuildContext context) {
    KabeMiniOynatici.instance.durdur();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => widget.sayfaKaynagi()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final boyut = MediaQuery.of(context).size;
    final genislik = boyut.width * 0.42;
    return Positioned(
      right: 12,
      bottom: 24 + MediaQuery.of(context).padding.bottom,
      child: SafeArea(
        child: SlideTransition(
          position: _kayma,
          child: GestureDetector(
            onTap: () => _genislet(context),
            child: Container(
              width: genislik,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.45),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ValueListenableBuilder<VideoPlayerValue>(
                        valueListenable: widget.kontrol,
                        builder: (context, deger, _) {
                          if (!deger.isInitialized) {
                            return Container(
                              color: Colors.black87,
                              child: const Center(
                                child: SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            );
                          }
                          return VideoPlayer(widget.kontrol);
                        },
                      ),
                      // CANLI rozeti
                      Positioned(
                        top: 6,
                        left: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.circle, size: 6, color: Colors.white),
                              SizedBox(width: 4),
                              Text(
                                'CANLI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Kapatma butonu
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () => KabeMiniOynatici.instance.durdur(),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                      // Dokunma ipucu
                      Positioned(
                        bottom: 4,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Genişletmek için dokun',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              shadows: const [
                                Shadow(color: Colors.black, blurRadius: 4),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}