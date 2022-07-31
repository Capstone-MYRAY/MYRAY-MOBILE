import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class CustomSnackbar {
  CustomSnackbar._();

  static show({
    required String title,
    required String message,
    Color backgroundColor = AppColors.primaryColor,
    Color textColor = AppColors.white,
    Widget? icon,
    SnackPosition? snackPosition = SnackPosition.BOTTOM,
  }) {
    return Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      borderRadius: CommonConstants.borderRadius,
      colorText: textColor,
      duration: const Duration(seconds: 2),
      icon: icon,
      snackPosition: snackPosition,
    );
  }
}
