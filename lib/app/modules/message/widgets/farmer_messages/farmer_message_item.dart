import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class FarmerMessageItem extends StatelessWidget {
  final String title;
  final String name;
  final DateTime? createdDate;
  final bool isRead;
  final void Function()? onTap;

  const FarmerMessageItem({
    Key? key,
    required this.title,
    required this.name,
    this.createdDate,
    this.isRead = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1.0),
      child: Material(
        color: isRead
            ? Get.theme.primaryColor.withOpacity(0.2)
            : Get.theme.cardColor,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Get.textTheme.headline5,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      Utils.formatMessageDateTime(
                          createdDate ?? DateTime.now()),
                      style: Get.textTheme.caption,
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      CustomIcons.person,
                      size: 15,
                    ),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.subtitle2!.copyWith(
                          color: AppColors.iconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
