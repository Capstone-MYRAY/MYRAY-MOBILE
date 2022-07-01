import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class LandownerJobPostController extends GetxController {
  navigateToDetails() {
    Get.toNamed(Routes.jobPostForm, arguments: {
      Arguments.action: Activities.create,
    });
  }
}
