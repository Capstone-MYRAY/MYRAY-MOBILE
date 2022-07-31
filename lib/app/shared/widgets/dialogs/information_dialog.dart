import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformationDialog {
  InformationDialog._();

  static Future<dynamic> showDialog(
      {String title = 'Thông báo',
      required String msg,
      required String confirmTitle}) {
    return Get.defaultDialog(
      title: title,
      titleStyle: Get.textTheme.headline3!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 20 * Get.textScaleFactor,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      titlePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      content: Text(
        msg,
        style: Get.textTheme.bodyText2!.copyWith(
          fontSize: 15 * Get.textScaleFactor,
        ),
      ),
      confirm: TextButton(
        child: Text(
          confirmTitle,
          // style: Get.textTheme.bodyText1!.copyWith(
          //   color: AppColors.primaryColor,
          //   fontWeight: FontWeight.w500,
          //   fontSize: 14 * Get.textScaleFactor,
          // ),
        ),
        onPressed: () => Get.back(),
      ),
      barrierDismissible: false,
    );
  }
}
