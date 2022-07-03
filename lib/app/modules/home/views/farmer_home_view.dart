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
                          height: Get.height * 0.32,
                          child: Obx(
                            () => ListView.builder(
                              padding: const EdgeInsets.only(left: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.listJobPost.length,
                              itemBuilder: (context, index) {
                                JobPost jobPost = controller.listJobPost[index];
                                var publishedDate = jobPost.publishedDate;
                                var numberPublishDate = jobPost.numOfPublishDay;
                                var expiredDate = controller.getExpiredDate(
                                    publishedDate, numberPublishDate);
                                if (jobPost.payPerHourJob != null) {
                                  return FarmerPostCard(
                                    backgroundColor:
                                        AppColors.markedBackgroundColor,
                                    title: jobPost.title,
                                    address: "142 Lâm Đồng",
                                    price: 30000,
                                    treeType: "Cây cà phê",
                                    workType: "Làm công",
                                    isStatus: true,
                                    expiredDate: DateFormat('dd-MM-yyyy')
                                        .format(expiredDate),
                                    isExpired: controller
                                        .checkExpiredDate(expiredDate),
                                    onTap: () => {
                                      Get.toNamed(Routes.farmerJobPostDetail,
                                          arguments: {Arguments.item: jobPost})
                                    },
                                  );
                                } else {
                                  return FarmerPostCard(
                                    title: jobPost.title,
                                    address: "142 Lâm Đồng",
                                    price: 30000,
                                    treeType: "Cây cà phê",
                                    workType: "Làm khoán",
                                    isStatus: true,
                                    expiredDate: DateFormat('dd-MM-yyyy')
                                        .format(expiredDate),
                                    onTap: () {
                                      Get.toNamed(Routes.farmerJobPostDetail,
                                          arguments: {Arguments.item: jobPost});
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    // : Center(
                    //     child: Column(
                    //       children: [
                    //         Text(
                    //           AppStrings.noMarkedJobPost,
                    //           style: Get.textTheme.bodyMedium!
                    //               .copyWith(color: AppColors.grey),
                    //         ),
                    //         const SizedBox(height: 10),
                    //         const ImageIcon(AssetImage(AppAssets.noJobFound),
                    //             size: 20, color: AppColors.grey)
                    //       ],
                    //     ),
                      // ),
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
              child: ListView.builder(
                  padding: const EdgeInsets.only(left: 10),
                  itemCount: 15,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return FarmerPostCard(
                      title: "Thu hoạch cà phê $index",
                      address: "142 Lâm Đồng",
                      price: 30000,
                      treeType: "Cây cà phê",
                      workType: "Làm công",
                      onTap: () {
                        print("Tap job post");
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
