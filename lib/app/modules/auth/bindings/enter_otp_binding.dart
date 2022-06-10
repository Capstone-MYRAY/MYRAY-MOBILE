import 'package:get/instance_manager.dart';
import 'package:myray_mobile/app/modules/auth/controllers/enter_otp_controller.dart';

class EnterOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => EnterOtpController(),
    );
  }
}
