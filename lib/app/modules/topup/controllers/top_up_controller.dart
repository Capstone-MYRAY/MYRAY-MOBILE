import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/environment.dart';
import 'package:myray_mobile/app/data/providers/momo/momo_provider.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/auth_credentials.dart';
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
  }

  void onTopUp() async {
    if (!formKey.currentState!.validate()) return;
    int amount = topUpMoneyController.numberValue.toInt();
    final accountId = AuthCredentials.instance.user!.id;
    try {
      MomoProvider.instance.createPayment(
        amount: amount,
        orderInfo: 'Nạp tiền vào tài khoản MYRAY',
        ipnUrl: '${Environment.apiUrl}/account/topup',
        redirectUrl: 'myray://paymentResult',
        requestType: MomoRequestType.captureWallet.name,
        extraData: {'accountId': accountId.toString()},
      );
    } catch (e) {
      CustomSnackbar.show(
        title: AppStrings.titleError,
        message: 'Giao dịch thất bại',
        backgroundColor: AppColors.errorColor,
      );
    }
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
