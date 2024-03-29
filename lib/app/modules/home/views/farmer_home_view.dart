import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_home_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/farmer_post_card.dart';
import 'package:myray_mobile/app/routes/app_pages.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/constants/common.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/hex_color_extension.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/controls/search_and_filter.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerHomeView extends GetView<FarmerHomeController> {
  const FarmerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.home),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.guidepost);
            },
            child: Image.asset(
              AppAssets.guidepost,
              width: 50,
              height: 50,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kTextTabBarHeight + 15),
          child: SearchAndFilter(
            onFilterTap: () {
              Get.toNamed(Routes.farmerJobPostFilter);
            },
            searchController: controller.titleController,
            refreshOnClear: true,
            onTextChanged: (value) {
              controller.titleSearch = value;
              controller.onRefresh();
            },
          ),
        ),
      ),
      body: FutureBuilder(
        future: controller.getListJobPost(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingBuilder();
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
            return Obx(
              () => LazyLoadingList(
                width: Get.width,
                onEndOfPage: controller.getListJobPost,
                onRefresh: controller.onRefresh,
                isLoading: controller.isLoading.value,
                itemCount: 1,
                itemBuilder: ((context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 10),
                      Obx(
                        () => controller.secondObject.isNotEmpty
                            ? Column(
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
                                          style:
                                              Get.textTheme.headline2?.copyWith(
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
                                ],
                              )
                            : const SizedBox(),
                      ),
                      Obx(
                        () => controller.secondObject.isNotEmpty                            
                            ? ListView.builder(
                                // shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                // padding: const EdgeInsets.only(left: 10),
                                itemCount: controller.secondObject.length,
                                itemBuilder: (context, index) {
                                  JobPost jobPost =
                                      controller.secondObject[index];
                                  double distance = controller.getDistance(
                                      jobPost.gardenLat!, jobPost.gardenLon!);

                                  return Container(
                                    margin: const EdgeInsets.only(
                                      top: 4,
                                      bottom: 4,
                                    ),
                                    child: FarmerPostCard(
                                      backgroundColor:
                                          AppColors.markedBackgroundColor,
                                      statusColor: HexColor.fromHex(
                                          jobPost.backgroundColor!),
                                      // statusName: jobPost.postTypeName,
                                      // statusNameColor: HexColor.fromHex(
                                      //     jobPost.foregroundColor!),
                                      title: jobPost.title,
                                      address: jobPost.address != null
                                          ? jobPost.address!.split(',').last
                                          : '',
                                      price: jobPost.payPerHourJob != null
                                          ? jobPost.payPerHourJob!.salary
                                          : jobPost.payPerTaskJob!.salary,
                                      treeType: jobPost.treeTypes == ''
                                          ? 'Không có'
                                          : jobPost.treeTypes, //no
                                      paidType: jobPost.payPerHourJob != null
                                          ? AppStrings.payPerHour
                                          : AppStrings.payPerTask,
                                      workType: jobPost.workTypeName,
                                      isStatus: true,
                                      imageUrl: jobPost.gardenImage!.split(
                                          CommonConstants.imageDelimiter)[0],
                                      distance:
                                          distance == 0.0 ? null : distance,
                                      onTap: () => {
                                        Get.toNamed(Routes.farmerJobPostDetail,
                                            arguments: {
                                              Arguments.item: jobPost
                                            })
                                      },
                                    ),
                                  );
                                })

                            // )
                            :
                           
                            const SizedBox(),
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
                      const SizedBox(height: 10),
                      Obx(
                        () => controller.listObject.isNotEmpty
                            ? Flexible(
                                child: ListView.builder(
                                    itemCount: controller.listObject.length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      JobPost jobPost =
                                          controller.listObject[index];
                                      return Container(
                                        margin: const EdgeInsets.only(
                                            top: 4, bottom: 4),
                                        child: FarmerPostCard(
                                          title: jobPost.title,
                                          address: jobPost.address != null
                                              ? jobPost.address!.split(',').last
                                              : '',
                                          price: jobPost.payPerHourJob != null
                                              ? jobPost.payPerHourJob!.salary
                                              : jobPost.payPerTaskJob!.salary,
                                          treeType: jobPost.treeTypes, //no
                                          paidType:
                                              jobPost.payPerHourJob != null
                                                  ? AppStrings.payPerHour
                                                  : AppStrings.payPerTask,
                                          workType: jobPost.workTypeName,

                                          distance: controller.getDistance(
                                              jobPost.gardenLat!,
                                              jobPost.gardenLon!),
                                          imageUrl: jobPost.gardenImage!
                                              .split(CommonConstants
                                                  .imageDelimiter)
                                              .first,
                                          onTap: () {
                                            Get.toNamed(
                                                Routes.farmerJobPostDetail,
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
                                      AppStrings.noJobPost,
                                      style: Get.textTheme.bodyMedium!
                                          .copyWith(color: AppColors.grey),
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
                  );
                }),
              ),
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
