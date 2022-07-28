import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_form_controller.dart';
import 'package:myray_mobile/app/modules/garden/widgets/upload_image_holder.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/field_validation.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';

class GardenFormView extends GetView<GardenFormController> {
  const GardenFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.screenTitle),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            width: double.infinity,
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyCard(
                    isForm: true,
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
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                emptyBuilder: ((_, __) {
                                  return _buildError('Không có dữ liệu');
                                }),
                              ),
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  icon: Icon(CustomIcons.map_marker_outline),
                                  labelText: '${AppStrings.labelProvince}*',
                                  hintText: AppStrings.placeholderProvince,
                                ),
                              ),
                              compareFn: controller.compareString,
                              items: controller.provinces,
                              selectedItem: controller.selectedProvince.isEmpty
                                  ? null
                                  : controller.selectedProvince,
                              onChanged: controller.onChangeProvince,
                              validator:
                                  FieldValidation.instance.validateProvince,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          }),
                          const SizedBox(height: 16.0),
                          Obx(() {
                            return DropdownSearch(
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  icon: Icon(CustomIcons.map_marker_outline),
                                  labelText: '${AppStrings.labelDistrict}*',
                                  hintText: AppStrings.placeholderDistrict,
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                emptyBuilder: ((_, __) {
                                  return _buildError(
                                      'Không có dữ liệu\nVui lòng chọn tỉnh trước.');
                                }),
                              ),
                              compareFn: controller.compareString,
                              items: controller.districts,
                              selectedItem: controller.selectedDistrict.isEmpty
                                  ? null
                                  : controller.selectedDistrict,
                              onChanged: controller.onChangeDistrict,
                              validator:
                                  FieldValidation.instance.validateDistrict,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          }),
                          const SizedBox(height: 16.0),
                          Obx(() {
                            return DropdownSearch(
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  icon: Icon(CustomIcons.map_marker_outline),
                                  labelText: '${AppStrings.labelCommune}*',
                                  hintText: AppStrings.placeholderCommune,
                                ),
                              ),
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                                emptyBuilder: ((_, __) {
                                  return _buildError(
                                      'Không có dữ liệu\nVui lòng chọn tỉnh và huyện trước');
                                }),
                              ),
                              items: controller.communes,
                              compareFn: controller.compareCommune,
                              itemAsString: controller.getCommuneString,
                              selectedItem:
                                  controller.selectedCommune.value.id == 0
                                      ? null
                                      : controller.selectedCommune.value,
                              onChanged: controller.onChangeCommune,
                              validator:
                                  FieldValidation.instance.validateCommune,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                            );
                          }),
                          const SizedBox(height: 16.0),
                          InputField(
                            controller: controller.addressController,
                            icon: const Icon(Icons.map_outlined),
                            labelText: '${AppStrings.labelAddress}*',
                            placeholder: AppStrings.placeholderAddress,
                            inputAction: TextInputAction.next,
                            keyBoardType: TextInputType.text,
                            minLines: 1,
                            maxLines: 8,
                            readOnly: true,
                            validator:
                                FieldValidation.instance.validateGardenAddress,
                            onTap: controller.navigateToMap,
                            suffixIcon: IconButton(
                              icon: const Icon(CustomIcons.map_marker_outline),
                              tooltip: 'Lấy vị trí hiện tại',
                              onPressed: controller.getCurrentPosition,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          InputField(
                            controller: controller.landAreaController,
                            icon: const Icon(CustomIcons.mountain),
                            labelText: '${AppStrings.labelLandArea} (ha)*',
                            placeholder: AppStrings.placeholderLandArea,
                            inputAction: TextInputAction.next,
                            keyBoardType: TextInputType.number,
                            validator:
                                FieldValidation.instance.validateLandArea,
                            onChanged: controller.onChangeLandArea,
                          ),
                          const SizedBox(height: 16.0),
                          InputField(
                            controller: controller.gardenNameController,
                            icon: const Icon(CustomIcons.sprout_outline),
                            labelText: '${AppStrings.labelGardenName}*',
                            placeholder: AppStrings.placeholderGardenName,
                            inputAction: TextInputAction.next,
                            keyBoardType: TextInputType.text,
                            validator:
                                FieldValidation.instance.validateGardenName,
                            minLines: 1,
                            maxLines: 8,
                          ),
                          const SizedBox(height: 16.0),
                          InputField(
                            controller: controller.descriptionController,
                            icon: const Icon(Icons.paste_outlined),
                            labelText: '${AppStrings.labelDescription}*',
                            placeholder: AppStrings.placeholderDescription,
                            keyBoardType: TextInputType.text,
                            minLines: 3,
                            maxLines: 10,
                          ),
                        ]),
                  ),
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
                            UploadImageHolder(
                              key: controller.imageHolderKey,
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  FilledButton(
                    minWidth: (Get.width * 0.9 - 32 * 2),
                    title: controller.buttonTitle,
                    onPressed: controller.onSubmit,
                  ),
                ],
              ),
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
}
