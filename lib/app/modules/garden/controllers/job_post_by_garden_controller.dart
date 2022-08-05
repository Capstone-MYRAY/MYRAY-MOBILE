import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';

class JobPostByGardenController extends GetxController {
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _gardenId = Get.arguments[Arguments.item];
  RxList<JobPost> jobPosts = RxList();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final isLoading = false.obs;

  Future<bool?> getJobPosts() async {
    final int accountId = AuthCredentials.instance.user!.id!;
    final data = GetRequestJobPostList(
      publishBy: accountId.toString(),
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: JobPostSortColumn.createdDate,
      orderBy: SortOrder.descending,
      gardenId: _gardenId.toString(),
    );

    //load job post
    isLoading.value = true;

    if (_hasNextPage) {
      final response = await _jobPostRepository.getLandownerJobPostList(data);
      if (response == null || response.jobPosts!.isEmpty) {
        isLoading.value = false;
        return null;
      }

      jobPosts.addAll(response.jobPosts!);
      //update hasNext
      _hasNextPage = response.metadata!.hasNextPage;
    }
    isLoading.value = false;
    return true;
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;

    //clear job post list
    jobPosts.clear();

    update();
  }
}
