import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/controllers/job_farmer_details_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class JobFarmerDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final String tag = Get.arguments[Arguments.tag];
    final Rx<AppliedFarmer> appliedFarmer = Rx(Get.arguments[Arguments.item]);
    Get.lazyPut(
      () => JobFarmerDetailsController(appliedFarmer: appliedFarmer),
      tag: tag,
    );
  }
}
