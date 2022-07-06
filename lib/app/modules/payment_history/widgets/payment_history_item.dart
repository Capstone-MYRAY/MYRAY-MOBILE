import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class PaymentHistoryItem extends StatelessWidget {
  const PaymentHistoryItem({Key? key}) : super(key: key);

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
                  '09:30 - 27/05/2022',
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
                        color: AppColors.successColor,
                      ),
                    ),
                    child: const Icon(
                      CustomIcons.currency_usd,
                      color: AppColors.successColor,
                      size: 24.0,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trả tiền cho bài đăng dài dài này nè dài lắm',
                          style: Get.textTheme.bodyText1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Số dư: 120.000đ',
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
              Text(
                '+15 điểm',
                style: Get.textTheme.bodyText1!.copyWith(
                  color: AppColors.errorColor,
                  fontSize: 11 * Get.textScaleFactor,
                ),
              ),
              Text(
                '-15.0000đ',
                style: Get.textTheme.headline6!.copyWith(
                  color: AppColors.primaryColor,
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
