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
      if (feedback.value == null) {
        final data = PostFeedbackRequest(
          content: content,
          numStar: ratedStar.toInt(),
          jobPostId: appliedFarmer.value.jobPost.id,
          belongedId: appliedFarmer.value.userInfo.id!,
        );

        submittedFeedback = await _feedbackRepository.sendFeedBack(data);
      } else {
        final data = PutFeedbackRequest(
          id: feedback.value!.id,
          content: content,
          numStar: ratedStar.toInt(),
          jobPostId: appliedFarmer.value.jobPost.id,
          belongedId: appliedFarmer.value.userInfo.id!,
        );

        submittedFeedback = await _feedbackRepository.updateFeedback(data);
      }

      if (submittedFeedback == null) throw CustomException('Có lỗi xảy ra');

      //update ui
      feedback.value = submittedFeedback;

      EasyLoading.dismiss();
      Get.back(); //close dialog

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: 'Gửi đánh giá thành công',
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
      final submittedReport = await _reportRepository.report(data);

      if (submittedReport == null) throw CustomException('Có lỗi xảy ra');

      //update ui
      report.value = submittedReport;

      EasyLoading.dismiss();
      Get.back(); //close dialog

      CustomSnackbar.show(
        title: AppStrings.titleSuccess,
        message: 'Gửi báo cáo thành công',
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
      bool? success = await approveFarmer(appliedFarmer.value.id);

      //user cancel action
      if (success == null) return;

      if (success) {
        //update status
        appliedFarmer.value.status = AppliedFarmerStatus.approved.index;

        //update job farmer list
        _jobFarmerController.updateList(appliedFarmer.value);
        appliedFarmer.refresh();
      }
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
