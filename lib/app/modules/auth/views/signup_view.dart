import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/signup_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/input_field.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: SizedBox(
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
                  AppStrings.titleSignup,
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
                          controller: controller.fullNameController,
                          icon: const Icon(CustomIcons.account_outline),
                          labelText: '${AppStrings.labelFullName}*',
                          placeholder: AppStrings.placeholderFullName,
                          inputAction: TextInputAction.next,
                          validator: controller.validateFullName,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.phoneController,
                          icon: const Icon(CustomIcons.phone_outline),
                          labelText: '${AppStrings.labelPhone}*',
                          placeholder: AppStrings.placeholderPhone,
                          inputAction: TextInputAction.next,
                          keyBoardType: TextInputType.phone,
                          validator: controller.validatePhone,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.dobController,
                          icon: const Icon(CustomIcons.cake_variant_outline),
                          labelText: '${AppStrings.labelDob}*',
                          placeholder: AppStrings.placeholderDate,
                          validator: controller.validateDob,
                          onTap: controller.chooseDate,
                          readOnly: true,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.passwordController,
                          isPassword: true,
                          icon: const Icon(CustomIcons.lock_outline),
                          labelText: '${AppStrings.labelPassword}*',
                          placeholder: AppStrings.placeholderPassword,
                          inputAction: TextInputAction.next,
                          validator: controller.validatePassword,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.confirmPasswordController,
                          isPassword: true,
                          icon: const Icon(CustomIcons.lock_check_outline),
                          labelText: AppStrings.labelConfirmPassword,
                          placeholder: AppStrings.placeholderConfirmPassword,
                          validator: controller.validateConfirmPassword,
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                          onPressed: controller.onSubmitForm,
                          child: const Text(AppStrings.titleSignup),
                        ),
                        const SizedBox(height: 16.0),
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
