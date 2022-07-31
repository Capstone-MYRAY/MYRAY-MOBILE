import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/bookmark/controllers/farmer_bookmark_controller.dart';

class FarmerBookmarkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FarmerBookmarkController());
  }
}
