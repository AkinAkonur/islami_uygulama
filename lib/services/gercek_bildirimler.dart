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

/// Telefona gerçek (OS) bildirimleri zamanlar: her namaz vakti, günün ayeti,
/// cuma hatırlatması ve kullanıcının kurduğu dua hatırlatıcıları.
/// Kullanıcının ayarlarına göre planlar.
class GercekBildirimler {
  GercekBildirimler._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool _hazir = false;
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
  static NotificationDetails _namazDetay(bool titresimAktif) =>
      NotificationDetails(
        android: AndroidNotificationDetails(
          'namaz_vakitleri',
          'Namaz Vakitleri',
          channelDescription: 'Namaz vakti girdiğinde ve günlük ibadet '
              'hatırlatmalarında bildirim gönderir.',
          importance: Importance.high,
          priority: Priority.high,
          category: AndroidNotificationCategory.reminder,
          enableVibration: titresimAktif,
        ),
        iOS: DarwinNotificationDetails(),
        macOS: DarwinNotificationDetails(),
      );

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
      channelDescription: 'Kullanıcının seçtiği dua için kurduğu hatırlatıcılar.',
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
      channelDescription: 'Kullanıcının belirlediği saatte günün hikmetli sözü.',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
    ),
    iOS: DarwinNotificationDetails(),
    macOS: DarwinNotificationDetails(),
  );

  /// Eklentiyi hazırlar ve gerekli izinleri ister. Güvenli (hata yutmaz değil,
  /// tüm hataları yakalar) — test ve desteklenmeyen platformlarda sessizce döner.
  static Future<void> kurulum() async {
    if (!_destekleniyor() || _hazir) return;
    _hazir = true;
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
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidPlugin =
            _plugin.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();
        await androidPlugin?.requestNotificationsPermission();
        await androidPlugin?.requestExactAlarmsPermission();
      }
      _zamanlayiciHazir = true;
    } catch (_) {
      // Desteklenmeyen ortam (test vb.) — sessizce devam et.
    }
  }

  /// Tüm zamanlanmış bildirimleri ayarlara göre yeniden planlar.
  /// Sessiz mod açıksa tüm bildirimleri iptal eder.
  static Future<void> planla() async {
    if (!_destekleniyor() || !_zamanlayiciHazir) return;
    if (await BildirimMerkezi.sessizDurumu()) {
      await _plugin.cancelAll();
      return;
    }
    try {
      await _plugin.cancelAll();

      final vakitler = await VakitServisi.gunlukVakitler();
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

      // 1) NAMAZ vakitleri — her vakit için "X dakika önce" ayarı (id: 1001+)
      if (await BildirimMerkezi.ayarOku(BildirimTipi.namaz)) {
        await NamazBildirimAyarlari.yukle();
        final titresim = NamazBildirimAyarlari.titresim.value;
        final detay = _namazDetay(titresim);
        var id = 1001;
        for (final v in vakitler) {
          final vakit = NamazVakti.adindan(v.ad);
          if (vakit == null) continue;
          final dakikaOnce = NamazBildirimAyarlari.dakikaOnce(vakit);
          if (dakikaOnce < 0) continue; // Vakit için bildirimler Kapalı

          final hedef = namazBildirimZamani(
            DateTime(bugun.year, bugun.month, bugun.day, v.saat, v.dakika),
            dakikaOnce,
          );
          final vaktinde = dakikaOnce == 0;
          await _plugin.zonedSchedule(
            id: id++,
            title: vaktinde ? '${v.ad} vakti girdi' : '${v.ad} vaktine $dakikaOnce dk kaldı',
            body: vaktinde
                ? 'Namaz vakti — ${v.saatYaz}'
                : 'Namaz vakti ${v.saatYaz} — ${v.ad} için hazır ol ${dakikaOnce} dakika içinde',
            scheduledDate: gunlukHedef(hedef.hour, hedef.minute),
            notificationDetails: detay,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.time,
          );
        }
      }

      // 2) GÜNLÜK ayet
      if (await BildirimMerkezi.ayarOku(BildirimTipi.gunluk)) {
        await _plugin.zonedSchedule(
          id: 2001,
          title: 'Günün Ayeti',
          body: 'İnşirah: Her zorlukla birlikte bir kolaylık vardır. (94:6)',
          scheduledDate: gunlukHedef(9, 0),
          notificationDetails: _gunlukDetay,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      }

      // 3) CUMA hatırlatması
      if (await BildirimMerkezi.ayarOku(BildirimTipi.ozelGun)) {
        var cuma = gunlukHedef(11, 30);
        while (cuma.weekday != DateTime.friday) {
          cuma = cuma.add(const Duration(days: 1));
        }
        await _plugin.zonedSchedule(
          id: 3001,
          title: 'Bugün Cuma',
          body: 'Hutbe öncesi cuma namazını planlamayı unutma.',
          scheduledDate: cuma,
          notificationDetails: _gunlukDetay,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }

      // 4) Kullanıcının kurduğu DUA hatırlatıcıları (id: 4001+)
      await duaHatirlatmalariPlanla();

      // 5) GÜNÜN İLHAMI hatırlatıcısı (id: 5001)
      await ilhamHatirlatmasiPlanla();
    } catch (_) {
      // Zamanlama başarısız olursa uygulama akışını bozma.
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
    if (!_destekleniyor() || !_zamanlayiciHazir) return false;
    try {
      final now = tz.TZDateTime.now(tz.local);
      await _plugin.zonedSchedule(
        id: 9001,
        title: 'Namaz Vakti Hatırlatıcıları',
        body: 'Bildirimler çalışıyor. Bu bir test bildirimi. 👍',
        scheduledDate: now.add(const Duration(seconds: 5)),
        notificationDetails: _namazDetay(
          NamazBildirimAyarlari.titresim.value,
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Kullanıcının seçtiği saatte günün hikmetli sözünü bildirir (her gün).
  static Future<void> ilhamHatirlatmasiPlanla() async {
    if (!_destekleniyor() || !_zamanlayiciHazir) return;
    try {
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
        title: 'Günün İlhamı ✨',
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
          await _plugin.zonedSchedule(
            id: id++,
            title: 'Dua Vakti 🤲',
            body: baslik,
            scheduledDate: hedef(0, kayit.saat, kayit.dakika),
            notificationDetails: _duaDetay,
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            matchDateTimeComponents: DateTimeComponents.time,
          );
        } else {
          // Belirli günlerde haftalık tekrar (her gün için bir kayıt).
          for (final gun in kayit.gunler.toSet()) {
            await _plugin.zonedSchedule(
              id: id++,
              title: 'Dua Vakti 🤲',
              body: baslik,
              scheduledDate: hedef(gun, kayit.saat, kayit.dakika),
              notificationDetails: _duaDetay,
              androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
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
