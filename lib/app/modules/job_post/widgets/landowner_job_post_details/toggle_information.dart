import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/toggle_controller.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/landowner_job_post_details/toggle_header.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class ToggleInformation extends GetView<ToggleController> {
  final String tagName;
  const ToggleInformation({Key? key, required this.tagName}) : super(key: key);

  @override
  String? get tag => tagName;

  @override
  Widget build(BuildContext context) {
    return ObxValue<RxBool>(
        (isOpen) => _buildContent(isOpen.value), controller.isOpen);
  }

  _buildContent(bool isOpen) {
    return Column(
      children: [
        ToggleHeader(onTap: () => controller.toggle(), isOpen: isOpen),
        if (isOpen)
          MyCard(
            margin: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.titleWorkInformation,
                  style: Get.textTheme.headline6,
                ),
                const SizedBox(height: 8.0),
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
            ),
          ),
      ],
    );
  }
}
