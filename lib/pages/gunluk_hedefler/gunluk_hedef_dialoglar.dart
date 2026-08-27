import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../soru_cevap/soru_cevap_model.dart';
import 'gunluk_hedef_store.dart';
import 'gunluk_hedef_verileri.dart';

class KissaDialogi extends StatelessWidget {
  const KissaDialogi({super.key, required this.kissa});

  final KissaIcerik kissa;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AlertDialog(
      backgroundColor: Renkler.kart,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        '📖 ${kissa.baslik}',
        style: const TextStyle(color: Colors.white, fontSize: 17),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kissa.metin,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              kissa.kaynak,
              style: TextStyle(
                color: Renkler.vurgu,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l.t('gd.later')),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.pop(context, true),
          style: FilledButton.styleFrom(
            backgroundColor: Renkler.vurgu,
            foregroundColor: Colors.black,
          ),
          icon: const Icon(Icons.check, size: 18),
          label: Text(l.t('gd.readDone')),
        ),
      ],
    );
  }
}

class SoruDialogi extends StatefulWidget {
  const SoruDialogi({super.key, required this.soru});

  final SoruCevapSorusu soru;

  @override
  State<SoruDialogi> createState() => _SoruDialogiState();
}

class _SoruDialogiState extends State<SoruDialogi> {
  int? _secili;
  bool _dogru = false;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final secenekler = widget.soru.secenekler ?? const <String>[];
    return AlertDialog(
      backgroundColor: Renkler.kart,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        l.t('gd.questionTitle'),
        style: const TextStyle(color: Colors.white, fontSize: 17),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.soru.soru,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 14),
            if (_dogru)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${l.t('gd.correct')} ${widget.soru.cevap}',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              )
            else
              for (var i = 0; i < secenekler.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      final dogruMu = i == widget.soru.dogruIndex;
                      setState(() {
                        _secili = i;
                        _dogru = dogruMu;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        color: _secili == i
                            ? (_dogru
                                ? Colors.green.withValues(alpha: 0.25)
                                : Colors.red.withValues(alpha: 0.25))
                            : Renkler.seciliYuzey,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _secili == i
                              ? (_dogru ? Colors.greenAccent : Colors.redAccent)
                              : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        secenekler[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
            if (!_dogru && _secili != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  l.t('gd.wrongHint'),
                  style: const TextStyle(color: Colors.redAccent, fontSize: 11),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(l.t('gd.close')),
        ),
        FilledButton.icon(
          onPressed: _dogru ? () => Navigator.pop(context, true) : null,
          style: FilledButton.styleFrom(
            backgroundColor: Renkler.vurgu,
            foregroundColor: Colors.black,
          ),
          icon: const Icon(Icons.check, size: 18),
          label: Text(l.t('gd.complete')),
        ),
      ],
    );
  }
}

class ZikirSayaci extends StatefulWidget {
  const ZikirSayaci({super.key, required this.baslangic});

  final int baslangic;

  @override
  State<ZikirSayaci> createState() => _ZikirSayaciState();
}

class _ZikirSayaciState extends State<ZikirSayaci> {
  late int _sayi = widget.baslangic;
  late bool _tamam = _sayi >= 33;

  Future<void> _arttir() async {
    if (_tamam) return;
    final yeni = _sayi + 1;
    setState(() {
      _sayi = yeni;
      _tamam = yeni >= 33;
    });
    await GunlukHedefStore.zikirEkle(1);
    if (_tamam && mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Dialog(
      backgroundColor: Renkler.kart,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l.t('gd.dhikrTitle'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l.t('gd.dhikrSub'),
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 24),
            Text(
              '$_sayi / 33',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _tamam ? null : _arttir,
                style: FilledButton.styleFrom(
                  backgroundColor: Renkler.vurgu,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                child: Text(
                  _tamam ? l.t('gd.done') : l.t('gd.dhikrTap'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l.t('gd.close')),
            ),
          ],
        ),
      ),
    );
  }
}
