import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';

class PayByTaskWidget extends StatelessWidget {
  final double salary;
  final bool toolAvailable;
  const PayByTaskWidget(
      {Key? key, required this.salary, required this.toolAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardField(
          icon: CustomIcons.cash,
          title: AppStrings.labelTaskSalary,
          data: Utils.vietnameseCurrencyFormat.format(salary),
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.lucide_axe,
          title: AppStrings.labelTool,
          data: toolAvailable ? 'Có sẵn' : 'Không có sẵn',
        ),
      ],
    );
  }
}
