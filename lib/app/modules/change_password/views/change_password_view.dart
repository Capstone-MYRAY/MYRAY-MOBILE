import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/change_password/controllers/change_password_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleChangePassword),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InputField(
                      icon: const Icon(CustomIcons.lock_password_line),
                      labelText: AppStrings.labelOldPassword,
                      controller: controller.oldPasswordController,
                      isPassword: true,
                      placeholder: AppStrings.placeholderOldPassword,
                      validator: controller.checkOldPassword,
                    ),
                    Obx(
                      () => !controller.isOldPassword.value
                          ? Container(
                              margin: const EdgeInsets.only(top: 9, left: 40),
                              child: Row(
                                children: [
                                  Text(AppMsg.MSG7004,
                                      style: Get.textTheme.bodySmall!.copyWith(
                                          color: AppColors.errorColor,
                                          fontSize: Get.textScaleFactor * 13)),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InputField(
                        icon: const Icon(CustomIcons.lock_outline),
                        labelText: AppStrings.labelNewPawword,
                        controller: controller.newPasswordController,
                        isPassword: true,
                        placeholder: AppStrings.placeholderNewPassword,
                        validator: controller.checkNewPassword),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    InputField(
                      icon: const Icon(CustomIcons.lock_check_outline),
                      labelText: ' ${AppStrings.labelConfirmPassword}*',
                      controller: controller.confirmNewPasswordController,
                      isPassword: true,
                      placeholder: AppStrings.labelConfirmPassword,
                      validator: controller.validateConfirmPassword,
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextButton(
                      onPressed: controller.onChangePassword,
                      title: 'Thay đổi ',
                      background: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.2, vertical: 10),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
