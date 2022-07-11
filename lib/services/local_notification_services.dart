import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationServices {
  
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future init({bool scheduled = false}) async {
    const initAndroidSettings = AndroidInitializationSettings('@mipmap/ic_pet');
    const ios = IOSInitializationSettings();
    const settings = InitializationSettings(android: initAndroidSettings, iOS: ios);
    await _notification.initialize(settings);
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'adoptapetchannel',
        'adoptapetchannel',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );
}
