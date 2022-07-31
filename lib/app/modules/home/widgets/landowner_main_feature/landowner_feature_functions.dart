import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_main_feature/feature_function.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class LandownerFeatureFunctions extends StatelessWidget {
  const LandownerFeatureFunctions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: Get.width * 0.15,
      ),
      child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          shrinkWrap: true,
          childAspectRatio: 1,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FeatureFunction(
              title: AppStrings.titleMyGarden,
              icon: CustomIcons.sprout_outline,
              onTap: () async {
                //go to garden screen
                await Get.toNamed(Routes.gardenHome);
                final dashboardController = Get.find<DashboardController>();
                dashboardController.changeTabIndex(LandownerTabs.profile.index);
              },
            ),
            FeatureFunction(
              title: AppStrings.titlePaymentHistory,
              icon: CustomIcons.credit_card_outline,
              onTap: () async {
                //go to payment history screen
                await Get.toNamed(Routes.paymentHistoryHome);
                final dashboardController = Get.find<DashboardController>();
                dashboardController.changeTabIndex(LandownerTabs.profile.index);
              },
            ),
            FeatureFunction(
              title: AppStrings.payPerHour,
              icon: CustomIcons.bulletin_board,
              onTap: () {
                Get.toNamed(
                  Routes.landownerJobPostByType,
                  arguments: {Arguments.type: JobType.payPerHourJob.name},
                );
              },
            ),
            FeatureFunction(
              title: AppStrings.payPerTask,
              icon: CustomIcons.bulletin_board,
              onTap: () {
                Get.toNamed(
                  Routes.landownerJobPostByType,
                  arguments: {Arguments.type: JobType.payPerTaskJob.name},
                );
              },
            ),
          ]),
    );
  }
}
