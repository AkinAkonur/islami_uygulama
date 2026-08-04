import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manevi_store.dart';

enum BildirimTipi { namaz, gunluk, ozelGun, ummet, diger }

class Bildirim {
  final String id;
  final BildirimTipi tip;
  final String baslik;
  final String mesaj;
  final DateTime zaman;
  final String hedef;
  final bool okundu;
  final bool sessiz;

  const Bildirim({
    required this.id,
    required this.tip,
    required this.baslik,
    required this.mesaj,
    required this.zaman,
    required this.hedef,
    required this.okundu,
    required this.sessiz,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'tip': tip.name,
        'baslik': baslik,
        'mesaj': mesaj,
        'zaman': zaman.toIso8601String(),
        'hedef': hedef,
        'okundu': okundu,
        'sessiz': sessiz,
      };

  static Bildirim fromJson(Map<String, dynamic> j) => Bildirim(
        id: j['id'] as String,
        tip: BildirimTipi.values.firstWhere(
          (t) => t.name == j['tip'],
          orElse: () => BildirimTipi.diger,
        ),
        baslik: j['baslik'] as String,
        mesaj: j['mesaj'] as String,
        zaman: DateTime.parse(j['zaman'] as String),
        hedef: j['hedef'] as String,
        okundu: j['okundu'] as bool,
        sessiz: j['sessiz'] as bool,
      );
}

/// Zil ikonunun arkasındaki "sessiz yardımcı": bildirim üretimi, rozet,
/// okundu işaretleri ve tür bazlı ayarlar.
class BildirimMerkezi {
  BildirimMerkezi._();

  static const _keyListe = 'bildirim_liste';
  static const _keySonGun = 'bildirim_son_gun';
  static const _keySessiz = 'bildirim_sessiz_modu';
  static const _keyKaza = 'kaza_namaz';

  /// Zildeki kırmızı rozet sayısı. Değişince dinleyen widget'lar tazelenir.
  static final ValueNotifier<int> rozet = ValueNotifier<int>(0);

  static Future<SharedPreferences> get _p => SharedPreferences.getInstance();

  static String _tarihKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static bool _sessizSaat(DateTime now) => now.hour >= 21 || now.hour < 6;

  // ---------------- LİSTE ----------------

  static Future<List<Bildirim>> listeyiOku() async {
    final p = await _p;
    final raw = p.getString(_keyListe);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => Bildirim.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> _listeyiKaydet(List<Bildirim> liste) async {
    final p = await _p;
    await p.setString(
      _keyListe,
      jsonEncode(liste.map((b) => b.toJson()).toList()),
    );
  }

  /// Günün bildirimlerini üretir. Günde bir kez çalışır; en fazla 5 bildirim.
  static Future<void> guncelle() async {
    final p = await _p;
    final now = DateTime.now();
    final bugunKey = _tarihKey(now);
    if (p.getString(_keySonGun) == bugunKey) return;

    final yeni = <Bildirim>[];
    final sessiz = _sessizSaat(now);

    // 1) NAMAZ (çekirdek)
    if (await ayarOku(BildirimTipi.namaz)) {
      final vakit = _siradakiVakit(now);
      if (vakit != null) {
        yeni.add(Bildirim(
          id: 'namaz_vakit_$bugunKey',
          tip: BildirimTipi.namaz,
          baslik: '${vakit.$1} ${vakit.$2}',
          mesaj: 'Namaz vakti giriyor — kalan ${vakit.$3}',
          zaman: now,
          hedef: 'namaz',
          okundu: false,
          sessiz: sessiz,
        ));
      }
      if (now.hour >= 19) {
        final kildin = (await ManeviStore.bugunNamaz()).length;
        if (kildin < 5) {
          yeni.add(Bildirim(
            id: 'namaz_kildin_$bugunKey',
            tip: BildirimTipi.namaz,
            baslik: 'Bugün $kildin/5 kıldın',
            mesaj: 'Akşam oldu — kalan vakitleri işaretlemeyi unutma.',
            zaman: now,
            hedef: 'gorevler',
            okundu: false,
            sessiz: sessiz,
          ));
        }
      }
      final kaza = p.getInt(_keyKaza) ?? 3;
      if (kaza > 0 && now.hour >= 12) {
        yeni.add(Bildirim(
          id: 'namaz_kaza_$bugunKey',
          tip: BildirimTipi.namaz,
          baslik: '$kaza kaza namazın var',
          mesaj: 'Tertip kuralına göre kazaları kılmaya çalış.',
          zaman: now,
          hedef: 'namaz',
          okundu: false,
          sessiz: sessiz,
        ));
      }
    }

    // 2) GÜNLÜK MANEVİ DOZ
    if (await ayarOku(BildirimTipi.gunluk)) {
      if (now.hour >= 7) {
        yeni.add(Bildirim(
          id: 'gunluk_ayet_$bugunKey',
          tip: BildirimTipi.gunluk,
          baslik: 'Günün Ayeti',
          mesaj: '"İnşirah: Her zorlukla birlikte bir kolaylık vardır." (94:6)',
          zaman: now,
          hedef: 'kuran',
          okundu: false,
          sessiz: sessiz,
        ));
      }
      if (now.hour >= 9) {
        final gunler = ['Bir akrabanı ara', 'Bir teşekkür mesajı gönder', 'Bir sadaka ver', 'Bir hastayı ziyaret et'];
        final secim = gunler[now.difference(DateTime(now.year, 1, 1)).inDays % gunler.length];
        yeni.add(Bildirim(
          id: 'gunluk_iyilik_$bugunKey',
          tip: BildirimTipi.gunluk,
          baslik: "Bugünün iyiliği: $secim",
          mesaj: 'Küçük bir adım, günü güzelleştirir.',
          zaman: now,
          hedef: 'gorevler',
          okundu: false,
          sessiz: sessiz,
        ));
      }
      if (now.hour >= 15) {
        final hatim = await ManeviStore.hatimDurumu();
        yeni.add(Bildirim(
          id: 'gunluk_hatim_$bugunKey',
          tip: BildirimTipi.gunluk,
          baslik: 'Hatim hedefi',
          mesaj: 'Bugün 1 sayfa okursan ${hatim['sayfa'] ?? 1}. sayfadan devam edeceksin.',
          zaman: now,
          hedef: 'hatim',
          okundu: false,
          sessiz: sessiz,
        ));
      }
    }

    // 3) ÖZEL GÜNLER
    if (await ayarOku(BildirimTipi.ozelGun)) {
      if (now.weekday == DateTime.friday && now.hour >= 11) {
        yeni.add(Bildirim(
          id: 'ozel_cuma_$bugunKey',
          tip: BildirimTipi.ozelGun,
          baslik: 'Bugün Cuma',
          mesaj: 'Hutbe öncesi cuma namazını planlamayı unutma.',
          zaman: now,
          hedef: 'namaz',
          okundu: false,
          sessiz: sessiz,
        ));
      }
      final bugunKey2 = _tarihKey(now);
      final ozel = ManeviStore.ozelGunler.where((g) => g['tarih'] == bugunKey2);
      if (ozel.isNotEmpty) {
        final g = ozel.first;
        yeni.add(Bildirim(
          id: 'ozel_gun_$bugunKey',
          tip: BildirimTipi.ozelGun,
          baslik: '${g['ikon']} ${g['ad']}',
          mesaj: 'Bugün mübarek bir gün — ibadetlerine biraz zaman ayır.',
          zaman: now,
          hedef: 'ramazan',
          okundu: false,
          sessiz: sessiz,
        ));
      }
      if (ManeviStore.ramazanIci(now) && now.hour >= 16) {
        yeni.add(Bildirim(
          id: 'ozel_iftar_$bugunKey',
          tip: BildirimTipi.ozelGun,
          baslik: 'İftar yaklaşıyor',
          mesaj: 'İftar 20:17 — orucunu unutma, ailenle paylaş.',
          zaman: now,
          hedef: 'ramazan',
          okundu: false,
          sessiz: sessiz,
        ));
      }
    }

    // 4) ÜMMET
    if (await ayarOku(BildirimTipi.ummet) && now.hour >= 8) {
      yeni.add(Bildirim(
        id: 'ummet_dua_$bugunKey',
        tip: BildirimTipi.ummet,
        baslik: 'Dua kardeşliğin aktif',
        mesaj: '1.420 kardeşin senin için dua etti. Sen de birine katıl.',
        zaman: now,
        hedef: 'ummet',
        okundu: false,
        sessiz: sessiz,
      ));
    }

    // En fazla 5, önem sırası: Namaz > Özel gün > Görevler > Diğer
    final secilen = yeni.take(5).toList();
    if (secilen.isNotEmpty) {
      final eski = await listeyiOku();
      await _listeyiKaydet([...secilen, ...eski]);
    }
    await p.setString(_keySonGun, bugunKey);
    await rozetGuncelle();
  }

  /// Sıradaki vakti hesaplar; (ad, saat, kalan yazısı) döner.
  static (String, String, String)? _siradakiVakit(DateTime now) {
    const vakitler = [
      (4, 12, 'İmsak', '04:12'),
      (5, 48, 'Güneş', '05:48'),
      (13, 5, 'Öğle', '13:05'),
      (16, 45, 'İkindi', '16:45'),
      (20, 17, 'Akşam', '20:17'),
      (21, 50, 'Yatsı', '21:50'),
    ];
    int? secilenDakika;
    String secilenAd = '';
    String secilenSaat = '';
    for (final v in vakitler) {
      final dakika = v.$1 * 60 + v.$2;
      if (dakika > now.hour * 60 + now.minute) {
        secilenDakika = dakika;
        secilenAd = v.$3;
        secilenSaat = v.$4;
        break;
      }
    }
    if (secilenDakika == null) return null;
    final simdiDakika = now.hour * 60 + now.minute;
    final kalanDk = secilenDakika - simdiDakika;
    if (kalanDk <= 0 || kalanDk > 300) return null;
    final h = kalanDk ~/ 60;
    final m = kalanDk % 60;
    final kalanYaz = h > 0 ? '$h saat $m dk' : '$m dk';
    return (secilenAd, secilenSaat, kalanYaz);
  }

  // ---------------- ROZET & OKUNDU ----------------

  static Future<int> okunmamisSayisi() async {
    final p = await _p;
    if (p.getBool(_keySessiz) ?? false) return 0;
    final liste = await listeyiOku();
    return liste.where((b) => !b.okundu && !b.sessiz).length;
  }

  static Future<void> rozetGuncelle() async {
    rozet.value = await okunmamisSayisi();
  }

  static Future<void> hepsiniOkunduYap() async {
    final liste = await listeyiOku();
    if (liste.isEmpty) return;
    await _listeyiKaydet(
      liste
          .map((b) => Bildirim(
                id: b.id,
                tip: b.tip,
                baslik: b.baslik,
                mesaj: b.mesaj,
                zaman: b.zaman,
                hedef: b.hedef,
                okundu: true,
                sessiz: b.sessiz,
              ))
          .toList(),
    );
    await rozetGuncelle();
  }

  static Future<void> biriniOkunduYap(String id) async {
    final liste = await listeyiOku();
    await _listeyiKaydet(liste.map((b) {
      if (b.id != id) return b;
      return Bildirim(
        id: b.id,
        tip: b.tip,
        baslik: b.baslik,
        mesaj: b.mesaj,
        zaman: b.zaman,
        hedef: b.hedef,
        okundu: true,
        sessiz: b.sessiz,
      );
    }).toList());
  }

  // ---------------- SESSİZ MODU ----------------

  static Future<bool> sessizDurumu() async {
    final p = await _p;
    return p.getBool(_keySessiz) ?? false;
  }

  static Future<bool> sessizDegistir() async {
    final p = await _p;
    final yeni = !(p.getBool(_keySessiz) ?? false);
    await p.setBool(_keySessiz, yeni);
    await rozetGuncelle();
    return yeni;
  }

  // ---------------- TÜR AYARLARI ----------------

  static Future<bool> ayarOku(BildirimTipi tip) async {
    final p = await _p;
    return p.getBool('bildirim_ayar_${tip.name}') ??
        (tip != BildirimTipi.ummet);
  }

  static Future<void> ayarYaz(BildirimTipi tip, bool deger) async {
    final p = await _p;
    await p.setBool('bildirim_ayar_${tip.name}', deger);
  }

  // ---------------- KAZA NAMAZ ----------------

  static Future<int> kazaOku() async {
    final p = await _p;
    return p.getInt(_keyKaza) ?? 3;
  }

  static Future<int> kazaYaz(int deger) async {
    final p = await _p;
    await p.setInt(_keyKaza, deger.clamp(0, 50));
    return deger.clamp(0, 50);
  }
}
