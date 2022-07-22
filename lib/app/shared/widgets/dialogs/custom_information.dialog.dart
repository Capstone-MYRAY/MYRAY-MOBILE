import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class CustomInformationDialog {
  CustomInformationDialog._();

  static show({
    required String title,
    TextStyle? titleStyle,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? contentPadding,
    Widget? content,
    Widget? confirm,
    String? confirmTitle,
    String? message,
    Icon? icon,
  }) {
    return Get.defaultDialog(
      title: title,
      titleStyle: titleStyle ??
          Get.textTheme.headline4!.copyWith(
            color: AppColors.primaryColor,
          ),
      titlePadding: titlePadding ?? const EdgeInsets.only(top: 20),
      contentPadding:
          contentPadding ?? const EdgeInsets.only(left: 20, right: 20, top: 15),
      content: content ??
          Column(
            children: [
              icon ?? const SizedBox(),
              icon != null ? const SizedBox(height: 10,): const SizedBox(),          
              Text(
                message ?? 'Thao tác được xử lý thành công !',
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: Get.textScaleFactor * 16,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
      confirm: confirm ??
          TextButton(
            child: Text(
              confirmTitle ?? 'Đóng',
            ),
            onPressed: () => Get.back(),
          ),
      barrierDismissible: false,
    );
  }
}
