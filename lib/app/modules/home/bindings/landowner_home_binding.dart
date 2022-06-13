import 'package:get/get.dart';

import '../controllers/landowner_home_controller.dart';

class LandownerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandownerHomeController>(
      () => LandownerHomeController(),
    );
  }
}
