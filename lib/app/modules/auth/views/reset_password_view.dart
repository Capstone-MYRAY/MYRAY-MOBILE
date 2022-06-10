import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/reset_password_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/input_field.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(
              top: 24,
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.resetPassword,
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
                          AppStrings.resetPassword,
                          style: Get.textTheme.headline2,
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          controller: controller.passwordController,
                          icon: const Icon(CustomIcons.lock_outline),
                          labelText: AppStrings.labelPassword,
                          placeholder: AppStrings.placeholderPassword,
                          keyBoardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        InputField(
                          controller: controller.confirmPasswordController,
                          icon: const Icon(CustomIcons.lock_check_outline),
                          labelText: AppStrings.labelConfirmPassword,
                          placeholder: AppStrings.placeholderConfirmPassword,
                          keyBoardType: TextInputType.text,
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text(AppStrings.resetPassword),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
