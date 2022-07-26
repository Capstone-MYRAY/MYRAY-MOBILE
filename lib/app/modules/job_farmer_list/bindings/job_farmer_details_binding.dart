import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/controllers/job_farmer_details_controller.dart';

class JobFarmerDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobFarmerDetailsController());
  }
}
