import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_details_info.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/payment_field.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class PaymentDetailsInfoCard extends StatelessWidget {
  final String title;
  final String? paymentId;
  final double postingFee;
  final int numOfPostingDay;
  final double? upgradingFee;
  final int? numOfUpgradingDay;
  final double pointFee;
  final int usedPoint;
  final double total;
  final int earnedPoint;

  const PaymentDetailsInfoCard({
    Key? key,
    required this.title,
    required this.postingFee,
    required this.numOfPostingDay,
    required this.pointFee,
    required this.usedPoint,
    required this.total,
    required this.earnedPoint,
    this.upgradingFee,
    this.numOfUpgradingDay,
    this.paymentId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Get.textTheme.headline6,
          ),
          PaymentDetailsInfo(
            postingFee: postingFee,
            numOfPostingDay: numOfPostingDay,
            pointFee: pointFee,
            usedPoint: usedPoint,
            total: total,
            earnedPoint: earnedPoint,
            upgradingFee: upgradingFee ?? 0,
            numOfUpgradingDay: numOfUpgradingDay ?? 0,
            paymentId: paymentId,
          ),
        ],
      ),
    );
  }
}
