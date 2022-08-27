import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/models/feedback/feedback.dart';
import 'package:myray_mobile/app/modules/guidepost/widgets/avatar.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_job_post_detail_controller.dart';
import 'package:myray_mobile/app/modules/home/controllers/feedback_list_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:myray_mobile/app/modules/home/widgets/custom_sliver_app_bar.dart';
import 'package:myray_mobile/app/modules/home/widgets/feedback_container.dart';
import 'package:myray_mobile/app/shared/constants/app_assets.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/icons/custom_icons_icons.dart';
import 'package:myray_mobile/app/shared/utils/utils.dart';
import 'package:myray_mobile/app/shared/widgets/builders/list_empty_builder.dart';
import 'package:myray_mobile/app/shared/widgets/builders/my_loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/buttons/custom_text_button.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_confirm_dialog.dart';
import 'package:myray_mobile/app/data/models/job_post/farmer_job_post_detail_response.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/custom_information.dialog.dart';
import 'package:myray_mobile/app/shared/widgets/dialogs/information_dialog.dart';
import 'package:myray_mobile/app/shared/widgets/lazy_loading_list.dart';

class FarmerJobPostDetail extends GetView<FarmerJobPostDetailController> {
  const FarmerJobPostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleJobPostDetail),
        foregroundColor: AppColors.primaryColor,
        centerTitle: true,
      ),
      bottomNavigationBar: Obx(
        () => controller.isApplied.value
            ? CustomBottomNavigationBar(
                onPressedOutlineButton: controller.navigateToChatScreen,
                isExpired: controller.jobPost.status == 4,
              )
            : CustomBottomNavigationBar(
                isExpired: controller.jobPost.status == 4,
                onPressedOutlineButton: controller.navigateToChatScreen,
                onPressedFilledButton: () {
                  if (controller.isFullApplyRequestJob.value) {
                    CustomInformationDialog.show(
                      title: 'Thông báo',
                      content: Column(
                        children: [
                          Text('Bạn đã ứng tuyển 5 công việc',
                              style: Get.textTheme.headline6!
                                  .copyWith(color: Colors.black, fontSize: 18)),
                          const SizedBox(height: 10),
                          Text(
                            'Vui lòng chờ duyệt các công việc đã ứng tuyển trước khi ứng tuyển công việc này.',
                            style: Get.textTheme.bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                    return;
                  }
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
                      message: AppMsg.MSG3005);
                },
              ),
      ),
      body: FutureBuilder<FarmerJobPostDetailResponse?>(
        future: controller.getJobPostDetail(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MyLoadingBuilder();
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
            return detailList(controller.isApplied.value, context);
          }

          return const SizedBox();
        }),
      ),
    );
  }

  Widget detailList(bool isChangedState, BuildContext context) =>
      CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: CustomSliverAppBarDelegate(
              expandedHeight: Get.height * 0.25,
              heightOfScreen: Get.height * 0.35,
              titleFloatingCard: controller.jobPost.title,
              isChangedState: isChangedState,
              imageList: controller.jobPost.gardenImageList),
        ),
        _buildLandownerCard(context),
        _buildCardInfoJjob(),
        _buildCardDescriptionJob(),
        const SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30),
        ))
      ]);

  Widget _buildLandownerCard(BuildContext context) {
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
                          AppStrings.landowner,
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
                            : "Tên chủ vườn đang cập nhật",
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
                      SizedBox(width: Get.width * 0.025),
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextButton(
                          onPressed: () {
                            buildFeedBackBottomSheet(context);
                          },
                          title: AppStrings.titleViewFeedback,
                          background: AppColors.white,
                          foreground: AppColors.primaryColor,
                          border: Border.all(color: AppColors.primaryColor)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
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
                        controller.jobPost.workTypeName,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${AppStrings.labelTreeType}:',
                          style: Get.textTheme.bodyText1),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          controller.jobPost.treeTypes == ''
                              ? 'Không phân loại'
                              : controller.jobPost.treeTypes,
                          style: TextStyle(
                            fontSize: Get.textScaleFactor * 15,
                          ),
                          softWrap: true,
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
                      Text("Trả lương theo:", style: Get.textTheme.bodyText1),
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
                            fontWeight: FontWeight.w700),
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
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700),
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
                        width: 27,
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy')
                            .format(controller.jobPost.jobStartDate.toLocal()),
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

  Future<void> buildFeedBackBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          int? id = controller.landownerAccount!.value.id;
          String? imageUrl = controller.landownerAccount!.value.imageUrl;
          double? numStar = controller.landownerAccount!.value.rating;
          return Container(
              height: Get.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Container(
                        height: Get.height * 0.25,
                        child: Column(
                          children: [
                            Container(
                              height: 5,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(''),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Avatar(imageUrl: imageUrl, width: 100, height: 100),
                            const SizedBox(height: 10),
                            Expanded(
                              // width: Get.width * 0.5,
                              child: Text(
                                controller.landownerAccount!.value.fullName ??
                                    'Tên chủ vườn đang cập nhật',
                                style: Get.textTheme.headline5,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // const SizedBox(height: 10),
                            RatingBarIndicator(
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemSize: 30,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              rating: numStar ?? 5,
                            ),
                          ],
                        )),
                  ),
                  Divider(
                    color: AppColors.grey.withOpacity(0.5),
                    height: 10,
                    endIndent: 25,
                    indent: 15,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 30,
                          child: Text(
                            "${AppStrings.titleFeedback}:",
                            style: Get.textTheme.headline3!
                                .copyWith(color: AppColors.primaryColor),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GetBuilder<FeedBackListController>(
                      builder: (controller) {
                        controller.landOwnerAccountId = id!;
                        return FutureBuilder(
                          future: controller.getFeedbackList(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const MyLoadingBuilder();
                            }
                            if (snapshot.hasError ||
                                snapshot.data == null ||
                                controller.feedBackList.isEmpty) {
                              // printError();
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Chưa có đánh giá nào',
                                      style: Get.textTheme.bodyMedium!.copyWith(
                                          color: AppColors.grey, fontSize: 20),
                                    ),
                                    const SizedBox(height: 10),
                                    const ImageIcon(
                                        AssetImage(AppAssets.feedBack),
                                        size: 50,
                                        color: AppColors.grey),
                                    FractionallySizedBox(
                                      widthFactor: 0.3,
                                      child: TextButton(
                                        onPressed: controller.onRefreshFeedBack,
                                        child: Text('Tải lại',
                                            style: Get.textTheme.headline6),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }

                            return Obx(
                              () => LazyLoadingList(
                                onEndOfPage: controller.getFeedbackList,
                                onRefresh: controller.onRefreshFeedBack,
                                itemCount: controller.feedBackList.length,
                                isLoading: controller.isLoading.value,
                                itemBuilder: (context, index) {
                                  FeedBack feedBack =
                                      controller.feedBackList[index];
                                  return FeedBackContainer(feedBack: feedBack);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ));
        });
  }
}
