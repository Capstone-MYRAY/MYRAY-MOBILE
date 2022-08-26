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

  showDetailAttendance(
      BuildContext context, AttendanceResponse attendanceResponse) async {
    int status = attendanceResponse.status;
    print('Status: $status');
    if (status == 1) {
      GetAttendanceByDateRequest data = GetAttendanceByDateRequest(
        jobPostId: currentJobPost.id.toString(),
        date: attendanceResponse.date.toLocal(),
      );
      try {
        List<GetAttendanceByDateResponse>? attendance =
            await _attendanceRepository.getList(data);

        EasyLoading.show();
        Future.delayed(const Duration(milliseconds: 1000), () {
          EasyLoading.dismiss();
          //when checked attendance
          if (attendance != null && attendance.first.attendances.isNotEmpty) {
            //add attendance parameter.
            Attendance data = attendance.first.attendances.first;
            FarmerAttendanceDetailDialog.show(
                context, data, currentJobPost.title);
            return;
          }
          CustomInformationDialog.show(
              title: 'Thất bại',
              content: const Center(child: Text('Không có dữ liệu')));
        });
      } on CustomException catch (e) {
        print(e.message);
        CustomInformationDialog.show(
            title: 'Thất bại',
            content: const Center(child: Text('Không thể tải dữ liệu')));
      }
      return;
    }

    if (status == 0) {
      CustomInformationDialog.show(
          title: 'Thông báo',
          content: const Center(child: Text('Bạn đã vắng mặt')));
      return;
    }

    if (status == 4) {
      CustomInformationDialog.show(
        title: 'Đã xin nghỉ',
        content: Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                'Lý do:',
                style: Get.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: Get.textScaleFactor * 16,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  attendanceResponse.reason ?? 'Không có lý do',
                  style: Get.textTheme.labelMedium!.copyWith(
                      fontSize: Get.textScaleFactor * 16,
                      color: AppColors.black),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      );
      return;
    }
  }
}
