import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class HistoryAppliedJobController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _appliedRepository = Get.find<AppliedJobRepository>();
  RxList<AppliedJobResponse> appliedJobPostResponse =
      RxList<AppliedJobResponse>();

  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;
  final isLoading = false.obs;
  int tabIndex = 0;

  late TabController tabController;

  List<Widget> tabs = const [
    Tab(
      text: 'Tất cả',
    ),
    Tab(
      text: 'Chờ duyệt',
    ),
    Tab(
      text: 'Đã nhận',
    ),
    Tab(
      text: 'Từ chối',
    ),
    Tab(
      text: 'Hoàn thành',
    ),
    Tab(
      text: 'Sa thải',
    ),
  ];

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(vsync: this, length: tabs.length);
    tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    tabController.removeListener(_handleTabSelection);
    tabController.dispose();
    super.dispose();
  }

  

  Map<int, dynamic> statusMap = {
    0: null,
    1: AppliedFarmerStatus.pending,
    2: AppliedFarmerStatus.approved,
    3: AppliedFarmerStatus.rejected,
    4: AppliedFarmerStatus.end,
    5: AppliedFarmerStatus.fired
  };

  void _handleTabSelection() async {
    if (tabController.indexIsChanging) {
      switch (tabController.index) {
        case 0:
          tabIndex = 0;
          await onRefresh();
          break;
        case 1:
          tabIndex = 1;
          await onRefresh();
          break;
        case 2:
          tabIndex = 2;
          await onRefresh();
          break;
        case 3:
          tabIndex = 3;
          await onRefresh();
          break;
        case 4:
          tabIndex = 4;
          await onRefresh();
          break;
        case 5:
          tabIndex = 5;
          await onRefresh();
          break;
      }
    }
  }

  //theo tab: all:0; đã nhận: 1; chờ duyệt: 2: từ chối: 3
  Future<bool?> getAppliedJobList() async {
    GetAppliedJobPostList? list;
    //lấy các công việc chưa start và đang start
    GetAppliedJobRequest data = GetAppliedJobRequest(
      status: statusMap[tabIndex],
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      orderBy: SortOrder.descending,
    );

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        list = await _appliedRepository.getAppliedJobList(data);
        if (list == null || list.listObject!.isEmpty) {
          isLoading.value = false;
          return null;
        }
        appliedJobPostResponse.addAll(list.listObject!);
        _hasNextPage = list.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } on CustomException catch (e) {
      print(e);
      isLoading.value = false;
      _hasNextPage = false;
    }
    return null;
  }

  Future<void> onRefresh() async {
    _currentPage = 0;
    _hasNextPage = true;

    appliedJobPostResponse.clear();
    await getAppliedJobList();
  }
}
