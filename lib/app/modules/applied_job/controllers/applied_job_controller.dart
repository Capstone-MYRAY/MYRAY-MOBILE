import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';

class AppliedJobController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final _appliedRepository = Get.find<AppliedJobRepository>();
  Rx<GetAppliedJobPostList>? appliedJobList;
  RxList<AppliedJobResponse> appliedJobPostResponse =
      RxList<AppliedJobResponse>();
  Rx<bool> isRefresh = false.obs;
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
  }

  Future<void> onRefresh() async {
    _currentPage = 0;
    _hasNextPage = true;

    appliedJobPostResponse.clear();
    await getAppliedJobList();
    
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
    GetRequestJobPostList data = GetRequestJobPostList(
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
              appliedJobPostResponse.removeWhere((appliedJob) => appliedJob.jobPost.id == jobPostId),            
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
}
