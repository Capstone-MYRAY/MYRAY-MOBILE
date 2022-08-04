import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/history_job/controllers/history_applied_job_controller.dart';

class HistoryAppliedJobBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryAppliedJobController(), fenix: true);
  }

}