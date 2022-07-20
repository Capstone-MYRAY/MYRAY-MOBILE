import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/custom_circle_avatar.dart';

class CheckAttendanceCard extends StatelessWidget {
  final String fullName;
  final String phone;
  final String? avatar;
  final String? statusName;
  final bool isControlDisplayed;
  final String? reason;
  const CheckAttendanceCard({
    Key? key,
    required this.fullName,
    required this.phone,
    this.avatar,
    this.statusName,
    this.isControlDisplayed = false,
    this.reason,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: MyCard(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 8.0,
          left: 32.0,
          right: 32.0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomCircleAvatar(
                  url: avatar,
                  radius: 24,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: Get.textTheme.headline6!.copyWith(
                          color: AppColors.black,
                        ),
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
            if (isControlDisplayed == true)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 10 / 3,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    FilledButton(
                      title: 'Vắng mặt',
                      onPressed: () {},
                      color: AppColors.errorColor,
                    ),
                    FilledButton(
                      title: 'Có mặt',
                      onPressed: () {},
                    ),
                    FilledButton(
                      title: 'Kết thúc',
                      onPressed: () {},
                      color: AppColors.errorColor,
                    ),
                    FilledButton(
                      title: 'Hoàn thành',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            if (reason != null)
              CardField(
                icon: CustomIcons.content_paste,
                title: 'Lý do',
                data: reason ?? '',
              ),
            if (!isControlDisplayed)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: StatusChip(statusName: statusName ?? ''),
              ),
          ],
        ),
      ),
    );
  }
}
