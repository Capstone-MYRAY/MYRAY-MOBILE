import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class FeatureOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final double widthFactor;
  final double borderRadius;
  final void Function()? onTap;

  const FeatureOption({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.widthFactor = 1.0,
    this.borderRadius = 0.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppColors.white,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          // highlightColor: AppColors.greyOtp.withOpacity(0.5),
          // splashColor: AppColors.successColor.withOpacity(0.2),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: subtitle != null ? 12.0 : 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: AppColors.featureColor,
                        size: 24.0,
                      ),
                      const SizedBox(width: 8.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: Get.textTheme.headline6),
                          const SizedBox(height: 2),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: Get.textTheme.subtitle2!.copyWith(
                                color: AppColors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                Icon(
                  CustomIcons.chevron_right,
                  color: AppColors.featureColor,
                  size: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
