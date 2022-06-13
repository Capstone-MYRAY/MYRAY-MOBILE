import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/tabs.dart';
import 'package:myray_mobile/app/modules/applied_job/views/applied_job_view.dart';
import 'package:myray_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:myray_mobile/app/modules/job_post/views/farmer_job_post_view.dart';
import 'package:myray_mobile/app/modules/message/views/farmer_message_view.dart';
import 'package:myray_mobile/app/modules/profile/views/farmer_profile_view.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class FarmerDashboardView extends StatelessWidget {
  const FarmerDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: const [
              FarmerProfileView(),
              FarmerJobPostView(),
              AppliedJobView(),
              FarmerMessageView(),
              FarmerProfileView(),
            ],
          ),
          bottomNavigationBar: Theme(
            //remove splash color
            data: Get.theme.copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: controller.changeTabIndex,
              currentIndex: controller.tabIndex,
              items: [
                _bottomNavbarItem(
                  icon: controller.tabIndex == farmerTabs.home.index
                      ? CustomIcons.home
                      : CustomIcons.home_outline,
                  label: AppStrings.home,
                ),
                _bottomNavbarItem(
                  icon: controller.tabIndex == farmerTabs.jobPost.index
                      ? CustomIcons.briefcase
                      : CustomIcons.briefcase_outline,
                  label: AppStrings.jobPost,
                ),
                _bottomNavbarItem(
                  icon: controller.tabIndex == farmerTabs.appliedJob.index
                      ? CustomIcons.account_clock
                      : CustomIcons.account_clock_outline,
                  label: AppStrings.applied,
                ),
                _bottomNavbarItem(
                  icon: controller.tabIndex == farmerTabs.message.index
                      ? CustomIcons.chat
                      : CustomIcons.chat_outline,
                  label: AppStrings.message,
                ),
                _bottomNavbarItem(
                  icon: controller.tabIndex == farmerTabs.profile.index
                      ? CustomIcons.account_circle
                      : CustomIcons.account_circle,
                  label: AppStrings.profile,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  _bottomNavbarItem({required IconData icon, String? label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
