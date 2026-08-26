import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';

class SpecialScreen extends StatelessWidget {
  const SpecialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Color(0xFF0F1410),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).t('s.specialConditions'),
          style: TextStyle(fontWeight: FontWeight.bold, color: Renkler.vurgu),
        ),
        backgroundColor: Color(0xFF141F18),
        elevation: 0,
        iconTheme: IconThemeData(color: Renkler.vurgu),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _specialCard(
            context,
            l.t('sp.travel'),
            "90 km ve üzeri yolculuklarda (Hanefî mezhebine göre) 4 rekatlı farz namazlar 2 rekat olarak kılınır (kasr). Vitir namazı tam kılınır.",
            [
              "• Şartları: 90 km mesafeye çıkmak, niyet etmek, seyahat halinde olmak.",
              "• Sünnetler: Acele ve yorgunluk durumunda seferîlikte sünnetler terk edilebilir.",
              "• İkamet: 15 günden az kalınacak yerlerde seferîlik hükmü devam eder."
            ],
            Colors.blueAccent,
          ),
          _specialCard(
            context,
            l.t('sp.sick'),
            "Ayakta duramayacak veya sağlığına zarar gelecek hastalar için dinimiz kolaylık sağlamıştır.",
            [
              "• Ayakta duramayan: Oturarak rüku ve secde ile kılar.",
              "• Oturamayan: Sırtüstü uzanarak veya yan yatarak ima ile (baş işaretiyle) kılabilir.",
              "• Abdest alamayan: Teyemmüm eder veya sargı üzerine mesh yapar."
            ],
            Colors.teal,
          ),
          _specialCard(
            context,
            l.t('sp.congregation'),
            "Cemaatle kılınan namazların sevabı tek başına kılınana göre 27 kat daha fazladır.",
            [
              "• Cuma Namazı: Cuma günü öğle vaktinde cemaatle kılınması farzdır. Hutbe dinlemek şarttır.",
              "• İmama Uyma: İmam sesli okurken (cehrî) cemaat Fâtiha okumaz, dinler; gizli okurken (hafî) içinden okur.",
              "• Kâmet ve Saf Düzeni: Saf düzgünlüğü ve omuz omuza olmak sünnettir."
            ],
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _specialCard(BuildContext context, String title, String summary, List<String> details, Color accentColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF161E18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: accentColor, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(summary, style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
          SizedBox(height: 14),
          ...details.map((d) => Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child: Text(d, style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.3)),
              )),
        ],
      ),
    );
  }
}
