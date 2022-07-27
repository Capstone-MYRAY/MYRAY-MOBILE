import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/report/report_models.dart';
import 'package:myray_mobile/app/modules/report/controllers/landowner_report_details_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class LandownerReportDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final String tag = Get.arguments[Arguments.tag];
    final Report report = Get.arguments[Arguments.item];
    Get.lazyPut(
      () => LandownerReportDetailsController(report: report),
      tag: tag,
    );
  }
}
