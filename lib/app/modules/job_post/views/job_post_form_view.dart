import 'package:dropdown_search/dropdown_search.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/garden/garden_models.dart';
import 'package:myray_mobile/app/modules/job_post/controllers/job_post_form_controller.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/field_validation.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/custom_icon_button.dart';
import 'package:myray_mobile/app/shared/widgets/dropdown_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/filled_button.dart';
import 'package:myray_mobile/app/shared/widgets/input_field.dart';
import 'package:myray_mobile/app/shared/widgets/my_card.dart';
import 'package:myray_mobile/app/shared/widgets/my_check_box.dart';

class JobPostFormView extends GetView<JobPostFormController> {
  const JobPostFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.titleCreateJobPost,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
        ),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thông tin công việc',
                        style: Get.textTheme.headline6,
                      ),
                      const SizedBox(height: 16.0),
                      InputField(
                        controller: controller.workNameController,
                        icon: const Icon(CustomIcons.briefcase_outline),
                        labelText: AppStrings.labelWorkName + '*',
                        placeholder: AppStrings.placeholderWorkName,
                        inputAction: TextInputAction.next,
                        keyBoardType: TextInputType.text,
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
                                mode: Mode.MENU,
                                dropdownSearchDecoration: const InputDecoration(
                                  icon: Icon(CustomIcons.sprout_outline),
                                  labelText: '${AppStrings.labelGardenName}*',
                                ),
                                items: controller.gardens,
                                itemAsString: controller.getGardenName,
                                showSelectedItems: true,
                                compareFn: controller.compareGarden,
                                selectedItem: controller.selectedGarden.value,
                                onChanged: controller.onGardenChange,
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: FieldValidation
                                    .instance.validateGardenSelection,
                                emptyBuilder: (_, __) =>
                                    const DropdownEmptyBuilder(
                                        msg: AppStrings.noData),
                              ),
                            ),
                            if (controller.selectedGarden.value != null) ...[
                              const SizedBox(width: 8.0),
                              CustomIconButton(
                                icon: Icons.remove_red_eye,
                                onTap: () {},
                                toolTip: 'Xem chi tiết',
                                size: 25,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.black, width: 1.0),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(CommonConstants.borderRadius),
                          ),
                        ),
                        child: GetBuilder<JobPostFormController>(
                          builder: (controller) => MultiSelectFormField(
                            checkBoxActiveColor: AppColors.primaryColor,
                            checkBoxCheckColor: AppColors.white,
                            title: Row(children: [
                              const Icon(
                                CustomIcons.tree_outline,
                                size: 24.0,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                AppStrings.labelTreeType,
                                style: Get.textTheme.headline6,
                              ),
                            ]),
                            okButtonLabel: 'Chọn'.toUpperCase(),
                            cancelButtonLabel: 'Đóng'.toUpperCase(),
                            hintWidget: Text('Chọn loại cây'),
                            border: InputBorder.none,
                            fillColor: Colors.transparent,
                            dialogTextStyle: Get.textTheme.bodyText2!,
                            leading: const Icon(CustomIcons.tree_outline),
                            dataSource: controller.treeTypes != null
                                ? controller.treeTypes!
                                    .map((type) => type.toJson())
                                    .toList()
                                    .cast<dynamic>()
                                : null,
                            textField: 'type',
                            valueField: 'id',
                            chipBackGroundColor:
                                AppColors.primaryColor.withOpacity(0.5),
                            chipLabelStyle: Get.textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0 * Get.textScaleFactor,
                            ),
                            onSaved: (value) {
                              controller.selectedTreeTypes.value =
                                  value.cast<int>();
                              print(controller.selectedTreeTypes.toString());
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      InputField(
                        controller: controller.jobStartDateController,
                        icon: const Icon(CustomIcons.calendar_range),
                        labelText: AppStrings.labelJobStartDate,
                        placeholder: AppStrings.placeholderJobStartDate,
                        inputAction: TextInputAction.next,
                        keyBoardType: TextInputType.number,
                        onTap: () {},
                      ),
                      const SizedBox(height: 16.0),
                      DropdownSearch<String>(
                        mode: Mode.MENU,
                        dropdownSearchDecoration: const InputDecoration(
                          icon: Icon(CustomIcons.bulletin_board),
                          labelText: '${AppStrings.labelWorkType}*',
                        ),
                        items: const [
                          AppStrings.payPerHour,
                          AppStrings.payPerTask,
                        ],
                        compareFn: controller.compareWorkType,
                        onChanged: controller.onWorkTypeChange,
                        showSelectedItems: true,
                      ),
                      Obx(
                        () => Column(
                          children: _buildFieldsByWorkType(
                              controller.selectedWorkType.value),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      InputField(
                        controller: controller.descriptionController,
                        icon: const Icon(Icons.paste_outlined),
                        labelText: AppStrings.labelJobDescription,
                        placeholder: AppStrings.placeholderDescription,
                        keyBoardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 10,
                      ),
                      const SizedBox(height: 16.0),
                      InputField(
                        controller: controller.publishDateController,
                        icon: const Icon(CustomIcons.calendar_range),
                        labelText: '${AppStrings.labelPublishDate}*',
                        placeholder: AppStrings.placeholderPublishDate,
                        inputAction: TextInputAction.next,
                        readOnly: true,
                        onTap: () {},
                      ),
                      const SizedBox(height: 16.0),
                      Column(
                        children: [
                          InputField(
                            controller: controller.numOfPublishDayController,
                            icon: const Icon(CustomIcons.calendar_range),
                            labelText: '${AppStrings.labelNumOfPublishDay}*',
                            placeholder: AppStrings.placeholderNumOfPublishDay,
                            inputAction: TextInputAction.next,
                            keyBoardType: TextInputType.number,
                            onChanged: controller.onChangeNumOfPublishDay,
                          ),
                          const SizedBox(height: 8.0),
                          Obx(
                            () => _buildEquationDisplay(
                                equation: controller.numOfPublishDayEquation,
                                cost: controller.publishFee),
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
                              onChanged: (value) =>
                                  controller.isUpgrade.value = value!,
                            ),
                          ),
                        ],
                      ),
                      Obx(() => _buildUpgradePost(controller.isUpgrade.value)),
                      const SizedBox(height: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Điểm hiện tại: 50000 điểm',
                            style: Get.textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0 * Get.textScaleFactor,
                            ),
                          ),
                          InputField(
                            controller: controller.usingPointController,
                            icon: const Icon(CustomIcons.gift_open_outline),
                            labelText: 'Dùng điểm',
                            placeholder: '0',
                            inputAction: TextInputAction.next,
                            keyBoardType: TextInputType.number,
                            onChanged: controller.onChangeUsingPoint,
                          ),
                          const SizedBox(height: 8.0),
                          Obx(
                            () => _buildEquationDisplay(
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
                const SizedBox(height: 16.0),
                FilledButton(
                    title: AppStrings.titleCreate,
                    minWidth: Get.width * 0.7,
                    onPressed: () {
                      controller.formKey.currentState!.save();
                      print(controller.selectedTreeTypes);
                    })
              ],
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
        InputField(
          controller: controller.upgradeDateController,
          icon: const Icon(CustomIcons.calendar_range),
          labelText: '${AppStrings.labelUpgradeDate}*',
          placeholder: AppStrings.placeholderUpgradeDate,
          inputAction: TextInputAction.next,
          readOnly: true,
          onTap: () {},
        ),
        const SizedBox(height: 16.0),
        InputField(
          controller: controller.numOfUpgradeDateController,
          icon: const Icon(CustomIcons.calendar_range),
          labelText: '${AppStrings.labelNumOfUpgradeDay}*',
          placeholder: AppStrings.placeholderNumOfUpgradeDay,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          onChanged: controller.onChangeNumOfUpgradeDay,
        ),
        const SizedBox(height: 8.0),
        _buildEquationDisplay(
            equation: controller.upgradeEquation,
            cost: controller.totalUpgrade),
      ],
    );
  }

  Widget _buildEquationDisplay(
      {required String equation, required String cost, bool isReduce = true}) {
    return Padding(
      padding: const EdgeInsets.only(left: 25 + 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            equation,
            style: Get.textTheme.caption,
          ),
          SizedBox(width: Get.width * 0.1),
          Text(
            cost,
            style: Get.textTheme.caption!.copyWith(
              color: isReduce ? AppColors.errorColor : AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildFieldsByWorkType(String workType) {
    if (workType.isEmpty) {
      return [];
    } else if (Utils.equalsUtf8String(AppStrings.payPerHour, workType)) {
      return [
        const SizedBox(height: 16.0),
        InputField(
          controller: controller.estimateWorkController,
          icon: const Icon(CustomIcons.lucide_axe),
          labelText: AppStrings.labelEstimateWork,
          placeholder: AppStrings.placeholderEstimateWork,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
        ),
        const SizedBox(height: 16.0),
        InputField(
          controller: controller.minFarmerController,
          icon: const Icon(CustomIcons.account_outline),
          labelText: AppStrings.labelMinFarmer,
          placeholder: AppStrings.placeholderMinFarmer,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
        ),
        const SizedBox(height: 16.0),
        InputField(
          controller: controller.maxFarmerController,
          icon: const Icon(CustomIcons.account_outline),
          labelText: AppStrings.labelMaxFarmer,
          placeholder: AppStrings.placeholderMaxFarmer,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
        ),
        InputField(
          controller: controller.hourSalaryController,
          icon: const Icon(CustomIcons.cash),
          labelText: AppStrings.labelHourSalary,
          placeholder: AppStrings.placeholderHourSalary,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
        ),
        const SizedBox(height: 16.0),
        InputField(
          controller: controller.startHourController,
          icon: const Icon(Icons.timer_outlined),
          labelText: AppStrings.labelStartHour,
          placeholder: AppStrings.placeholderStartHour,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          readOnly: true,
          onTap: controller.onChooseStartHour,
        ),
        const SizedBox(height: 16.0),
        InputField(
          controller: controller.endHourController,
          icon: const Icon(Icons.timer_outlined),
          labelText: AppStrings.labelEndHour,
          placeholder: AppStrings.placeholderEndHour,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          readOnly: true,
          onTap: controller.onChooseEndHour,
        ),
      ];
    } else {
      return [
        const SizedBox(height: 16.0),
        InputField(
          controller: controller.taskSalaryController,
          icon: const Icon(CustomIcons.cash),
          labelText: AppStrings.labelTaskSalary,
          placeholder: AppStrings.placeholderTaskSalary,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
        ),
        const SizedBox(height: 16.0),
        InputField(
          controller: controller.jobEndDate,
          icon: const Icon(CustomIcons.calendar_range),
          labelText: AppStrings.labelJobEndDate,
          placeholder: AppStrings.placeholderJobEndDate,
          inputAction: TextInputAction.next,
          keyBoardType: TextInputType.number,
          onTap: () {},
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
