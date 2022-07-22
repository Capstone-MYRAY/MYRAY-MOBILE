import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/data/models/report/report.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_detail.controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/card_function.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/extend_enddate_job_dialog.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/feedback_dialog.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/onLeave_dialog.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_dialog/report_dialog.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

// ignore: must_be_immutable
class FarmerInProgressJobDetail extends GetView<InprogressJobDetailController> {
  String? title;
  String? address;
  String? startTime;
  String? endTime;
  DateTime? endDate;

  FarmerInProgressJobDetail({
    Key? key,
    this.title,
    this.address,
    this.startTime,
    this.endTime,
    this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Công việc đang làm'),
          centerTitle: true,
          backgroundColor: Colors.amber[200],
          elevation: 0,
        ),
        body: FutureBuilder(
            //get job post
            builder: (context, snapshot) {
          bool isPayPerHourJob = controller.jobpost.type == 'PayPerHourJob';

          return Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width, vertical: Get.height * 0.08),
                decoration: BoxDecoration(
                  color: Colors.amber[200],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  ),
                  border: Border.all(
                    color: AppColors.backgroundColor,
                    width: 10
                  ),
                ),
                child: const Text('Heed not the rabble'),
              ),
              Positioned(
                top: Get.height * 0.03,
                left: Get.width * 0.07,
                right: Get.width * 0.07,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: Get.width * 0.9,
                            child: Text.rich(
                              TextSpan(
                                text: controller.jobpost.title,
                                style: Get.textTheme.headline3!.copyWith(
                                    fontSize: Get.textScaleFactor * 20,
                                    color: AppColors.brown),
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                            width: Get.width * 0.5,
                            child: Text.rich(
                              TextSpan(
                                text:
                                    isPayPerHourJob ? 'Làm công' : 'Làm khoán',
                                style: Get.textTheme.subtitle1!.copyWith(
                                    // fontSize: Get.textScaleFactor * 15,
                                    ),
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              maxLines: 10,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          const Divider(
                            color: AppColors.primaryColor,
                            height: 10,
                            indent: 20,
                            endIndent: 20,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          SizedBox(
                            width: Get.width * 0.7,
                            child: Text.rich(
                              TextSpan(
                                text: 'Địa chỉ:  ',
                                children: [
                                  TextSpan(
                                    text: controller.jobpost.address,
                                    style: Get.textTheme.bodyText2!.copyWith(
                                        fontSize: Get.textScaleFactor * 15),
                                  ),
                                ],
                                style: Get.textTheme.labelMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Get.textScaleFactor * 15,
                                ),
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: AppColors.primaryColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                isPayPerHourJob
                                    ? SizedBox(
                                        width: Get.width * 0.6,
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Giờ làm việc:     ',
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${Utils.fromHHmm(controller.jobpost.payPerHourJob!.startTime).format(context)} - ${Utils.fromHHmm(controller.jobpost.payPerHourJob!.finishTime).format(context)}',
                                                style: Get.textTheme.bodyText2!
                                                    .copyWith(
                                                        fontSize:
                                                            Get.textScaleFactor *
                                                                15,
                                                        color: AppColors.white),
                                              ),
                                            ],
                                            style: Get.textTheme.labelMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize:
                                                        Get.textScaleFactor *
                                                            15,
                                                    color: AppColors.white),
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          maxLines: 10,
                                        ),
                                      )
                                    : const SizedBox(),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                SizedBox(
                                  width: Get.width * 0.6,
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Ngày kết thúc:   ',
                                      children: [
                                        TextSpan(
                                          text: controller.jobpost.jobEndDate ==
                                                  null
                                              ? 'Chưa xác định'
                                              : DateFormat('dd/MM/yyyy').format(
                                                  controller
                                                      .jobpost.jobEndDate!),
                                          style:
                                              Get.textTheme.bodyText2!.copyWith(
                                            fontSize: Get.textScaleFactor * 15,
                                            color: AppColors.errorColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                      style: Get.textTheme.labelMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  Get.textScaleFactor * 15,
                                              color: AppColors.white),
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.33),
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(30),
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 40,
                  crossAxisCount: 2,
                  children: <Widget>[
                    isPayPerHourJob
                        ? CardFunction(
                            title: AppStrings.buttonCheckAttendance,
                            icon: Icons.check_circle_outline,
                            onTap: () {},
                          )
                        : CardFunction(
                            title: AppStrings.extendButton,
                            icon: Icons.edit_calendar_outlined,
                            onTap: () async {
                              ExtendEndDateJobDialog.show(
                                jobPostId: controller.jobpost.id,
                                job: await controller
                                    .getExtendEndDateJob(controller.jobpost.id),
                                formKey: controller.formKey,
                                oldDate: controller.jobpost.jobEndDate,
                                extendJobDateController:
                                    controller.extendJobDateController,
                                extendJobReasonController:
                                    controller.extendJobReasonController,
                                onTap: controller.onChooseNewEndDate,
                                validateReason: controller.validateReason,
                                validateChooseNewEndDate:
                                    controller.validateChooseNewEndDate,
                                submit: (_) {
                                  controller.onSubmitExtendJobForm(
                                      controller.jobpost.id);
                                },
                                closeDialog: controller.onCloseExtendJobDialog,
                              );
                            },
                          ),
                    CardFunction(
                      title: 'Đánh giá\ncông việc',
                      icon: Icons.feedback_outlined,
                      onTap: () async {
                        FeedBack? feedBack = await controller
                            .checkDoFeedBack(controller.jobpost.id);
                        if (feedBack != null) {
                          controller.feedbackContentController.text =
                              feedBack.content;
                          controller.feedbackRatingController.text =
                              feedBack.numStar.toString();
                          FeedbackDialog.show(
                            jobPostId: controller.jobpost.id,
                            formKey: controller.formKey,
                            isFeedbacked: true,
                            initialRating: double.parse(
                                controller.feedbackRatingController.text),
                            feedbackRatingController:
                                controller.feedbackRatingController,
                            feedbackContentController:
                                controller.feedbackContentController,
                            submit: (_) =>
                                controller.onUpdateFeedBackForm(feedBack),
                            validateReason: controller.validateReason,
                            closeDialog: controller.onCloseFeedBackDialog,
                          );
                          return;
                        }
                        FeedbackDialog.show(
                          jobPostId: controller.jobpost.id,
                          formKey: controller.formKey,
                          isFeedbacked: false,
                          initialRating: 5,
                          feedbackRatingController:
                              controller.feedbackRatingController,
                          feedbackContentController:
                              controller.feedbackContentController,
                          submit: (_) => controller
                              .onSubmitFeedBackForm(controller.jobpost.id),
                          validateReason: controller.validateReason,
                          closeDialog: controller.onCloseFeedBackDialog,
                        );
                      },
                    ),
                    CardFunction(
                      title: 'Báo cáo\nvấn đề',
                      icon: Icons.flag_outlined,
                      onTap: () async {
                        Report? report = await controller
                            .checkDoReport(controller.jobpost.id);
                        if (report != null) {
                          controller.reportContentController.text =
                              report.content;
                          ReportDialog.show(
                            isResovled: report.status != 1,
                            isReported: true,
                            jobPostId: controller.jobpost.id,
                            formKey: controller.formKey,
                            reportContentController:
                                controller.reportContentController,
                            validateReason: controller.validateReason,
                            submit: (_) {
                              controller.onUpdaetReportForm(report);
                            },
                            closeDialog: controller.onCloseReportDialog,
                          );
                          return;
                        }
                        ReportDialog.show(
                          isResovled: report != null && report.status != 1,
                          isReported: false,
                          jobPostId: controller.jobpost.id,
                          formKey: controller.formKey,
                          reportContentController:
                              controller.reportContentController,
                          validateReason: controller.validateReason,
                          submit: (_) {
                            controller
                                .onSubmitReportForm(controller.jobpost.id);
                          },
                          closeDialog: controller.onCloseReportDialog,
                        );
                      },
                    ),
                    isPayPerHourJob
                        ? CardFunction(
                            title: AppStrings.buttonOnLeave,
                            icon: CustomIcons.calendar_minus,
                            onTap: () {
                              OnLeaveDialog.show(
                                jobPostId: controller.jobpost.id,
                                formKey: controller.formKey,
                                onLeaveDateController:
                                    controller.onLeaveDateController,
                                onLeaveReasonController:
                                    controller.onLeaveReasonController,
                                onChooseOnLeaveDate:
                                    controller.onChooseOnLeaveDate,
                                validateReason: controller.validateReason,
                                validateChooseOnleaveDate:
                                    controller.validateChooseOnleaveDate,
                                submit: (_) => controller
                                    .onSubmitOnleaveForm(controller.jobpost.id),
                                closeDialog: controller.onCloseOnLeaveDialog,
                              );
                            },
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
