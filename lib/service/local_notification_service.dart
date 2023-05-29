import 'dart:developer';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const String channelId = "WLOWeatherApp";
const String appName = "Weather";

class LocalNotificationService {
  static final LocalNotificationService _localNotificationService =
      LocalNotificationService._internal();

  factory LocalNotificationService() {
    return _localNotificationService;
  }

  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await initializeLocalNotificationsPlugin(initializationSettings);
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      log("isNotificationPermissionGrand => $granted");
    }
  }

  Future<void> initializeLocalNotificationsPlugin(
      InitializationSettings initializationSettings) async {
    await _requestPermissions();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotification;
            break;
          case NotificationResponseType.selectedNotificationAction:
            // TO DO, when have notificaiton action
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static void notificationTapBackground(
      NotificationResponse notificationResponse) {
    log('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      log('notification action tapped with input: ${notificationResponse.input}');
    }
  }

  void showNotification({required String title, required String body}) async {
    await flutterLocalNotificationsPlugin.show(
        title.hashCode,
        title,
        body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            appName,
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ));
  }

  Future<void> cancleNotification(String notificationCode) async {
    await flutterLocalNotificationsPlugin.cancel(notificationCode.hashCode);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> selectNotification(String? payload) async {
    log('selectNotification');
  }
}
