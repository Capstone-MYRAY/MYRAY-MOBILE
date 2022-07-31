import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/report/controllers/landowner_report_controller.dart';

class LandownerReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LandownerReportController());
  }
}
