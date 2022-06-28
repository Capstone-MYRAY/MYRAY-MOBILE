

import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';

class FarmerJobPostDetailController extends GetxController{
  final _jobPostRepository = Get.find<JobPostRepository>();
  final JobPost jobPost;

  FarmerJobPostDetailController({required this.jobPost});

  

}