import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';

class LandownerJobPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandownerJobPostController());
  }
}
