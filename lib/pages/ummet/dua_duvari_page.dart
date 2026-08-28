import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';
import '../../widgets/kart_sekilleri.dart';

class DuaDuvariPage extends StatefulWidget {
  const DuaDuvariPage({super.key});

  @override
  State<DuaDuvariPage> createState() => _DuaDuvariPageState();
}

class _DuaDuvariPageState extends State<DuaDuvariPage> {
  List<DuaIstek> _istekler = [];
  String _seciliKategori = 'Tümü';
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final liste = await UmmetStore.duaIstekleriYukle();
    if (!mounted) return;
    setState(() {
      _istekler = liste;
      _yukleniyor = false;
    });
  }

  List<DuaIstek> get _filtreli => _seciliKategori == 'Tümü'
      ? _istekler
      : _istekler.where((i) => i.kategori == _seciliKategori).toList();

  Future<void> _duaEt(DuaIstek istek, AppLocalizations l) async {
    await UmmetStore.duaEt(istek.id);
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l.t('dw.prayedSnackbar').replaceAll('{name}', istek.rumuz),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  Future<void> _istekEkle(AppLocalizations l) async {
    final formKey = GlobalKey<FormState>();
    final rumuzCtrl = TextEditingController();
    final metinCtrl = TextEditingController();
    var kategori = duaKategorileri.first['ad']!;

    final eklendi = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: Renkler.kart,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            l.t('dw.share'),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: rumuzCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: _dekor(l.t('dw.nickname'), Icons.badge_rounded),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: kategori,
                    dropdownColor: Renkler.seciliYuzey,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: _dekor(
                      l.t('dw.category'),
                      Icons.category_rounded,
                    ),
                    items: duaKategorileri
                        .map(
                          (k) => DropdownMenuItem(
                            value: k['ad'],
                            child: Text('${k['ikon']} ${k['ad']}'),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => kategori = val);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: metinCtrl,
                    maxLines: 3,
                    maxLength: 200,
                    style: const TextStyle(color: Colors.white),
                    decoration: _dekor(
                      l.t('dw.prayerText'),
                      Icons.favorite_outline_rounded,
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? l.t('dw.prayerHint')
                        : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                l.t('dw.cancel'),
                style: const TextStyle(color: Colors.white54),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Renkler.vurgu,
                foregroundColor: Renkler.zemin,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context, true);
                }
              },
              child: Text(
                l.t('dw.shareButton'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );

    if (eklendi == true && mounted) {
      final rumuz = rumuzCtrl.text.trim();
      final yeni = DuaIstek(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rumuz: rumuz.isEmpty ? l.t('dw.anonymous') : rumuz,
        metin: metinCtrl.text.trim(),
        kategori: kategori,
        anonim: rumuz.isEmpty,
      );
      await UmmetStore.duaIstekEkle(yeni);
      await _yukle();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.t('dw.addedSnackbar')),
          backgroundColor: Renkler.bannerUst,
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).popUntil((r) => r.isFirst);
    }
  }

  InputDecoration _dekor(String hint, IconData ikon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
      prefixIcon: UcdIkon(ikon: ikon, renk: Renkler.vurgu, boyut: 20),
      filled: true,
      fillColor: Renkler.yuzey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final filtreli = _filtreli;
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('dw.title'),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Renkler.vurgu,
        foregroundColor: Renkler.zemin,
        onPressed: () => _istekEkle(l),
        icon: const UcdIkon(
          ikon: Icons.add_rounded,
          renk: Colors.white,
          boyut: 24,
        ),
        label: Text(
          l.t('dw.request'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _yukleniyor
          ? Center(child: CircularProgressIndicator(color: Renkler.vurgu))
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Renkler.bannerUst, Renkler.bannerAlt],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      UcdIkon(
                        ikon: Icons.volunteer_activism_rounded,
                        renk: Renkler.vurgu,
                        boyut: 22,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l.t('dw.hadis'),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 44,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      for (final k in [
                        l.t('dw.all'),
                        ...duaKategorileri.map((k) => k['ad']!),
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(k),
                            selected: _seciliKategori == k,
                            onSelected: (_) =>
                                setState(() => _seciliKategori = k),
                            selectedColor: Renkler.vurgu,
                            backgroundColor: Renkler.kart,
                            labelStyle: TextStyle(
                              color: _seciliKategori == k
                                  ? Renkler.zemin
                                  : Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: filtreli.isEmpty
                      ? Center(
                          child: Text(
                            l.t('dw.empty'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                          itemCount: filtreli.length,
                          itemBuilder: (context, i) =>
                              _duaKarti(context, filtreli[i], l),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _duaKarti(BuildContext context, DuaIstek istek, AppLocalizations l) {
    return Card(
      color: Renkler.kart,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Renkler.yuzey,
                  child: Text(
                    istek.rumuz.characters.first.toUpperCase(),
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    istek.rumuz,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Renkler.bannerUst,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    istek.kategori,
                    style: TextStyle(
                      color: Renkler.acikVurgu,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              istek.metin,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const UcdIkon(
                  ikon: Icons.favorite_rounded,
                  renk: Color(0xFFEF5350),
                  boyut: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  l
                      .t('dw.prayedCount')
                      .replaceAll('{count}', binlikSayi(istek.duaSayisi)),
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const Spacer(),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Renkler.vurgu,
                    foregroundColor: Renkler.zemin,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => _duaEt(istek, l),
                  icon: UcdIkon(
                    ikon: Icons.volunteer_activism_rounded,
                    renk: Renkler.zemin,
                    boyut: 16,
                  ),
                  label: Text(l.t('dw.prayButton')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
