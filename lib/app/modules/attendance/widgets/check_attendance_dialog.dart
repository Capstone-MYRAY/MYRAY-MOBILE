import 'package:extended_masked_text/extended_masked_text.dart';
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
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';
import 'package:signature/signature.dart';

class CheckAttendanceDialog {
  static Future<bool?> show(double salary,
      SignatureController signatureController, void Function() onSubmit,
      {MoneyMaskedTextController? moneyController}) async {
    final formKey = GlobalKey<FormState>();

    return await BaseDialog.show(
      child: GestureDetector(
        onPanDown: (_) {
          FocusScope.of(Get.context!).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Xác nhận trả lương',
                  style: Get.textTheme.headline4!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              if (moneyController == null)
                CardField(
                  icon: CustomIcons.cash,
                  title: AppStrings.labelTaskSalary,
                  data: Utils.vietnameseCurrencyFormat.format(salary),
                  isCenter: true,
                ),
              if (moneyController != null)
                Form(
                  key: formKey,
                  child: InputField(
                    icon: const Icon(CustomIcons.cash),
                    labelText: 'Giá công',
                    controller: moneyController,
                    keyBoardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (Utils.isEmpty(value)) {
                        return 'Vui lòng nhập số tiền';
                      }

                      if (moneyController.numberValue <= 0) {
                        return AppMsg.MSG0010;
                      }

                      return null;
                    },
                  ),
                ),
              // const SizedBox(height: 8.0),
              // const CardField(
              //   icon: CustomIcons.gift_open_outline,
              //   title: 'Điểm nhận được',
              //   data: '1 điểm',
              //   isCenter: true,
              // ),
              const SizedBox(height: 12.0),
              Text(
                'Ký xác nhận',
                style: Get.textTheme.headline6,
              ),
              const SizedBox(height: 8.0),
              Container(
                constraints: BoxConstraints(
                  maxWidth: Get.width * 0.9 - 40,
                  maxHeight: Get.height * 0.4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black),
                  borderRadius: BorderRadius.circular(
                    CommonConstants.borderRadius,
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRect(
                      child: Signature(
                        controller: signatureController,
                        backgroundColor: AppColors.white,
                      ),
                    ),
                    Positioned(
                      top: 2.0,
                      right: 2.0,
                      child: GestureDetector(
                        onTap: () => signatureController.clear(),
                        child: const Icon(Icons.clear),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              FilledButton(
                title: 'Xác nhận',
                onPressed: () {
                  bool isValid = formKey.currentState!.validate();
                  if (signatureController.isEmpty) {
                    InformationDialog.showDialog(
                      msg: 'Vui lòng ký xác nhận trước.',
                      confirmTitle: AppStrings.titleClose,
                    );
                    return;
                  }

                  if (!isValid) {
                    return;
                  }

                  onSubmit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
