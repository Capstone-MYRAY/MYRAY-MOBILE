

import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_not_start_job_controller.dart';

class FarmerNotStartJobBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FarmerNotStartJobController());
  }

}