import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/activities.dart';
import 'package:myray_mobile/app/data/models/garden/garden.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_home_controller.dart';
import 'package:myray_mobile/app/modules/garden/widgets/garden_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class GardenHomeView extends GetView<GardenHomeController> {
  const GardenHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleGarden),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () {
          Get.toNamed(Routes.gardenForm,
              arguments: {Arguments.action: Activities.create});
        },
      ),
      body: GetBuilder<GardenHomeController>(
        builder: (controller) => FutureBuilder(
          future: controller.getGardens(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const MyLoadingBuilder();
            }

            if (snapshot.data == null || controller.gardens.isEmpty) {
              return ListEmptyBuilder(
                onRefresh: controller.onRefresh,
                msg: AppMsg.MSG4016,
              );
            }

            if (snapshot.hasData && controller.gardens.isNotEmpty) {
              return Obx(
                () => LazyLoadingList(
                  onEndOfPage: controller.getGardens,
                  isLoading: controller.isLoading.value,
                  onRefresh: controller.onRefresh,
                  itemCount: controller.gardens.length,
                  itemBuilder: ((context, index) {
                    Garden garden = controller.gardens[index];
                    return GardenCard(
                      key: ValueKey(garden.id),
                      address: garden.address,
                      gardenName: garden.name,
                      landArea: garden.landArea,
                      thumbnail: garden.imageUrl
                          .split(CommonConstants.imageDelimiter)
                          .first,
                      onDetailsTap: () {
                        Get.toNamed(Routes.gardenDetails, arguments: {
                          Arguments.tag: garden.id.toString(),
                          Arguments.item: garden,
                        });
                      },
                      onDeleteTap: () => controller.onDeleteGarden(garden),
                    );
                  }),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
