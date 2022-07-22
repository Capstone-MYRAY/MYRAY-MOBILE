import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/attendance/farmer_post_attendance_request.dart';
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
    bool isFormValid = formKey.currentState!.validate();
    PutUpdateReportRequest data = PutUpdateReportRequest(
      id: report.id,
      jobPostId: report.jobPostId!,
      content: reportContentController.text,
      reportedId: report.reportedId!,
    );

    if (isFormValid) {
      try {
        Report? newReport = await _updateReport(data);
        if (newReport != null) {
          EasyLoading.show();
          Future.delayed(const Duration(milliseconds: 1200), () {
            onCloseFeedBackDialog();
            EasyLoading.dismiss();
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
          });
          return;
        }
        CustomSnackbar.show(
            title: "Thất bại",
            message: "Gửi báo cáo không thành công",
            backgroundColor: AppColors.errorColor);
      } on CustomException catch (e) {
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
      PostFeedbackRequest data = PostFeedbackRequest(
        content: feedbackContentController.text,
        numStar: feedbackRatingController.text != '5'
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
      try {
        FeedBack? newFeedBack = await feedBackController.updateFeedback(data);
        if (newFeedBack != null) {
          EasyLoading.show();
          Future.delayed(const Duration(milliseconds: 1200), () {
            onCloseReportDialog();
            EasyLoading.dismiss();
            Get.defaultDialog(
                title: 'Cập nhật đánh giá',
                titlePadding: const EdgeInsets.only(top: 20),
                contentPadding: const EdgeInsets.all(20),
                titleStyle: Get.textTheme.headline3,
                content: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star_border_rounded,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(width: Get.height * 0.01),
                        Text(
                          'Mức độ đánh giá:',
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: Get.textScaleFactor * 17,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      children: [
                        SizedBox(width: Get.width * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBarIndicator(
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: Get.textScaleFactor * 35,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              rating: double.parse(newFeedBack.numStar.toString())
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      children: [
                        const Icon(
                          Icons.content_copy_rounded,
                          size: 17,
                          color: AppColors.black,
                        ),
                        SizedBox(width: Get.height * 0.01),
                        Text(
                          'Nội dung cập nhật:',
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: Get.textScaleFactor * 17,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      children: [
                        SizedBox(width: Get.width * 0.07),
                        Expanded(
                          //valid giới hạn lại số chữ nhập
                          child: Text(
                            newFeedBack.content,
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: Get.textScaleFactor * 16),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            maxLines: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range_outlined,
                          size: 17,
                          color: AppColors.black,
                        ),
                        SizedBox(width: Get.height * 0.01),
                        Text(
                          'Ngày cập nhật:',
                          style: Get.textTheme.labelMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: Get.textScaleFactor * 17,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Row(
                      children: [
                        SizedBox(width: Get.width * 0.07),
                        Expanded(
                          child: Text(
                            Utils.formatHHmmddMMyyyy(DateTime.now()),
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: Get.textScaleFactor * 16),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            maxLines: 5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Get.height * 0.02),
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
                )                
                );
          });
          return;
        }
      } on CustomException catch (e) {
        print('$e');
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
        if (feedBack.listobject!.isNotEmpty) {
          print("feedback: ${feedBack.listobject!.length}");
          return feedBack.listobject![0];
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
}
