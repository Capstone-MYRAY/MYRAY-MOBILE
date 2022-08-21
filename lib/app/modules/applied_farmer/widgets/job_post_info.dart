import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class JobPostInfo extends StatelessWidget {
  final String gardenName;
  final String workType;
  final String title;
  final String workPayType;
  final int approvedFarmer;
  final int? maxFarmer;

  const JobPostInfo({
    Key? key,
    required this.title,
    required this.workType,
    required this.gardenName,
    required this.workPayType,
    required this.approvedFarmer,
    this.maxFarmer,
  }) : super(key: key);

  Color get totalColor {
    int max = maxFarmer ?? 1;
    if (approvedFarmer < max) {
      return AppColors.errorColor;
    } else {
      return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyCard(
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Thông tin bài đăng',
            textAlign: TextAlign.start,
            style: Get.textTheme.headline6,
          ),
          const SizedBox(height: 16.0),
          CardField(
            title: AppStrings.labelWorkName,
            data: title,
            icon: CustomIcons.briefcase_outline,
          ),
          const SizedBox(height: 8.0),
          CardField(
            title: AppStrings.labelWorkType,
            data: workType,
            icon: CustomIcons.briefcase_outline,
          ),
          const SizedBox(height: 8.0),
          CardField(
            title: AppStrings.labelWorkPayType,
            data: workType,
            icon: CustomIcons.bulletin_board,
          ),
          const SizedBox(height: 8.0),
          CardField(
            title: AppStrings.labelGardenName,
            data: gardenName,
            icon: CustomIcons.sprout_outline,
          ),
          const SizedBox(height: 8.0),
          RichText(
            textScaleFactor: Get.textScaleFactor,
            text: TextSpan(
              style: Get.textTheme.bodyText1,
              text: 'Số người đã nhận: ',
              children: <TextSpan>[
                TextSpan(
                  text: '$approvedFarmer/${maxFarmer ?? 1}',
                  style: Get.textTheme.bodyText1!.copyWith(
                    color: totalColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
