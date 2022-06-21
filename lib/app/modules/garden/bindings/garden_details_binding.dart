import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_details_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class GardenDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final String tag = Get.arguments[CommonConstants.tag];
    Rx<Garden> garden = Rx(Get.arguments[CommonConstants.item]);
    Get.lazyPut(
      () => GardenDetailsController(garden: garden),
      tag: tag,
      fenix: true,
    );
  }
}
