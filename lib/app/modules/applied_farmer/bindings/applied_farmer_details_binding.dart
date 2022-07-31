import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_details_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class AppliedFarmerDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final String tag = Get.arguments[Arguments.tag];
    final Rx<AppliedFarmer> appliedFarmer = Rx(Get.arguments[Arguments.item]);
    Get.lazyPut(
      () => AppliedFarmerDetailsController(appliedFarmer: appliedFarmer),
      tag: tag,
    );
  }
}
