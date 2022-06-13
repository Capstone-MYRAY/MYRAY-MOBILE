import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void navigateToOtpScreen() {
    Get.toNamed(Routes.enterOtp, arguments: {
      'action': Activities.reset,
      'phone': phoneController.text,
    });
  }
}
