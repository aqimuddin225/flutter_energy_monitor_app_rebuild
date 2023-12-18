import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationProvider() {
    initializeNotifications();
    schedulePeriodicNotifications();
  }

  Future<void> initializeNotifications() async {
    const settingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: settingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    const androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name');
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Your Notification Title',
      'Your Notification Body',
      platformChannelSpecifics,
    );
  }

  Future<void> schedulePeriodicNotifications() async {
    const androidPlatformChannelSpecifics =
        AndroidNotificationDetails('periodic channel id', 'periodic channel name');
    const platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.periodicallyShow(
      1, // Notification ID for periodic notification
      'Periodic Notification Title',
      'This is a periodic notification',
      RepeatInterval.everyMinute, // Adjust as needed
      platformChannelSpecifics,
    );
  }
}