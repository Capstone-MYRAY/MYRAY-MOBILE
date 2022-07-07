import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/currency_icon.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class PaymentBasicInfo extends StatelessWidget {
  final Color iconColor;
  final bool isMe;
  final double balanceFluctuation;
  final String paymentId;

  const PaymentBasicInfo({
    Key? key,
    required this.iconColor,
    required this.balanceFluctuation,
    required this.paymentId,
    this.isMe = true,
  }) : super(key: key);

  String get _balanceFructuationSign =>
      balanceFluctuation.isNegative ? '' : '+';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CurrencyIcon(
          iconColor: iconColor,
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 10.0,
          ),
          iconSize: 26.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isMe ? 'Thanh toán' : 'Nhận tiền',
              style: Get.textTheme.caption!.copyWith(
                fontSize: 12 * Get.textScaleFactor,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              '$_balanceFructuationSign${Utils.vietnameseCurrencyFormat.format(balanceFluctuation)}',
              style: Get.textTheme.headline6!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15 * Get.textScaleFactor,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              'Mã giao dịch: ${Utils.getPaymentId(paymentId)}',
              style: Get.textTheme.caption!.copyWith(
                fontSize: 12 * Get.textScaleFactor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
