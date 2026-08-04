import 'package:flutter/material.dart';
import '../services/manevi_store.dart';
import '../services/renkler.dart';

class GunlukGorevPage extends StatefulWidget {
  const GunlukGorevPage({super.key});

  @override
  State<GunlukGorevPage> createState() => _GunlukGorevPageState();
}

class _GunlukGorevPageState extends State<GunlukGorevPage> {
  Set<String> _gorevler = {};
  Set<String> _namaz = {};
  int _seri = 0;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final gorevler = await ManeviStore.bugunGorevler();
    final namaz = await ManeviStore.bugunNamaz();
    final seri = await ManeviStore.seriOku();
    if (mounted) {
      setState(() {
        _gorevler = gorevler;
        _namaz = namaz;
        _seri = seri;
      });
    }
  }

  Future<void> _gorevTikla(String id, bool tamam) async {
    final yeni = await ManeviStore.gorevTikla(id, tamam);
    final seri = await ManeviStore.seriOku();
    if (mounted) {
      setState(() {
        _gorevler = yeni;
        _seri = seri;
      });
    }
  }

  Future<void> _namazTikla(String vakit, bool tamam) async {
    final yeni = await ManeviStore.namazTikla(vakit, tamam);
    final seri = await ManeviStore.seriOku();
    if (mounted) {
      setState(() {
        _namaz = yeni;
        _seri = seri;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final tumGorev = ManeviStore.gorevler.every((g) => _gorevler.contains(g['id']));
    final tumNamaz = ManeviStore.namazVakitleri.every(_namaz.contains);
    final bugunBitti = tumGorev && tumNamaz;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Renkler.bannerUst, Renkler.bannerAlt],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _baslikSatiri(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _seriKarti(bugunBitti),
                    const SizedBox(height: 16),
                    _namazKarti(),
                    const SizedBox(height: 16),
                    _gorevKarti(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baslikSatiri(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const SizedBox(width: 8),
          const Text(
            'Günlük Görevler',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(Icons.local_fire_department_outlined,
              color: Colors.white54),
        ],
      ),
    );
  }

  Widget _seriKarti(bool bugunBitti) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Renkler.vurgu, Renkler.vurgu.withValues(alpha: 0.55)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text('🔥',
              style: TextStyle(fontSize: bugunBitti ? 34 : 28)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$_seri günlük seri',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  bugunBitti
                      ? 'Bugünün tüm görevlerini tamamladın, serin korundu!'
                      : 'Görevlerini ve 5 vaktini tamamla, serini büyüt.',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _namazKarti() {
    final tamam = ManeviStore.namazVakitleri.where(_namaz.contains).length;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.mosque_outlined, color: Renkler.vurgu, size: 20),
              const SizedBox(width: 8),
              Text(
                'Namaz · 5 Vakit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '$tamam/5',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...ManeviStore.namazVakitleri.map((v) => _kontrolSatiri(
                etiket: '$v Namazı',
                ikon: Icons.check_circle,
                deger: _namaz.contains(v),
                onChanged: (t) => _namazTikla(v, t),
              )),
        ],
      ),
    );
  }

  Widget _gorevKarti() {
    final tamam = ManeviStore.gorevler.where((g) => _gorevler.contains(g['id'])).length;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Renkler.kart.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.checklist_outlined, color: Renkler.vurgu, size: 20),
              const SizedBox(width: 8),
              Text(
                'Bugünün İyilikleri',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                '$tamam/${ManeviStore.gorevler.length}',
                style: TextStyle(
                  color: Renkler.vurgu,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Her biri tamamlanınca serin güçlenir.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 8),
          ...ManeviStore.gorevler.map(
            (g) => _gorevSatiri(
              ikon: g['ikon']!,
              baslik: g['baslik']!,
              aciklama: g['aciklama']!,
              deger: _gorevler.contains(g['id']),
              onChanged: (t) => _gorevTikla(g['id']!, t),
            ),
          ),
        ],
      ),
    );
  }

  Widget _kontrolSatiri({
    required String etiket,
    required IconData ikon,
    required bool deger,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!deger),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Icon(
              deger ? Icons.check_circle : Icons.radio_button_unchecked,
              color: deger ? Renkler.vurgu : Colors.white38,
              size: 22,
            ),
            const SizedBox(width: 12),
            Text(
              etiket,
              style: TextStyle(
                color: deger ? Colors.white70 : Colors.white,
                fontSize: 14,
                decoration: deger ? TextDecoration.lineThrough : null,
              ),
            ),
            const Spacer(),
            if (deger) Icon(Icons.done, color: Renkler.vurgu, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _gorevSatiri({
    required String ikon,
    required String baslik,
    required String aciklama,
    required bool deger,
    required ValueChanged<bool> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!deger),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Renkler.seciliYuzey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(ikon, style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    baslik,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      decoration: deger ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    aciklama,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 11,
                      decoration: deger ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              deger ? Icons.check_circle : Icons.radio_button_unchecked,
              color: deger ? Renkler.vurgu : Colors.white38,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
