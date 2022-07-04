import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';

class FarmerFeatureOptions extends StatelessWidget {
  const FarmerFeatureOptions({Key? key}) : super(key: key);

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
          onTap: () {},
        ),
        FeatureOption(
          icon: CustomIcons.work_history_outline,
          title: AppStrings.titleHistoryJob,
          subtitle: AppStrings.subtitleHistoryJob,
          onTap: () {},
        ),
        FeatureOption(
          icon: CustomIcons.account_heart_outline,
          title: AppStrings.titleFavorite,
          subtitle: AppStrings.subtitleFarmerFavorite,
          onTap: () {},
        ),
        FeatureOption(
          icon: CustomIcons.lock_outline,
          title: AppStrings.titlePassword,
          subtitle: AppStrings.subtitlePassword,
          onTap: () {},
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
