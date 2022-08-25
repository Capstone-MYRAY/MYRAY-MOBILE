import 'dart:io';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_models.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/data/models/upload_file/upload_file_models.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/applied_farmer/applied_farmer_repository.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/check_attendance_dialog.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/fired_confirm_dialog.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_details_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';
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
  final moneyController = MoneyMaskedTextController(
    thousandSeparator: '.',
    rightSymbol: 'đ',
    precision: 0,
    decimalSeparator: '',
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

  void updateAppliedFarmer(AppliedFarmer appliedFarmer) {
    int index = appliedFarmers.indexWhere((e) => e.id == appliedFarmer.id);
    if (index >= 0) {
      appliedFarmers[index] = appliedFarmer;
    }
  }

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

  onFinish(AppliedFarmer appliedFarmer) async {
    if (!appliedFarmer.jobPost.isPayPerHourJob) {
      //set money controller
      moneyController.updateValue(appliedFarmer.jobPost.payPerTaskJob?.salary);
      CheckAttendanceDialog.show(
        appliedFarmer.jobPost.payPerHourJob?.salary ??
            appliedFarmer.jobPost.payPerTaskJob?.salary ??
            0,
        signatureController,
        () => _payPerTaskEnd(appliedFarmer),
        moneyController: moneyController,
      );
    } else {
      try {
        final confirmed = await CustomDialog.show(
          message:
              'Bạn muốn hoàn thành công việc cho ${appliedFarmer.userInfo.fullName}?',
          confirm: () => Get.back(result: true),
        );

        if (confirmed == null || !confirmed) return;

        _payPerHourEnd(appliedFarmer);
      } catch (e) {
        EasyLoading.dismiss();
        CustomSnackbar.show(
          title: AppStrings.titleError,
          message: 'Có lỗi xảy ra',
          backgroundColor: AppColors.errorColor,
        );
        print('_onFinish: ${e.toString()}');
      }
    }
  }

  _payPerHourEnd(AppliedFarmer appliedFarmer) async {
    try {
      //mark as finish
      final data = CheckAttendanceRequest(
        jobPostId: appliedFarmer.jobPost.id.toString(),
        dateTime: DateTime.now(),
        accountId: appliedFarmer.userInfo.id.toString(),
        status: AttendanceStatus.end,
      );

      print(data.toJson());

      EasyLoading.show();
      final result = await _attendanceRepository.checkAttendance(data);
      EasyLoading.dismiss();
      if (result == null) throw Exception('Có lỗi xảy ra');

      _updateAppliedFarmer(appliedFarmer);
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  _payPerTaskEnd(AppliedFarmer appliedFarmer) async {
    try {
      print(moneyController.value);
      UploadImageResponse? uploadedFile;

      //generate multipart
      final imgBytes = await signatureController.toPngBytes();
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/signature.png').create();
      file.writeAsBytesSync(imgBytes!);

      var multipart =
          MultipartFile(file, filename: '${tempDir.path}/signature.png');
      uploadedFile = await _uploadService.uploadImage([multipart]);

      //mark as finish
      final data = CheckAttendanceRequest(
        jobPostId: appliedFarmer.jobPost.id.toString(),
        dateTime: DateTime.now(),
        salary: moneyController.numberValue,
        signature: uploadedFile?.files.first.link,
        accountId: appliedFarmer.userInfo.id.toString(),
        status: AttendanceStatus.end,
      );

      print(data.toJson());

      EasyLoading.show();
      final result =
          await _attendanceRepository.checkPayPerTaskAttendance(data);
      EasyLoading.dismiss();
      if (result == null) throw Exception('Có lỗi xảy ra');

      signatureController.clear();
      moneyController.clear();

      _updateAppliedFarmer(appliedFarmer);
      Get.back();
    } catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  _updateAppliedFarmer(AppliedFarmer appliedFarmer) {
    appliedFarmer.status = AppliedFarmerStatus.end.index;
    appliedFarmers.refresh();

    //update job post details
    final jobPostDetails = Get.find<LandownerJobPostDetailsController>(
        tag: appliedFarmer.jobPost.id.toString());
    jobPostDetails.totalPayingSalary.value =
        appliedFarmer.jobPost.payPerTaskJob?.salary ?? 0;
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

      appliedFarmer.status = AppliedFarmerStatus.fired.index;
      appliedFarmers.refresh();

      final jobPostDetailsController =
          Get.find<LandownerJobPostDetailsController>(
              tag: appliedFarmer.jobPost.id.toString());

      //update approve farmer
      print(jobPostDetailsController.totalApprovedFarmer.value);
      jobPostDetailsController.totalApprovedFarmer.value -= 1;
      print(jobPostDetailsController.totalApprovedFarmer.value);
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
