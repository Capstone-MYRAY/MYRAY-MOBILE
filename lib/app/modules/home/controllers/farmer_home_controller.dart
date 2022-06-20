import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/repositories/farmer_jobpost_repository.dart';
import '../../../data/models/response/job_post_response.dart';

class FarmerHomeController extends GetxController {
  final _repository = Get.find<FarmerJobPostRepository>();
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
