import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class FarmerJobPostDetailController extends GetxController {
  final _jobPostRepository = Get.find<JobPostRepository>();
  final JobPost jobPost;
  final check = false.obs;

  FarmerJobPostDetailController({required this.jobPost});

  applyJob(int idJobPost) async {
    Get.back();
    // await _jobPostRepository.applyJob(idJobPost).then(
    //       (result) => {

    //         if (result)
    //           {
    //             CustomSnackbar.show(
    //                 title: "Thành công", message: AppMsg.MSG3006),
    //           }
    //         else
    //           {
    //             CustomSnackbar.show(title: "Thất bại", message: AppMsg.MSG3007, backgroundColor: AppColors.errorColor),
    //           }
            
    //       },
    //     );
    check.value= true;
    update();
    print("Đã apply bài post có id $idJobPost");
  }
}
