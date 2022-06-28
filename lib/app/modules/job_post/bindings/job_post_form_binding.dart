import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/job_post_form_controller.dart';

class JobPostFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobPostFormController());
  }
}
