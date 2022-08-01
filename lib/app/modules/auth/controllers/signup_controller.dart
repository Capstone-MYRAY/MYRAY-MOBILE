import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/auth/signup_request.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository = Get.find();

  var selectedRole = Roles.none.obs;
  DateTime? selectedDate;
  late GlobalKey<FormState> formKey;
  late GlobalKey<FormState> passwordFormKey;
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _formatPhone = '';

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey();
    passwordFormKey = GlobalKey();
    fullNameController = TextEditingController();
    phoneController = TextEditingController();
    dobController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void onSelectFarmer() {
    selectedRole.value = Roles.farmer;
  }

  void onSelectLandowner() {
    selectedRole.value = Roles.landowner;
  }

  void navigateToSignupScreen() {
    Get.toNamed(Routes.signup);
  }

  chooseDate() async {
    selectedDate = await MyDatePicker.show(initDate: selectedDate);

    if (selectedDate != null) {
      dobController.text = Utils.formatddMMyyyy(selectedDate!);
    }
  }

  String? validatePassword(value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (!Utils.limitPassword.hasMatch(value)) {
      return 'Mật khẩu tối thiểu 8 ký tự và tối đa 30 ký tự';
    }

    return null;
  }

  String? validateConfirmPassword(value) {
    String password = passwordController.text;
    if (!Utils.equalsIgnoreCase(value, password)) {
      return AppMsg.MSG6006;
    }
    return null;
  }

  onSubmitForm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String phone = phoneController.text;

    EasyLoading.show(status: AppStrings.loading);
    bool isDuplicated = await _authRepository.checkDuplicatedPhone(phone);
    if (isDuplicated) {
      EasyLoading.dismiss();
      InformationDialog.showDialog(
          msg: AppMsg.MSG6001, confirmTitle: AppStrings.titleClose);
      return;
    }

    EasyLoading.dismiss();
    _formatPhone = Utils.formatVietnamesePhone(phone);

    Get.toNamed(Routes.enterOtp, arguments: {
      Arguments.action: Activities.signup,
      Arguments.phone: _formatPhone,
    });
  }

  onSignupAccount() async {
    if (!formKey.currentState!.validate() ||
        !passwordFormKey.currentState!.validate()) {
      return;
    }

    String fullName = fullNameController.text;
    DateTime dob = selectedDate!;
    String password = passwordController.text;
    int roleId = selectedRole.value == Roles.landowner
        ? CommonConstants.landownerRoleId
        : CommonConstants.farmerRoleId;

    SignupRequest data = SignupRequest(
      fullName: fullName,
      phoneNumber: _formatPhone,
      dob: dob,
      password: password,
      roleId: roleId,
    );

    try {
      EasyLoading.show(status: AppStrings.loading);
      await _authRepository.signup(data);
      await _auth.signOut();
      EasyLoading.dismiss();

      Get.offAllNamed(Routes.init);
      CustomSnackbar.show(title: 'Thông báo', message: AppMsg.MSG6009);
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }
}
