import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:attach_club/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
}

@pragma('vm:entry-point')
void handleLocalBackgroundMessage(NotificationResponse response) {
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    "High Importance Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) async {
    if (message == null) {
      return;
    }
    navigatorKey.currentState?.pushNamed('/notifications');
  }

  Future initLocalNotifications() async {
    const android = AndroidInitializationSettings("@drawable/launch");
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
        handleMessage(message);
      },
      onDidReceiveBackgroundNotificationResponse: handleLocalBackgroundMessage,
    );

    // if (Platform.isAndroid) {
    //   final platform =
    //       _localNotifications.resolvePlatformSpecificImplementation<
    //           AndroidFlutterLocalNotificationsPlugin>();
    //   await platform?.createNotificationChannel(_androidChannel);
    // }
  }

  void initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) async {
      final notification = message.notification;
      if (notification == null) {
        return;
      }
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: "@drawable/launch",
            importance: _androidChannel.importance,
          ),
          iOS: const DarwinNotificationDetails()
        ),
        payload: jsonEncode(notification.toMap()),
      );
    });
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    initPushNotifications();
    initLocalNotifications();
    //eh8nYTpAQeO4jyXkwg4fPx:APA91bF-pm3HJmDe_W20fbF0x51hPBnK0znUxfS4Z_9DeRRzBtzpzj1XtWZudM-CAYia4tcZqNctI5PpLrAnlGIRLTSxcObgDQZ1R3RD8CgbCs9390QQT1KR9gJcNdBHd3xe1U97-dW9
  }
}
