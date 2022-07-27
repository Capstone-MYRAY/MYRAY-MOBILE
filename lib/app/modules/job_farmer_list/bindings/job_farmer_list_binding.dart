import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/controllers/job_farmer_list_controller.dart';

class JobFarmerListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobFarmerListController());
  }
}
