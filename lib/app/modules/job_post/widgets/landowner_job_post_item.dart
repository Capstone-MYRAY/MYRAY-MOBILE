import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/tree_jobs/tree_jobs.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';

class LandownerJobPostItem extends StatelessWidget {
  final String title;
  final String address;
  final String workType;
  final String? pinType;
  final List<TreeJobs> treeTypes;
  final DateTime publishedDate;
  final DateTime? expiredDate;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final void Function() onDetailsPress;

  const LandownerJobPostItem({
    Key? key,
    required this.title,
    required this.address,
    required this.workType,
    required this.treeTypes,
    required this.publishedDate,
    required this.onDetailsPress,
    this.expiredDate,
    this.pinType,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  String get _treeType {
    if (treeTypes.isEmpty) {
      return '';
    }

    if (treeTypes.length == 1) {
      return treeTypes.first.type!;
    }

    final buffer = StringBuffer();

    for (int i = 0; i < treeTypes.length; i++) {
      buffer.write(treeTypes[i].type!);
      if (i < treeTypes.length - 1) {
        buffer.write(', ');
      }
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (pinType != null) ...[
            Align(
              //TODO: wait for backend return pinType name
              alignment: Alignment.centerRight,
              child: StatusChip(
                backgroundColor: backgroundColor!,
                foregroundColor: foregroundColor!,
                statusName: 'Thường',
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
            icon: CustomIcons.map_marker_outline,
            title: AppStrings.labelAddress,
            data: address,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.bulletin_board,
            title: AppStrings.labelWorkType,
            data: workType,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.tree_outline,
            title: AppStrings.labelTreeType,
            data: _treeType,
          ),
          const SizedBox(height: 8.0),
          CardField(
            icon: CustomIcons.calendar_range,
            title: AppStrings.labelPublishDate,
            data: Utils.formatddMMyyyy(publishedDate),
          ),
          const SizedBox(height: 8.0),
          if (expiredDate != null)
            CardField(
              icon: CustomIcons.calendar_range,
              title: AppStrings.labelExpiryDate,
              data: Utils.formatddMMyyyy(expiredDate!),
            ),
          const SizedBox(height: 8.0),
          FilledButton(
            minWidth: CommonConstants.buttonWidthSmall,
            title: AppStrings.titleDetails,
            onPressed: onDetailsPress,
          ),
        ],
      ),
    );
  }
}
