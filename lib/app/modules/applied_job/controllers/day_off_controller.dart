import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/day_off/day_off.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class DayOffController extends GetxController {
  RxList<DayOff> dayOffList = RxList<DayOff>();
  final AppliedJobRepository _appliedJobRepository =
      Get.find<AppliedJobRepository>();
  final int currenUserId = AuthCredentials.instance.user!.id!;
  bool _hasNextPage = true;
  final isLoading = false.obs;


  getDayOffList() async {
    List<DayOff>? loadList;
    isLoading.value = true;
    try {
      if(_hasNextPage){  
      loadList = await _appliedJobRepository.getDayOff();
        if (loadList == null) {
          isLoading.value = false;
          return null;
        }
        dayOffList.addAll(loadList.where((element) => element.accountId == currenUserId).toList());
         print('Số đơn nghỉ: ${dayOffList.length}');
        _hasNextPage = false;
      
      }
      isLoading.value = false;
      return true;
    } on CustomException catch (e) {
      isLoading.value = false;
      print('day off controller: ${e.message}');
      EasyLoading.showError('Đã có lỗi xảy ra');
    }
    return null;
  }

  Future<void> onRefresh() async {
    _hasNextPage = true;
    dayOffList.clear();
    await getDayOffList();
  }
}
