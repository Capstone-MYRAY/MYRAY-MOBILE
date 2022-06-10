import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  late TextEditingController phoneController;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
  }
}
