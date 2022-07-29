
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/applied_job_controller.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/day_off_controller.dart';

class AppliedJobBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AppliedJobController());
    Get.lazyPut(() => DayOffController());
  }

}