
import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_form_dialog.dart';

class ReportDialog{
  ReportDialog._();

  static show({
    required int jobPostId,
    required GlobalKey<FormState> formKey,
    required TextEditingController reportContentController,
    required String? Function(String?) validateReason,
    required void Function(int?) submit,
    required void Function() closeDialog,
  }){
       return CustomFormDialog.showDialog(
        title: 'Báo cáo',
        formKey: formKey,
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
        submit: () {
          submit(jobPostId);
        },
        submitButtonTitle: 'Báo cáo',
        cancel: closeDialog
        ); 
  }
}