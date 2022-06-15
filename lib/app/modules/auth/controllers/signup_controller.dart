import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/request/signup_request.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/information_dialog.dart';

class SignupController extends GetxController {
  final AuthRepository _authRepository = Get.find();

  var selectedRole = Roles.none.obs;
  DateTime? selectedDate;
  late GlobalKey<FormState> formKey;
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
    selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('vi'),
    );

    if (selectedDate != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
    }
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
      'action': Activities.signup,
      'phone': _formatPhone,
    });
  }

  onSignupAccount() async {
    String fullName = fullNameController.text;
    DateTime dob = selectedDate!;
    String password = passwordController.text;
    int roleId = selectedRole.value == Roles.landowner
        ? CommonConstants.landownerRoleId
        : CommonConstants.farmerRoleId;

    if (!formKey.currentState!.validate()) {
      return;
    }

    SignupRequest data = SignupRequest(
      fullName: fullName,
      phoneNumber: _formatPhone,
      dob: dob,
      password: password,
      roleId: roleId,
    );

    EasyLoading.show(status: AppStrings.loading);
    await _authRepository.signup(data);
    await _auth.signOut();
    EasyLoading.dismiss();

    Get.offAllNamed(Routes.login);
  }
}
