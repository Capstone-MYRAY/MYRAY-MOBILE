import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/data/models/report/report_models.dart';
import 'package:myray_mobile/app/modules/report/report_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class LandownerReportController extends GetxController {
  final _reportRepository = Get.find<ReportRepository>();
  RxList<Report> reports = RxList<Report>();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  Rxn<ReportStatus> selectedFilter = Rxn(null);

  final List<FilterObj> _filters = [
    FilterObj(name: 'Toàn bộ', value: null),
    FilterObj(
      name: AppStrings.reportPending,
      value: ReportStatus.pending,
    ),
    FilterObj(
      name: AppStrings.reportResolved,
      value: ReportStatus.resolved,
    ),
  ];

  Future<bool?> getReports() async {
    final int accountId = AuthCredentials.instance.user!.id!;

    final data = GetReportRequest(
      createdBy: accountId.toString(),
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: ReportSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    //load reports

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        final response = await _reportRepository.getReport(data);
        if (response == null || response.listObject!.isEmpty) {
          isLoading.value = false;
          return null;
        }

        reports.addAll(response.listObject!);
        //update hasNext
        _hasNextPage = response.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } catch (e) {
      isLoading.value = false;
      _hasNextPage = false;
      return null;
    }
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;

    reports.clear();

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
