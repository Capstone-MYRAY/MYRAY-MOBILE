import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/rating_star.dart';

class AppliedFarmerCard extends StatelessWidget {
  final String? avatar;
  final String fullName;
  final String phone;
  final String workTitle;
  final DateTime appliedDate;
  const AppliedFarmerCard({
    Key? key,
    required this.fullName,
    required this.phone,
    required this.workTitle,
    required this.appliedDate,
    this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: avatar != null
                        ? NetworkImage(avatar!)
                        : const AssetImage(AppAssets.tempAvatar)
                            as ImageProvider,
                    radius: 24,
                  ),
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
                  const RatingStar(
                    itemCount: 5,
                    rating: 1.5,
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
                    icon: CustomIcons.calendar_range,
                    title: AppStrings.labelAppliedDate,
                    data: Utils.formatHHmmddMMyyyy(appliedDate),
                  ),
                  const SizedBox(height: 16.0),
                  FilledButton(
                    title: AppStrings.titleDetails,
                    onPressed: () {},
                    minWidth: Get.width * 0.3,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 4.0,
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
