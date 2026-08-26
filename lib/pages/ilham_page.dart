// ===========================================================================
// İLHAM VE HİKMET KÖŞESİ
// ---------------------------------------------------------------------------
// 5 modül: Günün Âyeti & Tefekkür · Hadis-i Şerif & Rehberlik · Alim Sözleri ·
// "Bunu Biliyor Muydunuz?" · Günün Duası/Niyeti.
//
// ÖZELLİKLER:
// • Günün Akışı: tarihe göre rotasyonla her kategoriden bugünün içeriği.
// • Arşiv: "Geçmiş Günler" yalnızca sekme açılınca yüklenir (lazy) + bulut
//   tazeleme butonu.
// • Favoriler: beğenilen içerikler cihazda saklanır.
// • Görsel kart paylaşımı: kart kodu tarafında üretilir (gradient şablon),
//   sunucudan resim indirilmez.
// • Hatırlatıcı: kullanıcının seçtiği saatte "Günün İlhamı" bildirimi.
//
// İçerik: gömülü havuz (assets/ilham_hikmet.json) + uzak JSON
// (ilham_hikmet.json) ile bulut tabanlı; uygulama şişmez.
// ===========================================================================

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../services/gercek_bildirimler.dart';
import '../services/ilham_store.dart';
import '../services/ilham_verileri.dart';
import '../services/renkler.dart';
import '../widgets/kart_sekilleri.dart';

class IlhamPage extends StatefulWidget {
  const IlhamPage({super.key});

  @override
  State<IlhamPage> createState() => _IlhamPageState();
}

class _IlhamPageState extends State<IlhamPage> {
  final Map<String, GlobalKey> _kartAnahtarlari = {};
  bool _paylasiliyor = false;

  GlobalKey _anahtar(String bolge, String id) =>
      _kartAnahtarlari.putIfAbsent('$bolge:$id', () => GlobalKey());

  @override
  void initState() {
    super.initState();
    // Bulut tabanlı içerik (lazy-load): sayfa açılınca uzak JSON denenir,
    // başarılıysa akış güncellenir; çevrimdışıysa gömülü/önbellek kalır.
    IlhamVerileri.uzaktanYenile();
  }

  Future<void> _favoriDegistir(String id) async {
    await IlhamStore.favoriDegistir(id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Renkler.seciliYuzey,
          content: Text(
            IlhamStore.favoriMi(id)
                ? 'Favori ilhamlarınıza eklendi ❤️'
                : 'Favorilerden çıkarıldı.',
          ),
          duration: const Duration(milliseconds: 1500),
        ),
      );
    }
  }

  Future<void> _paylas(IlhamIcerik icerik, String bolge) async {
    if (_paylasiliyor) return;
    setState(() => _paylasiliyor = true);
    try {
      final boyut = _kartAnahtarlari['$bolge:${icerik.id}']?.currentContext?.size;
      if (boyut == null) throw Exception('Kart hazırlanamadı');
      final boundary = _kartAnahtarlari['$bolge:${icerik.id}']!.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      final resim = await boundary.toImage(pixelRatio: 3);
      final byteData = await resim.toByteData(format: ui.ImageByteFormat.png);
      resim.dispose();
      if (byteData == null) throw Exception('Görsel oluşturulamadı');

      final dizin = await getTemporaryDirectory();
      final dosya = File('${dizin.path}/ilham_${icerik.id}.png');
      await dosya.writeAsBytes(byteData.buffer.asUint8List());

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(dosya.path, mimeType: 'image/png')],
          text: '${icerik.kaynak} ✨ #islamiUygulama',
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paylaşım hazırlanamadı: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _paylasiliyor = false);
    }
  }

  Future<void> _hatirlaticiAc(BuildContext context) async {
    final mevcut = IlhamStore.hatirlatma.value;
    TimeOfDay zaman = mevcut != null
        ? TimeOfDay(hour: mevcut.saat, minute: mevcut.dakika)
        : const TimeOfDay(hour: 8, minute: 30);

    final kaydedildi = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Renkler.kart,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setLocal) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 18,
            bottom: 28 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const UcdIkon(ikon: Icons.wb_twilight_rounded, renk: Colors.orangeAccent, boyut: 22),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Günün İlhamı Hatırlatıcısı',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Kapat',
                    icon: const UcdIkon(ikon: Icons.close_rounded, renk: Colors.white38),
                    onPressed: () => Navigator.pop(ctx, false),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Her gün seçtiğiniz saatte günün hikmetli sözü '
                'bildirim olarak gelecek.',
                style: TextStyle(color: Colors.white54, fontSize: 12.5, height: 1.4),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final secilen = await showTimePicker(
                    context: ctx,
                    initialTime: zaman,
                    builder: (c, child) => Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: const ColorScheme.dark(
                          primary: Colors.orangeAccent,
                          surface: Color(0xFF1D2B23),
                        ),
                        timePickerTheme: const TimePickerThemeData(
                          backgroundColor: Color(0xFF1D2B23),
                          hourMinuteTextColor: Colors.white,
                          dayPeriodTextColor: Colors.white,
                          dialHandColor: Colors.orangeAccent,
                        ),
                      ),
                      child: child!,
                    ),
                  );
                  if (secilen != null) setLocal(() => zaman = secilen);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Renkler.seciliYuzey,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const UcdIkon(ikon: Icons.access_time_rounded, renk: Colors.white70, boyut: 20),
                      const SizedBox(width: 10),
                      Text(
                        'Saat: ${zaman.format(context)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(ctx, true),
                icon: const UcdIkon(ikon: Icons.notifications_active_outlined, renk: Colors.orangeAccent, boyut: 18),
                label: const Text(
                  'Hatırlatıcıyı Kaydet',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (mevcut != null) ...[
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, 'sil'),
                  style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                  child: const Text('Hatırlatıcıyı Kaldır'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    if (!mounted) return;
    if (kaydedildi == true) {
      await IlhamStore.hatirlatmaKaydet(
        IlhamHatirlatma(saat: zaman.hour, dakika: zaman.minute),
      );
      await GercekBildirimler.ilhamHatirlatmasiPlanla();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hatırlatıcı kuruldu ✨')),
        );
      }
    } else if (kaydedildi == 'sil') {
      await IlhamStore.hatirlatmaKaldir();
      await GercekBildirimler.ilhamHatirlatmasiPlanla();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hatırlatıcı kaldırıldı.')),
        );
      }
    }
  }

  Future<void> _bulutuTazele() async {
    final yenilendi = await IlhamVerileri.uzaktanYenile(zorla: true);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Renkler.seciliYuzey,
        content: Text(
          yenilendi
              ? 'İlham içeriği güncellendi ✨'
              : 'Şu an sunucudan güncelleme alınamadı; cihazdaki içerik gösteriliyor.',
        ),
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
          title: const Text(
            'İlham & Hikmet Köşesi',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF2D1E1E),
          actions: [
            IconButton(
              tooltip: 'Bulut içeriği tazele',
              icon: const UcdIkon(ikon: Icons.refresh, renk: Colors.white70),
              onPressed: _bulutuTazele,
            ),
            ValueListenableBuilder<IlhamHatirlatma?>(
              valueListenable: IlhamStore.hatirlatma,
              builder: (context, kayit, _) => IconButton(
                tooltip: kayit != null
                    ? 'Günün ilhamı · ${kayit.saatYaz} (düzenle)'
                    : 'Günün ilhamı hatırlatıcısı kur',
                icon: UcdIkon(
                  ikon: kayit != null ? Icons.alarm_on : Icons.alarm_add,
                  renk: kayit != null ? Colors.orangeAccent : Colors.white70,
                ),
                onPressed: () => _hatirlaticiAc(context),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.orangeAccent,
            labelColor: Colors.orangeAccent,
            unselectedLabelColor: Colors.white54,
            tabs: const [
              Tab(text: 'Günün Akışı'),
              Tab(text: 'Arşiv'),
              Tab(text: 'Favoriler'),
            ],
          ),
        ),
        body: FutureBuilder<void>(
          future: IlhamStore.yukle(),
          builder: (context, _) => const TabBarView(
            children: [
              _GununAkisiTab(),
              _ArsivTab(),
              _FavorilerTab(),
            ],
          ),
        ),
      ),
    );
  }
}

// ===========================================================================
// GÜNÜN AKIŞI
// ===========================================================================
class _GununAkisiTab extends StatelessWidget {
  const _GununAkisiTab();

  static String _tarihYaz(DateTime t) {
    const aylar = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
    ];
    const gunler = [
      '', 'Pazartesi', 'Salı', 'Çarşamba', 'Perşembe',
      'Cuma', 'Cumartesi', 'Pazar',
    ];
    return '${gunler[t.weekday]}, ${t.day} ${aylar[t.month - 1]} ${t.year}';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IlhamIcerik>>(
      future: IlhamVerileri.instance.gununAkisi(),
      builder: (context, snp) {
        if (!snp.hasData) {
          return Center(child: CircularProgressIndicator(color: Colors.orangeAccent));
        }
        final akis = snp.data!;
        if (akis.isEmpty) {
          return const Center(
            child: Text(
              'Bugünün içeriği henüz hazır değil.',
              style: TextStyle(color: Colors.white54),
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF2D1E1E),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const UcdIkon(ikon: Icons.wb_sunny_rounded, renk: Colors.orangeAccent, boyut: 18),
                  const SizedBox(width: 8),
                  Text(
                    _tarihYaz(DateTime.now()),
                    style: const TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            for (final icerik in akis) ...[
              _IlhamKarti(icerik: icerik),
              const SizedBox(height: 14),
            ],
            Center(
              child: Text(
                'İçerikler günlük olarak sunucudan yenilenir 🌙',
                style: TextStyle(color: Colors.white24, fontSize: 11),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ===========================================================================
// ARŞİV (lazy: yalnızca sekme açılınca yüklenir)
// ===========================================================================
class _ArsivTab extends StatelessWidget {
  const _ArsivTab();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, Object>>>(
      future: IlhamVerileri.instance.arsivGunleri(geriye: 7),
      builder: (context, snp) {
        if (!snp.hasData) {
          return Center(child: CircularProgressIndicator(color: Colors.orangeAccent));
        }
        final gunler = snp.data!;
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
          children: [
            const Text(
              'Geçmiş Günler',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Önceki günlerin ilhamları yalnızca buraya dokunduğunuzda '
              'yüklenir (lazy).',
              style: TextStyle(color: Colors.white38, fontSize: 12),
            ),
            const SizedBox(height: 12),
            for (final gun in gunler) ...[
              _ArsivGunu(veri: gun),
              const SizedBox(height: 8),
            ],
          ],
        );
      },
    );
  }
}

class _ArsivGunu extends StatelessWidget {
  final Map<String, Object> veri;

  const _ArsivGunu({required this.veri});

  String get _tarihYaz {
    final t = veri['tarih']! as DateTime;
    const aylar = [
      'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
      'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
    ];
    const gunler = [
      '', 'Pazartesi', 'Salı', 'Çarşamba', 'Perşembe',
      'Cuma', 'Cumartesi', 'Pazar',
    ];
    return '${gunler[t.weekday]}, ${t.day} ${aylar[t.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final icerikler = veri['icerikler']! as List<IlhamIcerik>;
    return Container(
      decoration: BoxDecoration(
        color: Renkler.kart,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Renkler.cerceve),
      ),
      child: ExpansionTile(
        leading: const UcdIkon(ikon: Icons.history, renk: Colors.orangeAccent, boyut: 20),
        title: Text(
          _tarihYaz,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${icerikler.length} modül · dokununca açılır',
          style: const TextStyle(color: Colors.white38, fontSize: 11.5),
        ),
        iconColor: Colors.orangeAccent,
        collapsedIconColor: Colors.white38,
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final icerik in icerikler) ...[
            _ArsivMiniKarti(icerik: icerik),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _ArsivMiniKarti extends StatelessWidget {
  final IlhamIcerik icerik;

  const _ArsivMiniKarti({required this.icerik});

  @override
  Widget build(BuildContext context) {
    final renk = _ArsivMiniKarti.renk(icerik.kategori);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Renkler.seciliYuzey.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UcdIkon(ikon: _kategoriIkon(icerik.kategori), renk: renk, boyut: 15),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  icerik.kategori.ad,
                  style: TextStyle(color: renk, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            icerik.baslik,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            icerik.metin,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white54, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '— ${icerik.kaynak}',
              style: TextStyle(color: renk.withValues(alpha: 0.9), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  static Color renk(IlhamKategori k) {
    switch (k) {
      case IlhamKategori.ayet:
        return Colors.greenAccent;
      case IlhamKategori.hadis:
        return Colors.amberAccent;
      case IlhamKategori.alim:
        return Colors.pinkAccent;
      case IlhamKategori.bilgi:
        return Colors.lightBlueAccent;
      case IlhamKategori.dua:
        return Colors.tealAccent;
    }
  }
}

// ===========================================================================
// FAVORİLER
// ===========================================================================
class _FavorilerTab extends StatelessWidget {
  const _FavorilerTab();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Set<String>>(
      valueListenable: IlhamStore.favoriler,
      builder: (context, fav, _) {
        if (fav.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const UcdIkon(ikon: Icons.favorite_border_rounded, renk: Colors.white24, boyut: 44),
                const SizedBox(height: 12),
                Text(
                  'Henüz favori ilhamınız yok.\n'
                  'Beğendiğiniz içerikteki kalp simgesine dokunun.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white38, fontSize: 13, height: 1.5),
                ),
              ],
            ),
          );
        }
        return FutureBuilder<List<IlhamIcerik>>(
          future: _favoriIcerikler(fav),
          builder: (context, snp) {
            if (!snp.hasData) {
              return Center(
                child: CircularProgressIndicator(color: Colors.orangeAccent),
              );
            }
            final liste = snp.data!;
            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
              children: [
                for (final icerik in liste) ...[
                  _IlhamKarti(icerik: icerik, bolge: 'favoriler'),
                  const SizedBox(height: 14),
                ],
              ],
            );
          },
        );
      },
    );
  }

  Future<List<IlhamIcerik>> _favoriIcerikler(Set<String> fav) async {
    final sonuc = <IlhamIcerik>[];
    for (final id in fav) {
      final i = await IlhamVerileri.instance.idIleBul(id);
      if (i != null) sonuc.add(i);
    }
    return sonuc;
  }
}

// ===========================================================================
// İLHAM KARTI (aynı kart paylaşıma da basılır)
// ===========================================================================
IconData _kategoriIkon(IlhamKategori k) {
  switch (k) {
    case IlhamKategori.ayet:
      return Icons.menu_book_outlined;
    case IlhamKategori.hadis:
      return Icons.auto_stories_outlined;
    case IlhamKategori.alim:
      return Icons.emoji_objects_outlined;
    case IlhamKategori.bilgi:
      return Icons.lightbulb_outline;
    case IlhamKategori.dua:
      return Icons.volunteer_activism_outlined;
  }
}

/// Paylaşım kartı arka plan şablonları (schema: paylasim_gorsel_arkaplan).
List<Color> _arkaPlanRenkleri(String anahtar) {
  switch (anahtar) {
    case 'linear_gradient_emerald':
      return const [Color(0xFF059669), Color(0xFF065F46)];
    case 'linear_gradient_gold':
      return const [Color(0xFFD97706), Color(0xFF92400E)];
    case 'linear_gradient_teal':
      return const [Color(0xFF0D9488), Color(0xFF134E4A)];
    case 'linear_gradient_rose':
      return const [Color(0xFFE11D48), Color(0xFF881337)];
    case 'linear_gradient_indigo':
      return const [Color(0xFF6366F1), Color(0xFF312E81)];
    case 'linear_gradient_night':
      return const [Color(0xFF6D28D9), Color(0xFF1E1B4B)];
    default:
      return const [Color(0xFF6D28D9), Color(0xFF1E1B4B)];
  }
}

class _IlhamKarti extends StatelessWidget {
  final IlhamIcerik icerik;
  final String bolge;

  const _IlhamKarti({required this.icerik, this.bolge = 'akis'});

  @override
  Widget build(BuildContext context) {
    final renkler = _arkaPlanRenkleri(icerik.arkaPlan);
    final kategori = icerik.kategori;
    final kartAnahtari = (context.findAncestorStateOfType<_IlhamPageState>())
        ?._anahtar(bolge, icerik.id);

    Widget kart() => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: renkler,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: renkler.last.withValues(alpha: 0.35),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  UcdIkon(ikon: _kategoriIkon(kategori), renk: Colors.white70, boyut: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      kategori.ad,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                icerik.baslik,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (icerik.ek != null && icerik.ek!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    icerik.ek!,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.92),
                      fontSize: 13,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                icerik.metin,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 14),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '— ${icerik.kaynak}',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (icerik.etiketler.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final e in icerik.etiketler.take(4))
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '#$e',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        );

    if (kartAnahtari == null) return kart();
    return RepaintBoundary(
      key: kartAnahtari,
      child: Column(
        children: [
          kart(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ValueListenableBuilder<Set<String>>(
                valueListenable: IlhamStore.favoriler,
                builder: (context, fav, _) {
                  final favori = fav.contains(icerik.id);
                  return IconButton(
                    tooltip: favori ? 'Favorilerden çıkar' : 'Favorilere ekle',
                    icon: UcdIkon(
                      ikon: favori ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      renk: favori ? Colors.redAccent : Colors.white38,
                      boyut: 22,
                    ),
                    onPressed: () => (context
                            .findAncestorStateOfType<_IlhamPageState>())
                        ?._favoriDegistir(icerik.id),
                  );
                },
              ),
              const SizedBox(width: 4),
              IconButton(
                tooltip: 'Görsel kart olarak paylaş',
                icon: const UcdIkon(
                  ikon: Icons.share_outlined,
                  renk: Colors.white54,
                  boyut: 22,
                ),
                onPressed: () => (context
                        .findAncestorStateOfType<_IlhamPageState>())
                    ?._paylas(icerik, bolge),
              ),
            ],
          ),
        ],
      ),
    );
  }
}