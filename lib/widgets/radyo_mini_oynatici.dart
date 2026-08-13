// ===========================================================================
// RADYO MİNİ OYNATICI - Alt çubuk kalıcı mini oynatıcı
// ---------------------------------------------------------------------------
// Radyo çalarken kullanıcı başka sayfalarda gezinse bile ekranın altında
// kompakt bir oynatıcı gösterir: kanal adı, çal/duraklat, durdur ve tam
// oynatıcıyı açma. Böylece yayın uygulama genelinde kesintisiz sürer.
// ===========================================================================

import 'package:flutter/material.dart';

import '../services/canli_yayin_konfigurasyonu.dart';
import '../services/radyo_oynatici_store.dart';
import '../services/renkler.dart';

/// Radyo çalarken gösterilen kompakt alt çubuk.
class RadyoMiniOynatici extends StatelessWidget {
  const RadyoMiniOynatici({super.key, this.kanallar, this.onTamAc});

  final List<RadyoKanali>? kanallar;

  /// Mini çubuğa dokununca tam oynatıcıyı açmak için kullanılır.
  final VoidCallback? onTamAc;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RadyoKanali?>(
      valueListenable: RadyoOynaticiStore.calanKanal,
      builder: (context, kanal, _) {
        if (kanal == null) return const SizedBox.shrink();
        return Container(
          decoration: BoxDecoration(
            color: Renkler.seciliYuzey,
            border: Border(top: BorderSide(color: Renkler.cerceve)),
          ),
          child: SafeArea(
            top: false,
            child: ValueListenableBuilder<bool>(
              valueListenable: RadyoOynaticiStore.calyor,
              builder: (context, calyor, _) => ValueListenableBuilder<bool>(
                valueListenable: RadyoOynaticiStore.yukleniyor,
                builder: (context, yukleniyor, _) => Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Row(
                    children: [
                      _calanSinyali(calyor: calyor),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: onTamAc,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  kanal.ad,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.5,
                                  ),
                                ),
                                Text(
                                  yukleniyor
                                      ? 'Bağlanıyor...'
                                      : (calyor ? '🔴 Canlı' : 'Duraklatıldı'),
                                  style: TextStyle(
                                    color: yukleniyor
                                        ? Colors.white54
                                        : (calyor
                                            ? Colors.redAccent
                                            : Colors.orangeAccent),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: calyor ? 'Duraklat' : 'Devam Et',
                        onPressed: () => RadyoOynaticiStore.oynat(kanal,
                            kanallar: kanallar),
                        icon: Icon(
                          calyor
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color:
                              calyor ? Colors.redAccent : Renkler.vurgu,
                          size: 38,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Durdur',
                        onPressed: () => RadyoOynaticiStore.durdur(),
                        icon: const Icon(
                          Icons.stop_circle_outlined,
                          color: Colors.white70,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _calanSinyali({required bool calyor}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: calyor
            ? Colors.redAccent.withValues(alpha: 0.18)
            : Renkler.cerceve,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.radio,
        color: calyor ? Colors.redAccent : Colors.white38,
        size: 20,
      ),
    );
  }
}
