import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/login_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/input_field.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  AppAssets.logo,
                  width: Get.width * 0.3,
                ),
                const SizedBox(height: 16.0),
                Text(
                  AppStrings.titleLogin,
                  style: Get.textTheme.headline1,
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: Get.width * 0.8,
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        InputField(
                          controller: controller.phoneController,
                          icon: const Icon(CustomIcons.phone_outline),
                          labelText: AppStrings.labelPhone,
                          placeholder: AppStrings.placeholderPhone,
                          inputAction: TextInputAction.next,
                          keyBoardType: TextInputType.phone,
                          validator: controller.validatePhone,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.passwordController,
                          isPassword: true,
                          icon: const Icon(CustomIcons.lock_outline),
                          labelText: AppStrings.labelPassword,
                          placeholder: AppStrings.placeholderPassword,
                          validator: controller.validatePassword,
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: controller.onSubmitForm,
                          child: const Text(AppStrings.titleLogin),
                        ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: controller.navigateToForgotPasswordScreen,
                          child: Text(
                            AppStrings.forgotPassword,
                            style: Get.textTheme.caption,
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        RichText(
                          text: TextSpan(
                            style: Get.textTheme.bodyText1,
                            text: '${AppStrings.doNotHaveAccount} ',
                            children: <TextSpan>[
                              TextSpan(
                                  text: AppStrings.titleSignup,
                                  style: Get.textTheme.bodyText1!.copyWith(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        controller.navigateToChooseRoleScreen),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
