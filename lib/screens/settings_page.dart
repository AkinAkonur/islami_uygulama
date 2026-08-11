import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../l10n/dil_hizmetleri.dart';
import '../pages/bildirimler_sayfasi.dart';
import '../pages/gizlilik_politikasi_page.dart';
import '../pages/profil_sayfasi.dart';
import '../pages/puanla_page.dart';
import '../services/ayarlar_store.dart';
import '../services/bildirim_merkezi.dart';
import '../services/gercek_bildirimler.dart';
import '../services/renkler.dart';
import '../services/vakit_servisi.dart';

class AyarlarSayfasi extends StatefulWidget {
  const AyarlarSayfasi({super.key});

  @override
  State<AyarlarSayfasi> createState() => _AyarlarSayfasiState();
}

class _AyarlarSayfasiState extends State<AyarlarSayfasi> {
  bool _karanlikMod = true;
  bool _konumOtomatik = true;
  bool _masterBildirim = true;
  String _metotKod = AyarlarStore.diyanetKod;
  String? _vurguKod;

static const List<({String kod, String ad})> _metotlar = [
    (kod: '13', ad: 'Diyanet İşleri Başkanlığı'),
    (kod: '3', ad: 'Müslüman Dünya Ligi (MWL)'),
    (kod: '2', ad: 'ISNA (Kuzey Amerika)'),
    (kod: '1', ad: 'Karaçi Üniversitesi'),
    (kod: '4', ad: "Ümmü'l-Kura (Mekke)"),
    (kod: '5', ad: 'Mısır Genel Araştırma Kurumu'),
  ];

  String _metotAd(AppLocalizations l) {
    for (final m in _metotlar) {
      if (m.kod == _metotKod) return m.ad;
    }
    return l.t('set.methodAuto');
  }

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final karanlik = await AyarlarStore.karanlikOku();
    final konum = await AyarlarStore.konumOtomatikOku();
    final master = await BildirimMerkezi.masterOku();
    final metot = await AyarlarStore.metotOku();
    final vurgu = await AyarlarStore.vurguOku();
    if (!mounted) return;
    setState(() {
      _karanlikMod = karanlik;
      _konumOtomatik = konum;
      _masterBildirim = master;
      _metotKod = metot ?? '';
      _vurguKod = vurgu;
    });
  }

  Future<void> _karanlikDegistir(bool deger) async {
    await AyarlarStore.karanlikYaz(deger);
    if (mounted) setState(() => _karanlikMod = deger);
  }

  Future<void> _konumDegistir(bool deger) async {
    await AyarlarStore.konumOtomatikYaz(deger);
    if (mounted) setState(() => _konumOtomatik = deger);
    if (deger) {
      // GPS ile konumu al, şehri bul ve vakit önbelleğini yenile.
      final sonuc = await VakitServisi.konumuOtomatikAl();
      if (!mounted) return;
      if (sonuc == KonumSonuc.basarili) {
        final sehir = await VakitServisi.sehirOku() ?? 'konumun algılandı';
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)
                  .t('s.locUpdated')
                  .replaceAll('{sehir}', sehir),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        if (!mounted) return;
        // Başarısızsa kullanıcı Konum sayfasından manuel şehir seçebilir.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).t('s.locFail'),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  Future<void> _masterBildirimDegistir(bool deger) async {
    await BildirimMerkezi.masterYaz(deger);
    await BildirimMerkezi.guncelle();
    await GercekBildirimler.planla();
    if (mounted) {
      setState(() => _masterBildirim = deger);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).t(
              deger ? 's.notifOn' : 's.notifOff',
            ),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _metotSec() async {
    final l = AppLocalizations.of(context);
    final secilen = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        backgroundColor: const Color(0xFF14382B),
        title: Text(
          l.t('set.methodDialog'),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        children: [
          for (final m in _metotlar)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, m.kod),
              child: Row(
                children: [
                  Icon(
                    m.kod == _metotKod
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Renkler.vurgu,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.ad,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          l.t('m.${m.kod}'),
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 6, 24, 18),
          child: Text(
            l.t('set.methodInfo'),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
        ],
      ),
    );
    if (secilen == null || secilen == _metotKod || !mounted) return;

    await AyarlarStore.metotYaz(secilen);
    // Önbelleğe takılmadan yeni yöntemle API'den yeniden çek. Bu, ana
    // ekrandaki vakit kartlarının da anında güncellenmesini sağlar.
    await VakitServisi.vakitleriYenile();
    await GercekBildirimler.planla();
    if (!mounted) return;
    setState(() => _metotKod = secilen);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l.t('s.methodUpdated')),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _gizlilikGoster() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const GizlilikPolitikasiSayfasi()),
    );
  }

  Future<void> _vurguSec() async {
    final l = AppLocalizations.of(context);
    const secenekler = [
      (kod: null, renk: null),
      (kod: 'zumrut', renk: Color(0xFF10B981)),
      (kod: 'mavi', renk: Color(0xFF3B82F6)),
      (kod: 'altin', renk: Color(0xFFF2C14E)),
      (kod: 'turkuaz', renk: Color(0xFF14B8A6)),
      (kod: 'gul', renk: Color(0xFFEC4899)),
    ];
    final secilen = await showDialog<String?>(
      context: context,
      builder: (ctx) => SimpleDialog(
        backgroundColor: const Color(0xFF14382B),
        title: Text(
          l.t('set.accentDialog'),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
            child: Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                for (final s in secenekler)
                  GestureDetector(
                    onTap: () => Navigator.pop(ctx, s.kod),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: s.renk ?? const Color(0xFF0F291E),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: s.kod == _vurguKod
                              ? Colors.white
                              : s.renk ?? const Color(0xFF395244),
                          width: s.kod == _vurguKod ? 3 : 1,
                        ),
                      ),
                      child: s.kod == _vurguKod
                          ? const Icon(Icons.check, color: Colors.white, size: 24)
                          : (s.renk == null
                              ? const Icon(Icons.auto_awesome,
                                  color: Colors.white54, size: 20)
                              : null),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 6, 24, 18),
            child: Text(
              l.t('set.accentInfo'),
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
    if (secilen == _vurguKod || !mounted) return;

    await AyarlarStore.vurguYaz(secilen);
    if (!mounted) return;
    setState(() => _vurguKod = secilen);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l.t('s.accentUpdated')),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _puanlaGoster() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PuanlaSayfasi()),
    );
  }

  String _aktifDilAdi() {
    final kod = DilHizmetleri.aktifDil.value.languageCode;
    for (final secenek in DilHizmetleri.secenekler) {
      if (secenek.kod == kod) return secenek.ad;
    }
    return 'Türkçe';
  }

  String _vurguAdi(AppLocalizations l) {
    if (_vurguKod == null) return l.t('c.auto');
    return l.t('c.$_vurguKod');
  }

  Future<void> _dilSec() async {
    final l = AppLocalizations.of(context);
    final aktifKod = DilHizmetleri.aktifDil.value.languageCode;
    final secilen = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        backgroundColor: const Color(0xFF14382B),
        title: Text(
          l.t('set.chooseLang'),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        children: [
          for (final secenek in DilHizmetleri.secenekler)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, secenek.kod),
              child: Row(
                children: [
                  Icon(
                    secenek.kod == aktifKod
                        ? Icons.radio_button_checked
                        : Icons.radio_button_unchecked,
                    color: Renkler.vurgu,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    secenek.ad,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
    if (secilen == null || secilen == aktifKod || !mounted) return;
    await DilHizmetleri.sec(secilen);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).t('set.langUpdated')),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0F291E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF14382B),
        title: Text(l.t('set.title'), style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _bolumBasligi(l.t('set.account')),
          _ayarSecenegi(
            Icons.person_outline,
            l.t('set.editProfile'),
            altMetin: l.t('set.editProfileAlt'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilSayfasi()),
              );
            },
          ),

          const SizedBox(height: 20),
          _bolumBasligi(l.t('set.time')),
          _ayarSwitch(
            Icons.location_on_outlined,
            l.t('set.autoLoc'),
            l.t('set.autoLocAlt'),
            _konumOtomatik,
            _konumDegistir,
          ),
          _ayarSecenegi(
            Icons.calculate_outlined,
            l.t('set.method'),
            altMetin: _metotAd(l),
            onTap: _metotSec,
          ),

          const SizedBox(height: 20),
          _bolumBasligi(l.t('set.notif')),
          _ayarSwitch(
            Icons.notifications_active_outlined,
            l.t('set.notifAll'),
            l.t('set.notifAllAlt'),
            _masterBildirim,
            _masterBildirimDegistir,
          ),
          _ayarSecenegi(
            Icons.tune_outlined,
            l.t('set.notifCenter'),
            altMetin: l.t('set.notifCenterAlt'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BildirimlerSayfasi()),
              );
            },
          ),

          const SizedBox(height: 20),
          _bolumBasligi(l.t('set.langSection')),
          _ayarSecenegi(
            Icons.language,
            l.t('set.lang'),
            altMetin: _aktifDilAdi(),
            onTap: _dilSec,
          ),

          const SizedBox(height: 20),
          _bolumBasligi(l.t('set.appearance')),
          _ayarSecenegi(
            Icons.color_lens_outlined,
            l.t('set.accent'),
            altMetin: _vurguAdi(l),
            onTap: _vurguSec,
          ),
          _ayarSwitch(
            Icons.dark_mode_outlined,
            l.t('set.dark'),
            l.t('set.darkAlt'),
            _karanlikMod,
            _karanlikDegistir,
          ),

          const SizedBox(height: 20),
          _bolumBasligi(l.t('set.about')),
          _ayarSecenegi(
            Icons.info_outline,
            l.t('set.privacy'),
            onTap: _gizlilikGoster,
          ),
          _ayarSecenegi(
            Icons.star_rate_outlined,
            l.t('set.rate'),
            onTap: _puanlaGoster,
          ),
          const SizedBox(height: 20),

          Center(
            child: Text(
              l.t('set.version'),
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _bolumBasligi(String baslik) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(
        baslik,
        style: TextStyle(
          color: Renkler.vurgu,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _ayarSecenegi(
    IconData ikon,
    String baslik, {
    String? altMetin,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF14382B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(ikon, color: Colors.white70, size: 20),
      ),
      title: Text(
        baslik,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      subtitle: altMetin != null
          ? Text(
              altMetin,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            )
          : null,
      trailing: const Icon(Icons.arrow_forward_ios,
          color: Colors.white54, size: 16),
      onTap: onTap,
    );
  }

  Widget _ayarSwitch(
    IconData ikon,
    String baslik,
    String aciklama,
    bool deger,
    Future<void> Function(bool) onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF14382B),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(ikon, color: Colors.white70, size: 20),
      ),
      title: Text(
        baslik,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      subtitle: Text(
        aciklama,
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
      trailing: Switch(
        value: deger,
        onChanged: (v) => onChanged(v),
        activeThumbColor: Renkler.vurgu,
      ),
    );
  }
}
