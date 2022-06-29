import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/auth/job_post_response.dart';
import 'package:myray_mobile/app/data/models/job_post/get_request_job_post_list.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';

class FarmerHomeController extends GetxController {
  final _repository = Get.find<JobPostRepository>();
  late int page = 1;
  late int page_size = 5;
  var listJobPost = [].obs;
  var isExpired = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() async {
    await getListJobPost();
    super.onInit();   
  }

  getExpiredDate(DateTime publishedDate, int numberPublishDate) {
    var publishDate = publishedDate.toLocal();
    var expiredDate = DateTime(publishDate.year, publishDate.month,
        publishDate.day + numberPublishDate);
        return expiredDate;
  }

  checkExpiredDate(DateTime expiredDate){
    var now = DateTime.now().toLocal();
    if(now.compareTo(expiredDate) > 0){
      return true;
    }
    return false;
  }

  GetRequestJobPostList data =
      GetRequestJobPostList(status: "2", page: "1", pageSize: "5");

  getListJobPost() async {
    isLoading.value = true;
    JobPostResponse? response = await _repository.getJobPostList(data);

    if (response != null) {
      print("Số lượng load: " + response.listJobPost.length.toString());
      listJobPost.value = response.listJobPost;
      isLoading.value = false;
    }
  }

  navigateToDetailPage(Rx<JobPost> jobPost) {
    Get.toNamed(Routes.farmerJobPostDetail,
        arguments: {Arguments.item: jobPost});
  }
}
