import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  @override
  onClose() {
    if (!Get.find<AuthController>().isLogged.value) {
      Get.deleteAll();
    }
    super.onClose();
  }
}
