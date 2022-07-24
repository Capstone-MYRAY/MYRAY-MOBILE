import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_models.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/check_attendance_dialog.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/fired_confirm_dialog.dart';
import 'package:myray_mobile/app/shared/utils/datetime_extension.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class JobPostAttendanceController extends GetxController {
  final _attendanceRepository = Get.find<AttendanceRepository>();
  final _uploadService = Get.find<UploadImageService>();
  final signatureController = SignatureController(
    penColor: AppColors.black,
    penStrokeWidth: 3.0,
    exportBackgroundColor: AppColors.white,
  );
  final attendances = LinkedHashMap(
    equals: (DateTime d1, DateTime d2) => Utils.isTheSameDate(d1, d2),
  );
  final JobPost _jobPost = Get.arguments[Arguments.item];
  late DateTime startDate;
  late DateTime? endDate;
  var selectedDate = DateTime(1900).obs;

  String get jobTitle => _jobPost.title;

  List<GetAttendanceByDateResponse> selectedAttendances = [];

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateUtils.dateOnly(DateTime.now());
    startDate = _jobPost.jobStartDate.toLocal();
    endDate = _jobPost.jobEndDate?.toLocal();

    endDate ??= now.add(const Duration(days: 7));

    if (now.isDateInRange(startDate, endDate!)) {
      selectedDate.value = now;
    } else {
      selectedDate.value = startDate;
    }

    print('Start: ${startDate.toIso8601String()}');
    print('Now: ${now.toIso8601String()}');
    print('Focused: ${selectedDate.value.toIso8601String()}');
    print('End: ${endDate?.toIso8601String()}');
  }

  Future<void> loadAttendancesByDate() async {
    try {
      if (!attendances.containsKey(selectedDate.value)) {
        await _getAttendancesByDate();
      }

      selectedAttendances = attendances[selectedDate.value];
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
    //table_calendar use utc
    selectedDate.value = DateUtils.dateOnly(selectedDay.toUtc());
    update(['Attendances']);
  }

  void _updateAttendanceList(Account farmer, DateTime date,
      Attendance attendance, AttendanceStatus status) {
    final item =
        selectedAttendances.firstWhere((e) => e.farmer.id == farmer.id);
    item.attendance.add(attendance);
    attendances.update(date, (value) => selectedAttendances);
    if (status == AttendanceStatus.end || status == AttendanceStatus.fired) {
      attendances.removeWhere(
          (key, value) => !key.isAtSameMomentAs(selectedDate.value));
    }
    update(['CA-${item.farmer.id}']);
  }

  onFired(Account farmer) {
    FiredConfirmDialog.show((reason) => _onFired(farmer, reason));
  }

  _onFired(Account farmer, String? reason) async {
    EasyLoading.show();

    try {
      final data = CheckAttendanceRequest(
        jobPostId: _jobPost.id.toString(),
        dateTime: selectedDate.value,
        accountId: farmer.id.toString(),
        status: AttendanceStatus.fired,
        reason: reason,
      );

      print(data.toJson());

      final result = await _attendanceRepository.checkAttendance(data);
      if (result == null) throw Exception('Có lỗi xảy ra');
      _updateAttendanceList(
          farmer, selectedDate.value, result, AttendanceStatus.fired);
      EasyLoading.dismiss();
      Get.back(); //close dialog
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      print('_onFired: ${e.toString()}');
    }
  }

  onAbsent(Account farmer) async {
    EasyLoading.show();
    try {
      final data = CheckAttendanceRequest(
        jobPostId: _jobPost.id.toString(),
        dateTime: selectedDate.value,
        accountId: farmer.id.toString(),
        status: AttendanceStatus.absent,
      );

      final result = await _attendanceRepository.checkAttendance(data);
      if (result == null) throw Exception('Có lỗi xảy ra');
      _updateAttendanceList(
          farmer, selectedDate.value, result, AttendanceStatus.absent);
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      print('onAbsent: ${e.toString()}');
    }
  }

  onPresent(Account farmer) {
    CheckAttendanceDialog.show(
      _jobPost.payPerHourJob?.salary ?? _jobPost.payPerTaskJob?.salary ?? 0,
      signatureController,
      () => _onPresentOrFinish(farmer),
    );
  }

  onFinish(Account farmer) {
    CheckAttendanceDialog.show(
      _jobPost.payPerHourJob?.salary ?? _jobPost.payPerTaskJob?.salary ?? 0,
      signatureController,
      () => _onPresentOrFinish(farmer, isOnFinish: true),
    );
  }

  _onPresentOrFinish(Account farmer, {bool isOnFinish = false}) async {
    EasyLoading.show();
    try {
      //generate multipart
      final imgBytes = await signatureController.toPngBytes();
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/signature.png').create();
      file.writeAsBytesSync(imgBytes!);

      var multipart =
          MultipartFile(file, filename: '${tempDir.path}/signature.png');
      final uploadedFile = await _uploadService.uploadImage([multipart]);

      //mark as present or finish
      final data = CheckAttendanceRequest(
        jobPostId: _jobPost.id.toString(),
        dateTime: selectedDate.value,
        accountId: farmer.id.toString(),
        signature: uploadedFile?.files.first.link,
        status: !isOnFinish ? AttendanceStatus.present : AttendanceStatus.end,
      );

      print(data.toJson());

      final result = await _attendanceRepository.checkAttendance(data);
      if (result == null) throw Exception('Có lỗi xảy ra');
      _updateAttendanceList(farmer, selectedDate.value, result,
          isOnFinish ? AttendanceStatus.end : AttendanceStatus.present);
      signatureController.clear();
      EasyLoading.dismiss();
      Get.back(); //close dialog
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
      print('_onPresentOrFinish: ${e.toString()}');
    }
  }
}
