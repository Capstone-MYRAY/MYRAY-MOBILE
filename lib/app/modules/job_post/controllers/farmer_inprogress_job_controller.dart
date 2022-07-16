import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_list_response.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/post_extend_end_date_job_request.dart';
import 'package:myray_mobile/app/data/models/report/post_report_request.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class FarmerInprogressJobController extends GetxController {
  final _appliedRepository = Get.find<AppliedJobRepository>();

  Rx<GetAppliedJobPostList>? inProgressJobList;
  RxList<AppliedJobResponse> inProgressJobPostList =
      RxList<AppliedJobResponse>();

  Rx<GetExtendEndDateJobList>? extendEndDateList;
  RxList<ExtendEndDateJob> listObject = RxList<ExtendEndDateJob>();

  final int _pageSize = 5;
  //paging progress list
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;

  late GlobalKey<FormState> formKey;

  late TextEditingController reportContentController;

  late TextEditingController onLeaveStartDateController;
  late TextEditingController onLeaveEndDateController;
  late TextEditingController onLeaveReasonController;

  late TextEditingController extendJobDateController;
  late TextEditingController extendJobReasonController;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();

    reportContentController = TextEditingController();

    onLeaveStartDateController = TextEditingController();
    onLeaveReasonController = TextEditingController();
    onLeaveEndDateController = TextEditingController();

    extendJobDateController = TextEditingController();
    extendJobReasonController = TextEditingController();
    super.onInit();
  }

  Future<bool?> getInProgressJobList() async {
    GetAppliedJobPostList? list;
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
        // isRefresh(true);
        print(list == null);
        if (list == null) {
          isLoading.value = false;
          return null;
        }
        inProgressJobPostList.addAll(list.listObject ?? []);
        _hasNextPage = list.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      // isRefresh(false);
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

    inProgressJobPostList.clear();
    await getInProgressJobList();
  }
  
  String? validateReason(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng nhập lý do';
    }
    return null;
  }

  String? validateChooseOnleaveEndDate(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng chọn ngày kết thúc nghỉ';
    }
    return null;
  }

  String? validateChooseOnleaveStartDate(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng chọn ngày bắt đầu nghỉ';
    }
    if (onLeaveEndDateController.text.isNotEmpty) {
      DateTime startDate = Utils.fromddMMyyyy(onLeaveStartDateController.text);
      DateTime endDate = Utils.fromddMMyyyy(onLeaveEndDateController.text);
      if (startDate.isAfter(endDate)) {
        return 'Ngày bắt đầu nghỉ phải trước ngày kết thúc nghỉ';
      }
    }
    return null;
  }

  String? validateChooseNewEndDate(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng chọn ngày kết thúc mới';
    }
    //Valid just only extend end job date once

    return null;
  }

  void onChooseOnLeaveStartDate() async {
    DateTime? _initDate = onLeaveStartDateController.text.isEmpty
        ? DateTime.now().add(const Duration(days: 1))
        : Utils.fromddMMyyyy(onLeaveStartDateController.text);
    DateTime? _pickedDate = await MyDatePicker.show(
        initDate: _initDate,
        firstDate: _initDate,
        lastDate: DateTime.now()
            .add(const Duration(days: 365 * 10))); //check ngày end job
    if (_pickedDate != null) {
      onLeaveStartDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
    if (onLeaveEndDateController.text.isEmpty) {
      onLeaveEndDateController.text = onLeaveStartDateController.text;
    }
  }

  void onChooseOnLeaveEndDate() async {
    DateTime now = DateTime.now();
    DateTime _firstDate = onLeaveStartDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(onLeaveStartDateController.text)
        : now;
    DateTime? _initDate = !_firstDate.isAtSameMomentAs(now)
        ? _firstDate
        : onLeaveEndDateController.text.isNotEmpty
            ? Utils.fromddMMyyyy(onLeaveEndDateController.text)
            : null;

    DateTime? _pickedDate = await MyDatePicker.show(
        firstDate: _firstDate,
        initDate: _initDate,
        lastDate: _firstDate.add(
            const Duration(days: 29))); // not include the first day; max = 30
    print('_pickedDate: $_pickedDate');

    if (_pickedDate != null) {
      onLeaveEndDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  void onChooseNewEndDate(DateTime? oldDate) async {
    DateTime now = DateTime.now();
    //if end date null, now + (365 days *10) -> update end date
    DateTime _initDate = oldDate != null
        ? oldDate.add(const Duration(days: 1))
        : now.add(const Duration(days: 365 * 10));
    DateTime _firstDate = onLeaveStartDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(onLeaveStartDateController.text)
        : _initDate;
    DateTime? _pickedDate = await MyDatePicker.show(
        firstDate: _firstDate,
        initDate: _initDate,
        lastDate: _firstDate.add(
            const Duration(days: 6))); // not include the first day; max = 7
    print('_pickedDate: $_pickedDate');

    if (_pickedDate != null) {
      extendJobDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  onCloseReportDialog() {
    reportContentController.clear();
    Get.back();
  }

  onCloseOnLeaveDialog() {
    onLeaveStartDateController.clear();
    onLeaveEndDateController.clear();
    onLeaveReasonController.clear();
    Get.back();
  }

  onCloseExtendJobDialog() {
    extendJobDateController.clear();
    extendJobReasonController.clear();
    Get.back();
  }

  onSubmitReportForm(int jobPostId) async {
    bool isFormValid = formKey.currentState!.validate();
    print(isFormValid ? reportContentController.value : 'no valid');
    if (isFormValid) {
      EasyLoading.show();
      PostReportRequest data = PostReportRequest(
          content: reportContentController.text,
          jobPostId: jobPostId,
          reportedId: AuthCredentials.instance.user!.id!);
      Report? result = await _reportJob(data);
      onCloseReportDialog();
      EasyLoading.dismiss();
      if (result == null) {
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi báo cáo không thành công",
            backgroundColor: AppColors.errorColor);
      } else {
        CustomSnackbar.show(
            title: "Thành công", message: "Gửi báo cáo thành công");
      }
    }
  }

  onSubmitOnleaveForm() {
    bool isFormValid = formKey.currentState!.validate();
    print(isFormValid);
    print(onLeaveEndDateController.text);

    if (isFormValid) {
      //do some code here
      onCloseOnLeaveDialog();
    }
  }

  onSubmitExtendJobForm(int jobPostId) async {
    bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      // EasyLoading.show();

      PostExtendEndDateJobRequest data = PostExtendEndDateJobRequest(
          extendEndDate: extendJobDateController.text,
          jobPostId: jobPostId,
          reason: extendJobReasonController.text);

      try {
        ExtendEndDateJob? result = await _extendEndDateJob(data);
        onCloseExtendJobDialog();
        if (result == null) {
          CustomSnackbar.show(
              title: "Thất bại",
              message: "Gửi yêu cầu không thành công",
              backgroundColor: AppColors.errorColor);
        } else {
          CustomSnackbar.show(
              title: "Thành công", message: "Gửi yêu cầu thành công");
        }
      } on CustomException catch (e) {
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi báo cáo không thành công",
            backgroundColor: AppColors.errorColor);
        print('lỗi: $e');
      } finally {
        // EasyLoading.dismiss();
      }
    }
  }

  Future<Report?> _reportJob(PostReportRequest reportData) async {
    return await _appliedRepository.reportJob(reportData);
  }

  Future<ExtendEndDateJob?> _extendEndDateJob(
      PostExtendEndDateJobRequest data) async {
    return await _appliedRepository.extendEndDateJob(data);
  }

  Future<ExtendEndDateJob?> getExtendEndDateJob(int jobPostId) async {
    return await _appliedRepository.getExtendEndDateJob(jobPostId);
  }
}
