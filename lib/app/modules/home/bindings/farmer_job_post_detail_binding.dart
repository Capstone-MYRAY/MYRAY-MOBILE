
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/bookmark/bookmark_repository.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_job_post_detail_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class FarmerJobPostDetailBinding extends Bindings{
  @override
  void dependencies() {
    JobPost jobPost = Get.arguments[Arguments.item];

    Get.lazyPut(() => FarmerJobPostDetailController(jobPost: jobPost));
    Get.lazyPut(() => BookmarkRepository(), fenix: true);
  }

}