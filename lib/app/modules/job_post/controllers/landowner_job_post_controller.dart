import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class LandownerJobPostController extends GetxController {
  final _jobPostRepository = Get.find<JobPostRepository>();
  RxList<JobPost> jobPosts = RxList();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  // @override
  // void onInit() async {
  //   await getJobPosts();
  //   super.onInit();
  // }

  Future<bool?> getJobPosts() async {
    final int _accountId = AuthCredentials.instance.user!.id!;
    final _data = GetRequestJobPostList(
      publishBy: _accountId.toString(),
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: JobPostSortColumn.createdDate,
      orderBy: SortOrder.descending,
    );

    //load job post
    isLoading.value = true;

    if (_hasNextPage) {
      final _response = await _jobPostRepository.getLandownerJobPostList(_data);
      if (_response == null || _response.jobPosts!.isEmpty) {
        isLoading.value = false;
        return null;
      }

      jobPosts.addAll(_response.jobPosts!);
      //update hasNext
      _hasNextPage = _response.metadata!.hasNextPage;
    }
    isLoading.value = false;
    return true;
  }

  navigateToCreateForm() {
    Get.toNamed(Routes.jobPostForm, arguments: {
      Arguments.action: Activities.create,
    });
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;

    //clear job post list
    jobPosts.clear();

    await getJobPosts();
  }
}
