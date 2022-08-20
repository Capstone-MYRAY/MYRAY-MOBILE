import 'package:flutter/material.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/card_status_field.dart';

class ToggleContentWorkInfo extends StatelessWidget {
  final String workName;
  final String workPayType;
  final String treeTypes;
  final String workType;
  final DateTime jobStartDate;
  final DateTime? jobEndDate;
  final String? description;
  final Widget workContent;
  final CardStatusField workStatus;
  final bool canEditJobStartDate;
  final void Function()? onEdit;

  const ToggleContentWorkInfo({
    Key? key,
    required this.workName,
    required this.workType,
    required this.workPayType,
    required this.treeTypes,
    required this.jobStartDate,
    required this.workContent,
    required this.workStatus,
    required this.canEditJobStartDate,
    this.onEdit,
    this.jobEndDate,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CardField(
          icon: CustomIcons.briefcase_outline,
          title: AppStrings.labelWorkName,
          data: workName,
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.briefcase_outline,
          title: AppStrings.labelWorkType,
          data: workType,
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.bulletin_board,
          title: AppStrings.labelWorkPayType,
          data: workPayType,
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.tree_outline,
          title: AppStrings.labelTreeType,
          data: treeTypes.isEmpty ? 'Không phân loại' : treeTypes,
        ),
        const SizedBox(height: 8.0),
        workContent,
        const SizedBox(height: 8.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CardField(
                icon: CustomIcons.calendar_range,
                title: AppStrings.labelJobStartDate,
                data: Utils.formatddMMyyyy(jobStartDate),
                isCenter: true,
              ),
            ),
            if (canEditJobStartDate)
              CustomIconButton(
                icon: CustomIcons.pencil,
                toolTip: 'Chỉnh sửa ngày bắt đầu',
                onTap: onEdit,
              ),
          ],
        ),
        const SizedBox(height: 8.0),
        CardField(
          icon: CustomIcons.calendar_range,
          title: AppStrings.labelJobEndDate,
          data: jobEndDate != null ? Utils.formatddMMyyyy(jobEndDate!) : 'N/A',
          isCenter: true,
        ),
        const SizedBox(height: 8.0),
        workStatus,
        const SizedBox(height: 8.0),
        CardField(
          icon: Icons.paste,
          title: AppStrings.labelDescription,
          data: description == null || description!.isEmpty
              ? 'Không có mô tả'
              : description!,
        ),
      ],
    );
  }
}
