import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_details_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class LandownerJobPostDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final String tag = Get.arguments[Arguments.tag];
    final Rx<JobPost> jobPost = Rx(Get.arguments[Arguments.item]);
    Get.lazyPut(
      () => LandownerJobPostDetailsController(jobPost: jobPost),
      tag: tag,
    );
  }
}
