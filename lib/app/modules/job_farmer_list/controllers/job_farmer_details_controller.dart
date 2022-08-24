import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback_models.dart';
import 'package:myray_mobile/app/data/models/report/report_models.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/feedback/feedback_repository.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/controllers/job_farmer_list_controller.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/widgets/feedback_dialog.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/widgets/report_dialog.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_controller.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/landowner_job_post_details_controller.dart';
import 'package:myray_mobile/app/modules/report/report_repository.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class JobFarmerDetailsController extends GetxController
    with AppliedFarmerService, MessageService, BookmarkService {
  final Rx<AppliedFarmer> appliedFarmer;
  final _jobFarmerController = Get.find<JobFarmerListController>();
  final _feedbackRepository = Get.find<FeedBackRepository>();
  final _reportRepository = Get.find<ReportRepository>();
  var isBookmarked = false.obs;
  Rx<FeedBack?> feedback = Rx(null);
  Rx<Report?> report = Rx(null);

  JobFarmerDetailsController({required this.appliedFarmer});

  Future<void> init() async {
    isBookmarked.value = await isBookMark(appliedFarmer.value.userInfo.id!);
    await getFeedback();
    await getReport();
  }

  onToggleBookmark() {
    try {
      if (isBookmarked.value) {
        unBookmark(appliedFarmer.value.userInfo.id!);
        isBookmarked.value = false;
      } else {
        bookmark(appliedFarmer.value.userInfo.id!);
        isBookmarked.value = true;
      }
    } catch (e) {
      print('Bookmark error: ${e.toString()}');
    }
  }

  void navigateToChatScreen() {
    final fromId = AuthCredentials.instance.user?.id ?? 0;
    final toId = appliedFarmer.value.userInfo.id ?? 0;
    final jobPostId = appliedFarmer.value.jobPost.id;
    final toAvatar = appliedFarmer.value.userInfo.imageUrl;
    navigateToP2PMessageScreen(
      fromId,
      toId,
      jobPostId,
      appliedFarmer.value.userInfo.fullName ?? '',
      appliedFarmer.value.jobPost.title,
      toAvatar: toAvatar,
    );
  }

  Future<void> getFeedback() async {
    final data = GetSpecificFeedbackRequest(
      jobPostId: appliedFarmer.value.jobPost.id.toString(),
      belongedId: appliedFarmer.value.userInfo.id.toString(),
      createdById: AuthCredentials.instance.user!.id.toString(),
    );

    feedback.value = await _feedbackRepository.getSpecificFeedback(data);
  }

  Future<void> getReport() async {
    final data = GetSpecificReportRequest(
      jobPostId: appliedFarmer.value.jobPost.id.toString(),
      reportedId: appliedFarmer.value.userInfo.id.toString(),
      createdById: AuthCredentials.instance.user!.id.toString(),
    );

    report.value = await _reportRepository.getSpecificReport(data);
  }

  onFeedback() {
    FeedbackDialog.show(_onFeedback, feedback: feedback.value);
  }

  _onFeedback(double ratedStar, String content) async {
    try {
      EasyLoading.show();
      FeedBack? submittedFeedback;
      String successMsg = '';
      if (feedback.value == null) {
        final data = PostFeedbackRequest(
          content: content,
          numStar: ratedStar.toInt(),
          jobPostId: appliedFarmer.value.jobPost.id,
          belongedId: appliedFarmer.value.userInfo.id!,
        );

        submittedFeedback = await _feedbackRepository.sendFeedBack(data);
        successMsg = AppMsg.MSG5003;
      } else {
        final data = PutFeedbackRequest(
          id: feedback.value!.id,
          content: content,
          numStar: ratedStar.toInt(),
          jobPostId: appliedFarmer.value.jobPost.id,
          belongedId: appliedFarmer.value.userInfo.id!,
        );

        submittedFeedback = await _feedbackRepository.updateFeedback(data);
        successMsg = AppMsg.MSG5010;
      }

      if (submittedFeedback == null) throw CustomException('Có lỗi xảy ra');

      //update star
      if (feedback.value == null) {
        if (appliedFarmer.value.userInfo.rating == null ||
            appliedFarmer.value.userInfo.rating == 0) {
          appliedFarmer.value.userInfo.rating =
              submittedFeedback.numStar.toDouble();
        } else {
          double newRating = (appliedFarmer.value.userInfo.rating! +
                  submittedFeedback.numStar.toDouble()) /
              2;
          appliedFarmer.value.userInfo.rating = newRating;
        }
      } else {
        double newRating =
            appliedFarmer.value.userInfo.rating! - feedback.value!.numStar;
        if (newRating == 0) {
          newRating += submittedFeedback.numStar;
        } else {
          newRating += submittedFeedback.numStar;
          newRating /= 2;
        }
        appliedFarmer.value.userInfo.rating = newRating;
      }

      //update ui
      feedback.value = submittedFeedback;

      appliedFarmer.refresh();

      //update job farmer list
      _jobFarmerController.updateAppliedFarmer(appliedFarmer.value);

      EasyLoading.dismiss();
      Get.back(); //close dialog

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: successMsg,
      );
    } catch (e) {
      print('Feedback error: ${e.toString()}');
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  onReport() {
    ReportDialog.show(_onReport);
  }

  _onReport(String reportReason) async {
    final data = PostReportRequest(
      jobPostId: appliedFarmer.value.jobPost.id,
      reportedId: appliedFarmer.value.userInfo.id,
      content: reportReason,
    );

    try {
      EasyLoading.show();
      final submittedReport = await _reportRepository.report(data);

      if (submittedReport == null) throw CustomException('Có lỗi xảy ra');

      //update ui
      report.value = submittedReport;

      EasyLoading.dismiss();
      Get.back(); //close dialog

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: AppMsg.MSG4041,
      );
    } catch (e) {
      print('Report error: ${e.toString()}');
      EasyLoading.dismiss();
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  onApprove() async {
    try {
      bool approvable = canApprove(appliedFarmer.value.jobPost);

      if (!approvable) {
        throw CustomException(
            'Công việc này đã đủ người, không thể nhận thêm.');
      }

      int? jobPostStatus = await approveFarmer(appliedFarmer.value.id);

      //user cancel action
      if (jobPostStatus == null) throw Exception('Có lỗi xảy ra');

      if (jobPostStatus == 0) return;

      //update job post status
      if (jobPostStatus == JobPostStatus.enough.index) {
        final jobPostController = Get.find<LandownerJobPostController>();
        jobPostController.updateJobPosts(
            appliedFarmer.value.jobPost..status = jobPostStatus);
      }

      //update job post details
      final jobPostDetailsController =
          Get.find<LandownerJobPostDetailsController>(
              tag: appliedFarmer.value.jobPost.id.toString());
      jobPostDetailsController.updateJobPostStatus(jobPostStatus);

      //update status
      appliedFarmer.value.status = AppliedFarmerStatus.approved.index;
      appliedFarmer.refresh();

      //update approve farmer
      jobPostDetailsController.totalApprovedFarmer.value += 1;

      //update job farmer list
      _jobFarmerController.onRefresh();
    } catch (e) {
      print('onApproveError: ${e.toString()}');
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }

  onReject() async {
    try {
      bool? success = await rejectFarmer(appliedFarmer.value.id);

      //user cancel action
      if (success == null) return;

      if (!success) throw Exception('Có lỗi xảy ra');

      //update status
      appliedFarmer.value.status = AppliedFarmerStatus.rejected.index;

      //update job farmer list
      _jobFarmerController.updateList(appliedFarmer.value);
      appliedFarmer.refresh();
    } catch (e) {
      print('onRejectError: ${e.toString()}');
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Có lỗi xảy ra',
        backgroundColor: AppColors.errorColor,
      );
    }
  }
}
