
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';

class AppliedJobController extends GetxController with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  final _appliedRepository = Get.find<AppliedJobRepository>();
  Rx<GetAppliedJobPostList>? appliedJobList;


  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: 3);
  }

  TabBar get tabBar => TabBar(
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.primaryColor,
          indicatorPadding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          controller: tabController,
          tabs:  <Widget>[
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

   GetRequestJobPostList data =
      GetRequestJobPostList(page: "1", pageSize: "20");
  
  Future<GetAppliedJobPostList?> getAppliedJobList () async{
    final GetAppliedJobPostList? list = await _appliedRepository.getAppliedJobList(data);
    print("applied list: ${list!.listObject!.length}");
    return list;
  }
}