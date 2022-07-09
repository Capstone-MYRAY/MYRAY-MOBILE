import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/farmer_inprogress_job_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/farmer_inprogress_job/farmer_inprogress_job_card.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';

class FarmerInprogressJobList extends GetView<FarmerInprogressJobController> {
  const FarmerInprogressJobList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
            padding: const EdgeInsets.all(10),
            child: FarmerInprogressJobCard(
              job: 'Thu hoạch cà phê',
              address: 'Dăk lăk, Buôn Mê Thuột',
              startTime: '7:00',
              endTime: '17:00',
              isPayPerHourJob: (index % 2) == 0 ? true : false,
              report: _showReportDialog,
              onLeave: _showOnLeaveDialog,
              extendJob: () => _showExtendJobDialog(DateTime.now()), //pass old end date job
            ));
      },
    );
  }

  Future _showReportDialog() {
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
        submit: controller.onSubmitReportForm,
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
    DateTime endJobDate = DateTime.now()
    .add(const Duration(days: 1));
    DateTime today = DateTime.now();
    // print(endJobDate.difference(today).inDays  >= 1);
    if(endJobDate.difference(today).inDays  < 1){
      return InformationDialog.showDialog(
        confirmTitle: 'Đóng',
        msg: 'Không thể gia hạn'
      );
    }
    return CustomFormDialog.showDialog(
      formKey: controller.formKey,
      title: 'Gia hạn ngày kết thúc',
      textFields: [
        Row(
          children: [
            const Icon(
              CustomIcons.calendar_range ,
              size: 25,
            ),
            SizedBox(width: Get.width * 0.04,),
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
