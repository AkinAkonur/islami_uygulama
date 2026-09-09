import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Yalnızca testte OS kanalını taklit eder. Gerçek bildirim teslimini test etmez.
class NotificationPlatformFake {
  final calls = <MethodCall>[];
  bool permissionGranted = true;
  bool failScheduling = false;
  static const channel = MethodChannel('dexterous.com/flutter/local_notifications');
  static const timezone = MethodChannel('flutter_timezone');

  void install() {
    // Widget tests do not run the device's generated plugin registrant.
    // Register the real Dart Android implementation; only OS channel replies are fake.
    AndroidFlutterLocalNotificationsPlugin.registerWith();
    final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(timezone, (_) async {
      // Üretimde de desteklenen saat dilimi okuma hatası → UTC yedeği.
      throw PlatformException(code: 'TEST_TIMEZONE_UNAVAILABLE');
    });
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      switch (call.method) {
        case 'initialize':
        case 'requestNotificationsPermission':
        case 'requestExactAlarmsPermission':
          return true;
        case 'areNotificationsEnabled':
          return permissionGranted;
        case 'pendingNotificationRequests':
        case 'getActiveNotifications':
          return <dynamic>[];
        case 'zonedSchedule':
          if (failScheduling) {
            throw PlatformException(code: 'exact_alarms_not_permitted');
          }
          return null;
        case 'show':
        case 'cancel':
        case 'cancelAll':
          return null;
        default:
          throw MissingPluginException('Unhandled notification test method: ${call.method}');
      }
    });
  }

  void uninstall() {
    final messenger = TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(channel, null);
    messenger.setMockMethodCallHandler(timezone, null);
  }
}
