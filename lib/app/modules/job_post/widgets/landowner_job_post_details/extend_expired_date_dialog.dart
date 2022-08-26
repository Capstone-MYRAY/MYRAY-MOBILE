import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/fee_data.dart';
import 'package:myray_mobile/app/modules/job_post/views/equation_display.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/base_dialog.dart';

class ExtendExpiredDateDialog {
  static Future<bool?> show(
    DateTime currentExpiredDate,
    FeeData feeData,
    LandownerProfileController profile,
    void Function(DateTime extendDate, int? usedPoint) extendFn,
  ) async {
    final formKey = GlobalKey<FormState>();
    final extendDateController = TextEditingController();
    int numOfExtendDays = 0;
    int usedPoint = 0;
    double postingFee = 0;
    double reduce = 0;

    return await BaseDialog.show(
      child: StatefulBuilder(
        builder: (context, setState) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Gia hạn ngày đăng bài',
                style: Get.textTheme.headline4!.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            CardField(
              icon: CustomIcons.calendar_range,
              title: 'Ngày hết hạn hiện tại',
              isCenter: true,
              data: Utils.formatddMMyyyy(currentExpiredDate),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: UniqueKey(),
                    controller: extendDateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Ngày muốn gia hạn',
                      hintText: 'dd/MM/yyyy',
                    ),
                    onTap: () async {
                      DateTime current = currentExpiredDate
                          .toLocal()
                          .add(const Duration(days: 1));
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: current,
                        firstDate: current,
                        lastDate: current.add(const Duration(days: 365)),
                      );

                      if (selectedDate != null) {
                        extendDateController.text =
                            Utils.formatddMMyyyy(selectedDate);
                        setState(() {
                          numOfExtendDays = selectedDate
                              .difference(currentExpiredDate)
                              .inDays
                              .abs();
                          postingFee =
                              feeData.postingFeePerDay * numOfExtendDays;
                        });
                      }
                    },
                    validator: (value) {
                      if (Utils.isEmpty(value)) {
                        return AppMsg.MSG0002;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 2.0),
                  EquationDisplay(
                    equation:
                        '${Utils.vietnameseCurrencyFormat.format(feeData.postingFeePerDay)} x $numOfExtendDays (ngày)',
                    cost:
                        '= ${Utils.vietnameseCurrencyFormat.format(postingFee)}',
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 8.0),
                  SpinBox(
                    key: UniqueKey(),
                    min: 0,
                    max: 100000,
                    step: 1,
                    keyboardType: TextInputType.number,
                    showButtons: true,
                    onChanged: (value) {
                      usedPoint = value.toInt();
                      setState(() {
                        reduce = feeData.pointToReduce1VND * usedPoint;
                      });
                    },
                    value: usedPoint.toDouble(),
                    decoration: const InputDecoration(
                      label: Text('Dùng điểm'),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  EquationDisplay(
                    equation:
                        '${Utils.vietnameseCurrencyFormat.format(feeData.pointToReduce1VND)} x $usedPoint (điểm)',
                    cost: '= ${Utils.vietnameseCurrencyFormat.format(reduce)}',
                    isReduce: false,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            DottedBorder(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              radius: const Radius.circular(CommonConstants.borderRadius),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng cộng',
                        style: Get.textTheme.bodyText1,
                      ),
                      Text(
                        Utils.vietnameseCurrencyFormat
                            .format(postingFee - reduce),
                        style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.errorColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Điểm tích lũy',
                        style: Get.textTheme.bodyText1,
                      ),
                      Text(
                        '+${Utils.threeDigitsFormat.format(((postingFee - reduce) / feeData.payToHave1Point).round())}',
                        style: Get.textTheme.bodyText2!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: FilledButton(
                title: 'Gia hạn',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final userBalance = profile.balanceWithPending.value;
                    print('userbalance $userBalance');
                    print('postingFee $postingFee');
                    if (postingFee > userBalance) {
                      Get.defaultDialog(
                        title: 'Thông báo',
                        barrierDismissible: false,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        confirm: TextButton(
                          child: const Text(
                            'Đóng',
                          ),
                          onPressed: () => Get.back(),
                        ),
                        content: RichText(
                          text: TextSpan(
                            style: Get.textTheme.bodyText1,
                            text: 'Tiền trong tài khoản còn ',
                            children: <TextSpan>[
                              TextSpan(
                                text: Utils.vietnameseCurrencyFormat
                                    .format(userBalance),
                                style: Get.textTheme.bodyText1!.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const TextSpan(
                                text: ' không đủ thực hiện giao dịch.',
                              ),
                            ],
                          ),
                        ),
                      );

                      return;
                    }
                    extendFn(Utils.fromddMMyyyy(extendDateController.text),
                        usedPoint);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
