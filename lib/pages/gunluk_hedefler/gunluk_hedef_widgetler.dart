import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/manevi_store.dart';
import '../../services/renkler.dart';
import 'gunluk_hedef_store.dart';
import 'gunluk_hedef_verileri.dart';

class RozetlerBolumu extends StatelessWidget {
  const RozetlerBolumu({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final kazanilan = GunlukHedefStore.kazanilanRozetler;
    final kazanilanIdler = {for (final r in kazanilan) r.id};
    return SizedBox(
      height: 108,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: kilometreTaslari.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final r = kilometreTaslari[index];
          final kazanildi = kazanilanIdler.contains(r.id);
          return Container(
            width: 150,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kazanildi ? Renkler.seciliYuzey : Renkler.kart,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: kazanildi
                    ? Renkler.vurgu.withValues(alpha: 0.5)
                    : Renkler.cerceve,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kazanildi ? r.ikon : '🔒',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 6),
                Text(
                  r.ad,
                  style: TextStyle(
                    color: kazanildi ? Colors.white : Colors.white38,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  l.t('gw.threshold')
                      .replaceFirst('{days}', '${r.esik}')
                      .replaceFirst('{desc}', r.aciklama),
                  style: TextStyle(
                    color: kazanildi ? Colors.white70 : Colors.white38,
                    fontSize: 10,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class MagazaKarti extends StatelessWidget {
  const MagazaKarti({super.key, required this.onAl});

  final VoidCallback onAl;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final yeterliXp = GunlukHedefStore.toplamXp >= dondurucuFiyati;
    final korundu = GunlukHedefStore.bugunKorundu;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Renkler.acikVurgu.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('🧊', style: TextStyle(fontSize: 22)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('gw.freezerTitle'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  korundu
                      ? l.t('gw.freezerActive')
                      : l.t('gw.freezerPassive').replaceFirst(
                          '{count}', '${GunlukHedefStore.dondurucu}'),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.t('gw.price')
                      .replaceFirst('{count}', '$dondurucuFiyati'),
                  style: TextStyle(
                    color: Renkler.vurgu,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.icon(
            onPressed: yeterliXp ? onAl : null,
            style: FilledButton.styleFrom(
              backgroundColor: Renkler.vurgu,
              foregroundColor: Colors.black,
            ),
            icon: const Icon(Icons.shopping_cart_outlined, size: 16),
            label: Text(l.t('gw.buy')),
          ),
        ],
      ),
    );
  }
}

class IstatistikKarti extends StatelessWidget {
  const IstatistikKarti({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _kutu(
            Icons.stars_outlined,
            '${GunlukHedefStore.toplamXp}',
            l.t('gw.statXp'),
          ),
          _kutu(
            Icons.local_fire_department_outlined,
            '${GunlukHedefStore.uzunSeri}',
            l.t('gw.statStreak'),
          ),
          _kutu(
            Icons.ac_unit_outlined,
            '${GunlukHedefStore.dondurucu}',
            l.t('gw.statFreezer'),
          ),
        ],
      ),
    );
  }

  Widget _kutu(IconData ikon, String deger, String ad) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Renkler.cerceve),
        ),
        child: Column(
          children: [
            Icon(ikon, color: Renkler.vurgu, size: 22),
            const SizedBox(height: 6),
            Text(
              deger,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              ad,
              style: const TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class NamazKarti extends StatelessWidget {
  const NamazKarti({super.key, required this.namaz, required this.onTikla});

  final Set<String> namaz;
  final ValueChanged<String> onTikla;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final tamam = ManeviStore.namazVakitleri.where(namaz.contains).length;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mosque_outlined, color: Renkler.vurgu, size: 20),
              const SizedBox(width: 8),
              Text(
                l.t('gw.namazTitle'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '$tamam/5',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            l.t('gw.namazHint'),
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 10),
          for (final v in ManeviStore.namazVakitleri)
            InkWell(
              onTap: () => onTikla(v),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      namaz.contains(v)
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: namaz.contains(v)
                          ? Renkler.vurgu
                          : Colors.white38,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      l.t('gw.namazName').replaceFirst('{name}', v),
                      style: TextStyle(
                        color: namaz.contains(v)
                            ? Colors.white70
                            : Colors.white,
                        fontSize: 14,
                        decoration: namaz.contains(v)
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
