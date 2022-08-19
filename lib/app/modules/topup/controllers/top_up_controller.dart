import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:momo_vn/momo_vn.dart';
import 'package:myray_mobile/app/data/providers/momo/momo_provider.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_snackbar.dart';

class TopUpController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late MoneyMaskedTextController topUpMoneyController;

  @override
  void onInit() {
    super.onInit();

    topUpMoneyController = MoneyMaskedTextController(
      thousandSeparator: '.',
      rightSymbol: 'đ',
      precision: 0,
      decimalSeparator: '',
    );

    MomoProvider.instance.onInit(
      handlePaymentSuccess: _handlePaymentSuccess,
      handlePaymentError: _handlePaymentError,
    );
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    print('Success: ${response.status} - ${response.message}');
    Get.back(); //close top up screen
    CustomSnackbar.show(
      title: AppStrings.titleSuccess,
      message: 'Nạp tiền thành công',
    );
  }

  void _handlePaymentError(PaymentResponse response) {
    print('Error: ${response.status} - ${response.message}');
    CustomSnackbar.show(
      title: AppStrings.titleError,
      message: response.message ?? 'Có lỗi xảy ra',
      backgroundColor: AppColors.errorColor,
    );
  }

  void onTopUp() {
    if (!formKey.currentState!.validate()) return;
    int amount = topUpMoneyController.numberValue.toInt();
    MomoProvider.instance.createPayment(amount: amount);
  }

  @override
  void onClose() {
    MomoProvider.instance.onClear();
  }

  String? validateTopUpMoney(String? value) {
    if (Utils.isEmpty(value)) {
      return AppMsg.MSG0002;
    }

    if (topUpMoneyController.numberValue <= 0) {
      return AppMsg.MSG0010;
    }

    if (topUpMoneyController.numberValue < 1000) {
      return 'Số tiền nạp tối thiểu là 1.000đ';
    }

    if (topUpMoneyController.numberValue > 10000000) {
      return 'Số tiền nạp tối đa là 10.000.000đ';
    }

    return null;
  }
}
