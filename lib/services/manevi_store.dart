import 'package:shared_preferences/shared_preferences.dart';

/// Yeni ana ekran modüllerinin (Devam Et, Günlük Görevler, Hedef Çarkı,
/// Ramazan Modu, Hızlı Tesbih) kalıcı verilerini yönetir.
class ManeviStore {
  ManeviStore._();

  static Future<SharedPreferences> get _p => SharedPreferences.getInstance();

  static String _tarih(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  // ---------------- DEVAM ET ----------------

  static Future<String> sonOkunanAyet() async {
    final p = await _p;
    return p.getString('son_okunan_ayet') ?? 'Bakara 255 · Ayetü\'l-Kürsî';
  }

  static Future<void> sonOkunanAyetKaydet(String deger) async {
    final p = await _p;
    await p.setString('son_okunan_ayet', deger);
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

  /// Yaklaşık hicri takvime göre Ramazan başlangıcı (1 Ramazan).
  static DateTime ramazanBaslangic(int yil) => DateTime(yil, 2, 8);

  /// Ramazan sonu (30 Ramazan).
  static DateTime ramazanBitis(int yil) => DateTime(yil, 3, 9);

  static DateTime sonrakiRamazanBaslangic(DateTime now) {
    final buYil = ramazanBaslangic(now.year);
    if (now.isBefore(buYil)) return buYil;
    final gelecek = ramazanBaslangic(now.year + 1);
    return gelecek;
  }

  static bool ramazanIci(DateTime now) {
    final bas = ramazanBaslangic(now.year);
    final bit = ramazanBitis(now.year);
    if (!now.isBefore(bas) && now.isBefore(bit)) return true;
    final b2 = ramazanBaslangic(now.year + 1);
    final b2b = ramazanBitis(now.year + 1);
    return !now.isBefore(b2) && now.isBefore(b2b);
  }

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

  /// Yaklaşık hicri günler: kandil, arefe, bayram.
  static const List<Map<String, String>> ozelGunler = [
    {'tarih': '2026-10-23', 'ad': 'Mevlid Kandili', 'ikon': '🕌'},
    {'tarih': '2027-01-08', 'ad': 'Regaib Kandili', 'ikon': '🌙'},
    {'tarih': '2027-01-30', 'ad': 'Miraç Kandili', 'ikon': '🪜'},
    {'tarih': '2027-02-05', 'ad': 'Berat Kandili', 'ikon': '✨'},
    {'tarih': '2027-03-06', 'ad': 'Kadir Gecesi', 'ikon': '🌙'},
    {'tarih': '2027-06-13', 'ad': 'Arefe Günü', 'ikon': '🕋'},
    {'tarih': '2027-06-14', 'ad': 'Kurban Bayramı', 'ikon': '🐑'},
  ];

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
    return (p.getStringList('manevi_gorev_${_tarih(DateTime.now())}') ?? const [])
        .toSet();
  }

  static Future<Set<String>> bugunNamaz() async {
    final p = await _p;
    return (p.getStringList('manevi_namaz_${_tarih(DateTime.now())}') ?? const [])
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
    final tumIdler = {
      ...gorevler.map((g) => g['id']!),
      ...namazVakitleri,
    };
    final gorevSet = (p.getStringList('manevi_gorev_$bugun') ?? const []).toSet();
    final namazSet = (p.getStringList('manevi_namaz_$bugun') ?? const []).toSet();
    final hepsiTamam = tumIdler.every(
        (id) => gorevSet.contains(id) || namazSet.contains(id));
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
