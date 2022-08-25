import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseDialog {
  BaseDialog._();

  static Future<dynamic> show({
    required Widget child,
    EdgeInsets? insetPadding,
  }) async {
    return Get.dialog(
      AlertDialog(
        insetPadding: insetPadding ??
            EdgeInsets.symmetric(
              horizontal: Get.width * 0.08,
            ),
        content: Stack(
          children: [
            child,
            Positioned(
              right: 0,
              top: 4.0,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.clear),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
