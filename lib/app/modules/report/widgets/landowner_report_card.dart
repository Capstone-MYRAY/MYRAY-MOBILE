import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_status_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

import 'reported_user.dart';

class LandownerReportCard extends StatelessWidget {
  final String fullName;
  final String phone;
  final String workName;
  final DateTime createdDate;
  final String? statusName;
  final Color? statusColor;
  final String? avatar;
  final void Function()? onButtonTap;

  const LandownerReportCard({
    Key? key,
    required this.fullName,
    required this.phone,
    required this.workName,
    required this.createdDate,
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
          Row(
            children: [
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      'Người bị báo cáo',
                      style: Get.textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    ReportedUser(
                      fullName: fullName,
                      phone: phone,
                      avatar: avatar,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              Flexible(
                flex: 6,
                child: Column(
                  children: [
                    CardField(
                      icon: CustomIcons.briefcase_outline,
                      title: AppStrings.labelWorkName,
                      data: workName,
                    ),
                    const SizedBox(height: 8.0),
                    CardField(
                      icon: CustomIcons.calendar_range,
                      title: AppStrings.labelCreatedDate,
                      data: Utils.formatddMMyyyy(createdDate),
                      isCenter: true,
                    ),
                    const SizedBox(height: 8.0),
                    CardStatusField(
                      title: 'Trạng thái',
                      statusName: statusName ?? '',
                      backgroundColor: statusColor,
                      isExpanded: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          FilledButton(
            title: AppStrings.titleDetails,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            onPressed: onButtonTap,
          ),
        ],
      ),
    );
  }
}
