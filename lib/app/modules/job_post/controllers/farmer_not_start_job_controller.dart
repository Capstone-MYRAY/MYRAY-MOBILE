import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_request.dart';
import 'package:myray_mobile/app/data/models/applied_job/get_applied_job_response.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class FarmerNotStartJobController extends GetxController {
  
  final _appliedRepository = Get.find<AppliedJobRepository>();
   Rx<GetAppliedJobPostList>? notStartJobList;
   RxList<AppliedJobResponse> notStartJobPostList =
      RxList<AppliedJobResponse>();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;
  final isLoading = false.obs;

  Future<bool?> getNotStartJobList() async {
    GetAppliedJobPostList? list;
    GetAppliedJobRequest data = GetAppliedJobRequest(
      status: AppliedFarmerStatus.approved,
      startWork: "0",
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
    );

    isLoading.value = true;
    try {
      if (_hasNextPage) {
        list = await _appliedRepository.getAppliedJobList(data);
        // isRefresh(true);
        print(list == null);
        if (list == null) {
          isLoading.value = false;
          return null;
        }
        notStartJobPostList.addAll(list.listObject ?? []);
        _hasNextPage = list.pagingMetadata!.hasNextPage;
      }
      isLoading.value = false;
      // isRefresh(false);
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

    notStartJobPostList.clear();
    await getNotStartJobList(); 
  }

  cancelAppliedJob(int jobPostId) async {
    Get.back();
    await _appliedRepository.cancelAppliedJob(jobPostId).then((result) => {
          if (result!)
            {
              CustomSnackbar.show(
                  title: "Thành công", message: "Hủy yêu cầu thành công"),
              notStartJobPostList.removeWhere((appliedJob) => appliedJob.jobPost.id == jobPostId),            
            }
          else
            {
              CustomSnackbar.show(
                  title: "Thất bại",
                  message: "Hủy yêu cầu không thành công",
                  backgroundColor: AppColors.errorColor),
            }
        });
  }
}
