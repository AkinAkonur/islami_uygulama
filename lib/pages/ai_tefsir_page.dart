import 'package:flutter/material.dart';
import '../services/renkler.dart';

class AiTefsirPage extends StatefulWidget {
  const AiTefsirPage({super.key});

  @override
  State<AiTefsirPage> createState() => _AiTefsirPageState();
}

class _AiTefsirPageState extends State<AiTefsirPage> {
  final TextEditingController _queryController = TextEditingController();
  String _selectedMode = "Tefsir Modu";
  bool _isLoading = false;

  // Active simulated result following the 7-layer architecture
  Map<String, dynamic>? _activeResponse;

  final List<String> _modes = [
    "Tefsir Modu",
    "Teselli & Umut",
    "Hayat Sorunu",
    "Öğrenme Modu",
    "Karşılaştırma",
  ];

  final List<String> _sampleQuestions = [
    "Nisa Suresi 34. ayeti açıklar mısın?",
    "Kaygılıyım, içimi ferahlatacak ayetler hangileri?",
    "Namazı kaçırdım, kaza ederken ne yapmalıyım?",
    "Bakara Suresi 256. ayette 'dinde zorlama yoktur' ne anlama gelir?",
  ];

  void _askAi(String query) {
    if (query.trim().isEmpty) return;
    setState(() {
      _isLoading = true;
      _activeResponse = null;
    });

    // Simulate AI generation with the 7-layer architecture
    Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        _isLoading = false;
        _activeResponse = {
          "query": query,
          "summary": "Bu ayet/konu, İslam'ın hakikatini, adalet prensibini ve insan ruhunun huzur bulacağı ilahi ölçüleri barındırır.",
          "verse": "İlgili Ayet: Örnek Bağlam Suresi, 32. Ayet",
          "tafsir": "İbn Kesîr tefsirine göre bu hüküm toplumsal maslahatı gözetirken; Râzî ve Elmalılı Hamdi Yazır ise hikmet boyutuna dikkat çeker.",
          "nuzul": "Nüzul Sebebi: Asr-ı Saadet döneminde sahabelerin karşılaştığı toplumsal olaylar üzerine nazil olmuştur.",
          "hadis": "Hadis Desteği: «Ameller niyetlere göredir» (Buhârî, Bed'ül-Vahy, 1)",
          "modern": "Güncel Uygulama: Modern iş ve aile hayatında adalet, dürüstlük ve tevekkül prensibiyle uygulanır.",
          "followUps": [
            "Bu konuda farklı mezhep görüşleri var mı?",
            "Günlük hayatta bunu nasıl pratik edebilirim?",
            "İlgili diğer ayetler hangileridir?"
          ]
        };
      });
    });
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
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Renkler.cerceve2 : Renkler.kart,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Renkler.vurgu : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        mode,
                        style: TextStyle(
                          color: isSelected ? Renkler.vurgu : Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
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

            // 7 Katmanlı Cevap Mimarisi Sonucu
            if (_activeResponse != null) ...[
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
                        Text(
                          "AI Tefsir Analizi ($_selectedMode)",
                          style: TextStyle(color: Renkler.vurgu, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ],
                    ),
                    Divider(color: Renkler.cerceve2, height: 24),

                    // Katman 1: Özet
                    _layerTitle("1. Doğrudan Özet"),
                    Text(_activeResponse!["summary"], style: TextStyle(color: Colors.white, fontSize: 14, height: 1.4)),
                    SizedBox(height: 14),

                    // Katman 2: Ayet & Bağlam
                    _layerTitle("2. Ayet & Bağlam"),
                    Text(_activeResponse!["verse"], style: TextStyle(color: Colors.white70, fontSize: 13)),
                    SizedBox(height: 14),

                    // Katman 3: Tefsir Karşılaştırması
                    _layerTitle("3. Tefsir Görüşleri (İbn Kesîr, Râzî, Elmalılı)"),
                    Text(_activeResponse!["tafsir"], style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                    SizedBox(height: 14),

                    // Katman 4: Nüzul Sebebi
                    _layerTitle("4. Nüzul Sebebi"),
                    Text(_activeResponse!["nuzul"], style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                    SizedBox(height: 14),

                    // Katman 5: Hadis Desteği
                    _layerTitle("5. Hadis Desteği"),
                    Text(_activeResponse!["hadis"], style: TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14),

                    // Katman 6: Güncel Hayat Uygulaması
                    _layerTitle("6. Güncel Hayat Bağlamı"),
                    Text(_activeResponse!["modern"], style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                    SizedBox(height: 20),

                    // Katman 7: Takip Soruları Önerileri
                    Text("7. Takip Soruları Önerileri:", style: TextStyle(color: Renkler.vurgu, fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    ...((_activeResponse!["followUps"] as List).map((fq) => Padding(
                          padding: EdgeInsets.only(bottom: 6.0),
                          child: InkWell(
                            onTap: () {
                              _queryController.text = fq;
                              _askAi(fq);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Renkler.cerceve2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.subdirectory_arrow_right, color: Renkler.vurgu, size: 16),
                                  SizedBox(width: 8),
                                  Expanded(child: Text(fq, style: TextStyle(color: Colors.white, fontSize: 12))),
                                ],
                              ),
                            ),
                          ),
                        ))),
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

  Widget _layerTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Text(
        title,
        style: TextStyle(
          color: Renkler.vurgu,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
