import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';
import 'package:myray_mobile/app/data/enums/status.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer_models.dart';
import 'package:myray_mobile/app/modules/applied_farmer/applied_farmer_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class AppliedFarmerController extends GetxController {
  final _appliedFarmerRepository = Get.find<AppliedFarmerRepository>();
  RxList<AppliedFarmer> appliedFarmers = RxList<AppliedFarmer>();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  final isBuildFuture = false.obs;

  Future<bool?> getAppliedFarmers() async {
    GetAppliedFarmerRequest data = GetAppliedFarmerRequest(
      status: AppliedFarmerStatus.pending,
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: AppliedFarmerSortColumn.appliedDate,
      orderBy: SortOrder.descending,
    );

    //load applied farmer

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        final _response = await _appliedFarmerRepository.getList(data);
        if (_response == null || _response.appliedFarmers!.isEmpty) {
          isLoading.value = false;
          return null;
        }

        appliedFarmers.addAll(_response.appliedFarmers!);
        //update hasNext
        _hasNextPage = _response.metadata!.hasNextPage;
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
    appliedFarmers.clear();

    update();
  }

  removeItem(AppliedFarmer appliedFarmer) {
    appliedFarmers.remove(appliedFarmer);
  }
}
