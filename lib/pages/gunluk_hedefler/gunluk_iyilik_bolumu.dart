import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/manevi_store.dart';
import '../../services/renkler.dart';
import '../../widgets/altin_tactile.dart';
import '../../widgets/kart_sekilleri.dart';

/// Günlük hedef sayfasındaki "Bugünün İyilikleri" bölümü.
///
/// Eskiden ayrı duran [GunlukGorevPage]'in tüm işlevini taşır: varsayılan
/// görevler, kullanıcının eklediği özel iyilikler ve namaz işaretleri. Böylece
/// günlük hedef sayfası tekmerkezde toplanır; `gunluk_gorev_page.dart` bu
/// birleştirmeyle kaldırıldı.
class IyilikBolumu extends StatefulWidget {
  const IyilikBolumu({super.key});

  @override
  State<IyilikBolumu> createState() => _IyilikBolumuState();
}

class _IyilikBolumuState extends State<IyilikBolumu> {
  Set<String> _gorevler = {};
  Set<String> _namaz = {};
  List<(String, String)> _ozelIyilikler = [];
  final TextEditingController _iyilikController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  @override
  void dispose() {
    _iyilikController.dispose();
    super.dispose();
  }

  Future<void> _yukle() async {
    final gorevler = await ManeviStore.bugunGorevler();
    final namaz = await ManeviStore.bugunNamaz();
    final ozel = await ManeviStore.ozelIyilikler();
    if (mounted) {
      setState(() {
        _gorevler = gorevler;
        _namaz = namaz;
        _ozelIyilikler = ozel;
      });
    }
  }

  Future<void> _iyilikEkle() async {
    final metin = _iyilikController.text.trim();
    if (metin.isEmpty) return;
    final yeni = await ManeviStore.ozelIyilikEkle(metin);
    if (mounted) {
      setState(() => _ozelIyilikler = yeni);
      _iyilikController.clear();
    }
  }

  Future<void> _iyilikSil(String id) async {
    final yeni = await ManeviStore.ozelIyilikSil(id);
    final gorevler = await ManeviStore.bugunGorevler();
    if (mounted) {
      setState(() {
        _ozelIyilikler = yeni;
        _gorevler = gorevler;
      });
    }
  }

  Future<void> _gorevTikla(String id, bool tamam) async {
    final yeni = await ManeviStore.gorevTikla(id, tamam);
    if (mounted) setState(() => _gorevler = yeni);
  }

  Future<void> _namazTikla(String vakit, bool tamam) async {
    final yeni = await ManeviStore.namazTikla(vakit, tamam);
    if (mounted) setState(() => _namaz = yeni);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _namazKarti(l),
          const SizedBox(height: 16),
          _gorevKarti(l),
        ],
      ),
    );
  }

  Widget _namazKarti(AppLocalizations l) {
    final tamam = ManeviStore.namazVakitleri.where(_namaz.contains).length;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: Icons.mosque_rounded, renk: Renkler.vurgu, boyut: 20),
              const SizedBox(width: 8),
              Text(
                l.t('gg.namaz5'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '$tamam/5',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...ManeviStore.namazVakitleri.map(
            (v) => _kontrolSatiri(
              etiket: '$v Namazı',
              deger: _namaz.contains(v),
              onChanged: (t) => _namazTikla(v, t),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gorevKarti(AppLocalizations l) {
    final tamam = ManeviStore.gorevler
        .where((g) => _gorevler.contains(g['id']))
        .length;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: Icons.checklist_rounded, renk: Renkler.vurgu, boyut: 20),
              const SizedBox(width: 8),
              Text(
                l.t('gg.goodDeeds'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '$tamam/${ManeviStore.gorevler.length}',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            l.t('gg.goodDeedsDesc'),
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          ...ManeviStore.gorevler.map(
            (g) => _gorevSatiri(
              ikon: g['ikon']!,
              baslik: g['baslik']!,
              aciklama: g['aciklama']!,
              deger: _gorevler.contains(g['id']),
              onChanged: (t) => _gorevTikla(g['id']!, t),
            ),
          ),
          const Divider(color: Colors.white12, height: 24),
          if (_ozelIyilikler.isNotEmpty) ...[
            ..._ozelIyilikler.map(
              (i) => _ozelIyilikSatiri(
                id: i.$1,
                baslik: i.$2,
                deger: _gorevler.contains(i.$1),
                onChanged: (t) => _gorevTikla(i.$1, t),
                onDelete: () => _iyilikSil(i.$1),
              ),
            ),
            const SizedBox(height: 8),
          ],
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _iyilikController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  cursorColor: Renkler.vurgu,
                  maxLength: 80,
                  onSubmitted: (_) => _iyilikEkle(),
                  decoration: InputDecoration(
                    counterText: '',
                    isDense: true,
                    hintText: l.t('gg.goodDeedsHint'),
                    hintStyle: const TextStyle(color: Colors.white38),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Renkler.vurgu),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _iyilikEkle,
                tooltip: l.t('gg.addGoodDeed'),
                icon: UcdIkon(
                  ikon: Icons.add_circle_rounded,
                  renk: Renkler.vurgu,
                  boyut: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _ozelIyilikSatiri({
    required String id,
    required String baslik,
    required bool deger,
    required ValueChanged<bool> onChanged,
    required VoidCallback onDelete,
  }) {
    final l = AppLocalizations.of(context);
    return UcdButon(
      onTap: () => onChanged(!deger),
      basili: deger,
      koseYaricapi: 12,
      genislik: double.infinity,
      dolgu: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('✨', style: TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              baslik,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                decoration: deger ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          UcdIkon(
            ikon: deger
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            renk: deger ? Renkler.vurgu : Colors.white38,
            boyut: 24,
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onDelete,
            tooltip: l.t('gg.removeGoodDeed'),
            icon: const UcdIkon(
              ikon: Icons.delete_outline_rounded,
              renk: Colors.white38,
            ),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _kontrolSatiri({
    required String etiket,
    required bool deger,
    required ValueChanged<bool> onChanged,
  }) {
    return UcdButon(
      onTap: () => onChanged(!deger),
      basili: deger,
      koseYaricapi: 12,
      genislik: double.infinity,
      dolgu: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          UcdIkon(
            ikon: deger
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            renk: deger ? Renkler.vurgu : Colors.white38,
            boyut: 22,
          ),
          const SizedBox(width: 12),
          Text(
            etiket,
            style: TextStyle(
              color: deger ? Colors.white70 : Colors.white,
              fontSize: 14,
              decoration: deger ? TextDecoration.lineThrough : null,
            ),
          ),
          const Spacer(),
          if (deger)
            UcdIkon(ikon: Icons.done_rounded, renk: Renkler.vurgu, boyut: 16),
        ],
      ),
    );
  }

  Widget _gorevSatiri({
    required String ikon,
    required String baslik,
    required String aciklama,
    required bool deger,
    required ValueChanged<bool> onChanged,
  }) {
    return UcdButon(
      onTap: () => onChanged(!deger),
      basili: deger,
      koseYaricapi: 12,
      genislik: double.infinity,
      dolgu: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Renkler.seciliYuzey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(ikon, style: const TextStyle(fontSize: 18)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  baslik,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    decoration: deger ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  aciklama,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    decoration: deger ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
          UcdIkon(
            ikon: deger
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            renk: deger ? Renkler.vurgu : Colors.white38,
            boyut: 24,
          ),
        ],
      ),
    );
  }
}
