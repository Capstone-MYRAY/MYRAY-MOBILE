import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';

class FarmerFeatureOptions extends StatelessWidget {

  final void Function()? attendance;
  final void Function()? history;
  final void Function()? bookmark;
  final void Function()? password;
  final void Function()? logout;
  final void Function()? appliedJob;

  const FarmerFeatureOptions({
    Key? key,
    this.attendance,
    this.history,
    this.bookmark,
    this.password,
    this.logout,
    this.appliedJob
  }) : super(key: key);

  _logout() {
    final AuthController _authController = Get.find<AuthController>();
    _authController.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeatureOption(
          icon: CustomIcons.calendar_check,
          title: AppStrings.titleCheckattendance,
          subtitle: AppStrings.subtitleCheckattendance,
          onTap: attendance,
        ),
        FeatureOption(
          icon: CustomIcons.work_history_outline,
          title: AppStrings.titleHistoryJob,
          subtitle: AppStrings.subtitleHistoryJob,
          onTap: history,
        ),
        FeatureOption(
          icon: Icons.history_toggle_off_outlined,
          title: AppStrings.titleAppliedJobPost,
          subtitle: AppStrings.subtitleAppliedJobPost,
          onTap: appliedJob,
        ),
        FeatureOption(
          icon: CustomIcons.account_heart_outline,
          title: AppStrings.titleFavorite,
          subtitle: AppStrings.subtitleFarmerFavorite,
          onTap: bookmark,
        ),
        FeatureOption(
          icon: CustomIcons.lock_outline,
          title: AppStrings.titlePassword,
          subtitle: AppStrings.subtitlePassword,
          onTap: password,
        ),
        FeatureOption(
          icon: CustomIcons.logout,
          title: AppStrings.titleLogout,
          subtitle: AppStrings.subtitleLogout,
          onTap: () => _logout(),
        ),
      ],
    );
  }
}
