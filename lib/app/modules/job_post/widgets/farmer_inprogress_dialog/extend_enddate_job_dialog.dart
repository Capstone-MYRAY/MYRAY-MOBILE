import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:myray_mobile/app/data/models/extend_end_date_job/extend_end_date_job.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';

@JsonSerializable(includeIfNull: false)
class ExtendEndDateJobDialog {
  ExtendEndDateJobDialog._();

  static show({
    required int jobPostId,
    required ExtendEndDateJob? job,
    required GlobalKey<FormState> formKey,
    required DateTime? oldDate,
    required TextEditingController extendJobDateController,
    required TextEditingController extendJobReasonController,
    required void Function(DateTime?) onTap,
    required String? Function(String?) validateReason,
    required String? Function(String?) validateChooseNewEndDate,
    required void Function(int?) submit,
    required void Function() closeDialog,
  }) async {
    DateTime endJobDate = DateTime.now().add(const Duration(days: 1));
    DateTime today = DateTime.now();
    // print(endJobDate.difference(today).inDays  >= 1);
    // if (endJobDate.difference(today).inDays < 1) {
    //   return InformationDialog.showDialog(
    //       confirmTitle: 'Đóng', msg: 'Không thể gia hạn');
    // }
    // ExtendEndDateJob? job = await controller.getExtendEndDateJob(jobPostId);
    if (job != null) {
      return InformationDialog.showDialog(
          confirmTitle: 'Đóng', msg: 'Bạn đã gia hạn ngày kết thúc.');
    }
    return CustomFormDialog.showDialog(
      formKey: formKey,
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
            oldDate != null
                ? DateFormat('dd/MM/yyyy').format(oldDate)
                : 'Chưa cập nhật',
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
          controller: extendJobDateController,
          icon: const Icon(Icons.edit_calendar_outlined),
          labelText: '${AppStrings.labelNewExtendJobDate}*',
          placeholder: AppStrings.placeholderNewExtendJobDate,
          inputAction: TextInputAction.next,
          readOnly: true,
          onTap: () => {
            onTap(oldDate),
          },
          validator: validateChooseNewEndDate,
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
        InputField(
          key: UniqueKey(),
          controller: extendJobReasonController,
          icon: const Icon(Icons.announcement_outlined),
          labelText: AppStrings.titleReason,
          placeholder: AppStrings.placeholderReport,
          keyBoardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 10,
          validator: validateReason,
        ),
      ],
      onSubmit: () => {submit(jobPostId)},
      submitButtonTitle: 'Gia hạn',
      onCancel: closeDialog,
    );
  }
}
