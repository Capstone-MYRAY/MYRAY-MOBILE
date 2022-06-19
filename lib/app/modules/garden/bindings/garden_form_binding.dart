import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_form_controller.dart';

class GardenFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GardenFormController());
  }
}
