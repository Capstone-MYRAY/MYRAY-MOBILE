import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/attendance/farmer_post_attendance_request.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/post_extend_end_date_job_request.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/feedback/post_feedback_request.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/data/models/report/get_report_request.dart';
import 'package:myray_mobile/app/data/models/report/get_report_response.dart';
import 'package:myray_mobile/app/data/models/report/post_report_request.dart';
import 'package:myray_mobile/app/data/models/report/put_update_report_request.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/modules/applied_job/applied_job_repository.dart';
import 'package:myray_mobile/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:myray_mobile/app/modules/report/report_repository.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
import 'package:myray_mobile/app/shared/utils/custom_exception.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';

class InprogressJobDetailController extends GetxController {
  final JobPost jobpost;
  FeedBackController feedBackController = Get.find<FeedBackController>();
  final _appliedRepository = Get.find<AppliedJobRepository>();
  final _reportRepository = Get.find<ReportRepository>();

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
    super.onInit();
  }

  String? validateReason(String? value) {
    if (Utils.isEmpty(value)) {
      return 'Vui lòng nhập lý do';
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
      currentExtendDate = _pickedDate;
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

  onSubmitReportForm(int jobPostId) async {
    bool isFormValid = formKey.currentState!.validate();
    print(isFormValid ? reportContentController.value : 'no valid');
    if (isFormValid) {
      EasyLoading.show();
      PostReportRequest data = PostReportRequest(
          content: reportContentController.text,
          jobPostId: jobPostId,
          reportedId: AuthCredentials.instance.user!.id!);
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
    Get.back();
    PutUpdateReportRequest data = PutUpdateReportRequest(
      id: report.id,
      jobPostId: report.jobPostId!,
      content: reportContentController.text,
      reportedId: report.reportedId!,
    );

    Report? newReport = await _updateReport(data);
    if (newReport != null) {
      Get.defaultDialog(
        title: 'Cập nhật báo cáo',
        titlePadding: const EdgeInsets.only(top: 10),
        contentPadding: const EdgeInsets.all(20),
        titleStyle: Get.textTheme.headline3,
        content: Stack(
          children: [
            SizedBox(
              width: Get.width * 0.7,
              child: Text.rich(
                TextSpan(
                  text: 'Nội dung cập nhật:  ',
                  children: [
                    TextSpan(
                      text: newReport.content,
                      style: Get.textTheme.bodyText2!
                          .copyWith(fontSize: Get.textScaleFactor * 17),
                    ),
                  ],
                  style: Get.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.textScaleFactor * 17,
                  ),
                ),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                width: Get.width * 0.7,
                child: Text.rich(
                  TextSpan(
                    text: 'Ngày cập nhật:  ',
                    children: [
                      TextSpan(
                        text: Utils.formatHHmmddMMyyyy(DateTime.now()),
                        style: Get.textTheme.bodyText2!
                            .copyWith(fontSize: Get.textScaleFactor * 17),
                      ),
                    ],
                    style: Get.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.textScaleFactor * 17,
                    ),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  maxLines: 3,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextButton(
                        onPressed: () {
                          Get.back();
                        },
                        title: 'Đóng',
                        border: Border.all(
                          color: AppColors.primaryColor,
                        ),
                        foreground: AppColors.primaryColor,
                        background: AppColors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.08, vertical: 9)),
                  ],
                ))
          ],
        ),
      );
      return;
    }
    CustomSnackbar.show(
        title: "Thất bại",
        message: "Gửi báo cáo không thành công",
        backgroundColor: AppColors.errorColor);
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
      // EasyLoading.show();
      PostExtendEndDateJobRequest data = PostExtendEndDateJobRequest(
          extendEndDate: '${currentExtendDate}Z',
          jobPostId: jobPostId,
          reason: extendJobReasonController.text);

      try {
        ExtendEndDateJob? result = await _extendEndDateJob(data);
        onCloseExtendJobDialog();
        if (result == null) {
          CustomSnackbar.show(
              title: "Thất bại",
              message: "Gửi yêu cầu không thành công",
              backgroundColor: AppColors.errorColor);
        } else {
          Future.delayed(const Duration(milliseconds: 1200), () {
            EasyLoading.dismiss();
            CustomSnackbar.show(
                title: "Thành công", message: "Gửi yêu cầu thành công");
          });
        }
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
      PostFeedbackRequest data = PostFeedbackRequest(
        content: feedbackContentController.text,
        numStart: feedbackRatingController.text != '5'
            ? int.parse(feedbackRatingController.text)
            : 5,
        jobPostId: jobPostId,
        belongedId: AuthCredentials.instance.user!.id!,
      );
      try {
        FeedBack? feedback = await feedBackController.sendFeedBack(data);
        EasyLoading.show();

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

  deleteReport(int reportId) async {
    bool? result = await _deleteReport(reportId);
    if (result != null) {
      if (result) {
        EasyLoading.show();
        Future.delayed(const Duration(milliseconds: 1200), () {
          onCloseReportDialog();
          EasyLoading.dismiss();
          CustomSnackbar.show(title: "Thành công", message: "Đã xóa báo cáo");
        });
        return;
      }
      CustomSnackbar.show(
          title: "Thất bại",
          message: "Không xóa được.",
          backgroundColor: AppColors.errorColor);
      return;
    }
    CustomSnackbar.show(
        title: "Thất bại",
        message: "Không xóa được.",
        backgroundColor: AppColors.errorColor);
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

  Future<bool?> _deleteReport(int reportId) async {
    return await _reportRepository.deleteReport(reportId);
  }
}
