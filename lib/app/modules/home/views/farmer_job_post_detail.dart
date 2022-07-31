import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_job_post_detail_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:myray_mobile/app/modules/home/widgets/custom_sliver_app_bar.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';
import 'package:myray_mobile/app/data/models/job_post/farmer_job_post_detail_response.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';

class FarmerJobPostDetail extends GetView<FarmerJobPostDetailController> {
  const FarmerJobPostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isExpired = controller.checkExpiredDate(controller.getExpiredDate(
        controller.jobPost.publishedDate, controller.jobPost.numOfPublishDay));
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleJobPostDetail),
        foregroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      bottomNavigationBar: Obx(
        () => controller.isApplied.value || isExpired
            ? CustomBottomNavigationBar(
                isExpired: isExpired,
                onPressedOutlineButton: controller.navigateToChatScreen,
              )
            : CustomBottomNavigationBar(
                isExpired: isExpired,
                // isExpired: false,
                onPressedOutlineButton: controller.navigateToChatScreen,
                onPressedFilledButton: () {
                  if (controller.jobPost.type == 'PayPerHourJob') {
                    controller.checkAppliedHourJob();
                    if (controller.isAppliedHourJob.value) {
                      InformationDialog.showDialog(
                        msg:
                            ' Bạn đã ứng tuyển một công việc có loại hình làm công',
                        confirmTitle: "Đóng",
                      );
                      return;
                    }
                  }
                  CustomDialog.show(
                      confirm: () => controller.applyJob(controller.jobPost.id),
                      message: "${AppMsg.MSG3005}");
                },
              ),
      ),
      body: FutureBuilder<FarmerJobPostDetailResponse?>(
        future: controller.getJobPostDetail(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingBuilder();
          }

          if (snapshot.hasError || snapshot.data == null) {
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

          if (snapshot.hasData) {
            controller.detailPost = snapshot.data!.obs;
            return detailList(controller.isApplied.value);
          }

          return const SizedBox();
        }),
      ),
    );
  }

  Widget detailList(bool isChangedState) => CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: CustomSliverAppBarDelegate(
            expandedHeight: Get.height * 0.2,
            heightOfScreen: Get.height * 0.35,
            titleFloatingCard: controller.jobPost.title,
            isChangedState: isChangedState,
          ),
        ),
        _buildLandownerCard(),
        _buildCardInfoJjob(),
        _buildCardDescriptionJob(),
        const SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
        ))
      ]);

  Widget _buildLandownerCard() {
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Card(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Chủ đất",
                          style: Get.textTheme.displayMedium?.copyWith(
                            color: AppColors.brown,
                          ),
                        ),
                        Obx(
                          () => Container(
                            padding: EdgeInsets.only(right: Get.width * 0.05),
                            child: IconButton(
                                onPressed: () {
                                  // print('${controller.landownerAccount!.value.id}');
                                  controller.bookmarkAccount(
                                      controller.landownerAccount!.value.id ??
                                          -1);
                                },
                                icon: controller.isBookmark.value
                                    ? Icon(
                                        CustomIcons.heart,
                                        color: Colors.red,
                                        size: Get.textScaleFactor * 30,
                                      )
                                    : Icon(
                                        CustomIcons.heart_outline,
                                        color: Colors.red,
                                        size: Get.textScaleFactor * 30,
                                      )),
                          ),
                        )
                      ]),
                  Divider(
                    color: AppColors.primaryColor.withOpacity(0.5),
                    height: 10,
                    endIndent: 15,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Họ và tên:", style: Get.textTheme.bodyText1),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      Text(
                        controller.landownerAccount != null
                            ? controller.landownerAccount!.value.fullName!
                            : "Tên chủ rẫy đang cập nhật",
                        style: TextStyle(
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Địa chỉ:", style: Get.textTheme.bodyText1),
                      SizedBox(
                        width: Get.width * 0.025 
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Text(
                            controller.jobPost.address ?? 'Đang cập nhật',
                            style: Get.textTheme.bodyText2!
                                .copyWith(fontSize: Get.textScaleFactor * 14),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              ),
            )));
  }

  Widget _buildCardInfoJjob() {
    return SliverToBoxAdapter(
        child: Container(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Card(
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 20),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(
                      "Thông tin công việc",
                      style: Get.textTheme.displayMedium?.copyWith(
                        color: AppColors.brown,
                      ),
                    ),
                  ]),
                  Divider(
                    color: AppColors.primaryColor.withOpacity(0.5),
                    height: 10,
                    endIndent: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Loại công việc:", style: Get.textTheme.bodyText1),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        controller.jobPost.type == 'PayPerHourJob'
                            ? AppStrings.payPerHour
                            : AppStrings.payPerTask,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Tiền lương:", style: Get.textTheme.bodyText1),
                      const SizedBox(
                        width: 44,
                      ),
                      Text(
                        controller.jobPost.type == 'PayPerHourJob'
                            ? "${Utils.vietnameseCurrencyFormat.format(controller.jobPost.payPerHourJob!.salary)} /công"
                            : "${Utils.vietnameseCurrencyFormat.format(controller.jobPost.payPerTaskJob!.salary)} ",
                        style: TextStyle(
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Ngày bắt đầu:", style: Get.textTheme.bodyText1),
                      const SizedBox(
                        width: 29,
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy')
                            .format(controller.jobPost.jobStartDate),
                        style: TextStyle(
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ]),
              ),
            )));
  }

  Widget _buildCardDescriptionJob() => SliverToBoxAdapter(
      child: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Column(children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Text(
                    "Mô tả công việc",
                    style: Get.textTheme.displayMedium?.copyWith(
                      color: AppColors.brown,
                    ),
                  ),
                ]),
                Divider(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  height: 10,
                  endIndent: 15,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(right: Get.width * 0.025),
                  child: Row(
                    children: [
                      Flexible(
                          child: Text(
                        controller.detailPost!.value.description.isEmpty
                            ? "Không có mô tả"
                            : controller.detailPost!.value.description,
                        maxLines: 10,
                        softWrap: true,
                        style: Get.textTheme.bodyText2?.copyWith(
                          fontSize: Get.textScaleFactor * 15,
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          )));
}
