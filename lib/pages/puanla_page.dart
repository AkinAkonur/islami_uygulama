import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';

/// Uygulamayı Puanla sayfası. Ayarlar menüsünden açılır; yıldızlı derecelendirme,
/// geri bildirim ve kalıcı puan kaydı sunar.
class PuanlaSayfasi extends StatefulWidget {
  const PuanlaSayfasi({super.key});

  @override
  State<PuanlaSayfasi> createState() => _PuanlaSayfasiState();
}

class _PuanlaSayfasiState extends State<PuanlaSayfasi> {
  static const _puanAnahtar = 'ayar_puan';
  static const _geribildirimAnahtar = 'ayar_puan_geribildirim';
  static const _gonderildiAnahtar = 'ayar_puan_gonderildi';

  int? _seciliPuan;
  final TextEditingController _geriBildirim = TextEditingController();
  bool _gonderildi = false;

  @override
  void initState() {
    super.initState();
    _kayitliYukle();
  }

  @override
  void dispose() {
    _geriBildirim.dispose();
    super.dispose();
  }

  Future<void> _kayitliYukle() async {
    final p = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _seciliPuan = p.getInt(_puanAnahtar);
      _gonderildi = p.getBool(_gonderildiAnahtar) == true;
    });
  }

  String _durumEtiketi(AppLocalizations l) {
    if (_seciliPuan == null) return '';
    return l.t('r.etiket$_seciliPuan');
  }

  String _durumEmoji() {
    if (_seciliPuan == null) return '🤲';
    return switch (_seciliPuan) {
      1 => '😞',
      2 => '😕',
      3 => '🙂',
      4 => '😊',
      _ => '🥰',
    };
  }

  Future<void> _puaniKaydet() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt(_puanAnahtar, _seciliPuan!);
    if (_geriBildirim.text.trim().isNotEmpty) {
      final gecerli = p.getStringList(_geribildirimAnahtar) ?? [];
      gecerli.add('Puan $_seciliPuan: ${_geriBildirim.text.trim()}');
      await p.setStringList(_geribildirimAnahtar, gecerli);
    }
    if (_seciliPuan! <= 3 && _geriBildirim.text.trim().isNotEmpty) {
      await p.setBool(_gonderildiAnahtar, true);
    }
    if (!mounted) return;
    setState(() => _gonderildi = true);
    final l = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l.t('r.kaydedildi')),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final karanlik = Theme.of(context).brightness == Brightness.dark;
    final zeminRenk = karanlik ? Renkler.zemin : const Color(0xFFF3F6F2);
    final kartRenk = karanlik ? Renkler.kart : Colors.white;
    final metinRenk = karanlik ? Colors.white : const Color(0xFF1C2B24);
    final altMetinRenk = karanlik ? Colors.white54 : const Color(0xFF5A6B62);

    return Scaffold(
      backgroundColor: zeminRenk,
      appBar: AppBar(
        backgroundColor: kartRenk,
        title: Text(
          l.t('set.rate'),
          style: TextStyle(
            color: karanlik ? Colors.white : const Color(0xFF1C2B24),
          ),
        ),
        iconTheme: IconThemeData(
          color: karanlik ? Colors.white : const Color(0xFF1C2B24),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Başlık kartı
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Renkler.bannerUst, Renkler.bannerAlt],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Text(_durumEmoji(), style: const TextStyle(fontSize: 44)),
                const SizedBox(height: 10),
                Text(
                  l.t(_seciliPuan == null ? 'r.baslik' : 'r.baslikPuanli'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l.t('r.altBaslik'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Yıldızlı puan seçimi
          Text(
            l.t('r.soru'),
            style: TextStyle(
              color: metinRenk,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: kartRenk,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Renkler.cerceve2, width: 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 1; i <= 5; i++) _yildiz(i),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _seciliPuan == null ? '—' : _durumEtiketi(l),
                  style: TextStyle(
                    color: Renkler.vurgu,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Puan seçildiyse dinamik içerik
          if (_seciliPuan != null) ...[
            if (_seciliPuan! <= 3)
              _geriBildirimKarti(l, karanlik, kartRenk, metinRenk, altMetinRenk)
            else
              _tesekkurKarti(l, karanlik, kartRenk, metinRenk, altMetinRenk),
            const SizedBox(height: 16),
          ],

          // Puan seçilmediyse ipucu
          if (_seciliPuan == null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kartRenk,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Renkler.cerceve2, width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: Renkler.vurgu, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l.t('r.ipucu'),
                      style: TextStyle(
                        color: altMetinRenk,
                        fontSize: 12,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 20),
          Center(
            child: Text(
              l.t('r.not'),
              textAlign: TextAlign.center,
              style: TextStyle(color: altMetinRenk, fontSize: 11, height: 1.5),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _yildiz(int deger) {
    final dolmus = _seciliPuan != null && deger <= _seciliPuan!;
    return GestureDetector(
      onTap: () => setState(() {
        _seciliPuan = deger;
        _gonderildi = false;
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Icon(
          dolmus ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 40,
          color: dolmus ? const Color(0xFFF2C14E) : Renkler.cerceve,
        ),
      ),
    );
  }

  Widget _geriBildirimKarti(
    AppLocalizations l,
    bool karanlik,
    Color kartRenk,
    Color metinRenk,
    Color altMetinRenk,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kartRenk,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.cerceve2, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.feedback_outlined, color: Renkler.vurgu, size: 20),
              const SizedBox(width: 8),
              Text(
                l.t('r.oneriBaslik'),
                style: TextStyle(
                  color: metinRenk,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _geriBildirim,
            maxLines: 4,
            maxLength: 500,
            style: TextStyle(color: metinRenk, fontSize: 13),
            decoration: InputDecoration(
              hintText: l.t('r.oneriIpucu'),
              hintStyle: TextStyle(color: altMetinRenk, fontSize: 13),
              filled: true,
              fillColor: karanlik ? Renkler.yuzey : const Color(0xFFF3F6F2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Renkler.cerceve2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Renkler.cerceve2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Renkler.vurgu, width: 1.5),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Renkler.vurgu,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _gonderildi ? null : _puaniKaydet,
              child: Text(
                _gonderildi ? l.t('r.gonderildi') : l.t('r.gonder'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (_gonderildi) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.check_circle, color: Renkler.vurgu, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.t('r.gonderildiMetin'),
                    style: TextStyle(color: altMetinRenk, fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _tesekkurKarti(
    AppLocalizations l,
    bool karanlik,
    Color kartRenk,
    Color metinRenk,
    Color altMetinRenk,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kartRenk,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Renkler.cerceve2, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.volunteer_activism_outlined, color: Renkler.vurgu, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l.t('r.tesekkurBaslik'),
                  style: TextStyle(
                    color: metinRenk,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            l.t('r.tesekkurMetin'),
            style: TextStyle(
              color: altMetinRenk,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: Renkler.vurgu,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _puaniKaydet,
              icon: const Icon(Icons.favorite, size: 18),
              label: Text(
                l.t('r.kaydet'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
