import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/change_password/change_password.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/field_validation.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class ChangePasswordController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  late GlobalKey<FormState> formKey;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  RxBool isOldPassword = true.obs;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.onInit();
  }

  String? checkNewPassword(String? value) {
    if (FieldValidation.instance.validatePassword(value) != null) {
      return 'Vui lòng nhập mật mới';
    }
    if(!Utils.limitPassword.hasMatch(value!)){
      return 'Mật khẩu không hợp lệ, cần ít nhất 6 ký tự';
    }
    return null;
  }

  String? checkOldPassword(String? value) {
    if (FieldValidation.instance.validatePassword(value) != null) {
      if(!isOldPassword.value){
        return null;
      }
      return 'Vui lòng nhập mật cũ';
    }
    _checkIfOldPassword(value!);
    return null;
  }

  _checkIfOldPassword(String password) async {
    bool? result = await _authRepository.checkOldPassword(password);
    if (result != null) {
      isOldPassword.value = result;
    }
  }

  String? validateConfirmPassword(value) {
    String password = newPasswordController.text;
    if (!Utils.equalsIgnoreCase(value, password)) {
      return AppMsg.MSG6006;
    }
    return null;
  }

  onChangePassword() async {
    bool? isValid = formKey.currentState!.validate();
    final Account? account;

    try {
      if (isValid && isOldPassword.value) {
        ChangePassword data =
            ChangePassword(password: newPasswordController.text);
        account = await _authRepository.changePassword(data);

        EasyLoading.show();
        Future.delayed(const Duration(milliseconds: 500), () {
          EasyLoading.dismiss();
          if (account != null) {
            EasyLoading.showSuccess('Thành công');
            Get.back();
            return;
          }
          EasyLoading.showError('Không thành công');
        });
      }
    } on CustomException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Đã có lỗi xảy ra!');
      print('change password: ${e.message}');
    }
  }

  @override
  void dispose() {
    super.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }
}
