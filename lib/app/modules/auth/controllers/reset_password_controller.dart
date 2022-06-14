import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

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

  String? validateConfirmPassword(value) {
    String password = passwordController.text;
    if (!Utils.equalsIgnoreCase(value, password)) {
      return AppMsg.MSG6006;
    }
    return null;
  }

  void navigateToOtpScreen() {
    Get.toNamed(Routes.enterOtp, arguments: {
      'action': Activities.reset,
      'phone': phoneController.text,
    });
  }
}
