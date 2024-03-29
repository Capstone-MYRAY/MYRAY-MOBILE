import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:myray_mobile/app/data/providers/momo/deep_link_handler.dart';
import 'package:myray_mobile/app/data/providers/notification/local_notification_service.dart';
import 'package:myray_mobile/app/data/providers/notification/notification_provider.dart';
import 'package:myray_mobile/app/data/providers/notification/notification_service.dart';
import 'package:myray_mobile/app_binding.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/theme/app_theme.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('onBackground');
  if (message.data.isNotEmpty) {
    print(message.messageId);
    // LocalNotificationService.display(message);
    // final service = NotificationService.instance;
    // service.updateData(message.data['type'] ?? '', message.data);
    // final serviceDelegate =
    //     service.serviceDelegate(message.data['type'] ?? '', message.data);
    // if (serviceDelegate != null) {
    //   serviceDelegate();
    // }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await GetStorage.init(CommonConstants.appName);

  await FlutterConfig.loadEnvVariables();
  await LocalNotificationService.initialize();
  await NotificationProvider.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.featureColor,
  ));

  // DeepLinkHandler.init();

  runApp(const MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskType = EasyLoadingMaskType.black
    ..toastPosition = EasyLoadingToastPosition.center
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..textStyle = Get.textTheme.headline5!.copyWith(
      color: AppColors.black,
      fontWeight: FontWeight.normal,
      fontSize: 16 * Get.textScaleFactor,
    )
    ..textColor = AppColors.black
    ..contentPadding = const EdgeInsets.all(16)
    ..backgroundColor = AppColors.white
    ..indicatorColor = AppColors.primaryColor
    ..progressColor = AppColors.primaryColor
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: CommonConstants.appName,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      initialBinding: AppBinding(),
      builder: EasyLoading.init(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VN'),
      ],
      locale: const Locale('vi'),
    );
  }
}
