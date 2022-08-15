import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/base_dialog.dart';

class UpdateMaxFarmerDialog {
  UpdateMaxFarmerDialog._();

  static Future<dynamic> show(int currentMaxFarmer,
      void Function(int maxFarmer) updateMaxFarmerFn) async {
    final maxFarmerController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return await BaseDialog.show(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Cập nhật số người tối đa',
              style: Get.textTheme.headline4!.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          CardField(
            icon: CustomIcons.account_outline,
            title: 'Số người ước lượng tối đa hiện tại',
            isCenter: true,
            data: currentMaxFarmer.toString(),
            dataColor: AppColors.primaryColor,
          ),
          const SizedBox(height: 4.0),
          Form(
            key: formKey,
            child: InputField(
              icon: const SizedBox(),
              labelText: 'Số người ước lượng tối đa mới*',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: maxFarmerController,
              keyBoardType: TextInputType.number,
              validator: (value) {
                if (Utils.isEmpty(value)) {
                  return AppMsg.MSG0002;
                }

                if (!Utils.isPositiveInteger(value!)) {
                  return AppMsg.MSG0010;
                }

                int max = int.parse(value.trim());
                if (max <= currentMaxFarmer) {
                  return 'Số người ước lượng tối đa mới phải lớn hơn số người ước lượng tối đa hiện tại';
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

                updateMaxFarmerFn(int.parse(maxFarmerController.text.trim()));
              },
              title: AppStrings.titleUpdate,
            ),
          ),
        ],
      ),
    );
  }
}
