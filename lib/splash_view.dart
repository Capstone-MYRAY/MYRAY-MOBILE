import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppAssets.logo,
                width: Get.width * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
