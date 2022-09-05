import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_models.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_response.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/farmer_attendance_detail_dialog.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_information.dialog.dart';

class FarmerAttendanceController extends GetxController {
  late JobPost currentJobPost;

  final _appliedRepository = Get.find<AppliedJobRepository>();
  final _attendanceRepository = Get.find<AttendanceRepository>();
  RxList<AppliedJobResponse> payPerHourJobList = RxList<AppliedJobResponse>();
  RxList<AttendanceResponse> attendances = RxList<AttendanceResponse>();
  RxList<AttendanceResponse> showLesAttendances = RxList<AttendanceResponse>();

  final int _pageSize = 5;
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;

  Future<bool?> getPayPerHourJobList() async {
    GetAppliedJobPostList? list;
    RxList<AppliedJobResponse> tempList = RxList<AppliedJobResponse>();

    GetAppliedJobRequest data = GetAppliedJobRequest(
      status: AppliedFarmerStatus.approved,
      startWork: "1",
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
    );

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        list = await _appliedRepository.getAppliedJobList(data);
        print(list == null);
        if (list == null) {
          isLoading.value = false;
          return null;
        }
        tempList.addAll(list.listObject ??= []);
        if (tempList.isNotEmpty) {
          payPerHourJobList.value = tempList
              .where((job) => job.jobPost.type == 'PayPerHourJob')
              .toList();
        }
        print('legth: ${payPerHourJobList.length}');
        _hasNextPage = list.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } on CustomException catch (e) {
      print(e.message);
      isLoading.value = false;
      _hasNextPage = false;
    }
    return null;
  }

  Future<void> onRefresh() async {
    _currentPage = 0;
    _hasNextPage = true;

    payPerHourJobList.clear();
    await getPayPerHourJobList();
  }

  getAttendanceByJob() async {
    GetAttendanceRequest data = GetAttendanceRequest(
        accountId: AuthCredentials.instance.user!.id.toString(),
        jobPostId: currentJobPost.id.toString());
    try {
      List<AttendanceResponse>? loadList =
          await _attendanceRepository.getAttendanceList(data);
      if (loadList == null) {
        return null;
      }

      if (loadList.isEmpty) {
        return [];
      }
      if (attendances.isNotEmpty) {
        return;
      }
      attendances.addAll(loadList.reversed);
    } on CustomException catch (e) {
      print("In attendance farmer controller: ${e.message}");
    }
    return null;
  }

  Future<void> onRefreshAttendanceList() async {
    attendances.clear();
    await getAttendanceByJob();
  }
  showAttendance(BuildContext context, DateTime dateAttendance) async {
    try {
      print(">>> $dateAttendance");
      GetAttendanceByDateRequest data = GetAttendanceByDateRequest(
        jobPostId: currentJobPost.id.toString(),
        date: dateAttendance.toLocal(),
      );

      EasyLoading.show();
      List<GetAttendanceByDateResponse>? attendances =
          await _attendanceRepository.getList(data);
      EasyLoading.dismiss();

      if (attendances == null || attendances.isEmpty) {
        CustomInformationDialog.show(
          title: 'Thông báo',
          message:
              'Bạn chưa được điểm danh!\nVui lòng liên hệ chủ vườn hoặc người điều hành gần bạn nhất để được hỗ trợ.',
          icon: const Icon(Icons.pending_actions_outlined,
              size: 40, color: AppColors.brown),
        );
        return;
      }

      final farmerId = AuthCredentials.instance.user!.id;

      //find farmer in attendance list
      GetAttendanceByDateResponse? todayAttendance = attendances
          .firstWhereOrNull((attendance) => attendance.farmer.id == farmerId);
      print("attendance: ${todayAttendance?.attendances.length}");
  
      if (todayAttendance == null || todayAttendance.attendances.isEmpty) {

        CustomInformationDialog.show(
          title: 'Thông báo',
          message:
              'Bạn chưa được điểm danh!\nVui lòng liên hệ chủ vườn hoặc người điều hành gần bạn nhất để được hỗ trợ.',
          icon: const Icon(Icons.pending_actions_outlined,
              size: 40, color: AppColors.brown),
        );
        return;
      }
      // if (todayAttendance == null)
      //   throw CustomException('Không thể xem điểm danh');
      //4: dayOff
      if (todayAttendance.attendances.first.status ==
          AttendanceStatus.dayOff.index) {
        CustomInformationDialog.show(
          title: 'Thông báo',
          message:
              'Bạn đã xin nghỉ phép ngày hôm nay\nVui lòng liên hệ chủ vườn hoặc người điều hành gần bạn nhất để được hỗ trợ.',
          icon: const Icon(Icons.free_cancellation_outlined,
              size: 40, color: AppColors.brown),
        );
        return;
      }

      if (todayAttendance.attendances.first.status ==
          AttendanceStatus.absent.index) {
        CustomInformationDialog.show(
            title: 'Thông báo', message: 'Bạn đã vắng mặt');
        return;
      }

      FarmerAttendanceDetailDialog.show(Get.context!,
          todayAttendance.attendances.first, currentJobPost.title);
    } on CustomException catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Không thể xem điểm danh !",
          backgroundColor: AppColors.errorColor);
    }
    // catch (e) {
    //   EasyLoading.dismiss();
    //   CustomSnackbar.show(
    //       title: "Thất bại",
    //       message: "Không thể xem điểm danh !",
    //       backgroundColor: AppColors.errorColor);
    // }
  }
}
