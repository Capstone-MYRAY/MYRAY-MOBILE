import 'package:get/instance_manager.dart';
import 'package:myray_mobile/app/modules/auth/controllers/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ResetPasswordController(),
    );
  }
}
