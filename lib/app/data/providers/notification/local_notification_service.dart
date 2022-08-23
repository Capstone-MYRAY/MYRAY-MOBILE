import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:myray_mobile/app/data/providers/notification/notification_service.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_logo'),
    );

    const channel = AndroidNotificationChannel(
      'myray', // id
      'Notification', // title// description
      importance: Importance.max,
      enableVibration: true,
    );

    await _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void _onSelectNotification(String? payload) {
    print('onTap');
    if (payload != null) {
      Map<String, dynamic> data = jsonDecode(payload);
      if (data.isNotEmpty) {
        final service = NotificationService.instance;
        final serviceDelegate =
            service.serviceDelegate(data['type'] ?? '', data);
        if (serviceDelegate != null) {
          serviceDelegate();
        }

        service.updateData(data['type'] ?? '', data);
      }
    }
  }

  static void display(RemoteMessage message) async {
    try {
      print('display');
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      String payload = jsonEncode(message.data);

      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'myray',
          'Notification',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_logo',
          autoCancel: true,
          channelShowBadge: true,
        ),
        iOS: IOSNotificationDetails(),
      );

      _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: payload,
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
