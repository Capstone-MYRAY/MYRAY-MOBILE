import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/data/models/job_post/farmer_job_post_detail_response.dart';

class FarmerJobPostDetailController extends GetxController {
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _accountRepository = Get.find<ProfileRepository>();
  final JobPost jobPost;
  final check = false.obs;
  Rx<FarmerJobPostDetailResponse>? detailPost;
  Rx<Account>? landownerAccount;

  FarmerJobPostDetailController({required this.jobPost});

  @override
  void onInit() async {
    //get job post detail
    super.onInit();
    // getJobPostDetail();
    _getLanownerAccount(jobPost.publishedBy);
  }

  Future<FarmerJobPostDetailResponse?> getJobPostDetail() async {
    //call api
    final FarmerJobPostDetailResponse? post =
        await _jobPostRepository.getFarmerJobPostdDetail(jobPost.id);
    return post;
  }

   _getLanownerAccount(int landownerId) async {
    await _accountRepository.getUser(landownerId).then((value) => {
      if(value != null){
        landownerAccount = value.obs,       
      },        
    },); 
  }

  applyJob(int idJobPost) async {
    Get.back();
    await _jobPostRepository.applyJob(idJobPost).then(
          (result) => {
            if (result)
              {
                CustomSnackbar.show(
                    title: "Thành công", message: AppMsg.MSG3006),
              }
            else
              {
                CustomSnackbar.show(
                    title: "Thất bại",
                    message: AppMsg.MSG3007,
                    backgroundColor: AppColors.errorColor),
              }
          },
        );
    check.value = true;
    update();
    print("Đã apply bài post có id $idJobPost");
  }
}
