import 'package:get/instance_manager.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_home_controller.dart';

class GardenHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GardenHomeController());
  }
}
