import 'package:flutter/material.dart';

import '../services/dua_store.dart';
import '../services/dualar_verileri.dart';
import '../services/renkler.dart';
import 'dua_detay_page.dart';

// ===========================================================================
// DUALAR BÖLÜMÜ - ANA SAYFA
// Kategoriler (durum/zaman odaklı), anında arama, favoriler ve
// "Kendi Dualarım" alanı tek sayfada. Tüm içerik çevrimdışı çalışır.
// ===========================================================================

class DualarPage extends StatefulWidget {
  const DualarPage({super.key});

  @override
  State<DualarPage> createState() => _DualarPageState();
}

class _DualarPageState extends State<DualarPage> {
  final TextEditingController _aramaController = TextEditingController();
  String _arama = '';
  List<DuaKategori>? _kategoriler;
  bool _hata = false;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    await DuaStore.yukle();
    try {
      final kategoriler = await DualarVerileri.instance.kategorileriYukle();
      if (mounted) setState(() => _kategoriler = kategoriler);
    } catch (_) {
      if (mounted) setState(() => _hata = true);
    }
    // Bulut tabanlı içerik (lazy-load): gömülü liste hemen gösterilirken
    // arka planda uzak JSON denenir; güncellenirse liste yenilenir.
    final yenilendi = await DualarVerileri.uzaktanYenile();
    if (yenilendi && mounted) {
      try {
        final kategoriler = await DualarVerileri.instance.kategorileriYukle();
        if (mounted) setState(() => _kategoriler = kategoriler);
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    _aramaController.dispose();
    super.dispose();
  }

  void _duaAc(BuildContext context, DuaKaydi dua, String kategoriAdi) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DuaDetayPage(dua: dua, kategoriAdi: kategoriAdi),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Renkler.zemin,
        appBar: AppBar(
          backgroundColor: Renkler.zemin,
          title: const Text(
            'Manevi Dualar Hazinesi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            indicatorColor: Renkler.vurgu,
            labelColor: Renkler.vurgu,
            unselectedLabelColor: Colors.white54,
            tabs: const [
              Tab(text: 'Kategoriler'),
              Tab(text: 'Favoriler'),
              Tab(text: 'Kendi Dualarım'),
            ],
          ),
        ),
        body: Column(
          children: [
            _AramaCubugu(
              controller: _aramaController,
              onChanged: (v) => setState(() => _arama = v),
            ),
            Expanded(
              child: _hata
                  ? const Center(
                      child: Text(
                        'Dua verileri yüklenemedi.',
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : _kategoriler == null
                      ? Center(child: CircularProgressIndicator(color: Renkler.vurgu))
                      : _arama.isNotEmpty
                          ? _AramaSonuclari(sorgu: _arama, onAc: _duaAc)
                          : TabBarView(
                              children: [
                                _KategorilerListesi(
                                  kategoriler: _kategoriler!,
                                  onKategori: (k) => _kategoriAc(context, k),
                                ),
                                _FavorilerListesi(onAc: _duaAc),
                                _OzDualarListesi(onAc: _duaAc),
                              ],
                            ),
            ),
          ],
        ),
      ),
    );
  }

  void _kategoriAc(BuildContext context, DuaKategori kategori) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DuaKategoriPage(kategori: kategori),
      ),
    );
  }
}

// ===========================================================================
// ARAMA
// ===========================================================================
class _AramaCubugu extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _AramaCubugu({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Ara: borç, uyku, sınav, korunma…',
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
          prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 20),
          suffixIcon: controller.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white38, size: 18),
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                ),
          filled: true,
          fillColor: Renkler.kart,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Renkler.cerceve),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Renkler.vurgu),
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// ARAMA SONUÇLARI
// ===========================================================================
class _AramaSonuclari extends StatelessWidget {
  final String sorgu;
  final void Function(BuildContext, DuaKaydi, String) onAc;

  const _AramaSonuclari({required this.sorgu, required this.onAc});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DuaKaydi>>(
      future: DualarVerileri.instance.ara(sorgu),
      builder: (context, snp) {
        if (!snp.hasData) {
          return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
        }
        final sonuclar = snp.data!;
        if (sonuclar.isEmpty) {
          return const Center(
            child: Text(
              'Sonuç bulunamadı. Farklı bir kelime deneyin.',
              style: TextStyle(color: Colors.white54, fontSize: 13),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          itemCount: sonuclar.length,
          itemBuilder: (context, i) {
            final dua = sonuclar[i];
            return _DuaKarti(
              dua: dua,
              kategoriAdi: 'Arama',
              onTap: () => onAc(context, dua, 'Arama'),
            );
          },
        );
      },
    );
  }
}

// ===========================================================================
// KATEGORİ LİSTESİ
// ===========================================================================
class _KategorilerListesi extends StatelessWidget {
  final List<DuaKategori> kategoriler;
  final void Function(DuaKategori) onKategori;

  const _KategorilerListesi({
    required this.kategoriler,
    required this.onKategori,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: kategoriler.length,
      itemBuilder: (context, i) {
        final k = kategoriler[i];
        final renk = _hexRenk(k.renkHex);
        return GestureDetector(
          onTap: () => onKategori(k),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Renkler.cerceve),
            ),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: renk.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(k.emoji, style: const TextStyle(fontSize: 26)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        k.ad,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${k.duaSayisi} dua · ${k.gruplar.length} bölüm',
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: renk, size: 22),
              ],
            ),
          ),
        );
      },
    );
  }
}

Color _hexRenk(String hex) {
  var h = hex.replaceFirst('#', '');
  if (h.length == 6) h = 'FF$h';
  return Color(int.tryParse(h, radix: 16) ?? 0xFFF2C14E);
}

// ===========================================================================
// KATEGORİ DETAY (gruplar + dualar)
// ===========================================================================
class DuaKategoriPage extends StatelessWidget {
  final DuaKategori kategori;

  const DuaKategoriPage({super.key, required this.kategori});

  @override
  Widget build(BuildContext context) {
    final renk = _hexRenk(kategori.renkHex);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        backgroundColor: Renkler.zemin,
        title: Text(
          '${kategori.emoji} ${kategori.ad}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: kategori.gruplar.length,
        itemBuilder: (context, i) {
          final grup = kategori.gruplar[i];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 18,
                      decoration: BoxDecoration(
                        color: renk,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        grup.ad,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              for (final dua in grup.dualar)
                _DuaKarti(
                  dua: dua,
                  kategoriAdi: kategori.ad,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DuaDetayPage(
                          dua: dua,
                          kategoriAdi: kategori.ad,
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

// ===========================================================================
// DUA KARTI (liste öğesi)
// ===========================================================================
class _DuaKarti extends StatelessWidget {
  final DuaKaydi dua;
  final String kategoriAdi;
  final VoidCallback onTap;

  const _DuaKarti({
    required this.dua,
    required this.kategoriAdi,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: DuaStore.favoriler,
      builder: (context, fav, _) {
        final favori = fav.contains(dua.id);
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Renkler.kart,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: favori ? Colors.redAccent.withValues(alpha: 0.4) : Renkler.cerceve,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Renkler.seciliYuzey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.auto_awesome_outlined,
                    color: Renkler.vurgu,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dua.baslik,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dua.meal,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          height: 1.35,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          if (dua.tekrar != null && dua.tekrar! > 0)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: _Etiket('🔁 ${dua.tekrar}x'),
                            ),
                          if (dua.sesUrl != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: _Etiket('🔊 Sesli'),
                            ),
                          if (dua.etiketler.isNotEmpty)
                            _Etiket('#${dua.etiketler.first}'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                GestureDetector(
                  onTap: () => DuaStore.favoriDegistir(dua.id),
                  child: Icon(
                    favori ? Icons.favorite : Icons.favorite_border,
                    color: favori ? Colors.redAccent : Colors.white30,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Etiket extends StatelessWidget {
  final String metin;
  const _Etiket(this.metin);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        metin,
        style: TextStyle(color: Renkler.vurgu, fontSize: 10),
      ),
    );
  }
}

// ===========================================================================
// FAVORİLER
// ===========================================================================
class _FavorilerListesi extends StatelessWidget {
  final void Function(BuildContext, DuaKaydi, String) onAc;

  const _FavorilerListesi({required this.onAc});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DuaKaydi>>(
      future: DualarVerileri.instance.tumDualar(),
      builder: (context, snp) {
        if (!snp.hasData) {
          return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
        }
        final tum = snp.data!;
        return ValueListenableBuilder<Set<String>>(
          valueListenable: DuaStore.favoriler,
          builder: (context, fav, _) {
            final favoriler =
                tum.where((d) => fav.contains(d.id)).toList();
            if (favoriler.isEmpty) {
              return const _BosMesaj(
                ikon: Icons.favorite_border,
                metin:
                    'Henüz favori duanız yok.\nBeğendiğiniz duaları yıldızla işaretleyin.',
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              itemCount: favoriler.length,
              itemBuilder: (context, i) {
                final dua = favoriler[i];
                return _DuaKarti(
                  dua: dua,
                  kategoriAdi: 'Favoriler',
                  onTap: () => onAc(context, dua, 'Favoriler'),
                );
              },
            );
          },
        );
      },
    );
  }
}

// ===========================================================================
// KENDİ DUALARIM
// ===========================================================================
class _OzDualarListesi extends StatelessWidget {
  final void Function(BuildContext, DuaKaydi, String) onAc;

  const _OzDualarListesi({required this.onAc});

  Future<void> _yeniDua(BuildContext context) async {
    final baslik = TextEditingController();
    final metin = TextEditingController();
    final form = GlobalKey<FormState>();
    final eklendi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Renkler.kart,
        title: const Text(
          'Kendi Duamı Ekle',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        content: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: baslik,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: _giris('Dua başlığı (örn: Evladım için)'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Başlık girin'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: metin,
                maxLines: 4,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: _giris('Duayı veya notunuzu yazın'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Dua metni girin'
                    : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Vazgeç', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Renkler.vurgu,
              foregroundColor: Colors.black87,
            ),
            onPressed: () {
              if (form.currentState!.validate()) {
                Navigator.pop(context, true);
              }
            },
            child: const Text('Kaydet'),
          ),
        ],
      ),
    );
    if (eklendi == true && baslik.text.trim().isNotEmpty) {
      await DuaStore.ozDuaEkle(baslik.text.trim(), metin.text.trim());
    }
  }

  InputDecoration _giris(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
        filled: true,
        fillColor: Renkler.yuzey,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Renkler.cerceve),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Renkler.vurgu),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<OzDua>>(
      valueListenable: DuaStore.ozDualar,
      builder: (context, liste, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Renkler.seciliYuzey,
                    foregroundColor: Renkler.vurgu,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => _yeniDua(context),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Yeni dua / not ekle'),
                ),
              ),
            ),
            Expanded(
              child: liste.isEmpty
                  ? const _BosMesaj(
                      ikon: Icons.edit_note,
                      metin:
                          'Kendi özel dualarınızı ve notlarınızı\nburaya yazıp saklayabilirsiniz.',
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: liste.length,
                      itemBuilder: (context, i) {
                        final oz = liste[i];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Renkler.kart,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Renkler.cerceve),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      oz.baslik,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      oz.metin,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        height: 1.4,
                                      ),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                tooltip: 'Sil',
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.white30,
                                  size: 20,
                                ),
                                onPressed: () => DuaStore.ozDuaSil(oz.id),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _BosMesaj extends StatelessWidget {
  final IconData ikon;
  final String metin;

  const _BosMesaj({required this.ikon, required this.metin});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(ikon, color: Colors.white24, size: 44),
          const SizedBox(height: 12),
          Text(
            metin,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white38, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }
}
