
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_detail.controller.dart';
import 'package:myray_mobile/app/modules/report/report_repository.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class FarmerInprogressJobDetailBinding extends Bindings{
  @override
  void dependencies() {
    JobPost jobPost = Get.arguments[Arguments.item];
    Get.lazyPut(() => InprogressJobDetailController(jobpost: jobPost));
    Get.lazyPut(() => FeedBackController());
    Get.lazyPut(() => AppliedJobRepository());
    Get.lazyPut(() => ReportRepository());
  }

}