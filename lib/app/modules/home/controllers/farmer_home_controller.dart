import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post_response.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';

class FarmerHomeController extends GetxController {
  final _repository = Get.find<JobPostRepository>();
  late int page = 1;
  late int page_size = 5;
  // var listJobPost = [].obs;
  // var secondJobPost = [].obs;
  var isExpired = false.obs;
  //list of not pin post
  RxList<JobPost> listObject = RxList<JobPost>();
  //List of pin post
  RxList<JobPost> secondObject = RxList<JobPost>();
  int _currentPage = 0;
  final int _pageSize = 10;
  bool _hasNextpage = true;

  final isLoading = false.obs;

  @override
  void onInit() async {
    await getListJobPost();
    super.onInit();
  }

  getExpiredDate(DateTime publishedDate, int numberPublishDate) {
    var publishDate = publishedDate.toLocal();
    var expiredDate = DateTime(publishDate.year, publishDate.month,
        publishDate.day + numberPublishDate - 1);
    return expiredDate;
  }

  checkExpiredDate(DateTime expiredDate) {
    var now = DateTime.now().toLocal();
    if (now.compareTo(expiredDate) > 0) {
      return true;
    }
    return false;
  }

  getListJobPost() async {
    GetRequestJobPostList data = GetRequestJobPostList(
      status: "2",
      page: (++_currentPage).toString(),
      pageSize: (_pageSize).toString(),
      sortColumn: JobPostSortColumn.createdDate,
      orderBy: SortOrder.descending
    );

    isLoading.value = true;
    JobPostResponse? response = await _repository.getJobPostList(data);

    // if (response != null) {
    //   print("Số lượng load: " + response.listJobPost.length.toString());
    //   listJobPost.value = response.listJobPost;
    //   secondJobPost.value = response.secondObject!;
    //   isLoading.value = false;
    // }

    try{
      if(_hasNextpage){
        final _response = await _repository.getJobPostList(data);
        if(_response == null || _response.listJobPost.isEmpty){
          isLoading(false);
          return null;
        }
        listObject.addAll(_response.listJobPost);
        secondObject.addAll(_response.secondObject!);
        _hasNextpage = _response.pagingMetadata.hasNextPage;    
      }
      isLoading.value = false;
      return true;
    }on CustomException catch (e){
      isLoading.value = false;
      _hasNextpage = false;
      return null;
    }
  }

  Future<void> onRefresh() async {
    //reset current page & hasNext
    _currentPage = 0;
    _hasNextpage = true;

    //clear garden list
    listObject.clear();
    secondObject.clear();

    await getListJobPost();
  }
  //list Object: các bài đăng thường
  //second list object: các bài đăng đặc biệt

  navigateToDetailPage(Rx<JobPost> jobPost) {
    Get.toNamed(Routes.farmerJobPostDetail,
        arguments: {Arguments.item: jobPost});
  }
}
