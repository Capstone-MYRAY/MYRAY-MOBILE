import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';

class FeatureFunction extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;

  const FeatureFunction({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.35,
        minHeight: Get.width * 0.35,
      ),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 32.0,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: Get.textTheme.bodyText1!.copyWith(
                      // color: AppColors.primaryColor,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
