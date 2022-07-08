import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class PaymentField extends StatelessWidget {
  final String title;
  final double price;
  final int unit;
  final String unitString;
  final Color priceColor;
  const PaymentField({
    Key? key,
    required this.title,
    required this.price,
    this.priceColor = AppColors.errorColor,
    this.unitString = 'ngày',
    this.unit = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Get.textTheme.bodyText1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${Utils.vietnameseCurrencyFormat.format(price)} x $unit ($unitString)',
              style: Get.textTheme.caption,
            ),
            Text(
              '= ${Utils.vietnameseCurrencyFormat.format(price * unit)}',
              style: Get.textTheme.caption!.copyWith(
                color: priceColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
