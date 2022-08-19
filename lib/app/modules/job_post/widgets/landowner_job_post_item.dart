import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_status_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';

class LandownerJobPostItem extends StatelessWidget {
  final String title;
  final String address;
  final String workPayType;
  final String workType;
  final String? pinType;
  final String treeTypes;
  final DateTime publishedDate;
  final DateTime? expiredDate;
  final Color? postTypeForeground;
  final Color? postTypeBackground;
  final Color? postStatusBackground;
  final Color? postStatusForeground;
  final Color? workStatusBackground;
  final Color? workStatusForeground;
  final String postStatusString;
  final String workStatusString;

  final void Function() onDetailsPress;

  const LandownerJobPostItem({
    Key? key,
    required this.title,
    required this.address,
    required this.workPayType,
    required this.treeTypes,
    required this.publishedDate,
    required this.onDetailsPress,
    required this.postStatusString,
    required this.workStatusString,
    required this.workType,
    this.expiredDate,
    this.pinType,
    this.postTypeBackground,
    this.postTypeForeground,
    this.postStatusBackground,
    this.postStatusForeground,
    this.workStatusBackground,
    this.workStatusForeground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (pinType != null) ...[
            Align(
              alignment: Alignment.centerRight,
              child: StatusChip(
                backgroundColor: postTypeBackground,
                foregroundColor: postTypeForeground,
                statusName: pinType!,
              ),
            ),
            const SizedBox(height: 8.0),
          ],
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: Get.textTheme.headline4,
            ),
          ),
          const SizedBox(height: 12.0),
          CardField(
            icon: CustomIcons.briefcase_outline,
            title: AppStrings.labelWorkType,
            data: workType,
          ),
          const SizedBox(height: 12.0),
          CardField(
            icon: CustomIcons.map_marker_outline,
            title: AppStrings.labelAddress,
            data: address,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.bulletin_board,
            title: AppStrings.labelWorkPayType,
            data: workPayType,
            isCenter: true,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.tree_outline,
            title: AppStrings.labelTreeType,
            data: treeTypes.isEmpty ? 'Không phân loại' : treeTypes,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.calendar_range,
            title: AppStrings.labelPublishDate,
            data: Utils.formatddMMyyyy(publishedDate),
            isCenter: true,
          ),
          const SizedBox(height: 8.0),
          if (expiredDate != null)
            CardField(
              icon: CustomIcons.calendar_range,
              title: AppStrings.labelExpiryDate,
              data: Utils.formatddMMyyyy(expiredDate!),
            ),
          const SizedBox(height: 8.0),
          CardStatusField(
            title: AppStrings.labelPostStatus,
            statusName: postStatusString,
            backgroundColor: postStatusBackground,
          ),
          const SizedBox(height: 8.0),
          CardStatusField(
            title: AppStrings.labelWorkStatus,
            statusName: workStatusString,
            backgroundColor: workStatusBackground,
          ),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.center,
            child: FilledButton(
              minWidth: CommonConstants.buttonWidthSmall,
              title: AppStrings.titleDetails,
              onPressed: onDetailsPress,
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 4.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
