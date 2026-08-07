import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manevi_store.dart';
import 'vakit_servisi.dart';

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
  static const _keyMaster = 'ayar_master_bildirim';

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

  /// Günün bildirimlerini üretir ve Bugün bölümündeki namaz kaydını canlı tutar.
  static Future<void> guncelle() async {
    final p = await _p;
    final now = DateTime.now();
    final bugunKey = _tarihKey(now);
    if (p.getString(_keySonGun) != bugunKey) {
      await _uretimYap(now, bugunKey);
    }
    await bugunNamaziniTazele(now);
    await rozetGuncelle();
  }

  /// Bugünün "sıradaki vakit" kaydını her açılışta günceller. Böylece liste
  /// "öğle giriyor" gibi eski bir vakitte takılı kalmaz; o an girecek olan
  /// namazı gösterir.
  static Future<void> bugunNamaziniTazele(DateTime now) async {
    final vakit = await _siradakiVakit(now);
    if (vakit == null) return;
    final liste = await listeyiOku();
    if (liste.isEmpty) return;

    final bugunKey = _tarihKey(now);
    final hedefId = 'namaz_vakit_$bugunKey';
    var degisti = false;
    final yeni = liste
        .map((b) {
          if (b.id != hedefId) return b;
          degisti = true;
          return Bildirim(
            id: b.id,
            tip: b.tip,
            baslik: '${vakit.$1} ${vakit.$2}',
            mesaj: 'Sıradaki namaz — kalan ${vakit.$3}',
            zaman: now,
            hedef: b.hedef,
            okundu: b.okundu,
            sessiz: b.sessiz,
          );
        })
        .toList();
    if (degisti) await _listeyiKaydet(yeni);
  }

  /// Günün bildirim setini üretir (günde bir kez). En fazla 5 bildirim.
  static Future<void> _uretimYap(DateTime now, String bugunKey) async {
    final p = await _p;
    final yeni = <Bildirim>[];
    final sessiz = _sessizSaat(now);

    // 1) NAMAZ (çekirdek)
    if (await ayarOku(BildirimTipi.namaz)) {
      final vakit = await _siradakiVakit(now);
      if (vakit != null) {
        yeni.add(Bildirim(
          id: 'namaz_vakit_$bugunKey',
          tip: BildirimTipi.namaz,
          baslik: '${vakit.$1} ${vakit.$2}',
          mesaj: 'Sıradaki namaz — kalan ${vakit.$3}',
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
        final aksam = VakitServisi.aksamVakti(await VakitServisi.gunlukVakitler());
        final iftar = aksam?.saatYaz ?? 'güneş batımı';
        yeni.add(Bildirim(
          id: 'ozel_iftar_$bugunKey',
          tip: BildirimTipi.ozelGun,
          baslik: 'İftar yaklaşıyor',
          mesaj: 'İftar $iftar — orucunu unutma, ailenle paylaş.',
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
        mesaj: 'Bugün bir dua zincirine katıl ve kardeşlerine dua edip huzur bul.',
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
  }

  /// Sıradaki vakti gerçek vakit listesinden hesaplar; (ad, saat, kalan) döner.
  /// Yatsı'dan sonra sabahki İmsak'ı (ertesi gün) döndürür; hiçbir saatte
  /// "vakit yok" durumuna düşmez, böylece Bugün bölümü her zaman dolu olur.
  static Future<(String, String, String)?> _siradakiVakit(DateTime now) async {
    final vakitler = await VakitServisi.gunlukVakitler();
    if (vakitler.isEmpty) return null;

    final simdiDk = now.hour * 60 + now.minute;
    VakitBilgisi? secilen;
    for (final v in vakitler) {
      if (v.dakikaToplam > simdiDk) {
        secilen = v;
        break;
      }
    }

    // Geceyi aşan hesaplama: seçilen vakit bugün geçtiyse yarın aynı vakittir.
    final int kalanDk;
    if (secilen == null) {
      secilen = vakitler.first; // İmsak (yarın)
      kalanDk = secilen.dakikaToplam + 1440 - simdiDk;
    } else {
      kalanDk = secilen.dakikaToplam - simdiDk;
    }
    if (kalanDk <= 0) return null;

    final h = kalanDk ~/ 60;
    final m = kalanDk % 60;
    final kalanYaz = h > 0 ? '$h saat $m dk' : '$m dk';
    return (secilen.ad, secilen.saatYaz, kalanYaz);
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

  /// "Tüm Bildirimlere İzin Ver" ana anahtarı. Kapalıyken tüm türler kapanır,
  /// açıkken son tür tercihleri kullanılır.
  static Future<bool> masterOku() async {
    final p = await _p;
    return p.getBool(_keyMaster) ?? true;
  }

  static Future<void> masterYaz(bool deger) async {
    final p = await _p;
    await p.setBool(_keyMaster, deger);
    for (final t in BildirimTipi.values) {
      await p.setBool('bildirim_ayar_${t.name}', deger);
    }
  }

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
