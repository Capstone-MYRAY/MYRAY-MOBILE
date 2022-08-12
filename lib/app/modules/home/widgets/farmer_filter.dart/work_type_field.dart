import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/work_type/work_type_models.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';

class WorkTypeField extends StatefulWidget {
  final List<WorkType> workTypes;
  final List<WorkType> selectedWorkTypes;
  const WorkTypeField(
      {Key? key, required this.workTypes, required this.selectedWorkTypes})
      : super(key: key);

  @override
  State<WorkTypeField> createState() => _WorkTypeFieldState();
}

class _WorkTypeFieldState extends State<WorkTypeField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.2),
        border: Border.all(color: AppColors.primaryColor, width: 1.0),
        borderRadius: const BorderRadius.all(
          Radius.circular(CommonConstants.borderRadius),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _openWrokTypeDialog(context),
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                top: 0.0,
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
              ),
              horizontalTitleGap: 0.0,
              title: Text(
                'Chọn loại công việc',
                style: Get.theme.inputDecorationTheme.labelStyle,
              ),
              trailing: _buildIcon(CustomIcons.menu_down),
            ),
          ),
          const Divider(color: AppColors.primaryColor),
          const SizedBox(
            height: 8.0,
          ),
          _buildSelectedChip(),
        ],
      ),
    );
  }

  void _openWrokTypeDialog(BuildContext context) {
    FilterListDialog.display<WorkType>(Get.context!,
        height: Get.height * 0.8,
        controlButtons: [ControlButtonType.Reset],
        resetButtonText: 'Bỏ chọn toàn bộ',
        applyButtonText: 'Chọn',
        listData: widget.workTypes,
        selectedItemsText: 'mục đã chọn',
        themeData: FilterListThemeData(
          context,
          choiceChipTheme: ChoiceChipThemeData(
            selectedBackgroundColor: AppColors.primaryColor.withOpacity(0.5),
          ),
          controlButtonBarTheme: ControlButtonBarThemeData(
            context,
            controlButtonTheme: ControlButtonThemeData(
              primaryButtonBackgroundColor: AppColors.primaryColor,
              textStyle: Get.textTheme.bodyText1!.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w400,
              ),
              primaryButtonTextStyle: Get.textTheme.bodyText1!.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          headerTheme: HeaderThemeData(
            searchFieldHintText: AppStrings.placeholderSearch,
            searchFieldInputBorder: InputBorder.none,
            searchFieldHintTextStyle: Get.textTheme.caption,
          ),
        ),
        selectedListData: widget.selectedWorkTypes,
        choiceChipLabel: (workType) => workType?.name,
        validateSelectedItem: (list, treeType) {
          if (list == null) return false;
          return list.contains(treeType);
        },
        onItemSearch: (workType, query) {
          return Utils.toLowerCaseNonAccentVietnamese(workType.name)
              .contains(Utils.toLowerCaseNonAccentVietnamese(query));
        },
        onApplyButtonClick: (list) {
          setState(() {
            widget.selectedWorkTypes.clear();
            if (list != null) {
              widget.selectedWorkTypes.addAll(list.toList().cast<WorkType>());
            }
          });
          Navigator.pop(context);
        });
  }

  Widget _buildIcon(IconData icon) {
    return Icon(
      icon,
      size: 25,
      color: AppColors.iconColor,
    );
  }

  _buildSelectedChip() {
    return Wrap(
      spacing: 12.0,
      children: [
        ...widget.selectedWorkTypes
            .map(
              (workType) => ActionChip(
                label: Text(
                  workType.name,
                  style: Get.textTheme.bodyText1!.copyWith(
                    color: AppColors.white,
                  ),
                ),
                avatar: const Icon(
                  Icons.clear,
                  color: AppColors.white,
                ),
                backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                onPressed: () {
                  setState(() {
                    widget.selectedWorkTypes.remove(workType);
                  });
                },
              ),
            )
            .toList(),
      ],
    );
  }
}
