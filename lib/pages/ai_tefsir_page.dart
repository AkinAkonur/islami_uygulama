import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/ayarlar_store.dart';
import '../services/gemini_servisi.dart';
import '../services/firebase_ai_backend.dart';
import '../services/yerel_ayet_rehberi.dart';
import '../widgets/kart_sekilleri.dart';
import '../widgets/tactile_kart.dart';
import 'kuran_bolumu_page.dart';

/// AI / rehber sayfası.
///
/// Varsayılan: ücretsiz çevrimdışı bilgi bankası (API anahtarı gerekmez).
/// İsteğe bağlı: geçerli Gemini anahtarı varsa çevrimiçi mod açılabilir.
/// Anahtar yoksa veya çevrimiçi istek başarısız olursa kullanıcıya ham API
/// hatası gösterilmez; yerel yanıt veya sade bir yedek mesaj sunulur.
class AiTefsirPage extends StatefulWidget {
  const AiTefsirPage({super.key, this.servis});
  final GeminiServisi? servis;
  @override
  State<AiTefsirPage> createState() => _AiTefsirPageState();
}

class _AiTefsirPageState extends State<AiTefsirPage> {
  late final GeminiServisi _gemini = widget.servis ?? GeminiServisi();
  /// Anahtar yoksa her zaman yerel. Anahtar varsa varsayılan yine yerel
  /// (ücretsiz / kotasız); kullanıcı isteğe bağlı çevrimiçiye geçer.
  bool _yerel = !AyarlarStore.geminiAnahtarVar;
  bool _modElleSecildi = false;
  final _queryController = TextEditingController();
  final _sonucKey = GlobalKey();
  String _seciliKategori = 'tefsir';
  String? _yanitMetni;
  String? _sonDil;
  bool _soruldu = false;
  bool _isLoading = false;
  bool _onlineHata = false;
  int _istek = 0;
  static const _gold = Color(0xFFFFD54F);
  static const _green = Color(0xFF34D399);

  static const _kategoriler = <(String, IconData)>[
    ('tefsir', Icons.menu_book_rounded),
    ('fikih', Icons.mosque_rounded),
    ('akaid', Icons.verified_user_rounded),
    ('hadis', Icons.collections_bookmark_rounded),
    ('siyer', Icons.history_edu_rounded),
    ('dua', Icons.front_hand_rounded),
    ('aile', Icons.family_restroom_rounded),
    ('teselli', Icons.volunteer_activism_rounded),
    ('karsilastirma', Icons.compare_arrows_rounded),
    ('ogrenme', Icons.school_rounded),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dil = AppLocalizations.of(context).locale.languageCode;
    if (_sonDil != null && _sonDil != dil) {
      _istek++;
      _yanitMetni = null;
      _onlineHata = false;
      _isLoading = false;
      _queryController.clear();
      _soruldu = false;
    }
    _sonDil = dil;
  }

  @override
  void dispose() {
    _istek++;
    _queryController.dispose();
    super.dispose();
  }

  void _sonucuGoster() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _sonucKey.currentContext;
      if (mounted && ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 250),
          alignment: 0.2,
        );
      }
    });
  }

  Future<void> _askAi(String query) async {
    if (query.trim().isEmpty || _isLoading) return;
    FocusScope.of(context).unfocus();
    final l = AppLocalizations.of(context);

    // Ücretsiz çevrimdışı yol — her zaman çalışır, API hatası üretmez.
    if (_yerel || !_gemini.hazir) {
      final yanit = YerelAyetRehberi.yanitla(query, l);
      setState(() {
        _yerel = true;
        _soruldu = true;
        _yanitMetni = yanit.metin;
        _onlineHata = false;
        _isLoading = false;
      });
      _sonucuGoster();
      return;
    }

    final istek = ++_istek;
    setState(() {
      _isLoading = true;
      _yanitMetni = null;
      _onlineHata = false;
      _soruldu = false;
    });

    try {
      final text = await _gemini.sor(
        query,
        dilKodu: l.locale.languageCode,
        ekTalimat: _seciliKategori,
      );
      if (!mounted || istek != _istek) return;
      setState(() {
        _yanitMetni = text;
        _isLoading = false;
        _soruldu = true;
        _onlineHata = false;
      });
    } catch (_) {
      if (!mounted || istek != _istek) return;
      // Çevrimiçi başarısız → otomatik yerel yedek. Ham API metni gösterilmez.
      final yedek = YerelAyetRehberi.yanitla(query, l);
      setState(() {
        _yerel = true;
        _yanitMetni = yedek.eslesme
            ? yedek.metin
            : '${l.t('ai.onlineError')}\n\n${yedek.metin}';
        _isLoading = false;
        _soruldu = true;
        _onlineHata = !yedek.eslesme;
      });
    }
    _sonucuGoster();
  }

  void _modDegistir(bool yerel) {
    setState(() {
      _modElleSecildi = true;
      _istek++;
      _yerel = yerel;
      _isLoading = false;
      _soruldu = false;
      _yanitMetni = null;
      _onlineHata = false;
    });
  }

  Widget _kart(Widget child, {bool gold = false}) => TactileKart(
        genislik: double.infinity,
        altinCerceve: gold,
        dolgu: const EdgeInsets.all(16),
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<FirebaseAiDurumu>(
      valueListenable: FirebaseAiBackend.durum,
      builder: (context, _, __) => ValueListenableBuilder<String>(
        valueListenable: AyarlarStore.geminiApiAnahtari,
        builder: (context, __, ___) {
          final onlineHazir = _gemini.hazir;
          if (onlineHazir && !_modElleSecildi && _yerel) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && !_modElleSecildi && _yerel && _gemini.hazir) {
                setState(() => _yerel = false);
              }
            });
          }
          return _buildBody(context, onlineHazir);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, bool onlineHazir) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF01140E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF06281E),
        foregroundColor: _gold,
        toolbarHeight: 88,
        title: Text(
          _yerel ? l.t('ai.localTitle') : l.t('ai.title'),
          maxLines: 2,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _kart(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        UcdIkon(
                          ikon: _yerel
                              ? Icons.offline_bolt_outlined
                              : Icons.auto_awesome,
                          renk: _gold,
                          boyut: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l.t(_yerel ? 'ai.localBadge' : 'ai.onlineBadge'),
                            style: const TextStyle(
                              color: _gold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l.t(_yerel ? 'ai.localNotice' : 'ai.disclaimer'),
                      style: const TextStyle(
                        color: Color(0xFFD1FAE5),
                        height: 1.5,
                      ),
                    ),
                    if (onlineHazir)
                      SwitchListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          l.t('ai.localTitle'),
                          style: const TextStyle(color: _green),
                        ),
                        subtitle: Text(
                          l.t('ai.onlineBadge'),
                          style: const TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 11,
                          ),
                        ),
                        value: _yerel,
                        onChanged: _modDegistir,
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          l.t('ai.localBadge'),
                          style: const TextStyle(
                            color: _green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                gold: true,
              ),
              const SizedBox(height: 24),
              Text(
                l.t('ai.mode'),
                style: const TextStyle(
                  color: _gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _kategoriler.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final (kod, icon) = _kategoriler[i];
                    return ChoiceChip(
                      avatar: UcdIkon(ikon: icon, renk: _gold, boyut: 18),
                      label: Text(l.t('ai.c.$kod')),
                      selected: kod == _seciliKategori,
                      onSelected: (_) =>
                          setState(() => _seciliKategori = kod),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              _kart(
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _queryController,
                        minLines: 1,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: l.t('ai.hint'),
                          hintStyle:
                              const TextStyle(color: Color(0xFF94A3B8)),
                          border: InputBorder.none,
                        ),
                        textInputAction: TextInputAction.send,
                        onSubmitted: _askAi,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      tooltip: l.t('ai.askTitle'),
                      onPressed: _isLoading
                          ? null
                          : () => _askAi(_queryController.text),
                      icon: const Icon(Icons.arrow_upward_rounded),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l.t('ai.ornekBaslik'),
                style: const TextStyle(
                  color: _gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              for (var i = 1; i <= 3; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TactileKart(
                    genislik: double.infinity,
                    onTap: _isLoading
                        ? null
                        : () {
                            final query =
                                l.t('ai.cs.$_seciliKategori.$i');
                            _queryController.text = query;
                            _askAi(query);
                          },
                    child: Row(
                      children: [
                        const UcdIkon(
                          ikon: Icons.menu_book_rounded,
                          renk: _green,
                          boyut: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l.t('ai.cs.$_seciliKategori.$i'),
                            style: const TextStyle(
                              color: Colors.white,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: _green,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                ),
              if (_isLoading)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(color: _gold),
                  ),
                ),
              if (_soruldu)
                Padding(
                  key: _sonucKey,
                  padding: const EdgeInsets.only(top: 12),
                  child: _kart(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l.t(
                            _yerel ? 'ai.localTitle' : 'ai.answerTitle',
                          ),
                          style: const TextStyle(
                            color: _gold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SelectableText(
                          _yanitMetni ?? '',
                          key: const ValueKey('guideResponseText'),
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1.6,
                          ),
                        ),
                        if (_onlineHata)
                          TextButton(
                            onPressed: () => _modDegistir(true),
                            child: Text(l.t('ai.localTitle')),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => KuranBolumuPage(),
                              ),
                            ),
                            icon: const Icon(Icons.menu_book_outlined),
                            label: Text(l.t('h.navKuran')),
                          ),
                        ),
                      ],
                    ),
                    gold: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
