import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';
import 'package:myray_mobile/app/shared/widgets/rating_star.dart';

class FarmerAvatarInfo extends StatelessWidget {
  final String? avatar;
  final String role;
  final double? rating;
  final bool isBookmarked;
  final bool isChatButtonDisplayed;
  final String? statusName;
  final Color? statusColor;
  final void Function()? navigateToChatScreen;
  final void Function()? onFavoriteToggle;

  const FarmerAvatarInfo({
    Key? key,
    required this.role,
    this.avatar,
    this.rating,
    this.isBookmarked = false,
    this.isChatButtonDisplayed = true,
    this.statusName,
    this.statusColor,
    this.navigateToChatScreen,
    this.onFavoriteToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCircleAvatar(
          url: avatar,
          radius: Get.width * 0.2,
        ),
        const SizedBox(height: 16.0),
        Text(
          role,
          style: Get.textTheme.subtitle1!.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w300,
            fontSize: 16 * Get.textScaleFactor,
          ),
        ),
        const SizedBox(height: 2.0),
        RatingStar(
          itemSize: 28.0,
          rating: rating ?? 0.0,
        ),
        const SizedBox(height: 16.0),
        if (statusName != null && statusColor != null)
          StatusChip(
            borderRadius: 20.0,
            statusName: statusName ?? '',
            backgroundColor: statusColor,
          ),
        const SizedBox(height: 16.0),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal:
                isChatButtonDisplayed ? Get.width * 0.1 : Get.width * 0.3,
          ),
          child: Row(
            children: [
              Expanded(child: _buildBookmarkButtons()),
              if (isChatButtonDisplayed) ...[
                const SizedBox(width: 16),
                Expanded(child: _buildChatButton())
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatButton() {
    return SizedBox(
      child: ElevatedButton.icon(
        icon: const Icon(CustomIcons.chat, size: 24.0),
        label: const Text(AppStrings.messageButton),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
        ),
        onPressed: navigateToChatScreen,
      ),
    );
  }

  Widget _buildBookmarkButtons() {
    if (isBookmarked) {
      return SizedBox(
        child: TextButton.icon(
          icon: const Icon(CustomIcons.heart, size: 24.0),
          label: const Text('Bỏ thích'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.errorColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.errorColor),
              borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            ),
          ),
          onPressed: onFavoriteToggle,
        ),
      );
    }

    return SizedBox(
      child: ElevatedButton.icon(
        icon: const Icon(CustomIcons.heart, size: 24.0),
        label: const Text(AppStrings.titleFavorite),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          backgroundColor: AppColors.errorColor,
          foregroundColor: AppColors.white,
          // foregroundColor: AppColors.white,
        ),
        onPressed: onFavoriteToggle,
      ),
    );
  }
}
