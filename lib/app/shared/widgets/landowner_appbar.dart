import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/profile/controllers/landowner_profile_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';

class LandownerAppbar extends GetView<LandownerProfileController>
    implements PreferredSizeWidget {
  final Widget title;
  const LandownerAppbar({
    Key? key,
    required this.title,
  }) : super(key: key);

  _buildField(
      {required String title,
      required IconData icon,
      required String details}) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.iconColor,
        ),
        const SizedBox(width: 2.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Get.textTheme.subtitle2!.copyWith(
                color: AppColors.primaryColor,
                fontSize: 10,
              ),
              textScaleFactor: 1.0,
            ),
            Text(
              details,
              style: Get.textTheme.bodyText2!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textScaleFactor: 1.0,
            ),
          ],
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: [
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2.0),
              _buildField(
                  icon: CustomIcons.wallet_outline,
                  title: 'Số dư',
                  details: controller.user.value.balance != null
                      ? Utils.vietnameseCurrencyFormat
                          .format(controller.balanceWithPending.value)
                      : AppStrings.loading),
              _buildField(
                icon: CustomIcons.gift_open_outline,
                title: 'Điểm',
                details: controller.user.value.point != null
                    ? Utils.threeDigitsFormat
                        .format(controller.pointWithPending.value)
                    : AppStrings.loading,
              ),
            ],
          ),
        ),
        CustomIconButton(
          icon: Icons.sync,
          toolTip: AppStrings.tooltipUpdateBalance,
          onTap: controller.getUserInfor,
          padding: const EdgeInsets.only(right: 8.0),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
