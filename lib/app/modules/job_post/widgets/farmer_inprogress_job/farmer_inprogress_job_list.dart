import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_job/farmer_inprogress_job_card.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerInprogressJobList extends GetView<FarmerInprogressJobController> {
  const FarmerInprogressJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controller.getInProgressJobList(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
          }
          if (snapshot.hasError) {
            printError(info: snapshot.error.toString());
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    size: 50.0,
                    color: AppColors.errorColor,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Đã có lỗi xảy ra',
                    style: Get.textTheme.headline6!.copyWith(
                      color: AppColors.errorColor,
                    ),
                  ),
                ],
              ),
            );
          }
          return Obx(() => LazyLoadingList(
              onEndOfPage: controller.getInProgressJobList,
              isLoading: controller.isLoading.value,
              onRefresh: controller.onRefresh,
              itemCount: controller.inProgressJobPostList.isEmpty
                  ? 1
                  : controller.inProgressJobPostList.length,
              itemBuilder: (context, index) {
                if (snapshot.data == null ||
                    controller.inProgressJobPostList.isEmpty) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: Get.height * 0.3),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Không có công việc nào.",
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color: AppColors.grey,
                              fontSize: Get.textScaleFactor * 20,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const ImageIcon(AssetImage(AppAssets.noJobFound),
                              size: 30, color: AppColors.grey),
                        ],
                      ),
                    ),
                  );
                }
                JobPost jobPost =
                    controller.inProgressJobPostList[index].jobPost;
                bool isPayPerHourJob = jobPost.payPerHourJob != null;
                return Container(
                    padding: const EdgeInsets.all(8),
                    child: FarmerInprogressJobCard(
                      job: jobPost.title,
                      address: jobPost.address ?? 'Cập nhật sau',
                      startTime: isPayPerHourJob
                          ? jobPost.payPerHourJob!.startTime.toString()
                          : "8:00",
                      endTime: isPayPerHourJob
                          ? jobPost.payPerHourJob!.finishTime.toString()
                          : jobPost.payPerTaskJob!.finishTime.toString() ==
                                  'null'
                              ? "17:00"
                              : jobPost.payPerTaskJob!.finishTime.toString(),
                      isPayPerHourJob: isPayPerHourJob ? true : false,
                      report: () {
                        Get.back();
                        _showReportDialog(jobPost.id);
                      },
                      onLeave: () {
                        Get.back();
                        _showOnLeaveDialog();
                      },
                      extendJob: () =>
                          {Get.back(), _showExtendJobDialog(DateTime.now())},
                    ));
              }));
        }));
  }

  Future _showReportDialog(int jobPostId) {
    return CustomFormDialog.showDialog(
        title: 'Báo cáo',
        formKey: controller.formKey,
        textFields: [
          InputField(
            key: UniqueKey(),
            controller: controller.reportContentController,
            icon: const Icon(Icons.announcement_outlined),
            labelText: AppStrings.titleReason,
            placeholder: AppStrings.placeholderReport,
            keyBoardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
            validator: controller.validateReason,
          ),
        ],
        submit: () {controller.onSubmitReportForm(jobPostId);},
        cancel: controller.onCloseReportDialog);
  }

  Future _showOnLeaveDialog() {
    return CustomFormDialog.showDialog(
      title: 'Nghỉ phép',
      formKey: controller.formKey,
      textFields: [
        SingleChildScrollView(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.o,
            child: Column(
          children: [
            InputField(
              key: UniqueKey(),
              controller: controller.onLeaveStartDateController,
              icon: const Icon(CustomIcons.calendar_range),
              labelText: '${AppStrings.labelOnLeaveStartDate}*',
              placeholder: AppStrings.placeholderOnleaveStartDate,
              inputAction: TextInputAction.next,
              readOnly: true,
              onTap: controller.onChooseOnLeaveStartDate,
              validator: controller.validateChooseOnleaveStartDate,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            InputField(
              key: UniqueKey(),
              controller: controller.onLeaveEndDateController,
              icon: const Icon(CustomIcons.calendar_range),
              labelText: '${AppStrings.labelOnLeaveEndDate}*',
              placeholder: AppStrings.placeholderOnleaveEndDate,
              inputAction: TextInputAction.next,
              readOnly: true,
              onTap: controller.onChooseOnLeaveEndDate,
              // validator: controller.validateChooseOnleaveEndDate,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            InputField(
              key: UniqueKey(),
              controller: controller.onLeaveReasonController,
              icon: const Icon(Icons.announcement_outlined),
              labelText: AppStrings.titleReason,
              placeholder: AppStrings.placeholderReport,
              keyBoardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              validator: controller.validateReason,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Lưu ý: ",
                    style: Get.textTheme.caption!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                      text:
                          "Chỉ được phép nghỉ tối đa 30 ngày, tính từ ngày bắt đầu nghỉ.",
                      style: Get.textTheme.caption),
                ],
              ),
              style: TextStyle(
                fontSize: Get.textScaleFactor * 17,
                fontStyle: FontStyle.italic,
              ),
            )
          ],
        ))
      ],
      submit: controller.onSubmitOnleaveForm,
      cancel: controller.onCloseOnLeaveDialog,
    );
  }

  Future _showExtendJobDialog(DateTime oldDate) {
    DateTime endJobDate = DateTime.now().add(const Duration(days: 1));
    DateTime today = DateTime.now();
    // print(endJobDate.difference(today).inDays  >= 1);
    if (endJobDate.difference(today).inDays < 1) {
      return InformationDialog.showDialog(
          confirmTitle: 'Đóng', msg: 'Không thể gia hạn');
    }
    return CustomFormDialog.showDialog(
      formKey: controller.formKey,
      title: 'Gia hạn ngày kết thúc',
      textFields: [
        Row(
          children: [
            const Icon(
              CustomIcons.calendar_range,
              size: 25,
            ),
            SizedBox(
              width: Get.width * 0.04,
            ),
            Text(
              'Ngày kết thúc cũ*',
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: Get.textScaleFactor * 16,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Padding(
          padding: EdgeInsets.only(left: Get.width * 0.1),
          child: Text(
            DateFormat('dd/MM/yyyy').format(oldDate),
            style: TextStyle(
              fontSize: Get.textScaleFactor * 16,
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        InputField(
          key: UniqueKey(),
          controller: controller.extendJobDateController,
          icon: const Icon(Icons.edit_calendar_outlined),
          labelText: '${AppStrings.labelNewExtendJobDate}*',
          placeholder: AppStrings.placeholderNewExtendJobDate,
          inputAction: TextInputAction.next,
          readOnly: true,
          onTap: () => controller.onChooseNewEndDate(oldDate),
          validator: controller.validateChooseNewEndDate,
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        InputField(
          key: UniqueKey(),
          controller: controller.extendJobReasonController,
          icon: const Icon(Icons.announcement_outlined),
          labelText: AppStrings.titleReason,
          placeholder: AppStrings.placeholderReport,
          keyBoardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 10,
          validator: controller.validateReason,
        ),
      ],
      submit: controller.onSubmitExtendJobForm,
      cancel: controller.onCloseExtendJobDialog,
    );
  }
}
