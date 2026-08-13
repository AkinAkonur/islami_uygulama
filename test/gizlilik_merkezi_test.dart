import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:islami_uygulama/pages/gizlilik_merkezi_page.dart';
import 'package:islami_uygulama/services/gizlilik_merkezi.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('Gömülü gizlilik JSON şeması hatasız çözülür ve içerik gelir', () {
    final merkez = GizlilikMerkeziServisi.veri;
    expect(merkez.baslik, 'Gizlilik ve Veri Güvenliğiniz');
    expect(merkez.izinKartlari, hasLength(3));
    expect(merkez.kullaniciHaklari, hasLength(2));
    expect(merkez.yasalMetinler.kisaOzet, isNotEmpty);
    expect(merkez.izinKarti('izin_konum'), isNotNull);
    expect(merkez.izinKarti('izin_analitik')?.degistirilebilirMi, isTrue);
  });

  testWidgets('Gizlilik Merkezi sayfası içeriğiyle yüklenir', (tester) async {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(home: GizlilikMerkeziPage()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Gizlilik Merkezi'), findsOneWidget);
    expect(find.text('Gizlilik ve Veri Güvenliğiniz'), findsOneWidget);
    expect(find.text('Konum Verisi'), findsOneWidget);
    expect(find.text('Çevrimdışı Depolama'), findsOneWidget);
    expect(find.text('İyileştirme ve İstatistikler'), findsOneWidget);
    expect(find.text('Tüm Verilerimi İndir'), findsOneWidget);
    expect(
      find.text('Hesabımı ve Tüm Verilerimi Kalıcı Olarak Sil'),
      findsOneWidget,
    );
    expect(find.text('Haklarınız (KVKK · md.11)'), findsOneWidget);
    expect(find.text('Teknik Güvence Altyapısı'), findsOneWidget);
  });
}