import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class LoginController extends GetxController {
  late GlobalKey<FormState> formKey;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  String? validatePhone(value) {
    if (Utils.isEmpty(value)) {
      return '';
    }
    return null;
  }

  String? validatePassword(value) {
    if (Utils.isEmpty(value)) {
      return '';
    }
    return null;
  }

  onSubmitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }
  }

  void navigateToForgotPasswordScreen() {
    Get.toNamed(Routes.forgotPassword);
  }

  void navigateToChooseRoleScreen() {
    Get.toNamed(Routes.chooseRole);
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
}
