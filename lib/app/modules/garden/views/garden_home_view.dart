import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:myray_mobile/app/modules/garden/controllers/garden_home_controller.dart';
import 'package:myray_mobile/app/modules/garden/widgets/garden_card.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:progress_indicators/progress_indicators.dart';

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
        onPressed: () {},
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: SizedBox(
            width: Get.width * 0.9,
            child: Obx(
              () => LazyLoadScrollView(
                onEndOfPage: controller.addMore,
                isLoading: controller.loadingState.value,
                child: ListView(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.gardens.length,
                      itemBuilder: ((context, index) {
                        return GardenCard();
                      }),
                    ),
                    controller.loadingState.value
                        ? JumpingDotsProgressIndicator(
                            fontSize: 40.0,
                            color: AppColors.primaryColor,
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
