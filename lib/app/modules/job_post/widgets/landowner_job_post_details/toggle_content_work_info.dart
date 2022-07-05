import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';

class ToggleContentWorkInfo extends StatelessWidget {
  const ToggleContentWorkInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardField(
          icon: CustomIcons.briefcase_outline,
          title: AppStrings.labelWorkName,
          data: 'test data',
        ),
        CardField(
          icon: CustomIcons.bulletin_board,
          title: AppStrings.labelWorkType,
          data: 'test data',
        ),
        CardField(
          icon: CustomIcons.tree_outline,
          title: AppStrings.labelTreeType,
          data: 'test data',
        ),
        CardField(
          icon: CustomIcons.lucide_axe,
          title: AppStrings.labelEstimateWork,
          data: 'test data',
        ),
        CardField(
          icon: CustomIcons.account_outline,
          title: AppStrings.labelEstimateFarmer,
          data: 'test data',
        ),
        CardField(
          icon: CustomIcons.cash,
          title: AppStrings.labelHourSalary,
          data: 'test data',
        ),
      ],
    );
  }
}
