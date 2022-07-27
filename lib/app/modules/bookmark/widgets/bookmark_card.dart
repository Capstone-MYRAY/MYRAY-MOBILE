import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class BookmarkCard extends StatelessWidget {
  final String? avatar;
  final String? fullName;
  final String? phone;
  final bool isBookmarked;
  final void Function() onToggleBookmark;
  final void Function()? onViewDetails;

  const BookmarkCard({
    Key? key,
    this.avatar,
    this.fullName,
    this.phone,
    this.onViewDetails,
    this.isBookmarked = true,
    required this.onToggleBookmark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      onTap: onViewDetails,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CustomCircleAvatar(
            url: avatar,
            radius: 36.0,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName ?? '',
                  style: Get.textTheme.bodyText1,
                ),
                const SizedBox(height: 4.0),
                Text(
                  phone ?? '',
                  style: Get.textTheme.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          CustomIconButton(
            icon: isBookmarked ? CustomIcons.heart : CustomIcons.heart_outline,
            onTap: onToggleBookmark,
            size: 30.0,
            isSplash: false,
            toolTip: isBookmarked ? 'Bỏ thích' : AppStrings.titleFavorite,
            foregroundColor: AppColors.errorColor,
          ),
        ],
      ),
    );
  }
}
