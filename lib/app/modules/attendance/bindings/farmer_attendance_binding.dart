
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/attendance/controllers/farmer_attendance_controller.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class FarmerAttendanceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FarmerAttendanceController(), fenix: true);
    Get.lazyPut(() => AttendanceRepository());
  }

}