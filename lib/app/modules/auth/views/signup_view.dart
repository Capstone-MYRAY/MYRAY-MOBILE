import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/signup_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/field_validation.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
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
                          validator: FieldValidation.instance.validateFullName,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.phoneController,
                          icon: const Icon(CustomIcons.phone_outline),
                          labelText: '${AppStrings.labelPhone}*',
                          placeholder: AppStrings.placeholderPhone,
                          inputAction: TextInputAction.next,
                          keyBoardType: TextInputType.phone,
                          validator: FieldValidation.instance.validatePhone,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.dobController,
                          icon: const Icon(CustomIcons.cake_variant_outline),
                          labelText: '${AppStrings.labelDob}*',
                          placeholder: AppStrings.placeholderDate,
                          validator: FieldValidation.instance.validateDob,
                          onTap: controller.chooseDate,
                          readOnly: true,
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
