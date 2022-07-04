
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_job/controllers/applied_job_controller.dart';

class AppliedJobBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AppliedJobController());
  }

}