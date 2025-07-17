import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

abstract class LocalNotificationsServices {
  const LocalNotificationsServices();

  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null, // icon for notification, null uses default app icon
      [
        NotificationChannel(
          channelKey: 'main_channel',
          channelName: 'Main Notifications',
          channelDescription: 'Main notification channel',
          defaultColor: null,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          playSound: true,
        ),
      ],
      debug: false,
    );
  }

  static NotificationContent _notificationContent(RemoteMessage message) {
    return NotificationContent(
      id: 3,
      channelKey: 'main_channel',
      title: message.notification?.title,
      body: message.notification?.body,
      payload: message.data.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  static Future<void> showNotification(RemoteMessage message) async {
    await AwesomeNotifications().createNotification(
      content: _notificationContent(message),
    );
  }
}
