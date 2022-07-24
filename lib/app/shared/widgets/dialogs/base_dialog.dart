import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class BaseDialog {
  BaseDialog._();

  static Future<dynamic> show(Widget child,
      {EdgeInsetsGeometry? margin, EdgeInsetsGeometry? padding}) async {
    return Get.dialog(
      Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: padding ??
                const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 40.0,
                ),
            margin: margin ??
                EdgeInsets.symmetric(
                  horizontal: Get.width * 0.1,
                  vertical: Get.height * 0.1,
                ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            ),
            child: child,
          ),
          Positioned(
            top: Get.height * 0.1 + 16,
            right: Get.width * 0.1 + 16,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.clear),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
