import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/renkler.dart';

class WuduScreen extends StatelessWidget {
  const WuduScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
        child: Scaffold(
          backgroundColor: Color(0xFF0F1410),
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).t('w.abbGuide'),
              style: TextStyle(fontWeight: FontWeight.bold, color: Renkler.vurgu),
            ),
          backgroundColor: Color(0xFF141F18),
          elevation: 0,
          iconTheme: IconThemeData(color: Renkler.vurgu),
          bottom: TabBar(
            indicatorColor: Renkler.vurgu,
            labelColor: Renkler.vurgu,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(text: "Abdest"),
              Tab(text: "Gusül"),
              Tab(text: "Teyemmüm"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _WuduTabContent(
              title: "Namaz Abdesti Nasıl Alınır?",
              steps: [
                "1. Niyet edilir ve 'Eûzü billâhi mine'ş-şeytâni'r-racîm, Bismillâhi'r-rahmâni'r-rahîm' denir.",
                "2. Eller bileklere kadar 3 defa yıkanır.",
                "3. Sağ avuç ile ağza 3 defa su verilip çalkalanır.",
                "4. Burna 3 defa su çekilip sol elle temizlenir.",
                "5. Alından kulak yumuşağına ve çene altından saç bitimine kadar yüz 3 defa yıkanır.",
                "6. Önce sağ kol, ardından sol kol dirseklerle beraber 3 defa yıkanır.",
                "7. El ıslatılarak başın dörtte biri meshedilir.",
                "8. Serçe parmakla kulak içi, baş parmakla kulak arkası meshedilir.",
                "9. Ellerin sırtı ile boyun meshedilir.",
                "10. Önce sağ ayak, sonra sol ayak topuklarla beraber 3 defa yıkanır."
              ],
            ),
            _WuduTabContent(
              title: "Gusül (Boy Abdesti) Esasları",
              steps: [
                "1. 'Niyet ettim rıza-i ilahi için gusül abdesti almaya' diye niyet edilir.",
                "2. Besmele çekilerek eller ve avret mahalli yıkanır.",
                "3. Beden üzerinde varsa necaset / pislik temizlenir.",
                "4. Namaz abdesti gibi tam bir abdest alınır (ancak ayak yıkama sona bırakılabilir).",
                "5. Önce başa 3 defa su dökülerek iyice ovulur.",
                "6. Sonra sağ omuza, ardından sol omuza 3'er defa su dökülür.",
                "7. Vücutta iğne ucu kadar kuru yer kalmayacak şekilde yıkanır (kulak küpe delikleri, göbek çukuru kontrol edilir).",
                "8. Ayaklar yıkanarak banyo tamamlanır."
              ],
            ),
            _WuduTabContent(
              title: "Teyemmüm Nasıl Alınır?",
              steps: [
                "1. Su bulunmadığında veya sağlık sorunları nedeniyle su kullanımı yasak olduğunda teyemmüme niyet edilir.",
                "2. Temiz toprak, kum veya mermer gibi toprak cinsinden bir nesneye eller vurulur.",
                "3. Eller hafifçe silkelenerek yüz mesh edilir (yüzün tamamı kaplanır).",
                "4. Toprağa ikinci kez eller vurulur.",
                "5. Sol elin iç kısmı ile sağ kol, sağ elin iç kısmı ile sol kol dirseklerle beraber meshedilir.",
                "6. Teyemmümü bozan şeyler, normal abdesti bozan haller ve suyun bulunmasıdır."
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WuduTabContent extends StatelessWidget {
  final String title;
  final List<String> steps;

  const _WuduTabContent({required this.title, required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        ...steps.map((step) => Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF161E18),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Color(0xFF223028)),
              ),
              child: Text(step, style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4)),
            )),
      ],
    );
  }
}
