import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/data/services/tree_type_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class LandownerJobPostController extends GetxController {
  final _treeTypeRepository = Get.find<TreeTypeRepository>();

  Future<void> navigateToDetails() async {
    Get.toNamed(Routes.jobPostForm, arguments: {
      Arguments.action: Activities.create,
    });
  }
}
