import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/data/models/post_type/post_type.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/job_post_form_controller.dart';
import 'package:myray_mobile/app/modules/job_post/views/equation_display.dart';
import 'package:myray_mobile/app/modules/job_post/widgets/tree_type_fields.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_icon_button.dart';
import 'package:myray_mobile/app/shared/widgets/builders/dropdown_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/controls/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/cards/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/controls/my_check_box.dart';

class JobPostFormView extends GetView<JobPostFormController> {
  const JobPostFormView({Key? key}) : super(key: key);

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
                          AppStrings.titleWorkInformation,
                          style: Get.textTheme.headline6,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          key: UniqueKey(),
                          controller: controller.workNameController,
                          icon: const Icon(CustomIcons.briefcase_outline),
                          labelText: '${AppStrings.labelWorkName}*',
                          placeholder: AppStrings.placeholderWorkName,
                          inputAction: TextInputAction.next,
                          keyBoardType: TextInputType.text,
                          validator: controller.validateWorkName,
                          minLines: 1,
                          maxLines: 4,
                        ),
                        const SizedBox(height: 16.0),
                        Obx(
                          () => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: DropdownSearch<Garden>(
                                  key: UniqueKey(),
                                  popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    emptyBuilder: (_, __) =>
                                        const DropdownEmptyBuilder(
                                      msg: AppStrings.noData,
                                    ),
                                  ),
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      icon: Icon(CustomIcons.sprout_outline),
                                      labelText:
                                          '${AppStrings.labelGardenName}*',
                                    ),
                                  ),
                                  items: controller.gardens,
                                  compareFn: controller.compareGarden,
                                  selectedItem: controller.selectedGarden.value,
                                  onChanged: controller.onGardenChange,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: controller.validateGardenSelection,
                                ),
                              ),
                              if (controller.selectedGarden.value != null) ...[
                                const SizedBox(width: 8.0),
                                CustomIconButton(
                                  icon: Icons.remove_red_eye,
                                  onTap: controller.viewGardenDetails,
                                  toolTip: 'Xem chi tiết',
                                  size: 25,
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        GetBuilder<JobPostFormController>(
                          builder: (controller) => TreeTypeField(
                            key: controller.treeTypeFieldKey,
                            treeTypes: controller.treeTypes != null
                                ? controller.treeTypes!
                                : [],
                            selectedTreeTypes: controller.selectedTreeTypes,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          key: UniqueKey(),
                          controller: controller.jobStartDateController,
                          icon: const Icon(CustomIcons.calendar_range),
                          labelText: '${AppStrings.labelJobStartDate}*',
                          placeholder: AppStrings.placeholderJobStartDate,
                          inputAction: TextInputAction.next,
                          readOnly: true,
                          onTap: controller.onChooseStartDate,
                          validator: controller.validateJobStartDate,
                        ),
                        const SizedBox(height: 16.0),
                        Obx(
                          () => DropdownSearch<String>(
                            key: UniqueKey(),
                            popupProps: const PopupProps.menu(
                              showSelectedItems: true,
                              constraints: BoxConstraints(
                                maxHeight: 120.0,
                              ),
                            ),
                            // maxHeight: 120.0,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                icon: Icon(CustomIcons.bulletin_board),
                                labelText: '${AppStrings.labelWorkType}*',
                                isDense: true,
                              ),
                            ),
                            selectedItem: controller.selectedWorkType.value,
                            items: const [
                              AppStrings.payPerHour,
                              AppStrings.payPerTask,
                            ],
                            compareFn: controller.compareWorkType,
                            onChanged: controller.onWorkTypeChange,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: controller.validateWorkType,
                          ),
                        ),
                        Obx(
                          () => Column(
                            children: _buildFieldsByWorkType(
                                controller.selectedWorkType.value),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          key: UniqueKey(),
                          controller: controller.descriptionController,
                          icon: const Icon(Icons.paste_outlined),
                          labelText: AppStrings.labelJobDescription,
                          placeholder: AppStrings.placeholderDescription,
                          keyBoardType: TextInputType.multiline,
                          minLines: 3,
                          maxLines: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  MyCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.titlePostInformation,
                          style: Get.textTheme.headline6,
                        ),
                        const SizedBox(height: 16.0),
                        InputField(
                          key: UniqueKey(),
                          controller: controller.publishDateController,
                          icon: const Icon(CustomIcons.calendar_range),
                          labelText: '${AppStrings.labelPublishDate}*',
                          placeholder: AppStrings.placeholderPublishDate,
                          inputAction: TextInputAction.next,
                          readOnly: true,
                          validator: controller.validatePublishDate,
                          onTap: controller.onChoosePublishDate,
                        ),
                        const SizedBox(height: 16.0),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  CustomIcons.calendar_range,
                                  size: 24.0,
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: SpinBox(
                                    key: UniqueKey(),
                                    min: 3,
                                    max: 100,
                                    keyboardType: TextInputType.number,
                                    showButtons: true,
                                    onChanged:
                                        controller.onChangeNumOfPublishDay,
                                    value: controller.numOfPublishDay.value
                                        .toDouble(),
                                    decoration: const InputDecoration(
                                      label: Text(
                                          '${AppStrings.labelNumOfPublishDay}*'),
                                    ),
                                    validator:
                                        controller.validateNumOfPublishDay,
                                    afterChange: controller.resetUpgradeData,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Obx(
                              () => EquationDisplay(
                                equation: controller.numOfPublishDayEquation,
                                cost: controller.publishFee,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            Text(
                              AppStrings.labelUpgradePost,
                              style: Get.textTheme.headline6!.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Obx(
                              () => MyCheckBox(
                                value: controller.isUpgrade.value,
                                onChanged: controller.onChangeUpgradePost,
                              ),
                            ),
                          ],
                        ),
                        Obx(() =>
                            _buildUpgradePost(controller.isUpgrade.value)),
                        const SizedBox(height: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Điểm hiện tại: ${controller.userPoint} điểm',
                              style: Get.textTheme.bodyText2!.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0 * Get.textScaleFactor,
                              ),
                            ),
                            InputField(
                              key: UniqueKey(),
                              controller: controller.usingPointController,
                              icon: const Icon(CustomIcons.gift_open_outline),
                              labelText: 'Dùng điểm',
                              placeholder: '0',
                              keyBoardType: TextInputType.number,
                              onChanged: controller.onChangeUsingPoint,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: controller.validateUsingPoint,
                            ),
                            const SizedBox(height: 8.0),
                            Obx(
                              () => EquationDisplay(
                                equation: controller.usingPointEquation,
                                cost: controller.totalReduce,
                                isReduce: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  MyCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tổng cộng',
                              style: Get.textTheme.bodyText1,
                            ),
                            Obx(
                              () => Text(
                                controller.totalFee,
                                style: Get.textTheme.bodyText2!.copyWith(
                                  color: AppColors.errorColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Điểm tích lũy',
                              style: Get.textTheme.bodyText1,
                            ),
                            Obx(
                              () => Text(
                                '+${controller.bonusPoint}',
                                style: Get.textTheme.bodyText2!.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FilledButton(
                    title: controller.buttonTitle,
                    minWidth: Get.width * 0.7,
                    onPressed: controller.onSubmitForm,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildUpgradePost(bool isUpgrade) {
    if (!isUpgrade) return const SizedBox();
    return Column(
      children: [
        DropdownSearch<PostType>(
          key: UniqueKey(),
          popupProps: PopupProps.menu(
            showSelectedItems: true,
            emptyBuilder: (_, __) =>
                const DropdownEmptyBuilder(msg: AppStrings.noData),
            itemBuilder: (_, postType, isSelected) => ListTile(
              title: Text(
                postType.name,
                style: Get.textTheme.bodyText1!.copyWith(
                  color: isSelected ? AppColors.primaryColor : AppColors.black,
                ),
              ),
              trailing: Text(
                Utils.vietnameseCurrencyFormat.format(postType.price),
                style: Get.textTheme.caption,
              ),
            ),
          ),
          dropdownDecoratorProps: const DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              icon: Icon(CustomIcons.box),
              labelText: '${AppStrings.labelPostType}*',
            ),
          ),
          items: controller.postTypes ?? [],
          selectedItem: controller.selectedPostType.value,
          compareFn: controller.comparePostType,
          onChanged: controller.onPostTypeChange,
          validator: controller.validatePostType,
          autoValidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.upgradeDateController,
          icon: const Icon(CustomIcons.calendar_range),
          labelText: '${AppStrings.labelUpgradeDate}*',
          placeholder: AppStrings.placeholderUpgradeDate,
          inputAction: TextInputAction.next,
          readOnly: true,
          onTap: controller.isUpgradeDateAvailable()
              ? controller.onChooseUpgradeDate
              : null,
          validator: controller.validateUpgradeDate,
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const Icon(
              CustomIcons.calendar_range,
              size: 24.0,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: SpinBox(
                key: UniqueKey(),
                min: controller.maxDay.value == 0 ? 0 : 1,
                max: controller.maxDay.value.toDouble(),
                keyboardType: TextInputType.number,
                showButtons: true,
                onChanged: controller.onChangeNumOfUpgradeDay,
                enabled: controller.isEnableDayEdit.value,
                value: controller.numOfUpgradeDay.value.toDouble(),
                decoration: const InputDecoration(
                  label: Text('${AppStrings.labelNumOfUpgradeDay}*'),
                ),
                validator: controller.validateNumOfUpgradeDay,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Obx(
          () => EquationDisplay(
            equation: controller.upgradeEquation,
            cost: controller.totalUpgrade,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildFieldsByWorkType(String workType) {
    if (workType.isEmpty) {
      return [];
    } else if (Utils.equalsUtf8String(AppStrings.payPerHour, workType)) {
      return [
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.estimateWorkController,
          icon: const Icon(CustomIcons.lucide_axe),
          labelText: '${AppStrings.labelEstimateWork}*',
          placeholder: AppStrings.placeholderEstimateWork,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: controller.validateEstimateWork,
        ),
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.minFarmerController,
          icon: const Icon(CustomIcons.account_outline),
          labelText: '${AppStrings.labelMinFarmer}*',
          placeholder: AppStrings.placeholderMinFarmer,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: controller.validateMinFarmer,
        ),
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.maxFarmerController,
          icon: const Icon(CustomIcons.account_outline),
          labelText: '${AppStrings.labelMaxFarmer}*',
          placeholder: AppStrings.placeholderMaxFarmer,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: controller.validateMaxFarmer,
        ),
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.hourSalaryController,
          icon: const Icon(CustomIcons.cash),
          labelText: '${AppStrings.labelHourSalary}*',
          placeholder: AppStrings.placeholderHourSalary,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: controller.validateHourSalary,
        ),
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.startHourController,
          icon: const Icon(Icons.timer_outlined),
          labelText: AppStrings.labelStartHour,
          placeholder: AppStrings.placeholderStartHour,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          readOnly: true,
          onTap: controller.onChooseStartHour,
          validator: controller.validateStartHour,
        ),
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.endHourController,
          icon: const Icon(Icons.timer_outlined),
          labelText: AppStrings.labelEndHour,
          placeholder: AppStrings.placeholderEndHour,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          readOnly: true,
          onTap: controller.onChooseEndHour,
          validator: controller.validateEndHour,
        ),
      ];
    } else {
      return [
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.taskSalaryController,
          icon: const Icon(CustomIcons.cash),
          labelText: '${AppStrings.labelTaskSalary}*',
          placeholder: AppStrings.placeholderTaskSalary,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: controller.validateTaskSalary,
        ),
        const SizedBox(height: 16.0),
        InputField(
          key: UniqueKey(),
          controller: controller.jobEndDateController,
          icon: const Icon(CustomIcons.calendar_range),
          labelText: '${AppStrings.labelJobEndDate}*',
          placeholder: AppStrings.placeholderJobEndDate,
          inputAction: TextInputAction.next,
          validator: controller.validateJobEndDate,
          readOnly: true,
          onTap: controller.onChooseJobEndDate,
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Text(
              AppStrings.labelToolAvailable,
              style: Get.textTheme.headline6!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Obx(
              () => MyCheckBox(
                key: UniqueKey(),
                value: controller.isToolAvailable.value,
                onChanged: (value) => controller.isToolAvailable.value = value!,
              ),
            ),
          ],
        ),
      ];
    }
  }
}
