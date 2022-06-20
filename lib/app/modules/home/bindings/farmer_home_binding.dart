
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';

class FarmerJobPostBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FarmerHomeController());
  }

}