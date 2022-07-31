import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/get_extend_end_date_job_list_response.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class FarmerInprogressJobController extends GetxController {
  final _appliedRepository = Get.find<AppliedJobRepository>();

  Rx<GetAppliedJobPostList>? inProgressJobList;
  RxList<AppliedJobResponse> inProgressJobPostList =
      RxList<AppliedJobResponse>();
  Rx<GetExtendEndDateJobList>? extendEndDateList;
  RxList<ExtendEndDateJob> listObject = RxList<ExtendEndDateJob>();

  final int _pageSize = 5;
  //paging progress list
  int _currentPage = 0;
  bool _hasNextPage = true;
  final isLoading = false.obs;

  Future<bool?> getInProgressJobList() async {
    GetAppliedJobPostList? list;
    GetAppliedJobRequest data = GetAppliedJobRequest(
      status: AppliedFarmerStatus.approved,
      startWork: "1",
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
    );

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        list = await _appliedRepository.getAppliedJobList(data);
        print(list == null);
        if (list == null) {
          isLoading.value = false;
          return null;
        }
        inProgressJobPostList.addAll(list.listObject ?? []);
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

    inProgressJobPostList.clear();
    await getInProgressJobList();
  }

  }

