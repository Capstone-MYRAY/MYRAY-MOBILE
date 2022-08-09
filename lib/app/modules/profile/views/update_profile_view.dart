import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/genders.dart';
import 'package:myray_mobile/app/modules/profile/controllers/update_profile_controller.dart';
import 'package:myray_mobile/app/modules/profile/widgets/avatar_update.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/utils/field_validation.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleUpdateProfile),
      ),
      body: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onPanDown: (_) {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => AvatarUpdate(
                    image: controller.currentImage.value == null
                        ? controller.profileImage
                        : FileImage(controller.currentImage.value!),
                    onTapHandlerImage: controller.showImageDialog,
                    onTapHandlerIcon: controller.currentImage.value == null
                        ? controller.showImageDialog
                        : controller.clearCurrentImage,
                    icon: controller.currentImage.value == null
                        ? CustomIcons.camera_plus
                        : Icons.clear,
                  ),
                ),
                Form(
                  key: controller.formKey,
                  child: MyCard(
                    isForm: true,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildInfoField(),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: Get.width * 0.7,
                  child: FilledButton(
                    title: AppStrings.titleUpdate,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      controller.updateProfile();
                    },
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInfoField() {
    return [
      Text(
        'Thông tin hồ sơ',
        style: Get.textTheme.headline6,
      ),
      const SizedBox(height: 8.0),
      InputField(
        controller: controller.fullNameController,
        icon: const Icon(CustomIcons.account_outline),
        labelText: '${AppStrings.labelFullName}*',
        placeholder: AppStrings.placeholderFullName,
        validator: FieldValidation.instance.validateFullName,
        inputAction: TextInputAction.next,
      ),
      const SizedBox(height: 8.0),
      InputField(
        controller: controller.dobController,
        icon: const Icon(CustomIcons.cake_variant_outline),
        labelText: '${AppStrings.labelDob}*',
        placeholder: 'dd/MM/yyyy',
        readOnly: true,
        validator: FieldValidation.instance.validateDob,
        onTap: controller.onChooseDob,
        inputAction: TextInputAction.next,
      ),
      const SizedBox(height: 8.0),
      InputField(
        controller: controller.emailController,
        icon: const Icon(CustomIcons.email_outline),
        labelText: AppStrings.labelEmail,
        placeholder: AppStrings.placeholderEmail,
        validator: FieldValidation.instance.validateEmail,
        inputAction: TextInputAction.next,
      ),
      const SizedBox(height: 8.0),
      InputField(
        controller: controller.addressController,
        icon: const Icon(CustomIcons.map_marker_outline),
        labelText: AppStrings.labelAddress,
        placeholder: 'Nhập địa chỉ',
        validator: FieldValidation.instance.validateAddress,
        inputAction: TextInputAction.next,
      ),
      const SizedBox(height: 8.0),
      _buildGender(),
      InputField(
        controller: controller.descriptionController,
        icon: const Icon(CustomIcons.content_paste),
        labelText: AppStrings.labelDescription,
        placeholder: AppStrings.placeholderDescription,
        minLines: 1,
        maxLines: 10,
        keyBoardType: TextInputType.multiline,
      ),
    ];
  }

  _buildGender() {
    return Row(
      children: [
        const Icon(
          CustomIcons.gender,
          size: 24.0,
        ),
        const SizedBox(width: 4.0),
        Flexible(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12.0, top: 12.0),
                child: Text(
                  AppStrings.labelGender,
                  style: Get.textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRadio(
                      value: Genders.male.index,
                      groupValue: controller.selectedGender.value,
                      displayText: AppStrings.male,
                    ),
                    _buildRadio(
                      value: Genders.female.index,
                      groupValue: controller.selectedGender.value,
                      displayText: AppStrings.female,
                    ),
                    _buildRadio(
                      value: Genders.other.index,
                      groupValue: controller.selectedGender.value,
                      displayText: AppStrings.other,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildRadio({
    required int value,
    required int groupValue,
    required displayText,
  }) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<int>(
            value: value,
            activeColor: AppColors.primaryColor,
            groupValue: groupValue,
            onChanged: (value) => controller.selectedGender.value = value ?? 0,
            toggleable: false,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashRadius: 4.0,
          ),
          Expanded(
            child: Text(
              displayText,
              style: Get.textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
