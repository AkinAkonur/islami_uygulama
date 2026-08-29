import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  State<GuideScreen> createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {
  String _selectedMadhab = "Hanefî";
  int _currentStep = 0;

  final List<String> _madhabs = ["Hanefî", "Şâfiî", "Mâlikî", "Hanbelî"];

  final List<Map<String, String>> _steps = [
    {
      "title": "Niyet ve Tekbir",
      "subtitle": "Kıyamda duruş ve İftitah Tekbiri",
      "content": "Kıbleye yönelerek kılınacak namaza niyet edilir. 'Allahu Ekber' denilerek eller kulak veya omuz hizasına kaldırılır ve göğüste bağlanır. Sübhaneke okunur."
    },
    {
      "title": "Kıraat (Fâtiha ve Sure)",
      "subtitle": "Kur'an okunması",
      "content": "Eûzü-Besmele çekilir, Fâtiha Suresi ve ardından en az üç kısa ayet veya bir zamm-ı sure (İhlâs vb.) okunur."
    },
    {
      "title": "Rükû",
      "subtitle": "Eğilme ve Ta'dîl-i Erkân",
      "content": "'Allahu Ekber' diyerek bel 90 derece bükülür, eller diz kapaklarına konur. 3 defa 'Sübhane rabbiye'l-azîm' denir."
    },
    {
      "title": "Secde",
      "subtitle": "Alın ve yere kapanma",
      "content": "'Allahu Ekber' denilerek dizler, eller ve ardından alın/burun yere konur. 3 defa 'Sübhane rabbiye'l-a'lâ' denir."
    },
    {
      "title": "Oturuş ve Selâm",
      "subtitle": "Tahiyyat ve Son Selâm",
      "content": "Son oturuşta Ettehiyyâtü, Salli-Bârik ve Rabbenâ duaları okunur. Önce sağa sonra sola 'Es-selâmu aleyküm ve rahmetullah' denilerek selâm verilir."
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Renkler.zemin,
      appBar: AppBar(
        title: Text(
          l.t('gu.title'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Renkler.vurgu),
        ),
        backgroundColor: Renkler.kart,
        elevation: 0,
        iconTheme: IconThemeData(color: Renkler.vurgu),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Renkler.kart,
            child: Row(
              children: [
                Text(l.t('gu.madhab'), style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 38,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _madhabs.length,
                      itemBuilder: (context, index) {
                        final m = _madhabs[index];
                        final isSelected = m == _selectedMadhab;
                        return Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(m),
                            selected: isSelected,
                            selectedColor: Renkler.seciliYuzey,
                            backgroundColor: Renkler.yuzey,
                            labelStyle: TextStyle(color: isSelected ? Renkler.vurgu : Colors.white60, fontWeight: FontWeight.bold),
                            onSelected: (val) {
                              setState(() => _selectedMadhab = m);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _currentStep,
              onStepTapped: (step) => setState(() => _currentStep = step),
              onStepContinue: () {
                if (_currentStep < _steps.length - 1) {
                  setState(() => _currentStep++);
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep--);
                }
              },
              controlsBuilder: (context, details) {
                return Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Renkler.vurgu, foregroundColor: Colors.black),
                        onPressed: details.onStepContinue,
                        child: Text(_currentStep == _steps.length - 1 ? l.t('gu.complete') : l.t('gu.nextStep')),
                      ),
                      SizedBox(width: 12),
                      if (_currentStep > 0)
                        TextButton(
                          onPressed: details.onStepCancel,
                          child: Text(l.t('gu.prevStep'), style: TextStyle(color: Colors.white70)),
                        ),
                    ],
                  ),
                );
              },
              steps: _steps.map((s) {
                int idx = _steps.indexOf(s);
                return Step(
                  title: Text(s["title"]!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(s["subtitle"]!, style: TextStyle(color: Colors.white54, fontSize: 12)),
                  content: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Renkler.yuzey,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Renkler.cerceve2),
                    ),
                    child: Text(s["content"]!, style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4)),
                  ),
                  isActive: _currentStep >= idx,
                  state: _currentStep > idx ? StepState.complete : StepState.indexed,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
