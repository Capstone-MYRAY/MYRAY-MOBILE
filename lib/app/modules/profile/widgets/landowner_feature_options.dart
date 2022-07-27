import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/auth/controllers/auth_controller.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/cards/feature_option.dart';

class LandownerFeatureOptions extends StatelessWidget {
  const LandownerFeatureOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeatureOption(
          icon: CustomIcons.sprout_outline,
          title: AppStrings.titleMyGarden,
          subtitle: AppStrings.subtitleMyGarden,
          onTap: () => Get.toNamed(Routes.gardenHome),
        ),
        _buildDivider(),
        FeatureOption(
          icon: CustomIcons.credit_card_outline,
          title: AppStrings.titlePaymentHistory,
          subtitle: AppStrings.subtitlePaymentHistory,
          onTap: () => Get.toNamed(Routes.paymentHistoryHome),
        ),
        _buildDivider(),
        FeatureOption(
          icon: CustomIcons.account_heart_outline,
          title: AppStrings.titleFavorite,
          subtitle: AppStrings.subtitleLandownerFavorite,
          onTap: () => Get.toNamed(Routes.landownerBookmark),
        ),
        _buildDivider(),
        FeatureOption(
          icon: CustomIcons.shield_alert,
          title: AppStrings.titleReport,
          subtitle: AppStrings.subtitleLandownerReport,
          onTap: () {},
        ),
        _buildDivider(),
        FeatureOption(
          icon: CustomIcons.post_outline,
          title: AppStrings.titleGuidepost,
          subtitle: AppStrings.subtitleGuidepost,
          onTap: () {
            Get.toNamed(Routes.guidepost);
          },
        ),
        _buildDivider(),
        FeatureOption(
          icon: CustomIcons.lock_outline,
          title: AppStrings.labelPassword,
          subtitle: AppStrings.subtitleChangePassword,
          onTap: () {},
        ),
        _buildDivider(),
        FeatureOption(
          icon: CustomIcons.logout,
          title: AppStrings.titleLogout,
          subtitle: AppStrings.subtitleLogout,
          onTap: () {
            final AuthController authController = Get.find<AuthController>();
            authController.logOut();
          },
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      thickness: 0.1,
      color: AppColors.backgroundColor,
    );
  }
}
