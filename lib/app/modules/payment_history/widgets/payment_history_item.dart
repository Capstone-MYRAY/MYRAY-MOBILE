import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class PaymentHistoryItem extends StatelessWidget {
  /// HH:mm - dd/MM/yyyy
  final DateTime issuedDate;
  final String title;
  final double balance;
  final int point;
  final double balanceFructuation;
  final Color iconColor;

  const PaymentHistoryItem({
    Key? key,
    required this.issuedDate,
    required this.title,
    required this.balance,
    required this.point,
    required this.balanceFructuation,
    required this.iconColor,
  }) : super(key: key);

  String get _pointSign => point.isNegative ? '' : '+';
  String get _balanceFructuationSign =>
      balanceFructuation.isNegative ? '' : '+';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 12.0,
            left: 4.0,
            right: 8.0,
          ),
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              bottom: BorderSide(
                color: AppColors.backgroundColor,
              ),
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  Utils.formatHHmmddMMyyyy(issuedDate),
                  style: Get.textTheme.caption!.copyWith(
                    fontSize: 11 * Get.textScaleFactor,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        width: 1,
                        color: iconColor,
                      ),
                    ),
                    child: Icon(
                      CustomIcons.currency_usd,
                      color: iconColor,
                      size: 24.0,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Get.textTheme.bodyText1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Số dư: ${Utils.vietnameseCurrencyFormat.format(balance)}',
                          style: Get.textTheme.caption!.copyWith(
                            fontSize: 11 * Get.textScaleFactor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 8.0,
          right: 8.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (point != 0)
                Text(
                  '$_pointSign$point điểm',
                  style: Get.textTheme.bodyText1!.copyWith(
                    color: point.isNegative
                        ? AppColors.errorColor
                        : AppColors.successColor,
                    fontSize: 11 * Get.textScaleFactor,
                  ),
                ),
              Text(
                '$_balanceFructuationSign ${Utils.vietnameseCurrencyFormat.format(balanceFructuation)}',
                style: Get.textTheme.headline6!.copyWith(
                  color: balanceFructuation.isNegative
                      ? AppColors.errorColor
                      : AppColors.primaryColor,
                  fontSize: 13 * Get.textScaleFactor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
