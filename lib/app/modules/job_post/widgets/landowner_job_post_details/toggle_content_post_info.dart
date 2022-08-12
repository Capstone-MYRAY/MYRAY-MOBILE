import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_status_field.dart';

class ToggleContentPostInfo extends StatelessWidget {
  final DateTime createdDate;
  final DateTime publishedDate;
  final DateTime? publishExpiryDate;
  final CardStatusField postStatus;
  final CardStatusField? postType;
  final DateTime? approvedDate;
  final String? approvedBy;
  final String? rejectedReason;
  final DateTime? upgradedDate;
  final DateTime? upgradeExpiryDate;

  const ToggleContentPostInfo({
    Key? key,
    required this.createdDate,
    required this.publishedDate,
    required this.postStatus,
    this.publishExpiryDate,
    this.postType,
    this.approvedBy,
    this.approvedDate,
    this.rejectedReason,
    this.upgradedDate,
    this.upgradeExpiryDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardField(
          icon: CustomIcons.calendar_range,
          title: AppStrings.labelCreatedDate,
          data: Utils.formatddMMyyyy(createdDate),
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.calendar_range,
          title: AppStrings.labelPublishDate,
          data: Utils.formatddMMyyyy(publishedDate),
        ),
        const SizedBox(height: 8.0),
        if (publishExpiryDate != null)
          CardField(
            icon: CustomIcons.calendar_range,
            title: AppStrings.labelExpiryDate,
            data: Utils.formatddMMyyyy(publishExpiryDate!),
          ),
        const SizedBox(height: 8.0),
        postStatus,
        if (postType != null) ..._buildPinInfo(),
        if (approvedBy != null) ..._buildApprovedBy(),
      ],
    );
  }

  List<Widget> _buildPinInfo() {
    return [
      const SizedBox(height: 8.0),
      postType!,
      const SizedBox(height: 8.0),
      CardField(
        icon: CustomIcons.calendar_range,
        title: AppStrings.labelUpgradeDate,
        data: Utils.formatddMMyyyy(publishedDate),
      ),
      const SizedBox(height: 8.0),
      CardField(
        icon: CustomIcons.calendar_range,
        title: AppStrings.labelExpiryDate,
        data: Utils.formatddMMyyyy(upgradeExpiryDate!),
      ),
    ];
  }

  List<Widget> _buildApprovedBy() {
    bool isRejected = rejectedReason != null;
    return [
      const SizedBox(height: 8.0),
      CardField(
        icon: CustomIcons.account_outline,
        title: isRejected
            ? AppStrings.labelRejectedBy
            : AppStrings.labelApprovedBy,
        data: approvedBy!,
      ),
      const SizedBox(height: 8.0),
      CardField(
        icon: CustomIcons.calendar_range,
        title: isRejected
            ? AppStrings.labelRejectedDate
            : AppStrings.labelApprovedDate,
        data: Utils.formatddMMyyyy(approvedDate!),
      ),
      const SizedBox(height: 8.0),
      if (isRejected)
        CardField(
          icon: Icons.paste,
          title: AppStrings.labelRejectedReason,
          data: rejectedReason!,
        ),
    ];
  }
}
