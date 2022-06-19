import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_form_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/my_card.dart';

class GardenFormView extends GetView<GardenFormController> {
  const GardenFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleCreateGarden),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
          ),
          width: double.infinity,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyCard(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thông tin vườn',
                          style: Get.textTheme.headline6,
                        ),
                        const SizedBox(height: 16.0),
                        Obx(() {
                          return DropdownSearch(
                            mode: Mode.MENU,
                            dropdownSearchDecoration: const InputDecoration(
                              icon: Icon(CustomIcons.map_marker_outline),
                              labelText: 'Tỉnh*',
                              hintText: 'Chọn tỉnh',
                            ),
                            showSelectedItems: true,
                            compareFn: controller.compareString,
                            items: controller.provinces,
                            selectedItem: controller.selectedProvince.isEmpty
                                ? null
                                : controller.selectedProvince,
                            onChanged: controller.onChangeProvince,
                            emptyBuilder: ((_, __) {
                              return _buildError('Không có dữ liệu');
                            }),
                          );
                        }),
                        const SizedBox(height: 16.0),
                        Obx(() {
                          return DropdownSearch(
                            mode: Mode.MENU,
                            dropdownSearchDecoration: const InputDecoration(
                              icon: Icon(CustomIcons.map_marker_outline),
                              labelText: 'Huyện*',
                              hintText: 'Chọn huyện',
                            ),
                            showSelectedItems: true,
                            compareFn: controller.compareString,
                            items: controller.districts,
                            selectedItem: controller.selectedDistrict.isEmpty
                                ? null
                                : controller.selectedDistrict,
                            onChanged: controller.onChangeDistrict,
                            emptyBuilder: ((_, __) {
                              return _buildError(
                                  'Không có dữ liệu\nVui lòng chọn tỉnh trước.');
                            }),
                          );
                        }),
                        const SizedBox(height: 16.0),
                        Obx(() {
                          return DropdownSearch(
                            mode: Mode.MENU,
                            dropdownSearchDecoration: const InputDecoration(
                              icon: Icon(CustomIcons.map_marker_outline),
                              labelText: 'Xã*',
                              hintText: 'Chọn xã',
                            ),
                            items: controller.communes,
                            showSelectedItems: true,
                            compareFn: controller.compareCommune,
                            itemAsString: controller.getCommuneString,
                            selectedItem:
                                controller.selectedCommune.value.id == 0
                                    ? null
                                    : controller.selectedCommune.value,
                            onChanged: controller.onChangeCommune,
                            emptyBuilder: ((_, __) {
                              return _buildError(
                                  'Không có dữ liệu\nVui lòng chọn tỉnh và huyện trước');
                            }),
                          );
                        }),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.landAreaController,
                          icon: const Icon(CustomIcons.mountain),
                          labelText: AppStrings.labelLandArea + '*',
                          placeholder: AppStrings.placeholderLandArea,
                          inputAction: TextInputAction.next,
                          keyBoardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.gardenNameController,
                          icon: const Icon(CustomIcons.sprout_outline),
                          labelText: AppStrings.labelGardenName + '*',
                          placeholder: AppStrings.placeholderGardenName,
                          inputAction: TextInputAction.next,
                          keyBoardType: TextInputType.text,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          controller: controller.descriptionController,
                          icon: const Icon(Icons.paste_outlined),
                          labelText: AppStrings.labelDescription + '*',
                          placeholder: AppStrings.placeholderDescription,
                          keyBoardType: TextInputType.text,
                          minLines: 3,
                          maxLines: 10,
                        ),
                      ]),
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  width: Get.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Text(
                              'Hình ảnh',
                              style: Get.textTheme.headline6,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          _buildImagePlaceHolder(),
                        ]),
                  ),
                ),
                const SizedBox(height: 24.0),
                FilledButton(
                  minWidth: (Get.width * 0.9 - 32 * 2),
                  title: AppStrings.titleCreate,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildError(String text) {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _buildImagePlaceHolder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 24.0,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(CommonConstants.borderRadius),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          CustomIcons.image_plus,
          size: 40,
        ),
        const SizedBox(height: 8.0),
        const Text('Bấm để chọn ảnh'),
        const SizedBox(height: 4.0),
        Text(
          '(Tối đa 4 ảnh)',
          style: Get.textTheme.caption,
        ),
      ]),
    );
  }
}
