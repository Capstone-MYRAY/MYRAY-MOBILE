import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/wating_approve_tab_controller.dart';
import 'package:myray_mobile/app/modules/applied_farmer/widgets/applied_farmer_list.dart';
import 'package:myray_mobile/app/modules/applied_farmer/widgets/extend_job_list.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';

class WaitingApproveView extends GetView<WaitingApproveTabController> {
  const WaitingApproveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.applied,
          textScaleFactor: 1,
        ),
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                AppliedFarmerList(),
                ExtendJobList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(top: 16.0),
      child: TabBar(
        controller: controller.tabController,
        tabs: controller.tabs,
        isScrollable: false,
        unselectedLabelStyle:
            Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400),
        unselectedLabelColor: AppColors.black,
        labelStyle: Get.textTheme.headline6,
        splashFactory: NoSplash.splashFactory,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: AppColors.white,
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        ),
      ),
    );
  }
}
