import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/change_password/change_password.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/field_validation.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/utils/debouncer.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class ChangePasswordController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  late GlobalKey<FormState> formKey;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  RxBool isOldPassword = true.obs;
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.onInit();
  }

  String? checkNewPassword(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG7005;
    }
    if (!Utils.limitPassword.hasMatch(value!)) {
      return AppMsg.MSG6011;
    }
    return null;
  }

  String? checkOldPassword(String? value) {
    if (FieldValidation.instance.validatePassword(value) != null) {
      if (!isOldPassword.value) {
        return null;
      }
      return AppMsg.MSG7006;
    }
    _checkIfOldPassword(value!);
    return null;
  }

  _checkIfOldPassword(String password) async {
    _debouncer.run(() async {
      isOldPassword.value = await _authRepository.checkOldPassword(password);
    });
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
            CustomSnackbar.show(
                title: "Thành công", message: "Thay đổi mật khẩu thành công");
            return;
          }
          CustomSnackbar.show(
              title: "Thất bại",
              message: "Thay đổi mật khẩu không thành công",
              backgroundColor: AppColors.errorColor);
        });
      }
    } on CustomException catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Đã có lỗi xảy ra!",
          backgroundColor: AppColors.errorColor);
      print('change password: ${e.message}');
    }finally{
      Get.back();
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
