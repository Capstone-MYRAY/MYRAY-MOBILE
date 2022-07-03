import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class FeatureOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final void Function()? onTap;

  const FeatureOption({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        highlightColor: AppColors.greyOtp.withOpacity(0.5),
        splashColor: AppColors.successColor.withOpacity(0.2),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 12.0,
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
                        Text(
                          subtitle,
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
    );
  }
}
