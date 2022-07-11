import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_controller.dart';

class AppliedFarmerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppliedFarmerController());
  }
}
