import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseDialog {
  BaseDialog._();

  static Future<dynamic> show({
    required Widget child,
    double? width,
  }) async {
    return Get.dialog(
      AlertDialog(
        content: SizedBox(
          width: width ?? Get.width * 0.9,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  child,
                ],
              ),
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
      ),
      barrierDismissible: false,
    );
  }
}
