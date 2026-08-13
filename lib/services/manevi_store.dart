import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dini_gunler_servisi.dart';

class KuranKonumu {
  final int sureNo;
  final int ayetNo;
  final String sureAdi;

  const KuranKonumu({
    required this.sureNo,
    required this.ayetNo,
    required this.sureAdi,
  });

  String get gosterim => '$sureAdi $ayetNo. âyet';
}

/// Yeni ana ekran modüllerinin (Devam Et, Günlük Görevler, Hedef Çarkı,
/// Ramazan Modu, Hızlı Tesbih) kalıcı verilerini yönetir.
class ManeviStore {
  ManeviStore._();

  static Future<SharedPreferences> get _p => SharedPreferences.getInstance();
  static const _varsayilanKuranKonumu = KuranKonumu(
    sureNo: 2,
    ayetNo: 255,
    sureAdi: 'Bakara',
  );
  static final ValueNotifier<KuranKonumu> kuranKonumu = ValueNotifier(
    _varsayilanKuranKonumu,
  );

  static String _tarih(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  // ---------------- DEVAM ET ----------------

  static Future<KuranKonumu> sonKuranKonumu() async {
    final p = await _p;
    final konum = KuranKonumu(
      sureNo: p.getInt('son_okunan_sure_no') ?? _varsayilanKuranKonumu.sureNo,
      ayetNo: p.getInt('son_okunan_ayet_no') ?? _varsayilanKuranKonumu.ayetNo,
      sureAdi:
          p.getString('son_okunan_sure_adi') ?? _varsayilanKuranKonumu.sureAdi,
    );
    kuranKonumu.value = konum;
    return konum;
  }

  static Future<String> sonOkunanAyet() async {
    return (await sonKuranKonumu()).gosterim;
  }

  static Future<void> sonOkunanAyetKaydet({
    required int sureNo,
    required int ayetNo,
    required String sureAdi,
  }) async {
    final p = await _p;
    final konum = KuranKonumu(sureNo: sureNo, ayetNo: ayetNo, sureAdi: sureAdi);
    await Future.wait([
      p.setString('son_okunan_ayet', konum.gosterim),
      p.setInt('son_okunan_sure_no', sureNo),
      p.setInt('son_okunan_ayet_no', ayetNo),
      p.setString('son_okunan_sure_adi', sureAdi),
    ]);
    kuranKonumu.value = konum;
  }

  /// Hatim takibi sayfasının yazdığı anahtarları birlikte okur.
  static Future<Map<String, int>> hatimDurumu() async {
    final p = await _p;
    return {
      'sayfa': p.getInt('hatim_sayfa') ?? 1,
      'sayi': p.getInt('hatim_sayisi') ?? 0,
      'bugun': p.getInt('hatim_bugun_okunan') ?? 0,
      'seri': p.getInt('hatim_streak') ?? 0,
    };
  }

  // ---------------- HIZLI TESBİH ----------------

  static Future<int> tesbihSayisi() async {
    final p = await _p;
    return p.getInt('manevi_tesbih') ?? 0;
  }

  static Future<int> tesbihEkle(int adet) async {
    final p = await _p;
    final yeni = (p.getInt('manevi_tesbih') ?? 0) + adet;
    await p.setInt('manevi_tesbih', yeni);
    return yeni;
  }

  // ---------------- RAMAZAN MODU ----------------
  // Tarihler Diyanet İşleri Başkanlığı resmî takvimine dayanır ve
  // DiniGunlerServisi üzerinden bulut yapılandırmasıyla otomatik tazelenir
  // (uygulama güncellemesi gerekmez). Aşağıdaki yöntemler uyumluluk için
  // korunur; tüm hesaplama servise devredilmiştir.

  /// [yil] içindeki Ramazan dönemi(ler)i (2030'da iki dönem olabilir).
  static List<({DateTime bas, DateTime bit})> ramazanAraliklari(int yil) =>
      DiniGunlerServisi.ramazanAraliklari(yil);

  /// 1 Ramazan (yaklaşık hicri takvimden değil, Diyanet takviminden).
  static DateTime ramazanBaslangic(int yil) =>
      DiniGunlerServisi.ramazanBaslangic(yil);

  /// 30 Ramazan (orucun son günü).
  static DateTime ramazanBitis(int yil) => DiniGunlerServisi.ramazanBitis(yil);

  static DateTime sonrakiRamazanBaslangic(DateTime now) =>
      DiniGunlerServisi.sonrakiRamazanBaslangic(now);

  static bool ramazanIci(DateTime now) => DiniGunlerServisi.ramazanIci(now);

  /// Kandiller, arefe ve bayramlar (Diyanet resmî tarihleri, otomatik
  /// güncellenir).
  static List<Map<String, String>> get ozelGunler =>
      DiniGunlerServisi.ozelGunler;

  static Future<int> ramazanGunlukHatim() async {
    final p = await _p;
    return p.getInt('ramazan_gunluk_hatim') ?? 0;
  }

  static Future<int> ramazanGunlukHatimEkle(int adet) async {
    final p = await _p;
    final yeni = (p.getInt('ramazan_gunluk_hatim') ?? 0) + adet;
    await p.setInt('ramazan_gunluk_hatim', yeni);
    return yeni;
  }

  // ---------------- GÜNLÜK GÖREVLER ----------------

  static const List<Map<String, String>> gorevler = [
    {
      'id': 'ayet',
      'ikon': '📖',
      'baslik': '1 Ayet Oku',
      'aciklama': 'Bugün bir ayet oku ve anlamına göz at.',
    },
    {
      'id': 'dua',
      'ikon': '🤲',
      'baslik': '1 Dua Et',
      'aciklama': 'İçinden veya sesli bir dua et.',
    },
    {
      'id': 'sadaka',
      'ikon': '💝',
      'baslik': '1 Sadaka Ver',
      'aciklama': 'Bir ihtiyaç sahibine yardım eli uzat.',
    },
    {
      'id': 'zikir',
      'ikon': '📿',
      'baslik': '100 Zikir',
      'aciklama': '100 kez Sübhanallah, Elhamdülillah veya Allahu Ekber.',
    },
  ];

  static const List<String> namazVakitleri = [
    'Sabah',
    'Öğle',
    'İkindi',
    'Akşam',
    'Yatsı',
  ];

  static Future<Set<String>> bugunGorevler() async {
    final p = await _p;
    return (p.getStringList('manevi_gorev_${_tarih(DateTime.now())}') ??
            const [])
        .toSet();
  }

  static Future<Set<String>> bugunNamaz() async {
    final p = await _p;
    return (p.getStringList('manevi_namaz_${_tarih(DateTime.now())}') ??
            const [])
        .toSet();
  }

  static Future<Set<String>> gorevTikla(String id, bool tamam) async {
    final p = await _p;
    final key = 'manevi_gorev_${_tarih(DateTime.now())}';
    final set = (p.getStringList(key) ?? const []).toSet();
    tamam ? set.add(id) : set.remove(id);
    await p.setStringList(key, set.toList());
    await _seriGuncelle(p);
    return set;
  }

  static Future<Set<String>> namazTikla(String vakit, bool tamam) async {
    final p = await _p;
    final key = 'manevi_namaz_${_tarih(DateTime.now())}';
    final set = (p.getStringList(key) ?? const []).toSet();
    tamam ? set.add(vakit) : set.remove(vakit);
    await p.setStringList(key, set.toList());
    await _seriGuncelle(p);
    return set;
  }

  static Future<int> seriOku() async {
    final p = await _p;
    return p.getInt('manevi_seri') ?? 0;
  }

  static Future<void> _seriGuncelle(SharedPreferences p) async {
    final bugun = _tarih(DateTime.now());
    final dun = _tarih(DateTime.now().subtract(const Duration(days: 1)));
    final tumIdler = {...gorevler.map((g) => g['id']!), ...namazVakitleri};
    final gorevSet = (p.getStringList('manevi_gorev_$bugun') ?? const [])
        .toSet();
    final namazSet = (p.getStringList('manevi_namaz_$bugun') ?? const [])
        .toSet();
    final hepsiTamam = tumIdler.every(
      (id) => gorevSet.contains(id) || namazSet.contains(id),
    );
    if (!hepsiTamam) return;
    final son = p.getString('manevi_seri_son') ?? '';
    if (son == bugun) return;
    final seri = p.getInt('manevi_seri') ?? 0;
    await p.setInt('manevi_seri', son == dun ? seri + 1 : 1);
    await p.setString('manevi_seri_son', bugun);
  }

  // ---------------- HEDEF ÇARKI ----------------

  static const Map<String, int> hedefLimitleri = {
    'kuran': 5,
    'zikir': 100,
    'namaz': 5,
  };

  static Future<Map<String, int>> hedeflerOku() async {
    final p = await _p;
    return {
      'kuran': p.getInt('hedef_kuran') ?? 0,
      'zikir': p.getInt('hedef_zikir') ?? 0,
      'namaz': p.getInt('hedef_namaz') ?? 0,
    };
  }

  static Future<Map<String, int>> hedefEkle(String tur, int delta) async {
    final p = await _p;
    final key = 'hedef_$tur';
    final limit = hedefLimitleri[tur] ?? 1;
    final yeni = ((p.getInt(key) ?? 0) + delta).clamp(0, limit);
    await p.setInt(key, yeni);
    return hedeflerOku();
  }
}
