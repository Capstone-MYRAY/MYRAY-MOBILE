import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/history_job/controllers/farmer_history_job_detail_controller.dart';
import 'package:myray_mobile/app/modules/history_job/history_job_repository.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class FarmerHistoryJobDetailBinding extends Bindings {
  @override
  void dependencies() {
    Rx<AppliedJobResponse> appliedJob = Rx(Get.arguments[Arguments.item]);
    final String tag = Get.arguments[Arguments.tag];
    Get.lazyPut(
      () => FarmerHistoryJobDetailController(appliedJob: appliedJob),
      fenix: true,
      tag: tag,
    );
    Get.lazyPut(() => HistoryJobRepository());
    Get.lazyPut(() => AttendanceRepository());
  }
}
