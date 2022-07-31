import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_main_feature/job_post_by_type/job_post_by_type_controller.dart';

class JobPostByTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobPostByTypeController());
  }
}
