import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_post_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FarmerHomeView extends GetView<FarmerHomeController> {
  const FarmerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(11.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Nổi bật",
                    style: Get.textTheme.headline2?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  CustomIcons.star,
                  size: 20,
                  color: Colors.amber,
                ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            // controller.isLoading.value
            //     ? JumpingDotsProgressIndicator(
            //         fontSize: 40.0,
            //         color: AppColors.primaryColor,
            //       ):
            //  controller.listJobPost.isNotEmpty
            //     ?
            Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: SizedBox(
                height: Get.height * 0.35,
                child: Obx(
                  () => controller.secondJobPost.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(left: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.secondJobPost.length,
                          itemBuilder: (context, index) {
                            JobPost jobPost = controller.secondJobPost[index];
                            var publishedDate = jobPost.publishedDate;
                            var numberPublishDate = jobPost.numOfPublishDay;
                            var expiredDate = controller.getExpiredDate(
                                publishedDate, numberPublishDate);
                            if (jobPost.payPerHourJob != null) {
                              return FarmerPostCard(
                                backgroundColor:
                                    AppColors.markedBackgroundColor,
                                title: jobPost.title,
                                address: jobPost.address ?? '',
                                price: jobPost.payPerHourJob!.salary,
                                treeType: "Cây cà phê", //no
                                workType: AppStrings.payPerHour,
                                isStatus: true,
                                expiredDate: DateFormat('dd-MM-yyyy')
                                    .format(expiredDate),
                                isExpired:
                                    controller.checkExpiredDate(expiredDate),
                                onTap: () => {
                                  Get.toNamed(Routes.farmerJobPostDetail,
                                      arguments: {Arguments.item: jobPost})
                                },
                              );
                            } else {
                              return FarmerPostCard(
                                backgroundColor:
                                    AppColors.markedBackgroundColor,
                                title: jobPost.title,
                                address: jobPost.address ?? '',
                                price: jobPost.payPerTaskJob!.salary,
                                treeType: "Cây cà phê", //no
                                workType: AppStrings.payPerTask,
                                isStatus: true,
                                expiredDate: DateFormat('dd-MM-yyyy')
                                    .format(expiredDate),
                                onTap: () {
                                  Get.toNamed(Routes.farmerJobPostDetail,
                                      arguments: {Arguments.item: jobPost});
                                },
                              );
                            }
                          })
                      : Center(
                          child: Column(
                            children: [
                              Text(
                                AppStrings.noMarkedJobPost,
                                style: Get.textTheme.bodyMedium!
                                    .copyWith(color: AppColors.grey),
                              ),
                              const SizedBox(height: 10),
                              const ImageIcon(AssetImage(AppAssets.noJobFound),
                                  size: 20, color: AppColors.grey)
                            ],
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(11.0),
              decoration: const BoxDecoration(
                color: AppColors.white,
              ),
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Công việc",
                    style: Get.textTheme.headline2?.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const ImageIcon(AssetImage(AppAssets.noJobFound),
                    size: 20, color: AppColors.brown)
              ]),
            ),
            Flexible(
                child: Obx(
              () => ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  itemCount: controller.listJobPost.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    JobPost jobPost = controller.listJobPost[index];

                    if (jobPost.payPerHourJob != null) {
                      return FarmerPostCard(
                        title: jobPost.title,
                        address: jobPost.address ?? '',
                        price: jobPost.payPerHourJob!.salary,
                        treeType: "Cây cà phê", //no
                        workType: AppStrings.payPerHour,
                        onTap: () {
                          print("Tap job post");
                        },
                      );
                    } else {
                      return FarmerPostCard(
                        title: jobPost.title,
                        address: jobPost.address ?? '',
                        price: jobPost.payPerTaskJob!.salary,
                        treeType: "Cây cà phê", //no
                        workType: AppStrings.payPerTask,
                        onTap: () {
                          print("Tap job post");
                        },
                      );
                    }
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
