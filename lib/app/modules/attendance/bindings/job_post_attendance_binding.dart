import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/attendance/controllers/job_post_attendance_controller.dart';

class JobPostAttendanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobPostAttendanceController>(
      () => JobPostAttendanceController(),
    );
  }
}
