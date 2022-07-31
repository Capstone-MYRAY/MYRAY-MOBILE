import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';
import 'package:myray_mobile/app/shared/widgets/rating_star.dart';

class AppliedFarmerCard extends StatelessWidget {
  final String? avatar;
  final String fullName;
  final String phone;
  final String workTitle;
  final String workType;
  final DateTime appliedDate;
  final double? rating;
  final void Function()? onDetailsPress;

  const AppliedFarmerCard({
    Key? key,
    required this.fullName,
    required this.phone,
    required this.workTitle,
    required this.appliedDate,
    required this.workType,
    this.rating,
    this.onDetailsPress,
    this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    CustomCircleAvatar(url: avatar, radius: 28),
                    const SizedBox(height: 4.0),
                    Text(
                      fullName,
                      textAlign: TextAlign.center,
                      style: Get.textTheme.bodyText1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      phone,
                      style: Get.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 2),
                    RatingStar(
                      itemCount: 5,
                      rating: rating ?? 0.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 6,
                child: Column(
                  children: [
                    CardField(
                      icon: CustomIcons.briefcase_outline,
                      title: AppStrings.labelWorkName,
                      data: workTitle,
                    ),
                    const SizedBox(height: 8.0),
                    CardField(
                      icon: CustomIcons.bulletin_board,
                      title: AppStrings.labelWorkType,
                      data: workType,
                      isCenter: true,
                    ),
                    const SizedBox(height: 8.0),
                    CardField(
                      icon: CustomIcons.calendar_range,
                      title: AppStrings.labelAppliedDate,
                      data: Utils.formatHHmmddMMyyyy(appliedDate),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: Get.width * 0.3,
            child: FilledButton(
              title: AppStrings.titleDetails,
              onPressed: onDetailsPress,
              minWidth: Get.width * 0.3,
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 4.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
