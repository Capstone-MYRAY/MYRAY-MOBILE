import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/data/services/garden_service.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class GardenHomeController extends GetxController with GardenService {
  final _gardenRepository = Get.find<GardenRepository>();
  RxList<Garden> gardens = RxList<Garden>();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  Future<bool?> getGardens() async {
    final int accountId = AuthCredentials.instance.user!.id!;

    GetGardenRequest data = GetGardenRequest(
      accountId: accountId.toString(),
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: GardenSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    //load gardens

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        final response = await _gardenRepository.getGardens(data);
        if (response == null || response.gardens!.isEmpty) {
          isLoading.value = false;
          return null;
        }

        gardens.addAll(response.gardens!);
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

    //clear garden list
    gardens.clear();

    // await getGardens();

    update();
  }

  onDeleteGarden(Garden garden) async {
    bool? success = await deleteGarden(garden, gardens);
    if (success != null && success) {
      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: AppMsg.MSG4014,
      );
    }
  }
}
