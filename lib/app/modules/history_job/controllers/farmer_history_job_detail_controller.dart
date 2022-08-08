import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_job/applied_job_response.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_models.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance_response.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/report/get_report_request.dart';
import 'package:myray_mobile/app/data/models/report/get_report_response.dart';
import 'package:myray_mobile/app/data/models/report/put_update_report_request.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/data/services/services.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/report_update_dialog.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/report_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class FarmerHistoryJobDetailController extends GetxController
    with BookmarkService, ReportService {
  Rx<AppliedJobResponse> appliedJob;
  FarmerHistoryJobDetailController({required this.appliedJob});
  final _attendanceRepository = Get.find<AttendanceRepository>();
  RxList<AttendanceResponse> attendanceList = RxList<AttendanceResponse>();

  late JobPost jobPost = appliedJob.value.jobPost;
  late bool isPayPerHourJob = jobPost.type == 'PayPerHourJob';
  late bool isFired = appliedJob.value.status == 4;
  late RxDouble totalSalary = 0.0.obs;
  late RxBool isBookmark = false.obs;

  late GlobalKey<FormState> formKey;
  late TextEditingController reportContentController;

  @override
  void onInit() async {
    await getAttendanceByJob();
    await _checkBookmark();
    formKey = GlobalKey<FormState>();
    reportContentController = TextEditingController();
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
    GetReportRequest data = GetReportRequest(
        jobPostId: jobPost.id.toString(),
        createdBy: AuthCredentials.instance.user!.id.toString(),
        page: "1",
        pageSize: '20');
    GetReportResponse? report = await getReport(data);
    if (report != null && report.listObject != null) {
      currentReport = report.listObject?.first;
      reportContentController.text = currentReport!.content;
      isReported = true;
    }
    if (currentReport != null) {
      isResolved = currentReport.resolvedBy != null;
    }
    ReportDialog.show(
      jobPostId: jobPost.id,
      formKey: formKey,
      reportContentController: reportContentController,
      validateReason: validateReason,
      submit: (_) => _onSubmit(isReported, currentReport),
      closeDialog: _onCloseReportDialog,
      isResovled: isResolved,
      isReported: isReported,
    );
  }

  _onCloseReportDialog(){
    reportContentController.clear();
    Get.back();
  }

  _onSubmit(bool isReported, Report? currentReport) {
    if(!formKey.currentState!.validate()){
      return;
    }
    if(isReported){
      _onUpdate(currentReport!);
    }
  }

  _onUpdate(Report currentReport) async {
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
  
  //valid báo cáo trong vòng 3 ngày
  
  //end report

  //feedback
  onFeedback() async {
    FeedBack? currentFeedback;
    bool isFeedbacked = false;
    
  }
  //end feedback
  
}
