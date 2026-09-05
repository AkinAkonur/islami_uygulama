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
import 'altin_tactile.dart';

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
            color: Renkler.navBar,
            border: Border(
              top: BorderSide(
                color: AltinTasarim.altin.withValues(alpha: 0.45),
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AltinTasarim.altin.withValues(alpha: 0.12),
                blurRadius: 14,
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: ValueListenableBuilder<bool>(
              valueListenable: RadyoOynaticiStore.calyor,
              builder: (context, calyor, _) => ValueListenableBuilder<bool>(
                valueListenable: RadyoOynaticiStore.yukleniyor,
                builder: (context, yukleniyor, _) => Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
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
                                            ? AltinTasarim.altinParlakRenk
                                            : Colors.orangeAccent),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AltinButon(
                        boyut: 42,
                        ikonBoyut: 22,
                        isik: true,
                        ikon: calyor
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        onPressed: () => RadyoOynaticiStore.oynat(kanal,
                            kanallar: kanallar),
                      ),
                      const SizedBox(width: 6),
                      AltinButon(
                        boyut: 32,
                        ikonBoyut: 15,
                        isik: false,
                        ikonRenk: Colors.white70,
                        ikon: Icons.stop_rounded,
                        onPressed: () => RadyoOynaticiStore.durdur(),
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
      width: 42,
      height: 42,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AltinTasarim.acikAltin.withValues(alpha: 0.9),
            AltinTasarim.koyuAltin.withValues(alpha: 0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: (calyor ? AltinTasarim.altin : Colors.white38)
                .withValues(alpha: 0.4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: const Alignment(-0.3, -0.4),
            colors: calyor
                ? [AltinTasarim.zumrutAcik, AltinTasarim.zumrutDerin]
                : [AltinTasarim.zumrutOrt, AltinTasarim.zumrutDerin],
          ),
        ),
        child: Icon(
          Icons.radio,
          color: calyor ? AltinTasarim.altinParlakRenk : Colors.white38,
          size: 18,
          shadows: calyor
              ? const [
                  Shadow(
                    color: Colors.black54,
                    offset: Offset(0, 1),
                    blurRadius: 1.2,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}
