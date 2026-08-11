// ignore_for_file: avoid_print
import 'package:islami_uygulama/services/kuran_api.dart';
import 'package:islami_uygulama/services/kuran_verileri.dart';

Future<void> main() async {
  // 1. Sure listesi
  final sureler = await KuranApi.instance.sureleriGetir();
  print('SURELER: ${sureler.length}');
  final s = sureler[111];
  print(
    '111 -> ${s.turkceAdi} (${s.arapcaAdi}) ${s.ayetSayisi} ayet ${s.inisYeri}',
  );

  // 2. Sure ayetleri (kombine edisyonlar)
  final ayetler = await KuranApi.instance.ayetleriGetir(sureNo: 1);
  print('FATIHA AYETLERI: ${ayetler.length}');
  final ilk = ayetler.first;
  print('1:1 -> ${ilk.arapca}');
  print('meal -> ${ilk.meal}');
  print('okunus -> ${ilk.okunus}');
  print('cuz ${ilk.cuz} sayfa ${ilk.sayfa}');

  // 3. Cuz 30
  final cuz = await KuranApi.instance.ayetleriGetir(cuzNo: 30);
  print('CUZ 30: ${cuz.length} ayet, ilk sure: ${cuz.first.sureNo}');

  // 4. Tek ayet
  final tek = await KuranApi.instance.tekAyetGetir(2, 255);
  print('2:255 meal -> ${tek.first.meal}');

  // 5. Arama
  final sonuclar = await KuranApi.instance.ayetAra('sabır');
  print('ARAMA "sabır": ${sonuclar.length} sonuc');
  if (sonuclar.isNotEmpty) {
    print(
      'ilk: sure ${sonuclar.first['sureNo']} ayet ${sonuclar.first['ayetNo']} -> ${sonuclar.first['text']}',
    );
  }

  // 6. Ses URL
  print('SES: ${KuranApi.sureSesUrl('ar.alafasy', 1)}');
  print('AYET SES: ${KuranApi.ayetSesUrl('ar.alafasy', 1)}');
  assert(
    KuranApi.ayetSesUrl(
      'ar.abdurrahmaansudais',
      1,
    ).contains('/192/ar.abdurrahmaansudais/'),
  );

  // 7. Yerel veriler
  print('KEHF: ${sureOzetiMetni(18)}');
  print('TEMA PAKET: ${tematikPaketler[0].baslik}');
  KuranApi.instance.dispose();
}
