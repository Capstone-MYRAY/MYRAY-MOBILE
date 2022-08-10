import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/reset_password/reset_password_request.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class ResetPasswordController extends GetxController {
  final _authRepository = Get.find<AuthRepository>();
  late GlobalKey<FormState> formKey;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  String? validateConfirmPassword(value) {
    String password = passwordController.text;
    if (!Utils.equalsIgnoreCase(value, password)) {
      return AppMsg.MSG6006;
    }
    return null;
  }

  void resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final data = ResetPasswordRequest(
          phoneNumber: Utils.formatVietnamesePhone(phoneController.text));

      EasyLoading.show();
      final success = await _authRepository.resetPassword(data);
      EasyLoading.dismiss();
      if (!success) throw CustomException('Có lỗi xảy ra');

      Get.back(); //back to login screen

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message:
            'Mật khẩu mới đã được gửi đến số điện thoại ${phoneController.text}',
      );
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  void navigateToOtpScreen() {
    Get.toNamed(Routes.enterOtp, arguments: {
      Arguments.action: Activities.reset,
      Arguments.phone: phoneController.text,
    });
  }
}
