import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/base_dialog.dart';

class FiredConfirmDialog {
  FiredConfirmDialog._();

  static const _firedReasons = [
    'Làm việc không nghiêm túc',
    'Kỹ năng không đủ',
    'Khác',
  ];

  static Future<bool?> show(void Function(String? reason) onFired) async {
    String? selectedReason;
    final formKey = GlobalKey<FormState>();
    final reasonController = TextEditingController();

    return await BaseDialog.show(
      child: StatefulBuilder(
        builder: (BuildContext ctx, StateSetter setState) {
          return Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Sa thải',
                  style: Get.textTheme.headline4!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      key: UniqueKey(),
                      items: _firedReasons
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedReason = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Lý do sa thải',
                      ),
                      value: selectedReason,
                      validator: (value) {
                        if (Utils.isEmpty(value)) {
                          return 'Vui lòng chọn lý do';
                        }
                        return null;
                      },
                    ),
                    if (Utils.equalsUtf8String(selectedReason ?? '', 'Khác'))
                      TextFormField(
                        key: UniqueKey(),
                        controller: reasonController,
                        decoration: const InputDecoration(
                          labelText: 'Lý do sa thải',
                        ),
                        validator: (value) {
                          if (Utils.isEmpty(value)) {
                            return 'Vui lòng nhập lý do';
                          }
                          return null;
                        },
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              FractionallySizedBox(
                widthFactor: 0.5,
                child: FilledButton(
                  title: 'Sa thải',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (Utils.equalsUtf8String(selectedReason!, 'Khác')) {
                        selectedReason = reasonController.text;
                      }
                      onFired(selectedReason);
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
