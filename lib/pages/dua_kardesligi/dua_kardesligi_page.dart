import 'package:flutter/material.dart';

import '../../services/renkler.dart';
import 'dua_kardesligi_store.dart';

class DuaKardesligiPage extends StatefulWidget {
  const DuaKardesligiPage({super.key});

  @override
  State<DuaKardesligiPage> createState() => _DuaKardesligiPageState();
}

class _DuaKardesligiPageState extends State<DuaKardesligiPage> {
  bool _hazir = false;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    await DuaKardesligiStore.yukle();
    if (mounted) setState(() => _hazir = true);
  }

  Future<void> _istekOlustur() async {
    final sonuc = await showModalBottomSheet<_YeniIstekSonuc>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Renkler.yuzey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => const _YeniIstekFormu(),
    );
    if (sonuc == null || !mounted) return;

    await DuaKardesligiStore.istekEkle(
      kategori: sonuc.kategori,
      metin: sonuc.metin,
      anonim: sonuc.anonim,
      sureSaat: sonuc.sureSaat,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dua isteğiniz yayınlandı. Rabbim kabul etsin.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: const Text('Dua Kardeşliği'),
        backgroundColor: Renkler.seciliYuzey,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _hazir ? _istekOlustur : null,
        backgroundColor: Renkler.vurgu,
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('Dua İste'),
      ),
      body: !_hazir
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white54),
            )
          : ValueListenableBuilder<int>(
              valueListenable: DuaKardesligiStore.surum,
              builder: (context, _, _) {
                final akis = DuaKardesligiStore.aktifAkis();
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: _HeaderBanner()),
                    SliverToBoxAdapter(child: _IstatistikKarti()),
                    SliverToBoxAdapter(child: _RozetlerBolumu()),
                    SliverToBoxAdapter(child: _bolumBasligi('🕊️ Akış')),
                    if (akis.isEmpty)
                      const SliverToBoxAdapter(child: _BosAkis())
                    else
                      SliverList.builder(
                        itemCount: akis.length,
                        itemBuilder: (context, index) {
                          final istek = akis[index];
                          return _DuaKarti(
                            istek: istek,
                            onAmin: () => DuaKardesligiStore.aminVer(istek.id),
                            onSikayet: () => _sikayetEt(istek),
                          );
                        },
                      ),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                );
              },
            ),
    );
  }

  Future<void> _sikayetEt(DuaIstegi istek) async {
    if (istek.benSikayetEttim) return;
    final onay = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Renkler.kart,
        title: const Text(
          'İçeriği şikâyet et',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Bu dua isteğini uygunsuz bulduğunuz için şikâyet ediyorsunuz. '
          '3 farklı kullanıcı şikâyet ederse kart otomatik kaldırılır.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Şikâyet Et'),
          ),
        ],
      ),
    );
    if (onay != true || !mounted) return;

    final kaldirildi = await DuaKardesligiStore.sikayetEt(istek.id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          kaldirildi
              ? 'İçerik şikâyetler nedeniyle kaldırıldı.'
              : 'Şikâyetiniz alındı. Teşekkürler.',
        ),
        backgroundColor: kaldirildi ? Colors.redAccent : Colors.blueGrey,
      ),
    );
  }

  Widget _bolumBasligi(String baslik) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        baslik,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _HeaderBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.bannerUst, Renkler.bannerAlt],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.vurgu.withValues(alpha: 0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.groups_outlined, color: Colors.white, size: 36),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Anonim Dua Ağı',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Kardeşlerin için dua iste, onların dualarına Amin de. '
                  'Tamamen gizli ve çevrimdışı çalışır.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IstatistikKarti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final aktif = DuaKardesligiStore.aktifIstekSayisi();
    final amin = DuaKardesligiStore.toplamAmin();
    final rozet = DuaKardesligiStore.kazanilanRozetler().length;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          _istatistik(aktif, 'Aktif Dua', Icons.hourglass_bottom),
          _istatistik(amin, 'Verilen Amin', Icons.favorite_outline),
          _istatistik(rozet, 'Rozet', Icons.emoji_events_outlined),
        ],
      ),
    );
  }

  Widget _istatistik(int deger, String ad, IconData ikon) {
    return Expanded(
      child: Container(
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
              '$deger',
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

class _RozetlerBolumu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final kazanilan = DuaKardesligiStore.kazanilanRozetler();
    final kazanilanIdler = {for (final r in kazanilan) r.id};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: const Text(
            '🏅 Rozetlerim',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 108,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: rozetler.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final r = rozetler[index];
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
                      r.aciklama,
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
        ),
      ],
    );
  }
}

class _DuaKarti extends StatelessWidget {
  const _DuaKarti({
    required this.istek,
    required this.onAmin,
    required this.onSikayet,
  });

  final DuaIstegi istek;
  final VoidCallback onAmin;
  final VoidCallback onSikayet;

  @override
  Widget build(BuildContext context) {
    final kategoriRenk = _kategoriRengi(istek.kategori);
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: kategoriRenk.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    istek.kategori,
                    style: TextStyle(
                      color: kategoriRenk,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _zamanMetni(istek.olusturma),
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              istek.metin,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  color: Colors.white38,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    istek.gorunenIsim,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (istek.ulkeEmoji.isNotEmpty)
                  Text(
                    '${istek.ulkeEmoji} ${istek.ulkeAdi}',
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                if (istek.benim) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Renkler.vurgu.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Benim',
                      style: TextStyle(
                        color: Renkler.vurgu,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 10),
            Row(
              children: [
                _sureKarti(),
                const Spacer(),
                _aminButonu(),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Şikâyet et',
                  onPressed: istek.benSikayetEttim ? null : onSikayet,
                  icon: Icon(
                    Icons.flag_outlined,
                    size: 20,
                    color: istek.benSikayetEttim
                        ? Colors.redAccent.withValues(alpha: 0.5)
                        : Colors.white38,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sureKarti() {
    final kalan = istek.olusturma
        .add(Duration(hours: istek.sureSaat))
        .difference(DateTime.now());
    final saat = kalan.inHours.clamp(0, 999);
    final sureEtiketi = istek.sureSaat == 24
        ? '24 saat'
        : istek.sureSaat == 72
            ? '3 gün'
            : '1 hafta';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '⏳ ${saat} sa  ·  $sureEtiketi',
        style: const TextStyle(color: Colors.white54, fontSize: 11),
      ),
    );
  }

  Widget _aminButonu() {
    final verdi = istek.benAminVerdim;
    return InkWell(
      onTap: onAmin,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: verdi ? Renkler.vurgu : Renkler.seciliYuzey,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: verdi
                ? Renkler.vurgu
                : Renkler.cerceve.withValues(alpha: 0.6),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🤲',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(width: 6),
            Text(
              'Amin · ${istek.aminSayisi}',
              style: TextStyle(
                color: verdi ? Colors.black : Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BosAkis extends StatelessWidget {
  const _BosAkis();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        children: [
          Text('🌙', style: TextStyle(fontSize: 40)),
          SizedBox(height: 12),
          Text(
            'Şu an aktif dua isteği yok.\n"+" butonuyla kardeşlerin için bir dua paylaş.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _YeniIstekSonuc {
  final String kategori;
  final String metin;
  final bool anonim;
  final int sureSaat;

  const _YeniIstekSonuc({
    required this.kategori,
    required this.metin,
    required this.anonim,
    required this.sureSaat,
  });
}

class _YeniIstekFormu extends StatefulWidget {
  const _YeniIstekFormu();

  @override
  State<_YeniIstekFormu> createState() => _YeniIstekFormuState();
}

class _YeniIstekFormuState extends State<_YeniIstekFormu> {
  final _metinController = TextEditingController();
  String _kategori = duaKategorileri.first;
  bool _anonim = true;
  int _sureSaat = 24;
  String? _hata;

  @override
  void dispose() {
    _metinController.dispose();
    super.dispose();
  }

  void _sablonSec(String sablon) {
    setState(() => _metinController.text = sablon);
  }

  void _paylas() {
    final metin = _metinController.text.trim();
    final hata = Moderasyon.sorunBul(metin);
    if (hata != null) {
      setState(() => _hata = hata);
      return;
    }
    Navigator.pop(
      context,
      _YeniIstekSonuc(
        kategori: _kategori,
        metin: metin,
        anonim: _anonim,
        sureSaat: _sureSaat,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final klavye = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: klavye),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Yeni Dua İsteği',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Center(
              child: Text(
                'Gizliliğiniz korunur: istekleriniz bu cihazda saklanır.',
                style: TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Kategori',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final k in duaKategorileri)
                  ChoiceChip(
                    label: Text(k),
                    selected: _kategori == k,
                    onSelected: (_) => setState(() => _kategori = k),
                    selectedColor: Renkler.vurgu,
                    backgroundColor: Renkler.kart,
                    labelStyle: TextStyle(
                      color: _kategori == k ? Colors.black : Colors.white70,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Dua Metni',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _metinController,
              maxLength: duaKarakterSiniri,
              maxLines: 4,
              minLines: 3,
              style: const TextStyle(color: Colors.white),
              onChanged: (_) {
                if (_hata != null) setState(() => _hata = null);
              },
              decoration: InputDecoration(
                hintText: 'Kardeşin için dileğini yaz...',
                hintStyle: const TextStyle(color: Colors.white38),
                counterStyle: const TextStyle(color: Colors.white38),
                errorText: _hata,
                filled: true,
                fillColor: Renkler.kart,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Hızlı şablonlar (boşlukları doldur):',
              style: TextStyle(color: Colors.white54, fontSize: 11),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final sablon in duaSablonlari[_kategori] ?? const [])
                  ActionChip(
                    label: Text(
                      sablon.length > 42
                          ? '${sablon.substring(0, 42)}...'
                          : sablon,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                      ),
                    ),
                    onPressed: () => _sablonSec(sablon),
                    backgroundColor: Renkler.seciliYuzey,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Anonimlik',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _anonim
                            ? 'İsimsiz paylaşılır'
                            : 'Profil adınızla paylaşılır',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _anonim,
                  onChanged: (v) => setState(() => _anonim = v),
                  activeThumbColor: Renkler.vurgu,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Yayında kalma süresi',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: [
                for (final (saat, etiket) in duaSureSecenekleri)
                  ButtonSegment(value: saat, label: Text(etiket)),
              ],
              selected: {_sureSaat},
              onSelectionChanged: (v) =>
                  setState(() => _sureSaat = v.first),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _paylas,
                style: FilledButton.styleFrom(
                  backgroundColor: Renkler.vurgu,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.send_outlined),
                label: const Text('Duayı Paylaş'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _kategoriRengi(String kategori) {
  switch (kategori) {
    case 'Şifa':
      return Colors.greenAccent;
    case 'Sınav / Eğitim':
      return Colors.blueAccent;
    case 'Borç / Sıkıntı':
      return Colors.orangeAccent;
    case 'Ailevi Durum':
      return Colors.pinkAccent;
    default:
      return Colors.tealAccent;
  }
}

String _zamanMetni(DateTime zaman) {
  final fark = DateTime.now().difference(zaman);
  if (fark.inMinutes < 1) return 'az önce';
  if (fark.inMinutes < 60) return '${fark.inMinutes} dk önce';
  if (fark.inHours < 24) return '${fark.inHours} sa önce';
  return '${fark.inDays} gün önce';
}
