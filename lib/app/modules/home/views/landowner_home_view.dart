import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/widgets/feature_function.dart';
import 'package:myray_mobile/app/modules/home/widgets/landowner_current_job/landowner_current_start_jobs_section.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

import '../controllers/landowner_home_controller.dart';

class LandownerHomeView extends GetView<LandownerHomeController> {
  const LandownerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.home,
          textScaleFactor: 1,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
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
                      onTap: () {},
                    ),
                    FeatureFunction(
                      title: AppStrings.titlePaymentHistory,
                      icon: CustomIcons.credit_card_outline,
                      onTap: () {},
                    ),
                    FeatureFunction(
                      title: AppStrings.payPerHour,
                      icon: CustomIcons.bulletin_board,
                      onTap: () {},
                    ),
                    FeatureFunction(
                      title: AppStrings.payPerTask,
                      icon: CustomIcons.bulletin_board,
                      onTap: () {},
                    ),
                  ]),
            ),
            const LandownerCurrentStartJobsSection(),
          ],
        ),
      ),
    );
  }
}
