import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/attendance/get_attendance_by_date_request.dart';
import 'package:myray_mobile/app/data/models/attendance/get_attendance_by_date_response.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/shared/utils/datetime_extension.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class JobPostAttendanceController extends GetxController {
  final _attendanceRepository = Get.find<AttendanceRepository>();
  final attendances = LinkedHashMap(
    equals: (DateTime d1, DateTime d2) => Utils.isTheSameDate(d1, d2),
  );
  final JobPost _jobPost = Get.arguments[Arguments.item];
  late DateTime startDate;
  late DateTime endDate;
  var selectedDate = DateTime(1900).obs;

  RxList<GetAttendanceByDateResponse> selectedAttendances = RxList([]);

  @override
  void onInit() {
    super.onInit();
    startDate = _jobPost.jobStartDate;

    if (_jobPost.jobEndDate == null) {
      endDate = DateUtils.dateOnly(DateTime.now()).add(const Duration(days: 7));
      selectedDate.value = DateUtils.dateOnly(DateTime.now());
    } else {
      endDate = _jobPost.jobEndDate!;
      if (DateUtils.dateOnly(DateTime.now())
          .isDateInRange(startDate, endDate)) {
        selectedDate.value = DateUtils.dateOnly(DateTime.now());
      } else {
        selectedDate.value = startDate;
      }
    }
  }

  Future<void> loadAttendancesByDate() async {
    try {
      if (!attendances.containsKey(selectedDate.value)) {
        await _getAttendancesByDate();
      }

      selectedAttendances.value = attendances[selectedDate.value];
    } catch (e) {
      print('Attendance error: ${e.toString()}');
    }
  }

  Future<void> _getAttendancesByDate() async {
    GetAttendanceByDateRequest data = GetAttendanceByDateRequest(
      jobPostId: _jobPost.id.toString(),
      date: selectedDate.value,
    );

    final responseList = await _attendanceRepository.getList(data);
    if (responseList != null) {
      attendances.addAll({selectedDate.value: responseList});
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    //rangeSelectionMode is disabled => selectedDay is focusedDay
    //table_calendar use utc => do not have to convert data receive from sever
    selectedDate.value = selectedDay;
    update(['Attendances']);
  }
}
