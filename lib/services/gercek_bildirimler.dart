import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'bildirim_merkezi.dart';
import 'dua_store.dart';
import 'dualar_verileri.dart';
import 'ilham_store.dart';
import 'ilham_verileri.dart';
import 'namaz_bildirim_ayarlari.dart';
import 'vakit_servisi.dart';
import '../l10n/app_localizations.dart';

/// Telefona gerçek (OS) bildirimleri zamanlar: her namaz vakti, günün ayeti,
/// cuma hatırlatması ve kullanıcının kurduğu dua hatırlatıcıları.
/// Kullanıcının ayarlarına göre planlar.
class GercekBildirimler {
  GercekBildirimler._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _hazir = false;
  static Future<void>? _planSirasi;
  static bool _zamanlayiciHazir = false;

  static bool _destekleniyor() {
    if (kIsWeb) return false;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
      default:
        return false;
    }
  }

  /// Namaz bildirimleri detayı; titreşim ayara göre açılıp kapatılabilir.
  /// Android'de `ozel_ses` ayarındaki ezan (res/raw/ezan_kisa.mp3) çalınır;
  /// ayar boşsa sistemin varsayılan bildirim sesi kullanılır.
  ///
  /// Kanal kimliği kaçınılmaz olarak `_ezan` son ekini taşır: eski kurulumlarda
  /// `namaz_vakitleri` kanalı sesisiz oluşturulduğu için ses değişikliği ancak
  /// yeni bir kanalla (yeniden) uygulanır.
  static NotificationDetails _namazDetay(bool titresimAktif) {
    final ses = _namazSesKaynagi();
    final seciliSes = NamazBildirimAyarlari.ses.value;
    return NotificationDetails(
      android: AndroidNotificationDetails(
        // Android bildirim kanalının sesi oluşturulduktan sonra değişmez.
        // Bu nedenle her yerleşik sesin ayrı, sabit bir kanal kimliği vardır.
        'namaz_vakitleri_v2_${seciliSes.kod}_${titresimAktif ? 'v1' : 'v0'}',
        'Namaz Vakitleri',
        channelDescription:
            'Namaz vakti girdiğinde ezan sesiyle ve günlük '
            'ibadet hatırlatmalarında bildirim gönderir.',
        importance: Importance.high,
        priority: Priority.high,
        category: AndroidNotificationCategory.reminder,
        enableVibration: titresimAktif,
        playSound: seciliSes != BildirimSesi.sessiz,
        sound: ses == null ? null : RawResourceAndroidNotificationSound(ses),
      ),
      iOS: DarwinNotificationDetails(presentSound: seciliSes != BildirimSesi.sessiz),
      macOS: DarwinNotificationDetails(presentSound: seciliSes != BildirimSesi.sessiz),
    );
  }

  /// Seçilen ses ayarından Android raw kaynak adını türetir
  /// (örn. "ezan_kisa.mp3" → "ezan_kisa"). Boşsa null döner.
  static String? _namazSesKaynagi() {
    final ayar = NamazBildirimAyarlari.ozelSes.trim();
    if (ayar.isEmpty) return null;
    return ayar.endsWith('.mp3') ? ayar.substring(0, ayar.length - 4) : ayar;
  }

  /// Exact alarm izni üretici/Android sürümüne göre reddedilirse planlamayı
  /// tamamen bırakma. Önce isabetli alarmı dener, izin yoksa cihazın izin
  /// verdiği inexactAllowWhileIdle moduna düşer. Böylece kullanıcı bildirimleri
  /// kaybetmez; yalnızca birkaç dakikalık sistem toleransı oluşabilir.
  static Future<bool> _guvenliZamanla({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required NotificationDetails notificationDetails,
    DateTimeComponents? matchDateTimeComponents,
    bool tamZaman = false,
  }) async {
    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: notificationDetails,
        androidScheduleMode: tamZaman
            ? AndroidScheduleMode.exactAllowWhileIdle
            : AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: matchDateTimeComponents,
      );
      return true;
    } catch (e) {
      if (!tamZaman) {
        debugPrint('[Bildirim] $id planlanamadı: $e');
        return false;
      }
      try {
        await _plugin.zonedSchedule(
          id: id,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: notificationDetails,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: matchDateTimeComponents,
        );
        debugPrint('[Bildirim] $id exact izin yok; inexact yedek kullanıldı');
        return true;
      } catch (yedekHata) {
        debugPrint('[Bildirim] $id yedek planlama hatası: $yedekHata');
        return false;
      }
    }
  }

  static const NotificationDetails _gunlukDetay = NotificationDetails(
    android: AndroidNotificationDetails(
      'gunluk_maneviyat',
      'Günlük Maneviyat',
      channelDescription: 'Günün ayeti ve cuma hatırlatmaları.',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    ),
    iOS: DarwinNotificationDetails(),
    macOS: DarwinNotificationDetails(),
  );

  static const NotificationDetails _duaDetay = NotificationDetails(
    android: AndroidNotificationDetails(
      'dua_hatirlatmalar',
      'Dua Hatırlatıcıları',
      channelDescription:
          'Kullanıcının seçtiği dua için kurduğu hatırlatıcılar.',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
    ),
    iOS: DarwinNotificationDetails(),
    macOS: DarwinNotificationDetails(),
  );

  static const NotificationDetails _ilhamDetay = NotificationDetails(
    android: AndroidNotificationDetails(
      'gunun_ilhami',
      'Günün İlhamı',
      channelDescription:
          'Kullanıcının belirlediği saatte günün hikmetli sözü.',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
    ),
    iOS: DarwinNotificationDetails(),
    macOS: DarwinNotificationDetails(),
  );

  /// Eklentiyi hazırlar ve gerekli izinleri ister.
  ///
  /// Başarısız kurulumda `_hazir` false kalır; böylece sonraki çağrılar
  /// tekrar deneme şansı bulur. Hatalar [debugPrint] ile loglanır.
  static Future<void> kurulum({bool izinIste = true}) async {
    if (!_destekleniyor() || _hazir) return;
    try {
      tz.initializeTimeZones();
      try {
        final bolge = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(bolge.identifier));
      } catch (_) {
        tz.setLocalLocation(tz.UTC);
      }

      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const darwin = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      await _plugin.initialize(
        settings: const InitializationSettings(
          android: android,
          iOS: darwin,
          macOS: darwin,
        ),
      );

      // Android 13+ bildirim izni
      if (izinIste && defaultTargetPlatform == TargetPlatform.android) {
        final androidPlugin = _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
        await androidPlugin?.requestNotificationsPermission();
        await androidPlugin?.requestExactAlarmsPermission();
      }
      _hazir = true;
      _zamanlayiciHazir = true;
    } catch (e) {
      debugPrint('[Bildirim] kurulum hatası: $e');
      // _hazir false kalır → sonraki çağrı tekrar deneyecek.
    }
  }

  /// Tüm zamanlanmış bildirimleri ayarlara göre yeniden planlar.
  /// Sessiz mod açıksa tüm bildirimleri iptal eder.
  static Future<void> planla() {
    final onceki = _planSirasi;
    final islem = onceki == null ? _planla() : onceki.then((_) => _planla());
    late final Future<void> sonuc;
    sonuc = islem.catchError((Object e) {
      debugPrint('[Bildirim] Planlama kuyruğu hatası: $e');
    }).whenComplete(() {
      if (identical(_planSirasi, sonuc)) _planSirasi = null;
    });
    _planSirasi = sonuc;
    return sonuc;
  }

  /// Her test kendi platform kanalları ve asenkron bölgesinde başlar.
  @visibleForTesting
  static void testDurumunuSifirla() {
    _hazir = false;
    _zamanlayiciHazir = false;
    _planSirasi = null;
  }

  static Future<void> _planla() async {
    if (!_destekleniyor() || !_zamanlayiciHazir) return;
    if (!await BildirimMerkezi.masterOku() || await BildirimMerkezi.sessizDurumu()) {
      await _plugin.cancelAll();
      return;
    }
    var sayac = 0;
    try {
      await NamazBildirimAyarlari.yukle();
      final namazAcik = await BildirimMerkezi.ayarOku(BildirimTipi.namaz);
      final takvimler = <({DateTime tarih, VakitTakvimi gun})>[];
      if (namazAcik) {
        final now = DateTime.now();
        for (var i = 0; i < 3; i++) {
          final tarih = DateTime(now.year, now.month, now.day + i);
          try {
            final gun = await VakitServisi.bildirimTakvimi(tarih);
            takvimler.add((tarih: tarih, gun: gun));
          } catch (e) {
            debugPrint('[Bildirim] $tarih için gerçek vakit alınamadı: $e');
          }
        }
      }
      // Silme öncesi tercihleri yeniden kontrol et: ağ sürerken kullanıcı
      // kapatmışsa önceki isteğin alarm kurmasına izin verme.
      if (!await BildirimMerkezi.masterOku() || await BildirimMerkezi.sessizDurumu()) {
        await _plugin.cancelAll();
        return;
      }
      final bekleyenler = await _plugin.pendingNotificationRequests();
      for (final b in bekleyenler) {
        // Eski, her gün aynı saate tekrar eden namaz alarmlarını temizle.
        final vakitIndex = b.id % 10;
        final vakitKapali = b.id >= 100000 && vakitIndex < NamazVakti.values.length &&
            NamazBildirimAyarlari.kapaliMi(NamazVakti.values[vakitIndex]);
        if (vakitKapali || (b.id >= 1001 && b.id < 2000) ||
            (b.id >= 100000 && !namazAcik) ||
            b.id == 2001 || b.id == 3001 || b.id == 5001 ||
            (b.id >= 4001 && b.id < 5000)) {
          await _plugin.cancel(id: b.id);
        }
      }
      final now = DateTime.now();
      final bugun = DateTime(now.year, now.month, now.day);
      tz.TZDateTime gunlukHedef(int saat, int dakika) {
        final ist = tz.TZDateTime(
          tz.local,
          bugun.year,
          bugun.month,
          bugun.day,
          saat,
          dakika,
        );
        return ist.isBefore(tz.TZDateTime.now(tz.local))
            ? ist.add(const Duration(days: 1))
            : ist;
      }

      // Tarih + saat dilimi bazlı, üç günlük tek seferlik namaz alarmları.
      // Bugünün saatleri ertesi güne kopyalanmaz.
      if (namazAcik) {
        final detay = _namazDetay(NamazBildirimAyarlari.titresim.value);
        for (final kayit in takvimler) {
          final bolge = tz.getLocation(kayit.gun.saatDilimi);
          for (final v in kayit.gun.vakitler) {
            final vakit = NamazVakti.adindan(v.ad);
            if (vakit == null) continue;
            final gunNo = DateTime.utc(kayit.tarih.year, kayit.tarih.month,
                kayit.tarih.day).millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
            final id = 100000 + gunNo * 10 + vakit.index;
            final dakikaOnce = NamazBildirimAyarlari.dakikaOnce(vakit);
            if (dakikaOnce < 0) {
              await _plugin.cancel(id: id);
              continue;
            }
            final hedef = tz.TZDateTime(bolge, kayit.tarih.year,
                kayit.tarih.month, kayit.tarih.day, v.saat, v.dakika)
                .subtract(Duration(minutes: dakikaOnce));
            if (!hedef.isAfter(tz.TZDateTime.now(bolge))) {
              await _plugin.cancel(id: id);
              continue;
            }
            final planlandi = await _guvenliZamanla(
              id: id,
              title: dakikaOnce == 0
                  ? AppLocalizations.aktif.t('nt.prayerNow').replaceAll('{name}', v.ad)
                  : AppLocalizations.aktif
                      .t('nt.prayerIn')
                      .replaceAll('{name}', v.ad)
                      .replaceAll('{min}', '$dakikaOnce'),
              body: AppLocalizations.aktif.t('nt.prayerBody').replaceAll('{time}', v.saatYaz),
              scheduledDate: hedef,
              notificationDetails: detay,
              tamZaman: true,
            );
            if (planlandi) sayac++;
          }
        }
      }

      // 2) GÜNLÜK ayet
      if (await BildirimMerkezi.ayarOku(BildirimTipi.gunluk)) {
        await _plugin.zonedSchedule(
          id: 2001,
          title: AppLocalizations.aktif.t('nt.verseTitle'),
          body: AppLocalizations.aktif.t('nt.verseBody'),
          scheduledDate: gunlukHedef(9, 0),
          notificationDetails: _gunlukDetay,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
        sayac++;
      }

      // 3) CUMA hatırlatması
      if (await BildirimMerkezi.ayarOku(BildirimTipi.ozelGun)) {
        var cuma = gunlukHedef(11, 30);
        while (cuma.weekday != DateTime.friday) {
          cuma = cuma.add(const Duration(days: 1));
        }
        await _plugin.zonedSchedule(
          id: 3001,
          title: AppLocalizations.aktif.t('nt.fridayTitle'),
          body: AppLocalizations.aktif.t('nt.fridayBody'),
          scheduledDate: cuma,
          notificationDetails: _gunlukDetay,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
        sayac++;
      }

      // 4) Kullanıcının kurduğu DUA hatırlatıcıları (id: 4001+)
      await duaHatirlatmalariPlanla();

      // 5) GÜNÜN İLHAMI hatırlatıcısı (id: 5001)
      await ilhamHatirlatmasiPlanla();
      debugPrint('[Bildirim] planla tamamlandı — $sayac bildirim zamanlandı');
    } catch (e) {
      debugPrint('[Bildirim] planla hatası: $e');
    }
  }

  /// Vakit zamanından "dakika önce" hedef zamanı hesaplar.
  /// `dakikaOnce <= 0` ise vaktin kendisi döner.
  @visibleForTesting
  static DateTime namazBildirimZamani(DateTime vakitZamani, int dakikaOnce) {
    if (dakikaOnce <= 0) return vakitZamani;
    return vakitZamani.subtract(Duration(minutes: dakikaOnce));
  }

  /// Ayarlar sayfasındaki "Test Bildirimi Gönder" düğmesi için 5 saniye sonra
  /// tek seferlik bir bildirim zamanlar (id: 9001).
  static Future<bool> testBildirimi() async {
    if (!_destekleniyor()) return false;
    if (!_zamanlayiciHazir) await kurulum();
    if (!_zamanlayiciHazir) return false;
    try {
      final now = tz.TZDateTime.now(tz.local);
      await NamazBildirimAyarlari.yukle();
      if (await bildirimIzniVarMi() == false) return false;
      return await _guvenliZamanla(
        id: 9001,
        title: AppLocalizations.aktif.t('nt.reminderChannel'),
        body: AppLocalizations.aktif.t('nt.testBody'),
        scheduledDate: now.add(const Duration(seconds: 5)),
        notificationDetails: _namazDetay(NamazBildirimAyarlari.titresim.value),
        tamZaman: true,
      );
    } catch (e) {
      debugPrint('[Bildirim] testBildirimi hatası: $e');
      return false;
    }
  }

  /// Android/iOS/macOS'te sistem bildirimlerinin gerçekten açık olup olmadığını
  /// döndürür. Plugin henüz başlatılmadıysa veya çağrı desteklenmiyorsa null döner.
  static Future<bool?> bildirimIzniVarMi() async {
    // Debug APK da gerçek cihazda izin durumunu sorgulamalıdır.
    if (!_destekleniyor()) return null;
    try {
      return await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.areNotificationsEnabled();
    } catch (e) {
      debugPrint('[Bildirim] izin kontrolü hatası: $e');
      return null;
    }
  }

  /// Anlık test bildirisi — zamanlayıcıya bağımlı olmadan hemen gösterir.
  ///
  /// Zamanlayıcı henüz hazır değilse bile [kurulum]'u tazeleyip denemeye devam
  /// eder; böylece kullanıcı bir kez izin verdikten sonra test hemen çalışır.
  static Future<bool> anlikTest() async {
    if (!_destekleniyor()) return false;
    if (!_zamanlayiciHazir) await kurulum();
    if (!_zamanlayiciHazir) {
      debugPrint('[Bildirim] anlikTest: zamanlayıcı hazır değil');
      return false;
    }
    try {
      await NamazBildirimAyarlari.yukle();
      if (await bildirimIzniVarMi() == false) return false;
      await _plugin.show(
        id: 9002,
        title: AppLocalizations.aktif.t('nt.testTitle'),
        body: AppLocalizations.aktif.t('nt.testShortBody'),
        notificationDetails: _namazDetay(NamazBildirimAyarlari.titresim.value),
      );
      return true;
    } catch (e) {
      debugPrint('[Bildirim] anlikTest hatası: $e');
      return false;
    }
  }

  /// Kullanıcının seçtiği saatte günün hikmetli sözünü bildirir (her gün).
  static Future<void> ilhamHatirlatmasiPlanla() async {
    if (!_destekleniyor() || !_zamanlayiciHazir) return;
    try {
      if (!await BildirimMerkezi.masterOku() || await BildirimMerkezi.sessizDurumu()) return;
      await _plugin.cancel(id: 5001);
      await IlhamStore.yukle();
      final kayit = IlhamStore.hatirlatma.value;
      if (kayit == null) return;

      // Bildirim metni: bugünün içeriğinden kısa bir satır.
      var gorunen = 'İlham ve hikmet köşesi seni bekliyor ✨';
      try {
        final akis = await IlhamVerileri.instance.gununAkisi();
        if (akis.isNotEmpty) {
          final ilk = akis.first;
          gorunen = '${ilk.baslik}: ${ilk.metin}';
          if (gorunen.length > 100) {
            gorunen = '${gorunen.substring(0, 97)}...';
          }
        }
      } catch (_) {}

      final now = DateTime.now();
      final bugun = DateTime(now.year, now.month, now.day);
      var hedef = tz.TZDateTime(
        tz.local,
        bugun.year,
        bugun.month,
        bugun.day,
        kayit.saat,
        kayit.dakika,
      );
      if (hedef.isBefore(tz.TZDateTime.now(tz.local))) {
        hedef = hedef.add(const Duration(days: 1));
      }

      await _plugin.zonedSchedule(
        id: 5001,
        title: AppLocalizations.aktif.t('nt.ilhamTitle'),
        body: gorunen,
        scheduledDate: hedef,
        notificationDetails: _ilhamDetay,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (_) {
      // Zamanlama hataları sessizce yutulur.
    }
  }

  /// Kullanıcının "Hatırlatıcı Kur" ile seçtiği duaları OS takvimine işler.
  /// Her gün → günlük tekrar; belirli günler → o günlerde haftalık tekrar.
  /// Sessiz mod açıksa hiçbir şey planlanmaz (planla() zaten iptal eder).
  static Future<void> duaHatirlatmalariPlanla() async {
    if (!_destekleniyor() || !_zamanlayiciHazir) return;
    try {
      if (!await BildirimMerkezi.masterOku() || await BildirimMerkezi.sessizDurumu()) return;
      final bekleyenler = await _plugin.pendingNotificationRequests();
      for (final bildirim in bekleyenler) {
        if (bildirim.id >= 4001 && bildirim.id < 5000) {
          await _plugin.cancel(id: bildirim.id);
        }
      }
      await DuaStore.yukle();
      final kayitlar = DuaStore.hatirlatmalar.value.values.toList();
      if (kayitlar.isEmpty) return;

      final now = DateTime.now();
      final bugun = DateTime(now.year, now.month, now.day);

      // Bildirim başlığı için dua adını alır (önbellek kullanılır).
      Future<String> baslikBul(String duaId) async {
        final d = await DualarVerileri.instance.idIleBul(duaId);
        return d?.baslik ?? 'Dua Vakti';
      }

      var id = 4001;
      for (final kayit in kayitlar) {
        final baslik = await baslikBul(kayit.duaId);
        tz.TZDateTime hedef(int gun, int saat, int dakika) {
          var tarih = tz.TZDateTime(
            tz.local,
            bugun.year,
            bugun.month,
            bugun.day,
            saat,
            dakika,
          );
          while (tarih.isBefore(tz.TZDateTime.now(tz.local))) {
            tarih = tarih.add(const Duration(days: 1));
          }
          if (gun != 0 && tarih.weekday != gun) {
            var fark = (gun - tarih.weekday) % 7;
            if (fark < 0) fark += 7;
            tarih = tarih.add(Duration(days: fark));
          }
          return tarih;
        }

        if (kayit.gunler.isEmpty) {
          // Her gün, seçilen saatte.
          await _guvenliZamanla(
            id: id++,
            title: AppLocalizations.aktif.t('nt.duaTitle'),
            body: baslik,
            scheduledDate: hedef(0, kayit.saat, kayit.dakika),
            notificationDetails: _duaDetay,
            tamZaman: true,
            matchDateTimeComponents: DateTimeComponents.time,
          );
        } else {
          // Belirli günlerde haftalık tekrar (her gün için bir kayıt).
          for (final gun in kayit.gunler.toSet()) {
            await _guvenliZamanla(
              id: id++,
              title: AppLocalizations.aktif.t('nt.duaTitle'),
              body: baslik,
              scheduledDate: hedef(gun, kayit.saat, kayit.dakika),
              notificationDetails: _duaDetay,
              tamZaman: true,
              matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
            );
          }
        }
      }
    } catch (_) {
      // Zamanlama hataları sessizce yutulur; uygulama akışı bozulmaz.
    }
  }
}
