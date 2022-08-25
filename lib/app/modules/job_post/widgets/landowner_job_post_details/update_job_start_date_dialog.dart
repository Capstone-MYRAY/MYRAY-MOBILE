import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/base_dialog.dart';

class UpdateJobStartDateDialog {
  UpdateJobStartDateDialog._();

  static Future<dynamic> show(
      {required DateTime currentStartDate,
      required void Function(DateTime) updateJobStartDateFn}) async {
    final startDateController = TextEditingController();
    DateTime? selectedDate;
    final formKey = GlobalKey<FormState>();

    return await BaseDialog.show(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Cập nhật ngày bắt đầu',
              style: Get.textTheme.headline4!.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          CardField(
            icon: CustomIcons.calendar_range,
            title: 'Ngày bắt đầu hiện tại',
            isCenter: true,
            data: Utils.formatddMMyyyy(currentStartDate),
            dataColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 4.0),
          Form(
            key: formKey,
            child: InputField(
              key: UniqueKey(),
              controller: startDateController,
              icon: const Icon(CustomIcons.calendar_range),
              labelText: 'Ngày bắt đầu công việc mới*',
              placeholder: AppStrings.placeholderJobStartDate,
              inputAction: TextInputAction.next,
              readOnly: true,
              onTap: () async {
                DateTime now = DateUtils.dateOnly(DateTime.now());
                DateTime initDate = selectedDate != null
                    ? selectedDate!
                    : currentStartDate.toLocal();
                DateTime? selected = await MyDatePicker.show(
                  firstDate: now.add(const Duration(days: 1)),
                  lastDate: now.toLocal().add(const Duration(days: 30)),
                  initDate: initDate,
                );

                if (selected != null) {
                  selectedDate = selected;
                  startDateController.text = Utils.formatddMMyyyy(selected);
                }
              },
              validator: (value) {
                if (Utils.isEmpty(value)) {
                  return AppMsg.MSG0002;
                }

                DateTime jobStartDate = Utils.fromddMMyyyy(value!);
                DateTime now = DateUtils.dateOnly(DateTime.now());

                if (jobStartDate.isBefore(now) ||
                    jobStartDate.isAtSameMomentAs(now)) {
                  return 'Ngày bắt đầu công việc phải sau ngày hiện tại';
                }

                return null;
              },
            ),
          ),
          const SizedBox(height: 16.0),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: FilledButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;

                updateJobStartDateFn(selectedDate!);
              },
              title: AppStrings.titleUpdate,
            ),
          ),
        ],
      ),
    );
  }
}
