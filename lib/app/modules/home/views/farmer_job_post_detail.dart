import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myray_mobile/app/modules/home/controllers/farmer_job_post_detail_controller.dart';
import 'package:myray_mobile/app/modules/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:myray_mobile/app/modules/home/widgets/custom_sliver_app_bar.dart';
import 'package:myray_mobile/app/shared/constants/app_colors.dart';
import 'package:myray_mobile/app/shared/constants/app_msg.dart';
import 'package:myray_mobile/app/shared/constants/app_strings.dart';
import 'package:myray_mobile/app/shared/widgets/bullet.dart';
import 'package:myray_mobile/app/shared/widgets/custom_confirm_dialog.dart';

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
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: CustomSliverAppBarDelegate(
            expandedHeight: Get.height * 0.2,
            heightOfScreen: Get.height * 0.1,
            titleFloatingCard: controller.jobPost.title,
          ),
        ),
        buildImages2(),
        buildImages3(),
        const SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.only(bottom: 50),
        ))
      ]),
    );
  }

  Widget buildImages2() => SliverToBoxAdapter(
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
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Chủ đất:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 20,
                    ),
                    Text("Landowner"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Địa chỉ:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 20,
                    ),
                    const Flexible(
                      child: Text(
                        "39 Nguyễn Bỉnh Khiêm, P.2, TP Bảo Lộc, Lâm Đồng",
                        softWrap: true,
                        maxLines: 5,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Số điện thoại:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 20,
                    ),
                    Text("0987654321"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Loại công việc:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Làm công",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Tiền lương:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "30.000 đ/công",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Thời gian:", style: Get.textTheme.bodyText1),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "2-3 tháng",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          )));

  Widget buildImages3() => SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
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
                    const Bullet(),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                        child: Text(
                      "Cần gấp người hái cà phê ở tháng. Bao ăn ở tại chỗ. được hướng dẫn làm việc. Ngày làm 6 - 7 tiếng.",
                      maxLines: 10,
                      softWrap: true,
                      style: Get.textTheme.bodyText2?.copyWith(
                        fontSize: 15,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Bullet(),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                        child: Text(
                      "Nam nữ đều làm được, có sức khỏe tốt. Nếu nữ thì cần có nam đi theo để hỗ trợ nhau trong lúc làm việc.",
                      maxLines: 10,
                      softWrap: true,
                      style: Get.textTheme.bodyText2?.copyWith(
                        fontSize: 15,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Bullet(),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                        child: Text(
                      "Được trợ cấp tiền xe lên Bảo Lộc, và cho tiền lúc về.",
                      maxLines: 10,
                      softWrap: true,
                      style: Get.textTheme.bodyText2?.copyWith(
                        fontSize: 15,
                      ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Bullet(),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                        child: Text(
                      "Thưởng nếu làm tốt.",
                      maxLines: 10,
                      softWrap: true,
                      style: Get.textTheme.bodyText2?.copyWith(
                        fontSize: 15,
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
