import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/profile/controllers/update_profile_controller.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController());
  }
}
