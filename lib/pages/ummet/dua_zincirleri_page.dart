import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';
import '../../widgets/kart_sekilleri.dart';

class DuaZincirleriPage extends StatefulWidget {
  const DuaZincirleriPage({super.key});

  @override
  State<DuaZincirleriPage> createState() => _DuaZincirleriPageState();
}

class _DuaZincirleriPageState extends State<DuaZincirleriPage> {
  final Map<String, int> _paylar = {};
  bool _yukleniyor = true;
  List<DuaZinciri> _zincirler = [];
  final TextEditingController _aramaCtrl = TextEditingController();
  String _aramaSorgusu = '';

  @override
  void initState() {
    super.initState();
    _aramaCtrl.addListener(() {
      setState(() => _aramaSorgusu = _aramaCtrl.text);
    });
    _yukle();
  }

  @override
  void dispose() {
    _aramaCtrl.dispose();
    super.dispose();
  }

  List<DuaZinciri> get _filtreli {
    final s = _aramaSorgusu.trim().toLowerCase();
    if (s.isEmpty) return _zincirler;
    return _zincirler
        .where((z) =>
            z.ad.toLowerCase().contains(s) ||
            z.detay.toLowerCase().contains(s) ||
            z.duaMetni.toLowerCase().contains(s))
        .toList();
  }

  Future<void> _yukle() async {
    final zincirler = await UmmetStore.tumZincirler();
    final paylar = <String, int>{};
    for (final z in zincirler) {
      paylar[z.id] = await UmmetStore.zincirPayi(z.id);
    }
    if (!mounted) return;
    setState(() {
      _zincirler = zincirler;
      _paylar.addAll(paylar);
      _yukleniyor = false;
    });
  }

  Future<void> _katil(DuaZinciri zincir, int adet) async {
    final l = AppLocalizations.of(context);
    await UmmetStore.zincirKatil(zincir.id, adet);
    if (!mounted) return;
    setState(() {
      _paylar[zincir.id] = (_paylar[zincir.id] ?? 0) + adet;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l.t('dz.assumed')
              .replaceFirst('{count}', '$adet')
              .replaceFirst('{name}', zincir.ad),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  Future<void> _zincirEkleDialog() async {
    final l = AppLocalizations.of(context);
    final formKey = GlobalKey<FormState>();
    final adCtrl = TextEditingController();
    final duaCtrl = TextEditingController();
    var seciliSure = l.t('dz.duaText');
    var seciliHedef = 1000;

    final tema = Theme.of(context);
    final sureSecenekleri = [
      l.t('dz.duaText'),
      'Yâsîn',
      'Fetih Suresi',
      'Salavat-ı Şerife',
      'Seyyidü\'l-İstiğfar',
      'Ayetü\'l-Kürsi',
    ];
    final eklendi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: Renkler.kart,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            l.t('dz.dialogTitle'),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: tema.textTheme.titleLarge?.fontFamily,
            ),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: adCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: _dekor(
                      l.t('dz.nameHint'),
                      Icons.link_rounded,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: seciliSure,
                    dropdownColor: Renkler.yuzey,
                    style: const TextStyle(color: Colors.white),
                    items: sureSecenekleri
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                    onChanged: (v) =>
                        setDialogState(() => seciliSure = v ?? seciliSure),
                    decoration: _dekor(null, Icons.book_outlined),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: duaCtrl,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 3,
                    maxLength: 300,
                    decoration: _dekor(
                      l.t('dz.duaHint'),
                      Icons.format_quote_outlined,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: seciliHedef,
                    dropdownColor: Renkler.yuzey,
                    style: const TextStyle(color: Colors.white),
                    items: [100, 1000, 5000, 10000, 100000]
                        .map((h) => DropdownMenuItem(
                            value: h,
                            child: Text(l.t('dz.target')
                                .replaceFirst('{count}', binlikSayi(h)))))
                        .toList(),
                    onChanged: (v) =>
                        setDialogState(() => seciliHedef = v ?? seciliHedef),
                    decoration: _dekor(null, Icons.flag_outlined),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l.t('dz.cancel'), style: const TextStyle(color: Colors.white54)),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Renkler.vurgu),
              onPressed: () async {
                if (adCtrl.text.trim().isEmpty || duaCtrl.text.trim().isEmpty) {
                  return;
                }
                Navigator.of(dialogContext).pop(true);
              },
              child: Text(l.t('dz.create'), style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );

    if (eklendi != true) {
      adCtrl.dispose();
      duaCtrl.dispose();
      return;
    }

    final zincir = await UmmetStore.zincirEkle(
      ad: adCtrl.text.trim(),
      detay: l.t('dz.globalTarget')
          .replaceFirst('{count}', binlikSayi(seciliHedef))
          .replaceFirst('{sure}', seciliSure),
      duaMetni: duaCtrl.text.trim(),
      hedef: seciliHedef,
    );
    adCtrl.dispose();
    duaCtrl.dispose();
    if (!mounted) return;
    setState(() {
      _zincirler.insert(0, zincir);
      _paylar[zincir.id] = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l.t('dz.created').replaceFirst('{name}', zincir.ad),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _zinciriSil(DuaZinciri zincir) async {
    final l = AppLocalizations.of(context);
    await UmmetStore.zincirSil(zincir.id);
    if (!mounted) return;
    setState(() {
      _zincirler.removeWhere((z) => z.id == zincir.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l.t('dz.deleted').replaceFirst('{name}', zincir.ad),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  InputDecoration _dekor(String? hint, IconData ikon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white38),
      prefixIcon: UcdIkon(ikon: ikon, renk: Colors.white54),
      filled: true,
      fillColor: Renkler.yuzey,
      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Renkler.cerceve2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Renkler.cerceve2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Renkler.vurgu, width: 1.5),
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
          l.t('dz.title'),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: l.t('dz.createTooltip'),
            onPressed: _zincirEkleDialog,
            icon: UcdIkon(ikon: Icons.link_rounded, renk: Colors.white),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _zincirEkleDialog,
        backgroundColor: Renkler.vurgu,
        foregroundColor: Colors.white,
        icon: UcdIkon(ikon: Icons.add_rounded, renk: Colors.white),
        label: Text(l.t('dz.createFab')),
      ),
      body: _yukleniyor
          ? Center(child: CircularProgressIndicator(color: Renkler.vurgu))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: TextField(
                    controller: _aramaCtrl,
                    style: const TextStyle(color: Colors.white),
                    decoration: _dekor(
                      l.t('dz.searchHint'),
                      Icons.search_rounded,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Renkler.bannerUst, Renkler.bannerAlt],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                UcdIkon(ikon: Icons.link_rounded, renk: Renkler.vurgu, boyut: 20),
                                const SizedBox(width: 8),
                                Text(
                                  l.t('dz.joinTitle'),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l.t('dz.joinIntro'),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l.t('dz.countInfo')
                            .replaceFirst('{total}', '${_zincirler.length}')
                            .replaceFirst('{shown}', '${_filtreli.length}'),
                        style: const TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      if (filtreli.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Center(
                            child: Column(
                              children: [
                                const UcdIkon(ikon: Icons.search_off, renk: Colors.white24, boyut: 44),
                                const SizedBox(height: 10),
                                Text(
                                  l.t('dz.noResults'),
                                  style: const TextStyle(
                                      color: Colors.white38, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        for (final zincir in filtreli) ...[
                          _zincirKarti(zincir, l),
                          const SizedBox(height: 12),
                        ],
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _zincirKarti(DuaZinciri zincir, AppLocalizations l) {
    final pay = _paylar[zincir.id] ?? 0;
    final mevcut = zincir.taban + pay;
    final oran = (mevcut / zincir.hedef).clamp(0.0, 1.0);

    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: zincir.kullanicidan ? Renkler.vurgu : Renkler.cerceve, width: zincir.kullanicidan ? 1.4 : 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    zincir.ad,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: zincir.kullanicidan
                        ? Renkler.yuzey
                        : Renkler.bannerUst,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    zincir.kullanicidan
                        ? l.t('dz.yourChain')
                        : '${binlikSayi(mevcut)} / ${binlikSayi(zincir.hedef)}',
                    style: TextStyle(
                      color: zincir.kullanicidan
                          ? Renkler.vurgu
                          : Renkler.acikVurgu,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              zincir.detay,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: oran,
                minHeight: 8,
                backgroundColor: Renkler.yuzey,
                valueColor: AlwaysStoppedAnimation<Color>(Renkler.vurgu),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '"${zincir.duaMetni}"',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (pay > 0) ...[
                  UcdIkon(ikon: Icons.check_circle_rounded, renk: Renkler.vurgu, boyut: 16),
                  const SizedBox(width: 6),
                  Text(
                    l.t('dz.yourShare').replaceFirst('{count}', binlikSayi(pay)),
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                const Spacer(),
                if (zincir.kullanicidan)
                  IconButton(
                    tooltip: l.t('dz.deleteTooltip'),
                    onPressed: () => _zinciriSil(zincir),
                    icon: UcdIkon(ikon: Icons.delete_outline_rounded, renk: Colors.redAccent, boyut: 20),
                  ),
                for (final adet in [1, 5, 10]) ...[
                  if (adet > 1) const SizedBox(width: 6),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Renkler.vurgu,
                      side: BorderSide(color: Renkler.cerceve2),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      minimumSize: const Size(0, 36),
                    ),
                    onPressed: () => _katil(zincir, adet),
                    child: Text('+$adet'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
