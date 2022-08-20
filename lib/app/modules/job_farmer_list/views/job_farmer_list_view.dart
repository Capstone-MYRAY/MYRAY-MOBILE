import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/enums/enums.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/controllers/controllers.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/constants.dart';
import 'package:myray_mobile/app/data/models/applied_farmer/applied_farmer.dart';
import 'package:myray_mobile/app/modules/job_farmer_list/widgets/farmer_info_card.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/controls/dropdown_list.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class JobFarmerListView extends GetView<JobFarmerListController> {
  const JobFarmerListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleFarmerList),
      ),
      body: Column(
        children: [
          Obx(
            () => DropdownList(
              items: controller.buildFilterList(),
              onChanged: controller.onChangedFilter,
              value: controller.selectedFilter.value,
            ),
          ),
          Obx(
            () => Container(
              width: Get.width * 0.9,
              margin: const EdgeInsets.only(
                top: 8.0,
              ),
              alignment: Alignment.centerRight,
              child: Text(
                'Tổng cộng: ${controller.totalCount.value}',
                style: Get.textTheme.caption,
              ),
            ),
          ),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return GetBuilder<JobFarmerListController>(
      builder: (_) => FutureBuilder(
        future: controller.getAppliedFarmers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingBuilder();
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
                  return FarmerInfoCard(
                    key: ValueKey(appliedFarmer.id),
                    fullName: appliedFarmer.userInfo.fullName ?? '',
                    phone: appliedFarmer.userInfo.phoneNumber ?? '',
                    avatar: appliedFarmer.userInfo.imageUrl,
                    statusName: appliedFarmer.statusString,
                    statusColor: appliedFarmer.statusColor,
                    isDisplayEllipsis: appliedFarmer.status ==
                        AppliedFarmerStatus.approved.index,
                    onFinish: () => controller.onFinish(appliedFarmer),
                    onFired: () => controller.onFired(appliedFarmer),
                    onButtonTap: () {
                      Get.toNamed(
                        Routes.jobFarmerDetails,
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
    );
  }
}
