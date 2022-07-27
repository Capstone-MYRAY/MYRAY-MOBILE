import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/modules/applied_farmer/applied_farmer_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class JobFarmerListController extends GetxController {
  final _appliedFarmerRepository = Get.find<AppliedFarmerRepository>();
  final _jobPostId = Get.arguments[Arguments.jobPostId];
  RxList<AppliedFarmer> appliedFarmer = RxList<AppliedFarmer>();
  Rxn<AppliedFarmerStatus> selectedFilter = Rxn(null);
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  final List<FilterObj> _filters = [
    FilterObj(name: 'Toàn bộ', value: null),
    FilterObj(
      name: AppStrings.appliedFarmerApproved,
      value: AppliedFarmerStatus.approved,
    ),
    FilterObj(
      name: AppStrings.appliedFarmerPending,
      value: AppliedFarmerStatus.pending,
    ),
    FilterObj(
      name: AppStrings.appliedFarmerEnd,
      value: AppliedFarmerStatus.end,
    ),
    FilterObj(
      name: AppStrings.appliedFarmerFired,
      value: AppliedFarmerStatus.fired,
    ),
    FilterObj(
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

        appliedFarmer.addAll(response.appliedFarmers!);
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

    //clear applied farmer list
    appliedFarmer.clear();

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
}
