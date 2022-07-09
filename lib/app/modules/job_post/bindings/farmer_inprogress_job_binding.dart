
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_controller.dart';

class FarmerInprogressJobBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => FarmerInprogressJobController());
  }

}