import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';

class ToggleController extends GetxController {
  RxBool isOpen = false.obs;

  void toggle() => isOpen.value = !isOpen.value;
}

class ToggleHeader extends StatelessWidget {
  final void Function() onTap;
  final bool isOpen;
  final String title;
  const ToggleHeader({
    Key? key,
    required this.onTap,
    required this.isOpen,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
        ),
        width: Get.width * 0.9,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: Get.textTheme.headline6!.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              isOpen ? CustomIcons.menu_up : CustomIcons.menu_down,
              color: AppColors.white,
              size: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
