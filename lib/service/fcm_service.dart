import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'local_notification_service.dart';

class FCMService {
  FCMService._internal();

  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;

  //Instantiate Firebase Messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await LocalNotificationService().init();
    subscribeToTopic();

    // For handling notification when the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("onMessage recieved => ${message.toMap()}");
      log('onMessage body => ${message.notification?.body}');
      log('onMessage data => ${message.data}');
      LocalNotificationService().showNotification(
          title: message.notification?.title ?? "New",
          body: message.notification?.body ?? "Message");
    });

    // For handling notification when the app is in background
    // but not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("onMessageOpenedApp recieved => $message");
      log('onMessageOpenedApp body => ${message.notification?.body}');
      log('onMessageOpenedApp values => ${message.data.values}');
      LocalNotificationService().showNotification(
          title: message.notification?.title ?? "New",
          body: message.notification?.body ?? "Message");
    });

    // refresh token
    FirebaseMessaging.instance.onTokenRefresh.listen((onData) {
      log('onTokenRefresh => $onData');
    });
  }

  subscribeToTopic() {
    _firebaseMessaging.subscribeToTopic("WLOWeatherApp");
  }

  unSubscribeToTopic() {
    _firebaseMessaging.unsubscribeFromTopic("WLOWeatherApp");
  }

  Future<String> getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    log('FCM token => $token');
    return token ?? "";
  }

  Future<void> deleteFCMToken() async {
    return await _firebaseMessaging.deleteToken();
  }
}
