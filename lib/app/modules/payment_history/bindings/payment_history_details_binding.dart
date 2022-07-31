import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/payment_history/payment_history_models.dart';
import 'package:myray_mobile/app/modules/payment_history/payment_history_module.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class PaymentHistoryDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final String tag = Get.arguments[Arguments.tag];
    final Rx<PaymentHistory> paymentHistory = Rx(Get.arguments[Arguments.item]);
    Get.lazyPut(
      () => PaymentHistoryDetailsController(paymentHistory: paymentHistory),
      tag: tag,
    );
  }
}
