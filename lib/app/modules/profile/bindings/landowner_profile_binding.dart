import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';

class LandownerProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandownerProfileController());
  }
}
