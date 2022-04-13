import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApp extends StatefulWidget {
  const NotificationApp({Key? key}) : super(key: key);

  @override
  _NotificationAppState createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  FlutterLocalNotificationsPlugin? localNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize =
        new AndroidInitializationSettings("@mipmap/ic_launcher");
    //https://stackoverflow.com/questions/55820299/flutter-local-notifications-platformexception-platformexceptioninvalid-icon
    var iOSInitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification!.initialize(initializationSettings);
  }

  Future<void> showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "Description of notification",
        importance: Importance.high);
    var iOSDetials = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetials);
    await localNotification!.show(0, "Notif Title", "The Body of Notification ",
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNotification();
        },
      ),
    );
  }
}
