import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/auth/auth_request.dart';
import 'package:myray_mobile/app/data/models/auth/auth_response.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/information_dialog.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;
  final AuthController _authController = Get.find<AuthController>();

  LoginController({required this.authRepository});

  late GlobalKey<FormState> formKey;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  String? validatePhone(value) {
    if (Utils.isEmpty(value)) {
      return '';
    }

    if (!Utils.vietnamesePhone.hasMatch(value)) {
      return AppMsg.MSG0003;
    }

    return null;
  }

  String? validatePassword(value) {
    if (Utils.isEmpty(value)) {
      return '';
    }
    return null;
  }

  onSubmitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final String phone = Utils.formatVietnamesePhone(phoneController.text);
    final String password = passwordController.text;

    final data = AuthRequest(phoneNumber: phone, password: password);
    EasyLoading.show(status: AppStrings.loading);
    try {
      AuthResponse? tokens = await authRepository.login(data);
      if (tokens != null) {
        await _authController.login(tokens.token!, tokens.refreshToken!);
        Get.delete<LoginController>();
      }
      EasyLoading.dismiss();
    } on CustomException catch (e) {
      String errorMsg = '';
      if (e.message.contains('Invalid Login Information')) {
        errorMsg = AppMsg.MSG6002;
      } else if (e.message.contains('Invalid Password')) {
        errorMsg = AppMsg.MSG6003;
      }
      EasyLoading.dismiss();
      InformationDialog.showDialog(
        msg: errorMsg,
        confirmTitle: 'Đóng',
      );
    }
  }

  void navigateToForgotPasswordScreen() {
    Get.toNamed(Routes.forgotPassword);
  }

  void navigateToChooseRoleScreen() {
    Get.toNamed(Routes.chooseRole);
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }
}
