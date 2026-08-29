import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/ummet_verileri.dart';

class HatimHalkalariPage extends StatefulWidget {
  const HatimHalkalariPage({super.key});

  @override
  State<HatimHalkalariPage> createState() => _HatimHalkalariPageState();
}

class _HatimHalkalariPageState extends State<HatimHalkalariPage> {
  Set<int> _cuzlerim = {};
  int _tamamlanan = hatimTabaniTamamlanan;
  bool _yukleniyor = true;

  @override
  void initState() {
    super.initState();
    _yukle();
  }

  Future<void> _yukle() async {
    final cuzlerim = await UmmetStore.hatimCuzlerim();
    final tamamlanan = await UmmetStore.hatimTamamlanan();
    if (!mounted) return;
    setState(() {
      _cuzlerim = cuzlerim;
      _tamamlanan = tamamlanan;
      _yukleniyor = false;
    });
  }

  Future<void> _cuzTikla(int cuzNo) async {
    final l = AppLocalizations.of(context);
    final eklendi = await UmmetStore.hatimCuzTikla(cuzNo);
    if (!mounted) return;
    setState(() {
      if (eklendi) {
        _cuzlerim.add(cuzNo);
        _tamamlanan += 1;
      } else {
        _cuzlerim.remove(cuzNo);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          eklendi
              ? l.t('hh.tookJuz').replaceFirst('{no}', '$cuzNo')
              : l.t('hh.leftJuz').replaceFirst('{no}', '$cuzNo'),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Renkler.bannerUst,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('hh.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: _yukleniyor
          ? Center(
              child: CircularProgressIndicator(color: Renkler.vurgu),
            )
          : ListView(
              padding: EdgeInsets.all(16),
              children: [
                Container(
                  padding: EdgeInsets.all(14),
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
                          Icon(Icons.groups_2_outlined,
                              color: Renkler.vurgu, size: 22),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l.t('hh.summary')
                                  .replaceFirst('{count}', '${_cuzlerim.length}')
                                  .replaceFirst('{finished}', binlikSayi(_tamamlanan)),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        l.t('hh.intro'),
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: 30,
                  itemBuilder: (context, i) => _cuzHucresi(i + 1, l),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Renkler.yuzey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          color: Renkler.vurgu, size: 16),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l.t('hh.legend'),
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: 11,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
    );
  }

  Widget _cuzHucresi(int cuzNo, AppLocalizations l) {
    final bende = _cuzlerim.contains(cuzNo);
    final onKatilim = hatimOnKatilim[cuzNo];
    final tamamlandi = onKatilim == null && !bende && cuzNo % 3 == 0;

    return GestureDetector(
      onTap: () => _cuzTikla(cuzNo),
      child: Container(
        decoration: BoxDecoration(
          color: Renkler.kart,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: bende
                ? Renkler.vurgu
                : tamamlandi
                    ? Renkler.acikVurgu.withValues(alpha: 0.5)
                    : Renkler.cerceve,
            width: bende ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$cuzNo',
              style: TextStyle(
                color: bende ? Renkler.vurgu : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 2),
            Text(
              bende ? l.t('hh.mine') : (tamamlandi ? '✓' : (onKatilim != null ? '…' : '+')),
              style: TextStyle(
                color: bende
                    ? Renkler.vurgu
                    : tamamlandi
                        ? Renkler.acikVurgu
                        : Colors.white38,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
