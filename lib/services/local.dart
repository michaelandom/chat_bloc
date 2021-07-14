import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HLocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  HLocalNotification() {
    var android =
        AndroidInitializationSettings('@mipmap/ic_notification_foreground');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);
  }

  static showNotification(RemoteMessage message) async {
    try {
      var android = AndroidNotificationDetails(
          'chatBlocID', 'chatBloc NAME', 'CHANNEL DESCRIPTION');
      var ios = IOSNotificationDetails();
      var platform = NotificationDetails(android: android, iOS: ios);
      await flutterLocalNotificationsPlugin.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          message.notification!.title,
          message.notification!.body,
          platform,
          payload: message.data.toString());
    } on Exception catch (e) {
      print(e);
    }
  }

  // on select notification action
  static Future onSelectNotification(var message) {
    final routerFromMessage = message;
    print(routerFromMessage);
    return Future.value(true);
  }
}
