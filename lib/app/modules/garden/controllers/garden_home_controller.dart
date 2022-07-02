import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class GardenHomeController extends GetxController {
  final _gardenRepository = Get.find<GardenRepository>();
  RxList<Garden> gardens = RxList<Garden>();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  // @override
  // void onInit() async {
  //   await getGardens();
  //   super.onInit();
  // }

  Future<bool?> getGardens() async {
    final int _accountId = AuthCredentials.instance.user!.id!;

    GetGardenRequest data = GetGardenRequest(
      accountId: _accountId.toString(),
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: GardenSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    //load gardens

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        final _response = await _gardenRepository.getGardens(data);
        if (_response == null) {
          isLoading.value = false;
          return null;
        }

        gardens.addAll(_response.gardens!);
        //update hasNext
        _hasNextPage = _response.metadata!.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } on CustomException catch (e) {
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

    await getGardens();
  }
}
