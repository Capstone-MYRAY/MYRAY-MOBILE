import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/payment_history/widgets/currency_icon.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class PaymentHistoryItem extends StatelessWidget {
  /// HH:mm - dd/MM/yyyy
  final DateTime issuedDate;
  final String title;
  final double balance;
  final int point;
  final double balanceFructuation;
  final Color iconColor;
  final void Function()? onTap;

  const PaymentHistoryItem({
    Key? key,
    required this.issuedDate,
    required this.title,
    required this.balance,
    required this.point,
    required this.balanceFructuation,
    required this.iconColor,
    this.onTap,
  }) : super(key: key);

  String get _pointSign => point.isNegative ? '' : '+';
  String get _balanceFructuationSign =>
      balanceFructuation.isNegative ? '' : '+';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 12.0,
                left: 4.0,
                right: 8.0,
              ),
              decoration: const BoxDecoration(
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
                      CurrencyIcon(iconColor: iconColor),
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
        ),
      ),
    );
  }
}
