import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/payment_history/controllers/payment_history_home_controller.dart';

class PaymentHistoryHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentHistoryHomeController());
  }
}
