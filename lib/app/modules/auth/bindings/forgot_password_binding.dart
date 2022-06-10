import 'package:get/instance_manager.dart';
import 'package:myray_mobile/app/modules/auth/controllers/forgot_password_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ForgotPasswordController(),
    );
  }
}
