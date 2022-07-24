import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class BaseDialog {
  BaseDialog._();

  static Future<dynamic> show(
    Widget child, {
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    isFit = true,
  }) async {
    margin ??= EdgeInsets.symmetric(
      horizontal: Get.width * 0.1,
      vertical: Get.height * 0.1,
    );
    padding ??= const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 40.0,
    );

    return Get.dialog(
      Stack(
        children: [
          isFit
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: padding,
                      margin: margin,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(CommonConstants.borderRadius),
                      ),
                      child: child,
                    ),
                  ],
                )
              : Container(
                  alignment: Alignment.center,
                  padding: padding,
                  margin: margin,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        BorderRadius.circular(CommonConstants.borderRadius),
                  ),
                  child: child,
                ),
          Positioned(
            top: (margin.vertical + padding.vertical) / 2,
            right: (margin.horizontal / 2 + padding.horizontal) / 2,
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
