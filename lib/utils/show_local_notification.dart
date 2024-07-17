

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
  AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    'New Notification', // Notification title
    'This is a notification message', // Notification body
    platformChannelSpecifics,
    payload: 'item x', // You can add a payload here
  );
}
