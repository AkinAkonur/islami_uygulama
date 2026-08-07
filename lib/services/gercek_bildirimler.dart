import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'bildirim_merkezi.dart';
import 'vakit_servisi.dart';

/// Telefona gerçek (OS) bildirimleri zamanlar: her namaz vakti, günün ayeti
/// ve cuma hatırlatması. Kullanıcının ayarlarına göre planlar.
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

  static const NotificationDetails _namazDetay = NotificationDetails(
    android: AndroidNotificationDetails(
      'namaz_vakitleri',
      'Namaz Vakitleri',
      channelDescription: 'Namaz vakti girdiğinde ve günlük ibadet '
          'hatırlatmalarında bildirim gönderir.',
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
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

      // 1) NAMAZ vakitleri
      if (await BildirimMerkezi.ayarOku(BildirimTipi.namaz)) {
        var id = 1001;
        for (final v in vakitler) {
          if (v.ad == 'Güneş') continue; // Güneş vaktinde bildirim yok
          await _plugin.zonedSchedule(
            id: id++,
            title: '${v.ad} vakti girdi',
            body: 'Namaz vakti — ${v.saatYaz}',
            scheduledDate: gunlukHedef(v.saat, v.dakika),
            notificationDetails: _namazDetay,
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
    } catch (_) {
      // Zamanlama başarısız olursa uygulama akışını bozma.
    }
  }
}
