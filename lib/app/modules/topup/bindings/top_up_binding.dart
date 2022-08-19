import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/topup/controllers/top_up_controller.dart';

class TopUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopUpController());
  }
}
