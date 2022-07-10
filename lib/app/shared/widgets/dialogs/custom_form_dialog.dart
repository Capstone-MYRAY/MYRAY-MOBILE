import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';

class CustomFormDialog {
  CustomFormDialog._();

  static Future<dynamic> showDialog({
    required final String title,
    required List<Widget> textFields,
    required void Function() submit,
    required void Function() cancel,
    GlobalKey<FormState>? formKey,
  }) {
    return Get.defaultDialog(
        barrierDismissible: false,
        radius: 10,
        title: title,
        titleStyle: Get.textTheme.headline3!.copyWith(),
        // titlePadding: EdgeInsets.only(bottom: 10),
        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
        titlePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

        // titlePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        content: Form(
          key: formKey,
          child: Flexible(
              child: SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: textFields,
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextButton(
                          onPressed: submit,
                          title: AppStrings.submit,
                        ),
                        SizedBox(
                          width: Get.width * 0.03,
                        ),
                        CustomTextButton(
                            onPressed: cancel,
                            title: AppStrings.cancel,
                            border: Border.all(
                              color: AppColors.primaryColor,
                            ),
                            foreground: AppColors.primaryColor,
                            background: AppColors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.08, vertical: 9))
                      ],
                    )
                  ],
                ),
              ),
            ),
          
        ));
  }
}