import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';
import 'package:myray_mobile/app/shared/widgets/rating_star.dart';

class FarmerAvatarInfo extends StatelessWidget {
  final String? avatar;
  final String role;
  final double? rating;
  final bool isBookmarked;
  final void Function()? navigateToChatScreen;
  final void Function()? onFavoriteToggle;

  const FarmerAvatarInfo({
    Key? key,
    required this.role,
    this.avatar,
    this.rating,
    this.isBookmarked = false,
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
        FractionallySizedBox(
          widthFactor: 0.3,
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
        ),
        const SizedBox(height: 8.0),
        _buildBookmarkButtons(),
      ],
    );
  }

  Widget _buildBookmarkButtons() {
    if (isBookmarked) {
      return FractionallySizedBox(
        widthFactor: 0.3,
        child: TextButton.icon(
          icon: const Icon(CustomIcons.heart, size: 24.0),
          label: const Text('Bỏ thích'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            primary: AppColors.errorColor,
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.errorColor),
              borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
            ),
          ),
          onPressed: onFavoriteToggle,
        ),
      );
    }

    return FractionallySizedBox(
      widthFactor: 0.3,
      child: ElevatedButton.icon(
        icon: const Icon(CustomIcons.heart, size: 24.0),
        label: const Text('Yêu thích'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          primary: AppColors.errorColor,
        ),
        onPressed: onFavoriteToggle,
      ),
    );
  }
}
