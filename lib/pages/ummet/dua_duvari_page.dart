import 'package:flutter/material.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

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

  Future<void> _duaEt(DuaIstek istek) async {
    await UmmetStore.duaEt(istek.id);
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${istek.rumuz} için dua ettin. 🤲 Birlikte güçlüyüz.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.of(context).popUntil((r) => r.isFirst);
  }

  Future<void> _istekEkle() async {
    final formKey = GlobalKey<FormState>();
    final rumuzCtrl = TextEditingController();
    final metinCtrl = TextEditingController();
    var kategori = duaKategorileri.first['ad']!;

    final eklendi = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: Renkler.kart,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            'Dua İsteği Paylaş',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: rumuzCtrl,
                    style: TextStyle(color: Colors.white),
                    decoration: _dekor(
                      'Rumuz (boş bırakırsan anonim)',
                      Icons.badge_outlined,
                    ),
                  ),
                  SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: kategori,
                    dropdownColor: Renkler.seciliYuzey,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: _dekor('Kategori', Icons.category_outlined),
                    items: duaKategorileri
                        .map((k) => DropdownMenuItem(
                              value: k['ad'],
                              child: Text('${k['ikon']} ${k['ad']}'),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setDialogState(() => kategori = val);
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: metinCtrl,
                    maxLines: 3,
                    maxLength: 200,
                    style: TextStyle(color: Colors.white),
                    decoration: _dekor('Dua isteğin', Icons.favorite_outline),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Dua isteğinizi yazın' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Vazgeç', style: TextStyle(color: Colors.white54)),
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
              child: Text('Paylaş', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );

    if (eklendi == true && mounted) {
      final rumuz = rumuzCtrl.text.trim();
      final yeni = DuaIstek(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        rumuz: rumuz.isEmpty ? 'Anonim Kardeş' : rumuz,
        metin: metinCtrl.text.trim(),
        kategori: kategori,
        anonim: rumuz.isEmpty,
      );
      await UmmetStore.duaIstekEkle(yeni);
      await _yukle();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Duvarına eklendi; ümmet senin için dua edecek. 🤲'),
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
      hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
      prefixIcon: Icon(ikon, color: Renkler.vurgu, size: 20),
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
    final filtreli = _filtreli;
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          'Canlı Dua Duvarı',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Renkler.vurgu,
        foregroundColor: Renkler.zemin,
        onPressed: _istekEkle,
        icon: Icon(Icons.add),
        label: Text('Dua İsteği',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _yukleniyor
          ? Center(
              child: CircularProgressIndicator(color: Renkler.vurgu),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(16, 12, 16, 4),
                  padding: EdgeInsets.all(14),
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
                      Icon(Icons.volunteer_activism,
                          color: Renkler.vurgu, size: 22),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '"Dua eden kardeşinin arkasından hayırla dua eden kimseye melekler: âmin, senin de hakkında aynısı olsun, derler."',
                          style: TextStyle(
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
                SizedBox(height: 10),
                SizedBox(
                  height: 44,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      for (final k in ['Tümü', ...duaKategorileri.map((k) => k['ad']!)])
                        Padding(
                          padding: EdgeInsets.only(right: 8),
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
                SizedBox(height: 8),
                Expanded(
                  child: filtreli.isEmpty
                      ? Center(
                          child: Text(
                            'Bu kategoride dua isteği yok.\nİlk isteği sen paylaş! 🤲',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white54, fontSize: 13),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.fromLTRB(16, 4, 16, 90),
                          itemCount: filtreli.length,
                          itemBuilder: (context, i) =>
                              _duaKarti(context, filtreli[i]),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _duaKarti(BuildContext context, DuaIstek istek) {
    return Card(
      color: Renkler.kart,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Renkler.cerceve),
      ),
      child: Padding(
        padding: EdgeInsets.all(14),
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
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    istek.rumuz,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            SizedBox(height: 10),
            Text(
              istek.metin,
              style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.favorite, color: Color(0xFFEF5350), size: 16),
                SizedBox(width: 6),
                Text(
                  '${binlikSayi(istek.duaSayisi)} kardeş dua etti',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
                Spacer(),
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Renkler.vurgu,
                    foregroundColor: Renkler.zemin,
                    padding: EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    textStyle: TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _duaEt(istek),
                  icon: Icon(Icons.volunteer_activism, size: 16),
                  label: Text('Senin İçin Dua Ettim'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
