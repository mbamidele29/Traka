import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationManager {

  LocalNotificationManager._();
  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
          'high_importance_channel', 'High Importance Notifications',
          importance: Importance.high);

  static const _initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');
  static const _initializationSettingsIOs = DarwinInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
  );

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void showNotification({required String title, required String body}) {
    _flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
        android: _initializationSettingsAndroid,
        iOS: _initializationSettingsIOs));

    _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
            _androidChannel.id, _androidChannel.name),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          badgeNumber: 1,
          attachments: null,
        ),
      ),
    );
  }
}
