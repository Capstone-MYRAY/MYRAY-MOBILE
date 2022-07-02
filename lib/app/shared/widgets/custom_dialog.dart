import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:myray_mobile/app/shared/constants/app_colors.dart';

class CustomDialog {
  CustomDialog._();

  static show({
    required void Function()? onConfirm,
    required void Function()? onCancel,
    required String title,
    required String message,
  }) {
    return Get.defaultDialog(
        title: title,
        onConfirm: onConfirm,
        onCancel: onCancel,
        middleText: "Hello world!",
        backgroundColor: AppColors.white,
        titleStyle: Get.textTheme.displayMedium!
            .copyWith(color: AppColors.primaryColor),
        middleTextStyle: TextStyle(color: AppColors.black),
        textConfirm: "Ứng tuyển",
        textCancel: "Hủy",
        cancelTextColor: AppColors.cancelColor,
        confirmTextColor: AppColors.white,
        buttonColor: AppColors.primaryColor,
        barrierDismissible: true,
        radius: 10,
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                  child: Text(
                    message,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
          
          ),
        ));
  }
}
