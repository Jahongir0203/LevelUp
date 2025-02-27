import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setUpFlutterNotification();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// request permission
    await _requestPermission();

    ///set up message andler
    await _setUpMessageHandlers();

    final token = await _messaging.getToken();
    print('FCM Token:${token}');
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      sound: true,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
    );
    print('PermissionStatus;${_messaging.isAutoInitEnabled}');
  }

  Future<void> setUpFlutterNotification() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    ///Android set up

    const channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      description: 'This is android channel',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    ///Ios set up
    final initializationSettingsDarwin = DarwinInitializationSettings(
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestAlertPermission: true,
    );

    final initializationSettings = InitializationSettings(
      iOS: initializationSettingsDarwin,
      android: initializationSettingsAndroid,
    );

    /// flutter notification set up
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;

    if (notification != null && androidNotification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            channelDescription: 'This is description',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  ///foreground message
  Future<void> _setUpMessageHandlers() async {
    FirebaseMessaging.onMessage.listen((event) {
      showNotification(event);
    });

    ///background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    ///opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {}
  }
}
