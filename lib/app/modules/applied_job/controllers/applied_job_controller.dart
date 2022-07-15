import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_list_response.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_request.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/put_extend_end_date_request.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';

class AppliedJobController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final _appliedRepository = Get.find<AppliedJobRepository>();

  Rx<GetAppliedJobPostList>? appliedJobList;
  RxList<AppliedJobResponse> appliedJobPostResponse =
      RxList<AppliedJobResponse>();

  Rx<GetExtendEndDateJobList>? extendEndDateList;
  RxList<ExtendEndDateJob> listObject = RxList<ExtendEndDateJob>();

  late GlobalKey<FormState> formKey;
  late TextEditingController extendEndDateController;
  late TextEditingController reasonExtendEndDateController;

  Rx<bool> isRefresh = false.obs;
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;
  final isLoading = false.obs;

  //paging extend job list
  int _currentExtendJobPage = 0;
  bool _hasNextExtendJobPage = true;
  final isLoadingExtendJobPage = false.obs;

  late DateTime currentDate;

  @override
  void onInit() {
    formKey = GlobalKey<FormState>();
    extendEndDateController = TextEditingController();
    reasonExtendEndDateController = TextEditingController();

    super.onInit();
    tabController = TabController(vsync: this, length: 3);
  }

   String? validateReason(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng nhập lý do';
    }
    return null;
  }

  Future<void> onRefresh() async {
    _currentPage = 0;
    _hasNextPage = true;

    appliedJobPostResponse.clear();
    await getAppliedJobList();
  }

  Future<void> onRefreshExtendPage() async {
    _currentExtendJobPage = 0;
    _hasNextExtendJobPage = true;

    listObject.clear();
    await getExtendEndDateJobList();
  }

  TabBar get tabBar => TabBar(
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.primaryColor,
          indicatorPadding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          controller: tabController,
          tabs: <Widget>[
            Tab(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  AppStrings.labelJobVerify,
                  style: TextStyle(fontSize: Get.textScaleFactor * 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  AppStrings.labelExtendEndDateVerify,
                  style: TextStyle(fontSize: Get.textScaleFactor * 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Tab(
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  AppStrings.labelOnLeave,
                  style: TextStyle(fontSize: Get.textScaleFactor * 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]);

  Future<bool?> getAppliedJobList() async {
    GetAppliedJobPostList? list;
    GetAppliedJobRequest data = GetAppliedJobRequest(
      status: AppliedFarmerStatus.pending,
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
    );

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        list = await _appliedRepository.getAppliedJobList(data);
        isRefresh(true);
        if (list == null || list.listObject!.isEmpty) {
          isLoading.value = false;
          return null;
        }
        appliedJobPostResponse.addAll(list.listObject!);
        _hasNextPage = list.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      isRefresh(false);
      return true;
    } on CustomException catch (e) {
      print(e);
      isLoading.value = false;
      _hasNextPage = false;
    }
    return null;
    // print("applied list: ${list!.listObject!.length}");
    // return list;
  }

  cancelAppliedJob(int jobPostId) async {
    Get.back();
    await _appliedRepository.cancelAppliedJob(jobPostId).then((result) => {
          if (result!)
            {
              CustomSnackbar.show(
                  title: "Thành công", message: "Hủy yêu cầu thành công"),
              isRefresh(true),
              appliedJobPostResponse.removeWhere(
                  (appliedJob) => appliedJob.jobPost.id == jobPostId),
            }
          else
            {
              CustomSnackbar.show(
                  title: "Thất bại",
                  message: "Hủy yêu cầu không thành công",
                  backgroundColor: AppColors.errorColor),
            }
        });

    isRefresh(false);
  }

  Future<bool?> getExtendEndDateJobList() async {
    GetExtendEndDateJobList? list;
    GetExtendEndDateJobRequest data = GetExtendEndDateJobRequest(
      requestBy: AuthCredentials.instance.user!.id!.toString(),
      status: '0',
      page: (++_currentExtendJobPage).toString(),
      pageSize: (_pageSize).toString(),
    );

    isLoadingExtendJobPage.value = true;
    try {
      if (_hasNextExtendJobPage) {
        list = await _appliedRepository.getExtendEndDateJobList(data);

        if (list == null) {
          isLoadingExtendJobPage.value = false;
          return null;
        }

        listObject.addAll(list.listObject ?? []);
        _hasNextExtendJobPage = list.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      print("length: ${listObject.length}");
      return true;
    } on CustomException catch (e) {
      print(e.message);
      isLoadingExtendJobPage.value = false;
      _hasNextExtendJobPage = false;
    }
    return null;
  }

  canceExtendEndDate(int extendTaskId) async {
    Get.back();
    final result = await _appliedRepository.canceExtendEndDate(extendTaskId);
    if (result!) {
      CustomSnackbar.show(
          title: "Thành công", message: 'Hủy yêu cầu thành công');
      listObject.removeWhere((extendTask) => extendTask.id == extendTaskId);
    } else {
      CustomSnackbar.show(
          title: "Thất bại",
          message: 'Hủy yêu cầu thất bại',
          backgroundColor: AppColors.errorColor);
    }
  }

  Future<bool?> updateExtendEndDate(
      ExtendEndDateJob extendTaskJob) async {
    PutExtendEndDateRequest data = PutExtendEndDateRequest(
      id: extendTaskJob.id.toString(),
      jobPostId: extendTaskJob.jobPostId,
      extendEndDate: currentDate.toString()+'Z',
      reason: reasonExtendEndDateController.text,
    );
    print("ngay moi: " + extendEndDateController.text);
    return await _appliedRepository.updateExtendEndDate(data);
    // return true;
  }

  void onChooseNewEndDate(DateTime oldDate) async {
    // DateTime now = DateTime.now();
    DateTime _initDate = oldDate;
    DateTime _firstDate = extendEndDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(extendEndDateController.text)
        : _initDate;
    DateTime? _pickedDate = await MyDatePicker.show(
        firstDate: _initDate ,
        initDate: _firstDate,
        lastDate: _firstDate.add(
            const Duration(days: 6))); // not include the first day; max = 7
    print('_pickedDate: $_pickedDate');

    if (_pickedDate != null) {
      currentDate = _pickedDate;
      extendEndDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }else{
      currentDate = oldDate;
    }
  }

  onInitUpdateExtendEndDateForm(ExtendEndDateJob appliedJob) {
    extendEndDateController.clear();
    reasonExtendEndDateController.clear();

    extendEndDateController.text =
        DateFormat('dd/MM/yyyy').format(appliedJob.extendEndDate);
    reasonExtendEndDateController.text = appliedJob.reason;
  }

  onSubmitExtendJobForm(ExtendEndDateJob extendTaskJob) async {
    print(extendTaskJob.id);
    bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      Get.back();
      bool? result =
          await updateExtendEndDate(extendTaskJob);     
      if (result!) {
        CustomSnackbar.show(
            title: "Thành công",
            message: 'Cập nhật yêu cầu gia hạn thành công');
        Future.delayed(const Duration(milliseconds: 1000), () {
          onRefreshExtendPage();
        });
      } else {
        CustomSnackbar.show(
            title: "Thất bại",
            message: 'Cập nhật yêu cầu gia hạn thất bại',
            backgroundColor: AppColors.errorColor);
      }
    }
  }

  onCloseExtendJobDialog() {
    extendEndDateController.clear();
    reasonExtendEndDateController.clear();

    Get.back();
  }
}
