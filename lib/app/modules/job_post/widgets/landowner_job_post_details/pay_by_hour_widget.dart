import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';

class PayByHourWidget extends StatelessWidget {
  final String estimateWork;
  final String estimateFarmer;
  final double salary;
  final String workingTime;
  const PayByHourWidget({
    Key? key,
    required this.estimateFarmer,
    required this.estimateWork,
    required this.salary,
    required this.workingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardField(
          icon: CustomIcons.lucide_axe,
          title: AppStrings.labelEstimateWork,
          data: estimateWork,
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.account_outline,
          title: AppStrings.labelEstimateFarmer,
          data: estimateFarmer,
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.cash,
          title: AppStrings.labelHourSalary,
          data: Utils.vietnameseCurrencyFormat.format(salary),
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: Icons.timer_outlined,
          title: AppStrings.labelWorkingTime,
          data: workingTime,
        ),
      ],
    );
  }
}
