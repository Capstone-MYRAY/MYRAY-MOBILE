import 'package:get/get.dart';
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

  @override
  void onInit() async {
    super.onInit();
    await getListJobPost();
  }

  GetRequestJobPostList data =
      GetRequestJobPostList(status: "2", page: "1", pageSize: "5");

  getListJobPost() async {
    JobPostResponse? response = await _repository.getJobPostList(data);

    if (response != null) {
      print(response.listJobPost.length);
      listJobPost.value = response.listJobPost;
    }
  }

  navigateToDetailPage(Rx<JobPost> jobPost){
    Get.toNamed(Routes.farmerJobPostDetail, arguments: {Arguments.item : jobPost});
  }
}
