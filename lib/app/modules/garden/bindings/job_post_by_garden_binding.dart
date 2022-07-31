import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/garden/controllers/job_post_by_garden_controller.dart';

class JobPostByGardenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobPostByGardenController());
  }
}
