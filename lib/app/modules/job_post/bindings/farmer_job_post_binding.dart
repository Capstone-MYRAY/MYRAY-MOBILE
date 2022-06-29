
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_job_post_controller.dart';

class FarmerJobPostBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FarmerJobPostController());
  }

}