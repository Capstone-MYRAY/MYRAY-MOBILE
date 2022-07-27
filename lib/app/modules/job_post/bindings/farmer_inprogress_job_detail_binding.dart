import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_detail.controller.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class FarmerInprogressJobDetailBinding extends Bindings {
  @override
  void dependencies() {
    JobPost jobPost = Get.arguments[Arguments.item];
    Get.lazyPut(() => InprogressJobDetailController(jobpost: jobPost));
  }
}
