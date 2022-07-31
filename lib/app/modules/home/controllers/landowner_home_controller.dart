import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_current_job/landowner_current_start_jobs_controller.dart';

class LandownerHomeController extends GetxController {
  final _currentStartJobController =
      Get.find<LandownerCurrentStartJobsController>();

  Future<void> refreshCurrentStartJob() async {
    await _currentStartJobController.onRefresh();
  }
}
