import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/base_dialog.dart';

class ReportDialog {
  static Future<bool?> show(void Function(String reason) reportFn) async {
    final reasonController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return await BaseDialog.show(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              AppStrings.titleReport,
              style: Get.textTheme.headline4!.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Form(
            key: formKey,
            child: InputField(
              icon: const Icon(CustomIcons.content_paste),
              labelText: 'Lý do báo cáo',
              controller: reasonController,
              minLines: 1,
              maxLines: 8,
              validator: (value) {
                if (Utils.isEmpty(value)) {
                  return AppMsg.MSG4040;
                }

                return null;
              },
            ),
          ),
          const SizedBox(height: 24.0),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: FilledButton(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              title: AppStrings.titleReport,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  reportFn(reasonController.text);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
