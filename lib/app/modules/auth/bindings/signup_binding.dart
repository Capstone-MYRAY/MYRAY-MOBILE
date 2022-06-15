import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/signup_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SignupController(),
    );
  }
}
