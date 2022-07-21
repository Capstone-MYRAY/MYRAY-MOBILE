import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';

class ReportDialog {
  ReportDialog._();
  static int size = 17;
  static show({
    required int jobPostId,
    required GlobalKey<FormState> formKey,
    required TextEditingController reportContentController,
    required String? Function(String?) validateReason,
    required void Function(int?) submit,
    required void Function() closeDialog,
    required bool isResovled,
    required bool isReported,
    void Function()? delete,
  }) {
    return CustomFormDialog.showDialog(
        title: 'Báo cáo',
        formKey: formKey,
        contentPadding: const EdgeInsets.only(left: 10, right: 10),
        textFields: [
          InputField(
            key: UniqueKey(),
            controller: reportContentController,
            icon: const Icon(Icons.announcement_outlined),
            labelText: AppStrings.titleReason,
            placeholder: AppStrings.placeholderReport,
            keyBoardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
            validator: validateReason,
          ),
        ],
        submitButtonTitle: 'Báo cáo',
        widget: isReported
        ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  CustomTextButton(
                      background: AppColors.white,
                      onPressed: () {
                        submit(jobPostId);
                      },
                      title: 'Cập nhật',
                      textStyle: Get.textTheme.button!.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: Get.textScaleFactor * size,
                      ),
                      padding: EdgeInsets.zero),
                  const SizedBox(
                    width: 5,
                  ),
                  const VerticalDivider(
                      color: AppColors.errorColor, indent: 10, endIndent: 10),
                ],
              ),
            ),
            delete != null
                ? IntrinsicHeight(
                    child: Row(
                      children: [
                         const SizedBox(
                          width: 5,
                        ),
                        CustomTextButton(
                            onPressed: delete,
                            title: 'Xóa',
                            background: AppColors.white,
                            foreground: AppColors.errorColor,
                            textStyle: Get.textTheme.displayMedium!.copyWith(
                              color: AppColors.errorColor,
                              fontSize: Get.textScaleFactor * size,
                            ),
                            padding: EdgeInsets.zero),
                        const SizedBox(
                          width: 5,
                        ),
                        const VerticalDivider(
                            color: AppColors.errorColor,
                            indent: 10,
                            endIndent: 10),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  )
                : const Text(''),
            CustomTextButton(
                onPressed: closeDialog,
                title: 'Quay lại',
                background: AppColors.white,
                textStyle: Get.textTheme.button!.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: Get.textScaleFactor * size,
                ),
                padding: EdgeInsets.zero)
          ],
        ): null,
        onSubmit: isReported ? null : (){submit(jobPostId);},
        onCancel: isReported ? null : closeDialog
        );
  }
}
