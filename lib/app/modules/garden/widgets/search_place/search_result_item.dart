import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';

class SearchResultItem extends StatelessWidget {
  final String address;
  final String mainText;
  final void Function()? onTap;

  const SearchResultItem({
    Key? key,
    required this.address,
    required this.mainText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.backgroundColor),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomIconButton(
              icon: CustomIcons.map_marker_outline,
              shape: CircleBorder(),
              isSplash: false,
              foregroundColor: AppColors.white,
              backgroundColor: AppColors.primaryColor,
              padding: EdgeInsets.all(4.0),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainText,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodyText1,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    address,
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
