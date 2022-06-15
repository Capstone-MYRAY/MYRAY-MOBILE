import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/onboard.dart';
import 'package:myray_mobile/splash_view.dart';

class InitView extends GetView<AuthController> {
  const InitView({Key? key}) : super(key: key);

  Future<void> autoLogin() async {
    controller.checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashView();
          } else {
            return const OnBoard();
          }
        });
  }
}
