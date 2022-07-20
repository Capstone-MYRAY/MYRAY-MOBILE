
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';

class OnLeaveDialog{

  OnLeaveDialog._();

  static show({
    required int jobPostId,
    required GlobalKey<FormState> formKey,
    required TextEditingController onLeaveDateController,
    required TextEditingController onLeaveReasonController,
    required void Function() onChooseOnLeaveDate,
    required String? Function(String?) validateReason,
    required String? Function(String?) validateChooseOnleaveDate,
    required void Function(int?) submit,
    required void Function() closeDialog,
    
  }){
      return CustomFormDialog.showDialog(
      title: 'Nghỉ phép',
      formKey: formKey,
      textFields: [
        SingleChildScrollView(
            // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.o,
            child: Column(
          children: [
            InputField(
              key: UniqueKey(),
              controller: onLeaveDateController,
              icon: const Icon(CustomIcons.calendar_range),
              labelText: '${AppStrings.labelOnLeaveDate}*',
              placeholder: AppStrings.placeholderOnleaveStartDate,
              inputAction: TextInputAction.next,
              readOnly: true,
              onTap: onChooseOnLeaveDate,
              validator: validateChooseOnleaveDate,
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            InputField(
              key: UniqueKey(),
              controller: onLeaveReasonController,
              icon: const Icon(Icons.announcement_outlined),
              labelText: AppStrings.titleReason,
              placeholder: AppStrings.placeholderReport,
              keyBoardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              validator: validateReason,
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
      submit: () {submit(jobPostId);},
      submitButtonTitle: 'Báo nghỉ',
      cancel:closeDialog,
    );
  }
  }
