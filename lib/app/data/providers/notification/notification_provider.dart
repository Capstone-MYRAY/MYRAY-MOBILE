import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    developer.log('Subscribe topic: $topic');
    await _messaging.subscribeToTopic(topic);
    await _initialize();
  }

  Future<void> unsubscribeTopic(String topic) async {
    developer.log('Unsubscribe topic: $topic');
    await _messaging.unsubscribeFromTopic(topic);
  }

  Future<void> _initialize() async {
    final initSetting = await _messaging.getNotificationSettings();

    if (initSetting.authorizationStatus == AuthorizationStatus.denied) {
      return Future.error('Notification service was denied');
    }

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

    _handleTerminateMessage();
    _handleForegroundMessage();
    _handleOnTapMessage();
  }

  _handleTerminateMessage() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null && message.data.isNotEmpty) {
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
      if (message.data.isNotEmpty) {
        _serviceDelegate =
            _service.serviceDelegate(message.data['type'] ?? '', message.data);
        if (_serviceDelegate != null) {
          _serviceDelegate!();
        }
      }
    });
  }

  _handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _serviceDelegate =
            _service.serviceDelegate(message.data['type'] ?? '', message.data);

        Get.snackbar(
          message.notification!.title ?? '',
          message.notification!.body ?? '',
          icon: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 12.0,
              ),
              child: Image.asset(AppAssets.logo, width: 24.0)),
          backgroundColor: AppColors.white,
          colorText: AppColors.black,
          borderRadius: 0.0,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5),
          dismissDirection: DismissDirection.up,
          maxWidth: double.infinity,
          margin: EdgeInsets.zero,
          mainButton: _serviceDelegate == null
              ? null
              : TextButton(
                  onPressed: () {
                    _serviceDelegate!();
                    Get.closeCurrentSnackbar();
                  },
                  child: const Text('Chi tiết'),
                ),
        );

        _service.updateData(message.data['type'] ?? '', message.data);
      }
    });
  }
}