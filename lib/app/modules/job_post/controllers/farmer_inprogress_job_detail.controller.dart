import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/status.dart';
import 'package:myray_mobile/app/data/models/account.dart';
import 'package:myray_mobile/app/data/models/attendance/attendance.dart';
import 'package:myray_mobile/app/data/models/attendance/farmer_post_attendance_request.dart';
import 'package:myray_mobile/app/data/models/attendance/get_attendance_by_date_request.dart';
import 'package:myray_mobile/app/data/models/attendance/get_attendance_by_date_response.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/post_extend_end_date_job_request.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/feedback/get_feedback_request.dart';
import 'package:myray_mobile/app/data/models/feedback/get_feedback_response.dart';
import 'package:myray_mobile/app/data/models/feedback/post_feedback_request.dart';
import 'package:myray_mobile/app/data/models/feedback/put_feedback_request.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/report/get_report_request.dart';
import 'package:myray_mobile/app/data/models/report/get_report_response.dart';
import 'package:myray_mobile/app/data/models/report/post_report_request.dart';
import 'package:myray_mobile/app/data/models/report/put_update_report_request.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/data/services/message_service.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/modules/attendance/attendance_repository.dart';
import 'package:myray_mobile/app/modules/attendance/widgets/farmer_attendance_detail_dialog.dart';
import 'package:myray_mobile/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/feedback_update_dialog.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/report_update_dialog.dart';
import 'package:myray_mobile/app/modules/profile/profile_repository.dart';
import 'package:myray_mobile/app/modules/report/report_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_information.dialog.dart';

class InprogressJobDetailController extends GetxController
    with MessageService, ProfileRepository {
  final JobPost jobpost;
  FeedBackController feedBackController = Get.find<FeedBackController>();
  final _appliedRepository = Get.find<AppliedJobRepository>();
  final _reportRepository = Get.find<ReportRepository>();
  final _attendanceRepository = Get.find<AttendanceRepository>();

  InprogressJobDetailController({required this.jobpost});

  late DateTime currentOnleaveDate;
  late DateTime currentExtendDate;

  late GlobalKey<FormState> formKey;

  late TextEditingController reportContentController;

  late TextEditingController onLeaveDateController;
  late TextEditingController onLeaveReasonController;

  late TextEditingController extendJobDateController;
  late TextEditingController extendJobReasonController;

  late TextEditingController feedbackContentController;
  late TextEditingController feedbackRatingController;

  @override
  void onInit() async {
    formKey = GlobalKey<FormState>();

    reportContentController = TextEditingController();

    onLeaveDateController = TextEditingController();
    onLeaveReasonController = TextEditingController();

    extendJobDateController = TextEditingController();
    extendJobReasonController = TextEditingController();

    feedbackContentController = TextEditingController();
    feedbackRatingController = TextEditingController();

    _getLanownerAccount(jobpost.publishedBy);
    super.onInit();
  }

  updateJobEndDate(DateTime jobEndDate) {
    jobpost.jobEndDate = jobEndDate;
    update(['jobEndDate']);
  }

  String? validateReason(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng nhập lý do';
    }
    if (!Utils.limitString.hasMatch(value!)) {
      return 'Bạn đã nhập quá 1000 từ';
    }

    return null;
  }

  String? validateChooseOnleaveDate(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng chọn ngày bắt đầu nghỉ';
    }
    return null;
  }

  String? validateChooseNewEndDate(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng chọn ngày kết thúc mới';
    }
    return null;
  }

  void onChooseOnLeaveDate() async {
    DateTime? _initDate = onLeaveDateController.text.isEmpty
        ? DateTime.now().add(const Duration(days: 1))
        : Utils.fromddMMyyyy(onLeaveDateController.text);
    DateTime? _pickedDate = await MyDatePicker.show(
        initDate: _initDate,
        firstDate: _initDate,
        lastDate: DateTime.now()
            .add(const Duration(days: 365 * 10))); //check ngày end job
    if (_pickedDate != null) {
      currentOnleaveDate = _pickedDate;
      onLeaveDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  void onChooseNewEndDate(DateTime? oldDate) async {
    DateTime now = DateTime.now();
    //if end date null, now + (365 days *10) -> update end date
    DateTime _initDate = oldDate != null
        ? oldDate.add(const Duration(days: 1))
        : now.add(const Duration(days: 365 * 10));
    DateTime _firstDate = onLeaveDateController.text.isNotEmpty
        ? Utils.fromddMMyyyy(onLeaveDateController.text)
        : _initDate;
    DateTime? _pickedDate = await MyDatePicker.show(
        firstDate: _firstDate,
        initDate: _initDate,
        lastDate: _firstDate.add(
            const Duration(days: 6))); // not include the first day; max = 7
    print('_pickedDate: $_pickedDate');

    if (_pickedDate != null) {
      currentExtendDate= _pickedDate;
      extendJobDateController.text = Utils.formatddMMyyyy(_pickedDate);
    }
  }

  onCloseReportDialog() {
    reportContentController.clear();
    Get.back();
  }

  onCloseOnLeaveDialog() {
    onLeaveDateController.clear();
    onLeaveReasonController.clear();
    Get.back();
  }

  onCloseExtendJobDialog() {
    extendJobDateController.clear();
    extendJobReasonController.clear();
    Get.back();
  }

  onCloseFeedBackDialog() {
    feedbackContentController.clear();
    feedbackRatingController.clear();
    Get.back();
  }

  onSubmitReportForm(JobPost jobPost) async {
    bool isFormValid = formKey.currentState!.validate();
    print(isFormValid ? reportContentController.value : 'no valid');
    if (isFormValid) {
      EasyLoading.show();
      PostReportRequest data = PostReportRequest(
          content: reportContentController.text,
          jobPostId: jobPost.id,
          reportedId: jobPost.publishedBy);
      Report? result = await _reportJob(data);
      onCloseReportDialog();
      EasyLoading.dismiss();
      if (result == null) {
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi báo cáo không thành công",
            backgroundColor: AppColors.errorColor);
      } else {
        CustomSnackbar.show(
            title: "Thành công", message: "Gửi báo cáo thành công");
      }
    }
  }

  onUpdaetReportForm(Report report) async {
    bool isFormValid = formKey.currentState!.validate();
    PutUpdateReportRequest data = PutUpdateReportRequest(
      id: report.id,
      jobPostId: report.jobPostId!,
      content: reportContentController.text,
      reportedId: report.reportedId!,
    );

    if (isFormValid) {
      EasyLoading.show();
      try {
        Report? newReport = await _updateReport(data);
        Future.delayed(const Duration(milliseconds: 1200), () {
          onCloseReportDialog();
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
  }

  onSubmitOnleaveForm(int jobPostId) async {
    bool isFormValid = formKey.currentState!.validate();
    print(isFormValid);

    if (isFormValid) {
      FarmerPostAttendanceRequest data = FarmerPostAttendanceRequest(
        jobPostId: jobPostId,
        dayOff: DateTime.parse('${currentOnleaveDate}Z'),
        reason: onLeaveReasonController.text,
      );
      print("reason: ${onLeaveReasonController.text}");
      onCloseOnLeaveDialog();
      try {
        EasyLoading.show();
        Future.delayed(const Duration(milliseconds: 1500), () {
          EasyLoading.dismiss();
        });
        await _requestDayOff(data).then((result) => {
              if (result!)
                {
                  CustomSnackbar.show(
                      title: "Thành công", message: "Gửi yêu cầu thành công")
                }
              else
                {
                  CustomSnackbar.show(
                      title: "Lỗi",
                      message: "Gửi yêu cầu không thành công",
                      backgroundColor: AppColors.errorColor)
                }
            });
      } on CustomException catch (e) {
        CustomSnackbar.show(
            title: "Lỗi",
            message: "Gửi yêu cầu không thành công",
            backgroundColor: AppColors.errorColor);
        print('lỗi: $e');
      }
    }
  }

  onSubmitExtendJobForm(int jobPostId) async {
    bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      PostExtendEndDateJobRequest data = PostExtendEndDateJobRequest(
          extendEndDate: '${currentExtendDate}Z',
          jobPostId: jobPostId,
          reason: extendJobReasonController.text);

      try {
        ExtendEndDateJob? result = await _extendEndDateJob(data);
        EasyLoading.show();
        Future.delayed(const Duration(milliseconds: 1200), () {
          EasyLoading.dismiss();
          onCloseExtendJobDialog();
          if (result == null) {
            CustomSnackbar.show(
                title: "Thất bại",
                message: "Gửi yêu cầu không thành công",
                backgroundColor: AppColors.errorColor);
          } else {
            CustomSnackbar.show(
                title: "Thành công", message: "Gửi yêu cầu thành công");
          }
        });
      } on CustomException catch (e) {
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi báo cáo không thành công",
            backgroundColor: AppColors.errorColor);
        print('lỗi: $e');
      } finally {
        // EasyLoading.dismiss();
      }
    }
  }

  onSubmitFeedBackForm(int jobPostId) async {
    bool isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      String ratingFeedback = feedbackRatingController.text;
      print('>>feed: ${feedbackContentController.text}');
      PostFeedbackRequest data = PostFeedbackRequest(
        content: feedbackContentController.text,
        numStar: feedbackRatingController.text != '5' && ratingFeedback != ''
            ? int.parse(ratingFeedback)
            : 5,
        jobPostId: jobPostId,
        belongedId: jobpost.publishedBy,
      );

      try {
        EasyLoading.show();
        FeedBack? feedback = await feedBackController.sendFeedBack(data);
        EasyLoading.dismiss();

        if (feedback != null) {
          onCloseFeedBackDialog();
          CustomSnackbar.show(
              title: "Thành công", message: "Gửi đánh giá thành công");

          return;
        }
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi đánh giá không thành công",
            backgroundColor: AppColors.errorColor);
      } on CustomException catch (e) {
        EasyLoading.dismiss();

        print('Đánh giá xảy ra lỗi: $e');
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi đánh giá không thành công",
            backgroundColor: AppColors.errorColor);
      }
    }
  }

  onUpdateFeedBackForm(FeedBack feedBack) async {
    bool isFormValid = formKey.currentState!.validate();
    if (isFormValid) {
      PutFeedbackRequest data = PutFeedbackRequest(
        id: feedBack.id,
        content: feedbackContentController.text,
        numStar: num.parse(feedbackRatingController.text),
        jobPostId: feedBack.jobPostId,
        belongedId: feedBack.belongedId,
      );
      onCloseFeedBackDialog(); //khi show ra nếu ko đóng key board sẽ bị stack overflow

      try {
        EasyLoading.show();

        FeedBack? newFeedBack = await feedBackController.updateFeedback(data);
        EasyLoading.dismiss();

        if (newFeedBack != null) {
          FeedBackUpdateDialog.show(
            newFeedBack: newFeedBack,
          );
          return;
        }
      } on CustomException catch (e) {
        EasyLoading.dismiss();

        print(e.message);
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Không thể gửi đánh giá !",
            backgroundColor: AppColors.errorColor);
      }
    }
  }

  checkDoReport(int jobPostId) async {
    GetReportRequest data = GetReportRequest(
        createdBy: AuthCredentials.instance.user!.id!.toString(),
        jobPostId: jobPostId.toString(),
        page: "1",
        pageSize: '20');

    GetReportResponse? report = await _getReport(data);

    if (report != null) {
      if (report.listObject!.isNotEmpty) {
        print(report.listObject!.length);
        return report.listObject![0];
      }
    }
    return null;
  }

  checkDoFeedBack(int jobPostId) async {
    GetFeedbackRequest data = GetFeedbackRequest(
        jobPostId: jobPostId.toString(),
        createdBy: AuthCredentials.instance.user!.id!.toString(),
        page: '1',
        pageSize: '20');

    try {
      GetFeedBackResponse? feedBack =
          await feedBackController.getFeedback(data);
      if (feedBack != null) {
        if (feedBack.listObject!.isNotEmpty) {
          print("feedback: ${feedBack.listObject!.length}");
          return feedBack.listObject![0];
        }
      }
      return;
    } on CustomException catch (e) {
      print(e);
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Lỗi khi load đánh giá",
          backgroundColor: AppColors.errorColor);
    }
    return null;
  }

  showAttendance(BuildContext context) async {
    try {
      GetAttendanceByDateRequest data = GetAttendanceByDateRequest(
        jobPostId: jobpost.id.toString(),
        date: DateTime.now(),
      );

      EasyLoading.show();
      List<GetAttendanceByDateResponse>? attendances =
          await _attendanceRepository.getList(data);
      EasyLoading.dismiss();

      if (attendances == null || attendances.isEmpty) {
        CustomInformationDialog.show(
          title: 'Thông báo',
          message:
              'Bạn chưa được điểm danh!\nVui lòng liên hệ chủ vườn hoặc người điều hành gần bạn nhất để được hỗ trợ.',
          icon: const Icon(Icons.pending_actions_outlined,
              size: 40, color: AppColors.brown),
        );
        return;
      }

      final farmerId = AuthCredentials.instance.user!.id;

      //find farmer in attendance list
      GetAttendanceByDateResponse? todayAttendance = attendances
          .firstWhereOrNull((attendance) => attendance.farmer.id == farmerId);
      // print("attendance: ${todayAttendance?.attendances.length}");

      if (todayAttendance == null || todayAttendance.attendances.isEmpty) {
        CustomInformationDialog.show(
          title: 'Thông báo',
          message:
              'Bạn chưa được điểm danh!\nVui lòng liên hệ chủ vườn hoặc người điều hành gần bạn nhất để được hỗ trợ.',
          icon: const Icon(Icons.pending_actions_outlined,
              size: 40, color: AppColors.brown),
        );
        return;
      }
      // if (todayAttendance == null)
      //   throw CustomException('Không thể xem điểm danh');
      //4: dayOff
      if (todayAttendance.attendances.first.status ==
          AttendanceStatus.dayOff.index) {
        CustomInformationDialog.show(
          title: 'Thông báo',
          message:
              'Bạn đã xin nghỉ phép ngày hôm nay\nVui lòng liên hệ chủ vườn hoặc người điều hành gần bạn nhất để được hỗ trợ.',
          icon: const Icon(Icons.free_cancellation_outlined,
              size: 40, color: AppColors.brown),
        );
        return;
      }

      if (todayAttendance.attendances.first.status ==
          AttendanceStatus.absent.index) {
        CustomInformationDialog.show(
            title: 'Thông báo', message: 'Bạn đã vắng mặt');
        return;
      }

      FarmerAttendanceDetailDialog.show(
          Get.context!, todayAttendance.attendances.first, jobpost.title);
    } on CustomException catch (e) {
      EasyLoading.dismiss();
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Không thể xem điểm danh !",
          backgroundColor: AppColors.errorColor);
    }
    // catch (e) {
    //   EasyLoading.dismiss();
    //   CustomSnackbar.show(
    //       title: "Thất bại",
    //       message: "Không thể xem điểm danh !",
    //       backgroundColor: AppColors.errorColor);
    // }
  }

  Future<Report?> _reportJob(PostReportRequest reportData) async {
    return await _appliedRepository.reportJob(reportData);
  }

  Future<ExtendEndDateJob?> _extendEndDateJob(
      PostExtendEndDateJobRequest data) async {
    return await _appliedRepository.extendEndDateJob(data);
  }

  Future<ExtendEndDateJob?> getExtendEndDateJob(int jobPostId) async {
    return await _appliedRepository.getExtendEndDateJob(jobPostId);
  }

  Future<bool?> _requestDayOff(FarmerPostAttendanceRequest data) async {
    return await _appliedRepository.requestDayOff(data);
  }

  Future<GetReportResponse?> _getReport(GetReportRequest data) async {
    return await _reportRepository.getReport(data);
  }

  Future<Report?> _updateReport(PutUpdateReportRequest data) async {
    return await _reportRepository.updateReport(data);
  }

  //Chat
  Account? landownerAccount;
  _getLanownerAccount(int landownerId) async {
    await getUser(landownerId).then(
      (value) => {
        if (value != null)
          {
            landownerAccount = value,
          },
      },
    );
  }

  void navigateToChatScreen() {
    print('Im here');
    final fromId = AuthCredentials.instance.user?.id ?? 0;
    final toId = jobpost.publishedBy;
    final jobPostId = jobpost.id;

    navigateToP2PMessageScreen(
      fromId,
      toId,
      jobPostId,
      jobpost.publishedName ?? 'Chủ vườn',
      jobpost.title,
      toAvatar: landownerAccount?.imageUrl,
    );
  }
}
