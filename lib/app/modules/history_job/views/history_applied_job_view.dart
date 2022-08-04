import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/job_post/job_post.dart';
import 'package:myray_mobile/app/modules/history_job/controllers/history_applied_job_controller.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/chips/status_chip.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class HistoryAppliedJobView extends GetView<HistoryAppliedJobController> {
  const HistoryAppliedJobView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Các công việc ứng tuyển'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight),
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
            tabs: controller.tabs,
            controller: controller.tabController,
            indicatorColor: Colors.transparent,
            labelColor: AppColors.primaryColor,
            isScrollable: true,
            unselectedLabelColor: Colors.grey,
          ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: controller.getAppliedJobList(),
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

            return Obx(() => LazyLoadingList(
                onEndOfPage: () => controller.getAppliedJobList(),
                onRefresh: controller.onRefresh,
                // itemCount: 100,
                itemCount: controller.appliedJobPostResponse.isEmpty
                    ? 1
                    : controller.appliedJobPostResponse.length,
                itemBuilder: ((context, index) {
                  if (snapshot.data == null ||
                      controller.appliedJobPostResponse.isEmpty) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.3),
                      child: Center(
                        child: Column(
                          children: [
                            Text("Không có công việc nào.",
                                style: Get.textTheme.bodyLarge!.copyWith(
                                  color: AppColors.grey,
                                  fontSize: Get.textScaleFactor * 20,
                                ),
                                textAlign: TextAlign.center),
                            const SizedBox(height: 10),
                            const ImageIcon(AssetImage(AppAssets.noJobFound),
                                size: 30, color: AppColors.grey),
                          ],
                        ),
                      ),
                    );
                  }
                  JobPost jobPost =
                      controller.appliedJobPostResponse[index].jobPost;
                  return Container(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 20),
                      child: Card(
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(jobPost.title,
                                          style:
                                              Get.textTheme.headline3?.copyWith(
                                            color: AppColors.brown,
                                          ),
                                          softWrap: true,
                                          maxLines: 3,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 15),
                                child: Stack(
                                  children: [
                                    const Icon(CustomIcons.map_marker_outline,
                                        size: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: SizedBox(
                                        width: Get.width * 0.65,
                                        child: Text.rich(
                                          TextSpan(
                                            text: jobPost.address ?? '',
                                          ),
                                          style: Get.textTheme.bodyText2!
                                              .copyWith(
                                                  fontSize:
                                                      Get.textScaleFactor * 14),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.justify,
                                          maxLines: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Row(
                                  children: [
                                    const Icon(CustomIcons.calendar_star,
                                        size: 20),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Row(children: [
                                        Text(
                                          "Ngày ứng tuyển:",
                                          style: Get.textTheme.labelMedium!
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: Get.textScaleFactor * 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          DateFormat('dd-MM-yyyy').format(
                                              controller
                                                  .appliedJobPostResponse[index]
                                                  .appliedDate),
                                          style:
                                              Get.textTheme.bodyText2!.copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: Get.textScaleFactor * 15,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          maxLines: 10,
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Row(
                                  children: [
                                    const Icon(CustomIcons.box, size: 20),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Row(children: [
                                        Text(
                                          "Loại hình công việc: ",
                                          style: Get.textTheme.labelMedium!
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: Get.textScaleFactor * 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          controller
                                                      .appliedJobPostResponse[
                                                          index]
                                                      .jobPost
                                                      .type ==
                                                  "PayPerHourJob"
                                              ? AppStrings.payPerHour
                                              : AppStrings.payPerTask,
                                          style:
                                              Get.textTheme.bodyText2!.copyWith(
                                            color: AppColors.primaryColor,
                                            fontSize: Get.textScaleFactor * 15,
                                          ),
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          maxLines: 10,
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 20),
                                child: Row(
                                  children: [
                                    const Icon(CustomIcons.work_history_outline, size: 20),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Row(children: [
                                        Text(
                                          "Trạng thái:",
                                          style: Get.textTheme.labelMedium!
                                              .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: Get.textScaleFactor * 15,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        StatusChip(
                                          statusName: controller
                                              .appliedJobPostResponse[index]
                                              .statusString,
                                          backgroundColor: controller
                                                .appliedJobPostResponse[index]
                                                .statusColor,
                                          foregroundColor: Colors.white,
                                        ),
                                        // Text(
                                        //   controller
                                        //       .appliedJobPostResponse[index]
                                        //       .statusString,
                                        //   style:
                                        //       Get.textTheme.bodyText2!.copyWith(
                                        //     color: controller
                                        //         .appliedJobPostResponse[index]
                                        //         .statusColor,
                                        //     fontSize: Get.textScaleFactor * 15,
                                        //   ),
                                        //   softWrap: true,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   textAlign: TextAlign.left,
                                        //   maxLines: 10,
                                        // ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          )));
                })));
            // return ListView.builder(itemCount: 1000, itemBuilder: ((context, index) {
            //   return SizedBox(child: Text('hello'));
            // }));

            // return const SizedBox();
          }),
          // )
        ));
  }
}
