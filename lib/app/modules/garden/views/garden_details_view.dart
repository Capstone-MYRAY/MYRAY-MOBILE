import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/area/area.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_details_controller.dart';
import 'package:myray_mobile/app/modules/garden/widgets/garden_details_card.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/filled_button.dart';

class GardenDetailsView extends GetView<GardenDetailsController> {
  const GardenDetailsView({Key? key}) : super(key: key);

  @override
  String? get tag => Get.arguments[Arguments.tag];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleGardenDetails),
      ),
      body: FutureBuilder<Area?>(
        future: controller.getArea(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
          }

          if (snapshot.hasError || snapshot.data == null) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    size: 50.0,
                    color: AppColors.errorColor,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Đã có lỗi xảy ra',
                    style: Get.textTheme.headline6!.copyWith(
                      color: AppColors.errorColor,
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasData) {
            controller.area = snapshot.data!.obs;
            return _buildDetails();
          }

          return const SizedBox();
        }),
      ),
    );
  }

  Widget _buildDetails() {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return GardenDetailsCard(
                  garden: controller.garden.value,
                  area: controller.area!.value,
                  onEditTap: controller.action == null
                      ? controller.navigateToEditForm
                      : null,
                );
              }),
              const SizedBox(height: 16.0),
              SizedBox(
                width: Get.width * 0.7,
                child: Column(children: [
                  FilledButton(
                    title: 'Danh sách công việc',
                    onPressed: () {},
                  ),
                  const SizedBox(height: 16.0),
                  if (controller.action == null)
                    FilledButton(
                      title: AppStrings.titleDelete,
                      onPressed: controller.onDeleteGarden,
                      color: AppColors.errorColor,
                    ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
