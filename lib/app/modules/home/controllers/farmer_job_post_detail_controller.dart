

import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';

class FarmerJobPostDetailController extends GetxController{
  final _jobPostRepository = Get.find<JobPostRepository>();
  final JobPost jobPost;
  RxBool isAppliedDone = false.obs;

  FarmerJobPostDetailController({required this.jobPost});



  applyJob (int idJobPost) async {
    //  await _jobPostRepository.applyJob(idJobPost);
    print("Đã apply bài post có id $idJobPost");     
    isAppliedDone.value = true;
  }
  

}