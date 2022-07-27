import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_status_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class ReportFarmerCard extends StatelessWidget {
  final DateTime createdDate;
  final String content;
  final String? statusName;
  final Color? statusColor;
  final String? resolvedName;
  final DateTime? resolvedDate;
  final String? resolvedContent;

  const ReportFarmerCard({
    Key? key,
    required this.createdDate,
    required this.content,
    this.statusName,
    this.statusColor,
    this.resolvedName,
    this.resolvedDate,
    this.resolvedContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Thông tin báo cáo',
              style: Get.textTheme.headline6,
            ),
          ),
          const SizedBox(height: 8.0),
          CardField(
            title: AppStrings.labelCreatedDate,
            icon: CustomIcons.calendar_range,
            data: Utils.formatddMMyyyy(createdDate),
            isCenter: true,
          ),
          const SizedBox(height: 8.0),
          CardField(
            title: AppStrings.labelReportDescription,
            icon: CustomIcons.content_paste,
            data: content,
          ),
          const SizedBox(height: 8.0),
          CardStatusField(
            title: 'Trạng thái',
            statusName: statusName ?? '',
            backgroundColor: statusColor,
          ),
          if (resolvedName != null) ...[
            const SizedBox(height: 8.0),
            CardField(
              title: AppStrings.labelResolvedBy,
              icon: CustomIcons.account_outline,
              data: resolvedName!,
            ),
            const SizedBox(height: 8.0),
            CardField(
              title: AppStrings.labelResolvedDate,
              icon: CustomIcons.calendar_range,
              data: Utils.formatddMMyyyy(resolvedDate!),
              isCenter: true,
            ),
            const SizedBox(height: 8.0),
            CardField(
              title: AppStrings.labelResolvedContent,
              icon: CustomIcons.content_paste,
              data: resolvedContent!,
            ),
          ],
        ],
      ),
    );
  }
}
