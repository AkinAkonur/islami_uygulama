import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../services/renkler.dart';
import '../../services/kuran_api.dart';
import '../../services/kuran_verileri.dart';
import 'sure_detay_page.dart';

class AyetAramaPage extends StatefulWidget {
  const AyetAramaPage({super.key});

  @override
  State<AyetAramaPage> createState() => _AyetAramaPageState();
}

class _AyetAramaPageState extends State<AyetAramaPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, Object>>? _sonuclar;
  bool _araniyor = false;
  String? _hata;

  Future<void> _ara(String kelime) async {
    final q = kelime.trim();
    if (q.isEmpty) return;
    setState(() {
      _araniyor = true;
      _hata = null;
      _sonuclar = null;
    });
    try {
      final sonuclar = await KuranApi.instance.ayetAra(q);
      if (mounted) {
        setState(() {
          _sonuclar = sonuclar;
          _araniyor = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hata = e.toString();
          _araniyor = false;
        });
      }
    }
  }

  Future<void> _numaraIleGit(String ifade) async {
    final parcalar = ifade.split(':');
    if (parcalar.length != 2) return;
    final sureNo = int.tryParse(parcalar[0].trim());
    final ayetNo = int.tryParse(parcalar[1].trim());
    final l = AppLocalizations.of(context);
    if (sureNo == null || ayetNo == null || sureNo < 1 || sureNo > 114) {
      _gosterMesaj(l.t('aa.invalidRef'));
      return;
    }
    try {
      final ayetler = await KuranApi.instance.tekAyetGetir(sureNo, ayetNo);
      if (mounted && ayetler.isNotEmpty) {
        _ayetDetayGoster(ayetler[0]);
      }
    } catch (_) {
      _gosterMesaj(l.t('aa.verseNotFound'));
    }
  }

  void _gosterMesaj(String m) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(m)));
  }

  void _ayetDetayGoster(AyetMetni ayet) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF161616),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        final l = AppLocalizations.of(ctx);
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    '${ayet.sureNo}. ${sureAdiTurkce(ayet.sureNo)} • ${ayet.ayetNo}. ${l.t('aa.verseWord')}',
                    style: TextStyle(
                      color: Renkler.vurgu,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    tooltip: l.t('aa.openSure'),
                    icon: Icon(Icons.open_in_new, color: Colors.white54, size: 18),
                    onPressed: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SureDetayPage(sureNo: ayet.sureNo),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ayet.arapca,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.white, fontSize: 22, height: 1.7),
                    ),
                    SizedBox(height: 10),
                    Text(
                      ayet.okunus,
                      style: TextStyle(
                        color: Colors.white38,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Renkler.seciliYuzey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ayet.meal,
                        style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final oneriler = [
      l.t('aa.sug1'), l.t('aa.sug2'), l.t('aa.sug3'),
      l.t('aa.sug4'), l.t('aa.sug5'), l.t('aa.sug6'), l.t('aa.sug7'),
    ];
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('aa.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Renkler.yuzey,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  style: TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.search,
                  onSubmitted: _ara,
                  decoration: InputDecoration(
                    hintText: l.t('aa.searchHint'),
                    hintStyle: TextStyle(color: Colors.white38),
                    prefixIcon: Icon(Icons.search, color: Colors.white54),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.arrow_forward, color: Renkler.vurgu),
                      onPressed: () {
                        final metin = _controller.text.trim();
                        if (metin.contains(':')) {
                          _numaraIleGit(metin);
                        } else {
                          _ara(metin);
                        }
                      },
                    ),
                    filled: true,
                    fillColor: Renkler.kart,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final oneri in oneriler)
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: ActionChip(
                            label: Text(
                              oneri,
                              style: TextStyle(color: Renkler.vurgu, fontSize: 11),
                            ),
                            backgroundColor: Renkler.seciliYuzey,
                            side: BorderSide.none,
                            onPressed: () {
                              _controller.text = oneri;
                              _ara(oneri);
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _icerik(l)),
        ],
      ),
    );
  }

  Widget _icerik(AppLocalizations l) {
    if (_araniyor) {
      return Center(child: CircularProgressIndicator(color: Renkler.vurgu));
    }
    if (_hata != null) {
      return Center(
        child: Text(
          l.t('aa.searchError'),
          style: TextStyle(color: Colors.white70),
        ),
      );
    }
    if (_sonuclar == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.manage_search, color: Colors.white24, size: 56),
            SizedBox(height: 12),
            Text(
              l.t('aa.searchEmpty'),
              style: TextStyle(color: Colors.white54, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    if (_sonuclar!.isEmpty) {
      return Center(
        child: Text(l.t('aa.noResults'), style: TextStyle(color: Colors.white54)),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemCount: _sonuclar!.length,
      itemBuilder: (context, index) {
        final m = _sonuclar![index];
        final sureNo = m['sureNo'] as int;
        final ayetNo = m['ayetNo'] as int;
        final metin = m['text'] as String;
        return Card(
          color: Renkler.kart,
          margin: EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: Renkler.cerceve),
          ),
          child: ListTile(
            onTap: () async {
              try {
                final ayetler = await KuranApi.instance.tekAyetGetir(sureNo, ayetNo);
                if (mounted && ayetler.isNotEmpty) {
                  _ayetDetayGoster(ayetler[0]);
                }
              } catch (_) {}
            },
            title: Text(
              metin,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                '$sureNo. ${sureAdiTurkce(sureNo)} • $ayetNo. ${l.t('aa.verseWord')}',
                style: TextStyle(color: Renkler.vurgu, fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.white24),
          ),
        );
      },
    );
  }
}
