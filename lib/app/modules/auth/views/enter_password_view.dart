import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/signup_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';

class EnterPasswordView extends GetView<SignupController> {
  const EnterPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    AppAssets.enterPassword,
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
                          AppStrings.titleEnterPassword,
                          style: Get.textTheme.headline2,
                        ),
                        const SizedBox(height: 16),
                        Form(
                          key: controller.passwordFormKey,
                          child: Column(
                            children: [
                              InputField(
                                isPassword: true,
                                controller: controller.passwordController,
                                icon: const Icon(CustomIcons.lock_outline),
                                labelText: AppStrings.labelPassword,
                                placeholder: AppStrings.placeholderPassword,
                                keyBoardType: TextInputType.text,
                                inputAction: TextInputAction.next,
                                validator: controller.validatePassword,
                              ),
                              const SizedBox(height: 16),
                              InputField(
                                isPassword: true,
                                controller:
                                    controller.confirmPasswordController,
                                icon:
                                    const Icon(CustomIcons.lock_check_outline),
                                labelText: AppStrings.labelConfirmPassword,
                                placeholder:
                                    AppStrings.placeholderConfirmPassword,
                                keyBoardType: TextInputType.text,
                                validator: controller.validateConfirmPassword,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            controller.onSignupAccount();
                          },
                          child: const Text(AppStrings.titleSignup),
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
