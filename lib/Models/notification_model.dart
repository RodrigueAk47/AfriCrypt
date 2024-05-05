import 'package:africrypt/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class NotificationModel {

  static Future<void> showNotification(RemoteNotification notification) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_ID', 'channel_name', channelDescription: 'channel_description',
        importance: Importance.max, priority: Priority.max, showWhen: false,
        fullScreenIntent: true,


      );

      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          0, notification.title, notification.body, platformChannelSpecifics,
          payload: 'item x');
    }
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('A bg message just showed up :  ${message.messageId}');
  }

  static void configureFirebaseListeners() {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.requestPermission(
      criticalAlert: true,
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void initNotify () {
    var initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    NotificationModel.configureFirebaseListeners();




    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && defaultTargetPlatform == TargetPlatform.android) {
        print('Message title: ${notification.title}, body: ${notification.body}');
        NotificationModel.showNotification(notification);
      }
    });

    FirebaseMessaging.onBackgroundMessage(NotificationModel.firebaseMessagingBackgroundHandler);
  }
}