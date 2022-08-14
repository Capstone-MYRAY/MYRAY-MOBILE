import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_filter.dart/tree_type_field.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_date_picker.dart';
import 'package:myray_mobile/app/shared/widgets/filters/filter_controls.dart';
import 'package:myray_mobile/app/shared/widgets/filters/filter_section.dart';
import 'package:myray_mobile/app/shared/widgets/filters/inline_filter.dart';

class FarmerJobPostFilter extends GetView<FarmerHomeController> {
  FarmerJobPostFilter({Key? key}) : super(key: key);
  final paidTypeKey = GlobalKey<InlineFilterState>();
  final workTypeKey = GlobalKey<InlineFilterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ lọc'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                FilterSection(
                  title: 'Tỉnh',
                  child: _buildProvinceDropdownList(),
                ),
                Obx(
                  () => FilterSection(
                    title: 'Loại công việc',
                    child: _buildWorkTypeDropdownList(),
                  ),
                ),
                //  FilterSection(
                //     title: 'Xã',
                //     child: _buildProvinceDropdownList(),
                //   ),
                //   FilterSection(
                //     title: 'Huyện',
                //     child: _buildProvinceDropdownList(),
                //   ),
                _buildPaidTypeFilter(),
                Obx(
                  () => FilterSection(
                    title: 'Mức lương',
                    child: _buildSalaryDropdownList(),
                  ),
                ),

                FilterSection(
                  title: 'Ngày bắt đầu',
                  child: Column(
                    children: [
                      TextFormField(
                        key: UniqueKey(),
                        controller: controller.fromDateController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Từ ngày:',
                          labelStyle: TextStyle(fontSize: 15),
                          suffixIcon: Icon(CustomIcons.calendar_range,
                              color: AppColors.primaryColor),
                        ),
                        readOnly: true,
                        onTap: controller.onChooseFromDate,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        key: UniqueKey(),
                        controller: controller.toDateController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Đến ngày:',
                          labelStyle: TextStyle(fontSize: 15),
                          suffixIcon: Icon(CustomIcons.calendar_range,
                              color: AppColors.primaryColor),
                        ),
                        readOnly: true,
                        onTap: controller.onChooseToDate,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: controller.onClearChooseDate,
                            child: const Text('Xóa ngày chọn'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                FilterSection(
                  title: 'Loại cây',
                  child: TreeTypeField(
                    key: controller.treeTypeFieldKey,
                    treeTypes: controller.treeTypes,
                    selectedTreeTypes: controller.selectedTreeTypes,
                  ),
                ),
              ],
            ),
          ),
          FilterControls(
              onApply: controller.onApplyFilter,
              onClear: () {
                paidTypeKey.currentState?.clearFilter();
                controller.onClearFilter();
              }),
        ],
      ),
    );
  }

  Widget _buildPaidTypeFilter() {
    return FilterSection(
      title: AppStrings.labelWorkPayType,
      child: InlineFilter(
        key: paidTypeKey,
        onChanged: (value) {
          controller.paidTypeFilter = value;
          print('Selected paid type: $value');
        },
        selectedItem: controller.paidTypeFilter,
        items: [
          FilterObject(
            name: 'Tất cả',
            value: null,
          ),
          FilterObject(
            name: AppStrings.payPerHour,
            value: JobType.payPerHourJob.name,
          ),
          FilterObject(
            name: AppStrings.payPerTask,
            value: JobType.payPerTaskJob.name,
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryDropdownList() {
    return DropdownSearch<String>(
      key: UniqueKey(),
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        constraints: BoxConstraints(
          maxHeight: 120.0,
        ),
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          // icon: Icon(CustomIcons.bulletin_board, size: 24),
          labelText: 'Chọn mức lương',
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      selectedItem: controller.selectSalaryRange.value.name,
      items: const [
        'Mức lương',
        '>= 100.000 đ',
        '>= 500.000 đ',
        '>= 1.000.000 đ',
        '>= 5.000.000 đ',
        '>= 10.000.000 đ',
      ],
      compareFn: (item1, item2) {
        return true;
      },
      onChanged: controller.onSalaryRangeChange,
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildProvinceDropdownList() {
    return DropdownSearch<String>(
      key: UniqueKey(),
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        constraints: BoxConstraints(
          maxHeight: 120.0,
        ),
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          // icon: Icon(CustomIcons.bulletin_board, size: 24),
          labelText: 'Chọn tỉnh',
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      selectedItem: controller.selectProvince.value,
      items: const [
        'Lâm Đồng',
        'Kiên Giang',
        'Đà Lạt',
      ],
      compareFn: (item1, item2) {
        return true;
      },
      onChanged: controller.onProvinceChange,
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildWorkTypeDropdownList() {
    return DropdownSearch<String>(
      key: UniqueKey(),
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        constraints: BoxConstraints(
          maxHeight: 120.0,
        ),
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          // icon: Icon(CustomIcons.bulletin_board, size: 24),
          labelText: 'Chọn loại công việc',
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      selectedItem: controller.selectedWorkTypes.value,
      items: controller.labelWorkType,
      compareFn: (item1, item2) {
        return true;
      },
      onChanged: controller.onWorkTypeChange,
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
