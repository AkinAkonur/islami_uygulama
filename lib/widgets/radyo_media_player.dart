// ===========================================================================
// RADYO MEDYA OYNATICI - Kullanıcı kontrollü canlı radyo oynatıcı paneli
// ---------------------------------------------------------------------------
// Dini Radyo & İlahi bölümünün ana oynatıcısıdır. Store'un tek AudioPlayer
// örneğini yönetir ve şu kullanıcı kontrollerini sunar:
//   • Çal / Duraklat / Devam / Durdur
//   • Ses seviyesi slider'ı
//   • Uyku zamanlayıcısı (15-60 dk)
//   • Favori kanal işareti
//   • Önceki / Sonraki kanal gezinme
//   • Canlı yayın göstergesi + yüklenme/hata durumları
// ===========================================================================

import 'package:flutter/material.dart';

import '../services/canli_yayin_konfigurasyonu.dart';
import '../services/radyo_oynatici_store.dart';
import '../services/renkler.dart';

/// Tam kontrollü radyo oynatıcı paneli. [kanallar] önceki/sonraki
/// gezinmede kullanılacak sıralı kanal listesidir.
class RadyoMediaPlayer extends StatelessWidget {
  const RadyoMediaPlayer({super.key, this.kanallar});

  final List<RadyoKanali>? kanallar;

  IconData _kategoriIkon(RadyoKategori kategori) {
    switch (kategori) {
      case RadyoKategori.tilavet:
        return Icons.menu_book;
      case RadyoKategori.ilahi:
        return Icons.music_note;
      case RadyoKategori.dini:
        return Icons.forum;
      case RadyoKategori.yurtdisi:
        return Icons.public;
    }
  }

  Future<void> _uykuMenusu(BuildContext context) async {
    final secim = await showModalBottomSheet<int>(
      context: context,
      backgroundColor: Renkler.yuzey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return ValueListenableBuilder<int?>(
          valueListenable: RadyoOynaticiStore.uykuDk,
          builder: (context, seciliDk, _) {
            const secenekler = <(int?, String)>[
              (null, 'Kapalı'),
              (15, '15 dakika'),
              (30, '30 dakika'),
              (45, '45 dakika'),
              (60, '60 dakika'),
            ];
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '😴 Uyku Zamanlayıcısı',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (final (dk, etiket) in secenekler)
                    ListTile(
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor: dk == seciliDk
                          ? Renkler.vurgu.withValues(alpha: 0.18)
                          : null,
                      title: Text(
                        etiket,
                        style: TextStyle(
                          color:
                              dk == seciliDk ? Renkler.vurgu : Colors.white70,
                          fontWeight: dk == seciliDk
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: dk == seciliDk
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.greenAccent,
                              size: 20,
                            )
                          : null,
                      onTap: () => Navigator.pop(sheetContext, dk),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
    if (secim == null) return;
    RadyoOynaticiStore.uykuZamanlayici(
      secim,
      durdugunda: RadyoOynaticiStore.durdur,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RadyoKanali?>(
      valueListenable: RadyoOynaticiStore.calanKanal,
      builder: (context, kanal, _) {
        if (kanal == null) return const SizedBox.shrink();
        return ValueListenableBuilder<bool>(
          valueListenable: RadyoOynaticiStore.calyor,
          builder: (context, calyor, _) => ValueListenableBuilder<bool>(
            valueListenable: RadyoOynaticiStore.yukleniyor,
            builder: (context, yukleniyor, _) => ValueListenableBuilder<String?>(
              valueListenable: RadyoOynaticiStore.hata,
              builder: (context, hata, _) => ValueListenableBuilder<int>(
                valueListenable: RadyoOynaticiStore.ses,
                builder: (context, ses, _) => _panel(
                  context,
                  kanal,
                  calyor: calyor,
                  yukleniyor: yukleniyor,
                  hata: hata,
                  ses: ses,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _panel(
    BuildContext context,
    RadyoKanali kanal, {
    required bool calyor,
    required bool yukleniyor,
    required String? hata,
    required int ses,
  }) {
    final favori = RadyoOynaticiStore.favoriMi(kanal.url);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Renkler.seciliYuzey.withValues(alpha: 0.9),
            Renkler.kart,
          ],
        ),
        border: Border.all(color: Renkler.cerceve),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _kanalSimge(kanal, calyor: calyor),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kanal.ad,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      kanal.aciklama,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _durumEtiketi(calyor: calyor, yukleniyor: yukleniyor),
                  ],
                ),
              ),
              IconButton(
                tooltip: favori ? 'Favorilerden Çıkar' : 'Favorilere Ekle',
                onPressed: () => RadyoOynaticiStore.favoriDegistir(kanal.url),
                icon: Icon(
                  favori ? Icons.favorite : Icons.favorite_border,
                  color: favori ? Renkler.vurgu : Colors.white54,
                ),
              ),
            ],
          ),
          if (hata != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.redAccent, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      hata,
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        RadyoOynaticiStore.oynat(kanal, kanallar: kanallar),
                    child: const Text('Tekrar Dene',
                        style: TextStyle(color: Colors.redAccent)),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'Önceki',
                onPressed: () => RadyoOynaticiStore.onceki(),
                icon: const Icon(Icons.skip_previous, color: Colors.white70),
                iconSize: 32,
              ),
              const SizedBox(width: 12),
              _anaButon(
                calyor: calyor,
                yukleniyor: yukleniyor,
                onPressed: () => RadyoOynaticiStore.oynat(kanal,
                    kanallar: kanallar),
              ),
              const SizedBox(width: 12),
              IconButton(
                tooltip: 'Sonraki',
                onPressed: () => RadyoOynaticiStore.sonraki(),
                icon: const Icon(Icons.skip_next, color: Colors.white70),
                iconSize: 32,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                tooltip: 'Durdur',
                onPressed: () => RadyoOynaticiStore.durdur(),
                icon: const Icon(Icons.stop_circle_outlined,
                    color: Colors.white54, size: 26),
              ),
              const SizedBox(width: 12),
              IconButton(
                tooltip: 'Uyku Zamanlayıcısı',
                onPressed: () => _uykuMenusu(context),
                icon: const Icon(Icons.bedtime_outlined,
                    color: Colors.white54, size: 26),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.volume_down, color: Colors.white38, size: 18),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 7),
                    overlayShape:
                        const RoundSliderOverlayShape(overlayRadius: 14),
                  ),
                  child: Slider(
                    value: ses.toDouble(),
                    max: 100,
                    activeColor: Renkler.vurgu,
                    inactiveColor: Renkler.cerceve2,
                    onChanged: (v) => RadyoOynaticiStore.sesAyarla(v.round()),
                  ),
                ),
              ),
              const Icon(Icons.volume_up, color: Colors.white38, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kanalSimge(RadyoKanali kanal, {required bool calyor}) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey.withValues(alpha: 0.6),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _kategoriIkon(kanal.kategori),
        color: calyor ? Renkler.vurgu : Colors.white38,
        size: 28,
      ),
    );
  }

  Widget _durumEtiketi({required bool calyor, required bool yukleniyor}) {
    final String metin;
    final Color renk;
    if (yukleniyor) {
      metin = 'Bağlanıyor...';
      renk = Colors.white54;
    } else if (calyor) {
      metin = '🔴 Canlı yayın';
      renk = Colors.redAccent;
    } else {
      metin = 'Duraklatıldı';
      renk = Colors.orangeAccent;
    }
    return Text(
      metin,
      style: TextStyle(color: renk, fontSize: 12, fontWeight: FontWeight.w500),
    );
  }

  Widget _anaButon({
    required bool calyor,
    required bool yukleniyor,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: yukleniyor ? null : onPressed,
      child: Container(
        width: 68,
        height: 68,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Renkler.vurgu,
              Renkler.vurgu.withValues(alpha: 0.75),
            ],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Renkler.vurgu.withValues(alpha: 0.35),
              blurRadius: 18,
              spreadRadius: 2,
            ),
          ],
        ),
        child: yukleniyor
            ? const Center(
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                ),
              )
            : Icon(
                calyor ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
      ),
    );
  }
}
