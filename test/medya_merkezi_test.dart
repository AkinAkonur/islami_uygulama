import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:islami_uygulama/pages/daha_fazla_page.dart';
import 'package:islami_uygulama/pages/kabe_canli_page.dart';
import 'package:islami_uygulama/pages/mekke_medine_sanal_tur_page.dart';
import 'package:islami_uygulama/pages/sesli_kissalar_ve_podcastler_page.dart';

void main() {
  testWidgets('Medya Merkezi bolumu Kabe canli yayin hero kartini icerir', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: DahaFazlaPage()));
    await tester.pump();

    expect(find.text('🎧 İnteraktif Medya Merkezi'), findsOneWidget);
    expect(find.text('KABE-İ MUAZZAMA CANLI YAYINI'), findsOneWidget);
    expect(
      find.text('Şu an Mescid-i Haram\'dan Canlı · 24/7'),
      findsOneWidget,
    );
    expect(find.textContaining('🎧 Ses Modu'), findsOneWidget);
    expect(find.textContaining('📺 Tam Ekran İzle'), findsOneWidget);
    expect(find.text('Sesli Kıssalar ve Podcastler'), findsOneWidget);
    expect(find.text('Mekke & Medine 360° Sanal Tur'), findsOneWidget);
    expect(find.text('Dini Radyo & İlahi'), findsOneWidget);
  });

  testWidgets('Sesli Kıssalar ve Podcastler sayfasi sekmeleriyle yuklenir', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: SesliKissalarVePodcastlerPage()),
    );
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Sesli Kıssalar ve Podcastler'), findsOneWidget);
    expect(find.text('📖 Sesli Kıssalar'), findsOneWidget);
    expect(find.text('🎙️ Podcastler & Radyo'), findsOneWidget);

    // Podcast sekmesine geçildiğinde dinamik radyo kanalları
    // (varsayılan konfigürasyondan) listelenir.
    await tester.tap(find.byType(Tab).at(1));
    await tester.pumpAndSettle();
    expect(find.textContaining('Kur\'an Radyosu'), findsOneWidget);
    expect(find.textContaining('Sünnet Radyosu'), findsOneWidget);
  });

  testWidgets('Mekke & Medine sanal tur sayfasi canli ve 360 girdileri sunar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: MekkeMedineSanalTurPage()));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Mekke & Medine Sanal Tur'), findsOneWidget);
    expect(find.text('🔴 Canlı Yayınlar'), findsOneWidget);
    expect(find.text('🎥 360° Sanal Tur'), findsOneWidget);
    expect(find.text('📍 Mekânlar'), findsOneWidget);
    expect(find.text('Mescid-i Haram - Kâbe Canlı'), findsOneWidget);
    expect(find.text('Mescid-i Nebevî Canlı'), findsOneWidget);
    expect(find.text('Kâbe 360° Sanal Tur (Mekke)'), findsOneWidget);
    expect(find.text('Mescid-i Haram ve Kâbe'), findsOneWidget);
  });

  testWidgets('Hero karttaki Ses Modu butonu ses modu sayfasini acar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MaterialApp(home: DahaFazlaPage()));
    await tester.pump();

    await tester.tap(find.text('📺 Tam Ekran İzle'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.byType(KabeCanliPage), findsOneWidget);
    expect(find.text('Kâbe-i Muazzama Canlı Yayın'), findsOneWidget);
  });
}