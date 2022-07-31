import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/data/enums/sort.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/post_type/post_type_models.dart';
import 'package:myray_mobile/app/data/services/post_type_repository.dart';
import 'package:myray_mobile/app/modules/garden/garden_repository.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';

class LandownerJobPostController extends GetxController {
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _postTypeRepository = Get.find<PostTypeRepository>();
  RxList<JobPost> jobPosts = RxList();
  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasNextPage = true;

  final List<FilterObject> postTypeList = [
    FilterObject(name: 'Tất cả', value: null)
  ];

  final titleController = TextEditingController();
  String titleFilter = '';
  String? workTypeFilter;
  int? postTypeFilter;
  int? postStatusFilter;
  int? workStatusFilter;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPostType();
  }

  onApplyFilter() {
    onRefresh(isFilter: true);
    Get.back(); //close filter screen
  }

  onClearFilter() {
    workTypeFilter = null;
    postTypeFilter = null;
    postStatusFilter = null;
    workStatusFilter = null;
  }

  _loadPostType() async {
    GetPostTypeRequest data = GetPostTypeRequest(
      page: 1.toString(),
      pageSize: 100.toString(),
      sortColumn: PostTypeSortColumn.price,
      orderBy: SortOrder.ascending,
    );

    final responseData = await _postTypeRepository.getList(data);

    if (responseData != null && responseData.postTypes != null) {
      final List<PostType> postTypes = responseData.postTypes!;
      List<FilterObject> types = postTypes
          .map((type) => FilterObject(name: type.name, value: type.id))
          .toList();
      postTypeList.addAll(types);
    }
  }

  void updateJobPosts(JobPost jobPost) {
    int index = jobPosts.indexWhere((e) => e.id == jobPost.id);
    if (index >= 0) {
      jobPosts[index] = jobPost;
    }
  }

  Future<bool?> getJobPosts() async {
    final int accountId = AuthCredentials.instance.user!.id!;
    final data = GetRequestJobPostList(
      publishBy: accountId.toString(),
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: JobPostSortColumn.createdDate,
      orderBy: SortOrder.descending,
      status: postStatusFilter?.toString(),
      workStatus: workStatusFilter?.toString(),
      type: workTypeFilter,
      postTypeId: postTypeFilter?.toString(),
      title: titleFilter.isEmpty ? null : titleFilter,
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

  navigateToCreateForm() async {
    //check if there is any garden or not
    final gardenRepository = Get.find<GardenRepository>();
    final data = GetGardenRequest(
      accountId: AuthCredentials.instance.user!.id.toString(),
      page: 1.toString(),
      pageSize: 1.toString(),
    );
    final GetGardenResponse? response = await gardenRepository.getGardens(data);
    if (response != null && response.gardens!.isNotEmpty) {
      Get.toNamed(Routes.jobPostForm, arguments: {
        Arguments.action: Activities.create,
      });
      return;
    }

    InformationDialog.showDialog(
      msg:
          'Bạn chưa có vườn nào.\nVui lòng vào Hồ sơ -> Vườn của tôi để tạo vườn trước',
      confirmTitle: AppStrings.titleClose,
    );
  }

  Future<void> onRefresh({bool isFilter = false}) async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextPage = true;

    //clear job post list
    jobPosts.clear();

    if (!isFilter) {
      //load user info
      final profile = Get.find<LandownerProfileController>();
      profile.getUserInfo();
    }

    update();
  }
}
