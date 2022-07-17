import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class LandownerMessageItem extends StatelessWidget {
  final String name;
  final String message;
  final DateTime? createdDate;
  final bool isRead;
  final String? avatar;
  final void Function()? onTap;

  const LandownerMessageItem({
    Key? key,
    required this.name,
    required this.message,
    this.createdDate,
    this.isRead = true,
    this.onTap,
    this.avatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            children: [
              CustomCircleAvatar(
                url: avatar,
                radius: 32,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.headline6!.copyWith(
                        color: AppColors.black,
                        fontWeight: isRead ? FontWeight.w500 : FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            message,
                            style: isRead
                                ? Get.textTheme.caption
                                : Get.textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          ' · ${Utils.formatMessageDateTime(createdDate ?? DateTime.now())}',
                          style: Get.textTheme.caption,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
