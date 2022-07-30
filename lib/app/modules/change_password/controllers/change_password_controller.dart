import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/change_password/change_password.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class ChangePasswordController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  late GlobalKey<FormState> formKey;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.onInit();
  }

  onChangePassword() async {
    bool? isValid = formKey.currentState!.validate();
    final Account? account;
    try {
      if (isValid) {
        ChangePassword data =
            ChangePassword(password: newPasswordController.text.trim());
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
