import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/auth/job_post_response.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';

class FarmerHomeController extends GetxController {
  final _repository = Get.find<JobPostRepository>();
  late int page = 1;
  late int page_size = 20;
  var listJobPost = [].obs;

  @override
  void onInit() async {
    super.onInit();
    await getListJobPost();
  }

  getListJobPost() async {
    JobPostResponse? response =
        await _repository.getJobPostList(page, page_size);

    if (response != null) {
      print(response.listJobPost.length);
      listJobPost.value = response.listJobPost;
    }
  }
}
