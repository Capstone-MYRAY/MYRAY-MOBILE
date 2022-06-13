import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class SignupController extends GetxController {
  var selectedRole = Roles.none.obs;
  DateTime? selectedDate;
  late GlobalKey<FormState> formKey;
  late TextEditingController fullNameController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

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

  String? validateFullName(value) {
    if (Utils.isEmpty(value)) {
      return AppErrors.MSG0002;
    }
    return null;
  }

  String? validatePhone(value) {
    if (Utils.isEmpty(value)) {
      return AppErrors.MSG0002;
    }

    if (!Utils.vietnamesePhone.hasMatch(value)) {
      return AppErrors.MSG0003;
    }
    return null;
  }

  String? validateDob(value) {
    if (Utils.isEmpty(value)) {
      return AppErrors.MSG0002;
    }

    if (!Utils.isWorkingAge(value, 'dd/MM/yyyy')) {
      return 'Phải đủ tối thiểu 15 tuổi';
    }

    return null;
  }

  String? validatePassword(value) {
    if (Utils.isEmpty(value)) {
      return AppErrors.MSG0002;
    }
    return null;
  }

  String? validateConfirmPassword(value) {
    String password = passwordController.text;
    if (!Utils.equalsIgnoreCase(value, password)) {
      return 'Mật khẩu xác nhận không trùng khớp';
    }
    return null;
  }

  onSubmitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    Get.toNamed(Routes.enterOtp, arguments: {
      'action': Activities.signup,
      'phone': phoneController.text,
    });
  }

  onSignupAccount() {
    Get.offAllNamed(Routes.login);
  }
}
