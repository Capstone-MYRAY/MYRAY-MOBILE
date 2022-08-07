import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_models.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_response.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class FarmerHistoryJobDetailController extends GetxController {
  Rx<AppliedJobResponse> appliedJob;
  FarmerHistoryJobDetailController({required this.appliedJob});
  final _attendanceRepository = Get.find<AttendanceRepository>();
  RxList<AttendanceResponse> attendanceList = RxList<AttendanceResponse>();

  late JobPost jobPost = appliedJob.value.jobPost;
  late bool isPayPerHourJob = jobPost.type == 'PayPerHourJob';
  late bool isFired = appliedJob.value.status == 4;
  late RxDouble totalSalary = 0.0.obs;


  @override
  void onInit() async {
    await getAttendanceByJob();
    super.onInit();
  }

  getAttendanceByJob() async {
    GetAttendanceRequest data = GetAttendanceRequest(
        accountId: AuthCredentials.instance.user!.id.toString(),
        jobPostId: jobPost.id.toString());
    try {
      List<AttendanceResponse>? loadList =
          await _attendanceRepository.getAttendanceList(data);
      if (loadList == null) {
        return null;
      }

      if (loadList.isEmpty) {
        return [];
      }
      if (attendanceList.isNotEmpty) {
        return;
      }
      attendanceList.addAll(loadList.reversed);
      await _getTotalSalary();
    } on CustomException catch (e) {
      print("In attendance farmer controller: ${e.message}");
    }
    return null;
  }
  _getTotalSalary() async {
     for (var attendance in attendanceList) { 
      totalSalary.value = totalSalary.value + attendance.salary;
     }
  }
}
