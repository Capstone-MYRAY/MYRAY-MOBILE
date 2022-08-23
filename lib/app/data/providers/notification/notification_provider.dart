import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/providers/notification/local_notification_service.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'notification_service.dart';
import 'dart:developer' as developer;

class NotificationProvider {
  NotificationProvider._();
  static final NotificationProvider _instance = NotificationProvider._();
  static NotificationProvider get instance => _instance;

  final _messaging = FirebaseMessaging.instance;
  final _service = NotificationService.instance;
  void Function()? _serviceDelegate;

  Future<void> subscribeTopic(String topic) async {
    await _messaging.subscribeToTopic(topic);
    developer.log('Subscribe topic: $topic');
  }

  Future<void> unsubscribeTopic(String topic) async {
    await _messaging.unsubscribeFromTopic(topic);
    developer.log('Unsubscribe topic: $topic');
  }

  Future<void> initialize() async {
    final initSetting = await _messaging.getNotificationSettings();

    if (initSetting.authorizationStatus == AuthorizationStatus.denied) {
      return Future.error('Notification service was denied');
    }

    print('initSetting: ${initSetting.authorizationStatus}');

    //request permission
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      return Future.error('Notification service was denied');
    }

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _handleTerminateMessage();
    _handleForegroundMessage();
    _handleOnTapMessage();
  }

  _handleTerminateMessage() {
    _messaging.getInitialMessage().then((message) {
      print('getInitialMessage');
      if (message != null && message.data.isNotEmpty) {
        LocalNotificationService.display(message);
        _serviceDelegate =
            _service.serviceDelegate(message.data['type'] ?? '', message.data);
        if (_serviceDelegate != null) {
          _serviceDelegate!();
        }
      }
    });
  }

  _handleOnTapMessage() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp');
      if (message.data.isNotEmpty) {
        _serviceDelegate =
            _service.serviceDelegate(message.data['type'] ?? '', message.data);
        if (_serviceDelegate != null) {
          _serviceDelegate!();
        }

        _service.updateData(message.data['type'] ?? '', message.data);
      }
    });
  }

  _handleForegroundMessage() {
    developer.log('Run: _handleForegroundMessage');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('onMessage');
      if (message.notification != null) {
        _serviceDelegate =
            _service.serviceDelegate(message.data['type'] ?? '', message.data);

        LocalNotificationService.display(message);

        // Get.snackbar(
        //   message.notification!.title ?? '',
        //   message.notification!.body ?? '',
        //   icon: Container(
        //       margin: const EdgeInsets.symmetric(
        //         vertical: 8.0,
        //         horizontal: 12.0,
        //       ),
        //       child: Image.asset(AppAssets.logo, width: 24.0)),
        //   backgroundColor: AppColors.white,
        //   colorText: AppColors.black,
        //   borderRadius: 0.0,
        //   snackPosition: SnackPosition.TOP,
        //   duration: const Duration(seconds: 5),
        //   dismissDirection: DismissDirection.up,
        //   maxWidth: double.infinity,
        //   margin: EdgeInsets.zero,
        //   mainButton: _serviceDelegate == null
        //       ? null
        //       : TextButton(
        //           onPressed: () {
        //             _serviceDelegate!();
        //             Get.closeCurrentSnackbar();
        //           },
        //           child: const Text('Chi tiết'),
        //         ),
        // );

        _service.updateData(message.data['type'] ?? '', message.data);
      }
    });
  }
}
