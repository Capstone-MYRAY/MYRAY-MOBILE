
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/modules/history_job/history_job_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class FarmerHistoryJobController extends GetxController{

  final HistoryJobRepository _historyJobRepository = Get.find<HistoryJobRepository>();
  
  final int _pageSize = 5;
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;
  bool isPayPerhour = true;

   RxList<AppliedJobResponse> historyJobPostList =
      RxList<AppliedJobResponse>();

  Future<bool?> getHistoryJobList() async {
    GetAppliedJobPostList? list;
    GetAppliedJobRequest data = GetAppliedJobRequest(
      startWork: "2",//job done
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
    );

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        list = await _historyJobRepository.getAppliedJobList(data);
        print(list == null);
        if (list == null) {
          isLoading.value = false;
          return null;
        }
        historyJobPostList.addAll(list.listObject ?? []);
        _hasNextPage = list.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      return true;
    } on CustomException catch (e) {
      print(e.message);
      isLoading.value = false;
      _hasNextPage = false;
    }
    return null;
  }

  Future<void> onRefresh() async {
    _currentPage = 0;
    _hasNextPage = true;

    historyJobPostList.clear();
    await getHistoryJobList();
  }
}