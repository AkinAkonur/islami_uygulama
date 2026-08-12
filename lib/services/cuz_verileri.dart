import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// Tek bir âyete ait sadeleştirilmiş veri (assets/cuzler/cuz{N}.json).
class CuzAyah {
  final int sureNo;
  final int ayetNo;
  final int globalNo;
  final String metin;
  final int sayfa;
  final bool secdeAyeti;

  const CuzAyah({
    required this.sureNo,
    required this.ayetNo,
    required this.globalNo,
    required this.metin,
    required this.sayfa,
    required this.secdeAyeti,
  });
}

/// Al Quran Cloud API'den indirilen cüz verilerini uygulama paketinden okur.
/// Uygulamayla birlikte gelen JSON dosyaları sayesinde internet olmadan
/// çalışır.
class CuzVerileri {
  static Future<List<CuzAyah>> cuzuYukle(int cuzNo) async {
    final veri = await rootBundle.load('assets/cuzler/cuz$cuzNo.json');
    final liste =
        jsonDecode(utf8.decode(veri.buffer.asUint8List())) as List<dynamic>;
    return liste.map((e) {
      final m = e as Map<String, dynamic>;
      return CuzAyah(
        sureNo: m['s'] as int,
        ayetNo: m['a'] as int,
        globalNo: m['n'] as int,
        metin: (m['t'] as String).replaceAll('\uFEFF', ''),
        sayfa: m['p'] as int,
        secdeAyeti: m['sj'] == true,
      );
    }).toList();
  }

  /// EveryAyah kütüphanesinde barınan El-Hüseynî (Alafasy) okuyuşu için
  /// ses URL'si. Dosyalar cihazda saklanmaz, internetten akışla oynatılır.
  /// Örnek: 001001.mp3 (Fâtiha 1. âyet)
  static String ayetSesUrl(int sureNo, int ayetNo) {
    final sure = sureNo.toString().padLeft(3, '0');
    final ayet = ayetNo.toString().padLeft(3, '0');
    return 'https://everyayah.com/data/Alafasy_128kbps/$sure$ayet.mp3';
  }
}
