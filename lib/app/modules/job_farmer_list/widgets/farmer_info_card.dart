import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class FarmerInfoCard extends StatelessWidget {
  final String fullName;
  final String phone;
  final String? statusName;
  final Color? statusColor;
  final String? avatar;
  final bool isDisplayEllipsis;
  final void Function()? onButtonTap;
  final void Function() onFinish;
  final void Function() onFired;

  const FarmerInfoCard({
    Key? key,
    required this.fullName,
    required this.phone,
    required this.onFinish,
    required this.onFired,
    this.isDisplayEllipsis = false,
    this.statusName,
    this.statusColor,
    this.avatar,
    this.onButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        children: [
          if (statusName != null && statusColor != null)
            Align(
              alignment: Alignment.centerRight,
              child: StatusChip(
                statusName: statusName!,
                backgroundColor: statusColor,
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CustomCircleAvatar(
                      url: avatar,
                      radius: 28.0,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName,
                            style: Get.textTheme.bodyText1,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            phone,
                            style: Get.textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (isDisplayEllipsis)
                PopupMenuButton<int>(
                  onSelected: (value) {
                    if (value == AppliedFarmerStatus.end.index) {
                      onFinish();
                    } else {
                      onFired();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: AppliedFarmerStatus.end.index,
                      child: const Text('Hoàn thành'),
                    ),
                    PopupMenuItem(
                      value: AppliedFarmerStatus.fired.index,
                      child: const Text('Sa thải'),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16.0),
          FractionallySizedBox(
            widthFactor: 0.4,
            child: FilledButton(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              title: AppStrings.titleDetails,
              onPressed: onButtonTap,
            ),
          )
        ],
      ),
    );
  }
}
