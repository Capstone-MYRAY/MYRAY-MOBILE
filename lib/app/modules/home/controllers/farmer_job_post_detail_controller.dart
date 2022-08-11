import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/services/applied_job_service.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/modules/bookmark/bookmark_repository.dart';
import 'package:myray_mobile/app/modules/job_post/job_post_repository.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/data/models/job_post/farmer_job_post_detail_response.dart';

class FarmerJobPostDetailController extends GetxController with MessageService, AppliedJobService {
  final _jobPostRepository = Get.find<JobPostRepository>();
  final _accountRepository = Get.find<ProfileRepository>();
  final _bookmarkRepository = Get.find<BookmarkRepository>();
  final JobPost jobPost;
  final isApplied = false.obs;
  final isAppliedHourJob = false.obs;
  Rx<FarmerJobPostDetailResponse>? detailPost;
  Rx<Account>? landownerAccount;
  Rx<bool> isBookmark = false.obs;
  RxBool isFullApplyRequestJob = false.obs;

  FarmerJobPostDetailController({required this.jobPost});

  @override
  void onInit() async {
    super.onInit();
    _getLanownerAccount(jobPost.publishedBy);
    _checkFarmerAppliedOrNot(jobPost.id);
    // checkAppliedHourJob();
    checkBookmark(jobPost.publishedBy);
    checkNumOfAppliedJob();
  }

  void navigateToChatScreen() {
    print('Im here');
    final fromId = AuthCredentials.instance.user?.id ?? 0;
    final toId = landownerAccount?.value.id ?? 0;
    final jobPostId = jobPost.id;

    navigateToP2PMessageScreen(
      fromId,
      toId,
      jobPostId,
      landownerAccount?.value.fullName ?? '',
      jobPost.title,
      toAvatar: landownerAccount?.value.imageUrl,
    );
  }

  Future<FarmerJobPostDetailResponse?> getJobPostDetail() async {
    //call api
    final FarmerJobPostDetailResponse? post =
        await _jobPostRepository.getFarmerJobPostdDetail(jobPost.id);
    print("object: ${post!.type}");
    return post;
  }

  _getLanownerAccount(int landownerId) async {
    await _accountRepository.getUser(landownerId).then(
          (value) => {
            if (value != null)
              {
                landownerAccount = value.obs,
              },
          },
        );
  }

  //Check farmer apply to hour job or not
  checkAppliedHourJob() async {
    final isApplied = await _jobPostRepository.checkAppliedHourJob();
    isAppliedHourJob(isApplied);
    isAppliedHourJob.value
        ? print("Đã ứng tuyển một job công khác ? ")
        : print('Chưa ứng tuyển');
  }

  //check the num of applied job is 5 or not.
  checkNumOfAppliedJob() async {
    int? numOfAppliedJobList = await checkAmountAppliedJob();
    if(numOfAppliedJobList == CommonConstants.numOfAppliedJobList){
      isFullApplyRequestJob(true);
    }
  }

  getExpiredDate(DateTime publishedDate, int numberPublishDate) {
    var publishDate = publishedDate.toLocal();
    var expiredDate = DateTime(publishDate.year, publishDate.month,
        publishDate.day + numberPublishDate);
    return expiredDate;
  }

  checkExpiredDate(DateTime expiredDate) {
    var now = DateTime.now().toLocal();
    if (now.compareTo(expiredDate) > 0) {
      return true;
    }
    return false;
  }

  applyJob(int idJobPost) async {
    Get.back();
    await _jobPostRepository.applyJob(idJobPost).then(
          (result) => {
            if (result || result == null)
              {
                const LoadingBuilder(),
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
    _checkFarmerAppliedOrNot(idJobPost);
    print("Đã apply bài post có id $idJobPost");
  }

  //applied: false, not applied: true (200)
  _checkFarmerAppliedOrNot(int jobPostId) async {
    final result = await _jobPostRepository.checkFarmerAppliedOrNot(jobPostId);
    isApplied(result);
    print(isApplied.value ? 'applied' : 'not applied');
  }

  bookmarkAccount(int accountId) async {
    if (accountId == -1) {
      return;
    }
    bool? result = await _bookmarkRepository.bookmarkAccount(accountId);
    if (result != null && result) {
      isBookmark.value = true;
      //show Toast message
    } else {
      isBookmark.value = false;
      await _bookmarkRepository.unBookmarkAccount(accountId);
    }
    //chưa có check bookmark or not
  }

  //check is like
  checkBookmark(int accountId) async {
    final result = await _bookmarkRepository.checkBookmark(accountId);
    if (result == null) {
      isBookmark.value = false;
    } else if (result) {
      isBookmark.value = true;
    } else {
      isBookmark.value = false;
    }
  }
}
