import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';

class LandownerJobPostDetailsController extends GetxController {
  final Rx<JobPost> jobPost;

  LandownerJobPostDetailsController({required this.jobPost});

  @override
  void onInit() {
    print('init');

    super.onInit();
  }
}
