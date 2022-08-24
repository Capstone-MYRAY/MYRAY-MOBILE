import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/data/models/filter_object.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_filter.dart/price_list.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_filter.dart/tree_type_field.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
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
                Obx(() => FilterSection(
                      title: 'Tỉnh',
                      child: Column(
                        children: [
                          _buildProvinceDropdownList(),
                          controller.isProvinceChosen.value
                              ? Column(
                                  children: [
                                    const SizedBox(height: 15),
                                    _buildDistrictDropdownList(),
                                    controller.isDistrictChosen.value
                                        ? Column(
                                            children: [
                                              const SizedBox(height: 15),
                                              _buildCommuneDropdownList(),
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                )
                              : const SizedBox()
                        ],
                      ),
                    )),
                Obx(
                  () => FilterSection(
                    title: 'Loại công việc',
                    child: _buildWorkTypeDropdownList(),
                  ),
                ),
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
    return SizedBox(
      width: Get.width * 0.8,
      child: DropdownButtonFormField<FilterPrice>(
        key: UniqueKey(),
        value: controller.selectSalaryRange.value,
        onChanged: controller.onSalaryRangeChange,
        menuMaxHeight: 160.0,
        // isExpanded: true,
        style: const TextStyle(color: AppColors.primaryColor),
        elevation: 0,
        alignment: Alignment.bottomLeft,
        dropdownColor: AppColors.white,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        decoration: const InputDecoration(
          labelText: 'Chọn mức lương',
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelAlignment: FloatingLabelAlignment.start
        ),
        items: PriceList.priceList.map((FilterPrice price) {
          String formatPrice = price.toPriceString();
          return DropdownMenuItem<FilterPrice>(
            value: price,
            child: Text(
              formatPrice,
              style: TextStyle(color: AppColors.black),
            ),
          );
        }).toList(),
      ),
    );

    // DropdownSearch<FilterPrice>(
    //   key: UniqueKey(),
    //   popupProps: const PopupProps.menu(
    //     showSelectedItems: true,
    //     constraints: BoxConstraints(
    //       maxHeight: 120.0,
    //     ),
    //   ),
    //   dropdownDecoratorProps: const DropDownDecoratorProps(
    //     dropdownSearchDecoration: InputDecoration(
    //       // icon: Icon(CustomIcons.bulletin_board, size: 24),
    //       labelText: 'Chọn mức lương',
    //       isDense: true,
    //       floatingLabelBehavior: FloatingLabelBehavior.auto,
    //     ),
    //   ),
    //   selectedItem: controller.selectSalaryRange.value,
    //   items: PriceList.priceList,
    //   compareFn: (item1, item2) {
    //     return true;
    //   },
    //   onChanged: (value){

    //     print('get ${value?.salaryFrom}');
    //   },
    //   autoValidateMode: AutovalidateMode.onUserInteraction,
    // );
  }

  Widget _buildProvinceDropdownList() {
    return DropdownSearch<String>(
      key: UniqueKey(),
      popupProps: const PopupProps.menu(
        showSelectedItems: true,
        constraints: BoxConstraints(
          maxHeight: 120.0,
        ),
        textStyle: TextStyle(color: AppColors.black),
      ),
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          // icon: Icon(CustomIcons.bulletin_board, size: 24),
          labelText: 'Chọn tỉnh',
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      selectedItem: controller.selectedProvince.value,
      items: controller.provinces,
      compareFn: (item1, item2) {
        return true;
      },
      onChanged: controller.onProvinceChange,
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildDistrictDropdownList() {
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
          labelText: 'Chọn huyện',
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      selectedItem: controller.selectedDistrict.value,
      items: controller.districts,
      compareFn: (item1, item2) {
        return true;
      },
      onChanged: controller.onDistrictChange,
      autoValidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildCommuneDropdownList() {
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
          labelText: 'Chọn xã',
          isDense: true,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
      selectedItem: controller.selectedCommune.value,
      items: controller.communes,
      compareFn: (item1, item2) {
        return true;
      },
      onChanged: controller.onCommuneChange,
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
