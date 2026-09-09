import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:islami_uygulama/widgets/kart_sekilleri.dart';
import 'package:islami_uygulama/services/gercek_bildirimler.dart';
import 'package:islami_uygulama/services/namaz_bildirim_ayarlari.dart';
import 'helpers/notification_platform_fake.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late NotificationPlatformFake platform;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await NamazBildirimAyarlari.sifirla();
    GercekBildirimler.testDurumunuSifirla();
    platform = NotificationPlatformFake()..install();
  });
  tearDown(() {
    platform.uninstall();
  });

  testWidgets('3D ikon tek Icon olarak bulunur ve dugme bir kez calisir', (tester) async {
    var basildi = 0;
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: IconButton(
      tooltip: 'Hatırlatıcı',
      onPressed: () => basildi++,
      icon: const UcdIkon(ikon: Icons.alarm_add, renk: Colors.amber),
    ))));
    expect(find.byIcon(Icons.alarm_add), findsOneWidget);
    await tester.tap(find.byIcon(Icons.alarm_add));
    await tester.pump();
    expect(basildi, 1);
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));

  testWidgets('Golgesiz ve RTL ikonlar da tek kontrol olarak kalir', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(body: UcdIkon(
        ikon: Icons.arrow_back, renk: Colors.green, golge: false)),
    )));
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(tester.takeException(), isNull);
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));

  testWidgets('Zamanli bildirim basarisizsa false doner, yedek de denenir', (tester) async {
    platform.failScheduling = true;
    final sonuc = await GercekBildirimler.testBildirimi();
    expect(sonuc, isFalse);
    expect(platform.calls.where((c) => c.method == 'zonedSchedule'), hasLength(2));
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));

  testWidgets('Bildirim izni yoksa basari bildirilmez', (tester) async {
    platform.permissionGranted = false;
    expect(await GercekBildirimler.anlikTest(), isFalse);
    expect(await GercekBildirimler.testBildirimi(), isFalse);
    expect(platform.calls.where((c) => c.method == 'initialize'), hasLength(1));
    expect(platform.calls.where((c) => c.method == 'areNotificationsEnabled'), hasLength(2));
    expect(platform.calls.where((c) => c.method == 'show'), isEmpty);
    expect(platform.calls.where((c) => c.method == 'zonedSchedule'), isEmpty);
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));

  testWidgets('Anlik ve zamanli testler ayri OS cagrisina donusur', (tester) async {
    expect(await GercekBildirimler.anlikTest(), isTrue);
    expect(await GercekBildirimler.testBildirimi(), isTrue);
    expect(platform.calls.where((c) => c.method == 'show'), hasLength(1));
    expect(platform.calls.where((c) => c.method == 'zonedSchedule'), hasLength(1));
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));

  testWidgets('Bos planlama kuyrugu ard arda tekrar calisabilir', (tester) async {
    // Kurulum yapılmadığından ağ/OS planlaması yok; sıra tamamlama davranışı test edilir.
    await GercekBildirimler.planla();
    await GercekBildirimler.planla();
    await Future.wait([GercekBildirimler.planla(), GercekBildirimler.planla()]);
  }, variant: TargetPlatformVariant.only(TargetPlatform.android));
}
