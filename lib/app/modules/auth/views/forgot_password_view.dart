import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/input_field.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            top: 24,
          ),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppAssets.forgotPassword,
                  width: Get.width * 0.6,
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: Get.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.forgotPassword,
                        style: Get.textTheme.headline2,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.captionForgotPassword,
                        style: Get.textTheme.caption,
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: controller.phoneController,
                        icon: const Icon(CustomIcons.phone_outline),
                        labelText: AppStrings.labelPhone,
                        placeholder: AppStrings.placeholderPhone,
                        keyBoardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(AppStrings.titleSendOtp),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
