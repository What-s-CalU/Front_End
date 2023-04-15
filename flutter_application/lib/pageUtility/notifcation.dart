import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> showNotification() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const NotificationDetails androidPlatformChannelSpecifics = 
    NotificationDetails(
      android: AndroidNotificationDetails("events", "events"),  //Required for Android 8.0 or after
    );
await flutterLocalNotificationsPlugin.show(
        12345, 
        "A Notification From My Application",
        "This notification was sent using Flutter Local Notifcations Package", 
        androidPlatformChannelSpecifics,
        payload: 'data');
}

