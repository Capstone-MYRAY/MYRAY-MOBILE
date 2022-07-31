import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_models.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/applied_farmer/applied_farmer_repository.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/check_attendance_dialog.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/fired_confirm_dialog.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

class JobFarmerListController extends GetxController {
  final _attendanceRepository = Get.find<AttendanceRepository>();
  final _uploadService = Get.find<UploadImageService>();
  final signatureController = SignatureController(
    penColor: AppColors.black,
    penStrokeWidth: 3.0,
    exportBackgroundColor: AppColors.white,
  );
  final _appliedFarmerRepository = Get.find<AppliedFarmerRepository>();
  final _jobPostId = Get.arguments[Arguments.jobPostId];
  RxList<AppliedFarmer> appliedFarmers = RxList<AppliedFarmer>();
  Rxn<AppliedFarmerStatus> selectedFilter = Rxn(null);
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  var totalCount = 0.obs;

  final List<FilterObject> _filters = [
    FilterObject(name: 'Toàn bộ', value: null),
    FilterObject(
      name: AppStrings.appliedFarmerApproved,
      value: AppliedFarmerStatus.approved,
    ),
    FilterObject(
      name: AppStrings.appliedFarmerPending,
      value: AppliedFarmerStatus.pending,
    ),
    FilterObject(
      name: AppStrings.appliedFarmerEnd,
      value: AppliedFarmerStatus.end,
    ),
    FilterObject(
      name: AppStrings.appliedFarmerFired,
      value: AppliedFarmerStatus.fired,
    ),
    FilterObject(
      name: AppStrings.appliedFarmerRejected,
      value: AppliedFarmerStatus.rejected,
    ),
  ];

  Future<bool?> getAppliedFarmers() async {
    GetAppliedFarmerRequest data = GetAppliedFarmerRequest(
      status: selectedFilter.value,
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      jobPostId: _jobPostId.toString(),
      sortColumn: AppliedFarmerSortColumn.appliedDate,
      orderBy: SortOrder.descending,
    );

    //load applied farmer

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        final response = await _appliedFarmerRepository.getAppliedByJob(data);
        if (response == null || response.appliedFarmers!.isEmpty) {
          isLoading.value = false;
          return null;
        }

        totalCount.value = response.metadata?.totalCount ?? 0;

        appliedFarmers.addAll(response.appliedFarmers!);
        //update hasNext
        _hasNextPage = response.metadata!.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } on CustomException {
      isLoading.value = false;
      _hasNextPage = false;
      return null;
    }
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;
    totalCount.value = 0;

    //clear applied farmer list
    appliedFarmers.clear();

    update();
  }

  List<DropdownMenuItem<Object?>> buildFilterList() {
    return _filters
        .map(
          (filter) => DropdownMenuItem(
            value: filter.value,
            child: Text(filter.name),
          ),
        )
        .toList();
  }

  onChangedFilter(value) {
    selectedFilter.value = value;
    onRefresh();
  }

  updateList(AppliedFarmer appliedFarmer) {
    AppliedFarmer farmer =
        appliedFarmers.firstWhere((element) => element.id == appliedFarmer.id);
    farmer.status = appliedFarmer.status;
    appliedFarmers.refresh();
  }

  onFinish(AppliedFarmer appliedFarmer) {
    CheckAttendanceDialog.show(
      appliedFarmer.jobPost.payPerHourJob?.salary ??
          appliedFarmer.jobPost.payPerTaskJob?.salary ??
          0,
      signatureController,
      () => _onFinish(appliedFarmer, isOnFinish: true),
      isFinish: true,
    );
  }

  _onFinish(AppliedFarmer appliedFarmer, {bool isOnFinish = false}) async {
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
        jobPostId: appliedFarmer.jobPost.id.toString(),
        dateTime: DateTime.now(),
        accountId: appliedFarmer.userInfo.id.toString(),
        signature: uploadedFile?.files.first.link,
        status: AttendanceStatus.end,
      );

      print(data.toJson());

      final result = await _attendanceRepository.checkAttendance(data);
      if (result == null) throw Exception('Có lỗi xảy ra');

      appliedFarmer.status = AppliedFarmerStatus.end.index;
      appliedFarmers.refresh();

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

  onFired(AppliedFarmer appliedFarmer) {
    FiredConfirmDialog.show((reason) => _onFired(appliedFarmer, reason));
  }

  _onFired(AppliedFarmer appliedFarmer, String? reason) async {
    EasyLoading.show();

    try {
      final data = CheckAttendanceRequest(
        jobPostId: appliedFarmer.jobPost.id.toString(),
        dateTime: DateTime.now(),
        accountId: appliedFarmer.userInfo.id.toString(),
        status: AttendanceStatus.fired,
        reason: reason,
      );

      print(data.toJson());

      final result = await _attendanceRepository.checkAttendance(data);
      if (result == null) throw Exception('Có lỗi xảy ra');

      appliedFarmer.status = AppliedFarmerStatus.end.index;
      appliedFarmers.refresh();

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
}
