
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post_response.dart';
import 'package:myray_mobile/app/modules/history_job/history_job_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class FarmerHistoryJobController extends GetxController{

  final HistoryJobRepository _historyJobRepository = Get.find<HistoryJobRepository>();
  
  final int _pageSize = 5;
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;
  bool isPayPerhour = true;

   RxList<JobPost> historyJobPostList =
      RxList<JobPost>();

  Future<bool?> getHistoryJobList() async {
    JobPostResponse? list;
    GetAppliedJobRequest data = GetAppliedJobRequest(
      status: AppliedFarmerStatus.approved,
      startWork: "2",
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
    );

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        list = await _historyJobRepository.getHistoryJobPostList(data);
        print(list == null);
        if (list == null) {
          isLoading.value = false;
          return null;
        }
        historyJobPostList.addAll(list.listJobPost);
        _hasNextPage = list.pagingMetadata.hasNextPage;
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