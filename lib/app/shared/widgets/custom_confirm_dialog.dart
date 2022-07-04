import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class CustomDialog {
  CustomDialog._();

  static show({
    required void Function() confirm,
    required String message,
    String? confirmTitle = AppStrings.titleConfirm,
    String? cancelTileButton = AppStrings.cancel,
  }) {
    return Get.defaultDialog(
      title: confirmTitle!,
      backgroundColor: AppColors.white,
      titleStyle:
          Get.textTheme.displayMedium!.copyWith(color: AppColors.primaryColor),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      titlePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      textConfirm: "Ứng tuyển",
      textCancel: cancelTileButton,
      cancelTextColor: AppColors.cancelColor,
      confirmTextColor: AppColors.white,
      buttonColor: AppColors.primaryColor,
      barrierDismissible: false,
      radius: 10,
      confirm: CustomTextButton(
        onPressed: confirm,
        title: confirmTitle,
        background: AppColors.white,
        foreground: AppColors.primaryColor,
      ),
      cancel: CustomTextButton(
        onPressed: () => Get.back(),
        title: cancelTileButton!,
        background: AppColors.white,
        foreground: AppColors.cancelColor,
      ),
      content: Column(
        children: [
          Text(
            message,
            softWrap: true,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
