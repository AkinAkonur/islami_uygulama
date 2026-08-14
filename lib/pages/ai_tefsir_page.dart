import 'package:flutter/material.dart';
import '../services/gemini_servisi.dart';
import '../services/renkler.dart';

class AiTefsirPage extends StatefulWidget {
  const AiTefsirPage({super.key});

  @override
  State<AiTefsirPage> createState() => _AiTefsirPageState();
}

class _AiTefsirPageState extends State<AiTefsirPage> {
  final TextEditingController _queryController = TextEditingController();
  final GeminiServisi _gemini = GeminiServisi();
  String _selectedMode = "Tefsir Modu";
  bool _isLoading = false;

  // Active simulated result following the 7-layer architecture
  String? _yanitText;
  String? _hataText;

  final List<String> _modes = [
    "Tefsir Modu",
    "Teselli & Umut",
    "Hayat Sorunu",
    "Öğrenme Modu",
    "Karşılaştırma",
  ];

  static const Map<String, String> _modeTalimatlari = {
    "Tefsir Modu":
        "Kur'an ayeti/konusu hakkında klasik tefsirler (İbn Kesîr, Râzî, Elmalılı) ve dilbilimsel açıklamayla detaylı yanıt ver. Ayet numarası verildiyse metni ve meramını açıkla.",
    "Teselli & Umut":
        "Kaygı, keder ve umutsuzluğa karşı Kur'an'dan ve hadislerden ferahlatıcı, şefkatli ve güven veren yanıtlar ver. Kısa, sıcak ve manevi bir üslup kullan.",
    "Hayat Sorunu":
        "Günlük hayattaki sorunlara (aile, iş, ilişki, alışkanlıklar) İslami çerçevede pratik ve uygulanabilir çözümler sun; adım adım, özlü ve samimi yanıtla.",
    "Öğrenme Modu":
        "Soruya net, düzenli, madde madde ve başlangıç seviyesinden akademik seviyeye açıklamalı eğitici bir yanıt ver. Terimleri tanımla ve örnek ver.",
    "Karşılaştırma":
        "İki veya daha fazla konuyu (ayet, görüş, uygulama) yan yana karşılaştır; benzerlik ve farklılıkları tablo/madde halinde nesnel şekilde sun.",
  };

  final List<String> _sampleQuestions = [
    "Nisa Suresi 34. ayeti açıklar mısın?",
    "Kaygılıyım, içimi ferahlatacak ayetler hangileri?",
    "Namazı kaçırdım, kaza ederken ne yapmalıyım?",
    "Bakara Suresi 256. ayette 'dinde zorlama yoktur' ne anlama gelir?",
  ];

  Future<void> _askAi(String query) async {
    if (query.trim().isEmpty) return;
    setState(() {
      _isLoading = true;
      _yanitText = null;
      _hataText = null;
    });

    try {
      if (!_gemini.hazir) {
        throw const GemiException(
          "API anahtarı tanımlı değil.\nDerleme: flutter run --dart-define=GEMINI_API_KEY=<anahtar>",
        );
      }
      final talimat = _modeTalimatlari[_selectedMode] ?? '';
      final text = await _gemini.sor(
        "$_selectedMode etkin. $talimat\n\nSoru: $query",
      );
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _yanitText = text;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _hataText = 'Hata: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text("AI Tefsir & Soru Asistanı"),
        backgroundColor: Renkler.yuzey,
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Renkler.cerceve2,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Hak: 5/5",
                  style: TextStyle(color: Renkler.vurgu, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Disclaimer / Fetva Uyarısı
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Renkler.yuzey,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Renkler.cerceve2),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Renkler.vurgu, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Bu asistan bilgi ve tefsir amaçlıdır; bağlayıcı dini hüküm (fetva) için yetkili bir âlime danışınız.",
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Özel Mod Seçimi (Horizontal Chips)
            Text(
              "Asistan Modu",
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _modes.length,
                itemBuilder: (context, index) {
                  final mode = _modes[index];
                  final isSelected = mode == _selectedMode;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedMode = mode),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Renkler.vurgu : Renkler.kart,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Renkler.vurgu : Renkler.cerceve2,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Renkler.vurgu.withValues(alpha: 0.35),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            Icon(
                              Icons.check_circle,
                              color: Renkler.zemin,
                              size: 15,
                            ),
                            SizedBox(width: 6),
                          ],
                          Text(
                            mode,
                            style: TextStyle(
                              color: isSelected ? Renkler.zemin : Colors.white70,
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),

            // Soru Sorma Alanı
            Text(
              "Ayet, Sure veya Manevi Soru Sorun",
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _queryController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Örn: Nisa 34 hakkında ne düşünüyorsun?",
                      hintStyle: TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: Renkler.kart,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () => _askAi(_queryController.text),
                  icon: Icon(Icons.send, color: Renkler.vurgu),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Örnek Sorular
            Text(
              "Örnek Sorular:",
              style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _sampleQuestions.map((q) {
                return ActionChip(
                  backgroundColor: Renkler.kart,
                  labelStyle: TextStyle(color: Colors.white70, fontSize: 12),
                  label: Text(q),
                  onPressed: () {
                    _queryController.text = q;
                    _askAi(q);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 24),

            // Loading state
            if (_isLoading)
              Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(color: Renkler.vurgu),
                ),
              ),

            // API anahtarı yoksa bilgilendirme
            if (!_isLoading && !_gemini.hazir && _yanitText == null && _hataText == null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Renkler.yuzey,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Renkler.cerceve2),
                ),
                child: Row(
                  children: [
                    Icon(Icons.key_off, color: Renkler.vurgu, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "API anahtarı ayarlanmamış",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Ücretsiz anahtar için: aistudio.google.com/apikey\nSonra uygulamayı şöyle çalıştırın:\nflutter run --dart-define=GEMINI_API_KEY=ANAHTAR",
                            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Hata durumu
            if (_hataText != null)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Renkler.yuzey,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.redAccent, size: 20),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _hataText!,
                        style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),

            // Gemini'den gelen gerçek yanıt
            if (_yanitText != null) ...[
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Renkler.yuzey,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Renkler.cerceve2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: Renkler.vurgu, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "AI Yanıtı ($_selectedMode)",
                            style: TextStyle(color: Renkler.vurgu, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Renkler.cerceve2, height: 24),
                    Text(
                      _yanitText!,
                      style: TextStyle(color: Colors.white, fontSize: 14, height: 1.6),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Geri bildiriminiz için teşekkürler! (👍 Doğru)")));
                          },
                          icon: Icon(Icons.thumb_up_outlined, color: Colors.white60, size: 20),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Geri bildiriminiz alındı. (👎 Geliştirilecek)")));
                          },
                          icon: Icon(Icons.thumb_down_outlined, color: Colors.white60, size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
