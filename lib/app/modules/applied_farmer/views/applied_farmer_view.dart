import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer.dart';
import 'package:myray_mobile/app/modules/applied_farmer/controllers/applied_farmer_controller.dart';
import 'package:myray_mobile/app/modules/applied_farmer/widgets/applied_farmer_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/landowner_appbar.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class AppliedFarmerView extends StatelessWidget {
  const AppliedFarmerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LandownerAppbar(
        title: Text(
          AppStrings.applied,
          textScaleFactor: 1,
        ),
      ),
      body: GetBuilder<AppliedFarmerController>(
        builder: (controller) => FutureBuilder(
          future: controller.getAppliedFarmers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingBuilder();
            }

            if (snapshot.data == null) {
              return ListEmptyBuilder(onRefresh: controller.onRefresh);
            }

            if (snapshot.hasData) {
              return Obx(
                () => LazyLoadingList(
                  onEndOfPage: controller.getAppliedFarmers,
                  isLoading: controller.isLoading.value,
                  onRefresh: controller.onRefresh,
                  itemCount: controller.appliedFarmers.length,
                  itemBuilder: ((context, index) {
                    AppliedFarmer appliedFarmer =
                        controller.appliedFarmers[index];
                    return AppliedFarmerCard(
                      fullName: appliedFarmer.userInfo.fullName ?? '',
                      phone: appliedFarmer.userInfo.phoneNumber ?? '',
                      avatar: appliedFarmer.userInfo.imageUrl,
                      workTitle: appliedFarmer.jobPost.title,
                      appliedDate: appliedFarmer.appliedDate,
                      rating: appliedFarmer.userInfo.rating,
                      onDetailsPress: () {
                        Get.toNamed(
                          Routes.appliedFarmerDetails,
                          arguments: {
                            Arguments.tag: appliedFarmer.id.toString(),
                            Arguments.item: appliedFarmer,
                          },
                        );
                      },
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
