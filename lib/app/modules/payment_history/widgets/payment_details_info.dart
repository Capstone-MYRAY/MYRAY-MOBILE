import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_field.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class PaymentDetailsInfo extends StatelessWidget {
  final String? paymentId;
  final double postingFee;
  final int numOfPostingDay;
  final double upgradingFee;
  final int numOfUpgradingDay;
  final double pointFee;
  final int usedPoint;
  final double total;
  final int earnedPoint;

  const PaymentDetailsInfo({
    Key? key,
    required this.postingFee,
    required this.numOfPostingDay,
    required this.pointFee,
    required this.usedPoint,
    required this.total,
    required this.earnedPoint,
    required this.upgradingFee,
    required this.numOfUpgradingDay,
    this.paymentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (paymentId != null) ...[
          const SizedBox(height: 8.0),
          Text(
            Utils.getPaymentId(paymentId!),
            style: Get.textTheme.bodyText1,
          ),
        ],
        const SizedBox(height: 8.0),
        PaymentField(
          title: 'Đăng bài',
          price: postingFee,
          unit: numOfPostingDay,
        ),
        if (numOfUpgradingDay != 0) ...[
          const SizedBox(height: 8.0),
          PaymentField(
            title: 'Nâng cấp',
            price: upgradingFee,
            unit: numOfUpgradingDay,
          ),
        ],
        if (usedPoint != 0) ...[
          const SizedBox(height: 8.0),
          PaymentField(
            title: 'Điểm đã dùng',
            price: pointFee,
            unit: usedPoint,
            priceColor: AppColors.primaryColor,
            unitString: 'điểm',
          ),
        ],
        const SizedBox(height: 4.0),
        const Divider(),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thanh toán',
              style: Get.textTheme.bodyText1,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '= ${Utils.vietnameseCurrencyFormat.format(total.abs())}',
                  style: Get.textTheme.caption!.copyWith(
                    color: AppColors.errorColor,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  '+$earnedPoint điểm',
                  style: Get.textTheme.caption!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
