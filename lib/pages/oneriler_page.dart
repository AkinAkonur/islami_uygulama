// ===========================================================================
// ÖNERİ & HATA BİLDİR
// ---------------------------------------------------------------------------
// Ayarlar > Hakkında'da yer alır. Kullanıcı; önerisini veya karşılaştığı
// yanlışlığı yazar, "E-posta ile Gönder" ile cihazındaki posta uygulamasında
// konu ve mesaj hazır hâlde proje sahibinin adresine gönderir.
// ===========================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/app_localizations.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class OnerilerPage extends StatefulWidget {
  const OnerilerPage({super.key});

  @override
  State<OnerilerPage> createState() => _OnerilerPageState();
}

class _OnerilerPageState extends State<OnerilerPage> {
  /// Proje sahibinin e-posta adresi (uygulama-çapı hedef adres).
  static const _destekEposta = 'islamiuygulama@outlook.com';

  final _mesajController = TextEditingController();
  int _tip = 0; // 0: Öneri, 1: Hata Bildir, 2: Diğer

  @override
  void dispose() {
    _mesajController.dispose();
    super.dispose();
  }

  String _tipAdi(AppLocalizations l) {
    return switch (_tip) {
      0 => l.t('on.ok'),
      1 => l.t('on.bug'),
      _ => l.t('on.other'),
    };
  }

  void _bilgi(AppLocalizations l, String mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mesaj), duration: const Duration(seconds: 3)),
    );
  }

  Future<void> _gonder(AppLocalizations l) async {
    final metin = _mesajController.text.trim();
    if (metin.isEmpty) {
      _bilgi(l, l.t('on.empty'));
      return;
    }

    final konu = '${_tipAdi(l)} - İslami Uygulama';
    final uri = Uri.parse(
      'mailto:$_destekEposta?subject=${Uri.encodeQueryComponent(konu)}'
      '&body=${Uri.encodeQueryComponent(metin)}',
    );
    try {
      final acildi = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!acildi) await _kopyalaVeBilgi(l);
    } catch (_) {
      await _kopyalaVeBilgi(l);
    }
  }

  Future<void> _kopyalaVeBilgi(AppLocalizations l) async {
    final metin = _mesajController.text.trim();
    if (metin.isNotEmpty) {
      try {
        await Clipboard.setData(ClipboardData(text: metin));
      } catch (_) {}
    }
    _bilgi(l, l.t('on.sendFail'));
  }

  Future<void> _kopyala(AppLocalizations l) async {
    final metin = _mesajController.text.trim();
    if (metin.isEmpty) {
      _bilgi(l, l.t('on.empty'));
      return;
    }
    try {
      await Clipboard.setData(ClipboardData(text: metin));
    } catch (_) {}
    _bilgi(l, l.t('on.copied'));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(l.t('on.title')),
        backgroundColor: Renkler.seciliYuzey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l.t('on.subtitle'),
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: Row(
              children: [
                const UcdIkon(ikon: Icons.mark_email_read_outlined, renk: Colors.white70, boyut: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.t('on.to'),
                        style: const TextStyle(color: Colors.white38, fontSize: 11),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _destekEposta,
                        style: TextStyle(
                          color: Renkler.vurgu,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 4),
            child: Text(
              l.t('on.type'),
              style: TextStyle(
                color: Renkler.vurgu,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final (kod, ad) in [(0, l.t('on.ok')), (1, l.t('on.bug')), (2, l.t('on.other'))])
                ChoiceChip(
                  label: Text(ad),
                  selected: _tip == kod,
                  onSelected: (_) => setState(() => _tip = kod),
                  selectedColor: Renkler.vurgu,
                  backgroundColor: Renkler.kart,
                  labelStyle: TextStyle(
                    color: _tip == kod ? Colors.black : Colors.white70,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 18),

          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4),
            child: Text(
              l.t('on.message'),
              style: TextStyle(
                color: Renkler.vurgu,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            controller: _mesajController,
            maxLines: 6,
            minLines: 4,
            style: const TextStyle(color: Colors.white),
            onChanged: (_) {},
            decoration: InputDecoration(
              hintText: l.t('on.messageHint'),
              hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
              filled: true,
              fillColor: Renkler.yuzey,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Renkler.cerceve),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Renkler.cerceve2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Renkler.vurgu.withValues(alpha: 0.6)),
              ),
            ),
          ),
          const SizedBox(height: 16),

          ElevatedButton.icon(
            onPressed: () => _gonder(l),
            icon: const UcdIkon(ikon: Icons.send_rounded, renk: Colors.black, boyut: 18),
            label: Text(
              l.t('on.send'),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Renkler.vurgu,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => _kopyala(l),
            icon: const UcdIkon(ikon: Icons.copy_rounded, renk: Colors.white54, boyut: 16),
            label: Text(
              l.t('on.copy'),
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l.t('on.sendHint'),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white38, fontSize: 11.5, height: 1.5),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}