import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/kuran_api.dart';
import '../../services/kuran_verileri.dart';
import 'sure_detay_page.dart';

class TematikAyetlerPage extends StatefulWidget {
  const TematikAyetlerPage({super.key});

  @override
  State<TematikAyetlerPage> createState() => _TematikAyetlerPageState();
}

class _TematikAyetlerPageState extends State<TematikAyetlerPage> {
  int? _seciliPaket;
  List<AyetMetni>? _ayetler;
  bool _yukleniyor = false;

  Future<void> _paketiAc(int index) async {
    final l = AppLocalizations.of(context);
    final paket = tematikPaketler[index];
    setState(() {
      _seciliPaket = index;
      _yukleniyor = true;
      _ayetler = null;
    });
    try {
      final sonuclar = <AyetMetni>[];
      for (final ref in paket.ayetler) {
        final parca = ref.split(':');
        final sureNo = int.parse(parca[0]);
        final ayetNo = int.parse(parca[1]);
        final ayetler = await KuranApi.instance.tekAyetGetir(sureNo, ayetNo);
        if (ayetler.isNotEmpty && !sonuclar.any((s) => s.ayetNo == ayetNo && s.sureNo == sureNo)) {
          sonuclar.add(ayetler[0]);
        }
      }
      if (mounted) {
        setState(() {
          _ayetler = sonuclar;
          _yukleniyor = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _yukleniyor = false;
          _ayetler = [];
        });
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(l.t('ta.networkError'))),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('ta.title'),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 46,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i = 0; i < tematikPaketler.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          '${tematikPaketler[i].ikon} ${tematikPaketler[i].baslik}',
                          style: const TextStyle(fontSize: 11),
                        ),
                        selected: _seciliPaket == i,
                        selectedColor: Renkler.vurgu,
                        backgroundColor: Renkler.kart,
                        labelStyle: TextStyle(
                          color: _seciliPaket == i ? Colors.black : Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (_) => _paketiAc(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(child: _icerik(l)),
        ],
      ),
    );
  }

  Widget _icerik(AppLocalizations l) {
    if (_seciliPaket == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            l.t('ta.selectHint'),
            style: const TextStyle(color: Colors.white54, fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    if (_yukleniyor) {
      return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
    }

    if (_ayetler == null || _ayetler!.isEmpty) {
      return Center(
        child: Text(l.t('ta.loadError'), style: const TextStyle(color: Colors.white54)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
      itemCount: _ayetler!.length,
      itemBuilder: (context, index) {
        final ayet = _ayetler![index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Renkler.kart,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF262626)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ayet.arapca,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: const TextStyle(color: Colors.white, fontSize: 20, height: 1.7),
              ),
              const SizedBox(height: 10),
              Text(
                ayet.meal,
                style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${sureAdiTurkce(ayet.sureNo)} • ${l.t('ta.verse').replaceFirst('{no}', '${ayet.ayetNo}')}',
                    style: TextStyle(color: Renkler.vurgu, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SureDetayPage(sureNo: ayet.sureNo)),
                    ),
                    child: Text(
                      l.t('ta.openSurah'),
                      style: const TextStyle(color: Colors.white38, fontSize: 11, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
