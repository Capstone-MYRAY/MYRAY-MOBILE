import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:signature/signature.dart';

class CheckAttendanceDialog {
  static Future<bool?> show(
      double salary, SignatureController controller) async {
    return await Get.dialog(
      Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
            margin: EdgeInsets.symmetric(
              horizontal: Get.width * 0.1,
              vertical: Get.height * 0.1,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Điểm danh',
                    style: Get.textTheme.headline4!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                CardField(
                  icon: CustomIcons.cash,
                  title: AppStrings.labelTaskSalary,
                  data: Utils.vietnameseCurrencyFormat.format(salary),
                  isCenter: true,
                ),
                const SizedBox(height: 8.0),
                const CardField(
                  icon: CustomIcons.gift_open_outline,
                  title: 'Điểm nhận được',
                  data: '1 điểm',
                  isCenter: true,
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Ký xác nhận',
                  style: Get.textTheme.headline6,
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.9 - 40,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black),
                      borderRadius: BorderRadius.circular(
                        CommonConstants.borderRadius,
                      ),
                    ),
                    child: Stack(
                      children: [
                        ClipRect(
                          child: Signature(
                            controller: controller,
                            backgroundColor: AppColors.white,
                          ),
                        ),
                        Positioned(
                          top: 2.0,
                          right: 2.0,
                          child: GestureDetector(
                            onTap: () => controller.clear(),
                            child: const Icon(Icons.clear),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                FilledButton(
                  title: 'Điểm danh',
                  onPressed: () => Get.back(result: true),
                ),
              ],
            ),
          ),
          Positioned(
            top: Get.height * 0.1 + 16,
            right: Get.width * 0.1 + 16,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(Icons.clear),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}