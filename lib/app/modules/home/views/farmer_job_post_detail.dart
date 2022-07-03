import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myray_mobile/app/data/enums/job_type.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_job_post_detail_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:myray_mobile/app/modules/home/widgets/custom_sliver_app_bar.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/builders/loading_builder.dart';
import 'package:myray_mobile/app/shared/widgets/bullet.dart';
import 'package:myray_mobile/app/shared/widgets/custom_confirm_dialog.dart';
import 'package:myray_mobile/app/data/models/job_post/farmer_job_post_detail_response.dart';

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
        () => controller.check.value
            ? CustomBottomNavigationBar(
                onPressedOutlineButton: () {},
              )
            : CustomBottomNavigationBar(
                onPressedOutlineButton: () {},
                onPressedFilledButton: () {
                  CustomDialog.show(
                      confirm: () => controller.applyJob(controller.jobPost.id),
                      message:
                          "${AppMsg.MSG3005} Lưu ý: bạn chỉ có 1 lần hủy ứng tuyển, hãy cân nhắc");
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
            return detailList();
          }

          return const SizedBox();
        }),
      ),
    );
  }

  Widget detailList() => CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: CustomSliverAppBarDelegate(
            expandedHeight: Get.height * 0.2,
            heightOfScreen: Get.height * 0.1,
            titleFloatingCard: controller.jobPost.title,
          ),
        ),
        _buildCardInfoJjob(),
        _buildCardDescriptionJob(),
        const SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.only(bottom: 50),
        ))
      ]);

  Widget _buildCardInfoJjob() => SliverToBoxAdapter(
      child: Container(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
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
                    Text("Chủ đất:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 15,
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
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Địa chỉ:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        controller.jobPost.address,
                        softWrap: true,
                        maxLines: 5,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: Get.textScaleFactor * 15,
                        ),
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
                          ? "${controller.jobPost.payPerHourJob!.salary} đ/công"
                          : "${controller.jobPost.payPerTaskJob!.salary} đ",
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
                    Text("Ngày dự kiến:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 29,
                    ),
                    Text(
                      DateFormat('dd-MM-yyyy')
                              .format(controller.jobPost.jobStartDate) +
                          " đến " +
                          DateFormat('dd-MM-yyyy')
                              .format(controller.jobPost.jobEndDate),
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
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                        child: Text(
                      controller.detailPost?.value.description ??
                          "Không có mô tả",
                      maxLines: 10,
                      softWrap: true,
                      style: Get.textTheme.bodyText2?.copyWith(
                        fontSize: Get.textScaleFactor * 15,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          )));
}
