import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_models.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_response.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback_models.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/report/get_report_request.dart';
import 'package:myray_mobile/app/data/models/report/get_report_response.dart';
import 'package:myray_mobile/app/data/models/report/post_report_request.dart';
import 'package:myray_mobile/app/data/models/report/put_update_report_request.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/data/services/feedback_service.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/feedback_dialog.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/feedback_update_dialog.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/report_update_dialog.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/report_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_information.dialog.dart';

class FarmerHistoryJobDetailController extends GetxController
    with BookmarkService, ReportService, FeedBackService {
  Rx<AppliedJobResponse> appliedJob;
  FarmerHistoryJobDetailController({required this.appliedJob});
  final _attendanceRepository = Get.find<AttendanceRepository>();
  RxList<AttendanceResponse> attendanceList = RxList<AttendanceResponse>();

  late JobPost jobPost = appliedJob.value.jobPost;
  late bool isPayPerHourJob = jobPost.type == 'PayPerHourJob';
  late bool isFired = appliedJob.value.status == 4;
  late RxDouble totalSalary = 0.0.obs;
  late RxBool isBookmark = false.obs;
  late String? firedReason = '';

  late GlobalKey<FormState> formKey;
  late TextEditingController reportContentController;
  late TextEditingController feedbackContentController;
  late TextEditingController feedbackRatingController;

  @override
  void onInit() async {
    await getAttendanceByJob();
    await _checkBookmark();
    formKey = GlobalKey<FormState>();
    reportContentController = TextEditingController();
    feedbackContentController = TextEditingController();
    feedbackRatingController = TextEditingController();
    super.onInit();
  }

  //attendance
  getAttendanceByJob() async {
    GetAttendanceRequest data = GetAttendanceRequest(
        accountId: AuthCredentials.instance.user!.id.toString(),
        jobPostId: jobPost.id.toString());
    try {
      List<AttendanceResponse>? loadList =
          await _attendanceRepository.getAttendanceList(data);
      if (loadList == null) {
        return null;
      }

      if (loadList.isEmpty) {
        return [];
      }
      if (attendanceList.isNotEmpty) {
        return;
      }
      attendanceList.addAll(loadList.reversed);
      firedReason = attendanceList.first.reason;
      await _getTotalSalary();
    } on CustomException catch (e) {
      print("In attendance farmer controller: ${e.message}");
    }
    return null;
  }

  _getTotalSalary() async {
    for (var attendance in attendanceList) {
      totalSalary.value = totalSalary.value + attendance.salary;
    }
  }

  Attendance getAttentdance(AttendanceResponse data) {
    Attendance attendance = Attendance(
      id: data.id,
      date: data.date,
      bonusPoint: data.bonusPoint,
      reason: data.reason,
      salary: data.salary,
      signature: data.signature,
      status: data.status,
      appliedJobId: data.appliedJobId,
      accountId: data.accountId,
    );
    return attendance;
  }

  //end attendance

  //bookmark
  _checkBookmark() async {
    isBookmark.value = await isBookMark(jobPost.publishedBy);
  }

  onBookmark() {
    if (isBookmark.value) {
      unBookmark(jobPost.publishedBy);
      isBookmark(false);
      return;
    }
    bookmark(jobPost.publishedBy);
    isBookmark(true);
  }
  //end bookmark

  //report
  onReport() async {
    //get report
    Report? currentReport;
    bool isReported = false;
    bool isResolved = false;

    try {
      GetReportRequest data = GetReportRequest(
          jobPostId: jobPost.id.toString(),
          createdBy: AuthCredentials.instance.user!.id.toString(),
          page: "1",
          pageSize: '20');
      GetReportResponse? report = await getReport(data);
      if (_canUpdateOrCreate(jobPost.jobEndDate)) {
        if (report != null && report.listObject != null) {
          if (report.listObject!.isNotEmpty) {
            currentReport = report.listObject?.first;

            //reported
            if (currentReport != null) {
              reportContentController.text = currentReport.content;
              isReported = true;
              isResolved = currentReport.resolvedBy != null;
              if (isResolved) {
                ReportUpdateDialog.show(
                    newReport: currentReport, title: 'Báo cáo');
                return;
              }
            }
          }
          ReportDialog.show(
            jobPostId: jobPost.id,
            formKey: formKey,
            reportContentController: reportContentController,
            validateReason: validateReason,
            submit: (_) => _onSubmitReport(currentReport),
            closeDialog: _onCloseReportDialog,
            isResovled: isResolved,
            isReported: isReported,
          );
        }
        return;
      }
      if (currentReport != null) {
        ReportUpdateDialog.show(newReport: currentReport, title: 'Báo cáo');
      }
      CustomInformationDialog.show(
          title: 'Báo cáo', message: 'Đã hết hạn báo cáo');
      return;
    } on CustomException catch (e) {
      print('>>Report in history detail: ${e.message}');
    }
  }

  _onCloseReportDialog() {
    reportContentController.clear();
    Get.back();
  }

  _onSubmitReport(Report? currentReport) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (currentReport != null) {
      await _onUpdateReport(currentReport);
      return;
    }
    await _onCreateReport();
  }

  _onUpdateReport(Report currentReport) async {
    PutUpdateReportRequest data = PutUpdateReportRequest(
      id: currentReport.id,
      jobPostId: jobPost.id,
      content: reportContentController.text,
      reportedId: currentReport.reportedId!,
    );
    EasyLoading.show();
    try {
      Report? newReport = await updateReport(data);
      Future.delayed(const Duration(milliseconds: 1200), () {
        _onCloseReportDialog();
        EasyLoading.dismiss();
        if (newReport != null) {
          ReportUpdateDialog.show(newReport: newReport);
          return;
        }
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi báo cáo không thành công",
            backgroundColor: AppColors.errorColor);
      });
    } on CustomException catch (e) {
      EasyLoading.dismiss();
      print(e);
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Không thể gửi báo cáo",
          backgroundColor: AppColors.errorColor);
    }
  }

  _onCreateReport() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
print("content: ${reportContentController.text}");

    EasyLoading.show();
    try {
      PostReportRequest data = PostReportRequest(
          content: reportContentController.text,
          jobPostId: jobPost.id,
          reportedId: jobPost.publishedBy);

      Report? result = await reportJob(data);
      _onCloseReportDialog();
      EasyLoading.dismiss();
      if (result == null) {
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi báo cáo không thành công",
            backgroundColor: AppColors.errorColor);
        return;
      }
      CustomSnackbar.show(
          title: "Thành công", message: "Gửi báo cáo thành công");
    } on CustomException catch (e) {
      print('Error in report of hitory job: ${e.message}');
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Đã có lỗi xảy ra",
          backgroundColor: AppColors.errorColor);
    }
  }

  //end report

  //feedback

  onFeedback() async {
    FeedBack? currentFeedback;
    bool isFeedbacked = false;
    DateTime? endDate;

    GetFeedbackRequest data = GetFeedbackRequest(
      page: '1',
      pageSize: '20',
      jobPostId: jobPost.id.toString(),
      createdBy: AuthCredentials.instance.user!.id.toString(),
    );
    try {
      GetFeedBackResponse? feedBack = await getFeedback(data);
      if (_canUpdateOrCreate(jobPost.jobEndDate)) {
        if (feedBack != null && feedBack.listObject != null) {
          if (feedBack.listObject!.isNotEmpty) {
            currentFeedback = feedBack.listObject?.first;
            //hết hạn feedback: sau 3 ngày, kể từ ngày đăng ký
            if (currentFeedback != null) {
              feedbackContentController.text = currentFeedback.content;
              feedbackRatingController.text =
                  currentFeedback.numStar.toString();
              isFeedbacked = true;
            }
          }
        }
        FeedbackDialog.show(
            jobPostId: jobPost.id,
            formKey: formKey,
            feedbackRatingController: feedbackRatingController,
            feedbackContentController: feedbackContentController,
            submit: (_) => _onSubmitFeedback(currentFeedback),
            validateReason: validateReason,
            closeDialog: _onCloseFeedbackDialog,
            isFeedbacked: isFeedbacked,
            initialRating: currentFeedback != null
                ? (currentFeedback.numStar + 0.0)
                : 1.0);
        return;
      }
      if (currentFeedback == null) {
        CustomInformationDialog.show(
            title: 'Đánh giá', message: 'Đã hết hạn đánh giá');
        return;
      }
      FeedBackUpdateDialog.show(
          newFeedBack: currentFeedback, title: 'Đánh giá');
    } on CustomException catch (e) {
      print('error in Feedback: $e');
    }
  }

  _onSubmitFeedback(FeedBack? feedback) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (feedback != null) {
      await _onUpdateFeedback(feedback);
      return;
    }

    await _onCreateFeedback();
  }

  _onUpdateFeedback(FeedBack currentFeedback) async {
    PutFeedbackRequest data = PutFeedbackRequest(
      id: currentFeedback.id,
      content: feedbackContentController.text,
      numStar: num.parse(feedbackRatingController.text),
      jobPostId: jobPost.id,
      belongedId: currentFeedback.belongedId,
    );
    EasyLoading.show();
    _onCloseFeedbackDialog();
    try {
      FeedBack? newFeedBack = await updateFeedback(data);
      Future.delayed(const Duration(milliseconds: 1200), () {
        EasyLoading.dismiss();
        if (newFeedBack != null) {
          FeedBackUpdateDialog.show(
            newFeedBack: newFeedBack,
          );
          return;
        }
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi đánh giá không thành công",
            backgroundColor: AppColors.errorColor);
      });
    } on CustomException catch (e) {
      EasyLoading.dismiss();

      print('$e');
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Không thể gửi đánh giá !",
          backgroundColor: AppColors.errorColor);
    }
  }

  _onCreateFeedback() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    PostFeedbackRequest data = PostFeedbackRequest(
      content: feedbackContentController.text,
      numStar: feedbackRatingController.text != '5'
          ? int.parse(feedbackRatingController.text)
          : 5,
      jobPostId: jobPost.id,
      belongedId: jobPost.publishedBy,
    );

    try {
      FeedBack? feedback = await sendFeedBack(data);
      EasyLoading.show();
      _onCloseFeedbackDialog();

      if (feedback != null) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          EasyLoading.dismiss();
          CustomSnackbar.show(
              title: "Thành công", message: "Gửi đánh giá thành công");
        });

        return;
      }

      CustomSnackbar.show(
          title: "Thất bại",
          message: "Gửi đánh giá không thành công",
          backgroundColor: AppColors.errorColor);
    } on CustomException catch (e) {
      print('Đánh giá xảy ra lỗi: $e');
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Gửi đánh giá không thành công",
          backgroundColor: AppColors.errorColor);
    }
  }

  _onCloseFeedbackDialog() {
    feedbackContentController.clear();
    feedbackRatingController.clear();
    Get.back();
  }
  //end feedback

  _canUpdateOrCreate(DateTime? endDate) {
    return endDate == null ||
        DateTime.now().isBefore(endDate
            .add(const Duration(days: CommonConstants.dayCanEditFeedback)));
  }
}
