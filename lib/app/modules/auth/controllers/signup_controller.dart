import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/request/signup_request.dart';
import 'package:myray_mobile/app/modules/auth/auth_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class SignupController extends GetxController {
  final AuthRepository authRepository;
  SignupController({required this.authRepository});

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

  onSubmitForm() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    String phone = phoneController.text;
    if (phone.startsWith('0')) {
      _formatPhone = '+84${phone.substring(1)}';
    } else if (phone.startsWith('84')) {
      _formatPhone = '+$phone';
    } else {
      _formatPhone = phone;
    }

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

    SignupRequest data = SignupRequest(
      fullName: fullName,
      phoneNumber: _formatPhone,
      dob: dob,
      password: password,
      roleId: roleId,
    );

    await authRepository.signup(data);
    await _auth.signOut();

    Get.offAllNamed(Routes.login);
  }
}
