import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_post_card%20copy.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_post_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/hex_color_extension.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerHomeView extends GetView<FarmerHomeController> {
  const FarmerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.home),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.guidepost);
                },
                child: Image.asset(
                  AppAssets.guidepost,
                  width: 32,
                  height: 30,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder(
            future: controller.getListJobPost(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBuilder();
              }
              if (snapshot.hasError) {
                printError(info: snapshot.error.toString());
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
              if (snapshot.data == null) {
                return ListEmptyBuilder(
                  onRefresh: controller.onRefresh,
                  msg: 'Không có bài viết nào',
                  nameImage: AppAssets.noJobPost,
                );
              }
              if (snapshot.hasData) {
                return LazyLoadingList(
                  onEndOfPage: controller.getListJobPost,
                  onRefresh: controller.onRefresh,
                  isLoading: controller.isLoading.value,
                  itemCount: 1,
                  itemBuilder: ((context, index) {
                    return SingleChildScrollView(
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
                            Obx(
                              () => controller.secondObject.isNotEmpty
                                  ? Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: AppColors.white,
                                      ),
                                       constraints: BoxConstraints(
                                          minHeight: Get.height * 0.29,
                                          maxHeight:  Get.height * 0.32,
                                        ),
                                      child: 
                                      ListView.builder(
                                          // shrinkWrap: true,
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              controller.secondObject.length,
                                          itemBuilder: (context, index) {
                                            JobPost jobPost = controller
                                                .secondObject[index];
                                            var publishedDate =
                                                jobPost.publishedDate;
                                            var numberPublishDate =
                                                jobPost.numOfPublishDay;
                                            var expiredDate =
                                                controller.getExpiredDate(
                                                    publishedDate,
                                                    numberPublishDate);
                                            return Container(
                                              margin: const EdgeInsets.only(right: 20),
                                              child: FarmerSpecialPostCard(
                                                backgroundColor: AppColors
                                                    .markedBackgroundColor,
                                                statusColor: HexColor.fromHex(jobPost.backgroundColor!),
                                                statusName: jobPost.postTypeName,
                                                statusNameColor: HexColor.fromHex(jobPost.foregroundColor!),
                                                title: jobPost.title,
                                                address: jobPost.address ?? '',
                                                price: jobPost.payPerHourJob !=
                                                        null
                                                    ? jobPost
                                                        .payPerHourJob!.salary
                                                    : jobPost
                                                        .payPerTaskJob!.salary,
                                                treeType: jobPost
                                                        .treeJobs.isEmpty
                                                    ? "Không phân loại"
                                                    : jobPost
                                                            .treeJobs[0].type ??
                                                        "Không phân loại", //no
                                                workType:
                                                    jobPost.payPerHourJob !=
                                                            null
                                                        ? AppStrings.payPerHour
                                                        : AppStrings.payPerTask,
                                                isStatus: true,
                                                expiredDate:
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(expiredDate),
                                                isExpired:
                                                    controller.checkExpiredDate(
                                                        expiredDate),
                                                onTap: () => {
                                                  Get.toNamed(
                                                      Routes
                                                          .farmerJobPostDetail,
                                                      arguments: {
                                                        Arguments.item: jobPost
                                                      })
                                                },
                                              ),
                                            );
                                          })
                                    )
                                  : Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            AppStrings.noMarkedJobPost,
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: AppColors.grey),
                                          ),
                                          const SizedBox(height: 10),
                                          const ImageIcon(
                                              AssetImage(AppAssets.noJobFound),
                                              size: 20,
                                              color: AppColors.grey)
                                        ],
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
                                const ImageIcon(
                                    AssetImage(AppAssets.noJobFound),
                                    size: 20,
                                    color: AppColors.brown)
                              ]),
                            ),
                            Obx(
                              () => controller.listObject.isNotEmpty
                                  ? Flexible(
                                      child: ListView.builder(
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 5.0,
                                          ),
                                          itemCount:
                                              controller.listObject.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            JobPost jobPost =
                                                controller.listObject[index];
                                            var publishedDate =
                                                jobPost.publishedDate;
                                            var numberPublishDate =
                                                jobPost.numOfPublishDay;
                                            var expiredDate =
                                                controller.getExpiredDate(
                                                    publishedDate,
                                                    numberPublishDate);
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  top: Get.height * 0.02),
                                              child: FarmerPostCard(
                                                title: jobPost.title,
                                                address: jobPost.address ?? '',
                                                price: jobPost.payPerHourJob !=
                                                        null
                                                    ? jobPost
                                                        .payPerHourJob!.salary
                                                    : jobPost
                                                        .payPerTaskJob!.salary,
                                                treeType: jobPost
                                                        .treeJobs.isEmpty
                                                    ? "Không phân loại"
                                                    : jobPost
                                                            .treeJobs[0].type ??
                                                        "Không phân loại", //no
                                                workType:
                                                    jobPost.payPerHourJob !=
                                                            null
                                                        ? AppStrings.payPerHour
                                                        : AppStrings.payPerTask,
                                                expiredDate:
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(expiredDate),
                                                isExpired:
                                                    controller.checkExpiredDate(
                                                        expiredDate),
                                                onTap: () {
                                                  Get.toNamed(
                                                      Routes
                                                          .farmerJobPostDetail,
                                                      arguments: {
                                                        Arguments.item: jobPost
                                                      });
                                                },
                                              ),
                                            );
                                          }),
                                    )
                                  : Center(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          Text(
                                            AppStrings.noMarkedJobPost,
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                                    color: AppColors.grey),
                                          ),
                                          const SizedBox(height: 10),
                                          const ImageIcon(
                                              AssetImage(AppAssets.noJobFound),
                                              size: 20,
                                              color: AppColors.grey)
                                        ],
                                      ),
                                    ),
                            )
                          ],
                        ),
                      
                    );
                  }),
                );
              }
              return const SizedBox();
            })));
  }
}
